package com.houpu.web.controller;

import com.github.pagehelper.PageInfo;
import com.houpu.entity.Bill;
import com.houpu.entity.User;
import com.houpu.service.BillService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/bill")
public class BillController {

    @Autowired
    private BillService billService;

    @RequestMapping("/findAll")
    public String findAll(@RequestParam(defaultValue = "1") Integer pageNum,
                          @RequestParam(defaultValue = "5") Integer pageSize,
                          @RequestParam(value = "productName",required = false) String productName,
                          @RequestParam(value = "provider_id",required = false) Integer provider_id,
                          @RequestParam(value = "isPayment",required = false) Integer isPayment,
                          Model model){
        //查询
        PageInfo<Bill> pageInfo = billService.findAll(pageNum,pageSize,productName,provider_id,isPayment);
        model.addAttribute("pageBean",pageInfo);
        model.addAttribute("productName",productName);
        model.addAttribute("provider_id",provider_id);
        model.addAttribute("isPayment",isPayment);
        return "bill/bill_list";
    }

    @GetMapping("/add")
    public String toAdd(){
        return "bill/bill_add";
    }

    @PostMapping("/add")
    public String add(Bill bill, HttpSession session){
        //获取当前用户
        User user = (User) session.getAttribute("user");
        bill.setCreatedBy(user.getId());
        billService.save(bill);
        return "redirect:/bill/findAll";
    }

    @RequestMapping("/view")
    public String view(String id,Model model,String type){

        //查找
        Bill bill = billService.findById(Integer.parseInt(id));
        //存储数据
        model.addAttribute("bill",bill);
        if ("update".equals(type)){
            return "forward:/WEB-INF/pages/bill/bill_update.jsp";
        }else {
            return "forward:/WEB-INF/pages/bill/bill_view.jsp";
        }
    }

    @RequestMapping("/delete")
    public String delete(Integer id){
        //删除
        billService.delete(id);
        return "redirect:/bill/findAll";
    }

    @RequestMapping("/update")
    public String update(Bill bill,HttpSession session){
        User user = (User) session.getAttribute("user");
        bill.setModifyBy(user.getId());
        billService.update(bill);
        return "redirect:/bill/findAll";
    }

}
