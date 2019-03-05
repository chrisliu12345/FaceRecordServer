package com.gd.controller.video;

import com.gd.domain.org.*;
import com.gd.domain.query.PeopleCollect;
import com.gd.domain.userinfo.UserInfo;
import com.gd.domain.video.SimplePicture;
import com.gd.service.org.IOrgService;
import com.gd.service.orgtree.IOrgTreeService;
import com.gd.service.userinfo.IUserInfoService;
import com.gd.service.video.IVideoService;
import com.google.gson.Gson;
import io.swagger.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 郄梦岩 on 2017/12/22.
 */
@RestController
@RequestMapping("/face")
public class FaceController {
    @Autowired
    private IVideoService iVideoService;
    @Autowired
    private IOrgService orgService;
    @Autowired
    private IUserInfoService userInfoService;
    @Autowired
    private IOrgTreeService orgTreeService;
    @Value("${picture.url}")
    private String pictureUrl;
    @RequestMapping(value = "/{id}", method = RequestMethod.POST)
    @ApiOperation(value = "查询组织Tree", notes = "查询组织Tree", httpMethod = "GET", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiResponses(value = {
            @ApiResponse(code = 401, message = "No Privilege"),
    })
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "组织id", required = true, dataType = "String", paramType = "path")
    })
    public String getGroupTree(@PathVariable("id") String id){
        List<ZTreeParams> zTreeParamsList=new ArrayList<>();
           /* List<Org> orgList=this.orgTreeService.queryForGroupToGroup(id);

            if(orgList.size()>0) {
                for (int i = 0; i < orgList.size(); i++) {
                    ZTreeParams zTreeParamsz = new ZTreeParams();
                    zTreeParamsz.setId(orgList.get(i).getId());
                    zTreeParamsz.setpId(id);
                    zTreeParamsz.setParent(true);
                    zTreeParamsz.setNum("1");
                    zTreeParamsz.setName(orgList.get(i).getOrgName());
                    zTreeParamsList.add(zTreeParamsz);
                }
            }*/

            List<PeopleCollect> userInfoList=getWaitUser();
            if(userInfoList.size()>0) {
                for (int j = 0; j < userInfoList.size(); j++) {
                    ZTreeParams zTreeParamsz = new ZTreeParams();
                    zTreeParamsz.setId(userInfoList.get(j).getId());
                    zTreeParamsz.setpId(id);
                    zTreeParamsz.setNum("2");
                    zTreeParamsz.setIcon("/img/people.png");
                    zTreeParamsz.setCollectId(userInfoList.get(j).getCollectId());
                    zTreeParamsz.setParent(false);
                    zTreeParamsz.setName(userInfoList.get(j).getRealName());
                    zTreeParamsList.add(zTreeParamsz);
                }
            }
            Gson gson = new Gson();
            return gson.toJson(zTreeParamsList);
        }

    //查询待更新人脸的人员
    public List<PeopleCollect> getWaitUser(){
        //查询人员采集表中updateornot为1的所有工号对用的人员表中的人员数据
        List<PeopleCollect> userInfos=this.iVideoService.queryForPersonCollection();
        //查询所有已录入的人员工号
       if(userInfos.size()<=0) {
           return null;
       }else{
        return userInfos;
        }
    }
    //已注册照片获取
    @RequestMapping(value = "/getPicture1/{id}", method = RequestMethod.POST)
    public String getPicture(@PathVariable("id") int id) {
        SimplePicture simplePicture = new SimplePicture();
        simplePicture.setCollectId(id);

        List<SimplePicture> list = this.iVideoService.getPicture1(simplePicture);
        for(int i=0;i<list.size();i++){
            list.get(i).setUrl(pictureUrl);
        }
        Map<String, Object> map = new HashMap<>();
        map.put("data", list);
        Gson gson = new Gson();
        return gson.toJson(map);
    }
    //待更新照片获取
    @RequestMapping(value = "/getPicture2/{id}", method = RequestMethod.POST)
    public String getPicture1(@PathVariable("id") int id) {
        SimplePicture simplePicture = new SimplePicture();
        simplePicture.setCollectId(id);
        List<SimplePicture> list = this.iVideoService.getPicture2(simplePicture);
        for(int i=0;i<list.size();i++){
            list.get(i).setUrl(pictureUrl);
        }
        Map<String, Object> map = new HashMap<>();
        map.put("data", list);
        Gson gson = new Gson();
        return gson.toJson(map);
    }
    @RequestMapping(value = "/updateSelectedFlag1", method = RequestMethod.POST)
    public String updatePictureFace1(@RequestBody List<Integer> addid) {
        for(int i=0;i<addid.size();i++){
            SimplePicture simplePicture=new SimplePicture();
            simplePicture.setId(addid.get(i));
            this.iVideoService.updatePicture1(simplePicture);
        }
        Map<String, Object> map1 = new HashMap<>();
        map1.put("data", "success");
        Gson gson = new Gson();
        return gson.toJson(map1);
    }
    @RequestMapping(value = "/updateSelectedFlag2", method = RequestMethod.POST)
    public String updatePictureFace2(@RequestBody List<Integer> removeid) {
        for(int i=0;i<removeid.size();i++){
            SimplePicture simplePicture=new SimplePicture();
            simplePicture.setId(removeid.get(i));
            this.iVideoService.updatePicture2(simplePicture);
        }
        Map<String, Object> map1 = new HashMap<>();
        map1.put("data", "success");
        Gson gson = new Gson();
        return gson.toJson(map1);
    }
}
