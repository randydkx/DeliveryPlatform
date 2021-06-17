package test.RestTest;

import cn.edu.njust.mapper.RestMapper;
import cn.edu.njust.utils.StaticConfig;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import java.util.List;

public class TestQueryDIshType {

    private ApplicationContext applicationContext ;
    //    加载spring配置文件
    @Before
    public void setup()throws Exception{
        applicationContext=new ClassPathXmlApplicationContext("classpath:spring/beans.xml");
    }
    @Test
    public void method(){
//      获取restmapper的实例，与mapper对应，首字母小写
        RestMapper restMapper=(RestMapper) applicationContext.getBean("restMapper");
        List<String> list=restMapper.distinctDishType(StaticConfig.TEST_RES_ID);
    }
}
