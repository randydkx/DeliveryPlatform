package cn.edu.njust.controller;

import cn.edu.njust.entity.*;
import cn.edu.njust.service.OrderService;
import cn.edu.njust.service.RestService;
import cn.edu.njust.service.TransactionService;
import cn.edu.njust.service.UserService;
import cn.edu.njust.utils.DateTool;
import cn.edu.njust.utils.StaticConfig;
import com.alibaba.fastjson.JSONObject;
import com.mchange.v2.codegen.bean.SimpleStateBeanImportExportGeneratorExtension;
import com.sun.deploy.security.WSeedGenerator;
import javafx.scene.layout.BorderRepeat;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import cn.edu.njust.utils.StatisticFormat;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;
import static jdk.nashorn.internal.runtime.regexp.joni.Config.log;

@Controller
@RequestMapping(value = "/rest")
public class RestController {

    @Autowired
    private RestService restService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private UserService userService;
    @Autowired
    private TransactionService transactionService;

//    @RequestMapping(value = "/toListOneResDish")
//    public String toListOneResDish(Model model){
//        return "redirect:listAllDish.do";
//    }
//    将一个指定页面中的菜品信息封装并放到前端
    @RequestMapping(value = "/toUploadDish")
    public String toUploadDish(){
        return "page/restaurant/uploadDish";
    }
//    跳转到成列菜品的页面
    @RequestMapping(value = "/toListAllDish")
    public String toListAllDish(){
        return "redirect:listAllDish.do";
    }

//    查看菜品信息的页面进行菜品信息的修改
    @RequestMapping(value = "/modifyDish")
    public String modifyDish(Model model,Dish dish,HttpServletRequest request,MultipartFile file) throws Exception {
        Dish oldDish = restService.OneDishInfo(dish.getDishID());
        System.out.println("企图修改的菜品的dishID="+dish.getDishID());
//        如果没有上传新的文件的话直接用菜品原来的图片作为新的图片
        if(file.isEmpty()==true || file.getSize()==0){
            dish.setImage(oldDish.getImage());
        }else{
            String pic_path=request.getServletContext().getRealPath("/static/upload/");
            String image =translate(file,pic_path);
            dish.setImage(image);
        }
        log.println("菜品名称："+dish.getName());
        log.println("菜品类型编号："+dish.getDishTypeID());
        log.println("菜品的余量："+dish.getRemain());
        log.println("菜品的描述："+dish.getDescription());
        log.println("菜品的价格："+dish.getPrice());
        log.println("菜品的折扣"+dish.getDiscount());
        restService.updateDishInfo(dish);
//        重定向到查看所有菜品的页面
        return "redirect: listAllDish.do";
    }

    @RequestMapping(value = "/toResin")
    public String toResin(){
        return "page/restaurant/resin";
    }
    //餐馆注册
    @RequestMapping(value = "/resin")
    public String Register(Restaurant restaurant,
                           @RequestParam String password2,
                           @RequestParam(required=false) MultipartFile file,
                           HttpServletRequest request,Model model) throws Exception {
//        检查是否有相同的商家已经注册过
        Map<String,String> con=new HashMap<>();
        con.put("name",restaurant.getName());
        log.println(restaurant.getName()+" "+restaurant.getLocate()+" "+
                restaurant.getResPhone());
        con.put("locate",restaurant.getLocate());
        con.put("resPhone",restaurant.getResPhone());
        List<Restaurant> res=  restService.queryByCondition(con);
        if(res!=null && res.size()>0){
            log.println("商家已经注册");
            model.addAttribute("message","商家已经注册");
            return "page/restaurant/resin";
        }else{
            if(restaurant.getPassword().equals(password2) == false){
                model.addAttribute("message","密码不一致，请重新填写");
                return "page/restaurant/resin";
            }else{
                restaurant.setManagerID(StaticConfig.DEFAULT_MANAGER);
                if(restaurant.getStartTime()<0 ||
                        restaurant.getEndTime()<=restaurant.getStartTime() ||
                        restaurant.getEndTime()>24){
                    log.println("开始或者结束时间错误");
                    model.addAttribute("message","开始或者结束时间设置错误");
                    return "page/restaurant/resin";
                }else{
                    Bank bank = transactionService.getBankByID(restaurant.getAccountID());
                    if(bank == null){
                        model.addAttribute("message","银行账户不存在，入驻失败");
                        return "page/restaurant/resin";
                    }else{
                        //                餐馆信息通过验证，可以在数据库中生成数据
                        if(!(file.isEmpty() || file.getSize()==0)){
                            String pic_path=request.getServletContext().getRealPath("/static/upload/");
                            String image =translate(file,pic_path);
                            restaurant.setImage(image);
                            log.println("餐馆成功上传照片:"+image);
                        }else{
//                缺省情况下用南京理工大学的logo
                            restaurant.setImage(StaticConfig.DEFAULT_REST_IMAGE);
                            log.println("餐馆使用的是南京理工大学的logo");
                        }
                        restService.ResRegister(restaurant);
                        String newResID = restService.MaxResID();
                        model.addAttribute("message","注册成功，入驻餐馆的账号是 "+newResID+", 请等待审核");
                        log.print("餐馆注册成功"+"name:"+restaurant.getName());
                        return "page/login";
                    }
                }
            }
        }
    }
//餐馆注销登录
    @RequestMapping(value = "/logout")
    public String logout(HttpSession session){
        session.removeAttribute("restaurant");
        return "page/login";
    }

//    跳转到商家所有订单的页面
    @RequestMapping(value = "/toListAllOrders")
    public String toListAllOrders(){
        return "redirect: listAllOrders";
    }

    //查找餐馆全部菜品信息,菜品的余量需要大于零
    @RequestMapping(value = "/listAllDish")
    public String LishDish( Model model,HttpSession session){
        Restaurant restaurant=(Restaurant)session.getAttribute("restaurant");
        String  resID=restaurant.getResID();
        List<Dish> dishes=restService.ListDish(resID);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        for(Dish dish:dishes){
//            DateTool.str2Date(sdf.format(dish.getStartTime()),"yyyy-MM-dd HH:mm:ss")
            System.out.println("菜品的id:"+dish.getDishID());
        }
        model.addAttribute("allDishes",dishes);
        System.out.println("商家菜品的数量："+dishes.size());
        return "page/restaurant/listOneResDish";
    }

    @RequestMapping(value = "/toViewReviews")
    public String toViewReviews(Model model,HttpSession session){
        Restaurant restaurant = (Restaurant)session.getAttribute("restaurant");
        List<QueryReview> listOfReviews = restService.FindResReview(restaurant.getResID());
        model.addAttribute("listOfReviews",listOfReviews);
        return "page/restaurant/viewReviews";
    }

    @RequestMapping(value = "/listAllOrders")
    public String listAllOrders(Model model,HttpSession session){
        Restaurant restaurant = (Restaurant) session.getAttribute("restaurant");
        Orders query=new Orders();
        query.setState("alreadypay");
        query.setResID(restaurant.getResID());
        Map<String,String> condition = new HashMap<>();
        condition.put("state","alreadypay");
        condition.put("resID",restaurant.getResID());
        List<Orders> orders1 = restService.queryOrdersByCon(condition);
        List<QueryOrderFullDetail> ordersAlreadyPay = new ArrayList<>();
        for(Orders order : orders1){
//            补充订单中的消费者信息
            QueryOrderFullDetail detail = orderService.getOrderFullDetail(order.getOrderID());
            double totalValue = 0;
            for(ExtendOrderItem item : detail.getOrderItems()){
                totalValue+=item.getItemPrice();
            }
            detail.setTotalMoney(totalValue);
            detail.setUser(userService.findById(order.getUserID()));
            ordersAlreadyPay.add(detail);
        }
        Map<String,String> condition2=new HashMap<>();
        condition2.put("resID",restaurant.getResID());
        condition2.put("state","indelivery");
        List<Orders> orders2 = restService.queryOrdersByCon(condition2);
        List<QueryOrderFullDetail> ordersInDelivery = new ArrayList<>();
        for(Orders order : orders2){
            QueryOrderFullDetail detail = orderService.getOrderFullDetail(order.getOrderID());
            double totalValue = 0;
            for(ExtendOrderItem item : detail.getOrderItems()){
                totalValue+=item.getItemPrice();
            }
            detail.setTotalMoney(totalValue);
            detail.setUser(userService.findById(order.getUserID()));
            ordersInDelivery.add(detail);
        }
        Collections.reverse(ordersInDelivery);
        Collections.reverse(ordersAlreadyPay);
        System.out.println("餐馆方：已经支付但是没有配送的订单数量："+ordersAlreadyPay.size());
        System.out.println("餐馆方：正在配送中的订单数量："+ordersInDelivery.size());
        model.addAttribute("ordersAlreadyPay",ordersAlreadyPay);
        model.addAttribute("ordersInDelivery",ordersInDelivery);
        return "page/restaurant/listOrder";
    }

    @RequestMapping(value = "/acceptDelivery")
    public String acceptDelivery(@RequestParam(required = true) int orderID,Model model){
        Orders order = new Orders();
        order.setState("indelivery");
        order.setOrderID(orderID);
        orderService.updateOrder(order);
        return "redirect: toListAllOrders.do";
    }

    @RequestMapping(value = "alreadyDone")
    public String alreadyDone(Model model,@RequestParam(required = true) int orderID){
        Orders order = new Orders();
        order.setState("noreview");
        order.setOrderID(orderID);
        orderService.updateOrder(order);
        return "redirect: toListAllOrders.do";
    }
//    处理餐馆上传的菜品
    @RequestMapping(value = "/addDish")
    public String addDish(Model model, Dish dish,
                          @RequestParam(required = false) MultipartFile file,
                          HttpServletRequest request, HttpSession session) throws Exception {
        String pic_path=request.getServletContext().getRealPath("/static/upload/");
//        没有上传菜品图片
        if(file.isEmpty() || file.getSize()==0){
                return "page/restaurant/uploadDish";
        }
        String image =translate(file,pic_path);
        dish.setImage(image);
        dish.setStartTime(new Timestamp(new Date().getTime()));
        Restaurant restaurant = (Restaurant)session.getAttribute("restaurant");
        dish.setResID(restaurant.getResID());
        log.println(dish.getDescription());
        if(dish.getDescription().length()>0 && dish.getRemain()>0
        && dish.getPrice()<0 || dish.getDiscount()<0 || dish.getDiscount()>10){
//            菜品没法通过检验，上传失败
            model.addAttribute("message","菜品上传失败，菜品不符合要求");
            return "page/restaurant/uploadDish";
        }
        restService.LoadDish(dish);
        return "page/restaurant/loadSuccess";
    }

//    响应ajax异步请求数据，将查找到的dishinfo传到前端
    @ResponseBody
    @RequestMapping(value = "/findOneDishInfo")
    public Dish findOneDishInfo(@RequestBody Dish dish){
        System.out.println("传过来的dishID是："+dish.getDishID());
        Dish findDish = restService.findDishByDishID(dish.getDishID());
        System.out.println("==============================================================");
        if(findDish==null){
            System.out.println("未找到指定的dish");
            return null;
        }else{
            log.println("findDish.dishID:"+findDish.getDishID());
            log.println("findDish.description"+findDish.getDescription());
            log.println("findDish.remain"+findDish.getRemain());
            log.println("findDish.price"+findDish.getPrice());
            log.println("findDish.discount"+findDish.getDiscount());
            log.println("findDish.startTime"+findDish.getStartTime().toString());
            return findDish;
        }
    }

//    //获取某一条菜品的具体信息(用于查看菜品详细信息页面、菜品信息修改页面)
//    @RequestMapping(value = "/oneDishInfo")
//    public String oneDishInfo(@RequestParam int dishID,Model model){
//        Dish dish=restService.OneDishInfo(dishID);
//        model.addAttribute("onedish",dish);
//        return"page/Onedish";
//    }
    //餐馆修改一条菜品信息
////   检查修改的菜品信息是否合法
//    @RequestMapping(value="/oneDishChange")
//    public String oneDishChange(Dish dish,Model model){
//        if(this.checkDishValid(dish)){
//            restService.OneDishChange(dish);
//            return "page/xxxx";
//        }
//        model.addAttribute("message","修改菜品信息请求错误");
//        return "page/test";
//    }

//    餐馆进行数据分析的请求
    @RequestMapping(value = "/getStatistic")
    public String showStatistic(@RequestParam(required = false) String resID,Model model,HttpSession session){
        if(resID==null || resID.equals("")==true){
            Restaurant re=(Restaurant)session.getAttribute("restaurant");
            resID = re.getResID();
        }
        Map<Object,Object> map=restService.getAllStatistic(resID);
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
            System.out.println("餐馆每月的销售金额变化：");
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
    }

    public boolean checkDishValid(Dish dish){
        if(dish.getRemain()>0 && dish.getDescription()!=null
                && dish.getDescription().equals("")==false){
            return false;
        }
        return true;
    }


    public boolean validToRegister(Restaurant restaurant){
        Map<String,String> con=new HashMap<>();
        con.put("name",restaurant.getName());
        con.put("locate",restaurant.getLocate());
        con.put("resPhone",restaurant.getResPhone());
        List<Restaurant> res=  restService.queryByCondition(con);
        if(res!=null)return false;
        return true;
    }

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
}
