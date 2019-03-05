package com.gd.domain.config;

import com.gd.domain.base.BaseModel;

/**
 * Created by Administrator on 2017/12/21 0021.
 */
public class DisPlay extends BaseModel{
    private int ContentId;

    private String DisplayContent;

    public int getContentId() {
        return ContentId;
    }

    public void setContentId(int contentId) {
        ContentId = contentId;
    }

    public String getDisplayContent() {
        return DisplayContent;
    }

    public void setDisplayContent(String displayContent) {
        DisplayContent = displayContent;
    }
}
