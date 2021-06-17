package cn.edu.njust.entity;

import java.util.List;

public class DishQryModel {
    List<ExtendOrderItem> dishes;

    public List<ExtendOrderItem> getDishes() {
        return dishes;
    }

    public void setDishes(List<ExtendOrderItem> orderItems) {
        this.dishes = orderItems;
    }
}
