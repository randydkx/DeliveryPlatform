package cn.edu.njust.entity;
import java.util.Date;
public class Review {
    private int reviewID;
    private int userID;
    private String content;
    private Date time;
    private int resID;

    public int getReviewID() {
        return reviewID;
    }

    public void setReviewID(int reviewID) {
        this.reviewID = reviewID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public int getResID() {
        return resID;
    }

    public void setResID(int dishID) {
        this.resID = resID;
    }
}
