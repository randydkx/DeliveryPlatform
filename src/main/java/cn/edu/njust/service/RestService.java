package cn.edu.njust.service;

import cn.edu.njust.entity.*;
import com.github.pagehelper.Page;

import java.util.List;
import java.util.Map;

public interface RestService extends BaseService<Restaurant> {

    //根据餐馆resId查询全部菜品信息
    List<Dish> ListDish(String resID);
    //查询评分最高的5家餐馆
    List<Restaurant> Top3();
    //按照餐馆类别查询餐馆
    List<Dish> ListByType(String dishTypeName);
    //查询评分最高的餐馆信息
    Restaurant TopScore();
    //根据菜品ID查询一条菜品的信息
    Dish OneDishInfo(int dishID);
    //修改某一条菜品的信息
    void OneDishChange(Dish dish);
    //添加一条菜品信息
    void LoadDish(Dish dish);
    //餐馆注册
    boolean ResRegister(Restaurant restaurant);
//    通过id查找一个餐馆
    Restaurant selectResByID(String resID);
//    查找所有dish
    List<Dish> listAllDish();
//    通过条件查询，通过mybatis插件实现分页
//    分页控制
    PageBean<Dish> findByPage(Map<String,String> con, int pageCode, int pageSize);
//查找所有对应该res的评论
    List<QueryReview> FindResReview(String resID);
//    查询每个月的订单（2020年的）
    Map<Integer,List<Orders> > listOrdersInAllMonth(String resID);
//    查询餐馆的不同类型的菜品的集合
    List<String> distinctDishType(String resID);
//    通过菜品类型编号得到菜品类型名称
    List<String> queryDishTypeByID(int dishTypeID);
//    查询每个菜品名称对应的菜品的销售数量
    Map<String ,Integer> dishTypeToAmountMap(String resID);
//   通过resID查找对应的类别以及该类别对应的金额
    List<QueryDishTypeAndMoney> dishTypeAndMoney(String resID);
    //    查询一个餐馆所有的数据分析信息
    Map<Object,Object> getAllStatistic(String resID);
//    查询2019年每个月的订单
    public Map<Integer, List<Orders>> listOrdersInAllMonthIn2019(String resID);
//    查找所有餐馆
    public List<Restaurant> findAll();
//   根据条件查询
    List<Restaurant> queryByCondition(Map<String,String> con);
//    根据菜品类型查找类型编号
    int queryDishTypeIDByName(String dishTypeName);
//    更新餐馆的盈余
    void updateRestBalance(Restaurant restaurant);
//   给餐馆添加爱心
    void addLove(String resID);
//    更新菜品信息
    void updateDishInfo(Dish dish);
//    找到最大的餐馆编号，在餐馆注册之后要展示给餐馆
    String MaxResID();
//    通过dishID查找dish
    Dish findDishByDishID(int dishID);
//    通过条件查找餐馆的订单
    List<Orders> queryOrdersByCon(Map<String,String> condition);
}
