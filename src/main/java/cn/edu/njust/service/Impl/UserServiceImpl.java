package cn.edu.njust.service.Impl;

import cn.edu.njust.entity.Review;
import cn.edu.njust.entity.Users;
import cn.edu.njust.mapper.UserMapper;
import cn.edu.njust.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public Users selectByName(String userName) {
        return userMapper.selectByName(userName);
    }

    @Override
    public Users findById(int id) {
        return userMapper.selectById(id);
    }

//    用户更新头像
    @Override
    public void updateAvatar(int id, String avatar) {
        Users users=new Users();
        users.setUserID(id);
        users.setAvatar(avatar);
        userMapper.updateAvatar(users);
    }

    @Override
    public void updateAllInfo(Users users) {
         userMapper.updateAllInfo(users);
    }

    @Override
    public Users findUserByPhone(String phoneNum) {
        return userMapper.selectByPhone(phoneNum);
    }

    @Override
    public void makeReview(Review review) {
        userMapper.makeReview(review);
    }

    @Override
    public void create(Users users) {
            userMapper.insertUser(users);
    }

    @Override
    public void delete(int id) {
        userMapper.deleteAUser(id);
    }

    @Override
    public void update(Users users) {

    }

    @Override
    public List<Users> findAll() {
        return null;
    }

}
