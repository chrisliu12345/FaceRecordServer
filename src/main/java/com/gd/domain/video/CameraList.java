package com.gd.domain.video;

/**
 * Created by Administrator on 2018/1/24 0024.
 */
public class CameraList {
    private  Integer ResID;
    private String IPAddress;
    private String Name;

    public Integer getResID() {
        return ResID;
    }

    public void setResID(Integer resID) {
        ResID = resID;
    }

    public String getIPAddress() {
        return IPAddress;
    }

    public void setIPAddress(String IPAddress) {
        this.IPAddress = IPAddress;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }
}
