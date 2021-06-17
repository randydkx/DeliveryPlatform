package test.OrderTest;

import cn.edu.njust.entity.Dish;
import cn.edu.njust.entity.QueryOrderFullDetail;
import cn.edu.njust.mapper.DishMapper;
import cn.edu.njust.mapper.OrderMapper;
import cn.edu.njust.mapper.RestMapper;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OrderWithAllDetailTest1 {
    //    spring+springMVC环境
    private ApplicationContext applicationContext ;
    //    加载spring配置文件
    @Before
    public void setup()throws Exception{
        applicationContext=new ClassPathXmlApplicationContext("classpath:spring/beans.xml");
    }


    @Test
    public void method(){
        OrderMapper orderMapper=(OrderMapper) applicationContext.getBean("orderMapper");
        DishMapper dishMapper=(DishMapper)applicationContext.getBean("dishMapper");
        RestMapper restMapper=(RestMapper)applicationContext.getBean("restMapper");
//        通过orderID查找所有对应的orderItem
        QueryOrderFullDetail detail = orderMapper.queryOrderFullDetail(2);
        double ans=new Double(0);
        double check=0;
        for(int i=0;i<detail.getOrderItems().size();i++){
            Dish dish = detail.getOrderItems().get(i).getOrderedDish();
            check+=dish.getDiscount()*dish.getPrice()*detail.getOrderItems().get(i).getCount()/10;
            ans+=detail.getOrderItems().get(i).getItemPrice();
        }
        System.out.println("函数计算得到："+ans);
        System.out.println("直接计算得到："+check);
////        查找宋涛犯的错误->0折？
        Map<String,String> con=new HashMap<>();
        con.put("discount","0");
        List<Dish> listOfDish=dishMapper.findByPage(con);
    }
}
