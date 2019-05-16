package com.gd.config;

import com.gd.jwt.JwtAuthenticationEntryPoint;
import com.gd.jwt.JwtAuthenticationTokenFilter;
import com.gd.security.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;

import org.springframework.http.HttpMethod;
import org.springframework.security.access.AccessDecisionManager;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.authentication.dao.ReflectionSaltSource;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.security.config.annotation.ObjectPostProcessor;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;

import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.access.expression.DefaultWebSecurityExpressionHandler;

import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.springframework.security.web.access.intercept.FilterSecurityInterceptor;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;


/**
 * Created by dell on 2017/1/11.
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
@Configuration
@SuppressWarnings("all")
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {


    @Autowired
    private JwtAuthenticationEntryPoint unauthorizedHandler;

    @Autowired
    private SecurityUserService securityUserService;

    @Autowired
    MyFilterSecurityInterceptor myFilterSecurityInterceptor;

//    @Autowired
//    private MySecurityMetadataSource mySecurityMetadataSource;

    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        //auth.userDetailsService(securityUserService);

        auth.authenticationProvider(authenticationProvider());
    }


    protected void configure(HttpSecurity http) throws Exception {
//                    http.addFilterBefore(myFilterSecurityInterceptor, FilterSecurityInterceptor.class);
//        http.authorizeRequests().anyRequest().authenticated().withObjectPostProcessor(new ObjectPostProcessor<FilterSecurityInterceptor>() {
//            public <O extends FilterSecurityInterceptor> O postProcess(O fsi) {
//                fsi.setSecurityMetadataSource(securityMetadataSource());
//                fsi.setAccessDecisionManager(accessDecisionManager());
//                fsi.setAuthenticationManager(authenticationManagerBean());
//                return fsi;
//            }
//        });
        http.addFilterBefore(myFilterSecurityInterceptor, FilterSecurityInterceptor.class);
        http
                // 由于使用的是JWT，我们这里不需要csrf
                .csrf().disable()

                .exceptionHandling().authenticationEntryPoint(unauthorizedHandler).and()

                // 基于token，所以不需要session
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS).and()

                .authorizeRequests()
                //.antMatchers(HttpMethod.OPTIONS, "/**").permitAll()

                // 允许对于网站静态资源的无授权访问
                .antMatchers(
                        HttpMethod.GET,
                        "/",
                        "/*.html",
                        "/favicon.ico",
                        "/**/*.html",
                        "/**/*.css",
                        "/**/*.js",
                        "/api/hello/hello",
                        "/userExcel/downloadFile",
                        "/config/downloadFile",
                        "/common/**",
                         "/user/CsResult/*/*",
                        "/query/url",
                        "/config/exportCameraLocation"
                ).permitAll()
                .antMatchers(
                        HttpMethod.POST,
                        "/",
                        "/websocket",
                        "/userExcel/userImport",
                        "/userAdd/simpleUserPicImport",
                        "userExcel/userPicImport"

                ).permitAll()
                // 对于获取token的rest api要允许匿名访问
                .antMatchers("/auth/**","/websocket").permitAll()
                // 除上面外的所有请求全部需要鉴权认证
                .anyRequest().authenticated();

        // 添加JWT filter
        http
                .addFilterBefore(authenticationTokenFilterBean(), UsernamePasswordAuthenticationFilter.class);

        // 禁用缓存
        http.headers().cacheControl();
    }

    @Bean
    public JwtAuthenticationTokenFilter authenticationTokenFilterBean() throws Exception {
        return new JwtAuthenticationTokenFilter();
    }

//    @Bean(name = "securityMetadataSource")
//    FilterInvocationSecurityMetadataSource securityMetadataSource() {
//        return new MySecurityMetadataSource();
//    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers("/swagger-ui.html", "/swagger/**", "/v2/api-docs", "/webjars/**"
                , "/swagger-resources/**", "/images/**", "/configuration/**");
    }

    @Bean(name = "authenticationManager")
    @Override
    public AuthenticationManager authenticationManagerBean() {
        AuthenticationManager authenticationManager = null;
        try {
            authenticationManager = super.authenticationManagerBean();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return authenticationManager;
    }

//    @Bean(name = "accessDecisionManager")
//    public AccessDecisionManager accessDecisionManager() {
//
//        return new MyAccessDecisionManager();
//    }

    @Bean(name = "expressionHandler")
    public DefaultWebSecurityExpressionHandler webSecurityExpressionHandler() {
        DefaultWebSecurityExpressionHandler webSecurityExpressionHandler = new DefaultWebSecurityExpressionHandler();
        return webSecurityExpressionHandler;
    }

    @Bean
    public CustomBasicAuthenticationEntryPoint getBasicAuthentryPoint() {
        return new CustomBasicAuthenticationEntryPoint();
    }

    @Bean(name = "saltSource")
    public ReflectionSaltSource saltSource() {
        ReflectionSaltSource saltSource = new ReflectionSaltSource();
        saltSource.setUserPropertyToUse("salt");
        return saltSource;
    }

    @Bean(name = "authenticationProvider")
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();
        authenticationProvider.setPasswordEncoder(passwordEncoder());
        authenticationProvider.setUserDetailsService(securityUserService);
        authenticationProvider.setSaltSource(saltSource());
        return authenticationProvider;
    }


    @Bean
    public Md5PasswordEncoder passwordEncoder() {
        return new Md5PasswordEncoder();
    }


}
