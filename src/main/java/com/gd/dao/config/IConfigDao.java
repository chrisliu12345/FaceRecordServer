package com.gd.dao.config;

import com.gd.domain.config.*;
import com.gd.domain.query.Record;
import com.gd.domain.userinfo.UserInfo;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2017/12/19 0019.
 */
@Repository("configDao")
public interface IConfigDao {
    @Select("<script>SELECT * FROM fr_config</script>")
     List<ConfigSQL> queryForObject();
    @Update("<script>UPDATE fr_config set value=#{RestDay} where name='NationalHolidays'</script>")
    void addConfig(Config config);
    @Update("<script>UPDATE fr_config set value=#{StartTime} where name='ClockIn'</script>")
    void updateStartTime(Config config);
    @Update("<script>UPDATE fr_config set value=#{EndTime} where name='ClockOff'</script>")
    void updateEndTime(Config config);
    @Update("<script>UPDATE fr_config set value=#{StartRestTime} where name='LunchTimeBegin'</script>")
    void updateStartRestTime(Config config);
    @Update("<script>UPDATE fr_config set value=#{EndRestTime} where name='LunchTimeEnd'</script>")
    void updateEndRestTime(Config config);
    @Update("<script>UPDATE fr_config set value=#{StartWrok} where name='ClockInExtraTime'</script>")
    void updateStartWrok(Config config);
    @Update("<script>UPDATE fr_config set value=#{EndWork} where name='ClockOffExtraTime'</script>")
    void updateEndWork(Config config);
    @Update("<script>UPDATE fr_config set value=#{NoWork} where name='OffDutyTime'</script>")
    void updateNoWork(Config config);
    @Update("<script>UPDATE fr_config set value=#{Selected} where name='WorkingDays'</script>")
    void updateSelected(Config config);
    @Update("<script>UPDATE fr_config set value=#{StartAddWorkTime} where name='OvertimeBegin'</script>")
    void updateStartAddWorkTime(Config config);
    @Update("<script>UPDATE fr_config set value=#{TimeoutClearingSetting} where name='TimeoutClearingSetting'</script>")
    void cleanData(ConfigData configData);
    @Select("<script>SELECT A.*,B.ServiceIp,B.ShowCameraID FROM fr_camera as A inner join fr_cs_services as B on A.ServiceId = B.ServiceId </script>")
    List<Camera> getCameraList();
    @Update("<script>UPDATE fr_camera set Site=#{Site}," +
            "<if test=\"TaskType!=null and TaskType!=''\">\n" +
            "TaskType=#{TaskType}\n" +
            "</if>\n" +
            " where CamerId=#{CamerId} </script>")
    void updateCamera(Camera camera);

    @Insert("<script>INSERT INTO fr_camera (Site,url,TaskType,AttendanceLocationID,ServiceCameraID,ServiceId,featureID,camConfigID,soundID) values (#{Site},#{url},#{TaskType},#{AttendanceLocationID},#{ServiceCameraID},#{ServiceId},#{featureID},#{camConfigID},#{soundID}) </script>")
    @Options(useGeneratedKeys=true, keyProperty="CamerId",keyColumn = "CamerId")
    void addCamera(Camera camera);
    @Select("<script>SELECT * FROM fr_display_text</script>")
    List<DisPlay> getDisPlay();
    @Insert("<script>INSERT INTO fr_display_text (DisplayContent) values (#{DisplayContent}) </script>")
    void addDisPlay(DisPlay disPlay);
    @Update("<script>UPDATE fr_config set value=#{ContentId} where name='DisplayContentSetting'</script>")
    void updateConfigPlay(DisPlay disPlay);
    @Select("<script>SELECT * FROM fr_cs_panel</script>")
    List<CsConfig> updateCsPlay();
    @Update("<script>UPDATE fr_config set value=#{PanelId} where name='SystemInterfaceSetting'</script>")
    void addCsText(CsConfig csConfig);
    @Select("<script>SELECT CamerId FROM fr_camera WHERE Site=#{Site} AND url=#{url} AND TaskType=#{TaskType} AND AttendanceLocationID=#{AttendanceLocationID}</script>")
    Integer queryForCameraId(Camera camera);
    @Insert("<script>INSERT INTO fr_param_identify (" +
            "CameraId,recognisePath,bMouse,skipFrame,DetectType,scale,faceProbThresh,SelectType,eyesDistThresh," +
            "AlignType,DescriberType,sideFaceThresh,upFaceThresh,downFaceThresh,faceSharpThresh,maxFrameCache,maxFrameBatch,modelType)" +
            " VALUES (#{CameraId},#{recognisePath},#{bMouse},#{skipFrame},#{DetectType},#{scale},#{faceProbThresh},#{SelectType},#{eyesDistThresh}," +
            "#{AlignType},#{DescriberType},#{sideFaceThresh},#{upFaceThresh},#{downFaceThresh},#{faceSharpThresh},#{maxFrameCache},#{maxFrameBatch},#{modelType})" +
            "</script>")
    void addParamIdentily(ParamIdentify paramIdentify);
    @Insert("<script>INSERT INTO fr_param_collect (CameraId,distThresh,sharpnessThresh,perDirectNum,scale,probThresh,rotationThresh,roiInfo) VALUES" +
            " (#{CameraId},#{distThresh},#{sharpnessThresh},#{perDirectNum},#{scale},#{probThresh},#{rotationThresh},#{roiInfo})" +
            "</script>")
     void addParamConllect(ParamCollect paramCollect);
    @Update("<script>UPDATE fr_config set value=#{i} where name='DisplayCameraIdSetting'</script>")
    void addCamera1(int i);
    @Insert("<script>INSERT INTO fr_attendance_location (AttendanceLocationName) VALUES" +
            " (#{AttendanceLocationName})" +
            "</script>")
    void addCameraLocation(CameraLocation cameraLocation);
    @Select("<script>select value from fr_config where name='DisplayContentSetting'</script>")
    String getDisPlayParam();
    @Select("<script>SELECT * FROM fr_display_text WHERE ContentId=#{id}</script>")
    DisPlay getDisPlayNow(Integer id);
    @Select("<script>select value from fr_config where name='SystemInterfaceSetting'</script>")
    String getCsTextParam();
    @Select("<script>SELECT * FROM fr_cs_panel WHERE PanelId=#{id}</script>")
    CsConfig getCsTextNow(Integer id);
    @Select("<script>select value from fr_config where name='DisplayCameraIdSetting'</script>")
    String getCameraParam();
    /*@Select("<script>SELECT * FROM fr_camera WHERE CamerId=#{id}</script>")
    Camera getCameraNow(Integer id);*/
    @Select("<script>SELECT * FROM fr_camera limit 1</script>")
    Camera getCameraNow(Integer id);
    @Delete("<script>DELETE FROM fr_camera where CamerId=#{CamerId} </script>")
    void deleteCamera(Camera camera);
    @Delete("<script>DELETE FROM fr_param_identify where CameraId=#{CamerId} </script>")
    void deleteForidentify(Camera camera);
    @Delete("<script>DELETE FROM fr_param_collect where CameraId=#{CamerId} </script>")
    void deleteForcollect(Camera camera);
    @Select("<script>select * from fr_camera LIMIT 1 </script>")
    Camera queryTopForCamera();
    @Update("<script>UPDATE fr_config set value=#{CamerId} where name='DisplayCameraIdSetting'</script>")
    void updateDisplayCameraIdSetting(Integer camid);
    @Select("<script>select value from fr_config where name='CollectNewResult'</script>")
    String getCollectNewResult();
    @Update("<script>UPDATE fr_config set value='0' where name='CollectNewResult'</script>")
    void setCollectNewResult();
    @Select("<script>select count(*) from fr_attendance_location where AttendanceLocationName=#{AttendanceLocationName}</script>")
    Integer selectCameraLocation(CameraLocation cameraLocation);
    @Select("<script>select value from fr_config where name='TimeoutClearingSetting'</script>")
    String getcleanData();
    @Delete("<script>UPDATE fr_attendance_record set AttendanceFlag='',ClockIn=#{ClockIn},ClockOff=#{ClockOff} WHERE \n" +
            "(CollectId=#{CollectId} AND AttendanceFlag LIKE CONCAT('%','迟到','%'))\n" +
            "OR (CollectId=#{CollectId} AND AttendanceFlag LIKE CONCAT('%','早退','%'))\n" +
            "OR (CollectId=#{CollectId} AND AttendanceFlag LIKE CONCAT('%','旷工','%'))</script>")
    void deleteUserTemp(Record record);
    @Select("<script>SELECT * FROM fr_attendance_record WHERE " +
            "(CollectId=#{id} AND AttendanceFlag LIKE CONCAT('%','迟到','%'))\n" +
            " OR (CollectId=#{id} AND AttendanceFlag LIKE CONCAT('%','早退','%'))\n" +
            " OR (CollectId=#{id} AND AttendanceFlag LIKE CONCAT('%','旷工','%'))</script>")
    List<Record> queryForRecordById(String id);
    @Insert("<script>INSERT INTO fr_param_model_edulian (CameraId,modelType,modelPath,matchThresh," +
            "unMatchThresh,IOUThresh,recogSumVoteThresh,maxListLength) values " +
            "(#{CameraId},#{modelType},#{modelPath},#{matchThresh},#{unMatchThresh},#{IOUThresh},#{recogSumVoteThresh},#{maxListLength})</script>")
    void addModeledulian(Edulian edulian);
    @Delete("<script>delete from fr_param_model_edulian where CameraId=#{id}</script>")
    void deleteModeledulian(int id);

    @Insert("<script>INSERT INTO fr_param_model_softmax (CameraId,modelType,modelPath,fRecogPossibleThresh,fRecogSumVoteThreash) values" +
            " (#{CameraId},#{modelType},#{modelPath},#{fRecogPossibleThresh},#{fRecogSumVoteThreash})</script>")
    void addModelsoftMax(SoftMax softMax);
    @Delete("<script>delete from fr_param_model_softmax where CameraId=#{id}</script>")
    void deleteModelsoftMax(int id);
    @Select("<script>SELECT ServiceIp FROM fr_cs_services WHERE ServiceId=#{id}</script>")
    String queryForServicesIpByid(int id);
    @Insert("<script>INSERT INTO fr_param_model_deepinsight (CameraId,modelType,modelPath,matchThresh," +
            "unMatchThresh,IOUThresh,recogSumVoteThresh,maxListLength) values " +
            "(#{CameraId},#{modelType},#{modelPath},#{matchThresh},#{unMatchThresh},#{IOUThresh},#{recogSumVoteThresh},#{maxListLength})</script>")
    void addDeepinsight(Deepinsight deepinsight);
    @Delete("<script>delete from fr_param_model_deepinsight where CameraId=#{id}</script>")
    void deletedeepinsight(int id);
    @Select("<script>select ServiceId from fr_camera where CamerId=#{id}</script>")
    String queryForServicesId(int i);
    @Update("<script>update fr_cs_services set ShowCameraID=#{ShowCameraID} where ServiceId=#{ServiceId}</script>")
    void updateServiceCameraId(CsServers csServers);

    @Insert("<script>INSERT INTO fr_param_identify_contrast " +
            "(cameraId,bMouse,skipFrame,detectType,scale,faceProbThresh,selectType,eyesDistThresh,alignType,describerType," +
            "maxFrameCache,maxFrameBatch,veriThresh,accFrames,prob,sumFrames) values " +
            " (#{cameraId},#{bMouse},#{skipFrame},#{detectType},#{scale},#{faceProbThresh},#{selectType},#{eyesDistThresh},#{alignType},#{describerType}," +
            "#{maxFrameCache},#{maxFrameBatch},#{veriThresh},#{accFrames},#{prob},#{sumFrames})</script>")
    void addIdentifyContrast(IdentifyContrast identifyContrast);
    @Delete("<script>DELETE FROM fr_param_identify_contrast WHERE cameraId=#{CamerId}</script>")
    void deleteIdentifyContrast(Camera camera);
    @Select("<script>SELECT COUNT(1) FROM information_schema.tables WHERE table_schema='face' AND table_name = 'tbl_res_attr' </script>")
    int querytbl_resa_ttrExist();
    @Select("<script>SELECT COUNT(1) FROM information_schema.tables WHERE table_schema='face' AND table_name = 'tbl_camera' </script>")
    int querytbl_cameraExist();
    @Select("<script>SELECT COUNT(1) FROM information_schema.tables WHERE table_schema='face' AND table_name = 'tbl_channel' </script>")
    int querytbl_channelExist();
    @Select("<script>SELECT COUNT(1) FROM information_schema.tables WHERE table_schema='face' AND table_name = 'tbl_storplan' </script>")
    int querytbl_storplanExist();
    @Select("<script>SELECT COUNT(1) FROM information_schema.tables WHERE table_schema='face' AND table_name = 'fr_camera' </script>")
    int queryfr_cameraExist();
    @Select("<script>SELECT COUNT(1) FROM information_schema.tables WHERE table_schema='face' AND table_name = 'fr_param_identify' </script>")
    int queryfr_param_identifyExist();
    @Select("<script>SELECT COUNT(1) FROM information_schema.tables WHERE table_schema='face' AND table_name = 'fr_param_model_edulian' </script>")
    int queryfr_param_model_edulianExist();
    @Select("<script>SELECT COUNT(1) FROM information_schema.tables WHERE table_schema='face' AND table_name = 'fr_param_model_deepinsight' </script>")
    int queryfr_param_model_deepinsightExist();
    @Select("<script>SELECT COUNT(1) FROM information_schema.tables WHERE table_schema='face' AND table_name = 'fr_param_model_softmax' </script>")
    int queryfr_param_model_softmaxExist();
    @Select("<script>SELECT COUNT(1) FROM information_schema.tables WHERE table_schema='face' AND table_name = 'fr_param_identify_contrast' </script>")
    int queryfr_param_identify_contrastExist();
    @Select("<script>SELECT B.*,A.REALNAME,A.ORG,A.PARENTORG,A.POLICENUM FROM  fr_attendance_record as B inner join sys_userinfo as A on  A.BeIsDeleted=0"+
            "<if test=\"CollectId!=0\">\n" +
            "AND A.CollectId=#{CollectId}" +
            "</if>\n" +
            " AND A.CollectId = B.CollectId"+
            "<if test=\"CreateTime1!=null\">\n" +
            "AND B.CreateTime BETWEEN #{CreateTime1} and #{CreateTime2} AND A.ORGID=#{ORGID} ORDER BY A.CollectId,B.CreateTime ASC\n" +
            "</if>\n" +
            "</script>")
    List<Record> DownLoadDataOrgs(Record record);
    @Delete("<script>DELETE FROM fr_attendance_record WHERE CreateTime &lt;#{year}</script>")
    void cleanAttendanceData(String year);
    @Select("<script>SELECT * FROM sys_userinfo where ORGID=#{id}</script>")
    List<UserInfo> getNamesByOrgId(String id);
    @Insert("INSERT INTO fr_sound_equipment (soundEquipmentIp,username,password) VALUES (#{soundEquipmentIp},#{username},#{password})")
    @Options(useGeneratedKeys = true,keyProperty = "soundID",keyColumn = "soundID")
    void addSound(Sound sound);
    @Select("SELECT soundID from fr_camera where CamerId=#{CamerId}")
    int queryForSoundId(Camera camera);
    @Delete("delete from fr_sound_equipment where soundID=#{id}")
    void deleteSound(int id);
    @Update("UPDATE fr_signin SET signIn=0,signTime=NULL")
    void cleanMettingSignAndTime();
}
