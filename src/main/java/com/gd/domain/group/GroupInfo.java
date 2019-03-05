package com.gd.domain.group;



import java.util.List;

/**
 * Created by 郄梦岩 on 2017/10/13.
 */
public class GroupInfo {
    private Integer GroupID;
    private Integer Type;
    private String VirtualOrgID;
    /*private String Name;*/
    private String name;
    private Integer ParentID;
    private String BusinessGroupID;
    private String ParentOrgID;
    private String groups;

    private String branch;
    private int id;
    private int pId;
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getpId() {
        return pId;
    }

    public void setpId(int pId) {
        this.pId = pId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBranch() {
        return branch;
    }

    public void setBranch(String branch) {
        this.branch = branch;
    }



    public String getGroups() {
        return groups;
    }

    public void setGroups(String groups) {
        this.groups = groups;
    }

    public Integer getGroupID() {
        return GroupID;
    }

    public void setGroupID(Integer groupID) {
        GroupID = groupID;
    }

    public Integer getType() {
        return Type;
    }

    public void setType(Integer type) {
        Type = type;
    }

    public String getVirtualOrgID() {
        return VirtualOrgID;
    }

    public void setVirtualOrgID(String virtualOrgID) {
        VirtualOrgID = virtualOrgID;
    }

  /*  public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }
*/

    public Integer getParentID() {
        return ParentID;
    }

    public void setParentID(Integer parentID) {
        ParentID = parentID;
    }

    public String getBusinessGroupID() {
        return BusinessGroupID;
    }

    public void setBusinessGroupID(String businessGroupID) {
        BusinessGroupID = businessGroupID;
    }

    public String getParentOrgID() {
        return ParentOrgID;
    }

    public void setParentOrgID(String parentOrgID) {
        ParentOrgID = parentOrgID;
    }
}
