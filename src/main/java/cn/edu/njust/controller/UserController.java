package cn.edu.njust.controller;

import cn.edu.njust.entity.*;
import cn.edu.njust.service.*;
import cn.edu.njust.utils.StatisticFormat;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.*;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import cn.edu.njust.utils.StaticConfig;

import static jdk.nashorn.internal.runtime.regexp.joni.Config.log;


//用户请求控制器
@Controller
@RequestMapping(value = "/user")
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private ManagerService managerService;
    @Autowired
    private RestService restService;
    @Autowired
    private TransactionService transactionService;
    @Autowired
    private OrderService orderService;

//    跳转到登录页面
    @RequestMapping(value = "/toLogin")
    public String toLoginPage(){
        return "page/login";
    }
    @RequestMapping(value = "toRegister")
    public String toRegister(){
        return "page/user/register";
    }
    @RequestMapping(value="/toShowInfo")
    public String toShowInfoPage(){
        return "page/user/userInfo";
    }
    @RequestMapping(value = "/toPayPage")
    public String toPayPage(Model model){
        return "page/user/pay";
    }

//    用户登录
    @RequestMapping(value="/login")
    public String login(@RequestParam String userName, @RequestParam String password,
                        HttpSession session, Model model) {
        Manager manager=managerService.getManagerByID(userName);
        Restaurant restaurant=restService.selectResByID(userName);
        Users user = userService.findUserByPhone(userName);
        if(manager!=null){
            if(manager.getPassword().equals(password)){
                session.setAttribute("manager",manager);
                System.out.println("manager:"+manager.getManagerID()+"登陆成功");
                List<Restaurant> listOfNotAccepted = managerService.listAllNotAccepted();
                System.out.println("总计未审批的数量"+listOfNotAccepted.size());
                model.addAttribute("listOfNotAccepted",listOfNotAccepted);
                List<Restaurant> listOfAccepted = managerService.ListAllAcceptedRest(manager.getManagerID());
                model.addAttribute("listOfAccepted",listOfAccepted);
                System.out.println("总计已经审批的数量："+listOfAccepted.size());
                return "page/manager/mainPage";

            }else {
                model.addAttribute("message","管理员登录失败");
                System.out.println("manager:"+manager.getManagerID()+"登录失败，密码错误");
                return "page/login";
            }
        }else if(restaurant!=null){
            if(restaurant.getPassword().equals(password)){
                if(restaurant.getAccepted()==1){
//                    餐馆登陆成功之后将餐馆放入session域中
                    session.setAttribute("restaurant",restaurant);
                    model.addAttribute("restaurant",restaurant);
                    model.addAttribute("message","商家登录成功");
                    log.println("商家："+restaurant.getName()+"登陆成功");
                    Map<Object,Object> map=restService.getAllStatistic(restaurant.getResID());
                    if(map.containsKey(StaticConfig.TOTAL_BALANCE)){
                        //年度销售总额,控制显示的精度
                        double balance= (double) map.get(StaticConfig.TOTAL_BALANCE);
                        BigDecimal balanceDecimal = BigDecimal.valueOf(balance);
                        balanceDecimal.setScale(2,BigDecimal.ROUND_CEILING);
                        balance=balanceDecimal.doubleValue();
                        model.addAttribute("total_balance", balance);
                    }
                    if(map.containsKey(StaticConfig.TOTAL_COUNT_OF_DISHTYPE)){
                        /* 菜品类型对应的销售数量 */
                        Map<String,Integer> cur= (Map<String, Integer>)
                                map.get(StaticConfig.TOTAL_COUNT_OF_DISHTYPE);
                        int size = cur.size();
                        double sale_amount=0;
                        if(cur==null || cur.size()==0){
                            model.addAttribute("CanDraw",false);
//                没有订单的时候设置月销售量为0，并且和订单相关的图片设置无法绘制
                            model.addAttribute("avg_sale_amount",0);
                        }else{
                            List<String> keys= new ArrayList<>();
                            List<Integer> values=new ArrayList<>();
                            Iterator i = cur.entrySet().iterator();
                            while(i.hasNext()){
                                Map.Entry entry = (Map.Entry)i.next();
                                keys.add((String) entry.getKey());
                                values.add((Integer)entry.getValue());
                                sale_amount+=Double.valueOf(entry.getValue().toString());
                            }
//                控制双精度浮点数显示的精度
                            System.out.println("菜品的销售总数量------>"+sale_amount);
                            double avg_sale_amount = sale_amount/9;
                            BigDecimal avgDecimal = BigDecimal.valueOf(avg_sale_amount);
                            avgDecimal = avgDecimal.setScale(2,BigDecimal.ROUND_CEILING);
                            avg_sale_amount=avgDecimal.doubleValue();

                            String jsonStringKeys = JSONObject.toJSON(keys).toString();
                            String jsonStringValues = JSONObject.toJSON(values).toString();
//            将键值对的建与值分别转化成json对应的list
                            model.addAttribute("total_count_of_dishType_keys", jsonStringKeys);
                            model.addAttribute("total_count_of_dishType_values",jsonStringValues);
                            System.out.println("月平均销量："+avg_sale_amount);
                            model.addAttribute("avg_sale_amount",avg_sale_amount);
                            String format=StatisticFormat.translate(cur);
                            log.println(format);
                            model.addAttribute("total_count_of_dishType",format);
                            model.addAttribute("CanDraw",true);
                        }
                    }
                    if(map.containsKey(StaticConfig.TOTAL_SALES_OF_DISHTYPE)){
                        /* 菜品类型对应的销售金额 */
                        Map<String,Double> cur= (Map<String, Double>)
                                map.get(StaticConfig.TOTAL_SALES_OF_DISHTYPE);
                        if(cur==null || cur.size()==0){
                            model.addAttribute("CanDraw",false);
                        }else{
                            List<String> keys= new ArrayList<>();
                            List<Double> values=new ArrayList<>();
                            Iterator i = cur.entrySet().iterator();
                            while(i.hasNext()){
                                Map.Entry entry = (Map.Entry)i.next();
                                keys.add((String) entry.getKey());
                                values.add((Double)entry.getValue());
                            }
                            String jsonStringKeys = JSONObject.toJSON(keys).toString();
                            String jsonStringValues = JSONObject.toJSON(values).toString();
//            将键值对的建与值分别转化成json对应的list
                            model.addAttribute("total_sales_of_dishType_keys", jsonStringKeys);
                            model.addAttribute("total_sales_of_dishType_values",jsonStringValues);
                            String format=StatisticFormat.translate4(cur);
                            System.out.println("餐馆每种类型的销售金额：");
                            log.println(format);
                            model.addAttribute("total_sales_of_dishType",format);
                            model.addAttribute("CanDraw",true);
                        }
                    }
                    if(map.containsKey(StaticConfig.TOTAL_SCORE_OF_RES)){
                        //餐馆收到的点赞的总数量
                        int totalScore= (int) map.get(StaticConfig.TOTAL_SCORE_OF_RES);
                        log.println("点赞数量："+totalScore);
                        model.addAttribute("total_score_of_res", totalScore);
                    }
                    if(map.containsKey(StaticConfig.TOTAL_ORDERS_IN_ALL_MONTH)){
                        //餐馆每月的订单数量，截止到第九月
                        Map<Integer,Integer> ordersInAllMonth= (Map<Integer, Integer>) map.get(StaticConfig.TOTAL_ORDERS_IN_ALL_MONTH);
                        String jsonString = StatisticFormat.translate2(ordersInAllMonth);
                        System.out.println("餐馆每月的订单数量变化：");
                        log.println(jsonString);
                        model.addAttribute("total_orders_in_all_month",jsonString);
                    }
                    if(map.containsKey(StaticConfig.TOTAL_SALES_IN_A_MONTH)){
                        //月销售数量，截止到第九月
                        Map<Integer,Integer> totalSales= (Map<Integer, Integer>) map.get(StaticConfig.TOTAL_SALES_IN_A_MONTH);
                        System.out.println("餐馆每月的销售数量变化：");
                        String jsonString = JSONObject.toJSON(totalSales).toString();
                        model.addAttribute("total_sales_in_a_month", StatisticFormat.translate2(totalSales));
                    }
                    if(map.containsKey(StaticConfig.TOTAL_MONEY_IN_A_MONTH)){
                        //餐馆每月的销售金额
                        Map<Integer,Double> totalMoneyInMonth= (Map<Integer, Double>) map.get(StaticConfig.TOTAL_MONEY_IN_A_MONTH);
                        model.addAttribute("total_money_in_a_month",
                                StatisticFormat.translate3(totalMoneyInMonth));
                    }
                    return "page/restaurant/statistic";
                }else{
                    model.addAttribute("message","该餐馆未通过审批，请耐心等待");
                    return "page/login";
                }
            }else{
                model.addAttribute("message","商家登录失败，密码错误");
                return "page/login";
            }
        }else if(user != null) {
            if (user.getPassword().equals(password) == true) {
                session.setAttribute("user", user);
                System.out.println("用户：" + user.getUserName() + "登陆成功");
                model.addAttribute("message", "用户登陆成功");
                return "redirect: findByPage.do";
            } else {
                model.addAttribute("message", "用户登陆失败，密码错误");
                return "page/login";
            }
        }
        model.addAttribute("message","用户名不存在！");
        return "page/login";
    }

//    根据订单查看订单的详细信息
    @ResponseBody
    @RequestMapping(value = "/viewDetailOfOneOrder")
    public ResponseDetailOfOrder viewDetailOfOneOrder(@RequestBody ResponseDetailOfOrder responseDetailOfOrder){
        System.out.println("想要查找的订单实体的订单编号是-------->"+responseDetailOfOrder.getOrderID());
        QueryOrderFullDetail detail= orderService.getOrderFullDetail(responseDetailOfOrder.getOrderID());
        detail.setUser(userService.findById(detail.getUserID()));
        if(detail.getUser()==null) System.out.println("查找到的用户为空值");
        responseDetailOfOrder.setAddress(detail.getUser().getAddress());
        Date time=detail.getOrderTime();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        responseDetailOfOrder.setOrderTime(sdf.format(time));
        responseDetailOfOrder.setUserName(detail.getUser().getUserName());
        log.println("返回的查询实体中的订单编号："+responseDetailOfOrder.getOrderID());
        log.println("返回的查询实体中的用户名："+responseDetailOfOrder.getUserName());
        log.println("返回的查询实体中的用户地址："+responseDetailOfOrder.getAddress());
        log.println("返回的查询实体中的订单时间"+responseDetailOfOrder.getOrderTime());
        return responseDetailOfOrder;
    }

//    用户注册
    @RequestMapping(value = "/register")
    public String userRegister(Users users,@RequestParam String password2,
                               @RequestParam String accountPwd,@RequestParam MultipartFile file,
                               HttpServletRequest request,HttpSession session,
                               Model model) throws Exception {
//        判断用户密码是否一致
        Users  users1=userService.findUserByPhone(users.getPhoneNum());
//        一个手机号只能注册一次
        if(users1!=null){
            model.addAttribute("message","该手机号的用户已经注册！");
            log.println("搜索到的用户不为空："+users1.getPhoneNum());
            return "page/user/register";
        }
        if(users.getPassword().equals(password2)==false){
            model.addAttribute("message","密码不一致！");
            log.println("密码不一致");
            return "page/user/register";
        }else{
            Bank bank=transactionService.getBankByID(users.getAccountID());
            if(bank==null){
                model.addAttribute("message","银行账户不存在！");
                log.println("银行账户不存在");
                return "page/user/register";
            }else {
                    if(bank.getPassword().equals(accountPwd)==false) {
                        model.addAttribute("message", "银行账户密码不正确！");
                        log.println("银行账户密码不正确");
                        return "page/user/register";
                    }else {
//                        银行账户验证成功，密码也一致，头像如果未上传的话就把南理工图片作为头像
                        if(file.isEmpty() || file.getSize()==0){
                            log.println("头像未上传，直接用南京理工大学logo做头像");
                            users.setAvatar(StaticConfig.AVATAR);
                        }else {
                            String pic_path=request.getServletContext().getRealPath("/static/upload/");
//        图片保存到路径下并且将返回文件的名称
                            String avatar =translate(file,pic_path);
                            users.setAvatar(avatar);
                            log.println("成功上传用户头像："+avatar);
                        }
                        users.setScore(100);
                        users.setUserState(StaticConfig.USER_STATE_REGISTERED);
                        userService.create(users);
                        log.println("成功创建用用户："+users.getUserName());
                        session.setAttribute("user",users);
                    }
                return "redirect:findByPage";
            }
        }
    }

//    跳转到查看所有订单页面，
    @RequestMapping(value = "/toViewOrders")
    public String QueryOrders(Model model, HttpSession session){
        Users user=(Users)session.getAttribute("user");
//        查看用户所有在配送中的订单
        List<Orders> ordersInDelivery = orderService.queryDeliveryOrder(user.getUserID());
        List<QueryOrderFullDetail> orderFullDetailsInDelivery = new ArrayList<>();
//      对每一个在配送中的订单呢都查询全部信息
        for(Orders order : ordersInDelivery){
            QueryOrderFullDetail detail = orderService.getOrderFullDetail(order.getOrderID());
            double totalValue = 0;
//            计算订单单项的价格
            for(ExtendOrderItem orderItem : detail.getOrderItems()){
                totalValue+=orderItem.getItemPrice();
            }
            detail.setTotalMoney(totalValue);
            orderFullDetailsInDelivery.add(detail);
        }
//        查看用户所有未评价的订单
        List<QueryOrderFullDetail> orderFullDetailsNoReview = new ArrayList<>();
        List<Orders> ordersNoReview = orderService.queryNoReviewOrder(user.getUserID());
        for(Orders order : ordersNoReview){
            double totalValue = 0;
            QueryOrderFullDetail detail = orderService.getOrderFullDetail(order.getOrderID());
            for(ExtendOrderItem orderItem : detail.getOrderItems()){
                totalValue+=orderItem.getItemPrice();
            }
            detail.setTotalMoney(totalValue);
            orderFullDetailsNoReview.add(detail);
        }
//        查询用户所有的已经支付的订单
        List<QueryOrderFullDetail> orderFullDetailsAlreadyPay = new ArrayList<>();
        List<Orders> ordersAlreadyPay = orderService.queryAlreadyPayOrder(user.getUserID());
        for(Orders order : ordersAlreadyPay){
            double totalValue = 0;
            QueryOrderFullDetail detail = orderService.getOrderFullDetail(order.getOrderID());
            for(ExtendOrderItem orderItem : detail.getOrderItems()){
                totalValue+=orderItem.getItemPrice();
            }
            detail.setTotalMoney(totalValue);
            orderFullDetailsAlreadyPay.add(detail);
        }
        log.println("正在配送中的订单："+orderFullDetailsInDelivery.size());
        log.println("已经支付但是商家还没有确定的订单数量："+orderFullDetailsAlreadyPay.size());
        log.println("没有评论的订单："+orderFullDetailsNoReview.size());
//        将订单逆转，将最近的订单放在最前面
        Collections.reverse(orderFullDetailsAlreadyPay);
        Collections.reverse(orderFullDetailsInDelivery);
        Collections.reverse(orderFullDetailsNoReview);
        model.addAttribute("orderFullDetailsAlreadyPay",orderFullDetailsAlreadyPay);
        model.addAttribute("orderFullDetailsInDelivery",orderFullDetailsInDelivery);
        model.addAttribute("orderFullDetailsNoReview",orderFullDetailsNoReview);

        return "page/user/viewOrders";
    }

//    添加用户评论
    @RequestMapping(value = "/AddReview")
    public String toAddReview(Model model, Review review, HttpServletRequest request, HttpServletResponse response,
                              @RequestParam(required = true) int orderID,@RequestParam String aixin) throws UnsupportedEncodingException {
        int value=Integer.parseInt(aixin);
        if(value!=0)
            restService.addLove(review.getResID());
        System.out.println("点赞的值是："+String.valueOf(value));
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        review.setTime(new Timestamp(new Date().getTime()));
        log.println("评论的用户是："+review.getUserID());
        review.setContent(new String(review.getContent().getBytes("ISO-8859-1"),"UTF-8"));
        log.println("评论的内容是："+review.getContent());
        log.println("评论的事件是"+review.getTime().toString());
        log.println("评论中对应的餐馆编号："+review.getResID());
//        添加一条评论并且改变订单的状态(在评论不为空的情况下操作）
        if(review.getContent().equals("")==false)
            orderService.AddReview(review,orderID);
        return "redirect:toViewOrders.do";
    }

//    根据指定页面和指定大小进行跳转
    @RequestMapping(value = "/findByPage")
    public String getMain(Model model,Dish dish,
                          @RequestParam(required = false) String condition,
                          @RequestParam(value = "pageCode", required=false,defaultValue = "1") int pageCode ,
                          @RequestParam(value = "pageSize", required = false,defaultValue = StaticConfig.PAGE_SIZE) int pageSize){
        List<Dish> listOfDish = restService.listAllDish();
        List<Restaurant> listOfAllRes=restService.findAll();
        int max=listOfAllRes.size()-1;
        int min=0;
        Random random = new Random();
        List<Restaurant> listOfRes=new ArrayList<>();
//        随机生成三个幸运餐馆作为牌面
//        保证三个餐馆两两不同
        int rand1=0,rand2=0,rand3=0;
        for(int i=1;i<=3;i++){
            int tmp=(random.nextInt(max)%(max-min)+(max-min))%(max-min)+min;
            if(i==1)rand1=tmp;
            else if(i==2 && tmp==rand1){
                tmp=(tmp+1)%max;
                rand2=tmp;
            }else {
                while(i==3 &&(tmp==rand1 || tmp==rand2))
                    tmp=(tmp+1)%max;
            }
            listOfRes.add(listOfAllRes.get(tmp));
        }
        log.println(rand1+" "+rand2+" "+rand3);
        model.addAttribute("res",listOfRes);
        model.addAttribute("dishes",listOfDish);
        Map<String,String> con= new HashMap<>();
        if(condition!=null && condition.equals("")==false){
            log.println("前端收到的限制条件："+condition);
            con.put("resTypeID",condition);
        }
        model.addAttribute("page",restService.findByPage(con,pageCode,pageSize));

        return "page/user/mainPage";
    }

    @RequestMapping(value = "/todish2Res")
    public String dish2Res(Model model,@RequestParam int dishID,
                           @RequestParam String resID){
        List<Dish> dishes=restService.ListDish(resID);
        int tmp=-1;
        for(int i=0;i<dishes.size();i++){
            if(dishes.get(i).getDishID()==dishID){
                tmp=i;
            }
        }
        Restaurant restaurant=restService.selectResByID(resID);
//        将该页面对应的商家放到request域中
        model.addAttribute("rest",restaurant);
        Dish tmp2=dishes.get(tmp);
        dishes.set(tmp,dishes.get(0));
        dishes.set(0,tmp2);
        model.addAttribute("dishes",dishes);
        return "page/user/dish2Res";
    }

    @RequestMapping(value = "/goToPay")
    public String goToPay(Model model,DishQryModel dishQryModel,
                          @RequestParam(required = false) String resID,
                          HttpSession session){
            List<ExtendOrderItem> orderItems=dishQryModel.getDishes();
            double totalValue=0;
            Restaurant restaurant=restService.selectResByID(resID);
            List<ExtendOrderItem> orderItemToShow=new ArrayList<>();
            session.setAttribute("restaurant",restaurant);
            for(ExtendOrderItem item:orderItems){
                if(item.getCount()!=0){
                    item.setOrderedDish(restService.OneDishInfo(item.getDishID()));
                    totalValue+=item.getItemPrice();
                    orderItemToShow.add(item);
                }
            }
            session.setAttribute("totalValue",totalValue);
            session.setAttribute("orderItemToShow",orderItemToShow);
            return "page/user/pay";
    }

//    跳珠到个人信息界面
    @RequestMapping(value = "/toUserInfo")
    public String toSelfInfo(){
        return "page/user/userInfo";
    }

    @RequestMapping(value = "/modifyInfo.do")
    public String modifyInfo(Model model,
                             Users user,String password2,MultipartFile file,
                             HttpServletRequest request,
                             HttpSession session) throws Exception {
        Bank bank=transactionService.getBankByID(user.getAccountID());
        Users userIn=userService.findById(user.getUserID());
        if(userIn==null) System.out.println("查找到的用户为空！");
        log.println("参数：用户编号"+user.getUserID());
        log.println("参数：用户名："+user.getUserName());
        log.println("参数：密码"+user.getPassword());
        log.println("参数：地址："+user.getAddress());
        log.println("参数：email:"+user.getEmail());
        log.println("参数：电话"+user.getPhoneNum());
        log.println("参数：用户状态"+user.getUserState());
        log.println("参数：账户："+user.getAccountID());
        log.println("参数：分数"+user.getScore());
        log.println("参数：用户头像："+user.getAvatar());
        if(bank==null){
//            修改银行账户之后的银行账户是真实存在的
            model.addAttribute("message","银行账户不存在");
            log.println("用户修改信息：账号不存在");
            return "page/user/userInfo" ;
        }else{
            if(user.getPassword().equals(password2)==false){
                model.addAttribute("message","账号和密码不一致");
                log.println("用户修改信息：密码不一致");
                return "page/user/userInfo";
            }else{
                //            字段验证
                if(user.getPassword().equals("") || user.getUserName().equals("") ||
                        user.getAccountID().equals("") || user.getAddress().equals("") ||
                        user.getPhoneNum().equals("") || user.getEmail().equals("")){
                    model.addAttribute("message","用户信息存在错误");
                    log.println("用户修改信息：字段存在空值");
                    return "page/user/userInfo";
                }else{
                    if(!(file.isEmpty() || file.getSize()==0)){
//                    头像有改变的情况下将头像改成新生成的图片的UUID
                        String pic_path=request.getServletContext().getRealPath("/static/upload/");
                        String avatar =translate(file,pic_path);
                        user.setAvatar(avatar);
                        log.println("在用户修改信息页面成功上传用户头像："+avatar);
                    }else{
//                    头像没有改变的情况下直接用原来的头像
                        user.setAvatar(userIn.getAvatar());
                        log.println("用户未改变头像");
                    }
                    user.setScore(userIn.getScore());
                    userService.updateAllInfo(user);
                    log.println("用户信息已经成功修改");
                    if(user.getPhoneNum().equals(userIn.getPhoneNum()) == false){
                        session.removeAttribute("user");
                        model.addAttribute("message","用户电话发生更改，请重新登录");
                        return "page/login";
                    }
//                将新的用户信息放入session中
                    session.removeAttribute("user");
                    session.setAttribute("user",user);
                    return "page/user/userInfo";
                }
            }
        }
    }


//    用户取消订单，改变订单的状态，并且重新获取新的订单数据
    @RequestMapping(value = "/cancelOrder")
    public String cancelOrder(Model model ,@RequestParam(required = true) int orderID,HttpSession session){
        System.out.println("企图取消的订单编号是："+orderID);
        Orders order = new Orders();
        order.setOrderID(orderID);
        order.setState(StaticConfig.ORDER_CANCEL);
        orderService.updateOrder(order);
        Orders changedOrder = orderService.findById(orderID);
        if(changedOrder==null)
            System.out.println("订单状态出错！");
        transactionService.TransactionBack(changedOrder);
        QueryOrderFullDetail orderFullDetail = orderService.getOrderFullDetail(orderID);
        List<ExtendOrderItem> listOfItems = orderFullDetail.getOrderItems();
//       将菜品的余量信息更新会原来的样子
        for(int i=0;i<listOfItems.size();i++){
            int tmp = 0-listOfItems.get(i).getCount();
            listOfItems.get(i).setCount(tmp);
        }
        orderService.updateDishInfo(listOfItems);
        session.removeAttribute("user");
//        用户的评分信息发生变化，在session域中重新放入user用户
        Users user = userService.findById(changedOrder.getUserID());
        session.setAttribute("user",user);
        return "redirect:toViewOrders.do";
    }

//    判断支付订单是否合法，合法的情况下完成支付
    @RequestMapping(value = "/validToPay")
    public String validToPay(Model model ,@RequestParam String accountID,@RequestParam String accountPassword,
                             HttpSession session){
        Bank bank= transactionService.getBankByID(accountID);
        if(bank==null){
            model.addAttribute("message","银行账户不存在");
            return "page/user/errorPay";
        }else{
            if(bank.getPassword().equals(accountPassword)==false){
                model.addAttribute("message","密码错误");
                return "page/user/errorPay";
            }else{
//                找到所有的订单项，以及用户和餐馆，添加订单，然后再添加订单项
                double totalValue = (double)session.getAttribute("totalValue");
                Restaurant restaurant=(Restaurant)session.getAttribute("restaurant");
                List<ExtendOrderItem> orderItemToShow = (List<ExtendOrderItem>)
                        session.getAttribute("orderItemToShow");
                boolean flag=false;
//                检查菜品的余量是否足够
                for(ExtendOrderItem orderItem:orderItemToShow){
                    if(orderItem.getCount()>orderItem.getOrderedDish().getRemain()){
                        flag=true;
                        break;
                    }
                }
                if(flag){
                    log.println("菜品的余量不足");
                    return "page/user/pay";
                }else{
                    Users user=(Users)session.getAttribute("user");
                    Orders order=new Orders();
                    order.setUserID(user.getUserID());
                    order.setState(StaticConfig.ORDER_ALREADY_PAY);
                    order.setResID(restaurant.getResID());
                    order.setOrderTime(new Timestamp(new Date().getTime()));
                    List<OrderItem> listOfOrderItem= new ArrayList<>();
                    for(ExtendOrderItem item:orderItemToShow){
                        OrderItem orderItem = new OrderItem();
                        orderItem.setCount(item.getCount());
                        orderItem.setDishID(item.getDishID());
                        listOfOrderItem.add(orderItem);
                    }
                    log.println("订单中一共包含："+listOfOrderItem.size()+"订单单项");
//                将订单以及订单项插入数据库
                    orderService.AddNewOrder(order,listOfOrderItem);
                    log.println("成功创建订单");
//                根据订单将菜品的信息进行更改
                    orderService.updateDishInfo(orderItemToShow);
                    log.println("成功更新订单表项");
//                交易，包括三方转账以及改变银行的盈余等信息
                    if(!transactionService.Transaction(new BigDecimal(totalValue),restaurant.getResID(),
                            restaurant.getManagerID(),user.getUserID())){
                        log.println("支付失败，密码错误或余额不足");
                        return "page/user/errorPay";
                    }else{
                        log.println("一次订单交易成功");
//                    交易完成之后用户的信息发生变化，将session域中的user更新为最新状态
                        Users newUser = userService.findById(user.getUserID());
                        session.removeAttribute("user");
                        session.setAttribute("user",newUser);

                        model.addAttribute("message","成功支付");
                        return "page/user/successPay";
                    }
                }
            }
        }
    }
    @RequestMapping(value = "/showRoute")
    public String showRoute(Model model,HttpSession session){
        Users user =(Users) session.getAttribute("user");
        model.addAttribute("end",user.getAddress());
        Restaurant restaurant=(Restaurant)session.getAttribute("restaurant");
        model.addAttribute("start",restaurant.getLocate());
        return "page/user/route";
    }

    @RequestMapping(value = "/logout")
    public String logout(Model model,HttpSession session){
        session.removeAttribute("user");
        return "page/login";
    }
    //    文件写入并且返回文件名称以及扩展名
    public String translate(MultipartFile file, String pic_path)throws Exception{
        String name = UUID.randomUUID().toString().replaceAll("-", "");
        //获取文件的扩展名
        String ext = FilenameUtils.getExtension(file.getOriginalFilename());
//       將圖片保存在out目錄中
        file.transferTo(new File(pic_path+"/"+name + "." + ext));
        return name + "." + ext;
    }
    public String getUploadPath(HttpServletRequest request){
        return request.getServletContext().getRealPath("/static/upload/");
    }
//    评论合法的检测
    public Boolean ValidationOfReview(Review review){
//        必须有评论内容
        if(review.getContent()!=null && review.getContent().equals("")==false){
            return true;
        }
        return false;
    }
}