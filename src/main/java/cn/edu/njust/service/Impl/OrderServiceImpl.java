package cn.edu.njust.service.Impl;

import cn.edu.njust.entity.*;
import cn.edu.njust.mapper.OrderMapper;
import cn.edu.njust.mapper.RestMapper;
import cn.edu.njust.service.OrderService;
import cn.edu.njust.service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.edu.njust.utils.StaticConfig;

@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private RestMapper restMapper;
    @Autowired
    private TransactionService transactionService;
    @Override
    public List<Orders> findAll() {
        return null;
    }

    @Override
    public Orders findById(int id) {
        return orderMapper.queryByOrderID(id);
    }

    @Override
    public void create(Orders orders) {

    }

    @Override
    public void delete(int id) {

    }

    @Override
    public void update(Orders orders) {

    }
    //消费者查找进行中的订单
    public List<Orders> CurOrder(int userID){
        QueryOrder queryOrder=new QueryOrder();
        String ID=Integer.toString(userID);
        queryOrder.setID(ID);
        queryOrder.setState1(StaticConfig.ORDER_CANCEL);
        queryOrder.setState2(StaticConfig.ORDER_NO_REVIEW);
        queryOrder.setState3(StaticConfig.ORDER_ALREADY_REVIEW);
        return orderMapper.CurOrder(queryOrder);
    }
    //消费者查看已经完成的订单
    public List<Orders> HistoryOrder(int userID){
        QueryOrder queryOrder=new QueryOrder() ;
        String ID=Integer.toString(userID);
        queryOrder.setID(ID);
        queryOrder.setState1(StaticConfig.ORDER_NO_PAY);
        queryOrder.setState2(StaticConfig.ORDER_ALREADY_PAY);
        queryOrder.setState3(StaticConfig.ORDER_IN_DELIVERY);
        return orderMapper.HistoryOrder(queryOrder);
    }
    //获取餐馆已完成的订单
    public List<Orders>ResHistoryOrder(String resID){
        QueryOrder queryOrder=new QueryOrder() ;
        queryOrder.setID(resID);
        queryOrder.setState1(StaticConfig.ORDER_NO_PAY);
        queryOrder.setState2(StaticConfig.ORDER_ALREADY_PAY);
        queryOrder.setState3(StaticConfig.ORDER_IN_DELIVERY);
        return orderMapper.ResHistoryOrder(queryOrder);
    }
    //获取餐馆进行中的订单
    public List<Orders>ResCurOrder(String resID){
        QueryOrder queryOrder=new QueryOrder() ;
        queryOrder.setID(resID);
        queryOrder.setState1(StaticConfig.ORDER_CANCEL);
        queryOrder.setState2(StaticConfig.ORDER_NO_REVIEW);
        queryOrder.setState3(StaticConfig.ORDER_ALREADY_REVIEW);
        return orderMapper.ResCurOrder(queryOrder);
    }

    @Override
    public void updateOrder(Orders orders) {
        Map<String,String> condition = new HashMap<>();
        condition.put("orderID",String.valueOf(orders.getOrderID()));
        condition.put("state",orders.getState());
         orderMapper.changeOrderState(condition);
    }

//    //取消订单
//    public boolean  ResOrderRej(Orders orders){
//        String state=orderMapper.ResOrderRej(orders.getOrderID());//获取订单状态
//        //可以取消
//        if(state.equals(StaticConfig.ORDER_NO_PAY)||state.equals(StaticConfig.ORDER_ALREADY_PAY)){
//            ChangeOrderState changeOrderState=new ChangeOrderState();
//            changeOrderState.setOrderID(orders.getOrderID());
//            changeOrderState.setState(StaticConfig.ORDER_CANCEL);
//            orderMapper.ChangeOS(changeOrderState);
//            //退款
//            transactionService.TransactionBack(orders);
//            return true;
//        }else{ //已经配送后无法取消
//            return false;
//        }
//    }
    //创建新的订单,添加订单项
    public void AddNewOrder(Orders orders,List<OrderItem>Items){
        orderMapper.AddNewOrder(orders);
        int order=orderMapper.maxOrderID();//获取订单的orderID
        for(int i=0;i<Items.size();i++){
            Items.get(i).setOrderID(order);
            orderMapper.AddOrderItem(Items.get(i));
        }
    }
    //支付订单,并且完成金钱交易
    public  void PayForOrder(Orders orders){
        String resID=orders.getResID();
        Restaurant restaurant=restMapper.selectResByID(resID);
        QueryOrderFullDetail queryOrderFullDetail=orderMapper.queryOrderFullDetail(orders.getOrderID());
        double total=0;
        for(ExtendOrderItem extendOrderItem:queryOrderFullDetail.getOrderItems()){
            total+=extendOrderItem.getItemPrice();
        }
        BigDecimal amount=BigDecimal.valueOf(total);
        transactionService.Transaction(amount,resID,restaurant.getManagerID(),orders.getUserID());
    }

    //商家配送订单
    public  boolean DeliverOrder(int orderID){
        String state=orderMapper.ResOrderRej(orderID);
        //订单已支付时可以进行配送
        if(state.equals(StaticConfig.ORDER_ALREADY_PAY)){
            ChangeOrderState changeOrderState=new ChangeOrderState() ;
            changeOrderState.setOrderID(orderID);
            changeOrderState.setState(StaticConfig.ORDER_IN_DELIVERY);
            orderMapper.ChangeOS(changeOrderState);
            return true;
        }
        else{
            return false;
        }
    }

    //商家送达订单(订单完成 状态更改为未评论,菜品销量改变）
    public boolean Arrive(int orderID){
        String state=orderMapper.ResOrderRej(orderID);
        if(state.equals(StaticConfig.ORDER_IN_DELIVERY)){
            //订单状态更改
            ChangeOrderState changeOrderState=new ChangeOrderState();
            changeOrderState.setOrderID(orderID);
            changeOrderState.setState(StaticConfig.ORDER_NO_REVIEW);
            orderMapper.ChangeOS(changeOrderState);
            //菜品销量更改
            List<OrderDishes>orderDishes=OrderAllDish(orderID);
            for(int i=0;i<orderDishes.size();i++){
                int saleAmount=orderDishes.get(i).getSaleAmount();
                int count=orderDishes.get(i).getCount();
                int remain=orderDishes.get(i).getRemain();
                orderDishes.get(i).setSaleAmount(saleAmount+count);
                orderDishes.get(i).setRemain(remain-count);
                orderMapper.SaleRemainChange(orderDishes.get(i));
            }
            return true;
        }else{
            return false;
        }
    }
    //消费者对订单进行评价
    public void AddReview(Review review,int orderID){
        orderMapper.AddReview(review);
        //更改订单状态
        Map<String,String> condition = new HashMap<>();
        condition.put("orderID",String.valueOf(orderID));
        condition.put("state",StaticConfig.ORDER_ALREADY_REVIEW);
        orderMapper.changeOrderState(condition);
    }


    //查找一个订单的全部菜品信息（菜品名，数量，价格等）
    public List<OrderDishes>OrderAllDish(int orderID){
        List<OrderItem>Items=orderMapper.OrderItem(orderID);
        List<OrderDishes>dishes=new ArrayList<OrderDishes>();
        for(int i=0;i<Items.size();i++){
            int num=Items.get(i).getCount();//菜品数量
            Dish dish=orderMapper.ItemToDish(Items.get(i));
            OrderDishes orderDishes=new OrderDishes();
            orderDishes.setDishID(dish.getDishID());
            orderDishes.setDishTypeID(dish.getDishTypeID());
            orderDishes.setDescription(dish.getDescription());
            orderDishes.setPrice(dish.getPrice());
            orderDishes.setName(dish.getName());
            orderDishes.setResID(dish.getResID());
            orderDishes.setDiscount(dish.getDiscount());
            orderDishes.setScore(dish.getScore());
            orderDishes.setSaleAmount(dish.getSaleAmount());
            orderDishes.setRemain(dish.getRemain());
            orderDishes.setCount(num);
            dishes.add(orderDishes);
        }
        return dishes;
    }

    @Override
    public QueryOrderFullDetail getOrderFullDetail(int orderID) {
        return orderMapper.queryOrderFullDetail(orderID);
    }

    @Override
    public double gainFromOneOrder(int orderID) {
        QueryOrderFullDetail orderFullDetail=this.getOrderFullDetail(orderID);
        double totalPrice=0;
        for(ExtendOrderItem dish : orderFullDetail.getOrderItems())
            totalPrice+=dish.getItemPrice();
        return totalPrice;
    }

    @Override
    public void updateDishInfo(List<ExtendOrderItem> listOfItem) {
//        对每一个订单项都对菜品的数量进行更改，对其销售金额
        for(ExtendOrderItem orderItem : listOfItem){
            Map<String,String> condition = new HashMap<>();
//            更新菜品的余量以及菜品的销售数量
//            销售量增加，余量减少
            condition.put("dishID",String.valueOf(orderItem.getOrderedDish().getDishID()));
            condition.put("count",String.valueOf(orderItem.getCount()));
            orderMapper.updateSingleDishInfo(condition);
        }
    }

    @Override
    public List<Orders> queryDeliveryOrder(int userID) {
        return orderMapper.queryDeliveryOrder(userID);
    }

    @Override
    public List<Orders> queryNoReviewOrder(int userID) {
        return orderMapper.queryNoReviewOrder(userID);
    }

    @Override
    public List<Orders> queryAlreadyPayOrder(int userID) {
        return orderMapper.queryAlreadyPayOrder(userID);
    }


}