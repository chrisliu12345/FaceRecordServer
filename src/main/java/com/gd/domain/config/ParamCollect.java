package com.gd.domain.config;

/**
 * Created by Administrator on 2017/12/28 0028.
 */
public class ParamCollect {
    private int id;
    private int CameraId;
    private int distThresh;
    private int sharpnessThresh;
    private int perDirectNum;
    private float scale;
    private float probThresh;
    private String rotationThresh;
    private String roiInfo;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCameraId() {
        return CameraId;
    }

    public void setCameraId(int cameraId) {
        CameraId = cameraId;
    }

    public int getDistThresh() {
        return distThresh;
    }

    public void setDistThresh(int distThresh) {
        this.distThresh = distThresh;
    }

    public int getSharpnessThresh() {
        return sharpnessThresh;
    }

    public void setSharpnessThresh(int sharpnessThresh) {
        this.sharpnessThresh = sharpnessThresh;
    }

    public int getPerDirectNum() {
        return perDirectNum;
    }

    public void setPerDirectNum(int perDirectNum) {
        this.perDirectNum = perDirectNum;
    }

    public float getScale() {
        return scale;
    }

    public void setScale(float scale) {
        this.scale = scale;
    }

    public float getProbThresh() {
        return probThresh;
    }

    public void setProbThresh(float probThresh) {
        this.probThresh = probThresh;
    }

    public String getRotationThresh() {
        return rotationThresh;
    }

    public void setRotationThresh(String rotationThresh) {
        this.rotationThresh = rotationThresh;
    }

    public String getRoiInfo() {
        return roiInfo;
    }

    public void setRoiInfo(String roiInfo) {
        this.roiInfo = roiInfo;
    }
}
