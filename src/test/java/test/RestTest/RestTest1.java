package test.RestTest;

import cn.edu.njust.entity.Dish;
import cn.edu.njust.entity.Restaurant;
import cn.edu.njust.mapper.RestMapper;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.Date;
import java.util.List;

public class RestTest1 {


    private ApplicationContext applicationContext ;
    //    加载spring配置文件
    @Before
    public void setup()throws Exception{
        applicationContext=new ClassPathXmlApplicationContext("classpath:spring/beans.xml");
    }
    @Test
    public void method(){
//      获取restmapper的实例，与mapper对应，首字母小写
        RestMapper restMapper=(RestMapper) applicationContext.getBean("restMapper");
//
//      Restaurant restaurant=new Restaurant();
//      restaurant.setResID("1000001152");
//      restaurant.setLocate("B三楼教师休息室");
//      restaurant.setName("宋涛餐馆");
//      restaurant.setPassword("123456");
//      restaurant.setStartTime(9);
//      restaurant.setEndTime(10);
//      restaurant.setAccountID("100000009");
//      restaurant.setResPhone("19825000441");
//      restaurant.setResTypeID(6);
//      restaurant.setManagerID("19825000668");
//      restMapper.ResRegister(restaurant);
//        String maxid=restMapper.MaxResID().getResID();
//        System.out.println(maxid);
    }

}
