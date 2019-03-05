package com.gd.dao.app;

import com.gd.domain.app.App;
import com.gd.domain.base.BaseModel;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by dell on 2017/5/16.
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
@Repository("appDao")
public interface IAppDao {
    @Select("<script>SELECT  * FROM tbl_app WHERE 1=1\n" +
            "<if test=\"id!=null and id!=''\">\n" +
            "AND ID=#{id}\n" +
            "</if>\n" +
            "<if test=\"name!=null and name!=''\">\n" +
            "AND NAME=#{name}\n" +
            "</if>\n" +
            "<if test=\"ifuse!=null and ifuse!=''\">\n" +
            "AND IFUSE=#{ifuse}\n" +
            "</if></script>")
     List<App> queryForList(BaseModel baseModel);
    @Insert("<script>INSERT INTO tbl_app " +
            "(ID, NAME, DESCRIPTION, CREATETIME, UPDATETIME, IFUSE, ORDERNUM) VALUES " +
            "  (#{id},#{name},#{description},#{createTime},#{updateTime},#{ifuse},#{orderNum})</script>")
    int addObject(BaseModel baseModel);
    @Delete("<script>DELETE FROM tbl_app WHERE ID=#{id}</script>")
    int deleteObject(BaseModel baseModel);
}
