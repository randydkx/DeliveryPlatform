package cn.edu.njust.entity;


import java.io.Serializable;

public class ExtendOrderItem extends OrderItem implements Serializable {
    private Dish orderedDish;

    public Dish getOrderedDish() {
        return orderedDish;
    }

    public void setOrderedDish(Dish orderedDish) {
        this.orderedDish = orderedDish;
    }
//获取当前订单项的单项价格
    public double getItemPrice(){
        return this.orderedDish.getPrice()*
                this.orderedDish.getDiscount()*this.getCount()/10;
    }
}
