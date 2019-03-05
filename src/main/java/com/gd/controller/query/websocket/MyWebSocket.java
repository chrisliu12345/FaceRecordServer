package com.gd.controller.query.websocket;

import com.gd.controller.query.QueryController;
import com.gd.domain.query.DetectImagesTemp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CopyOnWriteArraySet;

/**
 * Created by Administrator on 2018/3/7 0007.
 */
@ServerEndpoint(value = "/websocket")
@Component
public class MyWebSocket {
    //静态变量，用来记录当前在线连接数。应该把它设计成线程安全的。
    private static int onlineCount = 0;

    //concurrent包的线程安全Set，用来存放每个客户端对应的MyWebSocket对象。
    private static CopyOnWriteArraySet<MyWebSocket> webSocketSet = new CopyOnWriteArraySet<MyWebSocket>();

    //与某个客户端的连接会话，需要通过它来给客户端发送数据
    private Session session;

    private boolean stopMe = true;
    /**
     * 连接建立成功调用的方法
     */
    @OnOpen
    public void onOpen(Session session) {
        this.session = session;
        webSocketSet.add(this);     //加入set中
        addOnlineCount();           //在线数加1
        System.out.println("有新连接加入！当前在线人数为" + getOnlineCount());
        try {
            //初始化加入全部数据
            QueryData queryList=new QueryData();
            String resultList=queryList.getListPeople();
            sendMessage(resultList);
            onMessage("start",session);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 连接关闭调用的方法
     */
    @OnClose
    public void onClose() {
        stopMe=false;
        webSocketSet.remove(this);  //从set中删除
        subOnlineCount();           //在线数减1
        System.out.println("有一连接关闭！当前在线人数为" + getOnlineCount());
    }

    /**
     * 收到客户端消息后调用的方法
     *
     * @param message 客户端发送过来的消息
     */
    @OnMessage
    public void onMessage(String message, Session session) {
        System.out.println("来自客户端的消息:" + message);
        QueryData queryData1=new QueryData();
        Integer maxID=queryData1.getMaxid();
        try {

            //定时执行此方法
            // 单位: 毫秒
            final long timeInterval = 1000;
            Runnable runnable = new Runnable() {
                public void run() {
                    while (stopMe) {
                        try {
                            QueryData queryData=new QueryData();
                            String list=queryData.getNewPeople(maxID);
                            if(list.equals("exist")){
                               System.out.println("无人签到");

                            }else {
                                System.out.println("有新的人员进行了签到！");
                                for (MyWebSocket item : webSocketSet) {
                                    item.sendMessage(list);

                                }

                            }
                            Thread.sleep(timeInterval);
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                }
            };

            Thread thread = new Thread(runnable);
            thread.start();
        }catch(Exception e){
            e.printStackTrace();
        }
        //群发消息

    }

    /*发生错误时调用*/
    @OnError
    public void onError(Session session, Throwable error) {
        System.out.println("发生错误");
        error.printStackTrace();
    }


    public void sendMessage(String message) throws IOException {
      //返回给客户端的数据

        this.session.getBasicRemote().sendText(message);

    }


    /**
     * 群发自定义消息
     */
    public static void sendInfo(String message) {
        for (MyWebSocket item : webSocketSet) {
            try {
                item.sendMessage(message);
            } catch (IOException e) {
                continue;
            }
        }
    }

    public static synchronized int getOnlineCount() {
        return onlineCount;
    }

    public static synchronized void addOnlineCount() {
        MyWebSocket.onlineCount++;
    }

    public static synchronized void subOnlineCount() {
        MyWebSocket.onlineCount--;
    }
}