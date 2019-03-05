package com.gd.domain.config;

public class CsServers  {
    private int ServiceId;
    private String ServiceIp;
    private int BeIsCharactered;
    private int ShowCameraID;

    public int getServiceId() {
        return ServiceId;
    }

    public void setServiceId(int serviceId) {
        ServiceId = serviceId;
    }

    public String getServiceIp() {
        return ServiceIp;
    }

    public void setServiceIp(String serviceIp) {
        ServiceIp = serviceIp;
    }

    public int getBeIsCharactered() {
        return BeIsCharactered;
    }

    public void setBeIsCharactered(int beIsCharactered) {
        BeIsCharactered = beIsCharactered;
    }

    public int getShowCameraID() {
        return ShowCameraID;
    }

    public void setShowCameraID(int showCameraID) {
        ShowCameraID = showCameraID;
    }
}
