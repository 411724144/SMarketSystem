package com.houpu.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.houpu.entity.Bill;
import com.houpu.mapper.BillMapper;
import com.houpu.service.BillService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BillServiceImpl implements BillService {
    @Autowired
    private BillMapper billMapper;

    @Override
    public PageInfo<Bill> findAll(Integer pageNum,Integer pageSize,String productName,Integer provider_id,Integer isPayment) {
        PageHelper.startPage(pageNum,pageSize);
        List<Bill> list = billMapper.findAll(productName,provider_id,isPayment);

        return new PageInfo<Bill>(list);
    }

    @Override
    public void save(Bill bill) {
        billMapper.save(bill);
    }

    @Override
    public Bill findById(Integer id) {
        return billMapper.findById(id);
    }

    @Override
    public void delete(Integer id) {
        billMapper.delete(id);
    }

    @Override
    public void update(Bill bill) {
        billMapper.update(bill);
    }
}
