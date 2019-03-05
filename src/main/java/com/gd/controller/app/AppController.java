package com.gd.controller.app;

import com.gd.domain.app.App;

import com.gd.service.app.IAppService;

import com.gd.util.TextToSpeak;
import com.gd.util.TimeUtils;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.*;

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
@RestController
@RequestMapping("/app")
public class AppController {

    String filePath = "file/";
    @Autowired
    private IAppService appService;


    @RequestMapping(method = RequestMethod.GET)
    public String queryForList() {
        List<App> appList = new ArrayList<>();
        Map<String, Object> resultMap = new HashMap<>();
        appList = this.appService.queryForList(new App());
        resultMap.put("code", "0000");
        resultMap.put("data", appList);

        Gson gson = new Gson();
        return gson.toJson(resultMap);
    }

    @RequestMapping(method = RequestMethod.POST)
    public String add(@RequestBody App app) {
        Map<String, Object> resultMap = new HashMap<>();
        Gson gson = new Gson();
        if (StringUtils.isEmpty(app)) {
            resultMap.put("code", "0002");
            resultMap.put("data", "authority insert failed");
            return gson.toJson(resultMap);
        }
        app.setId(UUID.randomUUID().toString());
        app.setCreateTime(TimeUtils.getCurrentTime());
        app.setUpdateTime(TimeUtils.getCurrentTime());
        app.setIfuse("y");
        int flag = this.appService.addObject(app);

        if (flag == 1) {
            resultMap.put("code", "0000");
            resultMap.put("data", "success");
        } else {
            resultMap.put("code", "0092");
            resultMap.put("data", "app insert failed");
        }

        return gson.toJson(resultMap);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public String delete(@PathVariable("id") String id) {
        App app = new App();
        app.setId(id);
        int flag = this.appService.deleteObject(app);
        Map<String, Object> resultMap = new HashMap<>();
        if (flag == 1) {
            resultMap.put("code", "0000");
            resultMap.put("data", "success");
        } else {
            resultMap.put("code", "0091");
            resultMap.put("data", "app delete failed");
        }
        Gson gson = new Gson();
        return gson.toJson(resultMap);
    }

}
