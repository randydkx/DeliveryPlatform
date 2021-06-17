package test.DishTest;

import cn.edu.njust.entity.OrderItem;
import cn.edu.njust.entity.Orders;
import cn.edu.njust.mapper.OrderMapper;
import cn.edu.njust.utils.StaticConfig;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

//动态插入订单以及订单项的数据
public class InsertOrderAndDish {
    private ApplicationContext applicationContext ;
    //    加载spring配置文件
    @Before
    public void setup() {
        applicationContext=new ClassPathXmlApplicationContext("classpath:spring/beans.xml");
    }
    //生成随机时间的方法
    private static Date randomDate(String beginDate, String endDate) {
        try {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            Date start = format.parse(beginDate);// 构造开始日期
            Date end = format.parse(endDate);// 构造结束日期
            // getTime()表示返回自 1970 年 1 月 1 日 00:00:00 GMT 以来此 Date 对象表示的毫秒数。
            if (start.getTime() >= end.getTime()) {
                return null;
            }
            long date = random(start.getTime(), end.getTime());

            return new Date(date);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private static long random(long begin, long end) {
        long rtn = begin + (long) (Math.random() * (end - begin));
        // 如果返回的是开始时间和结束时间，则递归调用本函数查找随机值
        if (rtn == begin || rtn == end) {
            return random(begin, end);
        }
        return rtn;
    }

    String resID= StaticConfig.TEST_RES_ID;
    int userID=3;
    @Test
    public void method() {
        final int total = 10;

        OrderMapper orderMapper=(OrderMapper)applicationContext.getBean("orderMapper");
//                构造订单
        String startTime="2020-01-01";
        String endTime="2020-09-26";
        int initOrderID=orderMapper.maxOrderID();
        for (int i=0;i<total;i++){
            Timestamp time= new Timestamp(randomDate(startTime,endTime).getTime());
            String state=StaticConfig.ORDER_ALREADY_PAY;
//                构造订单项
            int start=1;
            int end=12;
            int countMax=5;
            int countMin=1;
            Random random=new Random();
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
            Orders orders=new Orders();
            orders.setOrderTime(time);
            orders.setResID(resID);
            orders.setState(state);
            orders.setUserID(userID);
            orderMapper.AddNewOrder(orders);
            initOrderID++;
            for(int j=0;j<3;j++){
                int dishID=(random.nextInt()%(end-start)+(end-start))%(end-start)+start;
                int count=(random.nextInt()%(countMax-countMin)+(countMax-countMin))%
                        (countMax-countMin)+countMin;
                OrderItem orderItem=new OrderItem();
                orderItem.setDishID(dishID);
                orderItem.setCount(count);
                System.out.println(orderItem.getCount());
                orderItem.setOrderID(initOrderID);
                orderMapper.AddOrderItem(orderItem);
            }
        }
    }
}
