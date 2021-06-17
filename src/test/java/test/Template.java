package test;

import cn.edu.njust.entity.Users;
import cn.edu.njust.mapper.UserMapper;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class Template {
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
        UserMapper userMapper=(UserMapper) applicationContext.getBean("userMapper");
        Users users =new Users();
        users.setUserName("this");
        users.setPassword("fasdf");
        users.setAddress("fsadfas");
        users.setEmail("fasfsa");
        users.setAvatar("fasdf");
        users.setUserState("fasdf");
        users.setPhoneNum("fasdfas");
        users.setAccountID("100000000");
        users.setScore(0);
        userMapper.insertUser(users);
    }
}
