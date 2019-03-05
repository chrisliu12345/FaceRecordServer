package com.gd.controller;

import com.gd.domain.account.Account;
import com.gd.domain.userinfo.UserInfo;
import com.gd.domain.userinfo.UserInfoPicture;
import com.gd.jwt.JwtUser;
import com.gd.service.account.IAccountService;
import com.gd.service.userinfo.IUserInfoService;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;

import javax.imageio.stream.FileImageInputStream;
import javax.imageio.stream.FileImageOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.*;

/**
 * Created by dell on 2017/1/13.
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

@Controller
@RestController
public class IndexController {
    @Autowired
    private IAccountService accountService;
    @Autowired
    private IUserInfoService userInfoService;

    @GetMapping("/login")
//    @RequestMapping("/login")
    //@CrossOrigin(origins = "*", maxAge = 36000)
    public Object index(@AuthenticationPrincipal JwtUser loadUser) {
        System.out.println("wo shi username "+loadUser);
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        Map<String, Object> resultMap = new HashMap<>();
        Map<String, Object> map = new HashedMap();
        List<Map> resultList = new ArrayList<Map>();
        if (loadUser != null) {
            String username = loadUser.getUsername();

            Account account = new Account();
            account.setUsername(username);

            List<Account> queryAccount = accountService.queryForObject(account);

            for (int i = 0; i < queryAccount.size(); i++) {
                if (queryAccount.get(i).getUsername() .equals(username) ) {
                    String decription=queryAccount.get(i).getOrderNum();
                    // Account queryAccount = accountService.queryForObject(account).get(0);
                    //  System.out.println(queryAccount.getUsername());
                    List<UserInfo> userInfoList = accountService.queryForUserInfoByAccount(queryAccount.get(i));
                    UserInfoPicture userInfoPicture=new UserInfoPicture();
                    userInfoPicture.setUuid(userInfoList.get(0).getPicture());
                    UserInfoPicture picture=this.userInfoService.queryForPicture(userInfoPicture);
                    if(picture!=null) {
                        String path = picture.getName();
                        userInfoList.get(0).setPicture(path);
                    }
                    map.put("account", loadUser);
                    map.put("userinfo", userInfoList);
                    map.put("decripton",decription);
                    resultList.add(map);
                    resultMap.put("code", "0000");
                    resultMap.put("accountId", queryAccount.get(i).getId());
                    resultMap.put("appId", queryAccount.get(i).getAppId());
                    resultMap.put("data", resultList);

                }
            }
            return resultMap;
        } else {
            return "null";
        }

    }



}

