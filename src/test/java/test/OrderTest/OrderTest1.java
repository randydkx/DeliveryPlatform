package test.OrderTest;

import cn.edu.njust.entity.*;
import cn.edu.njust.mapper.OrderMapper;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;


public class OrderTest1 {
    //    spring+springMVC环境
    private ApplicationContext applicationContext ;
    //    加载spring配置文件
    @Before
    public void setup()throws Exception{
        applicationContext=new ClassPathXmlApplicationContext("classpath:spring/beans.xml");
    }

    @Test
    public void method(){
//      获取mapper的实例，与mapper对应，首字母小写
        OrderMapper orderMapper=(OrderMapper) applicationContext.getBean("orderMapper");
        OrderItem order=new OrderItem();
        order.setDishID(6);
        order.setOrderID(3);
        order.setCount(10);
        orderMapper.AddOrderItem(order);
    }
}
