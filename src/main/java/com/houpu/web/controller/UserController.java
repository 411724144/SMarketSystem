package com.houpu.web.controller;

import com.github.pagehelper.PageInfo;
import com.houpu.entity.PageBean;
import com.houpu.entity.User;
import com.houpu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("/toUserAddPage")
    public String toUserAddPage(){
        return "user/user_add";
    }

    @RequestMapping("/addUser")
    public String addUser(User user,HttpSession session){
        //获取当前用户
        User user1 = (User) session.getAttribute("user");
        user.setCreatedBy(user1.getId());
        userService.add(user);
        return "redirect:/user/findAll";
    }


    @RequestMapping("/login")
    public String login(String userCode, String userPassword, Model model, HttpSession session){

        User user = userService.login(userCode,userPassword);

        if (user!=null){
            user.setUserPassword("");
            session.setAttribute("user",user);
            //重定向到查找所有用户
            return "redirect:/user/findAll";
        }else {
            model.addAttribute("loginError","用户名或密码错误！");
            return "forward:/login.jsp";
        }
    }

    //查询所有
    @RequestMapping("/findAll")
    public String findAll(@RequestParam(defaultValue = "1") String pageNum,
                          @RequestParam(defaultValue = "5") String pageSize,
                          @RequestParam(required = false) String userName,
                          @RequestParam(required = false) String roleId,
                          Model model){
        Integer num = Integer.parseInt(pageNum);
        Integer size = Integer.parseInt(pageSize);
        //判断roleId是否为空
        Integer role_id =null;
        if (roleId!=null && roleId!=""){
           role_id = Integer.parseInt(roleId);
            if (role_id == 0){
                role_id = null;
            }
        }
        //获取分页对象
        PageInfo<User> pageBean = userService.findByPage(num,size,userName,role_id);
        //存储request域对象中
        model.addAttribute("pageBean",pageBean);
        model.addAttribute("userName",userName);
        model.addAttribute("roleId",role_id);
        return "/user/user_list";
    }

    //用户退出
    @RequestMapping("/logout")
    public String logout(HttpSession session){
        //清除用户信息
        session.removeAttribute("user");
        return "redirect:/login.jsp";
    }

    //注册
    @RequestMapping("/register")
    public String register(MultipartFile imgFile, User user, Model model){
        try {
            File file = null;
            if (imgFile!=null){
                file = new File("G:/IMG/");
                if (!file.exists()){
                    file.mkdirs();
                }
                //指定文件名
                String newFileName =UUID.randomUUID()+imgFile.getOriginalFilename();
                //获取图片的类型
                String type = newFileName.indexOf(".") != -1 ? newFileName.substring(newFileName.lastIndexOf(".") + 1, newFileName.length()) : null;
                //如果为空
                if (type!=null){
                    //只接受图片
                    if ("GIF".equals(type.toUpperCase()) || "PNG".equals(type.toUpperCase()) || "JPG".equals(type.toUpperCase())){
                        //文件上传
                        imgFile.transferTo(new File(file,newFileName));
                        //文件地址添加到user对象中
                        user.setPhoto(newFileName);
                    }else {
                        model.addAttribute("loginError","文件类型只能接收图片！");
                        return "forward:/register.jsp";
                    }
                }
            }
            //添加用户
            userService.add(user);
            return "redirect:/login.jsp";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("loginError","注册失败！");
            return "forward:/register.jsp";
        }
    }


    @RequestMapping("/view")
    public String view(String id, Model model,String type){
        //转化
        int i = Integer.parseInt(id);
        //查找用户
        User user = userService.findById(i);
        model.addAttribute("user2",user);
        if ("update".equals(type)){
            return "forward:/WEB-INF/pages/user/user_update.jsp";
        }else {
            return "forward:/WEB-INF/pages/user/userview.jsp";
        }
    }

    @RequestMapping("/update")
    public String update(User user,HttpSession session){

        //获取当前登录用户信息
        User user1 = (User) session.getAttribute("user");
        user.setModifyBy(user1.getId());
        userService.update(user);
        return "redirect:/user/findAll";
    }

    //删除用户
    @RequestMapping("/delete")
    public String delete(String id){
        userService.delete(Integer.parseInt(id));
        return "redirect:/user/findAll";
    }


    @RequestMapping("/toPwdModify")
    public String toPwdModify(){
        return "/user/userPwdmodify";
    }

    //根据id查找用户信息
    @RequestMapping("/findById")
    @ResponseBody
    public User findById(String id){
        User user = userService.findById(Integer.parseInt(id));
        return user;
    }

    //更新密码
    @RequestMapping("/updatePwd")
    public String updatePwd(String id,String newPwd){
        userService.updatePwd(Integer.parseInt(id),newPwd);
        return "redirect:/login.jsp";
    }

    //根据用户编号查询数据
    @RequestMapping("/findByUserCode")
    @ResponseBody
    public String findByUserCode(String userCode){

        User user = userService.findByUserCode(userCode);

        if (user!=null){
            return "1";
        }else {
            return "2";
        }

    }
}