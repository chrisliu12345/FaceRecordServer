package com.gd.service.common.impl;

import com.gd.dao.common.ICameraDao;
import com.gd.dao.common.IResAttrDao;

import com.gd.domain.config.SaveConfig;
import com.gd.domain.video.Camera1;


import com.gd.domain.video.Channel;
import com.gd.domain.video.Res_Attr;
import com.gd.service.common.ICameraService;
import com.gd.service.common.IChannelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2017/8/11 0011.
 */
@Service("cameraService")
public class CameraServiceImpl implements ICameraService {
    public static final String CACHE_KEY = "'camInfo'";
    public static final String DEMO_CACHE_NAME = "demo";
    @Autowired
    private ICameraDao icc;
    @Autowired
    private IChannelService ich;
    @Autowired
    private IResAttrDao irs;
    @CacheEvict(value=DEMO_CACHE_NAME,key=CACHE_KEY)//清除缓存
    @Override
    public String add(Camera1 camera) {
        this.icc.addObject(camera);

        return null;
    }
    @Cacheable(value=DEMO_CACHE_NAME,key=CACHE_KEY)//存入缓存


    @Override
    public List<Res_Attr> searchCameraName(Res_Attr res_attr) {
        return this.irs.searchCameraName(res_attr);
    }

    @Override
    public Res_Attr getCameraToResID(Integer id) {
        return icc.getCameraToResID(id);
    }

    @Override
    public List<Channel> getCameraToChannel(Integer id) {
        return icc.getCameraToChannel(id);
    }

    @Override
    public List<Camera1> listForCamera1() {
        return this.icc.listForCamera1();
    }

    @CacheEvict(value=DEMO_CACHE_NAME,key=CACHE_KEY)//清除缓存
    @Override
    public void delete(Camera1 camera) {
        this.icc.deleteObject(camera);
        Channel channel=new Channel();

        channel.setCamID(camera.getResID());
        this.ich.delete1(channel);
    }
    @CacheEvict(value=DEMO_CACHE_NAME,key=CACHE_KEY)//清除缓存
    @Override
    public void update(Camera1 camera) {
        this.icc.updateObject(camera);
    }

    @Override
    public String queryForProtocolType(String ss) {
        return this.icc.queryForProtocolType(ss);
    }


    @Override
    public String queryForStreamingIP(int s) {
        return this.icc.queryForStreamingIP(s);
    }

    @Override
    public List<Res_Attr> queryForCameraNodes(String id) {
        return this.icc.queryForCameraNodes(id);
    }

    @Override
    public void updateForName(Res_Attr res_attr) {
        this.irs.updateForName(res_attr);
    }

    @Override
    public void deleteForDeviceID(String de) {
        this.icc.deleteForDeviceID(de);
    }

    @Override
    public void updateAlias(Camera1 camera1) {
        this.icc.updateAlias(camera1);
    }

    @Override
    public List<Res_Attr> queryForCameralist() {
        return this.icc.queryForCameralist();
    }
    @Override
    public void deleteStoreplan(SaveConfig saveConfig) {
        this.icc.deleteStoreplan(saveConfig);
    }

    @Override
    public void addStorPlan(SaveConfig saveConfig) {
        this.icc.addStorPlan(saveConfig);
    }

}
