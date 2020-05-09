package com.houpu.web.controller;

import com.github.pagehelper.PageInfo;
import com.houpu.entity.PageBean;
import com.houpu.entity.Provider;
import com.houpu.entity.User;
import com.houpu.service.ProviderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/provider")
public class ProviderController {
    @Autowired
    private ProviderService providerService;


    @RequestMapping("/findAllByPage")
    public String findAllByPage(@RequestParam(defaultValue = "1") String pageNum,
                                @RequestParam(defaultValue = "5") String pageSize,
                                @RequestParam(value = "proCode",required = false) String proCode,
                                @RequestParam(value = "proName",required = false) String proName,
                                Model model){
//        int i = 1/0;
        //类型转换
        Integer num = Integer.parseInt(pageNum);
        Integer size = Integer.parseInt(pageSize);

        PageInfo<Provider> pageBean = providerService.findAllByPage(num,size,proCode,proName);
        model.addAttribute("pageBean",pageBean);
        model.addAttribute("proCode",proCode);
        model.addAttribute("proName",proName);
        return "provider/providerlist";
    }

    @RequestMapping(value = "/add",method = RequestMethod.GET)
    public String toAddPage(){
        return "provider/provideradd";
    }

    @PostMapping("/add")
    public String add(Provider provider, HttpSession session){

        //获取当前用户
        User user = (User) session.getAttribute("user");
        provider.setCreatedBy(user.getId());
        providerService.add(provider);

        return "redirect:/provider/findAllByPage";
    }

    @RequestMapping(value = "/update",method = RequestMethod.GET)
    public String toUpdate(String id,Model model){

        //根据id查找当前用户信息
        Provider provider = providerService.findById(Integer.parseInt(id));
        model.addAttribute("provider",provider);
        return "/provider/provider_update";
    }

    @RequestMapping(value = "/update",method = RequestMethod.POST)
    public String update(Provider provider,HttpSession session){

        //获取当前用户
        User user = (User) session.getAttribute("user");
        provider.setModifyBy(user.getId());
        providerService.update(provider);

        return "redirect:/provider/findAllByPage";
    }

    @RequestMapping("/delete")
    public String delete(String id){

        providerService.delete(Integer.parseInt(id));
        return "redirect:/provider/findAllByPage";
    }

    @RequestMapping("/check")
    public String check(String id,Model model){
        //根据id查找当前用户信息
        Provider provider = providerService.findById(Integer.parseInt(id));
        model.addAttribute("provider",provider);
        return "/provider/providerview";
    }

    @RequestMapping("/findAllProvider")
    @ResponseBody
    public List<Provider> findAllProvider(){
        return providerService.findAll();
    }
}
