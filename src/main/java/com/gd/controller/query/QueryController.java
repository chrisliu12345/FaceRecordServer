package com.gd.controller.query;

import com.gd.domain.config.Camera;
import com.gd.domain.query.*;
import com.gd.domain.userinfo.UserInfo;
import com.gd.domain.video.SimplePicture;
import com.gd.service.config.IConfigService;
import com.gd.service.query.IQueryService;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

/**
 * Created by 郄梦岩 on 2017/12/23.
 */
@RestController
@RequestMapping("/query")
public class QueryController {
    final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    @Autowired
    private IQueryService queryService;
    @Value("${picture.url}")
    private String pictureUrl;
    @Autowired
    private IConfigService configService;
    //获取图像列表（管理员）
    @RequestMapping(method = RequestMethod.GET)
    public String getList() {
        List<DetectImagesTemp> detectImagesTempList = this.queryService.queryForObject();
        String pictureRootUrl=this.queryService.getPictSaveRootDirectory();
            for (int i = 0; i < detectImagesTempList.size(); i++) {
                String dataTime=detectImagesTempList.get(i).getDate().toString();
                detectImagesTempList.get(i).setDatetmp(dataTime.substring(0,dataTime.length()-2));
                //System.out.println("我是来查看的时间："+dataTime.substring(0,dataTime.length()-2));
                detectImagesTempList.get(i).setUrl(pictureRootUrl);
                //根据员工号查询fr——person——collection表的collectid
                //Integer collectid = this.queryService.searchForcollectid(detectImagesTempList.get(i).getEmployeeId());

                    //根据摄像机ID去查摄像机地点
                    String camera = this.queryService.searchForSite(detectImagesTempList.get(i).getCamerId());
                    if (detectImagesTempList.get(i).getTaskType() == 0) {
                        String into1 = camera + "-入口";
                        detectImagesTempList.get(i).setInout(into1);
                    }
                    if (detectImagesTempList.get(i).getTaskType() == 1) {
                        String into1 = camera + "-出口";
                        detectImagesTempList.get(i).setInout(into1);
                    }
                    if (detectImagesTempList.get(i).getTaskType() == 2) {
                        String into1 = camera + "-出入口";
                        detectImagesTempList.get(i).setInout(into1);
                    }
                    String orgsadd1 = detectImagesTempList.get(i).getParentorg() + "-" + detectImagesTempList.get(i).getOrg();
                    detectImagesTempList.get(i).setOrgadd(orgsadd1);

                }
               /* Collections.sort(detectImagesTempList, new Comparator<DetectImagesTemp>() {
                    @Override
                    public int compare(DetectImagesTemp o1, DetectImagesTemp o2) {
                        int mark=1;
                        Date date1=o1.getDate();
                        Date date2=o2.getDate();
                        if(date2.getTime()>date1.getTime()){
                             mark=1;
                        }else if(date2.getTime()<date1.getTime()){
                            mark=-1;
                        }else{
                            mark=0;
                        }
                        return mark;
                    }
                });*/
        Map<String, Object> map = new HashMap<>();
        map.put("data", detectImagesTempList);
        Gson gson = new Gson();
        return gson.toJson(map);

    }
    @RequestMapping(value = "/get",method = RequestMethod.GET)
    public String getList1() {
        //List<DetectImagesTemp> detectImagesTempList = this.queryService.queryForObject();
        List<DetectImagesTemp> detectImagesTempList = this.queryService.queryForObjectDistory();
        String pictureRootUrl=this.queryService.getPictSaveRootDirectory();
        for (int i = 0; i < detectImagesTempList.size(); i++) {
            String dataTime=detectImagesTempList.get(i).getDate().toString();
            detectImagesTempList.get(i).setDatetmp(dataTime.substring(0,dataTime.length()-2));
            //System.out.println("我是来查看的时间："+dataTime.substring(0,dataTime.length()-2));
            detectImagesTempList.get(i).setUrl(pictureRootUrl);
            //根据员工号查询fr——person——collection表的collectid
          //  Integer collectid = this.queryService.searchForcollectid(detectImagesTempList.get(i).getEmployeeId());

            //根据摄像机ID去查摄像机地点
            String camera = this.queryService.searchForSite(detectImagesTempList.get(i).getCamerId());
            if (detectImagesTempList.get(i).getTaskType() == 0) {
                String into1 = camera + "-入口";
                detectImagesTempList.get(i).setInout(into1);
            }
            if (detectImagesTempList.get(i).getTaskType() == 1) {
                String into1 = camera + "-出口";
                detectImagesTempList.get(i).setInout(into1);
            }
            if (detectImagesTempList.get(i).getTaskType() == 2) {
                String into1 = camera + "-出入口";
                detectImagesTempList.get(i).setInout(into1);
            }
            String orgsadd1 = detectImagesTempList.get(i).getParentorg() + "-" + detectImagesTempList.get(i).getOrg();
            detectImagesTempList.get(i).setOrgadd(orgsadd1);

        }
        Map<String, Object> map = new HashMap<>();
        map.put("data", detectImagesTempList);
        Gson gson = new Gson();
        return gson.toJson(map);

    }
    //获取图像列表（个人）
    @RequestMapping(value = "/get1",method = RequestMethod.POST)
    public String getList1(@RequestBody String id) {
        List<DetectImagesTemp> detectImagesTempList = this.queryService.queryForObject1(id);
        String pictureRootUrl=this.queryService.getPictSaveRootDirectory();
        for (int i = 0; i < detectImagesTempList.size(); i++) {
            detectImagesTempList.get(i).setUrl(pictureRootUrl);
            String dataTime=detectImagesTempList.get(i).getDate().toString();
            detectImagesTempList.get(i).setDatetmp(dataTime.substring(0,dataTime.length()-2));
            //根据员工号查询fr——person——collection表的collectid
           // Integer collectid = this.queryService.searchForcollectid(detectImagesTempList.get(i).getEmployeeId());

            //根据摄像机ID去查摄像机地点
            String camera = this.queryService.searchForSite(detectImagesTempList.get(i).getCamerId());
            if (detectImagesTempList.get(i).getTaskType() == 0) {
                String into1 = camera + "-入口";
                detectImagesTempList.get(i).setInout(into1);
            }
            if (detectImagesTempList.get(i).getTaskType() == 1) {
                String into1 = camera + "-出口";
                detectImagesTempList.get(i).setInout(into1);
            }
            if (detectImagesTempList.get(i).getTaskType() == 2) {
                String into1 = camera + "-出入口";
                detectImagesTempList.get(i).setInout(into1);
            }
            String orgsadd1 = detectImagesTempList.get(i).getParentorg() + "-" + detectImagesTempList.get(i).getOrg();
            detectImagesTempList.get(i).setOrgadd(orgsadd1);
        }
        Map<String, Object> map = new HashMap<>();
        map.put("data", detectImagesTempList);
        Gson gson = new Gson();
        return gson.toJson(map);

    }
    //获取图像列表（切换不同摄像机实时识别）
    @RequestMapping(value = "/videoCamera",method = RequestMethod.POST)
    public String getList2(@RequestBody String Camid) {
        List<DetectImagesTemp> detectImagesTempList = this.queryService.queryForObject2(Camid);
        //获取图片所在的文件夹根路径
        String pictureRootUrl=this.queryService.getPictSaveRootDirectory();
        for (int i = 0; i < detectImagesTempList.size(); i++) {
            detectImagesTempList.get(i).setUrl(pictureRootUrl);
            String dataTime=detectImagesTempList.get(i).getDate().toString();
            detectImagesTempList.get(i).setDatetmp(dataTime.substring(0,dataTime.length()-2));
            //根据员工号查询fr——person——collection表的collectid
           // Integer collectid = this.queryService.searchForcollectid(detectImagesTempList.get(i).getEmployeeId());

            //根据摄像机ID去查摄像机地点
            String camera = this.queryService.searchForSite(detectImagesTempList.get(i).getCamerId());
            if (detectImagesTempList.get(i).getTaskType() == 0) {
                String into1 = camera + "-入口";
                detectImagesTempList.get(i).setInout(into1);
            }
            if (detectImagesTempList.get(i).getTaskType() == 1) {
                String into1 = camera + "-出口";
                detectImagesTempList.get(i).setInout(into1);
            }
            if (detectImagesTempList.get(i).getTaskType() == 2) {
                String into1 = camera + "-出入口";
                detectImagesTempList.get(i).setInout(into1);
            }
            String orgsadd1 = detectImagesTempList.get(i).getParentorg() + "-" + detectImagesTempList.get(i).getOrg();
            detectImagesTempList.get(i).setOrgadd(orgsadd1);
        }
        Map<String, Object> map = new HashMap<>();
        map.put("data", detectImagesTempList);
        Gson gson = new Gson();
        return gson.toJson(map);

    }
    //检测图像的编辑功能
    @RequestMapping(value = "/updateDectImg", method = RequestMethod.POST)
    public String updateDectImg(@RequestBody Map<String, Object> map) {
        String NewEmployee=map.get("NewEmployee").toString();//新的员工号
        String collectID=map.get("CollectId").toString();
        //更新本此的原始识别记录表的Emplyeeid和BeForeNum,也就是更新本条数据
        DetectImagesTemp detectImages=new DetectImagesTemp();
        detectImages.setBeforeNum(map.get("policeNum").toString());
        detectImages.setEmployeeId(NewEmployee);
        detectImages.setCollectId(Integer.parseInt(collectID));
        detectImages.setCamerId(Integer.parseInt(map.get("CamerId").toString()));
        detectImages.setId(Integer.parseInt(map.get("id").toString()));
        this.queryService.updateForThisData(detectImages);
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("data", "success");
        Gson gson = new Gson();
        return gson.toJson(resultMap);

    }

    //查询摄像机
     @RequestMapping(value = "/camera", method = RequestMethod.GET)
    public String getCameraName() {
        List<Camera> camera= this.queryService.getCamera();
         for(int i=0;i<camera.size();i++){
             if(Integer.parseInt(camera.get(i).getTaskType())==0){
                 camera.get(i).setTemp(camera.get(i).getSite()+"-入口");
             }
             if(Integer.parseInt(camera.get(i).getTaskType())==1){
                 camera.get(i).setTemp(camera.get(i).getSite()+"-出口");
             }if(Integer.parseInt(camera.get(i).getTaskType())==2){
                 camera.get(i).setTemp(camera.get(i).getSite()+"-出入口");
             }
         }
        Map<String, Object> map = new HashMap<>();
        map.put("data", camera);
        Gson gson = new Gson();
        return gson.toJson(map);
    }
    /*@RequestMapping(value = "/camera", method = RequestMethod.GET)
    public String getCameraName() {
        List<DetectImages> detectImages = this.queryService.getCamera();
        for(int i=0;i<detectImages.size();i++){
            String site=this.queryService.searchForSite(detectImages.get(i).getCamerId());
            if(detectImages.get(i).getTaskType()==0){
                detectImages.get(i).setTemp(site+"-入口");
            }
            if(detectImages.get(i).getTaskType()==1){
                detectImages.get(i).setTemp(site+"-出口");
            }if(detectImages.get(i).getTaskType()==2){
                detectImages.get(i).setTemp(site+"-出入口");
            }
        }
        Map<String, Object> map = new HashMap<>();
        map.put("data", detectImages);
        Gson gson = new Gson();
        return gson.toJson(map);
    }*/

    //检测图像浏览的查询功能
    @RequestMapping(value = "/ResultCamera", method = RequestMethod.POST)
    public String ResultCamera(@RequestBody Map<String, String> map) {
        String site="";
        DetectImagesTemp detectImagesTemp = new DetectImagesTemp();
        String rootUrl=this.queryService.getPictSaveRootDirectory();
        detectImagesTemp.setCamerId(Integer.parseInt(map.get("CameraId")));
        if(map.get("TaskType")!=null) {
            detectImagesTemp.setTaskType(Integer.parseInt(map.get("TaskType")));
        }
        if(map.get("policeNum")!=null ){
        detectImagesTemp.setPoliceNum(map.get("policeNum"));
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
        String a1 = map.get("Start");
        String a2 = map.get("End");
        java.util.Date date = new java.util.Date();
        Timestamp timeStamp = Timestamp.valueOf(a1);
        detectImagesTemp.setStartTime(timeStamp);
        Timestamp timeStamp1 = Timestamp.valueOf(a2);
        detectImagesTemp.setEndTime(timeStamp1);
        Map<String, Object> ResultMap = new HashMap<>();
        //查询摄像机地点
        List<DetectImagesTemp> list = this.queryService.queryForResultCamera(detectImagesTemp);

        if (list.size() <= 0) {
            ResultMap.put("data", "0000");
            Gson gson = new Gson();
            return gson.toJson(ResultMap);
        } else {
            for (int i = 0; i < list.size(); i++) {
                list.get(i).setDatetmp(list.get(i).getDate().toString());
                list.get(i).setUrl(rootUrl);
                if(map.get("CameraId")==null) {
                    site=this.queryService.searchForSite(list.get(i).getCamerId());
                }else{
                   site=this.queryService.searchForSite(Integer.parseInt(map.get("CameraId")));
                }

                if(list.get(i).getTaskType()==0){
                    list.get(i).setInout(site+"-入口");
                }
                if(list.get(i).getTaskType()==1){
                    list.get(i).setInout(site+"-出口");
                }if(list.get(i).getTaskType()==2){
                    list.get(i).setInout(site+"-出入口");
                }
                String orgsadd1 = list.get(i).getParentorg() + "-" + list.get(i).getOrg();
                list.get(i).setOrgadd(orgsadd1);
            }
            ResultMap.put("data", list);
            Gson gson = new Gson();
            return gson.toJson(ResultMap);
        }
    }

    //综合查询-获取数据
    @RequestMapping(value = "/queryAll", method = RequestMethod.GET)
    public String getAll() {
        List<Record> recordList = this.queryService.getAllRecord();
        for(int i=0;i<recordList.size();i++){
            if(recordList.get(i).getClockIn()==null){

            }else{
                recordList.get(i).setClockInTemp(recordList.get(i).getClockIn().toString().substring(
                        0,recordList.get(i).getClockIn().toString().length()-2));
            }
            if(recordList.get(i).getClockOff()==null){

            }else{
                recordList.get(i).setClockOffTemp(recordList.get(i).getClockOff().toString().substring(
                        0,recordList.get(i).getClockOff().toString().length()-2));
            }
        }
        Map<String, Object> ResultMap = new HashMap<>();
        ResultMap.put("data", recordList);
        Gson gson = new Gson();
        return gson.toJson(ResultMap);

    }

    //综合查询-查询数据
    @RequestMapping(value = "/Result1", method = RequestMethod.POST)
    public String getResult1(@RequestBody Map<String, Object> map,HttpServletRequest request) {
        Record record = new Record();
        //如果只输入了时间
        //System.out.println("我是否或者发的:"+map.get("orgId").toString());
        if(map.get("orgId")!=null){
            record.setOrg(map.get("orgId").toString());
        }
        if(map.get("CollectId")!=null) {
            record.setCollectId(Integer.parseInt(map.get("CollectId").toString()));
        }
        if (map.get("Start") != null) {
            String clockon = map.get("Start").toString();
            record.setCreateTime1(java.sql.Date.valueOf(clockon));
        }
        if (map.get("End") != null) {
            String clockoff = map.get("End").toString();
            record.setCreateTime2(java.sql.Date.valueOf(clockoff));
        }
        if(map.get("Start") != null&&map.get("End") != null&&map.get("Start").toString().equals(map.get("End").toString())){
            Map<String, Object> map1 = new HashMap<>();
            map1.put("data", "TimeEquals");
            Gson gson = new Gson();
            return gson.toJson(map1);
        }
            //先根据工号和时间查询到这条记录List
            List<Record> recordList = this.queryService.queryForNameAndTime(record);
        for(int i=0;i<recordList.size();i++){
            if(recordList.get(i).getClockIn()==null){

            }else{
                recordList.get(i).setClockInTemp(recordList.get(i).getClockIn().toString().substring(
                        0,recordList.get(i).getClockIn().toString().length()-2));
            }
            if(recordList.get(i).getClockOff()==null){

            }else{
                recordList.get(i).setClockOffTemp(recordList.get(i).getClockOff().toString().substring(
                0,recordList.get(i).getClockOff().toString().length()-2));
            }


        }
        //判断是否包含迟到早退。。。
        List<String> workoff = (List) map.get("Flag");
        if (map.get("Flag") != null && workoff.size() > 0) {
            System.out.println("进入包含迟到早退方法");
            List<Record> recordList1 = new ArrayList<>();
            for (int a = 0; a < recordList.size(); a++) {
                for (int i = 0; i < workoff.size(); i++) {
                    //不包含迟到早退加班旷工的
                    if (recordList.get(a).getAttendanceFlag().indexOf(workoff.get(i)) != -1 && recordList.get(a).getCollectId()==record.getCollectId()) {
                        recordList1.add(recordList.get(a));
                    } else {

                    }
                }
            }
            //去除重复元素
            HashSet h = new HashSet(recordList1);
            recordList1.clear();
            recordList1.addAll(h);
            Map<String, Object> map1 = new HashMap<>();
            HttpSession session=request.getSession();
            session.setAttribute("result1",recordList1);
            map1.put("data", recordList1);
            Gson gson = new Gson();
            return gson.toJson(map1);
        } else {
           /* System.out.println("进入正常方法");
            List<Record> recordResult = new ArrayList<>();
            for (int j = 0; j < recordList.size(); j++) {

                if (recordList.get(j).getEmployeeId().equals(map.get("PoliceNum").toString())) {
                    recordResult.add(recordList.get(j));
                }
            }*/

            Map<String, Object> map1 = new HashMap<>();
         /*   HttpSession session=request.getSession();
            session.setAttribute("result1",recordResult);*/
            map1.put("data", recordList);
            Gson gson = new Gson();
            return gson.toJson(map1);
        }
    }

    //按部门查询-查询数据
    @RequestMapping(value = "/Result2", method = RequestMethod.POST)
    public String getResult2(@RequestBody Map<String, Object> map,HttpServletRequest request) {
        Record record = new Record();
        if(map.get("Start") != null&&map.get("End") != null&&map.get("Start").toString().equals(map.get("End").toString())){
            Map<String, Object> map1 = new HashMap<>();
            map1.put("data", "TimeEquals");
            Gson gson = new Gson();
            return gson.toJson(map1);
        }
        //如果只输入了开始时间
        if (map.get("Start") != null) {
            String clockon = map.get("Start").toString();
            record.setCreateTime1(java.sql.Date.valueOf(clockon));
        }
        if (map.get("End") != null) {
            String clockoff = map.get("End").toString();
            System.out.println(clockoff );
            record.setCreateTime2(java.sql.Date.valueOf(clockoff));
        }
        record.setOrg(map.get("org").toString());
        record.setParentorg(map.get("parentOrg").toString());

        //先根据工号和时间查询到这条记录List
        List<Record> recordList = this.queryService.queryForOrgs(record);
        for(int i=0;i<recordList.size();i++){
            if(recordList.get(i).getClockIn()==null){

            }else{
                recordList.get(i).setClockInTemp(recordList.get(i).getClockIn().toString().substring(
                        0,recordList.get(i).getClockIn().toString().length()-2));
            }
            if(recordList.get(i).getClockOff()==null){

            }else{
                recordList.get(i).setClockOffTemp(recordList.get(i).getClockOff().toString().substring(
                        0,recordList.get(i).getClockOff().toString().length()-2));
            }
        }
        List<Record> recordResult = new ArrayList<>();
        //筛选部门
        for (int i = 0; i < recordList.size(); i++) {
            if (recordList.get(i).getOrg().equals(record.getOrg()) && recordList.get(i).getParentorg().equals(record.getParentorg())) {
                recordResult.add(recordList.get(i));
            }
        }
        Map<String, Object> map1 = new HashMap<>();
        HttpSession session=request.getSession();
        session.setAttribute("result2",recordResult);
        map1.put("data", recordResult);
        Gson gson = new Gson();
        return gson.toJson(map1);

    }

    //个人考勤查询-查询结果
    @RequestMapping(value = "/Result3", method = RequestMethod.POST)
    public String getResult3(@RequestBody Map<String, Object> map,HttpServletRequest request) {
        Record record = new Record();
        if(map.get("Start") != null&&map.get("End") != null&&map.get("Start").toString().equals(map.get("End").toString())){
            Map<String, Object> map1 = new HashMap<>();
            map1.put("data", "TimeEquals");
            Gson gson = new Gson();
            return gson.toJson(map1);
        }
        //如果只输入了开始时间
        if (map.get("Start") != null) {
            String clockon = map.get("Start").toString();
            record.setCreateTime1(java.sql.Date.valueOf(clockon));
        }
        if (map.get("End") != null) {
            String clockoff = map.get("End").toString();
            System.out.println(clockoff );
            record.setCreateTime2(java.sql.Date.valueOf(clockoff));
        }
        if (map.get("CollectId") != null) {
            record.setCollectId(Integer.parseInt(map.get("CollectId").toString()));
        }
        if (map.get("realName") != null) {
            record.setRealName(map.get("realName").toString());
        }
        //查询记录
        List<Record> recordList = this.queryService.queryForNameAndTime(record);
        for(int i=0;i<recordList.size();i++){
            if(recordList.get(i).getClockIn()==null){

            }else{
                recordList.get(i).setClockInTemp(recordList.get(i).getClockIn().toString().substring(
                        0,recordList.get(i).getClockIn().toString().length()-2));
            }
            if(recordList.get(i).getClockOff()==null){

            }else{
                recordList.get(i).setClockOffTemp(recordList.get(i).getClockOff().toString().substring(
                        0,recordList.get(i).getClockOff().toString().length()-2));
            }


        }

        Map<String, Object> map1 = new HashMap<>();

        map1.put("data", recordList);
        Gson gson = new Gson();
        return gson.toJson(map1);
    }
    @RequestMapping(value = "/recordResult", method = RequestMethod.POST)
    public String getRecordResult(@RequestBody String id){
        Record record=this.queryService.getRecordResultOne(Integer.parseInt(id));
        Map<String,Object> map=new HashMap<>();
        Gson gson=new Gson();
        List<TimeLine> timeLineList=new ArrayList<>();
        TimeLine timeLine=new TimeLine();
        TimeLine timeLine2=new TimeLine();
        if(record.getClockIn()!=null) {
            String start = record.getClockIn().toString().substring(0, record.getClockIn().toString().length() - 2);
            timeLine.setStart(start);
            timeLine.setId(record.getId());
            timeLine.setContent(record.getRealName()+"—上班打卡");
            timeLine.setStartData(record.getCreateTime().toString());
            timeLineList.add(timeLine);
        }
        if(record.getClockOff()!=null) {
            String end = record.getClockOff().toString().substring(0, record.getClockOff().toString().length() - 2);
            timeLine2.setStart(end);
            timeLine2.setId(record.getId()+1);
            timeLine2.setContent(record.getRealName()+"—下班打卡");
            timeLine2.setStartData(record.getCreateTime().toString());
            timeLineList.add(timeLine2);
        }
        map.put("data",timeLineList);
        return gson.toJson(map);
    }

    //获取照片存放的nginx路径
    @RequestMapping(value = "/url", method = RequestMethod.GET)
    public String getUrl(){
        return this.queryService.getPictSaveRootDirectory();
    }


}

