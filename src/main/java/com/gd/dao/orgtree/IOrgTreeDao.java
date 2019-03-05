package com.gd.dao.orgtree;


import com.gd.domain.config.CameraLocation;
import com.gd.domain.org.Org;
import com.gd.domain.userinfo.UserInfo;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by dell on 2017/5/5.
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
@Repository("orgTreeDao")
public interface IOrgTreeDao {
    @Insert("<script>INSERT INTO sys_orgtree " +
            "(ID, ORGID, CHILDRENID) VALUES " +
            "  (#{id},#{orgId},#{childrenId})</script>")
    int insert(Map<String, String> map);


    @Select("<script>SELECT  * FROM sys_orgtree WHERE 1=1\n" +
            "<if test=\"id!=null and id!=''\">\n" +
            "AND ID=#{id}\n" +
            "</if>\n" +
            "<if test=\"orgId!=null and orgId!=''\">\n" +
            "AND ORGID=#{orgId}\n" +
            "</if>\n" +
            "<if test=\"childrenId!=null and childrenId!=''\">\n" +
            "AND CHILDRENID=#{childrenId}\n" +
            "</if>\n" +
            "</script>")
    List<Map<String, String>> queryForList(Map<String, String> map);
    //删除关联，因为删除的是没有儿子的节点
    @Delete("<script>DELETE FROM sys_orgtree WHERE CHILDRENID=#{id}</script>")
    int delete(String id);

    @Select("<script>SELECT * FROM fr_attendance_location</script>")
    List<CameraLocation> queryForCameraLoaction();

    @Select("<script>SELECT * FROM fr_attendance_location WHERE AttendanceLocationID=#{id}</script>")
    CameraLocation queryForlocationNow(Integer id);
    @Select("<script>SELECT * FROM sys_userinfo WHERE ORGID=#{id} AND BeIsDeleted=0 </script>")
    List<UserInfo> queryForGroupToUser(String id);
    @Select("<script>SELECT * FROM sys_org WHERE PARENTID=#{id}</script>")
    List<Org> queryForGroupToGroup(String id);
}
