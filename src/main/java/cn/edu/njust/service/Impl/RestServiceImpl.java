package cn.edu.njust.service.Impl;

import cn.edu.njust.entity.*;
import cn.edu.njust.mapper.DishMapper;
import cn.edu.njust.mapper.OrderMapper;
import cn.edu.njust.mapper.RestMapper;
import cn.edu.njust.service.RestService;
import cn.edu.njust.utils.StaticConfig;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static cn.edu.njust.utils.DateTool.str2Date;

@Service
public class RestServiceImpl implements RestService {

    @Autowired
    private RestMapper restMapper;
    @Autowired
    private DishMapper dishMapper;
    @Autowired
    private OrderMapper orderMapper;

    @Override
    public List<Restaurant> findAll() {
        return restMapper.findAll();
    }

    @Override
    public List<Restaurant> queryByCondition(Map<String, String> con) {
        return restMapper.queryByCondition(con);
    }

    @Override
    public int queryDishTypeIDByName(String dishTypeName) {
        return restMapper.queryDishTypeIDByName(dishTypeName);
    }

    @Override
    public void updateRestBalance(Restaurant restaurant) {
        restMapper.updateRestBalance(restaurant);
    }

    @Override
    public void addLove(String resID) {
        restMapper.addLove(resID);
    }

    @Override
    public void updateDishInfo(Dish dish) {
        dishMapper.updateDishInfo(dish);
    }

    @Override
    public String MaxResID() {restMapper.MaxResID();
        return restMapper.MaxResID().getResID();
    }

    @Override
    public Dish findDishByDishID(int dishID) {
        return dishMapper.findDishByDishID(dishID);
    }

    @Override
    public List<Orders> queryOrdersByCon(Map<String, String> condition) {
        return restMapper.queryOrdersByCon(condition);
    }

    @Override
    public Restaurant findById(int id) { return null; }

    @Override
    public void create(Restaurant restaurant) { }

    @Override
    public void delete(int id) { }

    @Override
    public void update(Restaurant restaurant) { }

    //根据餐馆resId查询全部菜品信息
    public List<Dish> ListDish(String resID){
        return restMapper.ListDish(resID);
    }
    //查询评分最高的5家餐馆
    public List<Restaurant> Top3(){
        return restMapper.Top3();
    }
    //按照菜品类别名查询菜品信息
    public List<Dish> ListByType(String resTypeName){
        int resTypeID=restMapper.dishTypeID(resTypeName);
        return restMapper.ListByType(resTypeID);
    }
    //查询评分最高的餐馆信息
    public Restaurant TopScore(){
        return restMapper.TopScore();
    }
    //根据菜品ID查询一条菜品的信息
    public Dish OneDishInfo(int dishID){
        return restMapper.OneDishInfo(dishID);
    }
    //修改某一条菜品的信息
    public void OneDishChange(Dish dish){
        restMapper.OneDishChange(dish);
    }
    //添加一条菜品信息
    public void LoadDish(Dish dish){
        restMapper.LoadDish(dish);
    }
    //餐馆注册 返回true为成功注册，返回false为申请中或已注册
    public boolean ResRegister(Restaurant restaurant) {
        Restaurant res = restMapper.ResRegisterConfirm(restaurant.getResPhone());
        if (res != null) {
            return false;//审批中或已注册
        }
        //添加注册信息
        else {
            //获取MAXResID
            String maxResID = restMapper.MaxResID().getResID();
            int num = Integer.parseInt(maxResID);
            num += 32;
            String newResID = String.valueOf(num);
            restaurant.setResID(newResID);
            //注册信息添加
            restMapper.ResRegister(restaurant);
            return true;
        }
    }

    @Override
    public Restaurant selectResByID(String resID) {
        return restMapper.selectResByID(resID);
    }

    @Override
    public List<Dish> listAllDish() {
        Map<String, String> con=new HashMap<String,String>();
        return dishMapper.findByPage(con);
    }

    @Override
    public PageBean findByPage(Map<String, String> con, int pageCode, int pageSize) {
//使用mybatis分页插件
        PageHelper.startPage(pageCode,pageSize);
//调用分页查询方法，mybatis自动实现分页
        Page<Dish> page= dishMapper.findByPage(con);
//        设置pagecode，pagetotal，pageCount,page但也显示数量pageSize，当前页对应的查询结果
        return new PageBean(pageCode,(int)Math.ceil((double)(page.getTotal() /
                (double)pageSize)),(int)page.getTotal(),pageSize,page.getResult());
    }

    //查找餐馆评论
    public List<QueryReview> FindResReview(String resID){
        return  restMapper.FindResReview(resID);
    }

//    查询每个月的订单,通过map的key获取这些订单
    @Override
    public Map<Integer, List<Orders>> listOrdersInAllMonth(String resID) {
        Map result=new HashMap<Integer,List<Orders>>();
//        对十二个月的订单进行统计
        for(int i=1;i<=12;i++){
            String start=new String();
            String end=new String();
            if(i<10){
                start="2020-0"+i+"-"+"01";
            }else{
                start="2020-"+i+"-"+"01";
            }
            if(i<9){
                end="2020-0"+(i+1)+"-"+"01";
            }else if(i<12){
                end="2020-"+(i+1)+"-"+"01";
            }else{
                end="2021-01-01";
            }
            QueryStatisticInfo statisticInfo=new QueryStatisticInfo();
            Timestamp startTime = new Timestamp(str2Date(start, StaticConfig.TIME_PATTERN).getTime());
            Timestamp endTime=new Timestamp(str2Date(end,StaticConfig.TIME_PATTERN).getTime());
            System.out.println("开始时间是："+startTime.toString());
            System.out.println("结束时间是："+endTime.toString());
            statisticInfo.setStartTime(startTime);
            statisticInfo.setEndTime(endTime);
            statisticInfo.setResID(resID);
            List<Orders> list = restMapper.salesInAMonth(statisticInfo);
            result.put(new Integer(i),list);
        }
        return result;
    }
    public Map<Integer, List<Orders>> listOrdersInAllMonthIn2019(String resID) {
        Map result=new HashMap<Integer,List<Orders>>();
        for(int i=1;i<=12;i++){
            String start=new String();
            String end=new String();
//            设置开始时间以及结束时间
            if(i<10){
                start="2019-0"+i+"-"+"01";
            }else{
                start="2019-"+i+"-"+"01";
            }
            if(i<9){
                end="2019-0"+(i+1)+"-"+"01";
            }else if(i<12){
                end="2019-"+(i+1)+"-"+"01";
            }else{
                end="2020-01-01";
            }
            QueryStatisticInfo statisticInfo=new QueryStatisticInfo();
            Timestamp startTime = new Timestamp(str2Date(start, StaticConfig.TIME_PATTERN).getTime());
            Timestamp endTime=new Timestamp(str2Date(end,StaticConfig.TIME_PATTERN).getTime());
            System.out.println("开始时间是："+startTime.toString());
            System.out.println("结束时间是："+endTime.toString());
            statisticInfo.setStartTime(startTime);
            statisticInfo.setEndTime(endTime);
            statisticInfo.setResID(resID);
            List<Orders> list = restMapper.salesInAMonth(statisticInfo);
            result.put(new Integer(i),list);
        }
        return result;
    }

//    所有的数据分析的封装
    @Override
    public Map<Object,Object> getAllStatistic(String resID) {
        Map<Object,Object> result=new HashMap<>();
        Map<String,Double> dishTypeAndMoneyMap=new HashMap<>();
        Map<String,Integer> dishTypeAndCountMap=new HashMap<>();
        Map<Integer,Integer> ordersNumInMonth=new HashMap<>();
//        餐馆的月销售订单总信息
        Map<Integer,List<Orders> > map=this.listOrdersInAllMonth(resID);
//        Map<Integer,List<Orders> > map2=this.listOrdersInAllMonthIn2019(resID);
        if(map.size()==0){
            result.put(StaticConfig.NO_SALES,true);
            return result;
        }else{
            Map<Integer,Integer> totalAmountOfAllMonth=new HashMap<>();
            Map<Integer, Double> totalPriceOfAllMonth=new HashMap<>();
            for(int i=1;i<=12;i++){
                Integer month=new Integer(i);
                List<Orders> listOfAMonth=map.get(month);
                double totalPrice=0;
                int totalAmount=0;
                ordersNumInMonth.put(month,listOfAMonth.size());
                for(int j=0;j<listOfAMonth.size();j++){
//                    餐馆每月的销售总金额
                        QueryOrderFullDetail orderFullDetail=
                                orderMapper.queryOrderFullDetail(listOfAMonth.get(j).getOrderID());
                        if(orderFullDetail!=null){
                            for(ExtendOrderItem extendOrderItem : orderFullDetail.getOrderItems()){
                                totalPrice+=extendOrderItem.getItemPrice();
//                                餐馆的月销售数量(菜品）
                                totalAmount+=extendOrderItem.getCount();
                            }
                        }
                }
                totalPriceOfAllMonth.put(month,totalPrice);
                totalAmountOfAllMonth.put(month,totalAmount);
//                餐馆的月销售总金额+餐馆的月销售总量
            }
            List<QueryDishTypeAndMoney> list = this.dishTypeAndMoney(resID);
            for(QueryDishTypeAndMoney item:list){
                dishTypeAndMoneyMap.put(item.getDishTypeName(),item.getMoneyToOneDishType());
                dishTypeAndCountMap.put(item.getDishTypeName(),item.getCountToOneDishType());
            }
//            餐馆每月的销售金额
            result.put(StaticConfig.TOTAL_MONEY_IN_A_MONTH,
                    totalPriceOfAllMonth);
//            餐馆每月的销售量
            result.put(StaticConfig.TOTAL_SALES_IN_A_MONTH,
                    totalAmountOfAllMonth);
//            餐馆各类菜品的销售金额
            result.put(StaticConfig.TOTAL_SALES_OF_DISHTYPE,
                    dishTypeAndMoneyMap);
            result.put(StaticConfig.TOTAL_COUNT_OF_DISHTYPE,
                    dishTypeAndCountMap);
//            餐馆获得的点赞数量
            result.put(StaticConfig.TOTAL_SCORE_OF_RES,
                    restMapper.selectResByID(resID).getScore());
//            餐馆每月的订单数量
            result.put(StaticConfig.TOTAL_ORDERS_IN_ALL_MONTH,
                    ordersNumInMonth);
//            餐馆的年收入
            result.put(StaticConfig.TOTAL_BALANCE,
                    restMapper.selectResByID(resID).getBalance());
        }
        return result;
    }


    @Override
    public List<String> distinctDishType(String resID) {
        return restMapper.distinctDishType(resID);
    }

    @Override
    public List<String> queryDishTypeByID(int dishTypeID) {
        return restMapper.queryDishTypeByID(dishTypeID);
    }

    @Override
    public Map<String, Integer> dishTypeToAmountMap(String resID) {
        return null;
    }

    @Override
    public List<QueryDishTypeAndMoney> dishTypeAndMoney(String resID) {
        return restMapper.dishTypeAndMoney(resID);
    }
}