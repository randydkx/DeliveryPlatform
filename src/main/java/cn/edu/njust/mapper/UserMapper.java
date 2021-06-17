package cn.edu.njust.mapper;
import cn.edu.njust.entity.Review;
import cn.edu.njust.entity.Users;

import java.util.Map;

public interface UserMapper {
    Users selectByName(String userName);
    void insertUser(Users users);
    void updateAvatar(Users user);
    Users selectById(int id);
    void updateAllInfo(Users users);
    Users selectByPhone(String phoneNum);
    void makeReview(Review review);
    void deleteAUser(int userID);
    void updateScore(Map<String,String> condition);
}
