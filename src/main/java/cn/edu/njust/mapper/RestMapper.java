package cn.edu.njust.mapper;

import cn.edu.njust.entity.*;

import java.util.List;
import java.util.Map;

public interface RestMapper {
    //根据餐馆resId查询全部菜品信息
    public List<Dish> ListDish(String resID);
    //查询评分最高的5家餐馆
    public List<Restaurant> Top3();
    //查询评分最高的餐馆信息
    public Restaurant TopScore();
    //根据菜品ID查询一条菜品的信息
//    查找所以餐馆
    public List<Restaurant> findAll();
    public Dish OneDishInfo(int dishID);
    //修改某一条菜品的信息
    public void OneDishChange(Dish dish);
    //添加一条菜品信息
    public void LoadDish(Dish dish);
    //保存餐馆注册信息 初始状态为未通过申请
    public void ResRegister(Restaurant restaurant);
    //根据手机号查找餐馆信息，判断能否注册 查询非空时可以查看申请状态
    public Restaurant ResRegisterConfirm(String resPhone);
    //获取识别码最大的餐馆
    public Restaurant MaxResID();
    //获取菜品类别名对应的类别标号
    public int dishTypeID(String dishTypeName);
    //按照菜品类别编号查询菜品信息
    public List<Dish> ListByType(int dishTypeID);
//    通过id查找一条记录
    Restaurant selectResByID(String resID);
    //查找餐馆评论
    List<QueryReview> FindResReview(String resID);
    //    查询指定时间内的订单，时间放在con中
    List<Orders> salesInAMonth(QueryStatisticInfo queryStatisticInfo);
//    查询餐馆中含有的所有菜品类型
    List<String> distinctDishType(String resID);
//    通过菜品类型编号得到菜品类型名称
    List<String> queryDishTypeByID(int orderID);
//    商家通过resID查找对应的所有的dishTypeName和对应的金额
    List<QueryDishTypeAndMoney> dishTypeAndMoney(String resID);
//    根据条件查询
    List<Restaurant> queryByCondition(Map<String,String> con);
//    根据菜品的类型查找类型编号
    int queryDishTypeIDByName(String name);
//    更新餐馆的盈余
    void updateRestBalance(Restaurant restaurant);
//    给餐馆添加爱心
    void addLove(String resID);
//    通过餐馆编号以及state状态查找一个餐馆对应的所有订单
    List<Orders> queryOrdersByCon(Map<String,String> condition);
}