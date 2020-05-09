package com.houpu.service;

import com.github.pagehelper.PageInfo;
import com.houpu.entity.PageBean;
import com.houpu.entity.User;

public interface UserService {
    User login(String userCode, String userPassword);

    PageInfo<User> findByPage(Integer num, Integer size, String userName, Integer role_Id);

    void add(User user);

    User findById(Integer id);

    void update(User user);

    void delete(Integer id);

    void updatePwd(int parseInt, String newPwd);

    User findByUserCode(String userCode);
}
