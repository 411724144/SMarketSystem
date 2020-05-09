package com.houpu.mapper;

import com.houpu.entity.User;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface UserMapper {

    @Select("select * from t_user where userCode=#{userCode} and userPassword=#{userPassword}")
    User findByCodeAndPassword(@Param("userCode") String userCode,@Param("userPassword") String userPassword);

//    @Select("select count(id) from t_user")
    Integer findTotalCount(@Param("userName") String userName,@Param("roleId") Integer role_id);

//    @Select("select * from t_user limit #{index},#{size}")
    //多表关联查询
    List<User> findAll(@Param("userName") String userName,@Param("roleId") Integer role_id);

    void add(User user);

    User findById(Integer id);

    void update(User user);

    @Delete("delete from t_user where id=#{id}")
    void delete(Integer id);

    @Update("update t_user set userPassword=#{newPwd} where id=${id}")
    void updatePwd(@Param("id") int parseInt,@Param("newPwd") String newPwd);

    @Select("select * from t_user where userCode=#{userCode}")
    User findByUserCode(String userCode);
}