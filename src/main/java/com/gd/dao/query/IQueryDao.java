package com.gd.dao.query;

import com.gd.domain.config.Camera;
import com.gd.domain.query.DetectImages;
import com.gd.domain.query.DetectImagesTemp;
import com.gd.domain.query.PeopleCollect;
import com.gd.domain.query.Record;
import com.gd.domain.userinfo.SignIn;
import com.gd.domain.userinfo.UserInfo;
import com.gd.domain.userinfo.UserInfoPicture;
import com.gd.domain.video.SimplePicture;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.List;

/**
 * Created by 郄梦岩 on 2017/12/23.
 */
@Repository("queryDao")
public interface IQueryDao {
    @Select("<script>SELECT B.*,A.REALNAME,A.ORG,A.PARENTORG,A.POLICENUM FROM  fr_original_record as B inner join sys_userinfo as A on A.CollectId = B.CollectId and A.BeIsDeleted=0 ORDER BY B.Date DESC limit 5</script>")
    List<DetectImagesTemp> queryForObject();

    @Select("<script>SELECT B.*,A.REALNAME,A.ORG,A.PARENTORG,A.POLICENUM FROM  fr_original_record as B inner join sys_userinfo as A on A.CollectId = B.CollectId and A.BeIsDeleted=0  and  B.Date Like CONCAT('%',#{nowdate},'%') ORDER BY B.Date DESC</script>")

    List<DetectImagesTemp> queryForObjectDistory(String nowdate);
    @Select("<script>SELECT B.*,A.REALNAME,A.ORG,A.PARENTORG,A.POLICENUM FROM  fr_original_record as B inner join sys_userinfo as A on A.CollectId = B.CollectId and A.BeIsDeleted=0 where B.EmployeeId=#{id} ORDER BY B.Date DESC limit 5</script>")
    List<DetectImagesTemp> queryForObject1(String id);
    @Select("<script>SELECT B.*,A.REALNAME,A.ORG,A.PARENTORG,A.POLICENUM FROM  fr_original_record as B inner join sys_userinfo as A on A.CollectId = B.CollectId and A.BeIsDeleted=0 where B.CamerId=#{Camid} ORDER BY B.Date DESC limit 5</script>")
    List<DetectImagesTemp> queryForObject2(String Camid);


    @Select("<script>SELECT * FROM fr_camera </script>")
    List<Camera> getCameraName();

    @Select("<script>SELECT B.*,A.REALNAME,A.ORG,A.PARENTORG,A.POLICENUM,A.ID FROM  fr_original_record as B inner join sys_userinfo as A on A.CollectId = B.CollectId and  A.BeIsDeleted=0 and B.CamerId=#{CamerId} and B.TaskType=#{TaskType} and B.Date BETWEEN #{StartTime} and #{EndTime}" +
            "<if test=\"policeNum!=null\">\n" +
            "AND A.POLICENUM=#{policeNum}\n" +
            "</if>\n" +
            " ORDER BY B.id DESC</script>")

    List<DetectImagesTemp> queryForResultCamera(DetectImagesTemp detectImagesTemp);

    @Select("<script>SELECT B.*,A.REALNAME,A.ORG,A.PARENTORG,A.POLICENUM FROM  fr_attendance_record as B inner join sys_userinfo as A on A.CollectId = B.CollectId AND A.BeIsDeleted=0</script>")
    List<Record> getRecord();

    @Select("<script>SELECT B.*,A.REALNAME,A.ORG,A.PARENTORG,A.POLICENUM FROM  fr_attendance_record as B inner join sys_userinfo as A on A.CollectId = B.CollectId AND A.BeIsDeleted=0"+
            "<if test=\"CreateTime1!=null\">\n" +
            "AND B.CreateTime BETWEEN #{CreateTime1} and #{CreateTime2}\n" +
            "</if>\n" +
            "<if test=\"CollectId!=null\">\n" +
            "AND A.CollectId = #{CollectId}\n" +
            "</if>\n" +
            "<if test=\"realName!=null\">\n" +
            "AND A.REALNAME = #{realName}\n" +
            "</if>\n" +
            "<if test=\"org!=null\">\n" +
            "AND A.ORGID = #{org}\n" +
            "</if>\n" +
            "</script>")
    List<Record> queryForNameAndTime(Record record);
    @Select("<script>SELECT B.*,A.REALNAME,A.ORG,A.PARENTORG,A.POLICENUM FROM  fr_attendance_record as B inner join sys_userinfo as A on A.CollectId = B.CollectId and A.BeIsDeleted=0"+
            "<if test=\"CreateTime1!=null\">\n" +
            "AND B.CreateTime BETWEEN #{CreateTime1} and #{CreateTime2}\n" +
            "</if>\n" +
            "</script>")
    List<Record> queryForOrgs(Record record);
    @Select("<script>SELECT  Site FROM fr_camera WHERE CamerId=#{camera}</script>")
    String searchForSite(Integer camera);

    @Update("<script>UPDATE fr_original_record SET EmployeeId=#{EmployeeId},CollectId=#{CollectId},BeforeNum=#{BeforeNum} WHERE CamerId=#{CamerId} and id=#{id}</script>")
    void updateForThisData(DetectImagesTemp detectImages);
    @Select("<script>SELECT A.*,B.realName FROM fr_attendance_record as A inner join sys_userinfo as B on A.CollectId = B.CollectId AND A.id=#{id} AND A.BeIsDeleted=0</script>")
    Record getRecordResultOne(Integer id);
    @Select("<script>SELECT B.*,A.REALNAME,A.ORG,A.PARENTORG,A.POLICENUM FROM  fr_attendance_record as B inner join sys_userinfo as A on A.CollectId = B.CollectId AND A.BeIsDeleted=0"+
            "<if test=\"CreateTime1!=null\">\n" +
            "AND B.CreateTime BETWEEN #{CreateTime1} and #{CreateTime2}\n" +
            "</if>\n" +
            "<if test=\"EmployeeId!=null\">\n" +
            "AND A.POLICENUM = #{EmployeeId}\n" +
            "</if>\n" +
            "<if test=\"realName!=null\">\n" +
            "AND A.REALNAME = #{realName}\n" +
            "</if>\n" +
            "<if test=\"org!=null\">\n" +
            "AND A.ORGID = #{org}\n" +
            "</if>\n" +
            "</script>")
    List<Record> getRecordsToMap(Record record);
    @Select("<script>SELECT value FROM fr_config WHERE name='PictSavedHttpURL'</script>")
    String getPictSaveRootDirectory();
    @Select("<script>SELECT value FROM fr_config WHERE name='PictSaveRootDirectory'</script>")
    String getPictSaveRootDirectoryNew();


    @Select("<script>SELECT  B.*,A.REALNAME,A.ORG,A.PARENTORG,A.CollectId,max(C.Date) as Date FROM  sys_userinfo_picture as B " +
            "inner join sys_userinfo as A on A.picture = B.uuid " +
            " INNER JOIN fr_original_record as C on C.CollectId=A.CollectId and C.CollectId in " +
            "<foreach item='collectIds' index='index' collection='list' open='(' separator=',' close=')'>" +
            " #{collectIds}" +
            " </foreach>" +
            " GROUP BY c.CollectId DESC"+
            " </script>")

    List<UserInfoPicture> queryForObjectSimple(List<Integer> detectImages);

    /*@Select("<script>select * from fr_original_record where id > #{id} and </script>")*/
    @Select("<script>select A.* from fr_original_record as A INNER JOIN fr_signin as B on A.CollectId=B.collectId and  A.id > #{id} and B.mettingId=(select value from fr_metting where id=1)</script>")
    List<DetectImages> queryForCollectIdByFive(Integer id);
    @Select("<script>select  distinct CollectId from fr_original_record ORDER BY Date DESC</script>")
    List<Integer> queryForCollectIds();

    @Select("<script>SELECT  B.*,A.REALNAME,A.ORG,A.PARENTORG,A.CollectId,c.Date FROM  sys_userinfo_picture as B "+
            "inner join sys_userinfo as A on A.picture = B.uuid "+
            "inner join fr_original_record as c on c.CollectId=A.CollectId  and c.Date in (select  max(date)as Date " +
            "from fr_original_record where Date > #{dd} GROUP BY collectid) ORDER BY Date desc"+
            "</script>")
    List<UserInfoPicture> queryForObjectList(String dd);
    @Select("select B.*,c.name from  sys_userinfo as B INNER JOIN fr_signin as A  INNER JOIN sys_userinfo_picture as C where A.signIn=0 and A.mettingId =(select value from fr_metting where id=1)\n" +
            "and B.CollectId=A.collectId and B.PICTURE=C.uuid")
    List<SignIn> queryForSignIn();
    @Update("update fr_signin set signIn=1,signTime=#{Date} where collectId=#{CollectId} and mettingId =(select value from fr_metting where id=1)")
    void updateSignin(DetectImages detectImages);
    @Select("select count(*) from fr_signin where mettingId =(select value from fr_metting where id=1)")
    Integer signSum();
    @Select("select count(*) from fr_signin where signIn=1 and mettingId =(select value from fr_metting where id=1)")
    Integer signPeople();
   @Select("select collectId from fr_signin where signIn=0 and mettingId =(select value from fr_metting where id=1)")
    List<Integer> getSignCollectid();
    @Select("select collectId from fr_signin where signIn=1 and mettingId =(select value from fr_metting where id=1)")
    List<Integer> getSignCollectidRes();

    @Select("select A.REALNAME,A.PARENTORG,A.ORG,A.CollectId,B.name,B.name2,C.signTime as Date from sys_userinfo as A INNER JOIN sys_userinfo_picture as B on A.PICTURE=B.uuid \n" +
            " RIGHT JOIN fr_signin as C on C.collectId=A.CollectId  and C.signIn=1 and mettingId =(select value from fr_metting where id=1)")
    List<UserInfoPicture> getSignData();

    @Select("SELECT max(id) from fr_original_record")
    Integer queryForNowIDMax();


}

