package com.gd;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Base64;

/**
 * Created by dell on 2017/1/14.
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
//测试类，无用
public class MaClient {
    public static void main(String[] args) throws IOException {
        String username = "admin";
        String password = "111111";
        byte[] token = (username + ":" + password).getBytes("utf-8");
        String authorization = "Basic " + new String(Base64.getEncoder().encode(token), "utf-8");
        URL url = new URL("http://localhost:9090/ma/login");
        //URL url = new URL("http://www.baidu.com");
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setDoOutput(true);
        connection.setRequestProperty("Authorization", authorization);

        if (connection.getResponseCode() == 200) {
            InputStream inputStream = connection.getInputStream();
            String result = org.apache.commons.io.IOUtils.toString(inputStream, "utf-8");
            System.out.println(result);

        }
    }
}
