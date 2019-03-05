package com.gd.service.video.impl;

import com.gd.dao.video.IVideoDao;
import com.gd.domain.query.PeopleCollect;
import com.gd.domain.userinfo.UserInfo;
import com.gd.domain.video.CameraList;
import com.gd.domain.video.CsServices;
import com.gd.domain.video.SimplePicture;
import com.gd.service.video.IVideoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2017/12/22 0022.
 */
@Service("videoService")
public class VideoServiceImpl implements IVideoService {
    @Autowired
    private IVideoDao videoDao;

    @Override
    public List<SimplePicture> getPicture1(SimplePicture s) {
        return this.videoDao.getPicture1(s);
    }
    @Override
    public List<SimplePicture> getPicture2(SimplePicture s) {
        return this.videoDao.getPicture2(s);
    }
    @Override
    public List<Integer> getPictureId(SimplePicture simplePicture) {
        return this.videoDao.queryPictures(simplePicture);
    }

    @Override
    public void deleteSimPic(int i) {
        //删除person——collection数据
        this.videoDao.deleteSimPic1(i);
        //删除simple——photo数据
        this.videoDao.deleteSimPic2(i);
    }

    @Override
    public String searchCameraUrl(Integer cameraId) {
        return this.videoDao.searchCameraUrl(cameraId);
    }

    @Override
    public List<PeopleCollect> search1(String employeed) {
        return this.videoDao.search1(employeed);
    }

    @Override
    public Integer getConfigCamID() {
        return this.videoDao.getConfigCamID();
    }

    @Override
    public Integer getConfigCamID1(Integer x) {
        return this.videoDao.getShowCamera(x);
    }

    @Override
    public List<CsServices> getServices() {
        return this.videoDao.getServices();
    }

    @Override
    public List<CameraList> searchCameraID() {
        return this.videoDao.searchCameraID();
    }

    @Override
    public void updateCStatus(String a) {
        this.videoDao.updateCStatus(a);
    }

    @Override
    public String getCStatus() {
        return this.videoDao.getCStatus();
    }

    @Override
    public void updatePicture1(SimplePicture simplePicture) {
        this.videoDao.updatePicture1(simplePicture);
    }

    @Override
    public void updatePicture2(SimplePicture simplePicture) {
        this.videoDao.updatePicture2(simplePicture);
    }
    @Override
    public List<PeopleCollect> queryForPersonCollection() {
        return this.videoDao.queryForPersonCollection();
    }

    @Override
    public void updateCollectId(PeopleCollect peopleCollect) {
        this.videoDao.updateCollectId(peopleCollect);
    }

    @Override
    public List<SimplePicture> getPicture(SimplePicture s) {
        return this.videoDao.getPicture(s);
    }


    @Override
    public List<SimplePicture> queryForWaitUser() {
        return this.videoDao.queryForWaitUser();
    }

    @Override
    public List<PeopleCollect> getCollectId() {
        return this.videoDao.getCollectId();
    }


    @Override
    public List<UserInfo> checkName(UserInfo userInfo) {
        return this.videoDao.checkName(userInfo);
    }
}
