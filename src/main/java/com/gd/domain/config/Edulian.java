package com.gd.domain.config;

/**
 * Created by Administrator on 2018/3/29 0029.
 */
public class Edulian {
    private int id;
    private int CameraId;
    private int modelType;
    private String modelPath;
    private float matchThresh;
    private float unMatchThresh;
    private float IOUThresh;
    private int recogSumVoteThresh;
    private int maxListLength;

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

    public float getMatchThresh() {
        return matchThresh;
    }

    public void setMatchThresh(float matchThresh) {
        this.matchThresh = matchThresh;
    }

    public float getUnMatchThresh() {
        return unMatchThresh;
    }

    public void setUnMatchThresh(float unMatchThresh) {
        this.unMatchThresh = unMatchThresh;
    }

    public float getIOUThresh() {
        return IOUThresh;
    }

    public void setIOUThresh(float IOUThresh) {
        this.IOUThresh = IOUThresh;
    }

    public int getRecogSumVoteThresh() {
        return recogSumVoteThresh;
    }

    public void setRecogSumVoteThresh(int recogSumVoteThresh) {
        this.recogSumVoteThresh = recogSumVoteThresh;
    }

    public int getMaxListLength() {
        return maxListLength;
    }

    public void setMaxListLength(int maxListLength) {
        this.maxListLength = maxListLength;
    }
}
