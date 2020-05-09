package com.houpu.service;

import com.github.pagehelper.PageInfo;
import com.houpu.entity.Bill;

public interface BillService {
    PageInfo<Bill> findAll(Integer pageNum,Integer pageSize,String productName,Integer provider_id,Integer isPayment);

    void save(Bill bill);

    Bill findById(Integer id);

    void delete(Integer id);

    void update(Bill bill);
}
