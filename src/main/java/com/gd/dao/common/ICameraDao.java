package com.gd.dao.common;


import com.gd.domain.config.SaveConfig;
import com.gd.domain.video.Camera1;



import com.gd.domain.video.Channel;
import com.gd.domain.video.Res_Attr;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2017/8/11 0011.
 */
@Repository("camDao")
public interface ICameraDao {

    @Select("<script>SELECT * FROM tbl_camera</script>")
    List<Camera1> listForCamera1();

    //删除所有摄像机
    @Delete("<script>DELETE  FROM tbl_camera where ResID=#{ResID}</script> ")
    void deleteObject(Camera1 camera);

    //添加摄像机
    @Insert("<script>INSERT INTO tbl_camera " +
            "( ResID,PtzType, PositionType, RoomType, UseType, SupplyLightType, DirectionType,Resolution,BusinessGroupID,DownLoadSpeed,SVCSpaceSupportMode,SVCTimeSupportMode,PtzURL,Height,PitchAngle,Azimuth,Alias,LockedUsr,StreamingID,ReplayID,GroupID,PlaceID) VALUES " +
            "(#{ResID},#{PtzType},#{PositionType},#{RoomType},#{UseType},#{SupplyLightType},#{DirectionType},#{Resolution},#{BusinessGroupID},#{DownLoadSpeed},#{SVCSpaceSupportMode},#{SVCTimeSupportMode},#{PtzURL},#{Height},#{PitchAngle},#{Azimuth},#{Alias},#{LockedUsr},#{StreamingID},#{ReplayID},#{GroupID},#{PlaceID})</script>")
    void addObject(Camera1 camera);
    //更新摄像机
    @Update("<script>UPDATE tbl_camera set PtzType=#{PtzType},PositionType=#{PositionType}," +
            "RoomType=#{RoomType},UseType=#{UseType},SupplyLightType=#{SupplyLightType},DirectionType=#{DirectionType},Resolution=#{Resolution},BusinessGroupID=#{BusinessGroupID},DownLoadSpeed=#{DownLoadSpeed}," +
            "SVCSpaceSupportMode=#{SVCSpaceSupportMode},SVCTimeSupportMode=#{SVCTimeSupportMode},PtzURL=#{PtzURL},Height=#{Height},PitchAngle=#{PitchAngle},Azimuth=#{Azimuth},Alias=#{Alias},LockedUsr=#{LockedUsr},StreamingID=#{StreamingID},ReplayID=#{ReplayID},GroupID=#{GroupID} where  ResID=#{ResID}</script>")
    void updateObject(Camera1 camera);

    @Select("<script>SELECT * FROM tbl_res_attr WHERE ProtocolType='CAMERA' </script>")
   List<Res_Attr> queryForCameralist();
    @Select("<script>SELECT * FROM tbl_res_attr WHERE (CivilCode=#{id} AND ResType=131) OR (ResType=132 AND CivilCode=#{id})</script>")
    List<Res_Attr> queryForCameraNodes(String id);

    @Select("<script>SELECT ProtocolType FROM tbl_res_attr WHERE DeviceID=#{ss} </script>")
    String queryForProtocolType(String ss);

    @Delete("<script>DELETE FROM tbl_res_attr WHERE ParentID=#{de}</script>")
    void deleteForDeviceID(String de);

    @Select("<script>SELECT * FROM tbl_channel WHERE CamID=#{id} AND PlayUrl!='null' </script>")
    List<Channel> getCameraToChannel(Integer id);

    @Select("<script>SELECT * FROM tbl_res_attr WHERE DeviceID=(SELECT ParentID FROM tbl_res_attr WHERE ResID=#{id})</script>")
    Res_Attr getCameraToResID(Integer id);
    @Update("<script>UPDATE tbl_camera set Alias=#{Alias} WHERE ResID=#{ResID}</script>")
    void updateAlias(Camera1 camera1);
    @Select("<script>SELECT IPAddress FROM tbl_service WHERE ServiceID=#{s}</script>")
    String queryForStreamingIP(int s);
    @Insert("<script>INSERT INTO tbl_storplan (CamID,StreamingID,StartTime,StopTime,WorkDay,KeepTime,IslostStop) VALUES" +
            "(#{CamID},#{StreamingID},#{StartTime},#{StopTime},#{WorkDay},#{KeepTime},#{IslostStop})</script>")
    void addStorPlan(SaveConfig saveConfig);
    @Delete("<script>DELETE FROM tbl_storplan WHERE CamID=#{CamID}</script>")
    void deleteStoreplan(SaveConfig saveConfig);
}
