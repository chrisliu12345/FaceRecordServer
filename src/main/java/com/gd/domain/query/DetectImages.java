package com.gd.domain.query;

import com.gd.domain.userinfo.UserInfo;
import org.springframework.format.annotation.DateTimeFormat;

import java.sql.Timestamp;
import java.time.DateTimeException;

/**
 * Created by 郄梦岩 on 2017/12/23.
 */
public class DetectImages {
    private int id;
    private String EmployeeId;
    private int CollectId;
    private Timestamp Date;
    private String DetectetFaceImage;
    private String CurrFrame;
    private int TaskType;
    private int CamerId;
    private String BeforeNum;


    private String temp;

    public int getCollectId() {
        return CollectId;
    }

    public void setCollectId(int collectId) {
        CollectId = collectId;
    }

    public String getTemp() {
        return temp;
    }

    public void setTemp(String temp) {
        this.temp = temp;
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

    public Timestamp getDate() {
        return Date;
    }

    public void setDate(Timestamp date) {
        Date = date;
    }

    public String getDetectetFaceImage() {
        return DetectetFaceImage;
    }

    public void setDetectetFaceImage(String detectetFaceImage) {
        DetectetFaceImage = detectetFaceImage;
    }

    public String getCurrFrame() {
        return CurrFrame;
    }

    public void setCurrFrame(String currFrame) {
        CurrFrame = currFrame;
    }

    public int getTaskType() {
        return TaskType;
    }

    public void setTaskType(int taskType) {
        TaskType = taskType;
    }

    public int getCamerId() {
        return CamerId;
    }

    public void setCamerId(int camerId) {
        CamerId = camerId;
    }

    public String getBeforeNum() {
        return BeforeNum;
    }

    public void setBeforeNum(String beforeNum) {
        BeforeNum = beforeNum;
    }
}
