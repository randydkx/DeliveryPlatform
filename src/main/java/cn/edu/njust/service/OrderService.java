package cn.edu.njust.service;

import cn.edu.njust.entity.*;

import java.util.List;

public interface OrderService extends  BaseService<Orders>{
    //消费者查找进行中的订单
    List<Orders> CurOrder(int userID);
    //消费者查看已经完成的订单
    List<Orders> HistoryOrder(int userID);
    //获取餐馆已完成的订单
    List<Orders>ResHistoryOrder(String resID);
    //获取餐馆进行中的订单
    List<Orders>ResCurOrder(String resID);
    //取消订单业务
    void updateOrder(Orders orders);
    //点餐订单创建 订单+订单项
    void AddNewOrder(Orders orders,List<OrderItem>Items);
    //支付订单
    void PayForOrder(Orders orders);
    //商家配送订单（订单开始配送）
    boolean DeliverOrder(int orderID);
    //商家送达订单(订单完成)
    boolean Arrive(int orderID);
    //消费者对订单进行评价
    void AddReview(Review review,int orderID);
    //    通过订单号查看一个订单的详细信息
    QueryOrderFullDetail getOrderFullDetail(int orderID);
//    通过订单号查找该订单带来的收益
    double gainFromOneOrder(int orderID);
//    从订单中更新菜品的信息->菜品的余量，菜品的销售金额
    void updateDishInfo(List<ExtendOrderItem> listOfItem);
//    查看用户在配送中的订单
    List<Orders> queryDeliveryOrder(int userID);
//    查看用户未评价的订单
    List<Orders> queryNoReviewOrder(int userID);
//    查看已经支付的订单
    List<Orders> queryAlreadyPayOrder(int userID);
}