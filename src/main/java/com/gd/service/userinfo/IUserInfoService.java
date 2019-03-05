package com.gd.service.userinfo;

import com.gd.domain.app.App;
import com.gd.domain.base.BaseModel;
import com.gd.domain.userinfo.*;
import com.gd.domain.video.SimplePicture;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by dell on 2017/4/6.
 * Good Luck !
 * へ　　　　　／|
 * 　　/＼7　　　 ∠＿/
 * 　 /　│　　 ／　／
 * 　│　Z ＿,＜　／　　 /`ヽ
 * 　│　　　　　ヽ　　 /　　〉
 * 　 Y　　　　　`　 /　　/
 * 　ｲ●　､　●　　⊂⊃〈　　/
 * 　()　 へ　　　　|　＼〈
 * 　　>ｰ ､_　 ィ　 │ ／／
 * 　 / へ　　 /　ﾉ＜| ＼＼
 * 　 ヽ_ﾉ　　(_／　 │／／
 * 　　7　　　　　　　|／
 * 　　＞―r￣￣`ｰ―＿
 */
public interface IUserInfoService {
    void addPicture(UserInfoPicture userInfoPicture);

    void deleteUserPicture(UserInfoPicture userInfoPicture);

    UserInfoPicture queryForPicture(UserInfoPicture userInfoPicture);

    String queryForUUID(UserInfo userInfo);

    List<UserInfo> queryForObject(BaseModel baseModel);

    int insertUser(BaseModel baseModel);

    int deleteUser(BaseModel baseModel);

    //更新用户信息
    int updateUser(BaseModel baseModel);

    //查询当前用户的app列表
    List<App> queryAppListForObject(BaseModel baseModel);

    //查询当前用户的app列表+环信ID
    List<Map<String, Object>> queryAppListAndCommunicationIdForObject(BaseModel baseModel);

    //根据部门和工号查询一个用户
    UserInfo queryForObject1(BaseModel baseModel);

    //根据本级和上级部门查看该部门下的所有用户
    List<UserInfo> queryForObjectByorg(UserInfo userInfo);

    List<String> queryForName(int Orgid);

    void ImportUserTemp(ImportUser importUser);

    ImportUser getImportUser();

    ImportUser1 getImportUser1();


    void deleteImportUser();

    Integer getSimplePhotoMax();

    void addSimplePicture(SimplePicture simplePicture);

    String getRootPath();

    List<UserInfo> queryForName1(UserInfo userInfo);

    void importUserTemp1(ImportUser1 importUser1);

    void deleteSession();

    void insertCsString(String collectId);

    String queryCsString();

    SimplePicture getSimplePhotoById(int id);

    void addcsresult1(CsResult csResult);

    List<Integer> getCsResult();

    List<Integer> getCsResultForCollectID();

    void deleteForcsresult();

    void deleteForcsresult1();

    void deleteForSimplePhotobyId(int Id);

    List<SimplePicture> queryForSimplePhotos(List<Integer> ids);

    String queryForObjectToCollectID(int collectId);

    SimplePicture queryForSimplePhotosByurlName(String picName1);

    void deleteForSimplePhoto(int collectId);

    void updateBeIsRegisteredForSimplePhoto(SimplePicture simplePicture);

    List<SimplePicture> queryForSimplePhotosToBeIsRegistered();

    List<SimplePicture> getSimplePhotoByOne(Integer collectId);

    List<String> queryForVoiceByUUID();


}
