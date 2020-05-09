package com.houpu.mapper;

import com.houpu.entity.Provider;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface ProviderMapper {

    Integer findTotalCount();

    List<Provider> findAll(@Param("proCode") String proCode,@Param("proName") String proName);

    void add(Provider provider);

    void update(Provider provider);

    @Select("select * from t_provider where id=#{id}")
    Provider findById(Integer id);

    @Delete("delete from t_provider where id=#{id}")
    void delete(Integer id);
}
