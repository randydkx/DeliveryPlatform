package test.UserTest;
import cn.edu.njust.entity.Review;
import cn.edu.njust.mapper.UserMapper;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import java.sql.Timestamp;
import java.util.Date;


public class UserTest2 {
    private ApplicationContext applicationContext ;
    @Before
    public void setup()throws Exception{
//        加载环境
        applicationContext=new ClassPathXmlApplicationContext("classpath:spring/beans.xml");
    }
    @Test
    public void method(){
//        获取userMapper的bean实体实例对象
        UserMapper userMapper=(UserMapper) applicationContext.getBean("userMapper");
        Review review=new Review();
        review.setContent("这家菜馆的菜很好吃");
        review.setResID("1000000032");
        review.setUserID(3);
        review.setTime(new Timestamp(new Date().getTime()));
        userMapper.makeReview(review);
        Timestamp time=new Timestamp(new Date().getTime());
    }
}
