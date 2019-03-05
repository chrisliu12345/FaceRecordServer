package com.gd.controller.query.websocket;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

public class ApplicationHelper implements ApplicationContextAware {
    private static ApplicationContext applicationContext=null;

    public static ApplicationContext getApplicationContext() {
        return applicationContext;
    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {

       if(ApplicationHelper.applicationContext==null){ ApplicationHelper.applicationContext=applicationContext;}

    }

    public static Object getBean(String beanName){
        System.out.println(applicationContext);
        return applicationContext.getBean(beanName);
    }
    public static <T> T getBean(Class<T> clazz){
        return getApplicationContext().getBean(clazz);
    }
    public static <T> T getBean(String name,Class<T> clazz){
        return getApplicationContext().getBean(name, clazz);
    }
}
