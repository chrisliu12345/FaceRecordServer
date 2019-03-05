package com.gd.controller.video;

import com.gd.domain.query.PeopleCollect;
import com.gd.domain.userinfo.UserInfo;
import com.gd.domain.video.CameraList;
import com.gd.domain.video.CsServices;
import com.gd.domain.video.PeoplePicture;
import com.gd.domain.video.SimplePicture;
import com.gd.service.userinfo.IUserInfoService;
import com.gd.service.video.IVideoService;
import com.gd.util.BaseModelFieldSetUtils;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/12/22 0022.
 */
@Controller
@RestController
@RequestMapping("/video")
public class VideoController {
    @Autowired
    private IVideoService iVideoService;
    @Autowired
    private IUserInfoService userInfoService;
    @Value("${picture.url}")
    private String pictureUrl;
    //根据选择的部门检查部门下的人员姓名
    @RequestMapping(value = "/checkName", method = RequestMethod.POST)
    public String getCheckName(@RequestBody Map<String, String> map1) {
        //所有未被注册人脸的人员
        List<UserInfo> userInfos = this.userInfoService.queryForObject(new UserInfo());
        //查询所有已录入的人员工号
        List<SimplePicture> simplePictures = this.iVideoService.queryForWaitUser();
        if (simplePictures == null) {
            Map<String, Object> map = new HashMap<>();
            map.put("data", userInfos);
            Gson gson = new Gson();
            return gson.toJson(map);
        } else {
           /* for (int i = 0; i < simplePictures.size(); i++) {
                for (int j = 0; j < userInfos.size(); j++) {
                    if (Integer.parseInt(userInfos.get(j).getPoliceNum()) == simplePictures.get(i).getCollectId()) {
                        userInfos.remove(userInfos.get(j));
                    }
                }
            }*/
            //userinfos为没有被注册的人员

            UserInfo userInfo = new UserInfo();
            userInfo.setParentorg(map1.get("parentOrg"));
            userInfo.setOrg(map1.get("org"));
            userInfo.setOrgId(map1.get("orgId"));
            //新建一个用于存放未注册人员且属于选中组的人员列表
            List<UserInfo> uu = new ArrayList<>();
            for (int i = 0; i < userInfos.size(); i++) {
                if (userInfos.get(i).getOrg().equals(userInfo.getOrg()) && userInfos.get(i).getParentorg().equals(userInfo.getParentorg())&&userInfos.get(i).getOrgId().equals(userInfo.getOrgId())) {
                    uu.add(userInfos.get(i));
                }
            }
            //List<UserInfo> userInfoList= this.iVideoService.checkName(userInfo);
            Map<String, Object> map = new HashMap<>();
            map.put("data", uu);
            Gson gson = new Gson();
            return gson.toJson(map);
        }
    }

    //查询所有该部门下已注册过人脸识别的人员
    @RequestMapping(value = "/checkName1", method = RequestMethod.POST)
    public String getCheckName1(@RequestBody Map<String, String> map1) {
        UserInfo userInfo = new UserInfo();
        userInfo.setParentorg(map1.get("parentOrg"));
        userInfo.setOrg(map1.get("org"));
        userInfo.setOrgId(map1.get("orgId"));
        List<UserInfo> list=this.userInfoService.queryForObjectByorg(userInfo);
            Map<String, Object> map = new HashMap<>();
            map.put("data", list);
            Gson gson = new Gson();
            return gson.toJson(map);
        }



    //获取样本人默认id
    @RequestMapping(value = "/getMid", method = RequestMethod.GET)
    public String getMid() {
        List<PeopleCollect> count = this.iVideoService.getCollectId();
        /*List<Integer> names = new ArrayList<>();
        for (PeopleCollect ss : count) {
            names.add(ss.getCollectId());
        }*/
        Map<String, Object> map = new HashMap<>();
        map.put("data", count);
        Gson gson = new Gson();
        return gson.toJson(map);
    }

    //根据样本人默认名获取样本照片
    @RequestMapping(value = "/getPicture/{id}", method = RequestMethod.POST)
    public String getPicture(@PathVariable("id") String cc) {
        SimplePicture simplePicture = new SimplePicture();
        simplePicture.setCollectId(Integer.parseInt(cc));
        List<SimplePicture> list = this.iVideoService.getPicture(simplePicture);
        for(int i=0;i<list.size();i++){
            list.get(i).setUrl(pictureUrl);
        }
        Map<String, Object> map = new HashMap<>();
        map.put("data", list);
        Gson gson = new Gson();
        return gson.toJson(map);
    }

    //更改待处理的人员工号
    @RequestMapping(value = "/changeWorker", method = RequestMethod.POST)
    public String getPicture(@RequestBody Map<String, String> map) {
       /* SimplePicture simplePicture = new SimplePicture();
        simplePicture.setCollectId(Integer.parseInt(map.get("number")));
        simplePicture.setWait(Integer.parseInt(map.get("wait")));*/
       PeopleCollect peopleCollect=new PeopleCollect();
       peopleCollect.setEmployeeId(map.get("number"));
       peopleCollect.setCollectId(Integer.parseInt(map.get("wait")));
        this.iVideoService.updateCollectId(peopleCollect);

        Map<String, Object> map1 = new HashMap<>();
        map1.put("data", "success");
        Gson gson = new Gson();
        return gson.toJson(map);
    }

    //更新照片选中状态
    @RequestMapping(value = "/updateSelectedFlag", method = RequestMethod.POST)
    public String updatePicture(@RequestBody List<Integer> myid) {
        //先拿出一个id，并获取这个id
        for(int i=0;i<myid.size();i++){
            SimplePicture simplePicture=new SimplePicture();
            simplePicture.setId(myid.get(i));
            this.iVideoService.updatePicture2(simplePicture);
        }
        Map<String, Object> map1 = new HashMap<>();
        map1.put("data", "success");
        Gson gson = new Gson();
        return gson.toJson(map1);
    }
    //获取CS端启动状态
    @RequestMapping(value = "/CStatus",method = RequestMethod.GET)
    public String getCsstatus(){
        String status=this.iVideoService.getCStatus();
        Map<String,String> map=new HashMap<>();
        map.put("data",status);
        Gson gson=new Gson();
        return gson.toJson(map);
    }
    //改变CS端启动状态
    @RequestMapping(value = "/ChangeStartOrEnd",method = RequestMethod.POST)
    public void updateCsstatus(@RequestBody String a){
       this.iVideoService.updateCStatus(a);
    }
    //删除选中的人员收集ID和样本中照片
    @RequestMapping(value = "/deleteSimPic",method = RequestMethod.POST)
    public void deleteSimPic(@RequestBody List<Integer> collectid){
        for(int i=0;i<collectid.size();i++){
            //删除fr_person_collection表数据和fr_simple_photo表数据
            this.iVideoService.deleteSimPic(collectid.get(i));
        }
    }
    //搜索功能
    @RequestMapping(value = "/search1",method = RequestMethod.POST)
    public String search1(@RequestBody String employeed){
            //删除fr_person_collection表数据和fr_simple_photo表数据
        List<PeopleCollect> p=this.iVideoService.search1(employeed);
        Map<String, Object> map = new HashMap<>();
        map.put("data", p);
        Gson gson = new Gson();
        return gson.toJson(map);
    }
    //获取摄像机列表
    @RequestMapping(value = "/searchCameraID",method = RequestMethod.GET)
    public String searchCameraID(){
        List<CameraList> cameraid=this.iVideoService.searchCameraID();
        Map<String, Object> map = new HashMap<>();
        map.put("data",cameraid);
        Gson gson = new Gson();
        return gson.toJson(map);
    }
    //获取当前摄像机在Config表中的值
    @RequestMapping(value = "/ConfigCamID",method = RequestMethod.GET)
    public String getConfigCamID(){
        //Integer cameraid=this.iVideoService.getConfigCamID1(ca);
       Integer cameraid=this.iVideoService.getConfigCamID();
        Map<String, Object> map = new HashMap<>();
        map.put("data",cameraid);
        Gson gson = new Gson();
        return gson.toJson(map);
    }
    @RequestMapping(value = "/ConfigCamID1",method = RequestMethod.POST)
    public String getConfigCamID1(@RequestBody Integer camid){
       Integer cameraid=this.iVideoService.getConfigCamID1(camid);
       // Integer cameraid=this.iVideoService.getConfigCamID();
        Map<String, Object> map = new HashMap<>();
        map.put("data",cameraid);
        Gson gson = new Gson();
        return gson.toJson(map);
    }
    //根据摄像机ID查询摄像机URL
    @RequestMapping(value = "/searchCameraUrl",method = RequestMethod.POST)
    public String searchCameraURL(@RequestBody Integer CameraID){
        String url=this.iVideoService.searchCameraUrl(CameraID);
        System.out.println("根据摄像机ID查询摄像机URL:"+url);
        Map<String, String> map = new HashMap<>();
        map.put("data", url);
        Gson gson = new Gson();
        return gson.toJson(map);
    }

    //获取cs—servers表内容
    @RequestMapping(value = "/getServices",method = RequestMethod.GET)
    public String getServices(){
        List<CsServices> csServicesList=this.iVideoService.getServices();
        Map<String, Object> map = new HashMap<>();
        map.put("data", csServicesList);
        Gson gson = new Gson();
        return gson.toJson(map);
    }

}
