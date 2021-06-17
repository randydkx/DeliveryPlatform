package test.DishTest;

import cn.edu.njust.entity.Dish;
import cn.edu.njust.mapper.DishMapper;
import cn.edu.njust.mapper.OrderMapper;
import com.github.pagehelper.Page;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DishTest {
    private ApplicationContext applicationContext ;
    //    加载spring配置文件
    @Before
    public void setup() {
        applicationContext=new ClassPathXmlApplicationContext("classpath:spring/beans.xml");
    }

    @Test
    public void method(){
        DishMapper dishMapper=(DishMapper)applicationContext.getBean("dishMapper");
        OrderMapper orderMapper = (OrderMapper)applicationContext.getBean("orderMapper");
        Map<String,String> con=new HashMap<String,String>();
////        con.put("dishID","16");
//        con.put("resTypeID","5");
//        Page<Dish> list=dishMapper.findByPage(con);
//        for(int i=0;i<list.size();i++){
//            System.out.println(list.get(i).getDescription());
//        }
        con.put("dishID",String.valueOf(1));
        con.put("count",String.valueOf(10));
        orderMapper.updateSingleDishInfo(con);
    }
}
