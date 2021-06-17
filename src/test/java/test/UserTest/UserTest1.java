package test.UserTest;

import cn.edu.njust.entity.Users;
import cn.edu.njust.mapper.UserMapper;
import cn.edu.njust.service.UserService;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class UserTest1 {
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
        Users users =userMapper.selectById(1);
        System.out.println(users.getAddress());
    }
}
