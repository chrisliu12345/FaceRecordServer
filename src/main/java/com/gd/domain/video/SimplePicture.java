package com.gd.domain.video;

import com.gd.domain.base.BaseModel;

/**
 * Created by Administrator on 2017/12/22 0022.
 */
public class SimplePicture {
    private int id;
    private int CollectId;
    private String RelativePath;
    private int UsedToUpdate;
    private int SelectedFlag;
    private int wait;
    private int BeIsRegistered;
    private String FailReasons;
    private String url;
    private String userName;
    private String picName;
    private String realName;
    private boolean shows;

    public boolean isShows() {
        return shows;
    }

    public void setShows(boolean shows) {
        this.shows = shows;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getPicName() {
        return picName;
    }

    public void setPicName(String picName) {
        this.picName = picName;
    }

    public int getBeIsRegistered() {
        return BeIsRegistered;
    }

    public void setBeIsRegistered(int beIsRegistered) {
        BeIsRegistered = beIsRegistered;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getFailReasons() {
        return FailReasons;
    }

    public void setFailReasons(String failReasons) {
        FailReasons = failReasons;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getWait() {
        return wait;
    }

    public void setWait(int wait) {
        this.wait = wait;
    }

    public int getCollectId() {
        return CollectId;
    }

    public void setCollectId(int collectId) {
        CollectId = collectId;
    }

    public String getRelativePath() {
        return RelativePath;
    }

    public void setRelativePath(String relativePath) {
        RelativePath = relativePath;
    }

    public int getUsedToUpdate() {
        return UsedToUpdate;
    }

    public void setUsedToUpdate(int usedToUpdate) {
        UsedToUpdate = usedToUpdate;
    }

    public int getSelectedFlag() {
        return SelectedFlag;
    }

    public void setSelectedFlag(int selectedFlag) {
        SelectedFlag = selectedFlag;
    }
}
