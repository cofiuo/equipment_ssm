package com.lab.service;

import com.lab.entity.User;
import java.util.List;

public interface UserService {
    // 注册
    boolean register(User user);

    // 登录
    User login(String username, String password);

    // 根据ID查询用户
    User findById(Integer id);

    // 更新用户信息
    boolean updateUser(User user);
    
    // 查询所有用户
    List<User> findAll();
    
    // 删除用户
    boolean deleteUser(Integer id);
}
