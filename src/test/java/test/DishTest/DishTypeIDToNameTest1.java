package test.DishTest;

import cn.edu.njust.entity.Dish;
import cn.edu.njust.entity.QueryDishTypeAndMoney;
import cn.edu.njust.mapper.DishMapper;
import cn.edu.njust.mapper.RestMapper;
import cn.edu.njust.utils.StaticConfig;
import com.github.pagehelper.Page;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.core.task.SimpleAsyncTaskExecutor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DishTypeIDToNameTest1 {
    private ApplicationContext applicationContext;
    //    加载spring配置文件
    @Before
    public void setup() {
        applicationContext=new ClassPathXmlApplicationContext("classpath:spring/beans.xml");
    }

    @Test
    public void method(){
        DishMapper dishMapper=(DishMapper)applicationContext.getBean("dishMapper");
        RestMapper restMapper=(RestMapper)applicationContext.getBean("restMapper");
//        查询一个商家的dishType和所对应的累计金额
        List<QueryDishTypeAndMoney> dishTypeAndMoney=restMapper.dishTypeAndMoney(StaticConfig.TEST_RES_ID);
        for(QueryDishTypeAndMoney item : dishTypeAndMoney){
            System.out.println(item.getDishTypeName()+" "+item.getMoneyToOneDishType()+" "
            +item.getCountToOneDishType());
        }
    }
}
