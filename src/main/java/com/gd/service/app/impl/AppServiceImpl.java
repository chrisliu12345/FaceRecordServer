package com.gd.service.app.impl;

import com.gd.dao.app.IAppDao;
import com.gd.domain.app.App;
import com.gd.domain.base.BaseModel;
import com.gd.service.app.IAppService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by dell on 2017/5/16.
 * Good Luck !
 * へ　　　　　／|
 * 　　/＼7　　　 ∠＿/
 * 　 /　│　　 ／　／
 * 　│　Z ＿,＜　／　　 /`ヽ
 * 　│　　　　　ヽ　　 /　　〉
 * 　 Y　　　　　`　 /　　/
 * 　ｲ●　､　●　　⊂⊃〈　　/
 * 　()　 へ　　　　|　＼〈
 * 　　>ｰ ､_　 ィ　 │ ／／
 * 　 / へ　　 /　ﾉ＜| ＼＼
 * 　 ヽ_ﾉ　　(_／　 │／／
 * 　　7　　　　　　　|／
 * 　　＞―r￣￣`ｰ―＿
 */
@Service("appService")
public class AppServiceImpl implements IAppService {

    @Autowired
    private IAppDao appDao;

    @Override
    public List<App> queryForList(BaseModel baseModel) {
        return this.appDao.queryForList(baseModel);
    }

    @Override
    public int addObject(BaseModel baseModel) {
        return this.appDao.addObject(baseModel);
    }

    @Override
    public int deleteObject(BaseModel baseModel) {
        return this.appDao.deleteObject(baseModel);
    }
}
