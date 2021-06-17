package test.ManagerTest;

import cn.edu.njust.entity.Restaurant;
import cn.edu.njust.mapper.ManagerMapper;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;


public class ManagerTest3 {
    //    spring+springMVC环境
    private ApplicationContext applicationContext ;
    //    加载spring配置文件
    @Before
    public void setup()throws Exception{
        applicationContext=new ClassPathXmlApplicationContext("classpath:spring/beans.xml");
    }

    @Test
    public void method(){
        ManagerMapper managerMapper=(ManagerMapper)applicationContext.getBean("managerMapper");
        Restaurant restaurant=managerMapper.queryOneNotAccepted("1000000064");
        System.out.println("未经过审批的餐馆："+restaurant.getName());
    }
}
