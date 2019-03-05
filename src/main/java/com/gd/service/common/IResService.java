package com.gd.service.common;


import com.gd.domain.video.Res_Attr;


import java.util.List;

/**
 * Created by Administrator on 2017/9/18.
 */
public interface IResService {
    List<Res_Attr> list();//查询所有设备信息

    void add(Res_Attr res_attr);//添加设备信息

    void delete(Res_Attr res);//删除设备信息

    void update(Res_Attr attr);//更新设备信息



    String queryforobject1(Res_Attr res_attr);//根据设备ID查询设备的父设备ID

    Integer queryforResId(Res_Attr res_attr);//查询设备为摄像机的RESID，并给摄像机表使用
    String queryForMaxDeviceId();//查找tbl_res_attr表中deviceId后六位最大值

    String queryforobject2(Res_Attr res_attr);

    String queryforDeviceID(Res_Attr res_attr);

    List<String> deviceIDtoResID(String de);

     Integer queryforResIdtoChannel(Integer ss);

     Res_Attr DeviceIDforRes(String s);

     List<Res_Attr> queryForCameraTbl();
    String queryFortblServiceByIPAddress();



}
