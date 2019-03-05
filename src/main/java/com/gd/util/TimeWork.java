package com.gd.util;

import com.gd.dao.config.IConfigDao;
import com.gd.dao.query.IQueryDao;
import com.gd.service.query.IQueryService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.File;
import java.util.Calendar;

@Component
public class TimeWork {
    private static final Logger logger = Logger.getLogger(TimeWork.class);

    @Autowired
    private IQueryDao queryDao;
    @Autowired
    private IConfigDao configDao;
     //定时清除数据库和本地图片（考勤系统）
    @Scheduled(cron = "0 0 23 20 12 *")
    public void queryPayStatus() {
        logger.info("执行定时任务queryPayStatus---start");
        TimeWork();
        logger.info("执行定时任务queryPayStatus---end");
    }

    //定时任务，清除存储的图片和数据
    public void TimeWork() {
        //清除数据库数据
        Calendar a = Calendar.getInstance();
       this.configDao.cleanAttendanceData((a.get(Calendar.YEAR))+"-10-15");
        //清除识别之后存储的照片
        String path = this.queryDao.getPictSaveRootDirectoryNew() + "RecognizeResultImage".replace("/", File.separator);
        clearFiles(path, String.valueOf(a.get(Calendar.YEAR)));
    }

    //删除文件和目录
    private void clearFiles(String workspaceRootPath, String year) {
        File file = new File(workspaceRootPath);
        if (file.exists()) {
            File[] files = file.listFiles();
            for (int i = 0; i < files.length; i++) {
                if (files[i].getName().contains(year)) {
                    File filer = new File(workspaceRootPath + File.separator + files[i].getName());
                    deleteFile(filer);
                }
            }
        }
    }

    private void deleteFile(File file) {
        if (file.isDirectory()) {
            File[] files = file.listFiles();
            for (int i = 0; i < files.length; i++) {
                deleteFile(files[i]);

            }
        }
        file.delete();
    }

    @Scheduled(cron = "0 0 1 * * ?")
    public void cleanMettingWork() {
        logger.info("执行定时任务queryPayStatus---start");
        cleanMetting();
        logger.info("执行定时任务queryPayStatus---end");
    }
    public void cleanMetting(){
        this.configDao.cleanMettingSignAndTime();
    }
}
