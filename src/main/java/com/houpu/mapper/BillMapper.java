package com.houpu.mapper;

import com.houpu.entity.Bill;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BillMapper {
    List<Bill> findAll(@Param("productName") String productName,@Param("providerId") Integer provider_id, @Param("isPayment")Integer isPayment);

    void save(Bill bill);

    Bill findById(Integer id);

    @Delete("delete from t_bill where id=#{id}")
    void delete(Integer id);

    void update(Bill bill);
}
