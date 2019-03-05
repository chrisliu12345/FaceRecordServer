package com.gd.domain.config;

import java.sql.Time;
import java.util.List;

public class SaveConfig {
    private Integer PlanID;
    private Integer CamID;
    private String CameraName;
    private Integer StreamingID;
    private Integer WorkDay;
    private Integer KeepTime;
    private Integer IslostStop;
    private Time StartTime;
    private Time StopTime;
    private String start;
    private String stop;
    private List<String> dayTemp;

    public Integer getPlanID() {
        return PlanID;
    }

    public void setPlanID(Integer planID) {
        PlanID = planID;
    }

    public Integer getCamID() {
        return CamID;
    }

    public void setCamID(Integer camID) {
        CamID = camID;
    }

    public String getCameraName() {
        return CameraName;
    }

    public void setCameraName(String cameraName) {
        CameraName = cameraName;
    }

    public Integer getStreamingID() {
        return StreamingID;
    }

    public void setStreamingID(Integer streamingID) {
        StreamingID = streamingID;
    }

    public Integer getWorkDay() {
        return WorkDay;
    }

    public void setWorkDay(Integer workDay) {
        WorkDay = workDay;
    }

    public Integer getKeepTime() {
        return KeepTime;
    }

    public void setKeepTime(Integer keepTime) {
        KeepTime = keepTime;
    }

    public Integer getIslostStop() {
        return IslostStop;
    }

    public void setIslostStop(Integer islostStop) {
        IslostStop = islostStop;
    }

    public Time getStartTime() {
        return StartTime;
    }

    public void setStartTime(Time startTime) {
        StartTime = startTime;
    }

    public Time getStopTime() {
        return StopTime;
    }

    public void setStopTime(Time stopTime) {
        StopTime = stopTime;
    }

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getStop() {
        return stop;
    }

    public void setStop(String stop) {
        this.stop = stop;
    }

    public List<String> getDayTemp() {
        return dayTemp;
    }

    public void setDayTemp(List<String> dayTemp) {
        this.dayTemp = dayTemp;
    }
}
