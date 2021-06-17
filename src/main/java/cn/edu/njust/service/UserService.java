package cn.edu.njust.service;

import cn.edu.njust.entity.Review;
import cn.edu.njust.entity.Users;



public interface UserService extends BaseService<Users> {
//    通过name查找用户
    Users selectByName(String userName);
//    通过id查找用户
    Users findById(int id);
//    通过userID修改头像
    void updateAvatar(int id,String avatar);
//    更新用户所有信息
    void updateAllInfo(Users users);
//    通过phoneNum查找用户
    Users findUserByPhone(String phoneNum);
//    用户做出一条评论
    void makeReview(Review review);
}