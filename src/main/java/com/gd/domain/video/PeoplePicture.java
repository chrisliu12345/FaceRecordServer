package com.gd.domain.video;

import java.util.List;

/**
 * Created by Administrator on 2017/12/22 0022.
 */
public class PeoplePicture {
    private int name;
    private List<SimplePicture> simplePicture;

    public int getName() {
        return name;
    }

    public void setName(int name) {
        this.name = name;
    }

    public List<SimplePicture> getSimplePicture() {
        return simplePicture;
    }

    public void setSimplePicture(List<SimplePicture> simplePicture) {
        this.simplePicture = simplePicture;
    }
}
