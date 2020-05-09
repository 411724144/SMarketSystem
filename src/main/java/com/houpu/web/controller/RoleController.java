package com.houpu.web.controller;

import com.houpu.entity.Role;
import com.houpu.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private RoleService roleService;


    @RequestMapping("/findAll")
    @ResponseBody
    public List<Role> findAllAjax(){
        //查询
        List<Role> list = roleService.findAll();
        return list;
    }

}
