package com.gd.controller.common;


import com.gd.domain.query.Record;
import com.gd.service.config.IConfigService;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.crypto.*;
import javax.crypto.spec.SecretKeySpec;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 郄梦岩 on 2017/11/7.
 */
@RestController
@RequestMapping("/common")
public class CommonController {
    @Autowired
    private IConfigService iConfigService;
    //AES加密算法
    public static byte[] encrypt(String content, String password) {
        try {
            KeyGenerator kgen = KeyGenerator.getInstance("AES");
            kgen.init(128, new SecureRandom(password.getBytes()));
            SecretKey secretKey = kgen.generateKey();
            byte[] enCodeFormat = secretKey.getEncoded();
            SecretKeySpec key = new SecretKeySpec(enCodeFormat, "AES");
            Cipher cipher = Cipher.getInstance("AES");// 创建密码器
            byte[] byteContent = content.getBytes("utf-8");
            cipher.init(Cipher.ENCRYPT_MODE, key);// 初始化
            byte[] result = cipher.doFinal(byteContent);
            return result; // 加密
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (NoSuchPaddingException e) {
            e.printStackTrace();
        } catch (InvalidKeyException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IllegalBlockSizeException e) {
            e.printStackTrace();
        } catch (BadPaddingException e) {
            e.printStackTrace();
        }
        return null;
    }
    //AES解密算法
    public static byte[] decrypt(byte[] content, String password) {
        try {
            KeyGenerator kgen = KeyGenerator.getInstance("AES");
            kgen.init(128, new SecureRandom(password.getBytes()));
            SecretKey secretKey = kgen.generateKey();
            byte[] enCodeFormat = secretKey.getEncoded();
            SecretKeySpec key = new SecretKeySpec(enCodeFormat, "AES");
            Cipher cipher = Cipher.getInstance("AES");// 创建密码器
            cipher.init(Cipher.DECRYPT_MODE, key);// 初始化
            byte[] result = cipher.doFinal(content);
            return result; // 加密
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (NoSuchPaddingException e) {
            e.printStackTrace();
        } catch (InvalidKeyException e) {
            e.printStackTrace();
        } catch (IllegalBlockSizeException e) {
            e.printStackTrace();
        } catch (BadPaddingException e) {
            e.printStackTrace();
        }
        return null;
    }
    //异或运算方法
    public Integer Xor(List<Integer> mm){
        int s=0;

        for(int i=0;i<mm.size();i++){
            s^=mm.get(i);

        }
        return  s;
    }
    //主动接收人脸采集完成后的参数
    @RequestMapping(value = "/ClcikNext",method = RequestMethod.POST)
    public String next(@RequestBody String i){
        System.out.println("ClcikNext:"+i);
        return "我已经接收到了。Thank You";
    }

    //删除人员考勤错误信息
    @RequestMapping(value="/delete/{id}",method = RequestMethod.GET)
    public List<String> deleteUserTemp(@PathVariable("id") String CollectId){
        //查询所有关于此工号的记录
        List<Record> recordList=this.iConfigService.queryForRecordById(CollectId);
        List<String> result=new ArrayList<>();
        for(int i=0;i<recordList.size();i++){
            Date createTime=recordList.get(i).getCreateTime();
            String  temp=String.valueOf(createTime);
            String Clockon=temp+" "+"08:20:25";
            String Clockoff=temp+" "+"18:05:30";
            Timestamp con=Timestamp.valueOf(Clockon);
            Timestamp coff=Timestamp.valueOf(Clockoff);
            Record record=new Record();
            record.setClockIn(con);
            record.setClockOff(coff);
            record.setCollectId(Integer.parseInt(CollectId));
            this.iConfigService.deleteUserTemp(record);
            result.add("已更新"+createTime+"的记录");
        }
    return result;
    }


}
