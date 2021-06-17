package test.RestTest;

import cn.edu.njust.entity.Orders;
import cn.edu.njust.entity.QueryStatisticInfo;
import cn.edu.njust.mapper.RestMapper;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import cn.edu.njust.utils.StaticConfig;
import java.sql.Timestamp;
import java.util.List;
import static cn.edu.njust.utils.DateTool.str2Date;

public class QueryStatisticInfo1 {
    private ApplicationContext applicationContext ;
    //    加载spring配置文件
    @Before
    public void setup()throws Exception{
        applicationContext=new ClassPathXmlApplicationContext("classpath:spring/beans.xml");
    }
    @Test
    public void method() {
//      获取restmapper的实例，与mapper对应，首字母小写
        RestMapper restMapper = (RestMapper) applicationContext.getBean("restMapper");
        QueryStatisticInfo statisticInfo=new QueryStatisticInfo();
        Timestamp startTime = new Timestamp(str2Date("2020-01-01",StaticConfig.TIME_PATTERN).getTime());
        Timestamp endTime=new Timestamp(str2Date("2020-02-01",StaticConfig.TIME_PATTERN).getTime());
        System.out.println("开始时间是："+startTime.toString());
        System.out.println("结束时间是："+endTime.toString());
        statisticInfo.setStartTime(startTime);
        statisticInfo.setEndTime(endTime);
        statisticInfo.setResID(StaticConfig.TEST_RES_ID);
        List<Orders> list = restMapper.salesInAMonth(statisticInfo);
        for(int i=0;i<list.size();i++){
            System.out.println(list.get(i).getOrderTime().toString());
        }
    }
}
