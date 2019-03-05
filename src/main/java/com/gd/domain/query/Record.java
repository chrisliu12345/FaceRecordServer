package com.gd.domain.query;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * Created by 郄梦岩 on 2017/12/24.
 */
public class Record {
    private int id;
    private String EmployeeId;
    private int CollectId;
    private Timestamp ClockIn;
    private Timestamp ClockOff;
    private String AttendanceFlag;
    private String Flag1;//迟到
    private String Flag2;//早退
    private String Flag3;//旷工
    private String Flag4;//加班
    private String org;//部门
    private String parentorg;//上级部门
    private String realName;//姓名
    private Date CreateTime1;
    private Date CreateTime2;
    private Date CreateTime;
    private String ClockInTemp;
    private String ClockOffTemp;
    private String ORGID;

    public String getORGID() {
        return ORGID;
    }

    public void setORGID(String ORGID) {
        this.ORGID = ORGID;
    }

    public int getCollectId() {
        return CollectId;
    }

    public void setCollectId(int collectId) {
        CollectId = collectId;
    }

    public String getClockInTemp() {
        return ClockInTemp;
    }

    public void setClockInTemp(String clockInTemp) {
        ClockInTemp = clockInTemp;
    }

    public String getClockOffTemp() {
        return ClockOffTemp;
    }

    public void setClockOffTemp(String clockOffTemp) {
        ClockOffTemp = clockOffTemp;
    }

    public Date getCreateTime() {
        return CreateTime;
    }

    public void setCreateTime(Date createTime) {
        CreateTime = createTime;
    }

    public Date getCreateTime1() {
        return CreateTime1;
    }

    public void setCreateTime1(Date createTime1) {
        CreateTime1 = createTime1;
    }

    public Date getCreateTime2() {
        return CreateTime2;
    }

    public void setCreateTime2(Date createTime2) {
        CreateTime2 = createTime2;
    }

    public String getOrg() {
        return org;
    }

    public void setOrg(String org) {
        this.org = org;
    }

    public String getParentorg() {
        return parentorg;
    }

    public void setParentorg(String parentorg) {
        this.parentorg = parentorg;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmployeeId() {
        return EmployeeId;
    }

    public void setEmployeeId(String employeeId) {
        EmployeeId = employeeId;
    }

    public Timestamp getClockIn() {
        return ClockIn;
    }

    public void setClockIn(Timestamp clockIn) {
        ClockIn = clockIn;
    }

    public Timestamp getClockOff() {
        return ClockOff;
    }

    public void setClockOff(Timestamp clockOff) {
        ClockOff = clockOff;
    }

    public String getAttendanceFlag() {
        return AttendanceFlag;
    }

    public void setAttendanceFlag(String attendanceFlag) {
        AttendanceFlag = attendanceFlag;
    }

    public String getFlag1() {
        return Flag1;
    }

    public void setFlag1(String flag1) {
        Flag1 = flag1;
    }

    public String getFlag2() {
        return Flag2;
    }

    public void setFlag2(String flag2) {
        Flag2 = flag2;
    }

    public String getFlag3() {
        return Flag3;
    }

    public void setFlag3(String flag3) {
        Flag3 = flag3;
    }

    public String getFlag4() {
        return Flag4;
    }

    public void setFlag4(String flag4) {
        Flag4 = flag4;
    }
}
