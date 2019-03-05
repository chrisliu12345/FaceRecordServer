package com.gd.service.group.impl;

import com.gd.dao.group.IGroupDao;
import com.gd.domain.group.GroupInfo;
import com.gd.service.group.IGroupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by 郄梦岩 on 2017/10/13.
 */
@Service("groupsService")
public class GroupServiceImpl implements IGroupService{
    public static final String CACHE_KEY = "'demoInfo'";
    public static final String DEMO_CACHE_NAME = "demo";

    @Autowired
    private IGroupDao groupDao;
    @Cacheable(value=DEMO_CACHE_NAME,key=CACHE_KEY)//存入缓存
    @Override
    public List<GroupInfo> list() {
        System.out.print("我是查询组域的信息列表，没有走缓存！");
        return this.groupDao.queryForObject();
    }
    @CacheEvict(value=DEMO_CACHE_NAME,key=CACHE_KEY)//清除缓存
    @Override
    public void delete(GroupInfo groupInfo) {
        this.groupDao.deletForObject(groupInfo);
    }
    @CacheEvict(value=DEMO_CACHE_NAME,key=CACHE_KEY)//清除缓存
    @Override
    public void adds(GroupInfo groupInfo) {
        this.groupDao.addForObject(groupInfo);
    }

    @Override
    public List<Integer> list1() {
        return this.groupDao.queryForObject1();
    }


    @Override
    public List<Integer> list2() {
        return this.groupDao.queryForObject2();
    }
    @CacheEvict(value=DEMO_CACHE_NAME,key=CACHE_KEY)//清除缓存
    @Override
    public void update(GroupInfo groupInfo) {
        this.groupDao.updateForObject(groupInfo);
    }
    @CacheEvict(value=DEMO_CACHE_NAME,key=CACHE_KEY)//清除缓存
    @Override
    public void add(GroupInfo groupInfo) {
        this.groupDao.addForObject(groupInfo);
    }
}
