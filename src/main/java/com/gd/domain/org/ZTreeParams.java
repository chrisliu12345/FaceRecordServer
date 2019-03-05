package com.gd.domain.org;

/**
 * Created by Administrator on 2018/1/11 0011.
 */
public class ZTreeParams {
    private String id;//组ID
    private String pId;//父组ID
    private String name;//名称
    private boolean isParent;//是否有子节点
    private String icon;//摄像机图片
    private String num;//判断是组还是人，组是1，人是2
    private int collectId;//

    public int getCollectId() {
        return collectId;
    }

    public void setCollectId(int collectId) {
        this.collectId = collectId;
    }

    public String getNum() {
        return num;
    }

    public void setNum(String num) {
        this.num = num;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public boolean isParent() {
        return isParent;
    }

    public void setParent(boolean parent) {
        isParent = parent;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getpId() {
        return pId;
    }

    public void setpId(String pId) {
        this.pId = pId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
