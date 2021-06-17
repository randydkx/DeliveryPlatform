package cn.edu.njust.entity;

import java.io.Serializable;

public class ResType implements Serializable {
    private int resTypeID;
    private String resTypeName;

    public int getResTypeID() {
        return resTypeID;
    }

    public void setResTypeID(int resTypeID) {
        this.resTypeID = resTypeID;
    }

    public String getResTypeName() {
        return resTypeName;
    }

    public void setResTypeName(String resTypeName) {
        this.resTypeName = resTypeName;
    }
}
