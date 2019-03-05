package com.gd.service.video;

import com.gd.domain.query.PeopleCollect;
import com.gd.domain.userinfo.UserInfo;
import com.gd.domain.video.CameraList;
import com.gd.domain.video.CsServices;
import com.gd.domain.video.SimplePicture;

import java.util.List;

/**
 * Created by Administrator on 2017/12/22 0022.
 */
public interface IVideoService {
    List<UserInfo> checkName(UserInfo userInfo);

    List<Integer> getPictureId(SimplePicture simplePicture);

    List<SimplePicture> getPicture(SimplePicture s);

    List<SimplePicture> getPicture1(SimplePicture s);

    List<SimplePicture> getPicture2(SimplePicture s);

    List<PeopleCollect> getCollectId();

    void updateCollectId(PeopleCollect PeopleCollect);

    void updatePicture1(SimplePicture simplePicture);

    void updatePicture2(SimplePicture simplePicture);

    List<SimplePicture> queryForWaitUser();

    List<PeopleCollect> queryForPersonCollection();

    String getCStatus();

    void updateCStatus(String a);

    void deleteSimPic(int i);

    List<PeopleCollect> search1(String employeed);

    List<CameraList> searchCameraID();

    String searchCameraUrl(Integer cameraId);

    Integer getConfigCamID();
    Integer getConfigCamID1(Integer x);

    List<CsServices> getServices();




}
