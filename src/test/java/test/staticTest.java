package test;

import cn.edu.njust.utils.DateTool;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.apache.ibatis.ognl.IntHashMap;

import javax.persistence.criteria.CriteriaBuilder;
import java.sql.Timestamp;
import java.util.Map.*;
import java.util.*;

import static jdk.nashorn.internal.objects.Global.print;

public class staticTest {
    public static void main(String[] args) {
//        测试json数据的转换
        Map<String,Integer> map = new HashMap<>();
        map.put("first",3432);
        map.put("second",43242);
        Map<Object,Object> result=new HashMap<>();
        result.put("current",map);
        List<String> list=new ArrayList<>();
        list.add("324");
        list.add("r3r2");
        System.out.println(JSONObject.toJSON(result).toString());
        System.out.println(JSONObject.toJSON(list).toString());

        Map<String, Integer> cur=new HashMap<>();
        cur.put("宋涛",120);
        cur.put("王安文",111);
        cur.put("罗文水",234);
        List<String> keys=new ArrayList<>();
        List<Integer> values=new ArrayList<>();
        JSON json=JSON.parseObject(JSONObject.toJSON(cur).toString());
        System.out.println(json);

//       将map中的键值对分别分装在两个list中
        Iterator i =cur.entrySet().iterator();
        while(i.hasNext()){
            Entry entry=(Entry)i.next();
            String key=(String)entry.getKey();
            Integer value=(Integer)entry.getValue();
            keys.add(key);
            values.add(value);
        }
        System.out.println("键："+JSONObject.toJSON(keys).toString());
        System.out.println("值："+JSONObject.toJSON(values).toString());

        Map<String, Integer> testMap=new HashMap<>();
        testMap.put("罗文水",1213);
        testMap.put("宋涛",1323);
        testMap.put("王安文",4324);

         i=testMap.entrySet().iterator();
        List<String> allKeys=new ArrayList<>();
        List<Integer> allValues = new ArrayList<>();
        while(i.hasNext()){
            Map.Entry entry=(Map.Entry)i.next();
            allKeys.add((String) entry.getKey());
            allValues.add((Integer)entry.getValue());
        }

        String init = "[";
        int size=allKeys.size();
        for(int j=0;j<size-1;j++){
            init=init+"['"+allKeys.get(j)+"',"+allValues.get(j).toString()+"],";
        }
        init=init+"['"+allKeys.get(size-1)+"',"+allValues.get(size-1).toString()+"]]";
        System.out.println(init);
//        Timestamp time = new Timestamp(new Date().getTime());
//        System.out.println(time);
//
//        System.out.println();
//        System.out.println(new Timestamp(new Date().getTime()).toString());
//        DateTool.Date2Str(new Timestamp().toString(),"yyyy-MM-dd HH:mm:ss");
    }
}
