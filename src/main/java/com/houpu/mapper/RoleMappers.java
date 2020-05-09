package com.houpu.mapper;

import com.houpu.entity.Role;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface RoleMappers {

    @Select("select * from t_role where id=#{id}")
    Role findRoleById(Integer id);

    @Select("select * from t_role")
    List<Role> findAll();
}
