package com.gd.controller.orgtree;

import com.gd.domain.account_camera.Account_Camera;


import com.gd.domain.config.CameraLocation;
import com.gd.domain.group.GroupInfo;
import com.gd.domain.org.*;


import com.gd.domain.userinfo.UserInfo;



import com.gd.service.group.IGroupService;
import com.gd.service.org.IOrgService;
import com.gd.service.orgtree.IOrgTreeService;

import com.gd.service.userinfo.IUserInfoService;
import com.gd.util.BeanToMap;
import com.google.gson.Gson;

import io.swagger.annotations.*;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by dell on 2017/5/5.
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
@RequestMapping("/orgtree")
public class OrgTreeController {
    @Autowired
    private IOrgTreeService orgTreeService;
    @Autowired
    private IOrgService orgService;
    @Autowired
    private IUserInfoService userInfoService;





    @RequestMapping(value = "/{id}", method = RequestMethod.POST)
    @ApiOperation(value = "查询组织Tree", notes = "查询组织Tree", httpMethod = "GET", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiResponses(value = {
            @ApiResponse(code = 401, message = "No Privilege"),
    })
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "组织id", required = true, dataType = "String", paramType = "path")
    })
    public String getGroupTree(@PathVariable("id") String id){
        //查询一级目录（如：北京航天长峰股份有限公司）
        Org0 org=new Org0();
        org.setOrderNum("1");
        List<Org0> org0=this.orgService.queryForObject0(org);
        //查询所有组
        ZTreeParams zTreeParams=new ZTreeParams();
        zTreeParams.setId(org0.get(0).getId());
        zTreeParams.setName(org0.get(0).getOrgName());
        zTreeParams.setpId(org0.get(0).getParentId());
        zTreeParams.setNum("1");
        zTreeParams.setIcon("/img/group.png");
        zTreeParams.setParent(true);
        Map<String ,Object> map=new HashMap<>();
        map.put("code","0000");
        map.put("data",zTreeParams);
        Gson gson=new Gson();
        return gson.toJson(map);
    }
    @RequestMapping(value = "/getCtree/{id}", method = RequestMethod.POST)
    public String get1zTree(@PathVariable("id") String id) {
        List<Org> orgList=this.orgTreeService.queryForGroupToGroup(id);
        List<ZTreeParams> zTreeParamsList=new ArrayList<>();
        if(orgList.size()>0) {
            for (int i = 0; i < orgList.size(); i++) {
                ZTreeParams zTreeParamsz = new ZTreeParams();
                zTreeParamsz.setId(orgList.get(i).getId());
                zTreeParamsz.setpId(id);
                zTreeParamsz.setParent(true);
                zTreeParamsz.setNum("1");
                zTreeParamsz.setIcon("/img/group.png");
                zTreeParamsz.setName(orgList.get(i).getOrgName());
                zTreeParamsList.add(zTreeParamsz);
            }
        }

      /*  List<UserInfo> userInfoList=this.orgTreeService.queryForGroupToUser(id);
        if(userInfoList.size()>0) {
            for (int j = 0; j < userInfoList.size(); j++) {
                ZTreeParams zTreeParamsz = new ZTreeParams();
                zTreeParamsz.setId(userInfoList.get(j).getId());
                zTreeParamsz.setpId(id);
                zTreeParamsz.setNum("2");
                zTreeParamsz.setIcon("/img/people.png");
                zTreeParamsz.setParent(false);
                zTreeParamsz.setName(userInfoList.get(j).getRealName());
                zTreeParamsList.add(zTreeParamsz);
            }
        }*/
        Gson gson = new Gson();
        return gson.toJson(zTreeParamsList);
    }
    //获取所有部门
    @RequestMapping(value = "/group", method = RequestMethod.GET)
    public String getGroup(){

        List<Org> list=this.orgService.queryForObject(new Org());
        Map<String ,Object> map=new HashMap<>();
        map.put("code","0000");
        map.put("data",list);
        Gson gson=new Gson();
        return gson.toJson(map);
    }
    //获取更新的部门，并返回树的节点json
    @RequestMapping(value = "/treeNodes", method = RequestMethod.POST)
    public String getTreeNodes(@RequestBody String id){
        Org org=this.orgService.getGroupOne(id);
        ZTreeParams zTreeParams=new ZTreeParams();
        zTreeParams.setId(org.getId());
        zTreeParams.setNum("1");
        zTreeParams.setName(org.getOrgName());
        zTreeParams.setpId(org.getParentId());
        zTreeParams.setIcon("/img/group.png");
        zTreeParams.setParent(true);
        Map<String ,Object> map=new HashMap<>();
        map.put("code","0000");
        map.put("data",zTreeParams);
        Gson gson=new Gson();
        return gson.toJson(map);
    }




    //这是添加权限时用的组织机构树

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    @ApiOperation(value = "查询组织Tree", notes = "查询组织Tree", httpMethod = "GET", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiResponses(value = {
            @ApiResponse(code = 401, message = "No Privilege"),
    })
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "组织id", required = true, dataType = "String", paramType = "path")
    })
    public String getTree(@PathVariable("id") String id) {
        return null;
    }
    //查询map格式的org tree的每个节点下的user的app,并且添加到map中
    public void addAppForOrgUserMap(List<Map<String, Object>> resultList) {
        if (resultList != null) {
            for (Map<String, Object> map : resultList) {
                if (map.get("type") == "user") {
                    UserInfo queryUserInfo = new UserInfo();
                    queryUserInfo.setId(map.get("id").toString());
                    //只是查询了app，没有环信id
                    //List<App> appList = this.userInfoService.queryAppListForObject(queryUserInfo);
                    //查询加入了环信ID
                    List<Map<String, Object>> appList = this.userInfoService.queryAppListAndCommunicationIdForObject(queryUserInfo);
                    if (appList.size() == 0 || appList == null) {
                        addAppForOrgUserMap((List<Map<String, Object>>) (map.get("children")));
                    } else {
                        for (Map<String, Object> app : appList) {
                            app.put("type", "app");
                            if (map.get("children") != null) {
                                ((List<Map<String, Object>>) (map.get("children"))).add(app);
                            } else {
                                List<Map<String, Object>> mapAppList = new ArrayList<>();
                                mapAppList.add(app);
                                map.put("children", mapAppList);
                            }
                        }
                        addAppForOrgUserMap((List<Map<String, Object>>) (map.get("children")));
                    }
                } else {
                    addAppForOrgUserMap((List<Map<String, Object>>) (map.get("children")));
                }
            }
        }
    }


    //获取考勤地点
    @RequestMapping(value = "/cameraLoaction", method = RequestMethod.GET)
    public String getCameraLoaction(){
        List<CameraLocation> cameraLocationList=this.orgTreeService.queryForCameraLoaction();
        Map<String ,Object> map=new HashMap<>();
        map.put("code","0000");
        map.put("data",cameraLocationList);
        Gson gson=new Gson();
        return gson.toJson(map);
    }
    //获取当前考勤地点
    @RequestMapping(value = "/locationNow", method = RequestMethod.POST)
    public String getlocationNow(@RequestBody Integer id){
        CameraLocation cameraLocationList=this.orgTreeService.queryForlocationNow(id);
        Map<String ,Object> map=new HashMap<>();
        map.put("code","0000");
        map.put("data",cameraLocationList);
        Gson gson=new Gson();
        return gson.toJson(map);
    }
    @RequestMapping(value = "/showUserInfo/{id}", method = RequestMethod.POST)
    public String getUserInfoList(@PathVariable("id") String id){
        UserInfo userInfo=new UserInfo();
        userInfo.setOrgId(id);
        List<UserInfo> userInfoList=this.userInfoService.queryForObject(userInfo);
        Map<String,Object> map=new HashMap<>();
        Gson gson=new Gson();
        map.put("data",userInfoList);
        return gson.toJson(map);
    }
}
