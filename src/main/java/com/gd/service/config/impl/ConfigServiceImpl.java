package com.gd.service.config.impl;

import com.gd.dao.config.IConfigDao;
import com.gd.dao.query.IQueryDao;
import com.gd.domain.config.*;
import com.gd.domain.query.Record;
import com.gd.domain.userinfo.UserInfo;
import com.gd.service.config.IConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/12/19 0019.
 */
@Service("configService")
public class ConfigServiceImpl implements IConfigService {
    @Autowired
    private IConfigDao configDao;
    @Autowired
    private IQueryDao queryDao;

    @Override
    public void cleanData(ConfigData configData) {
        this.configDao.cleanData(configData);
    }

    @Override
    public void addCamera1(int i) {
        this.configDao.addCamera1(i);
    }

    @Override
    public List<ConfigSQL> queryForObject() {
        return this.configDao.queryForObject();
    }

    @Override
    public void addCameraLocation(CameraLocation cameraLocation) {
        this.configDao.addCameraLocation(cameraLocation);
    }

    @Override
    public void addParamConllect(ParamCollect paramCollect) {
        this.configDao.addParamConllect(paramCollect);
    }

    @Override
    public void addParamIdentily(ParamIdentify paramIdentify) {
        this.configDao.addParamIdentily(paramIdentify);
    }

    @Override
    public Integer queryForCameraId(Camera camera) {
        return this.configDao.queryForCameraId(camera);
    }

    @Override
    public void addCsText(CsConfig csConfig) {
        this.configDao.addCsText(csConfig);
    }

    @Override
    public List<CsConfig> getCsText() {
        return this.configDao.updateCsPlay();
    }

    @Override
    public void addConfigDisPlay(DisPlay disPlay) {
        this.configDao.updateConfigPlay(disPlay);
    }

    @Override
    public String getDisPlayParam() {
        return this.configDao.getDisPlayParam();
    }

    @Override
    public String getCsTextParam() {
        return this.configDao.getCsTextParam();
    }

    @Override
    public String getCameraParam() {
        return this.configDao.getCameraParam();
    }

    @Override
    public void updateDisplayCameraIdSetting(Integer cameraid) {
        this.configDao.updateDisplayCameraIdSetting(cameraid);
    }

    @Override
    public void setCollectNewResult() {
        this.configDao.setCollectNewResult();
    }

    @Override
    public String getCollectNewResult() {
        return this.configDao.getCollectNewResult();
    }

    @Override
    public Camera queryTopForCamera() {
        return this.configDao.queryTopForCamera();
    }

    @Override
    public void deleteForcollect(Camera camera) {
        this.configDao.deleteForcollect(camera);
    }

    @Override
    public void deleteForidentify(Camera camera) {
        this.configDao.deleteForidentify(camera);
    }

    @Override
    public Camera getCameraNow(Integer id) {
        return this.configDao.getCameraNow(id);
    }

    @Override
    public CsConfig getCsTextNow(Integer id) {
        return this.configDao.getCsTextNow(id);
    }

    @Override
    public DisPlay getDisPlayNow(Integer id) {
        return this.configDao.getDisPlayNow(id);
    }

    @Override
    public void addDisPlay(DisPlay disPlay) {
        this.configDao.addDisPlay(disPlay);
    }

    @Override
    public List<DisPlay> getDisPlay() {
        return this.configDao.getDisPlay();
    }

    @Override
    public String getcleanData() {
        return this.configDao.getcleanData();
    }

    @Override
    public Integer selectCameraLocation(CameraLocation cameraLocation) {
        return this.configDao.selectCameraLocation(cameraLocation);
    }

    @Override
    public void addCamera(Camera camera) {
        this.configDao.addCamera(camera);
    }

    @Override
    public void deleteCamera(Camera camera) {
        this.configDao.deleteCamera(camera);
    }

    @Override
    public void updateCamera(Camera camera) {
        this.configDao.updateCamera(camera);
    }


    @Override
    public List<Camera> getCamera() {
        return this.configDao.getCameraList();
    }

    @Override
    public void updateConfig(Config config) {
        this.configDao.updateStartTime(config);
        this.configDao.updateEndTime(config);
        this.configDao.updateStartRestTime(config);
        this.configDao.updateEndRestTime(config);
        this.configDao.updateStartWrok(config);
        this.configDao.updateEndWork(config);
        this.configDao.updateNoWork(config);
        this.configDao.updateSelected(config);
        this.configDao.updateStartAddWorkTime(config);
    }

    @Override
    public String addConfig(Config config) {
        this.configDao.addConfig(config);
        return "1";
    }

    @Override
    public void deletedeepinsight(int id) {
        this.configDao.deletedeepinsight(id);
    }

    @Override
    public void addDeepinsight(Deepinsight deepinsight) {
        this.configDao.addDeepinsight(deepinsight);
    }

    @Override
    public List<Record> queryForRecordById(String id) {
        return this.configDao.queryForRecordById(id);
    }

    @Override
    public int deleteUserTemp(Record record) {
         return this.configDao.deleteUserTemp(record);
    }

    @Override
    public void deleteedulian(int id) {
        this.configDao.deleteModeledulian(id);
    }

    @Override
    public void deletesoftMax(int id) {
        this.configDao.deleteModelsoftMax(id);
    }

    @Override
    public void deleteIdentifyContrast(Camera camera) {
        this.configDao.deleteIdentifyContrast(camera);
    }

    @Override
    public void addIdentifyContrast(IdentifyContrast identifyContrast) {
        this.configDao.addIdentifyContrast(identifyContrast);
    }

    @Override
    public void updateServiceCameraId(CsServers csServers) {
        this.configDao.updateServiceCameraId(csServers);
    }

    @Override
    public String queryForServicesId(int i) {
        return this.configDao.queryForServicesId(i);
    }

    @Override
    public String queryForServicesIpByid(int id) {
        return this.configDao.queryForServicesIpByid(id);
    }

    @Override
    public void addModelsoftMax(SoftMax sw) {
        this.configDao.addModelsoftMax(sw);
    }

    @Override
    public void addModeledulian(Edulian edulian) {
        this.configDao.addModeledulian(edulian);
    }

    @Override
    public List<UserInfo> getNamesByOrgId(String id) {
        return this.configDao.getNamesByOrgId(id);
    }

    @Override
    public void cleanAttendanceData(String year) {
        //清除数据库数据
        this.configDao.cleanAttendanceData(year);
        //清除识别之后存储的照片



    }


    @Override
    public int queryForSoundId(Camera camera) {
        return this.configDao.queryForSoundId(camera);
    }

    @Override
    public void deleteSound(int id) {
        this.configDao.deleteSound(id);
    }

    @Override
    public void addSound(Sound sound) {
        this.configDao.addSound(sound);
    }

    @Override
    public List<Record> downLoadData(Map<String, String> map) {
        Record record = new Record();
        record.setORGID(map.get("group"));
        record.setCreateTime1(java.sql.Date.valueOf(map.get("startDate")));
        record.setCreateTime2(java.sql.Date.valueOf(map.get("endDate")));
        if(map.get("person").equals("99999")){
            System.out.println("走全部"+map.get("person"));
        }else{
            System.out.println("走个人"+map.get("person"));
            record.setCollectId(Integer.parseInt(map.get("person")));
        }
        return this.configDao.DownLoadDataOrgs(record);
    }

    @Override
    public String queryForTableExist() {
        int table1 = this.configDao.querytbl_resa_ttrExist();
        int table2 = this.configDao.querytbl_cameraExist();
        int table3 = this.configDao.querytbl_channelExist();
        int table4 = this.configDao.querytbl_storplanExist();
        int table5 = this.configDao.queryfr_cameraExist();
        int table6 = this.configDao.queryfr_param_identifyExist();
        int table7 = this.configDao.queryfr_param_model_edulianExist();
        int table8 = this.configDao.queryfr_param_model_deepinsightExist();
        int table9 = this.configDao.queryfr_param_model_softmaxExist();
        int table10 = this.configDao.queryfr_param_identify_contrastExist();
        int num = table1 + table2 + table3 + table4 + table5 + table6 + table7 + table8 + table9 + table10;
        if (table1 == 0) {
            return "tbl_res_attr表不存在，请检查";
        } else if (table2 == 0) {
            return "tbl_camera表不存在，请检查";
        } else if (table3 == 0) {
            return "tbl_channel表不存在，请检查";
        } else if (table4 == 0) {
            return "tbl_storplan表不存在，请检查";
        } else if (table5 == 0) {
            return "fr_camera表不存在，请检查";
        } else if (table6 == 0) {
            return "fr_param_identify表不存在，请检查";
        } else if (table7 == 0) {
            return "fr_param_model_edulian表不存在，请检查";
        } else if (table8 == 0) {
            return "fr_param_model_deepinsight表不存在，请检查";
        } else if (table9 == 0) {
            return "fr_param_model_softmax表不存在，请检查";
        } else if (table10 == 0) {
            return "fr_param_identify_contrast表不存在，请检查";
        } else {
            return "access";
        }


    }
}
