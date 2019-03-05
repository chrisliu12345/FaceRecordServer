package com.gd.controller.group;

import com.gd.domain.group.GroupInfo;
import com.gd.service.group.IGroupService;
import com.gd.util.ExcelUtils;
import com.gd.util.FileLoadUtils;
import com.google.gson.Gson;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.xmlbeans.impl.piccolo.io.FileFormatException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;

/**
 * Created by 郄梦岩 on 2017/10/13.
 */
@RestController
@RequestMapping("/groups")
public class GroupController {
    String filePath = "file/导入EXCEL";
    @Autowired
    private IGroupService groupService;

    @RequestMapping(method = RequestMethod.GET)
    public String list() {
        List<GroupInfo> appList = new ArrayList<>();
        Map<String, Object> resultMap = new HashMap<>();
        appList = this.groupService.list();
        resultMap.put("code", "0000");
        resultMap.put("data", appList);
        Gson gson = new Gson();
        return gson.toJson(resultMap);
    }

    @RequestMapping(method = RequestMethod.POST)
    public void add(@RequestBody Map<String, Object> objectMap) {
        GroupInfo groupInfo = new GroupInfo();
        groupInfo.setGroupID(Integer.parseInt(objectMap.get("GroupID").toString()));
        groupInfo.setType(Integer.parseInt(objectMap.get("Type").toString()));
        groupInfo.setVirtualOrgID(objectMap.get("VirtualOrgID").toString());
        if (objectMap.get("BusinessGroupID") == null || objectMap.get("BusinessGroupID").toString().equals("")) {

        } else {
            groupInfo.setBusinessGroupID(objectMap.get("BusinessGroupID").toString());
        }
        if (objectMap.get("ParentOrgID") == null || objectMap.get("ParentOrgID").toString().equals("")) {

        } else {
            groupInfo.setParentOrgID(objectMap.get("ParentOrgID").toString());
        }
        groupInfo.setName(objectMap.get("name").toString());
        groupInfo.setParentID(Integer.parseInt(objectMap.get("ParentID").toString()));
        this.groupService.add(groupInfo);
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public void update(@RequestBody Map<String, Object> objectMap) {
        GroupInfo groupInfo = new GroupInfo();
        groupInfo.setGroupID(Integer.parseInt(objectMap.get("GroupID").toString()));
        groupInfo.setType(Integer.parseInt(objectMap.get("Type").toString()));
        groupInfo.setVirtualOrgID(objectMap.get("VirtualOrgID").toString());
        if (objectMap.get("BusinessGroupID") == null || objectMap.get("BusinessGroupID").toString().equals("") || Integer.parseInt(objectMap.get("Type").toString()) != 2) {

        } else {
            groupInfo.setBusinessGroupID(objectMap.get("BusinessGroupID").toString());
        }
        if (objectMap.get("ParentOrgID") == null || objectMap.get("ParentOrgID").toString().equals("") || Integer.parseInt(objectMap.get("Type").toString()) != 2) {

        } else {
            groupInfo.setParentOrgID(objectMap.get("ParentOrgID").toString());
        }
        groupInfo.setName(objectMap.get("name").toString());
        groupInfo.setParentID(Integer.parseInt(objectMap.get("ParentID").toString()));
        this.groupService.update(groupInfo);

    }

    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public String delete(@PathVariable("id") int id) {
        GroupInfo ee = new GroupInfo();
        ee.setGroupID(id);
        this.groupService.delete(ee);
        Map<String, Object> resultMap = new HashMap<>();

        resultMap.put("code", "0000");
        resultMap.put("data", "success");

        Gson gson = new Gson();
        return gson.toJson(resultMap);
    }

    @RequestMapping(value = "/delete_change", method = RequestMethod.POST)
    public void delete_change(@RequestBody List<Integer> kind) {

        for (int i = 0; i < kind.size(); i++) {
            GroupInfo ee = new GroupInfo();
            ee.setGroupID(kind.get(i));
            this.groupService.delete(ee);
        }
        System.out.println("删除完成");
    }

    @RequestMapping(value = "/codec_import", method = RequestMethod.POST)
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
                for (int i = 0; i < fileContentList.size(); i++) {
                    /*if (fileContentList.get(i).get("0") == null || fileContentList.get(i).get("0").equals("")) {
                        break;
                    } else {*/
                    GroupInfo groupInfo = new GroupInfo();
                    groupInfo.setGroupID(Integer.parseInt(fileContentList.get(i).get("0")));
                    groupInfo.setType(Integer.parseInt(fileContentList.get(i).get("1")));
                    groupInfo.setVirtualOrgID(fileContentList.get(i).get("2"));
                    groupInfo.setName(fileContentList.get(i).get("3"));
                    groupInfo.setParentID(Integer.parseInt(fileContentList.get(i).get("4")));
                    if (fileContentList.get(i).get("5") == null || fileContentList.get(i).get("5").equals("")) {

                    } else {
                        groupInfo.setBusinessGroupID(fileContentList.get(i).get("5"));
                    }
                    if (fileContentList.get(i).get("6") == null || fileContentList.get(i).get("6").equals("")) {

                    } else {
                        groupInfo.setParentOrgID(fileContentList.get(i).get("6"));
                    }

                    this.groupService.adds(groupInfo);

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

    //下载文件模板
    @RequestMapping(value = "/downloadFile")
    public void downloadMcode(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {

       // String s1 = com.gd.controller.group.GroupController.class.getResource("/file/").getPath();

        FileLoadUtils.fileDownLoad(response, "E:/FrConfig/ExcelFile/file/" + URLEncoder.encode("组信息批量上传模板示例.xlsx", "UTF-8"));

    }

    //数据导出
    @RequestMapping(value = "/groups_export", method = RequestMethod.GET)
    public void codecexport(HttpServletResponse res) {
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet("鼠标宏数据");
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
        encoder_name1.setCellValue("GroupID");
        HSSFCell group1 = head.createCell(1);
        group1.setCellValue("Type");
        HSSFCell encoder_address1 = head.createCell(2);
        encoder_address1.setCellValue("VirtualOrgID");
        HSSFCell encoder_port1 = head.createCell(3);
        encoder_port1.setCellValue("name");
        HSSFCell encoder_channel1 = head.createCell(4);
        encoder_channel1.setCellValue("ParentID");
        HSSFCell encoder_stream_number1 = head.createCell(5);
        encoder_stream_number1.setCellValue("BusinessGroupID");
        HSSFCell decod_channel1 = head.createCell(6);
        decod_channel1.setCellValue("ParentOrgID");

        GroupInfo ec = new GroupInfo();
        List<GroupInfo> encoders = this.groupService.list();
        for (int i = 0; i < encoders.size(); i++) {
            HSSFRow rowHeard = sheet.createRow(i + 1);
            HSSFCell encoder_name = rowHeard.createCell(0);
            encoder_name.setCellValue(encoders.get(i).getGroupID());
            HSSFCell groups = rowHeard.createCell(1);
            groups.setCellValue(encoders.get(i).getType());
            HSSFCell encoder_address = rowHeard.createCell(2);
            encoder_address.setCellValue(encoders.get(i).getVirtualOrgID());
            HSSFCell encoder_port = rowHeard.createCell(3);
            encoder_port.setCellValue(encoders.get(i).getName());
            HSSFCell encoder_channel = rowHeard.createCell(4);
            encoder_channel.setCellValue(encoders.get(i).getParentID());
            HSSFCell encoder_stream_number = rowHeard.createCell(5);
            encoder_stream_number.setCellValue(encoders.get(i).getBusinessGroupID());
            HSSFCell decod_channel = rowHeard.createCell(6);
            decod_channel.setCellValue(encoders.get(i).getParentOrgID());

        }
        File path = new File( "E:/FrConfig/ExcelFile/file/导出EXCEL");
        if (!path.exists()) {
            path.mkdir();
        }
        String path1 = "E:/FrConfig/ExcelFile/file/导出EXCEL"+ File.separator + "下载测试文档" + ".xls";

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

    @RequestMapping(value = "/typeid13", method = RequestMethod.GET)
    public String gettypeid() {
        List<Integer> list = new ArrayList<>();
        list = this.groupService.list1();
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("code", "0000");
        resultMap.put("data", list);
        Gson gson = new Gson();
        return gson.toJson(resultMap);
    }

    @RequestMapping(value = "/typeid2", method = RequestMethod.GET)
    public String gettypeid2() {
        List<Integer> list = new ArrayList<>();
        list = this.groupService.list2();
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("code", "0000");
        resultMap.put("data", list);
        Gson gson = new Gson();
        return gson.toJson(resultMap);
    }

    @RequestMapping(value = "/groupid", method = RequestMethod.GET)
    public String getgroupid() {
        List<Integer> list = new ArrayList<>();
        list = this.groupService.list1();

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("code", "0000");
        resultMap.put("data", list);
        Gson gson = new Gson();
        return gson.toJson(resultMap);
    }
}
