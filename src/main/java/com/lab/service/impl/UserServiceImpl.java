package com.lab.service.impl;

import com.lab.entity.User;
import com.lab.mapper.UserMapper;
import com.lab.service.BorrowService;
import com.lab.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private BorrowService borrowService;

    // 自定义 MD5 加密方法
    private String md5(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(input.getBytes());
            BigInteger no = new BigInteger(1, messageDigest);
            StringBuilder hashText = new StringBuilder(no.toString(16));
            while (hashText.length() < 32) {
                hashText.insert(0, "0");
            }
            return hashText.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean register(User user) {
        // 1. 检查用户名是否已存在
        User existUser = userMapper.findByUsername(user.getUsername());
        if (existUser != null) {
            return false;
        }
        // 2. 密码加密（MD5）
        user.setPassword(md5(user.getPassword()));
        // 3. 默认角色为USER
        if (user.getRole() == null) {
            user.setRole("USER");
        }
        // 4. 插入数据库
        return userMapper.register(user) > 0;
    }

    @Override
    public User login(String username, String password) {
        // 1. 查询用户
        User user = userMapper.findByUsername(username);
        // 2. 验证密码
        if (user != null && md5(password).equals(user.getPassword())) {
            return user;
        }
        return null;
    }

    @Override
    public User findById(Integer id) {
        return userMapper.findById(id);
    }

    @Override
    public boolean updateUser(User user) {
        // 1. 检查用户名是否被其他用户使用
        User existUser = userMapper.findByUsername(user.getUsername());
        if (existUser != null && !existUser.getId().equals(user.getId())) {
            return false;
        }
        // 2. 密码加密（MD5）
        user.setPassword(md5(user.getPassword()));
        // 3. 更新数据库
        return userMapper.update(user) > 0;
    }

    @Override
    public List<User> findAll() {
        return userMapper.findAll();
    }

    @Override
    public boolean deleteUser(Integer id) {
        // 检查该用户是否有未归还的借阅记录
        if (borrowService.hasUnreturnedBorrows(id)) {
            throw new RuntimeException("存在未归还记录，不可删除");
        }
        // 执行删除操作
        return userMapper.delete(id) > 0;
    }
}
