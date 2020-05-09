package com.houpu.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.houpu.entity.PageBean;
import com.houpu.entity.Provider;
import com.houpu.mapper.ProviderMapper;
import com.houpu.service.ProviderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ProviderServiceImpl implements ProviderService {

    @Autowired
    private ProviderMapper providerMapper;

    @Override
    public PageInfo<Provider> findAllByPage(Integer num, Integer size,String proCode,String proName) {

        //设置分页数据
        PageHelper.startPage(num,size);
        List<Provider> providerList = providerMapper.findAll(proCode,proName);
        //用pageInfo对结果进行包装
        PageInfo<Provider> pageInfo = new PageInfo(providerList);

        return pageInfo;
    }

    @Override
    public void add(Provider provider) {
        providerMapper.add(provider);
    }

    @Override
    public void update(Provider provider) {
        providerMapper.update(provider);
    }

    @Override
    public Provider findById(Integer id) {
        return providerMapper.findById(id);
    }

    @Override
    public void delete(Integer id) {
        providerMapper.delete(id);
    }

    @Override
    public List<Provider> findAll() {
        return providerMapper.findAll(null,null);
    }

    @Override
    public void addList(List<Provider> providerList) {

        //遍历数据
        for (Provider provider:providerList){
            providerMapper.add(provider);
        }
    }
}
