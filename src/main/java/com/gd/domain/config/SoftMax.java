package com.gd.domain.config;

/**
 * Created by Administrator on 2018/3/29 0029.
 */
public class SoftMax {
    private int id;
    private int CameraId;
    private int modelType;
    private String modelPath;
    private float fRecogPossibleThresh;
    private float fRecogSumVoteThreash;

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

    public int getModelType() {
        return modelType;
    }

    public void setModelType(int modelType) {
        this.modelType = modelType;
    }

    public String getModelPath() {
        return modelPath;
    }

    public void setModelPath(String modelPath) {
        this.modelPath = modelPath;
    }

    public float getfRecogPossibleThresh() {
        return fRecogPossibleThresh;
    }

    public void setfRecogPossibleThresh(float fRecogPossibleThresh) {
        this.fRecogPossibleThresh = fRecogPossibleThresh;
    }

    public float getfRecogSumVoteThreash() {
        return fRecogSumVoteThreash;
    }

    public void setfRecogSumVoteThreash(float fRecogSumVoteThreash) {
        this.fRecogSumVoteThreash = fRecogSumVoteThreash;
    }
}
