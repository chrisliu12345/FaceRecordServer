package com.gd.domain.config;

/**
 * Created by Administrator on 2017/12/28 0028.
 */
public class ParamIdentify {
    private int id;
    private int CameraId;
    private String recognisePath;
    private int bMouse;
    private int skipFrame;
    private int DetectType;
    private float faceProbThresh;
    private int scale;
    private int eyesDistThresh;
    private float sideFaceThresh;
    private float upFaceThresh;
    private float downFaceThresh;
    private int faceSharpThresh;
    private int maxFrameCache;
    private int maxFrameBatch;
    private int modelType;
    private int SelectType;
    private int AlignType;
    private int DescriberType;

    public int getDetectType() {
        return DetectType;
    }

    public void setDetectType(int detectType) {
        DetectType = detectType;
    }

    public int getSelectType() {
        return SelectType;
    }

    public void setSelectType(int selectType) {
        SelectType = selectType;
    }

    public int getAlignType() {
        return AlignType;
    }

    public void setAlignType(int alignType) {
        AlignType = alignType;
    }

    public int getDescriberType() {
        return DescriberType;
    }

    public void setDescriberType(int describerType) {
        DescriberType = describerType;
    }

    public int getbMouse() {
        return bMouse;
    }

    public void setbMouse(int bMouse) {
        this.bMouse = bMouse;
    }
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

    public String getRecognisePath() {
        return recognisePath;
    }

    public void setRecognisePath(String recognisePath) {
        this.recognisePath = recognisePath;
    }

    public int getSkipFrame() {
        return skipFrame;
    }

    public void setSkipFrame(int skipFrame) {
        this.skipFrame = skipFrame;
    }

    public int getScale() {
        return scale;
    }

    public void setScale(int scale) {
        this.scale = scale;
    }

    public float getFaceProbThresh() {
        return faceProbThresh;
    }

    public void setFaceProbThresh(float faceProbThresh) {
        this.faceProbThresh = faceProbThresh;
    }

    public int getEyesDistThresh() {
        return eyesDistThresh;
    }

    public void setEyesDistThresh(int eyesDistThresh) {
        this.eyesDistThresh = eyesDistThresh;
    }

    public float getSideFaceThresh() {
        return sideFaceThresh;
    }

    public void setSideFaceThresh(float sideFaceThresh) {
        this.sideFaceThresh = sideFaceThresh;
    }

    public float getUpFaceThresh() {
        return upFaceThresh;
    }

    public void setUpFaceThresh(float upFaceThresh) {
        this.upFaceThresh = upFaceThresh;
    }

    public float getDownFaceThresh() {
        return downFaceThresh;
    }

    public void setDownFaceThresh(float downFaceThresh) {
        this.downFaceThresh = downFaceThresh;
    }

    public int getFaceSharpThresh() {
        return faceSharpThresh;
    }

    public void setFaceSharpThresh(int faceSharpThresh) {
        this.faceSharpThresh = faceSharpThresh;
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

    public int getModelType() {
        return modelType;
    }

    public void setModelType(int modelType) {
        this.modelType = modelType;
    }
}
