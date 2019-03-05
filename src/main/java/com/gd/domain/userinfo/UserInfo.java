package com.gd.domain.userinfo;

import com.gd.domain.base.BaseModel;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.util.List;

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
@SuppressWarnings("unused")
@ApiModel(value = "用户对象",description = "UserInfo")
public class UserInfo extends BaseModel {
    @ApiModelProperty(value = "姓名",required = false)
    private String realName;
    @ApiModelProperty(value = "部门名称")
    private String org;
    @ApiModelProperty(value = "部门id")
    private String orgId;
    @ApiModelProperty(value = "头像")
    private String picture;
    @ApiModelProperty(value = "工号",required = true)
    private String policeNum;
    @ApiModelProperty(value = "个性签名")
    private String autoGraph;
    @ApiModelProperty(value = "上级部门id")
    private String parentorg;
    private String orgName;
    private int CollectId;
    private int BeIsRegistered;
    private int BeIsDeleted;

    public int getBeIsDeleted() {
        return BeIsDeleted;
    }

    public void setBeIsDeleted(int beIsDeleted) {
        BeIsDeleted = beIsDeleted;
    }

    public int getCollectId() {
        return CollectId;
    }

    public void setCollectId(int collectId) {
        CollectId = collectId;
    }

    public int getBeIsRegistered() {
        return BeIsRegistered;
    }

    public void setBeIsRegistered(int beIsRegistered) {
        BeIsRegistered = beIsRegistered;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getOrg() {
        return org;
    }

    public void setOrg(String org) {
        this.org = org;
    }

    public String getOrgId() {
        return orgId;
    }

    public void setOrgId(String orgId) {
        this.orgId = orgId;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public String getPoliceNum() {
        return policeNum;
    }

    public void setPoliceNum(String policeNum) {
        this.policeNum = policeNum;
    }

    public String getAutoGraph() {
        return autoGraph;
    }

    public void setAutoGraph(String autoGraph) {
        this.autoGraph = autoGraph;
    }

    public String getParentorg() {
        return parentorg;
    }

    public void setParentorg(String parentorg) {
        this.parentorg = parentorg;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }
}
