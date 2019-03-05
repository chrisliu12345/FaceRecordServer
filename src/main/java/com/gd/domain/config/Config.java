package com.gd.domain.config;

import com.gd.domain.base.BaseModel;

import java.util.List;

/**
 * Created by Administrator on 2017/12/19 0019.
 */
public class Config  extends BaseModel{
    private String StartTime;
    private String EndTime;
    private String StartRestTime;
    private String EndRestTime;
    private String StartWrok;
    private String EndWork;
    private String NoWork;
    private String Selected;
    private String RestDay;
    private String StartAddWorkTime;

    public String getStartAddWorkTime() {
        return StartAddWorkTime;
    }

    public void setStartAddWorkTime(String startAddWorkTime) {
        StartAddWorkTime = startAddWorkTime;
    }

    public String getRestDay() {
        return RestDay;
    }

    public void setRestDay(String restDay) {
        RestDay = restDay;
    }

    public String getStartTime() {
        return StartTime;
    }

    public void setStartTime(String startTime) {
        StartTime = startTime;
    }

    public String getEndTime() {
        return EndTime;
    }

    public void setEndTime(String endTime) {
        EndTime = endTime;
    }

    public String getStartRestTime() {
        return StartRestTime;
    }

    public void setStartRestTime(String startRestTime) {
        StartRestTime = startRestTime;
    }

    public String getEndRestTime() {
        return EndRestTime;
    }

    public void setEndRestTime(String endRestTime) {
        EndRestTime = endRestTime;
    }

    public String getStartWrok() {
        return StartWrok;
    }

    public void setStartWrok(String startWrok) {
        StartWrok = startWrok;
    }

    public String getEndWork() {
        return EndWork;
    }

    public void setEndWork(String endWork) {
        EndWork = endWork;
    }

    public String getNoWork() {
        return NoWork;
    }

    public void setNoWork(String noWork) {
        NoWork = noWork;
    }

    public String getSelected() {
        return Selected;
    }

    public void setSelected(String selected) {
        Selected = selected;
    }
}
