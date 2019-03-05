package com.gd.domain.query;

/**
 * Created by Administrator on 2018/4/23 0023.
 */
public class TimeLine {
    private int id;
    private String content;
    private String start;
    private String end;
    private String startData;
    private String endData;

    public String getEndData() {
        return endData;
    }

    public void setEndData(String endData) {
        this.endData = endData;
    }

    public String getStartData() {

        return startData;
    }

    public void setStartData(String startData) {
        this.startData = startData;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getEnd() {
        return end;
    }

    public void setEnd(String end) {
        this.end = end;
    }
}
