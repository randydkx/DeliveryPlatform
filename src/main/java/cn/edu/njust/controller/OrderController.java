package cn.edu.njust.controller;
import cn.edu.njust.entity.OrderItem;
import cn.edu.njust.entity.Orders;
import cn.edu.njust.entity.Review;
import cn.edu.njust.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping(value = "/order")
public class OrderController {
    @Autowired
    private OrderService orderService;


    //创建订单 传入用户ID，餐馆ID，和订单项List,订单项只需要dishID和count
    @RequestMapping(value = "/AddNewOrder")
    public void AddNewOrder(@RequestParam  int userID,@RequestParam String resID,@RequestParam List<OrderItem> Items){
        Orders orders=new Orders();
        orders.setUserID(userID);
        orders.setResID(resID);
        orders.setState("nopay");
        orders.setOrderTime(new Date());
        orderService.AddNewOrder(orders,Items);
    }

    //支付订单 传入订单实体order即可
    @RequestMapping(value = "/PayForOrder")
    public void PayForOrder(@RequestParam Orders orders){
        orderService.PayForOrder(orders);
    }

    //商家配送订单
    @RequestMapping(value = "/DeliveryOrder")
    public void DeliveryOrder(@RequestParam int OrderID){
        orderService.DeliverOrder(OrderID);
    }

    //商家送达订单
    @RequestMapping(value = "/Arrive")
    public void Arrive(@RequestParam int OrderID){
        orderService.Arrive(OrderID);
    }

    //消费者对订单评价
    @RequestMapping(value = "/AddReview")
    public String  AddReview(@RequestParam Review review,@RequestParam int orderID){
        orderService.AddReview(review,orderID);
        //评价完后跳转到历史订单页面
        return "page/test";
    }

}