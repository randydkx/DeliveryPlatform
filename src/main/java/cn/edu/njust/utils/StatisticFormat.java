package cn.edu.njust.utils;

import javax.persistence.criteria.CriteriaBuilder;
import java.util.*;

public class StatisticFormat {
    public static String translate(Map<String,Integer> map){
        if(map==null)return null;
        if(map.size()==0)return null;
        Iterator i=map.entrySet().iterator();
        List<String> allKeys=new ArrayList<>();
        List<Integer> allValues = new ArrayList<>();
        String init = "[";
            while(i.hasNext()){
                Map.Entry entry=(Map.Entry)i.next();
                allKeys.add((String) entry.getKey());
                allValues.add((Integer)entry.getValue());
            }
            int size=allKeys.size();
            for(int j=0;j<size-1;j++){
                init=init+"['"+allKeys.get(j).toString()+"',"+allValues.get(j).toString()+"],";
            }
            init=init+"['"+allKeys.get(size-1).toString()+"',"+allValues.get(size-1).toString()+"]]";
        System.out.println("map转换："+init);
        return init;
    }
    public static String translate2(Map<Integer, Integer> map){
        if(map==null)return null;
        Iterator i=map.entrySet().iterator();
        List<Integer> allKeys=new ArrayList<>();
        List<Integer> allValues = new ArrayList<>();
        String init = "[";
        while(i.hasNext()){
            Map.Entry entry=(Map.Entry)i.next();
            allKeys.add( (Integer) entry.getKey());
            allValues.add( (Integer) entry.getValue());
        }
        int size=allKeys.size();
        for(int j=0;j<size-1;j++){
            init=init+"['"+allKeys.get(j).toString()+"',"+allValues.get(j).toString()+"],";
        }
        init=init+"['"+allKeys.get(size-1).toString()+"',"+allValues.get(size-1).toString()+"]]";
        System.out.println("map转换："+init);
        return init;
    }
    public static String translate3(Map<Integer, Double> map){
        if(map==null)return null;
        Iterator i=map.entrySet().iterator();
        List<Integer> allKeys=new ArrayList<>();
        List<Double> allValues = new ArrayList<>();
        String init = "[";
        while(i.hasNext()){
            Map.Entry entry=(Map.Entry)i.next();
            allKeys.add( (Integer) entry.getKey());
            allValues.add( (Double) entry.getValue());
        }
        int size=allKeys.size();
        for(int j=0;j<size-1;j++){
            init=init+"['"+allKeys.get(j).toString()+"',"+allValues.get(j).toString()+"],";
        }
        init=init+"['"+allKeys.get(size-1).toString()+"',"+allValues.get(size-1).toString()+"]]";
        System.out.println("map转换："+init);
        return init;
    }

    public static String translate4(Map<String,Double> map){
        if(map==null)return null;
        if(map.size()==0)return null;
        Iterator i=map.entrySet().iterator();
        List<String> allKeys=new ArrayList<>();
        List<Double> allValues = new ArrayList<>();
        String init = "[";
        while(i.hasNext()){
            Map.Entry entry=(Map.Entry)i.next();
            allKeys.add((String) entry.getKey());
            allValues.add((Double)entry.getValue());
        }
        int size=allKeys.size();
        for(int j=0;j<size-1;j++){
            init=init+"['"+allKeys.get(j)+"',"+allValues.get(j).toString()+"],";
        }
        init=init+"['"+allKeys.get(size-1)+"',"+allValues.get(size-1).toString()+"]]";
        System.out.println("map转换："+init);
        return init;
    }
}
