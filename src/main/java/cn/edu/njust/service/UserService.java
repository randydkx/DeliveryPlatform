package cn.edu.njust.service;

import cn.edu.njust.entity.Users;

import java.util.List;


public interface UserService extends BaseService<Users> {
    Users login(String userName);
}