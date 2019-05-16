package com.gd.controller.userinfo;

import com.gd.domain.group.GroupInfo;
import com.gd.domain.org.Org;
import com.gd.domain.userinfo.CsResult;
import com.gd.domain.userinfo.ImportUser;
import com.gd.domain.userinfo.UserInfo;
import com.gd.domain.userinfo.UserInfoPicture;
import com.gd.domain.video.SimplePicture;
import com.gd.service.org.IOrgService;
import com.gd.service.orgtree.IOrgTreeService;
import com.gd.service.userinfo.IUserInfoService;
import com.gd.util.BaseModelFieldSetUtils;
import com.gd.util.ExcelUtils;
import com.gd.util.FileLoadUtils;
import com.gd.util.TextToSpeak;
import com.google.gson.Gson;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipFile;
import org.apache.xmlbeans.impl.piccolo.io.FileFormatException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;

/**
 * Created by Administrator on 2017/12/13 0013.
 */
@RestController
@RequestMapping("/userExcel")
public class UserController_Adds {
    @Autowired
    private IUserInfoService userInfoService;
    @Autowired
    private IOrgService orgService;
    @Value("${excel.path}")
    private String path1;
    @Value("${excel.path1}")
    private String filePath;
    @Value("${excel.path2}")
    private String path2;
    @Value("${zip.encoding}")
    private String encode;

    //第一步，将用户部门和考勤地点存到临时表中
    @RequestMapping(value = "/userSession", method = RequestMethod.POST)
    public void getUserSession(@RequestBody Map<String, Object> map) {
        String autoGraph = map.get("autoGraph").toString();
        String orgid = map.get("orgId").toString();
        String type = map.get("type").toString();
        ImportUser importUser = new ImportUser();
        importUser.setOrgId(Integer.parseInt(orgid));
        importUser.setPlaceId(Integer.parseInt(autoGraph));
        importUser.setType(Integer.parseInt(type));
        this.userInfoService.ImportUserTemp(importUser);
    }
    //下载文件模板
    @RequestMapping(value = "/downloadFile")
    public void downloadMcode(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {

        // String s1 = com.gd.controller.group.GroupController.class.getResource("/file/").getPath();

        FileLoadUtils.fileDownLoad(response, path2 + URLEncoder.encode("人员信息批量上传模板示例.xlsx", "UTF-8"));

    }

    //人员信息批量导入
    @RequestMapping(value = "/userImport", method = RequestMethod.POST)
    @ResponseBody
    public String usersUpload(HttpServletRequest request, HttpServletResponse res) {
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
                for (int i = 0; i < fileContentList.size(); i++) {
                    /*if (fileContentList.get(i).get("0") == null || fileContentList.get(i).get("0").equals("")) {
                        break;
                    } else {*/
                    UserInfo userInfo = new UserInfo();
                    userInfo.setId(UUID.randomUUID().toString());
                    userInfo.setParentorg(fileContentList.get(i).get("0"));
                    userInfo.setOrg(fileContentList.get(i).get("1"));
                    userInfo.setRealName(fileContentList.get(i).get("2"));
                    userInfo.setPoliceNum(fileContentList.get(i).get("3"));
                    if (fileContentList.get(i).get("3") != null) {
                        userInfo.setAutoGraph(fileContentList.get(i).get("4"));
                    }
                    userInfo.setPicture(UUID.randomUUID().toString());
                    userInfo = (UserInfo) BaseModelFieldSetUtils.FieldSet(userInfo);
                    this.userInfoService.insertUser(userInfo);
                    UserInfoPicture up = new UserInfoPicture();
                    up.setUuid(userInfo.getPicture());
                    up.setName(path1 + userInfo.getPoliceNum() + ".jpg");
                    this.userInfoService.addPicture(up);

                }

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

    //第二步，照片批量上传
    @RequestMapping(value = "/userPicImport", method = RequestMethod.POST)
    @ResponseBody
    public String uploadPicture(HttpServletRequest request, HttpServletResponse res) throws Exception {
        //随文件附带的部门和考勤地点信息
        ImportUser importUser = this.userInfoService.getImportUser();
        Org org = this.orgService.getGroupOne(String.valueOf(importUser.getOrgId()));
        String rootPath1 = this.userInfoService.getRootPath().replace("/", "\\");
        CommonsMultipartResolver muResolvers = new CommonsMultipartResolver(request.getSession().getServletContext());
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
                String path = rootPath1 + zipFile.getOriginalFilename();//zip文件
                String path2 = rootPath1 + "SamplePhotos\\" + importUser.getOrgId();//证件照
                String path3 = rootPath1 + "CertificatePhotos";
                String path201 = "SamplePhotos\\" + importUser.getOrgId() + "\\";
                String path301 = "CertificatePhotos\\";
                String path401 = "CertificatePhotosFace\\";
                File file = new File(path);
                FileUtils.copyInputStreamToFile(zipFile.getInputStream(), file);
                unZipFiles(new File(path), rootPath1, path2, path3, path201, path301, path401,importUser, org);
                file.delete();
            }

        }
        return null;
    }

    public synchronized void unZipFiles(File zipFile, String descDir, String path2, String path3, String path201, String path301,
                           String path401,ImportUser importUser, Org org) throws IOException {

        //获取该部门下的所有人员，用来判断人员是否已存在
        List<String> nameList = this.userInfoService.queryForName(importUser.getOrgId());
        //获取当前simplephoto表的collectid最大值
        Integer num = this.userInfoService.getSimplePhotoMax();
        if (num == null) {
            num = 1;
        }
        //用于存储人员姓名，判断当前人员是否已经被插入
        Set set = new HashSet();
        String picName = "";
        File pathFile = new File(descDir);
        if (!pathFile.exists()) {
            pathFile.mkdirs();
        }
        File pathFile1 = new File(path2);
        if (!pathFile1.exists()) {
            pathFile1.mkdirs();
        }
        File pathFile2 = new File(path3);
        if (!pathFile2.exists()) {
            pathFile2.mkdirs();
        }
        ZipFile zip = new ZipFile(zipFile, "GBK");

        for (Enumeration entries = zip.getEntries(); entries.hasMoreElements(); ) {
            synchronized (this) {
                ZipEntry entry = (ZipEntry) entries.nextElement();
                String zipEntryName = entry.getName();
                String unCodeString = new String(zipEntryName.getBytes("UTF-8"), "UTF-8");

                String[] temp = unCodeString.split("/");

                if (temp.length > 1) {

                    picName = temp[1];
                    String picNameAll = temp[1].substring(0, temp[1].length() - 4);
                    //stringList[0]为部门；picName为人员信息。
                    //判断人员信息中是否含有_,如果有，提取_前面的为名字，在判断是否含有-，如果有，则提取之间的为代号。
                    //将-后面的信息为员工ID
                    //人员姓名；

                    String realName;
                    //人员员工号;
                    String policNum;
                    //拼接的照片名称
                    String filePicName;
                    //判断插入的是否为已有人员
                    if (picNameAll.indexOf("_") != -1 && picNameAll.indexOf("-") != -1) {
                        //picName1[0]为名字
                        String[] picName1 = picName.split("_");
                        realName = picName1[0];
                        filePicName = "_" + picName1[1];
                        //daihaoAndEmployleeId[0]为代号,1为员工ID
                        String[] daihaoAndEmployleeId = picName1[1].split("-");
                        //员工号
                        policNum = daihaoAndEmployleeId[0];
                    } else if (picNameAll.indexOf("_") == -1 && picNameAll.indexOf("-") != -1) {
                        String[] picName1 = picName.split("-");
                        realName = picName1[0];
                        filePicName = "-" + picName1[1];
                        policNum = " ";
                    } else if (picNameAll.indexOf("_") != -1 && picNameAll.indexOf("-") == -1) {
                        String[] picName1 = picName.split("_");
                        realName = picName1[0];
                        filePicName = "_" + picName1[1];
                        policNum = picName1[1].substring(0, picName1[1].length() - 4);
                    } else {
                        realName = picName.substring(0, picName.length() - 4);
                        filePicName = ".jpg";
                        policNum = " ";
                    }
                    //判断插入的是否为已有人员

                    if (set.size() <= 0) {
                        set.add(realName);
                        num = num + 1;

                    } else {
                        if (set.contains(realName)) {

                        } else {
                            set.add(realName);
                            num = num + 1;

                        }
                    }
                    if (importUser.getType() == 0) {
                        if (nameList.contains(realName)) {
                            //人员已经进行了注册，根据人名查询该人的信息
                            UserInfo uname = new UserInfo();
                            uname.setRealName(realName);
                            UserInfo u = this.userInfoService.queryForObject1(uname);
                            SimplePicture simplePicture = new SimplePicture();
                            simplePicture.setCollectId(u.getCollectId());
                            Random random = new Random();
                            String picturePath01 = path201 + (u.getCollectId() + "-" + random.nextInt(1000) + filePicName);
                            String picturePath022 = (picturePath01).replace("\\", "/");
                            simplePicture.setRelativePath(picturePath022);
                            this.userInfoService.addSimplePicture(simplePicture);
                            CsResult csResult = new CsResult();
                            csResult.setPhotoId(simplePicture.getId());
                            csResult.setPhotoCollectId(simplePicture.getCollectId());
                            this.userInfoService.addcsresult1(csResult);
                            InputStream in = zip.getInputStream(entry);
                            String outPath = (path2 + "/" + picName).replaceAll("\\*", "/");
                            //判断文件全路径是否为文件夹,如果是上面已经上传,不需要解压
                            if (new File(outPath).isDirectory()) {
                                continue;
                            }
                            OutputStream out = new FileOutputStream(path2 + "/" + File.separator + (u.getCollectId() + "-" + random.nextInt(1000) + filePicName));
                            byte[] buf1 = new byte[1024];
                            int len;
                            while ((len = in.read(buf1)) > 0) {
                                out.write(buf1, 0, len);
                            }
                            in.close();
                            out.close();
                        } else if (!nameList.contains(realName)) {
                            //人员还没有进行注册
                            nameList.add(realName);
                            //准备添加用户信息
                            UserInfo userInfo = new UserInfo();
                            System.out.println("我是图片名称" + realName);
                            userInfo.setRealName(realName);
                            userInfo.setOrg(org.getOrgName());
                            userInfo.setPoliceNum(policNum);
                            userInfo.setCollectId(num);
                            String uuid = UUID.randomUUID().toString();
                            userInfo.setPicture(uuid);
                            userInfo.setParentorg(org.getParentName());
                            userInfo.setOrgId(String.valueOf(importUser.getOrgId()));
                            userInfo.setAutoGraph(String.valueOf(importUser.getPlaceId()));
                            //为证件照复制照片，准备添加用户照片信息
                            String picturePath = path301 + (num + filePicName);
                            String picturePath2 = (picturePath).replace("\\", "/");
                            String picturePath3 = (path401 + (num + filePicName)).replace("\\", "/");
                            setUserData(userInfo, picturePath2, picturePath3);
                            String outUserPicuture = (path3 + "/" + picName).replaceAll("\\*", "/");
                            //生成语音MP3
                            // TextToSpeak textToSpeak=new TextToSpeak();
                            //textToSpeak.textSpeak(realName,descDir+"VoicePlayback\\"+importUser.getOrgId() + "\\"+realName+".mp3");
                            InputStream in1 = zip.getInputStream(entry);
                            //OutputStream out1 = new FileOutputStream(outUserPicuture);
                            OutputStream out1 = new FileOutputStream(path3 + "/" + File.separator + (num + filePicName));

                            byte[] buf2 = new byte[1024];
                            int len2;
                            while ((len2 = in1.read(buf2)) > 0) {
                                out1.write(buf2, 0, len2);
                            }
                            in1.close();
                            out1.close();

                            SimplePicture simplePicture = new SimplePicture();
                            simplePicture.setCollectId(num);
                            String picturePath01 = path201 + (num + filePicName);
                            String picturePath022 = (picturePath01).replace("\\", "/");
                            simplePicture.setRelativePath(picturePath022);
                            this.userInfoService.addSimplePicture(simplePicture);
                            CsResult csResult = new CsResult();
                            csResult.setPhotoId(simplePicture.getId());
                            csResult.setPhotoCollectId(simplePicture.getCollectId());
                            this.userInfoService.addcsresult1(csResult);
                            InputStream in = zip.getInputStream(entry);
                            String outPath = (path2 + "/" + picName).replaceAll("\\*", "/");
                            //判断文件全路径是否为文件夹,如果是上面已经上传,不需要解压
                            if (new File(outPath).isDirectory()) {
                                continue;
                            }
                            OutputStream out = new FileOutputStream(path2 + "/" + File.separator + (num + filePicName));
                            byte[] buf1 = new byte[1024];
                            int len;
                            while ((len = in.read(buf1)) > 0) {
                                out.write(buf1, 0, len);
                            }
                            in.close();
                            out.close();
                        }
                    } else if (importUser.getType() == 1) {
                        InputStream in = zip.getInputStream(entry);
                        String outPath = (path2 + "/" + picNameAll + ".jpg").replaceAll("\\*", "/");
                        //判断文件全路径是否为文件夹,如果是上面已经上传,不需要解压
                        String picName1 = org.getId() + "/" + picNameAll + ".jpg";
                        System.out.println("部门+图片名称:" + picName1);
                        SimplePicture simpoid = this.userInfoService.queryForSimplePhotosByurlName(picName1);
                        //更新这张图片的BeIsRegistered值为空
                        this.userInfoService.updateBeIsRegisteredForSimplePhoto(simpoid);
                        CsResult csResult = new CsResult();
                        csResult.setPhotoId(simpoid.getId());
                        csResult.setPhotoCollectId(simpoid.getCollectId());
                        this.userInfoService.addcsresult1(csResult);
                        OutputStream out = new FileOutputStream(outPath);
                        byte[] buf1 = new byte[1024];
                        int len;
                        while ((len = in.read(buf1)) > 0) {
                            out.write(buf1, 0, len);
                        }
                        in.close();
                        out.close();
                        //拼接字符串（部门+图片名称）

                    }
                }

            }
        }
        zip.close();
        System.out.println("******************解压完毕********************");
        //删除临时数据
        this.userInfoService.deleteImportUser();

    }



    //插入人员信息和头像、样本照片数据数据
    private void setUserData(UserInfo userInfo, String picPath, String picPath1) {

        userInfo = (UserInfo) BaseModelFieldSetUtils.FieldSet(userInfo);
        this.userInfoService.insertUser(userInfo);
        UserInfoPicture userInfoPicture = new UserInfoPicture();
        userInfoPicture.setName(picPath);
        userInfoPicture.setName2(picPath1);
        userInfoPicture.setUuid(userInfo.getPicture());
        this.userInfoService.addPicture(userInfoPicture);

    }


}
