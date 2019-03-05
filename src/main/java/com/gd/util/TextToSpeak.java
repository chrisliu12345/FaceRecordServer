package com.gd.util;

import com.baidu.aip.speech.AipSpeech;
import com.baidu.aip.speech.TtsResponse;
import com.baidu.aip.util.Util;
import org.jaudiotagger.audio.exceptions.InvalidAudioFrameException;
import org.jaudiotagger.audio.exceptions.ReadOnlyFileException;
import org.jaudiotagger.audio.mp3.MP3AudioHeader;
import org.jaudiotagger.audio.mp3.MP3File;
import org.jaudiotagger.tag.TagException;
import org.json.JSONObject;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;

public class TextToSpeak {
    //设置APPID/AK/SK
    public static final String APP_ID = "14643333";
    public static final String API_KEY = "GMPtc3Rb5MoCGlfG7zrF4CEM";
    public static final String SECRET_KEY = "KWW7KVMUf1U8Ek4tGHyBBngOjKMYpVtR";
    public static MP3File mp3File;
    public  void textSpeak(String name,String path,String tmp) {
        // 初始化一个AipSpeech
        AipSpeech client = new AipSpeech(APP_ID, API_KEY, SECRET_KEY);

        // 可选：设置网络连接参数
        client.setConnectionTimeoutInMillis(30000);
        client.setSocketTimeoutInMillis(60000);

        // 可选：设置代理服务器地址, http和socket二选一，或者均不设置
       // client.setHttpProxy("proxy_host", proxy_port);  // 设置http代理
        //client.setSocketProxy("proxy_host", proxy_port);  // 设置socket代理

        // 可选：设置log4j日志输出格式，若不设置，则使用默认配置
        // 也可以直接通过jvm启动参数设置此环境变量
        //System.setProperty("aip.log4j.conf", "path/to/your/log4j.properties");
        HashMap<String, Object> options = new HashMap<String, Object>();
        options.put("spd", "4");
        options.put("pit", "5");
        options.put("per", "0");
        // 调用接口
        //TtsResponse res = client.synthesis("刘颖", "zh", 1, options);
        TtsResponse res = client.synthesis(name, "zh", 1, options);
        byte[] data = res.getData();
        JSONObject res1 = res.getResult();
        if (data != null) {
            try {
                //先把文件放到临时路径里
                Util.writeBytesToFileSystem(data, tmp);
                //转换格式，并将转换后的文件放入目标地址
                AnyAudioToMp3.WavToMp3Test(path,tmp);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        if (res1 != null) {
            System.out.println(res1.toString(2));
        }




    }
}
