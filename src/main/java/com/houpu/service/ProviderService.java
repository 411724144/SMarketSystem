package com.houpu.service;

import com.github.pagehelper.PageInfo;
import com.houpu.entity.PageBean;
import com.houpu.entity.Provider;

import java.util.List;

public interface ProviderService {
    PageInfo<Provider> findAllByPage(Integer num, Integer size,String proCode,String proName);

    void add(Provider provider);

    void update(Provider provider);

    Provider findById(Integer id);

    void delete(Integer id);

    List<Provider> findAll();

    void addList(List<Provider> providerList);
}
