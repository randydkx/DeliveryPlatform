package cn.edu.njust.entity;

import java.io.Serializable;

public class QueryOrder implements Serializable {
    //餐馆或消费者查找订单（已完成、未完成，两种情形下设置不同的state）

    String ID;
    String state1;
    String state2;
    String state3;

    public String ID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public String getState1() {
        return state1;
    }

    public void setState1(String state1) {
        this.state1 = state1;
    }

    public String getState2() {
        return state2;
    }

    public void setState2(String state2) {
        this.state2 = state2;
    }

    public String getState3() {
        return state3;
    }

    public void setState3(String state3) {
        this.state3 = state3;
    }
}