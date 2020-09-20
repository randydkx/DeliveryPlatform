package cn.edu.njust.mapper;

import cn.edu.njust.entity.Users;

public interface UserMapper {
    public Users login(String userName);
    public void insertUser(Users users);
}
