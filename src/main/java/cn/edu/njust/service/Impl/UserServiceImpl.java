package cn.edu.njust.service.Impl;

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
    public Users login(String userName) {
        return userMapper.login(userName);
    }


    @Override
    public List<Users> findAll() {
        return null;
    }

    @Override
    public Users findById(Long id) {
        return null;
    }

    @Override
    public void create(Users users) {
            userMapper.insertUser(users);
    }

    @Override
    public void delete(Long id) {

    }

    @Override
    public void update(Users users) {

    }
}
