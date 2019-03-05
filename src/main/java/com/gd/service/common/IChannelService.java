package com.gd.service.common;


import com.gd.domain.video.Channel;

import java.util.List;

/**
 * Created by 郄梦岩 on 2017/10/19.
 */
public interface IChannelService {
    void addForObject(Channel channel); //添加通道

    void updateForObject(Channel channel); //更新通道

    Integer queryForCameraId(Channel channel);//根据摄像机ID查询该摄像机是否使用了通道

    List<Channel> list(); //查询所有通道

    void delete(Channel channel); //删除通道

    List<Integer> queryForChannelID(Channel channel);//获取通道数量

    void delete1(Channel channel);//根据NVRID删除通道

    void updateForPlayUrl(Channel channel);

    String selectNvrID(String id);

    void updateForObject0(Channel channel);

    void UpdateOldChannel(Channel channel);


}
