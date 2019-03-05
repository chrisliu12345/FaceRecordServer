package com.gd;


import com.gd.controller.query.websocket.ApplicationHelper;
import com.gd.filters.CORSFilter;
import com.gd.service.query.impl.QueryServiceImpl;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Import;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import javax.servlet.Filter;
import javax.servlet.MultipartConfigElement;


@SpringBootApplication
@MapperScan("com.gd.dao")
@ComponentScan
@EnableAutoConfiguration
@EnableScheduling
@Import(value={ApplicationHelper.class})
public class MaApplication {
    public static void main(String[] args) {
        SpringApplication.run(MaApplication.class, args);
    }
    @Bean
    public ApplicationHelper applicationHelper(){
        return new ApplicationHelper();
    }

}
