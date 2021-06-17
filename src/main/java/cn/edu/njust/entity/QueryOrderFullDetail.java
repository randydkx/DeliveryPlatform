package cn.edu.njust.entity;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

//订单的详细信息
public class QueryOrderFullDetail implements Serializable {
    private int orderID;
    private int userID;
    private String resID;
    private Date orderTime;
    private String state;
    private double totalMoney;
    //    扩展订单项，包括订单的菜品，可直接计算单项的价格
    private List<ExtendOrderItem> orderItems;
//    一个订单包含的用户的信息，在餐馆查看订单的时候需要使用
    private Users user;

    public Users getUser() {
        return user;
    }

    public void setUser(Users user) {
        this.user = user;
    }

    public double getTotalMoney() {
        return totalMoney;
    }

    public void setTotalMoney(double totalMoney) {
        this.totalMoney = totalMoney;
    }


    public List<ExtendOrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<ExtendOrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getResID() {
        return resID;
    }

    public void setResID(String resID) {
        this.resID = resID;
    }

    public Date getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(Date orderTime) {
        this.orderTime = orderTime;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }
}
