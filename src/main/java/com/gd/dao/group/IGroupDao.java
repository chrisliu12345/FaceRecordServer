package com.gd.dao.group;

import com.gd.domain.group.GroupInfo;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by 郄梦岩 on 2017/10/13.
 */
@Repository("groupDao")
public interface IGroupDao {
    @Select("<script>SELECT * FROM sys_group</script>")
     List<GroupInfo> queryForObject();
    @Select("<script>SELECT GroupID FROM sys_group</script>")
    List<Integer> queryForObject1();
    @Select("<script>SELECT PlatformID FROM tbl_platform</script>")
    List<Integer> queryForObject2();

@Insert("<script>INSERT INTO sys_group (GroupID,Type,VirtualOrgID,Name,ParentID,BusinessGroupID,ParentOrgID) VALUES "+
        "(#{GroupID},#{Type},#{VirtualOrgID},#{name},#{ParentID},#{BusinessGroupID},#{ParentOrgID})</script>")
     void addForObject(GroupInfo groupInfo);

@Update("<script>UPDATE sys_group SET Type=#{Type},VirtualOrgID=#{VirtualOrgID},Name=#{name},ParentID=#{ParentID},"+
        "BusinessGroupID=#{BusinessGroupID},ParentOrgID=#{ParentOrgID} WHERE GroupID=#{GroupID}</script>")
    void updateForObject(GroupInfo groupInfo);
@Delete("<script>DELETE FROM sys_group WHERE GroupID=#{GroupID} </script>")
    void deletForObject(GroupInfo groupInfo);

}
