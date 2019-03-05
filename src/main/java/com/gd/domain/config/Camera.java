package com.gd.domain.config;

import com.gd.domain.base.BaseModel;

/**
 * Created by Administrator on 2017/12/21 0021.
 */
public class Camera extends BaseModel {
    private int CamerId;
    private String Site;
    private String TaskType;
    private String url;
    private String ServiceId;
    private String temp;
    private String AttendanceLocationID;
    private String ServiceCameraID;
    private String ServiceIp;
    private int ShowCameraID;
    private int featureID;
    private int camConfigID;
    private int soundID;

    public int getSoundID() {
        return soundID;
    }

    public void setSoundID(int soundID) {
        this.soundID = soundID;
    }

    public int getFeatureID() {
        return featureID;
    }

    public void setFeatureID(int featureID) {
        this.featureID = featureID;
    }

    public int getCamConfigID() {
        return camConfigID;
    }

    public void setCamConfigID(int camConfigID) {
        this.camConfigID = camConfigID;
    }

    public int getShowCameraID() {
        return ShowCameraID;
    }

    public void setShowCameraID(int showCameraID) {
        ShowCameraID = showCameraID;
    }

    public String getServiceIp() {
        return ServiceIp;
    }

    public void setServiceIp(String serviceIp) {
        ServiceIp = serviceIp;
    }

    public String getServiceCameraID() {
        return ServiceCameraID;
    }

    public void setServiceCameraID(String serviceCameraID) {
        ServiceCameraID = serviceCameraID;
    }

    public String getAttendanceLocationID() {
        return AttendanceLocationID;
    }

    public void setAttendanceLocationID(String attendanceLocationID) {
        AttendanceLocationID = attendanceLocationID;
    }

    public String getTemp() {
        return temp;
    }

    public void setTemp(String temp) {
        this.temp = temp;
    }

    public String getSite() {
        return Site;
    }

    public void setSite(String site) {
        Site = site;
    }

    public String getTaskType() {
        return TaskType;
    }
    public int getCamerId() {
        return CamerId;
    }

    public void setCamerId(int camerId) {
        CamerId = camerId;
    }
    public void setTaskType(String taskType) {
        TaskType = taskType;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getServiceId() {
        return ServiceId;
    }

    public void setServiceId(String serviceId) {
        ServiceId = serviceId;
    }
}
