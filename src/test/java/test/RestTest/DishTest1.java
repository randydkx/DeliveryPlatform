package test.RestTest;

import cn.edu.njust.entity.Dish;
import cn.edu.njust.mapper.DishMapper;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DishTest1 {
    private ApplicationContext applicationContext ;
    //    加载spring配置文件
    @Before
    public void setup()throws Exception{
        applicationContext=new ClassPathXmlApplicationContext("classpath:spring/beans.xml");
    }

    @Test
    public void method(){
        DishMapper dishMapper=(DishMapper)applicationContext.getBean("dishMapper");
        Map<String,String> con=new HashMap<String,String>();
        con.put("name","招牌小馄饨");

        List<Dish> list=dishMapper.findByPage(con);
        for(int i=0;i<list.size();i++){
            System.out.println(list.get(i).getDescription());
        }
    }
}
