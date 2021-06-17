package cn.edu.njust.entity;


import java.sql.Timestamp;

//餐馆数据分析查询实体
public class QueryStatisticInfo {
    private Timestamp startTime;
    private Timestamp endTime;
    private String resID;

    public Timestamp getStartTime() {
        return startTime;
    }

    public void setStartTime(Timestamp startTime) {
        this.startTime = startTime;
    }

    public Timestamp getEndTime() {
        return endTime;
    }

    public void setEndTime(Timestamp endTime) {
        this.endTime = endTime;
    }

    public String getResID() {
        return resID;
    }

    public void setResID(String resID) {
        this.resID = resID;
    }
}
