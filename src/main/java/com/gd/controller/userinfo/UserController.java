package com.gd.controller.userinfo;

import com.gd.domain.account.Account;
import com.gd.domain.account_camera.Account_Camera;
import com.gd.domain.account_role.AccountRole;
import com.gd.domain.account_user.AccountUser;
import com.gd.domain.group.GroupInfo;
import com.gd.domain.org.Org;
import com.gd.domain.org.ZTreeParams;
import com.gd.domain.query.Record;
import com.gd.domain.userinfo.UserInfo;
import com.gd.domain.userinfo.UserInfoPicture;
import com.gd.domain.userinfo.UserInfoVoice;
import com.gd.domain.video.SimplePicture;
import com.gd.service.account.IAccountService;
import com.gd.service.account_role.IAccountRoleService;
import com.gd.service.account_user.IAccountUserService;
import com.gd.service.org.IOrgService;
import com.gd.service.orgtree.IOrgTreeService;
import com.gd.service.userinfo.IUserInfoService;
import com.gd.util.*;
import com.google.gson.Gson;
import io.swagger.annotations.*;
import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.xmlbeans.impl.piccolo.io.FileFormatException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DuplicateKeyException;
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
import java.lang.reflect.InvocationTargetException;
import java.util.*;


/**
 * Created by dell on 2017/4/5.
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
@RequestMapping("/user")
@Api(value = "UserController", description = "用户相关api")
public class UserController {
    @Value("${excel.path}")
    private String path1;
    @Value("${excel.path2}")
    private String path2;
    @Value("${picture.url}")
    private String urlRoot;
    @Autowired
    private IUserInfoService userInfoService;
    @Autowired
    private IOrgService orgService;
    @Autowired
    private IOrgTreeService orgTreeService;
    @Autowired
    private IAccountService accountService;
    @Autowired
    private IAccountUserService accountUserService;
    @Autowired
    private IAccountRoleService iAccountRoleService;
    @Value("${picture.url}")
    private String picRootUrl;
    @RequestMapping(method = RequestMethod.GET)
    @ApiOperation(value = "查询用户列表", notes = "查询用户列表", httpMethod = "GET", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiResponses(value = {
            @ApiResponse(code = 401, message = "No Privilege"),
            @ApiResponse(code = 405, message = "Invalid input")
    })
    public String queryForUserList() {
        List<UserInfo> userInfoList = new ArrayList<>();
        userInfoList = this.userInfoService.queryForObject(new UserInfo());
        Map<String, Object> resultMap = new HashMap<>();

        resultMap.put("code", "0000");
        resultMap.put("data", userInfoList);
        //resultMap.put("total_count", userInfoList.size());
        Gson gson = new Gson();
        return gson.toJson(resultMap);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    @ApiOperation(value = "查询用户", notes = "查询用户", httpMethod = "GET", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiResponses(value = {
            @ApiResponse(code = 401, message = "No Privilege"),
            @ApiResponse(code = 405, message = "Invalid input")
    })
    public String queryForUser(@PathVariable String id) {
        UserInfo queryUserInfo = new UserInfo();
        queryUserInfo.setId(id);
        UserInfo userInfo = this.userInfoService.queryForObject(queryUserInfo).get(0);
        Map<String, Object> resultMap = new HashMap<>();

        resultMap.put("code", "0000");
        resultMap.put("data", userInfo);
        //resultMap.put("total_count", userInfoList.size());
        Gson gson = new Gson();
        return gson.toJson(resultMap);
    }


    @RequestMapping(method = RequestMethod.POST)
    @ApiOperation(value = "新增用户", notes = "新增用户", httpMethod = "POST", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ApiResponses(value = {
            @ApiResponse(code = 401, message = "No Privilege"),
            @ApiResponse(code = 405, message = "Invalid input")
    })
    public String add(@RequestBody UserInfo user) {
        user = (UserInfo) BaseModelFieldSetUtils.FieldSet(user);
        //判断用户是否已存在
        List<UserInfo> nameList = this.userInfoService.queryForName1(new UserInfo());
        if(nameList.size()<=0){
            this.userInfoService.insertUser(user);
        }
        //获取当前simplephoto表的collectid最大值
        Integer num = this.userInfoService.getSimplePhotoMax();

        Map<String, Object> resultMap = new HashMap<>();

            resultMap.put("code", "0001");
            resultMap.put("data", "user insert failed");

        Gson gson = new Gson();
        return gson.toJson(resultMap);

    }

    //新增用户（树结构）
    @RequestMapping(value = "/addOrgUser", method = RequestMethod.POST)
    public String addOrgUser(@RequestBody UserInfo user) {
        Org org = this.orgService.getGroupOne(user.getOrgId());
        user.setOrg(org.getOrgName());
        user.setParentorg(org.getParentName());
        user = (UserInfo) BaseModelFieldSetUtils.FieldSet(user);
        Map<String, Object> resultMap = new HashMap<>();
        ZTreeParams zTreeParamsz = new ZTreeParams();
        zTreeParamsz.setId(user.getId());
        zTreeParamsz.setpId(user.getOrgId());
        zTreeParamsz.setNum("2");
        zTreeParamsz.setIcon("/img/people.png");
        zTreeParamsz.setParent(false);
        zTreeParamsz.setName(user.getRealName());

        int flag = 0;
        try {
            flag = this.userInfoService.insertUser(user);
        } catch (DuplicateKeyException e) {
            resultMap.put("code", "0001");
            resultMap.put("data", "phone or policeNum repeat");
            Gson gson = new Gson();
            return gson.toJson(resultMap);
        }
        if (flag == 1) {
            resultMap.put("code", "0000");
            resultMap.put("data", zTreeParamsz);
        } else {
            resultMap.put("code", "0001");
            resultMap.put("data", "user insert failed");
        }
        Gson gson = new Gson();
        return gson.toJson(resultMap);

    }

    //为用户添加头像
    @RequestMapping(value = "/addPicture", method = RequestMethod.POST)
    @ResponseBody
    public String uploadFile(MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 参数列表
        String picName = request.getParameter("policeNum") + ".jpg";
        System.out.println(file);
        if (file != null) {
            savePic(file.getInputStream(), picName);
            String fileName = file.getOriginalFilename();
            UserInfoPicture userInfoPicture = new UserInfoPicture();
            userInfoPicture.setName(path1 + picName);
            userInfoPicture.setUuid(UUID.randomUUID().toString());
            this.userInfoService.addPicture(userInfoPicture);
            Map<String, String> resultMap = new HashMap<>();
            resultMap.put("uuid", userInfoPicture.getUuid());
            Gson gson = new Gson();
            return gson.toJson(resultMap);
        } else {
            Map<String, String> resultMap = new HashMap<>();
            resultMap.put("uuid", "null");
            Gson gson = new Gson();
            return gson.toJson(resultMap);
        }


    }

    private void savePic(InputStream inputStream, String fileName) {

        OutputStream os = null;
        try {
            // String path = "D:\\testFile\\";
            String path = path1;
            // 2、保存到临时文件
            // 1K的数据缓冲
            byte[] bs = new byte[1024];
            // 读取到的数据长度
            int len;
            // 输出的文件流保存到本地文件

            File tempFile = new File(path);
            if (!tempFile.exists()) {
                tempFile.mkdirs();
            }
            os = new FileOutputStream(tempFile.getPath() + File.separator + fileName);
            // 开始读取
            while ((len = inputStream.read(bs)) != -1) {
                os.write(bs, 0, len);
            }

        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 完毕，关闭所有链接
            try {
                os.close();
                inputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }



    @RequestMapping(value = "/edits", method = RequestMethod.POST)
    public void edits(@RequestBody List<UserInfo> userInfos) {
        for (int i = 0; i < userInfos.size(); i++) {
            this.userInfoService.updateUser(userInfos.get(i));
        }
    }
    //批量删除用户
    @RequestMapping(value = "delete_select", method = RequestMethod.POST)
    public String delete_change(@RequestBody List<UserInfo> kind) {
        StringBuffer stringBuffer=new StringBuffer();
        for (int i = 0; i < kind.size(); i++) {
            UserInfo userInfo = new UserInfo();
            userInfo.setId(kind.get(i).getId());
            userInfo.setBeIsDeleted(1);
            //更新用户表的BeIsDeleted为0
            this.userInfoService.updateUser(userInfo);
            //组装给CS端发送的字符串
            UserInfo userInfo1=this.userInfoService.queryForObject1(userInfo);
            if (kind.size() != i + 1) {
                stringBuffer.append(userInfo1.getCollectId() + "-");
            } else {
                stringBuffer.append(userInfo1.getCollectId());
            }
        }
        Map<String, Object> resultMap = new HashMap<>();
        Gson gson=new Gson();
        resultMap.put("data",stringBuffer);
        return gson.toJson(resultMap);
          /*  //根据用户ID查询用户uuid，根据uuid删除picture表图片
            String uuid = this.userInfoService.queryForUUID(userInfo);
            UserInfoPicture userInfoPicture = new UserInfoPicture();
            userInfoPicture.setUuid(uuid);
            //根据UUID查找到图片名称，并删除对应图片。
            UserInfoPicture userInfoPicture1 = this.userInfoService.queryForPicture(userInfoPicture);
            if (userInfoPicture1 != null) {
                String picturePath = path1 + userInfoPicture1.getName();
                deleteFile(picturePath);
            }
            this.userInfoService.deleteUserPicture(userInfoPicture);
            //根据用户collectid删除simplephoto表内容
            List<UserInfo> userInfo1=this.userInfoService.queryForObject(userInfo);
            this.userInfoService.deleteForSimplePhoto(userInfo1.get(0).getCollectId());*/
            //根据用户ID删除用户表内容
            //int flag = this.userInfoService.deleteUser(userInfo);
           /* AccountUser accountUser = new AccountUser();
            accountUser.setUserId(userInfo.getId());
            //根据账户用户实体，查询出账户用户表的关于此账户的内容列表
            List<AccountUser> accountUsers = this.accountUserService.queryForObject(accountUser);
            for (AccountUser a : accountUsers) {
                Account account = new Account();
                account.setId(a.getAccountId());
                //删除账户表内容
                this.accountService.deleteForObject(account);
                AccountRole accountRole = new AccountRole();
                accountRole.setAccountId(a.getAccountId());
                //删除账户角色表内容
                this.iAccountRoleService.deleteForObject(a.getAccountId());

            }
            //删除账户用户表内容
            this.accountUserService.delete(accountUser);*/

    }

    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    @ApiOperation(value = "删除用户", notes = "删除用户", httpMethod = "DELETE", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "用户id", required = true, dataType = "String", paramType = "path")
    })
    public String delete(@PathVariable("id") String id) {
        UserInfo userInfo = new UserInfo();
        userInfo.setId(id);
        userInfo.setBeIsDeleted(1);
        //更新用户表的BeIsDeleted为0
        this.userInfoService.updateUser(userInfo);
        //组装给CS端发送的字符串
        UserInfo userInfo1=this.userInfoService.queryForObject1(userInfo);
        String csString=String.valueOf(userInfo1.getCollectId());
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("data",csString);
        Gson gson = new Gson();
        return gson.toJson(resultMap);
    }
        //根据用户ID查询用户uuid，根据uuid删除picture表图片
      /*  String uuid = this.userInfoService.queryForUUID(userInfo);
        UserInfoPicture userInfoPicture = new UserInfoPicture();
        userInfoPicture.setUuid(uuid);
        //根据UUID查找到图片名称，并删除对应图片。
        UserInfoPicture userInfoPicture1 = this.userInfoService.queryForPicture(userInfoPicture);
        if (userInfoPicture1 != null) {
            String picturePath = urlRoot+ userInfoPicture1.getName();
            deleteFile(picturePath);
        }
        this.userInfoService.deleteUserPicture(userInfoPicture);
        //根据用户的CollectID删除SimplePhoto表中的数据
        List<UserInfo> userInfo1=this.userInfoService.queryForObject(userInfo);
        this.userInfoService.deleteForSimplePhoto(userInfo1.get(0).getCollectId());
        //根据用户ID删除用户表内容
        int flag = this.userInfoService.deleteUser(userInfo);
        AccountUser accountUser = new AccountUser();
        accountUser.setUserId(userInfo.getId());
        //根据账户用户实体，查询出账户用户表的关于此账户的内容列表
        List<AccountUser> accountUsers = this.accountUserService.queryForObject(accountUser);
        for (AccountUser a : accountUsers) {
            Account account = new Account();
            account.setId(a.getAccountId());
            //删除账户表内容
            this.accountService.deleteForObject(account);
            AccountRole accountRole = new AccountRole();
            accountRole.setAccountId(a.getAccountId());
            //删除账户角色表内容
            this.iAccountRoleService.deleteForObject(a.getAccountId());

        }
        //删除账户用户表内容
        this.accountUserService.delete(accountUser);

        if (flag == 1) {
            resultMap.put("code", "0000");
            resultMap.put("data", "success");
        } else {
            resultMap.put("code", "0011");
            resultMap.put("data", "user delete failed");
        }*/


    //删除用户时删除对应头像
    public static boolean deleteFile(String filePath) {
        File file = new File(filePath);
        if (file.isFile() && file.exists()) {
            file.delete();
            System.out.println("删除单个文件" + filePath + "成功！");
            return true;
        } else {
            System.out.println("删除单个文件" + filePath + "失败！");
            return false;
        }
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.PUT)
    @ApiOperation(value = "更新用户状态", notes = "更新用户状态", httpMethod = "PUT", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "用户id", required = true, dataType = "String", paramType = "path")
    })
    public String updateUserStatus(@PathVariable("id") String id) {
        return null;
    }

    @RequestMapping(method = RequestMethod.PUT)
    @ApiOperation(value = "更新用户", notes = "更新用户", httpMethod = "PUT", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ApiResponses(value = {
            @ApiResponse(code = 401, message = "No Privilege"),
            @ApiResponse(code = 405, message = "Invalid input")
    })
    public String updateUser(@RequestBody UserInfo userInfo) {
        //判断必须不为空字段,不必在判断
//        String argsEmptyJudge = StringJudgeEmptyUtils.StringJudgeEmpty(userInfo, new String[]{"id","phone","policeNum","identityCode"});
//        if(!StringUtils.isEmpty(argsEmptyJudge)){
//            return argsEmptyJudge;
//        }
        UserInfo baseUserInfo = new UserInfo();
        baseUserInfo.setId(userInfo.getId());
        UserInfo oldUserInfo = userInfoService.queryForObject(baseUserInfo).get(0);
        //更新实体的createTime,updateTime,ifuse
        BaseModelFieldSetUtils.FieldSetByOldField(userInfo, oldUserInfo);
        int flag = this.userInfoService.updateUser(userInfo);
        Map<String, Object> resultMap = new HashMap<>();
        if (flag == 1) {
            resultMap.put("code", "0000");
            resultMap.put("data", "success");
        } else {
            resultMap.put("code", "0011");
            resultMap.put("data", "user update failed");
        }
        Gson gson = new Gson();
        return gson.toJson(resultMap);
    }


    @RequestMapping(value = "/org/{id}", method = RequestMethod.GET)
    @ApiOperation(value = "获取部门下所有用户", notes = "获取部门下所有用户", httpMethod = "GET", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ApiResponses(value = {
            @ApiResponse(code = 401, message = "No Privilege"),
            @ApiResponse(code = 405, message = "Invalid input")
    })
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "部门id", required = true, dataType = "String", paramType = "path")
    })
    public String getUsersByOrg(@PathVariable("id") String id) {
        List<Org> orgList = new ArrayList<>();
        List<UserInfo> userList = new ArrayList<>();
        //查询当前部门的所有下级部门
        orgList = this.orgService.getAllLeaves(id);
        //查询当前部门
        Org queryOrg = new Org();
        queryOrg.setId(id);
        orgList.add(this.orgService.queryForObject(queryOrg).get(0));
        //遍历所有下级部门（包括本部门），将人员表中orgId等于当前部门ID的人员添加
        for (int i = 0; i < orgList.size(); i++) {
            List<UserInfo> uList = new ArrayList<>();
            UserInfo user = new UserInfo();
            user.setOrgId(orgList.get(i).getId());
            uList = this.userInfoService.queryForObject(user);
            userList.addAll(uList);
        }
        Gson gson = new Gson();
        return gson.toJson(userList);
    }
    //根据部门查询人员

    @RequestMapping(value = "/queryUserinfo", method = RequestMethod.POST)
    public String getUserInfo(@RequestBody Map<String, String> map) {
        UserInfo userInfo = new UserInfo();
        userInfo.setOrg(map.get("org"));
        userInfo.setParentorg(map.get("parentOrg"));
        userInfo.setOrgId(map.get("orgId"));
        List<UserInfo> userInfoList = this.userInfoService.queryForObjectByorg(userInfo);
        Map<String, Object> map1 = new HashMap<>();
        map1.put("data", userInfoList);
        Gson gson = new Gson();
        return gson.toJson(map1);
    }
    //获取当前人员所在的部门
    @RequestMapping(value = "/thisOrg", method = RequestMethod.POST)
    public String getOrg(@RequestBody  String OrgId) {
        Org org=this.orgService.getGroupOne(OrgId);
        Map<String, Object> map1 = new HashMap<>();
        map1.put("data", org);
        Gson gson = new Gson();
        return gson.toJson(map1);
    }
    //获取CS端返回的照片分析返回结果
    @RequestMapping(value = "/CsResult/{type}/{id}", method = RequestMethod.GET)
    public String getCSResult(@PathVariable("id") String id,@PathVariable("type") String type) {
      //如果类型为1，则是我自己接收数据，如果是2，则是CS端给我发送的数据
        Map<String,Object> map=new HashMap<>();
        Gson gson=new Gson();
        if(type.equals("1")){
            //取出数据
           String aa=this.userInfoService.queryCsString();
           if(aa==null){
               map.put("code","no data");
               return gson.toJson(map);
           }else{
               //获取所有刚插入CSRESULT1的样本ID，
               List<Integer> ids=this.userInfoService.getCsResult();
               if(ids.size()<=0){
                   map.put("code","user exist");
                   return gson.toJson(map);
               }
               //取出刚刚插入的样本数据
               List<SimplePicture> simplePictureList=this.userInfoService.queryForSimplePhotos(ids);

               for(int i=0;i<simplePictureList.size();i++){
                   //获取用户名和图片地址
                  String userName=this.userInfoService.queryForObjectToCollectID(simplePictureList.get(i).getCollectId());
                 simplePictureList.get(i).setUserName(userName);
                 simplePictureList.get(i).setUrl(picRootUrl);
                 //获取图片名称
                   String[] picName=simplePictureList.get(i).getRelativePath().split("/");
                   simplePictureList.get(i).setPicName(picName[2]);
               }
               //清除CSRESULT表数据
               this.userInfoService.deleteForcsresult();
               this.userInfoService.deleteForcsresult1();
               map.put("code","success");
               map.put("data",simplePictureList);
               return gson.toJson(map);
           }
        }else{
            //存数据到Cs_Result表
        this.userInfoService.insertCsString(id);

        }
        return "";
    }

    //获取所有样本照片CollectID
    @RequestMapping(value = "/getCsResult", method = RequestMethod.GET)
    public String getCSResult1() {
        List<Integer> CollectIDs=this.userInfoService.getCsResultForCollectID();
        HashSet h=new HashSet(CollectIDs);
        CollectIDs.clear();
        CollectIDs.addAll(h);
        Map<String,String> map=new HashMap<>();
        Gson gson=new Gson();
        if(CollectIDs.size()<=1){
            String s1=CollectIDs.toString();
            String s4=s1.substring(1,s1.length()-1);
            map.put("data",s4);
            System.out.println("呼叫！呼叫！长度小于1"+s4);
            return gson.toJson(map);
        }else{
            String s1=CollectIDs.toString();
            String s2=s1.replace(",","-");
            String s3=s2.replace(" ","");
            String s4=s3.substring(1,s3.length()-1);
            map.put("data",s4);
            System.out.println("呼叫！呼叫！长度大于1"+s4);
            return gson.toJson(map);
        }

    }
    //删除csresult1表中的数据
    @RequestMapping(value = "/deleteCsResult", method = RequestMethod.GET)
    public void deleteCsResult1(){
        this.userInfoService.deleteForcsresult1();
    }

    //批量导出不合格人员照片
    @RequestMapping(value="/exportFilePicture",method = RequestMethod.GET)
    public void exportFilePicture(HttpServletResponse res, HttpSession session) {
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet("不合格人员照片信息");
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
        encoder_name1.setCellValue("姓名");
        HSSFCell group1 = head.createCell(1);
        group1.setCellValue("图片名称");
        HSSFCell encoder_address1 = head.createCell(2);
        encoder_address1.setCellValue("失败原因");
        //导出未注册上的照片数据
        List<SimplePicture> list=this.userInfoService.queryForSimplePhotosToBeIsRegistered();
        for (int i = 0; i < list.size(); i++) {
            HSSFRow rowHeard = sheet.createRow(i + 1);
            HSSFCell encoder_name = rowHeard.createCell(0);
            encoder_name.setCellValue(list.get(i).getRealName());
            HSSFCell groups = rowHeard.createCell(1);
            String[] picName=list.get(i).getRelativePath().split("/");
            groups.setCellValue(picName[2]);
            HSSFCell encoder_address = rowHeard.createCell(2);
            encoder_address.setCellValue(list.get(i).getFailReasons());

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

    //获取单个人员的样本照片
    @RequestMapping(value="/getSimplePhotoByOne",method = RequestMethod.POST)
    public String getSimplePhotoByOne(@RequestBody String collectId){
        List<SimplePicture> simplePictureList=this.userInfoService.getSimplePhotoByOne(Integer.parseInt(collectId));
       for(int i=0;i<simplePictureList.size();i++){
           simplePictureList.get(i).setShows(false);
           simplePictureList.get(i).setWait(i);
       }
        Map<String,Object> map=new HashMap<>();
        Gson gson=new Gson();
        map.put("data",simplePictureList);
        //获取图片地址的根目录
        map.put("urlRoot",urlRoot);
        return gson.toJson(map);
    }
    //删除单个人员的样本照片
    @RequestMapping(value="/deleteSimplePhotoByOne",method = RequestMethod.POST)
    public void deleteSimplePhotoByOne(@RequestBody String id){
        this.userInfoService.deleteForSimplePhotobyId(Integer.parseInt(id));
    }
    //按照名字批量生成语音文件
    @RequestMapping(value = "/voice",method = RequestMethod.GET)
    public List<String> textToSpeak(){
        List<String> result=this.userInfoService.queryForVoiceByUUID();
        return result;
    }



}
