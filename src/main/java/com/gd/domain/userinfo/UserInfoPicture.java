package com.gd.domain.userinfo;

import java.sql.Timestamp;

/**
 * Created by Administrator on 2017/12/12 0012.
 */
public class UserInfoPicture  extends UserInfo{

    private String name;
    private String name2;
    private String voice;
    private String uuid;
    private String url;
    private String Date;

    public String getName2() {
        return name2;
    }

    public void setName2(String name2) {
        this.name2 = name2;
    }

    public String getDate() {
        return Date;
    }

    public void setDate(String date) {
        Date = date;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getVoice() {
        return voice;
    }

    public void setVoice(String voice) {
        this.voice = voice;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


}
