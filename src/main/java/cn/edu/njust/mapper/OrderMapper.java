package cn.edu.njust.mapper;

import cn.edu.njust.entity.*;

import java.util.List;
import java.util.Map;

public interface OrderMapper {
    //消费者查找进行中的订单
    List<Orders> CurOrder(QueryOrder queryOrder);
    // 断订单是否可以取消 ,返回订单状态
    String  ResOrderRej(int orderID);
    //查找一个订单的订单项
    List<OrderItem> OrderItem(int orderID);
    //消费者查看已经完成的订单
    List<Orders> HistoryOrder(QueryOrder queryOrder);
    //消费者对订单进行评价
    void AddReview(Review review);
    //改变订单状态
    void ChangeOS(ChangeOrderState changeOrderState);
    //获取餐馆已完成的订单
    List<Orders>ResHistoryOrder(QueryOrder queryOrder);
    //获取餐馆进行中的订单
    List<Orders>ResCurOrder(QueryOrder queryOrder);
    //创建新的订单
    void AddNewOrder(Orders orders);
    //添加订单的订单项
    void AddOrderItem(OrderItem orderItem);
    //获取最大的orderID
    int maxOrderID();
    //查找订单项找对应菜品
    Dish ItemToDish(OrderItem orderItem);
    //订单完成后更改菜品销量、余量
    void SaleRemainChange(OrderDishes orderDishes);
//    查看订单所有的信息
    QueryOrderFullDetail queryOrderFullDetail(int orderID);
//    更新单个菜品的余量以及销售量等信息
    void updateSingleDishInfo(Map<String,String> condition);
//    查看在配送中订单
    List<Orders> queryDeliveryOrder(int userID);
//    查询未评价订单
    List<Orders> queryNoReviewOrder(int userID);
//    查询已经支付但是还未配送的订单
    List<Orders> queryAlreadyPayOrder(int userID);
//   改变订单的状态
    void changeOrderState(Map<String,String> condition);
//    根据订单编号进行查询
    Orders queryByOrderID(int orderID);
}