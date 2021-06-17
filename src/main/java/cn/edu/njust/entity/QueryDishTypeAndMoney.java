package cn.edu.njust.entity;

import java.io.Serializable;

public class QueryDishTypeAndMoney implements Serializable {
    private String resID;
    private String dishTypeName;
    private double moneyToOneDishType;
    private int countToOneDishType;

    public int getCountToOneDishType() {
        return countToOneDishType;
    }

    public void setCountToOneDishType(int countToOneDishType) {
        this.countToOneDishType = countToOneDishType;
    }

    public String getResID() {
        return resID;
    }

    public void setResID(String resID) {
        this.resID = resID;
    }

    public String getDishTypeName() {
        return dishTypeName;
    }

    public void setDishTypeName(String dishTypeName) {
        this.dishTypeName = dishTypeName;
    }

    public double getMoneyToOneDishType() {
        return moneyToOneDishType;
    }

    public void setMoneyToOneDishType(double moneyToOneDishType) {
        this.moneyToOneDishType = moneyToOneDishType;
    }
}
