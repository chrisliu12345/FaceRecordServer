package com.gd.dao.common;

import com.gd.domain.base.BaseModel;

import com.gd.domain.video.Res_Attr;

import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2017/9/18.
 */
@Repository("resDao")
public interface IResAttrDao {
    //查询所有设备信息
    @Select("<script>SELECT * FROM tbl_res_attr order by ResID DESC </script>")
    List<Res_Attr> queryForObject();
    //根据设备ID查询设备的父设备ID
    @Select("<script>SELECT ResID From tbl_res_attr WHERE DeviceID=(SELECT ParentID FROM tbl_res_attr WHERE ResID=#{ResID})</script>")
    String queryForObject1(Res_Attr res_attr);
    @Select("<script>SELECT ParentID FROM tbl_res_attr WHERE ResID=#{ResID}</script>")
    String queryForObject2(Res_Attr res_attr);
    //添加设备信息
    @Insert("<script>INSERT INTO tbl_res_attr " +
            "(DeviceID,Name,ProtocolType,Manufacturer,Model,Owner,CivilCode,Block,Address," +
            "Parental,ParentID,SafetyWay,RegisterWay,CertNum," +
            "Certifiable,ErrCode,EndTime,Secrecy,IPAddress,Port,UsrName,Password,Status,Longitude," +
            "Latitude,PlatformID,ResType,SipServiceID,GuardFlag)" +
            "VALUES" +
            "(#{DeviceID},#{name},#{ProtocolType},#{Manufacturer},#{Model},#{Owner},#{CivilCode},#{Block},#{Address},#{Parental}," +
            "#{ParentID},#{SafetyWay},#{RegisterWay},#{CertNum},#{Certifiable},#{ErrCode},#{EndTime},#{Secrecy},#{IPAddress},#{Port}," +
            "#{UsrName},#{Password},#{Status},#{Longitude},#{Latitude},#{PlatformID},#{ResType},#{SipServiceID},#{GuardFlag})" +
            "</script>")
    void addForObject(BaseModel baseModel);
    //删除设备信息
    @Delete("<script>DELETE FROM tbl_res_attr WHERE ResID=#{ResID}</script>")
    void deleteForObject(BaseModel baseModel);
    //更新设备信息
    @Update("<script>UPDATE  tbl_res_attr SET DeviceID=#{DeviceID},Name=#{name},ProtocolType=#{ProtocolType},Manufacturer=#{Manufacturer},Model=#{Model},Owner=#{Owner},CivilCode=#{CivilCode},Block=#{Block},Address=#{Address}," +
            "Parental=#{Parental},ParentID=#{ParentID},SafetyWay=#{SafetyWay},RegisterWay=#{RegisterWay},CertNum=#{CertNum}," +
            "Certifiable=#{Certifiable},ErrCode=#{ErrCode},EndTime=#{EndTime},Secrecy=#{Secrecy},IPAddress=#{IPAddress},Port=#{Port},UsrName=#{UsrName},Password=#{Password},Status=#{Status},Longitude=#{Longitude}," +
            "Latitude=#{Latitude},PlatformID=#{PlatformID},ResType=#{ResType},SipServiceID=#{SipServiceID},GuardFlag=#{GuardFlag} where ResID=#{ResID} " +
            "</script>")
    void updateForObject(BaseModel baseModel);
    //修改摄像机信息时，同步更新res表的摄像机信息
    @Update("<script>UPDATE  tbl_res_attr SET Name=#{name} where ResID=#{ResID} " +
            "</script>")
    void updateForName(BaseModel baseModel);

    //根据设备ID查询设备的父设备ID
    @Update("<script>UPDATE  tbl_res_attr SET CivilCode=#{CivilCode},Block=#{Block},Address=#{Address},Secrecy=#{Secrecy},Longitude=#{Longitude}," +
            "Latitude=#{Latitude} where ResID=#{ResID}</script>")
    void updateForRes(Res_Attr res_attr);
    @Select("<script> SELECT ResID FROM tbl_res_attr WHERE IPAddress=#{IPAddress} AND Name=#{name} AND DeviceID=#{DeviceID}</script>")
    Integer queryForResId(Res_Attr res_attr);
    @Select("<script> SELECT max(right(DeviceID, 6)) FROM tbl_res_attr</script>")
    String queryForMaxDeviceId();


    @Select("<script>SELECT DeviceID FROM tbl_res_attr where ResID=#{ResID}</script>")
    String queryforDeviceID(Res_Attr res_attr);

    @Select("<script>SELECT ResID FROM tbl_res_attr WHERE ParentID=#{ss} </script>")
    List<String> deviceIDtoResID(String ss);

    @Select("<script>SELECT count(*) FROM tbl_channel WHERE PlayUrl='null' AND NVRID=#{ss}</script>")
    Integer queryforResIdtoChannel(Integer ss);
    @Select("<script>SELECT * FROM tbl_res_attr WHERE  DeviceID=#{ss}</script>")
    Res_Attr DeviceIDforRes(String ss);
    @Select("<script>SELECT * FROM tbl_res_attr WHERE   (Name  Like CONCAT('%',#{name},'%') AND ResType='131') OR (Name  Like CONCAT('%',#{name},'%') AND ResType='132')</script>")
    List<Res_Attr> searchCameraName(Res_Attr res_attr);
    @Select("select * from (select distinct  * from tbl_res_attr ) as c\n" +
            "    where (select count(1) as num from fr_camera as b where " +
            "b.ServiceCameraID = c.ResID) = 0 and (c.ResType='131' or c.ResType='132')")
    List<Res_Attr> queryForCameraTbl();
    @Select("select IPAddress from tbl_service where ServiceID=2")
    String queryFortblServiceByIPAddress();
}
