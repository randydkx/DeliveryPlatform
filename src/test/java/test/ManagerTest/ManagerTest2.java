package test.ManagerTest;

import cn.edu.njust.entity.Restaurant;
import cn.edu.njust.mapper.ManagerMapper;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;


public class ManagerTest2 {
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
        List<Restaurant> list= managerMapper.listAllNotAccepted();
        System.out.println("未审批的总数："+list.size());
        List<Restaurant> list1=managerMapper.listAllAcceptedRest("M-13218875296");
        System.out.println("审批过的总数："+list1.size());
    }
}
