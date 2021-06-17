package test.RestTest;

import cn.edu.njust.entity.Dish;
import cn.edu.njust.entity.QueryReview;
import cn.edu.njust.mapper.DishMapper;
import cn.edu.njust.mapper.RestMapper;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class QueryReviews {
    private ApplicationContext applicationContext ;
    //    加载spring配置文件
    @Before
    public void setup()throws Exception{
        applicationContext=new ClassPathXmlApplicationContext("classpath:spring/beans.xml");
    }

    @Test
    public void method(){
        DishMapper dishMapper=(DishMapper)applicationContext.getBean("dishMapper");
        RestMapper restMapper=(RestMapper)applicationContext.getBean("restMapper");
        List<QueryReview> list=restMapper.FindResReview("1000000992");
    }
}
