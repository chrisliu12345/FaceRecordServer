package com.gd.domain.config;

public class AttendanceReword {
    private int id;
    private String RealName;
    private String ClockIn;
    private String ClockOff;
    private String AttendanceFlag;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRealName() {
        return RealName;
    }

    public void setRealName(String realName) {
        RealName = realName;
    }

    public String getClockIn() {
        return ClockIn;
    }

    public void setClockIn(String clockIn) {
        ClockIn = clockIn;
    }

    public String getClockOff() {
        return ClockOff;
    }

    public void setClockOff(String clockOff) {
        ClockOff = clockOff;
    }

    public String getAttendanceFlag() {
        return AttendanceFlag;
    }

    public void setAttendanceFlag(String attendanceFlag) {
        AttendanceFlag = attendanceFlag;
    }
}
