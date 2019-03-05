package com.gd.dao.userinfo;

import com.gd.domain.app.App;
import com.gd.domain.base.BaseModel;
import com.gd.domain.userinfo.*;
import com.gd.domain.video.SimplePicture;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by dell on 2017/1/12.
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
@Repository("userInfoDao")
public interface IUserInfoDao {
    @Select("<script>SELECT  * FROM sys_userinfo WHERE 1=1 \n " +
            "<if test=\"id!=null and id!=''\">\n" +
            " AND ID=#{id}\n" +
            "</if>\n" +
            "<if test=\"realName!=null and realName!=''\">\n" +
            "AND REALNAME=#{realName}\n" +
            "</if>\n" +
            "<if test=\"org!=null and org!=''\">\n" +
            "AND ORG=#{org}\n" +
            "</if>\n" +
            "<if test=\"orgId!=null and orgId!=''\">\n" +
            "AND ORGID=#{orgId}\n" +
            "</if>\n" +
            "AND BeIsDeleted=0"+
            " ORDER BY CREATETIME DESC</script>")
    List<UserInfo> queryForObject(BaseModel baseModel);
    @Insert("<script> INSERT INTO sys_userinfo" +
            " (id,createTime,updateTime,realName,parentorg,org,picture,policeNum,autoGraph,orgId,CollectId) VALUES\n" +
            "  (#{id},#{createTime},#{updateTime},#{realName},#{parentorg},#{org},#{picture},#{policeNum},#{autoGraph},#{orgId},#{CollectId})" +
            "</script>")
    int insertUser(BaseModel baseModel);
    //更新用户
    @Update("<script> UPDATE sys_userinfo " +
            "<trim prefix=\"set\" suffixOverrides=\",\">" +
            "<if test=\"createTime!=null and createTime!=''\">\n" +
            "createTime=#{createTime},\n" +
            "</if>\n" +
            "<if test=\"updateTime!=null and updateTime!=''\">\n" +
            "updateTime=#{updateTime},\n" +
            "</if>\n" +
            "<if test=\"realName!=null and realName!=''\">\n" +
            "realName=#{realName},\n" +
            "</if>\n" +
            "<if test=\"parentorg!=null and parentorg!=''\">\n" +
            "parentorg=#{parentorg},\n" +
            "</if>\n" +
            "<if test=\"org!=null and org!=''\">\n" +
            "org=#{org},\n" +
            "</if>\n" +
            "<if test=\"picture!=null and picture!=''\">\n" +
            "picture=#{picture},\n" +
            "</if>\n" +
            "<if test=\"policeNum!=null and policeNum!=''\">\n" +
            "policeNum=#{policeNum},\n" +
            "</if>\n" +
            "<if test=\"autoGraph!=null and autoGraph!=''\">\n" +
            "autoGraph=#{autoGraph},\n" +
            "</if>\n" +
            "<if test=\"orgId!=null and orgId!=''\">\n" +
            "orgId=#{orgId},\n" +
            "</if>\n" +
            "<if test=\"BeIsDeleted!=null and BeIsDeleted!=''\">\n" +
            "BeIsDeleted=#{BeIsDeleted},\n" +
            "</if>\n" +
            "</trim>"+
            " WHERE id=#{id}</script>")
    int updateUser(BaseModel baseModel);
    @Delete("<script>DELETE FROM sys_userinfo WHERE ID=#{id}</script>")
    int deleteUser(BaseModel baseModel);
    //查询当前用户的app列表
    @Select("<script>SELECT ta.* FROM sys_userinfo su " +
            "LEFT JOIN sys_account_user sau ON su.`ID`=sau.`USERID` " +
            "LEFT JOIN sys_account sa ON sau.`ACCOUNTID`=sa.`ID` " +
            "RIGHT JOIN tbl_app ta ON sa.`APPID`=ta.`ID` " +
            "WHERE su.`ID`=#{id}</script>")
    List<App> queryAppListForObject(BaseModel baseModel);
    //查询当前用户的app列表+环信ID
    @Select("<script>SELECT sa.`ID` AS appId,sa.`COMMUNICATIONID` AS communicationId,ta.* FROM sys_userinfo su " +
            "LEFT JOIN sys_account_user sau ON su.`ID`=sau.`USERID` " +
            "LEFT JOIN sys_account sa ON sau.`ACCOUNTID`=sa.`ID` " +
            "RIGHT JOIN tbl_app ta ON sa.`APPID`=ta.`ID` " +
            "WHERE su.`ID`=#{id}</script>")
    List<Map<String,Object>> queryAppListAndCommunicationIdForObject(BaseModel baseModel);
    @Insert("<script> INSERT INTO sys_userinfo_picture" +
            " (name,name2,uuid) VALUES (#{name},#{name2},#{uuid})" +
            "</script>")
    int addPicture(UserInfoPicture userInfoPicture);

    @Select("<script>SELECT picture FROM sys_userinfo WHERE ID=#{id}</script>")
    String queryForUUID(UserInfo userInfo);
    @Delete("<script>DELETE FROM sys_userinfo_picture WHERE uuid=#{uuid}</script>")
    void deleteUserPicture(UserInfoPicture userInfoPicture);
    @Select("<script>SELECT * FROM sys_userinfo_picture WHERE uuid=#{uuid}</script>")
    UserInfoPicture queryforPicture(UserInfoPicture userInfoPicture);
    @Select("<script>SELECT * FROM sys_userinfo WHERE 1=1" +
            "<if test=\"parentorg!=null and parentorg!=''\">\n" +
            "AND parentorg=#{parentorg},\n" +
            "</if>\n" +
            "<if test=\"org!=null and org!=''\">\n" +
            " AND org=#{org},\n" +
            "</if>\n" +
            "<if test=\"policeNum!=null and policeNum!=''\">\n" +
            "AND policeNum=#{policeNum},\n" +
            "</if>\n" +
            "<if test=\"id!=null and id!=''\">\n" +
            " AND ID=#{id}\n" +
            "</if>\n" +
            "<if test=\"realName!=null and realName!=''\">\n" +
            " AND realName=#{realName}\n" +
            "</if>\n" +
             "</script>")
    UserInfo queryForObject1(BaseModel baseModel);
    @Select("<script>SELECT * FROM sys_userinfo WHERE parentorg=#{parentorg} AND org=#{org} AND orgId=#{orgId} AND BeIsDeleted=0</script>")
   List<UserInfo> queryForObjectByorg(BaseModel baseModel);
    @Insert("<script>INSERT INTO sys_importuser_tmp" +
            " (orgId,placeId,type) VALUES (#{orgId},#{placeId},#{type})" +
            "</script>")
    void ImportUserTemp(ImportUser importUser);
    @Select("<script>SELECT * FROM sys_importuser_tmp  order by id desc limit 1</script>")
    ImportUser getImportUser();
    @Select("<script>SELECT * FROM sys_importuser1_tmp  order by id desc limit 1</script>")
    ImportUser1 getImportUser1();
    @Select("<script>SELECT realName FROM sys_userinfo WHERE orgId=#{orgId}</script>")
    List<String> queryForName(int orgId);
    @Delete("<script>DELETE FROM sys_importuser_tmp</script>")
    void deleteImportUser();
    @Select("<script>Select max(CollectId) from fr_sample_photo</script>")
    Integer getSimplePhotoMax();
    @Insert("<script>INSERT INTO fr_sample_photo" +
            " (CollectId,RelativePath) VALUES (#{CollectId},#{RelativePath})" +
            "</script>")
    @Options(useGeneratedKeys=true, keyProperty="id",keyColumn = "id")
    void addSimplePicture(SimplePicture simplePicture);

    @Select("<script>SELECT value FROM fr_config WHERE name='PictSaveRootDirectory'</script>")
    String getRootPath();
    @Select("<script>SELECT * FROM sys_userinfo where  ORGID=#{orgId} and REALNAME=#{realName} </script>")
    List<UserInfo> queryForName1(UserInfo userInfo);
    @Insert("<script>INSERT INTO sys_importuser1_tmp" +
            " (name,employee,placeId,parentOrgName,orgName,orgId,collectId) VALUES (#{name},#{employee},#{placeId},#{parentOrgName},#{orgName},#{orgId},#{collectId})" +
            "</script>")
    void importUserTemp1(ImportUser1 importUser1);
    @Delete("<script>DELETE FROM sys_importuser1_tmp</script>")
    void deleteSession();
    @Insert("<script>INSERT INTO sys_csresult (photoId,result) VALUES (#{collectId},1)</script>")
    void insertCsString(String collectId);
    @Select("<script>SELECT photoId FROM sys_csresult order by id desc limit 1</script>")
    String queryCsString();
    @Select("<script>select * from fr_sample_photo where id=#{id}</script>")
    SimplePicture getSimplePhotoById(int id);
    @Insert("<script>INSERT INTO sys_csresult1 (photoId,photoCollectId) VALUES (#{photoId},#{photoCollectId})</script>")
    void addcsresult1(CsResult csResult);
    @Select("<script>SELECT photoId FROM sys_csresult1</script>")
    List<Integer> getCsResult();
    @Select("<script>SELECT photoCollectId FROM sys_csresult1</script>")
    List<Integer> getCsResultForCollectID();
    @Delete("<script>DELETE FROM sys_csresult</script>")
    void deleteForcsresult();
    @Delete("<script>DELETE FROM sys_csresult1</script>")
    void deleteForcsresult1();
    @Select("<script>SELECT * FROM fr_sample_photo WHERE id in <foreach item = 'item' index = 'index' collection = 'idList' open = '(' separator = ',' close = ')'>#{item}</foreach></script>")
    List<SimplePicture> queryForSimplePhotos(@Param("idList") List<Integer> idList);
    @Select("<script>SELECT realName FROM sys_userinfo WHERE CollectId=#{collectId}</script>")
    String queryForObjectToCollectID(int collectId);
    @Select("<script>SELECT * FROM fr_sample_photo WHERE RelativePath LIKE  CONCAT('%',#{picName1},'%')</script>")
    SimplePicture queryForSimplePhotosByurlName(String picName1);
    @Delete("<script>DELETE FROM fr_sample_photo WHERE CollectId=#{collectId}</script>")
    void deleteForSimplePhoto(int collectId);
    @Delete("<script>DELETE FROM fr_sample_photo WHERE id=#{Id}</script>")
    void deleteForSimplePhotobyId(int Id);
    @Update("<script>UPDATE fr_sample_photo SET BeIsRegistered=null WHERE id=#{id}</script>")
    void updateBeIsRegisteredForSimplePhoto(SimplePicture simplePicture);
    @Select("<script>SELECT A.*,B.REALNAME FROM fr_sample_photo as A INNER JOIN  sys_userinfo as B WHERE A.CollectId=B.CollectId AND A.BeIsRegistered=0</script>")
    List<SimplePicture> queryForSimplePhotosToBeIsRegistered();
    @Select("<script>SELECT * FROM fr_sample_photo WHERE CollectId=#{collectId}</script>")
    List<SimplePicture> getSimplePhotoByOne(Integer collectId);
    @Select("<script>SELECT A.id,A.REALNAME,A.CollectId,B.* FROM sys_userinfo as A INNER JOIN sys_userinfo_picture as B WHERE A.PICTURE=B.uuid</script>")
    List<UserInfoVoice> queryForVoiceByUUID();
    @Update("<script>UPDATE sys_userinfo_picture SET voice=#{voice} WHERE uuid=#{uuid}</script>")
    void  addUserInfoVoice(UserInfoVoice userInfoVoice);


}
