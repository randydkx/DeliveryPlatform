package cn.edu.njust.entity;

import java.io.Serializable;

public class OrderItem implements Serializable {
    private int orderItemID;
    private int dishID;
    private int orderID;
    private int count;

    public int getOrderItemID() {
        return orderItemID;
    }

    public void setOrderItemID(int orderDishID) {
        this.orderItemID = orderDishID;
    }

    public int getDishID() {
        return dishID;
    }

    public void setDishID(int dishID) {
        this.dishID = dishID;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
}
