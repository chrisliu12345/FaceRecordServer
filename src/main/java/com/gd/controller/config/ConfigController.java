package com.gd.controller.config;

import com.gd.domain.config.*;
import com.gd.domain.group.GroupInfo;
import com.gd.domain.org.Org;
import com.gd.domain.query.Record;
import com.gd.domain.userinfo.UserInfo;
import com.gd.service.config.IConfigService;
import com.gd.service.orgtree.IOrgTreeService;
import com.gd.util.BaseModelFieldSetUtils;
import com.gd.util.ExcelUtils;
import com.gd.util.FileLoadUtils;
import com.google.gson.Gson;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.xmlbeans.impl.piccolo.io.FileFormatException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.User;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.Callable;

/**
 * Created by Administrator on 2017/12/19 0019.
 */
@RequestMapping("/config")
@RestController
public class ConfigController {
    @Autowired
    private IConfigService configService;
    @Autowired
    private IOrgTreeService orgTreeService;
    @Value("${excel.path3}")
    String filePath;
    /*String path1="E:/FrConfig/zhy_webclient/excelFile/file/";*/
    @Value("${excel.path2}")
    private String path2;
    //获取当前考勤信息
    @RequestMapping(method = RequestMethod.GET)
    public String getConfig(){
        List<ConfigSQL> config=this.configService.queryForObject();
        Map<String,Object> map=new HashMap<>();
        map.put("data",config);
        Gson gson=new Gson();
        return gson.toJson(map);
    }
    //更新考勤配置
    @RequestMapping(method = RequestMethod.POST)
    public  String addConfig(@RequestBody Map<String,Object> map){
            Config config=new Config();
            config.setStartTime(map.get("StartTime").toString());
            config.setEndTime(map.get("EndTime").toString());
            config.setStartRestTime(map.get("StartRestTime").toString());
            config.setEndRestTime(map.get("EndRestTime").toString());
            config.setStartWrok(map.get("StartWrok").toString());
            config.setEndWork(map.get("EndWork").toString());
            config.setNoWork(map.get("NoWork").toString());
            config.setSelected(map.get("Selected").toString());
            config.setStartAddWorkTime(map.get("StartAddWorkTime").toString());
            this.configService.updateConfig(config);
            Map<String,String> map1=new HashMap<>();
            map1.put("code","success");
            Gson gson=new Gson();
            return gson.toJson(map1);
    }
    //下载节假日表
    @RequestMapping(value = "/downloadFile")
    public void downloadMcode(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {

        // String s1 = com.gd.controller.group.GroupController.class.getResource("/file/").getPath();

        FileLoadUtils.fileDownLoad(response, path2+ URLEncoder.encode("法定节假日表.xlsx", "UTF-8"));

    }
    //导入节假日表
    @RequestMapping(value = "/import", method = RequestMethod.POST)
    @ResponseBody
    public String codeUpload(HttpServletRequest request, HttpServletResponse res) {

        List<Map<String, String>> fileContentList = new ArrayList<>();
        Gson gson = new Gson();
        System.out.println("in");
        String userExcel = "";
        //解析器解析request的上下文
        CommonsMultipartResolver muResolvers =
                new CommonsMultipartResolver(request.getSession().getServletContext());
        //先判断request中是否包涵multipart类型的数据，
        if (muResolvers.isMultipart(request)) {
            //再将request中的数据转化成multipart类型的数据
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
            Iterator itter = multiRequest.getFileNames();
            while (itter.hasNext()) {
                //这里的name为fileItem的alias属性值，相当于form表单中name
                String name = (String) itter.next();
                //根据name值拿取文件
                MultipartFile file = multiRequest.getFile(name);
                if (file != null) {
                    String fileName = file.getOriginalFilename();
                    String path = "";
                    if (fileName.substring(fileName.length() - 3, fileName.length()).equals("xls")) {
                        path = filePath + fileName + "x";

                    } else {
                        path = filePath + fileName;

                    }
                    userExcel = path;
                    File localFile = new File(path);
                    if (!localFile.getParentFile().exists()) {
                        //如果目标文件所在的目录不存在，则创建父目录
                        localFile.getParentFile().mkdirs();

                    }
                    //写文件到本地
                    try {
                        //file.transferTo(localFile);
                        if (!localFile.exists()) {
                            localFile.createNewFile();
                        }
                        FileUtils.copyInputStreamToFile(file.getInputStream(), localFile);
                    } catch (IOException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                }
            }
        }
        File file = new File(userExcel);
        if (file.exists()) {
            System.out.println("我是读到的EXCEL" + file.getAbsolutePath());
            try {
                fileContentList = ExcelUtils.readExcel(file.getAbsolutePath());
                String num="";
                for (int i = 0; i < fileContentList.size(); i++) {
                    if (i != fileContentList.size() - 1) {
                        String kk = fileContentList.get(i).get("0");
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
                        java.sql.Date sdate = null; //初始化
                        try {
                            java.util.Date udate = sdf.parse(kk);
                            sdate = new java.sql.Date(udate.getTime()); //2013-01-14
                        } catch (ParseException e) {
                            e.printStackTrace();
                        }
                        num = num + sdate + ",";
                    } else {
                        String kk = fileContentList.get(i).get("0");
                        // String str = "2013-01-14";
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
                        java.sql.Date sdate = null; //初始化
                        try {
                            java.util.Date udate = sdf.parse(kk);
                            sdate = new java.sql.Date(udate.getTime()); //2013-01-14
                        } catch (ParseException e) {
                            e.printStackTrace();
                        }
                        num = num + sdate;
                    }
                }
                Config config=new Config();
                config.setRestDay(num);
                String flag=this.configService.addConfig(config);

                file.delete();

            } catch (FileNotFoundException e) {
                e.printStackTrace();

            } catch (FileFormatException e) {
                e.printStackTrace();
            }
            if (fileContentList.size() == 0) {
                Map<String, Object> resultMap = new HashMap<String, Object>();
                resultMap.put("code", "10004");
                resultMap.put("data", "excel is null");
                return gson.toJson(resultMap);
            }
        }
        return null;
    }
   //清除几个月前的数据
    @RequestMapping(value = "/clean" ,method = RequestMethod.POST)
    public String clean(@RequestBody String year){
        /*ConfigData configData=new ConfigData();
        configData.setTimeoutClearingSetting(data);
        this.configService.cleanData(configData);*/
        this.configService.cleanAttendanceData(year);
        Map<String,String> map=new HashMap<>();
        map.put("code","success");
        Gson gson=new Gson();
        return gson.toJson(map);
    }
    //显示当前设置的清除日期
    //清除几个月前的数据
    @RequestMapping(value = "/cleanNow" ,method = RequestMethod.GET)
    public String getclean(){
        String clean=this.configService.getcleanData();

        Map<String,String> map=new HashMap<>();
        map.put("data",clean);
        Gson gson=new Gson();
        return gson.toJson(map);
    }
    //添加大屏显示文字
    @RequestMapping(value="/addText",method = RequestMethod.POST)
    public String addText(@RequestBody String num){
        DisPlay disPlay=new DisPlay();
        disPlay.setDisplayContent(num);
        this.configService.addDisPlay(disPlay);
        Map<String,Object> map=new HashMap<>();
        map.put("data","success");
        Gson gson=new Gson();
        return gson.toJson(map);

    }
    //查询当前大屏显示文字
    @RequestMapping(value="/getTextNow",method = RequestMethod.GET)
    public String getTextNow(){
        String value=this.configService.getDisPlayParam();
        DisPlay disPlay=this.configService.getDisPlayNow(Integer.parseInt(value));
        Map<String,Object> map=new HashMap<>();
        map.put("data",disPlay);
        Gson gson=new Gson();
        return gson.toJson(map);

    }
    //读取历史大屏显示数据
    @RequestMapping(value="/getText",method = RequestMethod.GET)
    public String getText(){
        List<DisPlay> disPlayList=this.configService.getDisPlay();
        Map<String,Object> map=new HashMap<>();
        map.put("data",disPlayList);
        Gson gson=new Gson();
        return gson.toJson(map);

    }
    //设置当前大屏显示界面
    @RequestMapping(value="/addConfigText",method = RequestMethod.POST)
    public String addConfigText(@RequestBody int num){
        DisPlay disPlay=new DisPlay();
        disPlay.setContentId(num);
        this.configService.addConfigDisPlay(disPlay);
        Map<String,Object> map=new HashMap<>();
        map.put("data","success");
        Gson gson=new Gson();
        return gson.toJson(map);

    }
    //读取CS端大屏显示数据
    @RequestMapping(value="/getCSText",method = RequestMethod.GET)
    public String getCSText(){
        List<CsConfig> csConfigs=this.configService.getCsText();
        Map<String,Object> map=new HashMap<>();
        map.put("data",csConfigs);
        Gson gson=new Gson();
        return gson.toJson(map);

    }
    //设置CS大屏显示系统为
    @RequestMapping(value="/addCSText",method = RequestMethod.POST)
    public String addCSText(@RequestBody int i){
        CsConfig csConfig=new CsConfig();
        csConfig.setPanelId(i);
       this.configService.addCsText(csConfig);
        Map<String,Object> map=new HashMap<>();
        map.put("data","success");
        Gson gson=new Gson();
        return gson.toJson(map);

    }
    //查询当前CS端显示系统
    @RequestMapping(value="/getCSTextNow",method = RequestMethod.GET)
    public String getCSTextNow(){
        String value=this.configService.getCsTextParam();
        CsConfig csConfigs=this.configService.getCsTextNow(Integer.parseInt(value));
        Map<String,Object> map=new HashMap<>();
        map.put("data",csConfigs);
        Gson gson=new Gson();
        return gson.toJson(map);

    }
    //为fr_cs_services设置默认摄像机ID,并返回给CS端
    @RequestMapping(value="/addCamera1",method = RequestMethod.POST)
    public String addCamera1(@RequestBody int i){
        //把当前摄像机ID存放到config表中
        this.configService.addCamera1(i);
        //根据摄像机ID查询serviceID
        String serviceID=this.configService.queryForServicesId(i);
        //获取当前摄像机的ServiceIP
        String serviceIP=this.configService.queryForServicesIpByid(Integer.parseInt(serviceID));
        //根据serviceID，在对应表中更新默认的CameraID
        CsServers csServers=new CsServers();
        csServers.setServiceId(Integer.parseInt(serviceID));
        csServers.setShowCameraID(i);
        this.configService.updateServiceCameraId(csServers);

        Map<String,Object> map=new HashMap<>();
        map.put("data1",serviceIP);
        Gson gson=new Gson();
        return gson.toJson(map);

    }
    //查询当前使用的摄像机
    @RequestMapping(value="/getCameraNow",method = RequestMethod.GET)
    public String getCameraNow(){
        /*String value=this.configService.getCameraParam();*/
        Camera camera=this.configService.getCameraNow(1);

        Map<String,Object> map=new HashMap<>();
        map.put("data",camera);
        Gson gson=new Gson();
        return gson.toJson(map);

    }
    //添加考勤地点
    @RequestMapping(value="/addCameraLocation",method = RequestMethod.POST)
    public String addCameraLocation(@RequestBody String cam){
        CameraLocation cameraLocation=new CameraLocation();
        cameraLocation.setAttendanceLocationName(cam);
        //查询该地点是否已存在
        Integer num=this.configService.selectCameraLocation(cameraLocation);
        if(num>0){
            Map<String,Object> map=new HashMap<>();
            map.put("code","esit");
            Gson gson=new Gson();
            return gson.toJson(map);
        }else{
            this.configService.addCameraLocation(cameraLocation);
            Map<String,Object> map=new HashMap<>();
            map.put("code","success");
            Gson gson=new Gson();
            return gson.toJson(map);
        }


    }
    //获取config的CollectNewResult的值
    @RequestMapping(value="/CollectNewResult",method = RequestMethod.GET)
    public String CollectNewResult(){
        String value=this.configService.getCollectNewResult();
        Map<String,Object> map=new HashMap<>();
        map.put("code",value);
        if(!value.equals("0")){
            //如果不是0，则将它置为0；
            this.configService.setCollectNewResult();
        }
        Gson gson=new Gson();
        return gson.toJson(map);

    }
    //获取config的CollectNewResult的值
    @RequestMapping(value="/checkName1",method = RequestMethod.POST)
    public String checkName1(@RequestBody String id){
        List<UserInfo> userInfos=this.configService.getNamesByOrgId(id);
        UserInfo userInfo=new UserInfo();
        userInfo.setCollectId(99999);
        userInfo.setRealName("全部人员");
        userInfos.add(userInfo);
        Collections.reverse(userInfos);

        Map<String,Object> map=new HashMap<>();
        map.put("data",userInfos);
        Gson gson=new Gson();
        return gson.toJson(map);

    }
    //导出考勤地点
    @RequestMapping(value="/exportCameraLocation",method = RequestMethod.GET)
    public void exportCameraLocation(HttpServletResponse res){
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet("组织机构");
        sheet.autoSizeColumn(1);
        HSSFCellStyle style = wb.createCellStyle();
        HSSFFont fontSearch = wb.createFont();
        fontSearch.setFontHeightInPoints((short) 15);
        style.setFont(fontSearch);
        style.setBorderBottom(HSSFCellStyle.BORDER_DOUBLE);
        style.setBorderLeft(HSSFCellStyle.BORDER_DOUBLE);
        style.setBorderRight(HSSFCellStyle.BORDER_DOUBLE);
        style.setBorderTop(HSSFCellStyle.BORDER_DOUBLE);
        HSSFRow head = sheet.createRow(0);
        HSSFCell encoder_name1 = head.createCell(0);
        encoder_name1.setCellValue("考勤地点");
        HSSFCell encoder_channel1 = head.createCell(1);
        encoder_channel1.setCellValue("考勤地点ID");
        //组的树结构组装开始
        List<CameraLocation> cameraLocationList=this.orgTreeService.queryForCameraLoaction();
        for(int i=0;i<cameraLocationList.size();i++){
            HSSFRow heads = sheet.createRow(i+1);
            HSSFCell name = heads.createCell(0);
            name.setCellValue(cameraLocationList.get(i).getAttendanceLocationName());
            HSSFCell id = heads.createCell(1);
            id.setCellValue(cameraLocationList.get(i).getAttendanceLocationID());
        }
        File path = new File( path2);
        if (!path.exists()) {
            path.mkdir();
        }
        String path1 = path2+ File.separator + "下载测试文档" + ".xls";

        try {
            FileOutputStream fileout = new FileOutputStream(path1);
            wb.write(fileout);
            fileout.flush();
            fileout.close();
            System.out.println(path1);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        try {
            File ss = new File(path1);
            if (!ss.exists()) {
                ss.mkdir();
            }
            OutputStream os = res.getOutputStream();
            res.reset();
            res.setHeader("Content-Disposition", "attachment; filename=dict.txt");
            res.setContentType("application/octet-stream; charset=utf-8");
            os.write(FileUtils.readFileToByteArray(ss));
            System.out.println(os);
            os.flush();
            os.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
    //导出考勤数据
    @RequestMapping(value="/downloadData",method = RequestMethod.POST)
    public void downloadData(@RequestBody Map<String,String> map, HttpServletResponse res){
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet("考勤记录导出");
        //sheet.autoSizeColumn(1);
        for (int i = 0; i <= 5; i++) {
            sheet.setColumnWidth(i,5000);
        }

        HSSFCellStyle style = wb.createCellStyle();
        HSSFFont fontSearch = wb.createFont();
        fontSearch.setFontHeightInPoints((short) 15);
        style.setFont(fontSearch);
        style.setBorderBottom(HSSFCellStyle.BORDER_DOUBLE);
        style.setBorderLeft(HSSFCellStyle.BORDER_DOUBLE);
        style.setBorderRight(HSSFCellStyle.BORDER_DOUBLE);
        style.setBorderTop(HSSFCellStyle.BORDER_DOUBLE);
        HSSFRow head = sheet.createRow(0);
        HSSFCell encoder_group1 = head.createCell(0);
        encoder_group1.setCellValue("所属部门");
        HSSFCell encoder_name1 = head.createCell(1);
        encoder_name1.setCellValue("人员姓名");
        HSSFCell encoder_channel1 = head.createCell(2);
        encoder_channel1.setCellValue("上班时间");
        HSSFCell encoder_channel2 = head.createCell(3);
        encoder_channel2.setCellValue("下班时间");
        HSSFCell encoder_channel3 = head.createCell(4);
        encoder_channel3.setCellValue("备注");
        HSSFCell encoder_channel4 = head.createCell(5);
        encoder_channel4.setCellValue("记录时间");
        //组的树结构组装开始

        List<Record> dataList=this.configService.downLoadData(map);
       for(int i=0;i<dataList.size();i++){
            HSSFRow heads = sheet.createRow(i+1);

           HSSFCell group = heads.createCell(0);
           group.setCellValue(dataList.get(i).getParentorg()+"-"+dataList.get(i).getOrg());
            HSSFCell name = heads.createCell(1);
            name.setCellValue(dataList.get(i).getRealName());
            HSSFCell id = heads.createCell(2);
            if(dataList.get(i).getClockIn()==null){
                id.setCellValue(" ");
            }else{
                id.setCellValue(dataList.get(i).getClockIn().toString().substring(
                        0,dataList.get(i).getClockIn().toString().length()-2));
            }

           HSSFCell id2 = heads.createCell(3);
           if(dataList.get(i).getClockOff()==null){
               id2.setCellValue(" ");
           }else{
               id2.setCellValue(dataList.get(i).getClockOff().toString().substring(
                       0,dataList.get(i).getClockOff().toString().length()-2));
           }
           HSSFCell id3 = heads.createCell(4);
          if(dataList.get(i).getAttendanceFlag()==null){
              id3.setCellValue(" ");
          }else{
              id3.setCellValue(dataList.get(i).getAttendanceFlag());
          }
           HSSFCell id4 = heads.createCell(5);
          id4.setCellValue(dataList.get(i).getCreateTime().toString());
        }
        File path = new File( path2);
        if (!path.exists()) {
            path.mkdir();
        }
        String path1 = path2+ "考勤记录" + ".xls";
        try {
            FileOutputStream fileout = new FileOutputStream(path1);
            wb.write(fileout);
            fileout.flush();
            fileout.close();
            System.out.println(path1);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        try {
            File ss = new File(path1);
            if (!ss.exists()) {
                ss.mkdir();
            }
            OutputStream os = res.getOutputStream();
            res.reset();
            res.setHeader("Content-Disposition", "attachment; filename=test.txt");
            res.setContentType("application/octet-stream; charset=utf-8");
            os.write(FileUtils.readFileToByteArray(ss));
            os.flush();
            os.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
