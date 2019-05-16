package com.gd.controller.userinfo;

import com.gd.domain.org.Org;
import com.gd.domain.userinfo.*;
import com.gd.domain.video.SimplePicture;
import com.gd.service.org.IOrgService;
import com.gd.service.userinfo.IUserInfoService;
import com.gd.util.BaseModelFieldSetUtils;
import com.gd.util.TextToSpeak;
import com.google.gson.Gson;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.*;

/**
 * Created by Administrator on 2018/4/11 0011.
 */
@RestController
@RequestMapping("/userAdd")
public class UserController_Add {
    @Autowired
    private IUserInfoService userInfoService;
    @Autowired
    private IOrgService orgService;
    //第一步,插入用户信息
    @RequestMapping(value = "/userSession", method = RequestMethod.POST)
    public  String getUserSession(@RequestBody Map<String, Object> map) {
        Map<String, String> map1 = new HashMap<>();
        Gson gson = new Gson();
        String placId = map.get("autoGraph").toString();
        String orgid = map.get("orgId").toString();
        String org = map.get("org").toString();
        String parentorg = map.get("parentorg").toString();
        String name = map.get("realName").toString();
        String employee = map.get("policeNum").toString();
        UserInfo userInfo = new UserInfo();
        userInfo.setOrgId(orgid);
        userInfo.setRealName(name);
        List<UserInfo> nameList = this.userInfoService.queryForName1(userInfo);
        if (nameList.size() > 0) {
            map1.put("data", "no");
            return gson.toJson(map1);
        } else {
            ImportUser1 importUser = new ImportUser1();
            importUser.setPlaceId(Integer.parseInt(placId));
            importUser.setOrgId(Integer.parseInt(orgid));
            importUser.setOrgName(org);
            importUser.setParentOrgName(parentorg);
            importUser.setName(name);
            importUser.setEmployee(employee);
            this.userInfoService.importUserTemp1(importUser);
            //第一次查入用户信息
            synchronized(this) {
                Integer num = this.userInfoService.getSimplePhotoMax();
                if (num == null) {
                    num = 1;
                }
                UserInfo userInfo1 = new UserInfo();
                userInfo1.setRealName(name);
                userInfo1.setPicture(UUID.randomUUID().toString());
                userInfo1.setParentorg(parentorg);
                userInfo1.setPoliceNum(employee);
                userInfo1.setAutoGraph(placId);
                userInfo1.setCollectId(num + 1);
                userInfo1.setOrg(org);
                userInfo1.setOrgId(orgid);
                userInfo1 = (UserInfo) BaseModelFieldSetUtils.FieldSet(userInfo1);
                this.userInfoService.insertUser(userInfo1);
            }
            map1.put("data", "yes");
            return gson.toJson(map1);
        }
    }
    //第二步，为用户注册照片
    @RequestMapping(value = "/simpleUserPicImport", method = RequestMethod.POST)
    @ResponseBody
    public String simpleUserPicImport(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        //获取根路径
        String rootPath = this.userInfoService.getRootPath();
        String rootPath1 = (rootPath).replace("/", "\\");
        //获取用户信息
        ImportUser1 importUser1 = this.userInfoService.getImportUser1();
        //获取对应UserInfo的NUM最大值
        UserInfo userInfo = new UserInfo();
        userInfo.setOrgId(String.valueOf(importUser1.getOrgId()));
        userInfo.setRealName(importUser1.getName());

        List<UserInfo> users = this.userInfoService.queryForObject(userInfo);
        int num = users.get(0).getCollectId();
        List<String> nameList = new ArrayList<>();
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
                MultipartFile zipFile = multiRequest.getFile(name);
                String path = rootPath1 + zipFile.getOriginalFilename();
                //对文件名进行分割再拼接
                String[] buildName = new String[2];
                buildName = zipFile.getOriginalFilename().split("_");
                buildName[0] = String.valueOf(num);
                //图片名称重新拼接完成的结果：
                Random random = new Random();
                String pictureBuildOk = buildName[0] + "_" + random.nextInt(1000);
                //样本照片
                String path2 = rootPath1 + "SamplePhotos\\" + importUser1.getOrgId();
                //证件照
                String path3 = rootPath1 + "CertificatePhotos\\";
                String path3_1=rootPath1+"CertificatePhotosFace\\";
                //simple_photo根路径
                String path201 = "SamplePhotos\\" + importUser1.getOrgId() + "\\";
                //user_picture根路径
                String path301 = "CertificatePhotos\\";
                String path401="CertificatePhotosFace\\";
                //生成语音MP3
               // TextToSpeak textToSpeak=new TextToSpeak();
                //textToSpeak.textSpeak(importUser1.getName(),rootPath1+"VoicePlayback\\"+importUser1.getOrgId() + "\\"+importUser1.getName()+".mp3");
                if (zipFile != null) {
                    int id = saveSimplePic(zipFile.getInputStream(), zipFile.getInputStream(),zipFile.getInputStream(), path2, path3,path3_1, pictureBuildOk, path201, path301,path401, users);
                    Gson gson = new Gson();
                    return gson.toJson(id);
                } else {
                    Map<String, String> resultMap = new HashMap<>();
                    resultMap.put("uuid", "null");
                    Gson gson = new Gson();
                    return gson.toJson(resultMap);
                }
            }

        }

        return "";
    }

    private int saveSimplePic(InputStream inputStream, InputStream inputStream2, InputStream inputStream3,String path2, String path3,String path3_1, String pictureName,
                              String path201, String path301, String path401,List<UserInfo> users) {

        OutputStream os = null;
        try {
            // 2、保存到临时文件
            // 1K的数据缓冲
            byte[] bs = new byte[1024];
            // 读取到的数据长度
            int len;
            // 输出的文件流保存到本地文件

            File tempFile = new File(path2);
            if (!tempFile.exists()) {
                tempFile.mkdirs();
            }
            os = new FileOutputStream(tempFile.getPath() + File.separator + pictureName + ".jpg");

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
        //插入样本照片
        SimplePicture simplePicture = new SimplePicture();
        simplePicture.setCollectId(users.get(0).getCollectId());
        String outPath = (path201 + pictureName + ".jpg").replace("\\", "/");
        simplePicture.setRelativePath(outPath);
        this.userInfoService.addSimplePicture(simplePicture);
        CsResult csResult = new CsResult();
        csResult.setPhotoId(simplePicture.getId());
        csResult.setPhotoCollectId(simplePicture.getCollectId());
        this.userInfoService.addcsresult1(csResult);
        //判断user_picture是否已经有证件照
        UserInfoPicture userInfoPicture = new UserInfoPicture();
        userInfoPicture.setUuid(users.get(0).getPicture());
        UserInfoPicture result = this.userInfoService.queryForPicture(userInfoPicture);
        if (result != null) {
            //如果存在了，则什么都不执行。否则插入样本照片

        } else {
            saveUserPic(inputStream2,inputStream3, path3,path3_1,pictureName);
            String outPath1 = (path301 + pictureName + ".jpg").replace("\\", "/");
            String outPath2 = (path401 + pictureName + ".jpg").replace("\\", "/");
            userInfoPicture.setName(outPath1);
            userInfoPicture.setName2(outPath2);
            this.userInfoService.addPicture(userInfoPicture);

        }
        return simplePicture.getId();

    }

    private void saveUserPic(InputStream inputStream,InputStream inputStream3,String path3, String path3_1,String pictureName) {
        OutputStream os1 = null;
        OutputStream os2=null;

        try {

            // 2、保存到临时文件
            // 1K的数据缓冲
            byte[] bs1 = new byte[1024];
            byte[] bs2=new byte[1024];
            // 读取到的数据长度
            int len1;
            int len2;
            // 输出的文件流保存到本地文件

            File tempFile = new File(path3);
            File tempFile2=new File(path3_1);
            if (!tempFile.exists()) {
                tempFile.mkdirs();
            }
            if(!tempFile2.exists()) {
                tempFile2.mkdirs();
            }
            os1 = new FileOutputStream(tempFile.getPath() + File.separator + pictureName + ".jpg");

            // 开始读取
            while ((len1 = inputStream.read(bs1)) != -1) {
                os1.write(bs1, 0, len1);
            }
            os2 = new FileOutputStream(tempFile2.getPath() + File.separator + pictureName + ".jpg");

            // 开始读取
            while ((len2 = inputStream3.read(bs2)) != -1) {
                os2.write(bs2, 0, len2);
            }

        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 完毕，关闭所有链接
            try {
                os1.close();
                os2.close();
                inputStream.close();
                inputStream3.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

    }



    @RequestMapping(value = "/deleteSession", method = RequestMethod.GET)
    public void deleteSession() {
        this.userInfoService.deleteSession();
    }

    //用户编辑功能存储个人信息
    @RequestMapping(value = "/userSessionExit", method = RequestMethod.POST)
    public void userSessionExit(@RequestBody Map<String, Object> map) {
        Map<String, String> map1 = new HashMap<>();
        Gson gson = new Gson();
        String placId = map.get("autoGraph").toString();
        String orgid = map.get("orgId").toString();
        String org = map.get("org").toString();
        String parentorg = map.get("parentorg").toString();
        String name = map.get("realName").toString();
        String employee = map.get("policeNum").toString();
        ImportUser1 importUser = new ImportUser1();
        importUser.setPlaceId(Integer.parseInt(placId));
        importUser.setOrgId(Integer.parseInt(orgid));
        importUser.setOrgName(org);
        importUser.setParentOrgName(parentorg);
        importUser.setName(name);
        importUser.setEmployee(employee);
        importUser.setCollectId(Integer.parseInt(map.get("CollectId").toString()));
        this.userInfoService.importUserTemp1(importUser);
    }

    //个人上传照片编辑功能
    @RequestMapping(value = "/simpleUserPicImportEdit", method = RequestMethod.POST)
    @ResponseBody
    public String simpleUserPicImportEdit(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        //获取根路径
        String rootPath = this.userInfoService.getRootPath();
        String rootPath1 = (rootPath).replace("/", "\\");
        //获取用户信息
        ImportUser1 importUser1 = this.userInfoService.getImportUser1();
        int num = importUser1.getCollectId();
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
                MultipartFile zipFile = multiRequest.getFile(name);
                String path = rootPath1 + zipFile.getOriginalFilename();
                //对文件名进行分割再拼接
                String[] buildName = new String[2];
                //buildName = zipFile.getOriginalFilename().split("_");
                buildName[0] = String.valueOf(num);
                //图片名称重新拼接完成的结果：
                Random random = new Random();
                String pictureBuildOk = buildName[0] + "_" + random.nextInt(1000);
                //样本照片
                String path2 = rootPath1 + "SamplePhotos\\" + importUser1.getOrgId();
                //simple_photo根路径
                String path201 = "SamplePhotos\\" + importUser1.getOrgId() + "\\";
                System.out.println("样本照片路径" + path2);
                System.out.println("simple_photo根路径" + path201);
                if (zipFile != null) {
                    int id = saveSimplePicEdit(zipFile.getInputStream(), zipFile.getInputStream(), path2, pictureBuildOk, path201,importUser1);
                    Gson gson = new Gson();
                    return gson.toJson(id);
                } else {
                    Map<String, String> resultMap = new HashMap<>();
                    resultMap.put("uuid", "null");
                    Gson gson = new Gson();
                    return gson.toJson(resultMap);
                }
            }

        }

        return "";
    }

    private int saveSimplePicEdit(InputStream inputStream, InputStream inputStream2, String path2, String pictureName,
                              String path201,ImportUser1 importUser1 ) {

        OutputStream os = null;
        try {
            // 2、保存到临时文件
            // 1K的数据缓冲
            byte[] bs = new byte[1024];
            // 读取到的数据长度
            int len;
            // 输出的文件流保存到本地文件

            File tempFile = new File(path2);
            if (!tempFile.exists()) {
                tempFile.mkdirs();
            }
            os = new FileOutputStream(tempFile.getPath() + File.separator + pictureName + ".jpg");

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
        //插入样本照片
        SimplePicture simplePicture = new SimplePicture();
        simplePicture.setCollectId(importUser1.getCollectId());
        String outPath = (path201 + pictureName + ".jpg").replace("\\", "/");
        simplePicture.setRelativePath(outPath);
        this.userInfoService.addSimplePicture(simplePicture);
        CsResult csResult = new CsResult();
        csResult.setPhotoId(simplePicture.getId());
        csResult.setPhotoCollectId(simplePicture.getCollectId());
        this.userInfoService.addcsresult1(csResult);
        return simplePicture.getId();
    }

}
