package test.UserTest;

import cn.edu.njust.entity.Users;
import cn.edu.njust.mapper.UserMapper;
import cn.edu.njust.service.UserService;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class UserTest1 {
    public UserService userService;
    private ApplicationContext applicationContext ;
    @Before
    public void setup()throws Exception{
//        加载环境
        applicationContext=new ClassPathXmlApplicationContext("classpath:spring/beans.xml");
    }
    @Test
    public void testConn(){
//        获取userMapper的bean实体实例对象
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
