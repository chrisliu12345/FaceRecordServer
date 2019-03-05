package com.gd.controller.org;

import com.gd.domain.group.GroupInfo;
import com.gd.domain.org.Org;
import com.gd.domain.org.ZTreeParams;
import com.gd.domain.query.Record;
import com.gd.domain.userinfo.UserInfo;
import com.gd.service.group.IGroupService;
import com.gd.service.org.IOrgService;
import com.gd.service.orgtree.IOrgTreeService;
import com.gd.util.BaseModelFieldSetUtils;
import com.gd.util.ExcelUtils;
import com.gd.util.StringJudgeEmptyUtils;
import com.gd.util.TimeUtils;
import com.google.gson.Gson;
import io.swagger.annotations.*;
import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.xmlbeans.impl.piccolo.io.FileFormatException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.*;

/**
 * Created by dell on 2017/4/30.
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
@RequestMapping("/org")
@Api(value = "OrgController",description = "组织机构相关api")
public class OrgController {
    String filePath = "file/";
    @Value("${excel.path2}")
    private String path2;
    @Autowired
    IOrgService orgService;
    @Autowired
    IOrgTreeService orgTreeService;
    @Autowired
    IGroupService groupService;
    private int num=0;

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }
    @RequestMapping(method = RequestMethod.GET)
    @ApiOperation(value = "查询组织机构列表",notes = "查询组织机构列表",httpMethod = "GET",produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiResponses(value = {
            @ApiResponse(code = 401, message = "No Privilege"),
    })
    public String queryForList() {
        List<Org> userInfoList = new ArrayList<>();
        userInfoList = this.orgService.queryForObject(new Org());
        Map<String, Object> resultMap = new HashMap<>();

        resultMap.put("code", "0000");
        resultMap.put("data", userInfoList);
        //resultMap.put("total_count", userInfoList.size());
        Gson gson = new Gson();
        return gson.toJson(resultMap);
    }
    //查询单个org
    @RequestMapping(value = "/{id}",method = RequestMethod.GET)
    @ApiOperation(value = "查询组织机构",notes = "查询组织机构",httpMethod = "GET",produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiResponses(value = {
            @ApiResponse(code = 401, message = "No Privilege"),
    })
    public String queryForObject(@PathVariable String id) {
        Org baseOrg = new Org();
        baseOrg.setId(id);
        Org org = orgService.queryForObject(baseOrg).get(0);
        Map<String, Object> resultMap = new HashMap<>();

        resultMap.put("code", "0000");
        resultMap.put("data", org);
        Gson gson = new Gson();
        return gson.toJson(resultMap);
    }
    //查询组织机构下面的user和app
    @RequestMapping(value = "/{id}/userInfoApp",method = RequestMethod.GET)
    @ApiOperation(value = "查询组织下属人员和APP信息",notes = "查询组织下属人员和APP信息",httpMethod = "GET",produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiResponses(value = {
            @ApiResponse(code = 401, message = "No Privilege"),
    })
    public String queryUserInfoApp(@PathVariable String id) {
        List<Map<String,String>> queryMap = this.orgService.queryUserInfoApp(id);
        Map<String, Object> resultMap = new HashMap<>();

        resultMap.put("code", "0000");
        resultMap.put("data", queryMap);
        Gson gson = new Gson();
        return gson.toJson(resultMap);
    }


    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    @ApiOperation(value = "删除组织机构",notes = "删除组织机构",httpMethod = "DELETE",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "组织机构id", required = true, dataType = "String", paramType = "path")
    })
    public String delete(@PathVariable("id") String id) {
     /*   GroupInfo groupInfo=new GroupInfo();
        groupInfo.setGroupID(Integer.parseInt(id));
        this.groupService.delete(groupInfo);*/
        Org org=new Org();
        org.setId(id);
     //先删除该部门下的所有子部门
        List<Org>  num=this.orgService.queryForObject(org);
        Map<String, Object> resultMap1 = new HashMap<>();
        Gson gson = new Gson();
            for(int i=0; i<num.size();i++){
                Org org2=new Org();
                org2.setParentId(num.get(i).getId());
                this.orgService.deleteOrg(org2);
            }
        this.orgService.deleteOrg(org);

        resultMap1.put("code", "0001");
        resultMap1.put("data", "delete success");
        return gson.toJson(resultMap1);

    }



    @RequestMapping(method = RequestMethod.POST)
    @ApiOperation(value = "新增组织机构",notes = "新增组织机构",httpMethod = "POST",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ApiResponses(value = {
            @ApiResponse(code = 401, message = "No Privilege"),
            @ApiResponse(code = 405, message = "Invalid input")
    })
    public String add(@RequestBody Map<String,String> map) {
       /* org.setIfuse("y");*/
       Org org=new Org();
       org.setOrgName(map.get("name"));
       org.setParentId(map.get("ParentID"));
       org.setOrderNum("00");
       org.setParentName(map.get("parentName"));
        org= (Org) BaseModelFieldSetUtils.FieldSet(org);
        Map<String, Object> resultMap = new HashMap<>();
        Gson gson = new Gson();
        this.orgService.insertOrg(org);
       // String id=this.orgService.selectOrgId(org);
        ZTreeParams zTreeParams=new ZTreeParams();
        zTreeParams.setId(org.getId());
        zTreeParams.setName(org.getOrgName());
        zTreeParams.setpId(org.getParentId());
        zTreeParams.setNum("1");
        zTreeParams.setIcon("/img/group.png");
        zTreeParams.setParent(true);
            resultMap.put("code", "0001");
            resultMap.put("data", zTreeParams);
        return gson.toJson(resultMap);
    }
    @RequestMapping(method = RequestMethod.PUT)
    @ApiOperation(value = "更新组织机构",notes = "更新组织机构",httpMethod = "PUT",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ApiResponses(value = {
            @ApiResponse(code = 401, message = "No Privilege"),
            @ApiResponse(code = 405, message = "Invalid input")
    })
    public String updateOrg(@RequestBody Map<String, Object> map) {
        String id=map.get("id").toString();
        String orgName=map.get("name").toString();
        Org org=new Org();
        org.setOrgName(orgName);
        org.setId(id);
        this.orgService.updateOrg(org);
        //查询该部门的记录
        Org org1=this.orgService.getGroupOne(id);
        //更新人员表对应的组字段
        UserInfo userInfo=new UserInfo();
        userInfo.setOrg(org1.getOrgName());
        userInfo.setParentorg(org1.getParentName());
        userInfo.setOrgId(id);
        this.orgService.updateUserInfoOrg(userInfo);
        Map<String, Object> resultMap = new HashMap<>();
        Gson gson = new Gson();
        resultMap.put("data", org.getOrgName());
        return gson.toJson(resultMap);
    }
    @RequestMapping(value = "/getGroupRightOne",method = RequestMethod.POST)
    public String getGroupOne(@RequestBody String id){
        Org org=this.orgService.getGroupOne(id);
        Map<String, Object> resultMap = new HashMap<>();
        Gson gson = new Gson();
        resultMap.put("data", org);
        return gson.toJson(resultMap);

    }
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    @ApiOperation(value = "组织机构Excel上传",notes = "组织机构Excel上传",httpMethod = "POST",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public String ngUpload(HttpServletRequest request, HttpServletResponse res) {
        List<Map<String, String>> fileContentList = new ArrayList<>();
        Gson gson = new Gson();
        String orgExcel = "";
//        //接收参数
//        int id= Integer.parseInt(request.getParameter("id"));
//        System.out.println("id=="+id);
        Map<String, Object> resultMap = new HashMap<String, Object>();

        //解析器解析request的上下文
        CommonsMultipartResolver multipartResolver =
                new CommonsMultipartResolver(request.getSession().getServletContext());
        //先判断request中是否包涵multipart类型的数据，
        if (multipartResolver.isMultipart(request)) {
            //再将request中的数据转化成multipart类型的数据
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
            Iterator iter = multiRequest.getFileNames();
            while (iter.hasNext()) {
                //这里的name为fileItem的alias属性值，相当于form表单中name
                String name = (String) iter.next();
                //根据name值拿取文件
                MultipartFile file = multiRequest.getFile(name);
                if (file != null) {
                    String fileName = file.getOriginalFilename();
                    String path = filePath + fileName;
                    orgExcel = path;
                    File localFile = new File(path);
                    if (!localFile.getParentFile().exists()) {
                        localFile.getParentFile().mkdirs();
                    }
                    try {
                        //file.transferTo(localFile);
                        if (!localFile.exists()) {
                            localFile.createNewFile();
                        }
                        FileUtils.copyInputStreamToFile(file.getInputStream(), localFile);
                    } catch (IOException e) {
                        e.printStackTrace();
                        resultMap.put("code", "11001");
                        resultMap.put("data", "upload file error");
                        return gson.toJson(resultMap);
                    }
                }
            }
        }
        File file = new File(orgExcel);
        if (file.exists()) {
            System.out.println(file.getAbsolutePath());
            try {
                fileContentList = ExcelUtils.readExcel(file.getAbsolutePath());
            } catch (FileNotFoundException e) {
                e.printStackTrace();
                resultMap.put("code", "11002");
                resultMap.put("data", "parase excel error");
                return gson.toJson(resultMap);
            } catch (FileFormatException e) {
                e.printStackTrace();
                resultMap.put("code", "11002");
                resultMap.put("data", "parase excel error");
                return gson.toJson(resultMap);
            }

            if (fileContentList.size() == 0) {
                resultMap.put("code", "11004");
                resultMap.put("data", "excel is null");
                return gson.toJson(resultMap);
            }

            for (int i = 0; i < fileContentList.size(); i++) {
                Map<String, String> orgMap = new HashMap<>();
                orgMap = fileContentList.get(i);
                Org org = new Org();
                org.setId(UUID.randomUUID().toString());
                org.setCreateTime(TimeUtils.getCurrentTime());
                org.setUpdateTime(TimeUtils.getCurrentTime());
                org.setIfuse("y");

                org.setLeader(orgMap.get("1"));

                String content = orgMap.get("0");

                int left = content.indexOf("-");
                int right = content.lastIndexOf("-");
                if (left == -1 || left != right) {
                    resultMap.put("code", "11007");
                    resultMap.put("data", "org invalid");
                    return gson.toJson(resultMap);
                }
                String[] array = new String[2];
                array = content.split("-");

                String parentName = array[0];
                String name = array[1];

                if (StringUtils.isEmpty(parentName) || StringUtils.isEmpty(name)) {
                    resultMap.put("code", "11006");
                    resultMap.put("data", "unkonwn error");
                    return gson.toJson(resultMap);
                }
                Org o = new Org();
                o.setOrgName(parentName);
                List<Org> orgList = this.orgService.queryForObject(o);
                if (orgList.size() == 0) {
                    resultMap.put("code", "11007");
                    resultMap.put("data", "parent org not exists");
                    return gson.toJson(resultMap);
                }
                Map<String, String> paraMap = new HashedMap();
                paraMap.put("id", UUID.randomUUID().toString());
                paraMap.put("orgId", orgList.get(0).getId());
                paraMap.put("childrenId", org.getId());
                int flag2 = this.orgTreeService.insert(paraMap);
                if (flag2 !=1){
                    resultMap.put("code", "11008");
                    resultMap.put("data", "insert org fail");
                    return gson.toJson(resultMap);
                }
                org.setParentName(parentName);
                org.setParentId(orgList.get(0).getId());
                org.setOrgName(array[1]);
                int flag = this.orgService.insertOrg(org);
                if (flag != 1) {
                    resultMap.put("code", "11005");
                    resultMap.put("data", "insert error");
                    return gson.toJson(resultMap);
                }
            }

            file.delete();
            resultMap.put("code", "10002");
            resultMap.put("data", "parase excel error");
            return gson.toJson(resultMap);
        } else {
            resultMap.put("code", "10003");
            resultMap.put("data", "file not exists");
            return gson.toJson(resultMap);
        }
    }
    //导出组织机构
    @RequestMapping(value = "exportGroups/{id}", method = RequestMethod.GET)
    public void exportGroups(@PathVariable("id") String id,HttpServletResponse res, HttpSession session) {

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
        Org org0=this.orgService.getGroupOne(id);
        HSSFRow head = sheet.createRow(0);
        HSSFCell encoder_name1 = head.createCell(0);
        encoder_name1.setCellValue(org0.getOrgName());
        HSSFCell encoder_channel1 = head.createCell(1);
        encoder_channel1.setCellValue(org0.getId());
        //组的树结构组装开始
        List<Org> orgList=this.orgTreeService.queryForGroupToGroup(id);
        for(Org org:orgList){
            getOrgChildren(org,2);
        }
        //组装完毕
        //导出EXCEL开始
        for(Org org:orgList){
            writeExcel(org,wb);
        }
        //导出格式结束
        this.setNum(0);
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

    public void getOrgChildren(Org kk,int i){
        kk.setLevel(i);
        List<Org> orgList=this.orgTreeService.queryForGroupToGroup(kk.getId());
        if(orgList.size()>0){
            kk.setChildren(orgList);

            for(Org org:orgList){
                getOrgChildren(org,kk.getLevel()+1);
            }
        }else{
            kk.setChildren(null);
        }
    }
    private void writeExcel(Org org,HSSFWorkbook wb){
        HSSFSheet sheet = wb.getSheet("组织机构");
        this.setNum(this.getNum()+1);
        HSSFRow head = sheet.createRow(this.getNum());
        int j=0;
        for(;j<(org.getLevel()-1)*2;j++){
            head.createCell(j).setCellValue("");
        }
        HSSFCell groupName = head.createCell(j);
        groupName.setCellValue(org.getOrgName());
        HSSFCell virtualOrgID = head.createCell(j+1);
        virtualOrgID.setCellValue(org.getId());
        List<Org> groupList = org.getChildren();

        if(groupList!=null) {
            for (Org gf : groupList) {
                writeExcel(gf, wb);
            }
        }
    }
}
