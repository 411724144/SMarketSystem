package com.houpu.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.houpu.entity.User;
import com.houpu.mapper.UserMapper;
import com.houpu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;


    @Override
    public User login(String userCode, String userPassword) {
        return userMapper.findByCodeAndPassword(userCode,userPassword);
    }

    @Override
    public PageInfo<User> findByPage(Integer num, Integer size, String userName, Integer role_id) {
        //开启分页
        PageHelper.startPage(num,size);
        //查询数据
        List<User> users = userMapper.findAll(userName,role_id);
        //返回数据
        return new PageInfo<User>(users);
    }

    @Override
    public void add(User user) {
        userMapper.add(user);
    }

    @Override
    public User findById(Integer id) {
        return userMapper.findById(id);
    }

    @Override
    public void update(User user) {
        userMapper.update(user);
    }

    @Override
    public void delete(Integer id) {
        userMapper.delete(id);
    }

    @Override
    public void updatePwd(int parseInt, String newPwd) {
        userMapper.updatePwd(parseInt,newPwd);
    }

    @Override
    public User findByUserCode(String userCode) {
        return userMapper.findByUserCode(userCode);
    }
}