package com.gd.dao.video;

import com.gd.domain.query.PeopleCollect;
import com.gd.domain.userinfo.UserInfo;
import com.gd.domain.video.CameraList;
import com.gd.domain.video.CsServices;
import com.gd.domain.video.SimplePicture;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2017/12/22 0022.
 */
@Repository("videoDao")
public interface IVideoDao {
    @Select("<script>SELECT ID,REALNAME,POLICENUM FROM sys_userinfo WHERE ORG=#{org} AND PARENTORG=#{parentorg}</script>")
    List<UserInfo> checkName(UserInfo userInfo);
    @Select("<script>SELECT * FROM fr_sample_photo WHERE SelectedFlag=1 and CollectId=#{CollectId}</script>")
    List<SimplePicture> getPicture1(SimplePicture simplePicture);
    @Select("<script>SELECT * FROM fr_sample_photo WHERE UsedToUpdate=1 and CollectId=#{CollectId}</script>")
    List<SimplePicture> getPicture2(SimplePicture simplePicture);
    @Select("<script>SELECT * FROM fr_sample_photo WHERE  CollectId=#{CollectId}</script>")
    List<SimplePicture> getPicture(SimplePicture simplePicture);
    @Select("<script>select * from fr_person_collection where RegisteredFlag=0</script>")
    List<PeopleCollect> getCollectId();
    @Update("<script>UPDATE fr_person_collection SET EmployeeId=#{EmployeeId} WHERE CollectId=#{CollectId}</script>")
    void updateCollectId(PeopleCollect peopleCollect);
    @Update("<script>UPDATE fr_sample_photo SET SelectedFlag=1 WHERE id=#{id}</script>")
    void updatePicture1(SimplePicture simplePicture);
    @Update("<script>UPDATE fr_sample_photo SET SelectedFlag=0 WHERE id=#{id}</script>")
    void updatePicture2(SimplePicture simplePicture);
    @Select("<script>select  id from fr_sample_photo where CollectId in (SELECT CollectId FROM fr_sample_photo WHERE id=#{id}) </script>")
    List<Integer> queryPictures(SimplePicture simplePicture);
    @Select("<script>select  distinct CollectId,UsedToUpdate from fr_sample_photo group by CollectId HAVING UsedToUpdate=1</script>")
    List<SimplePicture> queryForWaitUser();
    @Select("<script>SELECT A.REALNAME,A.ORG,A.PARENTORG,A.POLICENUM,B.* FROM  sys_userinfo as A inner join fr_person_collection as B  on A.POLICENUM = B.EmployeeId and B.UpdatedOrNot=1</script>")
    List<PeopleCollect> queryForPersonCollection();
    @Select("<script>SELECT value FROM fr_config WHERE name='SystemInterfaceSetting'</script>")
    String getCStatus();
    @Update("<script>UPDATE fr_config SET value=#{a} WHERE name='SystemInterfaceSetting'</script>")
    void updateCStatus(String a);
    @Delete("<script>DELETE FROM fr_person_collection WHERE CollectId=#{i}</script>")
    void deleteSimPic1(int i);
    @Delete("<script>DELETE FROM fr_sample_photo WHERE CollectId=#{i}</script>")
    void deleteSimPic2(int i);
    @Select("<script>select * from fr_person_collection where RegisteredFlag=0 AND EmployeeId Like CONCAT('%',#{employeed},'%')\n</script>")
    List<PeopleCollect> search1(String employeed);
    @Select("<script>select ResID,Name,IPAddress from tbl_res_attr where ResType='131'and IPAddress!=''</script>")
    List<CameraList> searchCameraID();
    @Select("<script>SELECT s.IPAddress FROM tbl_service s INNER JOIN  tbl_res_attr  ra ON s.ServiceID = ra.SipServiceID  WHERE ra.ResID =  #{cameraID}</script>")
    String searchCameraUrl(Integer cameraID);
    /*@Select("<script>select ServiceCameraID from fr_camera where CamerId=(select value from fr_config where name='DisplayCameraIdSetting')</script>")
     Integer getConfigCamID();*/
    @Select("<script>select ServiceCameraID from fr_camera limit 1 </script>")
    Integer getConfigCamID();
    @Select("<script>SELECT * FROM fr_cs_services</script>")
    List<CsServices> getServices();
    @Select("<script>SELECT ServiceCameraID FROM fr_camera WHERE CamerId=#{camid}</script>")
    Integer getShowCamera(Integer camid);
}
