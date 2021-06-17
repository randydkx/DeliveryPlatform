package test.ManagerTest;

import cn.edu.njust.entity.Manager;
import cn.edu.njust.entity.Restaurant;
import cn.edu.njust.mapper.ManagerMapper;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

public class ManagerTest1 {
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
        Manager manager = managerMapper.selectByID("M-17851093886");
        System.out.println("manager信息："+manager.getAccountID());

//        测试列出所有manager自己通过的餐馆的信息
        List<Restaurant> listAccepted = managerMapper.listAllAcceptedRest("M-17851093886");
        for(int i=0;i<listAccepted.size();i++){
            System.out.println(listAccepted.get(i).getName());
        }

    }
}
