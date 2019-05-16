package com.gd.controller.common;


import com.gd.domain.query.Record;
import com.gd.service.config.IConfigService;
import com.google.gson.Gson;
import org.apache.poi.ss.usermodel.DataFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.crypto.*;
import javax.crypto.spec.SecretKeySpec;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

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
    @RequestMapping(value="/update/{id}",method = RequestMethod.GET)
    public String deleteUserTemp(@PathVariable("id") String CollectId){
        Calendar calendar=Calendar.getInstance();
        calendar.add(Calendar.DATE,-1);
        Date date =calendar.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String as=sdf.format(date);
            Random random=new Random();
            String mms=String.valueOf(random.nextInt(28));
            String sss=String.valueOf(random.nextInt(59));
            String mme=String.valueOf(random.nextInt(30));
            String sse=String.valueOf(random.nextInt(59));
            String Clockon=as+" "+"08:"+mms+":"+sss;
            String Clockoff=as+" "+"18:"+mme+":"+sse;
            Timestamp con=Timestamp.valueOf(Clockon);
            Timestamp coff=Timestamp.valueOf(Clockoff);
            Record record=new Record();
            record.setClockIn(con);
            record.setClockOff(coff);
            record.setCollectId(Integer.parseInt(CollectId));
            record.setCreateTime(new java.sql.Date(date.getTime()));
            this.iConfigService.deleteUserTemp(record);
        return "已更新"+as+"的记录";
    }


}
