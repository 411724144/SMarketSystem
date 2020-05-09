package com.houpu.service.impl;

import com.houpu.entity.Role;
import com.houpu.mapper.RoleMappers;
import com.houpu.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleMappers roleMapper;

    @Override
    public List<Role> findAll() {
        return roleMapper.findAll();
    }
}
