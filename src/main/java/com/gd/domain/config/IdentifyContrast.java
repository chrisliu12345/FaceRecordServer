package com.gd.domain.config;

public class IdentifyContrast {
    private int id;
    private int cameraId;
    private int bMouse;
    private int skipFrame;
    private int detectType;
    private float scale;
    private float faceProbThresh;
    private int selectType;
    private float eyesDistThresh;
    private int alignType;
    private int describerType;
    private int maxFrameCache;
    private int maxFrameBatch;
    private float veriThresh;
    private int accFrames;
    private float prob;
    private int sumFrames;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCameraId() {
        return cameraId;
    }

    public void setCameraId(int cameraId) {
        this.cameraId = cameraId;
    }

    public int getbMouse() {
        return bMouse;
    }

    public void setbMouse(int bMouse) {
        this.bMouse = bMouse;
    }

    public int getSkipFrame() {
        return skipFrame;
    }

    public void setSkipFrame(int skipFrame) {
        this.skipFrame = skipFrame;
    }

    public int getDetectType() {
        return detectType;
    }

    public void setDetectType(int detectType) {
        this.detectType = detectType;
    }

    public float getScale() {
        return scale;
    }

    public void setScale(float scale) {
        this.scale = scale;
    }

    public float getFaceProbThresh() {
        return faceProbThresh;
    }

    public void setFaceProbThresh(float faceProbThresh) {
        this.faceProbThresh = faceProbThresh;
    }

    public int getSelectType() {
        return selectType;
    }

    public void setSelectType(int selectType) {
        this.selectType = selectType;
    }

    public float getEyesDistThresh() {
        return eyesDistThresh;
    }

    public void setEyesDistThresh(float eyesDistThresh) {
        this.eyesDistThresh = eyesDistThresh;
    }

    public int getAlignType() {
        return alignType;
    }

    public void setAlignType(int alignType) {
        this.alignType = alignType;
    }

    public int getDescriberType() {
        return describerType;
    }

    public void setDescriberType(int describerType) {
        this.describerType = describerType;
    }

    public int getMaxFrameCache() {
        return maxFrameCache;
    }

    public void setMaxFrameCache(int maxFrameCache) {
        this.maxFrameCache = maxFrameCache;
    }

    public int getMaxFrameBatch() {
        return maxFrameBatch;
    }

    public void setMaxFrameBatch(int maxFrameBatch) {
        this.maxFrameBatch = maxFrameBatch;
    }

    public float getVeriThresh() {
        return veriThresh;
    }

    public void setVeriThresh(float veriThresh) {
        this.veriThresh = veriThresh;
    }

    public int getAccFrames() {
        return accFrames;
    }

    public void setAccFrames(int accFrames) {
        this.accFrames = accFrames;
    }

    public float getProb() {
        return prob;
    }

    public void setProb(float prob) {
        this.prob = prob;
    }

    public int getSumFrames() {
        return sumFrames;
    }

    public void setSumFrames(int sumFrames) {
        this.sumFrames = sumFrames;
    }
}
