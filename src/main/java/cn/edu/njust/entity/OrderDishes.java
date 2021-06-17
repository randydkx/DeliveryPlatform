package cn.edu.njust.entity;

//一次订单中的总金额
public class OrderDishes extends Dish {
    private int count; //订单中该菜品的数量

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
    //获取该菜品的总价格
    public double totalPrice(){
        return this.getPrice()*count;
    }
}
