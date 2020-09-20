package cn.edu.njust.utils;
import java.text.SimpleDateFormat;
import java.util.Date;

//日期处理的工具
public class DateTool {
    /**
     * 把datetime转为Date类型
     */
    public static Date str2Date(String dateStr, String parttern) {
        SimpleDateFormat sdf = new SimpleDateFormat(parttern);
        Date date = null;
        try {
            sdf.parse(dateStr);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return date;
    }

    /**
     * 把java.util.Date类型转为datetime字符串
     */
    public static String Date2Str(Date date,String parttern) {
        SimpleDateFormat sdf=new SimpleDateFormat(parttern);
        String dateStr =null;
        try {
            dateStr = sdf.format(date);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dateStr;
    }


    public static void main(String[] args) throws Exception{
        System.out.println(Date2Str(new Date(), "yyyy-MM-dd"));
        System.out.println(Date2Str(new Date(),"yyyy-MM-dd  HH:mm:ss"));
    }

}

