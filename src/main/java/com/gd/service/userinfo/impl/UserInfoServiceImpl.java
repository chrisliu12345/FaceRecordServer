package com.gd.service.userinfo.impl;

import com.gd.dao.config.IConfigDao;
import com.gd.dao.query.IQueryDao;
import com.gd.dao.userinfo.IUserInfoDao;
import com.gd.domain.app.App;
import com.gd.domain.base.BaseModel;
import com.gd.domain.userinfo.*;
import com.gd.domain.video.SimplePicture;
import com.gd.service.userinfo.IUserInfoService;
import com.gd.util.TextToSpeak;
import com.gd.util.deleteFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.ArrayList;
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
@Service("userInfoService")
public class UserInfoServiceImpl implements IUserInfoService {
    @Autowired
    private IUserInfoDao userInfoDao;
    @Autowired
    private IQueryDao iQueryDao;

    @Override
    public List<UserInfo> queryForObject(BaseModel baseModel) {
        return this.userInfoDao.queryForObject(baseModel);
    }

    @Override
    public int insertUser(BaseModel baseModel) {
        //防止那些不可重复的字段插入之后返回Exception
        int flag = 0;
        try{
            flag = this.userInfoDao.insertUser(baseModel);
        }catch (Exception e){
            flag = 0;
        }
        return flag;
    }

    @Override
    public int deleteUser(BaseModel baseModel) {
        return this.userInfoDao.deleteUser(baseModel);
    }
    @Override
    public int updateUser(BaseModel baseModel) {
        return this.userInfoDao.updateUser(baseModel);
    }

    @Override
    public List<App> queryAppListForObject(BaseModel baseModel) {
        return this.userInfoDao.queryAppListForObject(baseModel);
    }

    @Override
    public List<Map<String, Object>> queryAppListAndCommunicationIdForObject(BaseModel baseModel) {
        return this.userInfoDao.queryAppListAndCommunicationIdForObject(baseModel);
    }

    @Override
    public List<UserInfo> queryForObjectByorg(UserInfo userInfo) {
        return this.userInfoDao.queryForObjectByorg(userInfo);
    }

    @Override
    public ImportUser1 getImportUser1() {
        return userInfoDao.getImportUser1();
    }

    @Override
    public void importUserTemp1(ImportUser1 importUser1) {
        this.userInfoDao.importUserTemp1(importUser1);
    }

    @Override
    public List<Integer> getCsResult() {
        return this.userInfoDao.getCsResult();
    }

    @Override
    public void deleteForSimplePhotobyId(int Id) {
        this.userInfoDao.deleteForSimplePhotobyId(Id);
    }

    @Override
    public List<SimplePicture> getSimplePhotoByOne(Integer collectId) {
        return this.userInfoDao.getSimplePhotoByOne(collectId);
    }

    @Override
    public List<String> queryForVoiceByUUID() {
        List<UserInfoVoice> userInfoVoiceList=this.userInfoDao.queryForVoiceByUUID();
        List<String> stringList=new ArrayList<>();
        TextToSpeak textToSpeak=new TextToSpeak();
        String rootPath1 = this.iQueryDao.getPictSaveRootDirectoryNew().replace("/", "\\")+"VoicePlayback\\";
        File tempFile = new File(rootPath1);
        if (!tempFile.exists()) {
            tempFile.mkdirs();
        }
        File tempFile2=new File(rootPath1+"tmp\\");
        if(!tempFile2.exists()){
            tempFile2.mkdirs();
        }
        for(UserInfoVoice userInfoVoice: userInfoVoiceList){
            if(userInfoVoice.getVoice()==null||userInfoVoice.getVoice().equals("")){
                userInfoVoice.setVoice("VoicePlayback/"+userInfoVoice.getCollectId()+".mp3");
                this.userInfoDao.addUserInfoVoice(userInfoVoice);
                /*第一个参数为mp3名称，第二个参数为目标地址，第三个参数为临时目标地址*/
                textToSpeak.textSpeak(userInfoVoice.getRealName(),rootPath1+userInfoVoice.getCollectId()+".mp3",rootPath1+"tmp\\"+userInfoVoice.getCollectId()+".mp3");
                System.out.println("正在生成"+userInfoVoice.getRealName()+"的语音!");
                stringList.add(userInfoVoice.getRealName());
            }
        }
        System.out.println("-----转化完成-----");
        deleteFile.delAllFile(rootPath1+"tmp\\");
        return stringList;
    }

    @Override
    public List<SimplePicture> queryForSimplePhotosToBeIsRegistered() {
        return this.userInfoDao.queryForSimplePhotosToBeIsRegistered();
    }

    @Override
    public void updateBeIsRegisteredForSimplePhoto(SimplePicture simplePicture) {
        this.userInfoDao.updateBeIsRegisteredForSimplePhoto(simplePicture);
    }

    @Override
    public SimplePicture queryForSimplePhotosByurlName(String picName1) {
        return this.userInfoDao.queryForSimplePhotosByurlName(picName1);
    }

    @Override
    public String queryForObjectToCollectID(int collectId) {
        return this.userInfoDao.queryForObjectToCollectID(collectId);
    }

    @Override
    public List<SimplePicture> queryForSimplePhotos(List<Integer> ids) {
        return this.userInfoDao.queryForSimplePhotos(ids);
    }

    @Override
    public void deleteForcsresult1() {
        this.userInfoDao.deleteForcsresult1();
    }

    @Override
    public void deleteForcsresult() {
        this.userInfoDao.deleteForcsresult();
    }

    @Override
    public List<Integer> getCsResultForCollectID() {
        return this.userInfoDao.getCsResultForCollectID();
    }

    @Override
    public void addcsresult1(CsResult csResult) {
        this.userInfoDao.addcsresult1(csResult);
    }

    @Override
    public SimplePicture getSimplePhotoById(int id) {
        return this.userInfoDao.getSimplePhotoById(id);
    }

    @Override
    public String queryCsString() {
        return this.userInfoDao.queryCsString();
    }

    @Override
    public void insertCsString(String collectId) {
        this.userInfoDao.insertCsString(collectId);
    }

    @Override
    public void deleteSession() {
        this.userInfoDao.deleteSession();
    }

    @Override
    public List<UserInfo> queryForName1(UserInfo userInfo) {
        return this.userInfoDao.queryForName1(userInfo);
    }

    @Override
    public String getRootPath() {
        return this.userInfoDao.getRootPath();
    }

    @Override
    public void addSimplePicture(SimplePicture simplePicture) {
        this.userInfoDao.addSimplePicture(simplePicture);
    }

    @Override
    public Integer getSimplePhotoMax() {
        return this.userInfoDao.getSimplePhotoMax();
    }

    @Override
    public void deleteImportUser() {
        this.userInfoDao.deleteImportUser();
    }

    @Override
    public List<String> queryForName(int Orgid) {
        return this.userInfoDao.queryForName(Orgid);
    }

    @Override
    public ImportUser getImportUser() {
        return this.userInfoDao.getImportUser();
    }

    @Override
    public void deleteForSimplePhoto(int collectId) {
        this.userInfoDao.deleteForSimplePhoto(collectId);
    }

    @Override
    public void ImportUserTemp(ImportUser importUser) {
        this.userInfoDao.ImportUserTemp(importUser);
    }

    @Override
    public UserInfo queryForObject1(BaseModel baseModel) {
        return this.userInfoDao.queryForObject1(baseModel);
    }

    @Override
    public void addPicture(UserInfoPicture userInfoPicture) {
        this.userInfoDao.addPicture(userInfoPicture);
    }

    @Override
    public UserInfoPicture queryForPicture(UserInfoPicture userInfoPicture) {
        return userInfoDao.queryforPicture(userInfoPicture);
    }

    @Override
    public void deleteUserPicture(UserInfoPicture userInfoPicture) {
        this.userInfoDao.deleteUserPicture(userInfoPicture);
    }

    @Override
    public String queryForUUID(UserInfo userInfo) {
        return this.userInfoDao.queryForUUID(userInfo);
    }


}
