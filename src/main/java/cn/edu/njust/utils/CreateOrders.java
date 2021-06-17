package cn.edu.njust.utils;
import cn.edu.njust.utils.StaticConfig;
import cn.edu.njust.utils.DateTool;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

public class CreateOrders {
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

    String resID=StaticConfig.TEST_RES_ID;
    int userID=1;
    public static void main(String[] args) {
//                构造订单
//                String startTime="2020-01-01";
//                String endTime="2020-09-26";
//                Timestamp time= new Timestamp(randomDate(startTime,endTime).getTime());
//                String state=StaticConfig.ORDER_ALREADY_PAY;
////                构造订单项
//                int start=1;
//                int end=12;
//                int countMax=5;
//                int countMin=1;
//                Random random=new Random();
//                SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
//                String finalDat=sdf.format(randomDate(startTime,endTime));
//                for(int j=0;j<3;j++){
//                    int dishID=random.nextInt()%(end-start)+start;
//                    int count=random.nextInt()%(countMax-countMin)+countMin;
//                    System.out.println();
//                }
        Map map = new HashMap();
        map.put("msg", 1);//map里面装有yes
        Set<String> keys=map.keySet();
        Collection<Integer> values=map.values();
        JSON json = (JSON) JSONObject.toJSON(map);
        System.out.println(json.toJSONString());
    }
}
