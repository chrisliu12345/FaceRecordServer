package com.gd.service.query;

import com.gd.domain.config.Camera;
import com.gd.domain.config.ConfigSQL;
import com.gd.domain.query.DetectImages;
import com.gd.domain.query.DetectImagesTemp;
import com.gd.domain.query.PeopleCollect;
import com.gd.domain.query.Record;
import com.gd.domain.userinfo.SignIn;
import com.gd.domain.userinfo.UserInfo;
import com.gd.domain.userinfo.UserInfoPicture;
import com.gd.domain.video.SimplePicture;
import io.swagger.models.auth.In;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * Created by 郄梦岩 on 2017/12/23.
 */
public interface IQueryService {

    List<DetectImagesTemp> queryForObject();

    List<DetectImagesTemp> queryForObject1(String id);

    List<DetectImagesTemp> queryForObject2(String Camid);

    List<Camera> getCamera();

    //检测图像浏览的查询功能
    List<DetectImagesTemp> queryForResultCamera(DetectImagesTemp detectImagesTemp);

    List<Record> getAllRecord();

    List<Record> queryForNameAndTime(Record record);

    List<Record> queryForOrgs(Record record);

    String searchForSite(Integer camera);

    void updateForThisData(DetectImagesTemp detectImages);

    List<DetectImagesTemp> queryForObjectDistory();

    Record getRecordResultOne(Integer id);

    List<Record> getRecordsToMap(Record record);

    String getPictSaveRootDirectory();

    List<DetectImages> queryForCollectIdByFive(Integer maxId);

    List<UserInfoPicture> queryForObjectSimple(List<Integer> is);

    List<Integer> queryForCollectIds();

    List<UserInfoPicture> queryForObjectList(String date);

    List<SignIn> queryForSignIn();

    void updateSignin(DetectImages collectId);

    Integer signSum();

    Integer signPeople();

    List<Integer> getSignCollectid();
    List<Integer> getSignCollectidRes();

    List<UserInfoPicture> getSignData();

    Integer getMaxTime();

}
