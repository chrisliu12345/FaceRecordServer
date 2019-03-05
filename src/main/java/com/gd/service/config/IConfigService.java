package com.gd.service.config;

import com.gd.controller.config.ConfigController;
import com.gd.domain.config.*;
import com.gd.domain.query.Record;
import com.gd.domain.userinfo.UserInfo;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/12/19 0019.
 */
public interface IConfigService {
    List<ConfigSQL> queryForObject();

    String addConfig(Config config);

    void updateConfig(Config config);

    void cleanData(ConfigData configData);

    void updateCamera(Camera camera);

    void deleteCamera(Camera camera);

    void addCamera(Camera camera);

    List<Camera> getCamera();

    List<DisPlay> getDisPlay();

    void addDisPlay(DisPlay disPlay);

    void addConfigDisPlay(DisPlay disPlay);

    List<CsConfig> getCsText();

    void addCsText(CsConfig csConfig);

    Integer queryForCameraId(Camera camera);

    void addParamIdentily(ParamIdentify paramIdentify);

    void addParamConllect(ParamCollect paramCollect);

    void addCamera1(int i);

    void addCameraLocation(CameraLocation cameraLocation);

    String getDisPlayParam();

    DisPlay getDisPlayNow(Integer id);

    String getCsTextParam();

    CsConfig getCsTextNow(Integer id);

    String getCameraParam();

    Camera getCameraNow(Integer id);

    void deleteForcollect(Camera camera);

    void deleteForidentify(Camera camera);

    Camera queryTopForCamera();

    void updateDisplayCameraIdSetting(Integer cameraid);

    String getCollectNewResult();

    void setCollectNewResult();

    Integer selectCameraLocation(CameraLocation cameraLocation);

    String getcleanData();

    void deleteUserTemp(Record record);

    List<Record> queryForRecordById(String id);

    void addModeledulian(Edulian edulian);

    void addModelsoftMax(SoftMax sw);

    void deleteedulian(int id);

    void deletedeepinsight(int id);

    void deletesoftMax(int id);

    String queryForServicesIpByid(int id);

    void addDeepinsight(Deepinsight deepinsight);

    String queryForServicesId(int i);

    void updateServiceCameraId(CsServers csServers);

    void addIdentifyContrast(IdentifyContrast identifyContrast);

    void deleteIdentifyContrast(Camera camera);

    String queryForTableExist();

    List<Record> downLoadData(Map<String,String> map);

    void cleanAttendanceData(String year);

    List<UserInfo> getNamesByOrgId(String id);

    void addSound(Sound sound);

    int queryForSoundId(Camera camera);

    void deleteSound(int id);
}
