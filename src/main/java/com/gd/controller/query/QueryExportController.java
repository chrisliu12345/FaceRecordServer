package com.gd.controller.query;

import com.gd.domain.group.GroupInfo;
import com.gd.domain.query.Record;
import com.gd.service.query.IQueryService;
import com.sun.scenario.effect.impl.sw.sse.SSEBlend_SRC_OUTPeer;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.method.P;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/12/25 0025.
 */
@RestController
@RequestMapping("/queryExport")
public class QueryExportController {
    @Value("${excel.path2}")
    private String path2;
    @Autowired
    private IQueryService iQueryService;
   // String path2="E:\\FrConfig\\zhy_webclient\\excelFile/file\\";
    //综合查询批量导出（此方法已暂停使用）
    @RequestMapping(value = "/queryAll_export", method = RequestMethod.GET)
    public void codecexport1(HttpServletResponse res, HttpSession session) {
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet("综合查询");
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
        group1.setCellValue("员工号");
        HSSFCell encoder_address1 = head.createCell(2);
        encoder_address1.setCellValue("所属部门");
        HSSFCell encoder_port1 = head.createCell(3);
        encoder_port1.setCellValue("上班时间");
        HSSFCell encoder_channel1 = head.createCell(4);
        encoder_channel1.setCellValue("下班时间");
        HSSFCell encoder_stream_number1 = head.createCell(5);
        encoder_stream_number1.setCellValue("违规标记");
        List<Record> recordList=(List<Record>)session.getAttribute("result1");
        System.out.println("我是测试导出的数据"+recordList.get(0).getRealName());
        for (int i = 0; i < recordList.size(); i++) {
            HSSFRow rowHeard = sheet.createRow(i + 1);
            HSSFCell encoder_name = rowHeard.createCell(0);
            encoder_name.setCellValue(recordList.get(i).getRealName());
            HSSFCell groups = rowHeard.createCell(1);
            groups.setCellValue(recordList.get(i).getEmployeeId());
            HSSFCell encoder_address = rowHeard.createCell(2);
            encoder_address.setCellValue(recordList.get(i).getParentorg()+"-"+recordList.get(i).getOrg());
            HSSFCell encoder_port = rowHeard.createCell(3);
            encoder_port.setCellValue(recordList.get(i).getClockIn());
            HSSFCell encoder_channel = rowHeard.createCell(4);
            encoder_channel.setCellValue(recordList.get(i).getClockOff());
            HSSFCell encoder_stream_number = rowHeard.createCell(5);
            encoder_stream_number.setCellValue(recordList.get(i).getAttendanceFlag());

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
    //查询与统计的批量导出
    @RequestMapping(value = "/attend_export", method = RequestMethod.POST)
    public void codecexport2(@RequestBody Map<String,String> map, HttpServletResponse res, HttpSession session) {
        Record record=new Record();
        String id=map.get("num");
        record.setCreateTime1(java.sql.Date.valueOf(map.get("Start")));
        record.setCreateTime2(java.sql.Date.valueOf(map.get("End")));

        if(map.get("orgId")!=null){
            String orgId=map.get("orgId");
            record.setOrg(orgId);
        }
        if(map.get("PoliceNum")!=null) {
            String PoliceNum = map.get("PoliceNum");
            record.setEmployeeId(PoliceNum);
        }
        if(map.get("realName")!=null){
            record.setRealName(map.get("realName"));
        }
        if(map.get("NoClass")!=null) {
            String NoClass = map.get("NoClass");
            record.setAttendanceFlag(NoClass);
        }
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet("综合查询");
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
        group1.setCellValue("员工号");
        HSSFCell encoder_address1 = head.createCell(2);
        encoder_address1.setCellValue("所属部门");
        HSSFCell encoder_port1 = head.createCell(3);
        encoder_port1.setCellValue("上班时间");
        HSSFCell encoder_channel1 = head.createCell(4);
        encoder_channel1.setCellValue("下班时间");
        HSSFCell encoder_stream_number1 = head.createCell(5);
        encoder_stream_number1.setCellValue("违规标记");
       // List<Record> recordList =new ArrayList<>();
        if(id.equals("1")) {
            List<Record> recordList = (List<Record>) session.getAttribute("result1");

            for (int i = 0; i < recordList.size(); i++) {
                HSSFRow rowHeard = sheet.createRow(i + 1);
                HSSFCell encoder_name = rowHeard.createCell(0);
                encoder_name.setCellValue(recordList.get(i).getRealName());
                HSSFCell groups = rowHeard.createCell(1);
                groups.setCellValue(recordList.get(i).getEmployeeId());
                HSSFCell encoder_address = rowHeard.createCell(2);
                encoder_address.setCellValue(recordList.get(i).getParentorg()+"-"+recordList.get(i).getOrg());
                HSSFCell encoder_port = rowHeard.createCell(3);
                if(recordList.get(i).getClockIn()==null){
                    encoder_port.setCellValue("");
                }else{
                    encoder_port.setCellValue(recordList.get(i).getClockIn().toString());
                }

                HSSFCell encoder_channel = rowHeard.createCell(4);
                if(recordList.get(i).getClockOff()==null){
                    encoder_channel.setCellValue("");
                }else{
                    encoder_channel.setCellValue(recordList.get(i).getClockOff().toString());
                }
                HSSFCell encoder_stream_number = rowHeard.createCell(5);
                if(recordList.get(i).getAttendanceFlag()==null){
                    encoder_stream_number.setCellValue("");
                }else{
                    encoder_stream_number.setCellValue(recordList.get(i).getAttendanceFlag());
                }


            }
        }else if(id.equals("2")){
           // List<Record> recordList = (List<Record>) session.getAttribute("result2");
                List<Record> recordList=this.iQueryService.getRecordsToMap(record);
            for (int i = 0; i < recordList.size(); i++) {
                HSSFRow rowHeard = sheet.createRow(i + 1);
                HSSFCell encoder_name = rowHeard.createCell(0);
                encoder_name.setCellValue(recordList.get(i).getRealName());
                HSSFCell groups = rowHeard.createCell(1);
                groups.setCellValue(recordList.get(i).getEmployeeId());
                HSSFCell encoder_address = rowHeard.createCell(2);
                encoder_address.setCellValue(recordList.get(i).getParentorg()+"-"+recordList.get(i).getOrg());
                HSSFCell encoder_port = rowHeard.createCell(3);
                if(recordList.get(i).getClockIn()==null){
                    encoder_port.setCellValue("");
                }else{
                    encoder_port.setCellValue(recordList.get(i).getClockIn().toString());
                }

                HSSFCell encoder_channel = rowHeard.createCell(4);
                if(recordList.get(i).getClockOff()==null){
                    encoder_channel.setCellValue("");
                }else{
                    encoder_channel.setCellValue(recordList.get(i).getClockOff().toString());
                }
                HSSFCell encoder_stream_number = rowHeard.createCell(5);
                if(recordList.get(i).getAttendanceFlag()==null){
                    encoder_stream_number.setCellValue("");
                }else{
                    encoder_stream_number.setCellValue(recordList.get(i).getAttendanceFlag());
                }

            }
        }else {
           //  = (List<Record>) session.getAttribute("result3");
            List<Record> recordList=this.iQueryService.getRecordsToMap(record);
            for (int i = 0; i < recordList.size(); i++) {
                HSSFRow rowHeard = sheet.createRow(i + 1);
                HSSFCell encoder_name = rowHeard.createCell(0);
                encoder_name.setCellValue(recordList.get(i).getRealName());
                HSSFCell groups = rowHeard.createCell(1);
                groups.setCellValue(recordList.get(i).getEmployeeId());
                HSSFCell encoder_address = rowHeard.createCell(2);
                encoder_address.setCellValue(recordList.get(i).getParentorg()+"-"+recordList.get(i).getOrg());
                HSSFCell encoder_port = rowHeard.createCell(3);
                if(recordList.get(i).getClockIn()==null){
                    encoder_port.setCellValue("");
                }else{
                    encoder_port.setCellValue(recordList.get(i).getClockIn().toString());
                }

                HSSFCell encoder_channel = rowHeard.createCell(4);
                if(recordList.get(i).getClockOff()==null){
                    encoder_channel.setCellValue("");
                }else{
                    encoder_channel.setCellValue(recordList.get(i).getClockOff().toString());
                }
                HSSFCell encoder_stream_number = rowHeard.createCell(5);
                if(recordList.get(i).getAttendanceFlag()==null){
                    encoder_stream_number.setCellValue("");
                }else{
                    encoder_stream_number.setCellValue(recordList.get(i).getAttendanceFlag());
                }

            }

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
}

