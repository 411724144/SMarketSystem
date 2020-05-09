package com.houpu.entity;

import org.springframework.stereotype.Controller;

import java.io.Serializable;
import java.util.List;

public class Role extends BaseEntity implements Serializable {
    private String roleCode;
    private String roleName;

    private List<User> userList;

    public String getRoleCode() {
        return roleCode;
    }

    public void setRoleCode(String roleCode) {
        this.roleCode = roleCode;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public List<User> getUserList() {
        return userList;
    }

    public void setUserList(List<User> userList) {
        this.userList = userList;
    }
}

