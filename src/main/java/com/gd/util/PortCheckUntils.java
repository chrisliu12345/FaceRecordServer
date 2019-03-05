package com.gd.util;

/**
 * 这是一个扫描本机端口是否被占用的工具
 */

import java.io.IOException;
import java.net.Socket;

public class PortCheckUntils extends Thread{
    private int[] p;
    Socket ss = null;

    public PortCheckUntils(int[] p) {
        this.p = p;
    }

    public static void main(String[] args) {
        for(int i=0;i<5000;i=i+100){
            new PortCheckUntils(new int[]{
                    i+1,i+100
            }).start();
        }
    }
    @Override
    public void run() {
        System.err.println("启动线程");
        for(int i=p[0]; i<p[1];i++){
            try {
//                System.out.println(i);
                ss = new Socket("127.0.0.1",i);
                // 如果不能用Socket建立通信的话，说明端口已占用，然后把端口打印出来即可。
                System.err.println("扫描到端口： " + i);

            } catch (IOException e) {

            }
        }
    }


}