package cn.edu.njust.entity;

import java.io.Serializable;

public class DishType implements Serializable {
    private int dishTypeID;
    private String dishTypeName;

    public int getDishTypeID() {
        return dishTypeID;
    }

    public void setDishTypeID(int dishTypeID) {
        this.dishTypeID = dishTypeID;
    }

    public String getDishTypeName() {
        return dishTypeName;
    }

    public void setDishTypeName(String dishTypeName) {
        this.dishTypeName = dishTypeName;
    }
}
