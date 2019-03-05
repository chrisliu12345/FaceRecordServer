package com.gd.domain.query;

import com.gd.domain.userinfo.UserInfo;

/**
 * Created by Administrator on 2017/12/25 0025.
 */
public class PeopleCollect  extends UserInfo{
    private String EmployeeId;
    private int CollectId;
    private int RegisteredFlag;
    private int UpdatedOrNot;

    public String getEmployeeId() {
        return EmployeeId;
    }

    public void setEmployeeId(String employeeId) {
        EmployeeId = employeeId;
    }

    public int getCollectId() {
        return CollectId;
    }

    public void setCollectId(int collectId) {
        CollectId = collectId;
    }

    public int getRegisteredFlag() {
        return RegisteredFlag;
    }

    public void setRegisteredFlag(int registeredFlag) {
        RegisteredFlag = registeredFlag;
    }

    public int getUpdatedOrNot() {
        return UpdatedOrNot;
    }

    public void setUpdatedOrNot(int updatedOrNot) {
        UpdatedOrNot = updatedOrNot;
    }
}
