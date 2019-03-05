package com.gd.domain.video;


/**
 * Created by 郄梦岩 on 2017/10/19.
 */
public class Channel {
    private int ChannelID;
    private int CamID;
    private int NvrID;
    private String NvrChannelID;
    private int FrameRate;
    private String BitRateType;
    private int BitRate;
    private String PlayUrl;
    private String Resolution;
    private int AudioFlag;
    private int AudioEncoderType;
    private int AudioBitRate;
    private int AudioSampleRate;
    private int UseType;
    private String branch;
    private String groups;




    public String getBranch() {
        return branch;
    }

    public void setBranch(String branch) {
        this.branch = branch;
    }

    public String getGroups() {
        return groups;
    }

    public void setGroups(String groups) {
        this.groups = groups;
    }

    public int getChannelID() {
        return ChannelID;
    }

    public void setChannelID(int channelID) {
        ChannelID = channelID;
    }

    public int getCamID() {
        return CamID;
    }

    public void setCamID(int camID) {
        CamID = camID;
    }

    public int getNvrID() {
        return NvrID;
    }

    public void setNvrID(int nvrID) {
        NvrID = nvrID;
    }

    public String getNvrChannelID() {
        return NvrChannelID;
    }

    public void setNvrChannelID(String nvrChannelID) {
        NvrChannelID = nvrChannelID;
    }

    public int getFrameRate() {
        return FrameRate;
    }

    public void setFrameRate(int frameRate) {
        FrameRate = frameRate;
    }

    public String getBitRateType() {
        return BitRateType;
    }

    public void setBitRateType(String bitRateType) {
        BitRateType = bitRateType;
    }

    public int getBitRate() {
        return BitRate;
    }

    public void setBitRate(int bitRate) {
        BitRate = bitRate;
    }

    public String getPlayUrl() {
        return PlayUrl;
    }

    public void setPlayUrl(String playUrl) {
        PlayUrl = playUrl;
    }

    public String getResolution() {
        return Resolution;
    }

    public void setResolution(String resolution) {
        Resolution = resolution;
    }

    public int getAudioFlag() {
        return AudioFlag;
    }

    public void setAudioFlag(int audioFlag) {
        AudioFlag = audioFlag;
    }

    public int getAudioEncoderType() {
        return AudioEncoderType;
    }

    public void setAudioEncoderType(int audioEncoderType) {
        AudioEncoderType = audioEncoderType;
    }

    public int getAudioBitRate() {
        return AudioBitRate;
    }

    public void setAudioBitRate(int audioBitRate) {
        AudioBitRate = audioBitRate;
    }

    public int getAudioSampleRate() {
        return AudioSampleRate;
    }

    public void setAudioSampleRate(int audioSampleRate) {
        AudioSampleRate = audioSampleRate;
    }

    public int getUseType() {
        return UseType;
    }

    public void setUseType(int useType) {
        UseType = useType;
    }
}
