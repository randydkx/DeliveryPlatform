package cn.edu.njust.entity;

import java.io.Serializable;

public class ChangeOrderState implements Serializable {
    int orderID;
    String state;

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }
}

