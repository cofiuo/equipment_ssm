package com.lab.mapper;

import com.lab.entity.User;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface UserMapper {

    // 注册用户
    @Insert("INSERT INTO users(username, password, role) VALUES(#{username}, #{password}, #{role})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int register(User user);

    // 根据用户名查询用户
    @Select("SELECT * FROM users WHERE username = #{username}")
    User findByUsername(String username);

    // 根据ID查询用户
    @Select("SELECT * FROM users WHERE id = #{id}")
    User findById(Integer id);

    // 更新用户信息
    @Update("UPDATE users SET username = #{username}, password = #{password} WHERE id = #{id}")
    int update(User user);

    // 查询所有用户
    @Select("SELECT * FROM users")
    List<User> findAll();

    // 删除用户
    @Delete("DELETE FROM users WHERE id = #{id}")
    int delete(Integer id);
}