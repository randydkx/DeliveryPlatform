package cn.edu.njust.entity;

import java.io.Serializable;
import java.util.Date;

public class Dish implements Serializable {
    private int dishID;
    private int dishTypeID;
    private int remain;
    private String description;
    private Date startTime;
    private double price;
    private String name;
    private String resID;
    private String image;
    private double discount;
    private int saleAmount;
    private int score;

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public double getPrice(){return price;}
    public void setPrice(double price){this.price=price;}
    public int getDishID() {
        return dishID;
    }

    public void setDishID(int dishID) {
        this.dishID = dishID;
    }

    public int getDishTypeID() {
        return dishTypeID;
    }

    public void setDishTypeID(int dishTypeID) {
        this.dishTypeID = dishTypeID;
    }

    public int getRemain() {
        return remain;
    }

    public void setRemain(int remain) {
        this.remain = remain;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getResID() {
        return resID;
    }

    public void setResID(String resID) {
        this.resID = resID;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public int getSaleAmount() {
        return saleAmount;
    }

    public void setSaleAmount(int saleAmount) {
        this.saleAmount = saleAmount;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }
}
