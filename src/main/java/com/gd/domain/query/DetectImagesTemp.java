package com.gd.domain.query;

import com.gd.domain.userinfo.UserInfo;
import io.swagger.annotations.ApiModelProperty;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

/**
 * Created by 郄梦岩 on 2017/12/23.
 */
public class DetectImagesTemp extends DetectImages {
    @ApiModelProperty(value = "姓名",required = false)
    private String realName;
    @ApiModelProperty(value = "部门")
    private String org;
    @ApiModelProperty(value = "头像")
    private String picture;
    @ApiModelProperty(value = "工号",required = true)
    private String policeNum;
    @ApiModelProperty(value = "上级部门",required = true)
    private String parentorg;
    //部门拼接
    private String orgadd;
    //摄像机拼接
    private String Site;
    //出入口拼接
    private String inout;
    //查询开始时间
    private Timestamp StartTime;
    //查询结束时间
    private Timestamp EndTime;
    /*//对应的collectid
    private int CollectId;*/
    //显示时间拼接
    private String datetmp;
    //连接IP地址
    private String url;
    private String simplePhoto;

    public String getSimplePhoto() {
        return simplePhoto;
    }

    public void setSimplePhoto(String simplePhoto) {
        this.simplePhoto = simplePhoto;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getDatetmp() {
        return datetmp;
    }

    public void setDatetmp(String datetmp) {
        this.datetmp = datetmp;
    }

   /* public int getCollectId() {
        return CollectId;
    }

    public void setCollectId(int collectId) {
        CollectId = collectId;
    }*/

    public String getSite() {
        return Site;
    }

    public void setSite(String site) {
        Site = site;
    }

    public Timestamp getStartTime() {
        return StartTime;
    }

    public void setStartTime(Timestamp startTime) {
        StartTime = startTime;
    }

    public Timestamp getEndTime() {
        return EndTime;
    }

    public void setEndTime(Timestamp endTime) {
        EndTime = endTime;
    }

    public String getOrgadd() {
        return orgadd;
    }

    public void setOrgadd(String orgadd) {
        this.orgadd = orgadd;
    }

    public String getInout() {
        return inout;
    }

    public void setInout(String inout) {
        this.inout = inout;
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

    public String getParentorg() {
        return parentorg;
    }

    public void setParentorg(String parentorg) {
        this.parentorg = parentorg;
    }
}
