package com.gd.security;

import com.gd.domain.account.Account;
import com.gd.domain.authority.Authority;
import com.gd.domain.saltuser.SaltUser;
import com.gd.jwt.JwtUser;
import com.gd.jwt.JwtUserFactory;
import com.gd.service.account.IAccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.Cache;
import org.springframework.cache.ehcache.EhCacheCacheManager;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

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
@Component
public class SecurityUserService implements UserDetailsService {
    @Autowired
    private IAccountService accountService;
    @Autowired
    private EhCacheCacheManager ehCacheCacheManager;

    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        Account account = new Account();
        account.setUsername(s);//s为username
        //SecurityUser user = new SecurityUser();
        // SecurityUser securityUser = securityUserDao.queryForUserByName(username);
        List<Account> accountList = this.accountService.queryForObject(account);
        UserDetails userDetail = null;
//        if (accountList.size() != 0) {
//            userDetail = new JwtUser(accountList.get(0).getId(),s,
//                    accountList.get(0).getPassword(), true, true, true, true,
//                    findUserAuthorities2(accountList.get(0).getUsername()),
//                    accountList.get(0).getSalt());
//        }
//
//
//        //this.userCache.putUserInCache(userDetail);
//        return userDetail;
        try {

            return JwtUserFactory.create(accountList.get(0),findUserAuthorities2(accountList.get(0).getUsername()));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<GrantedAuthority> findUserAuthorities2(String username) {
        List<GrantedAuthority> autthorities = new ArrayList<GrantedAuthority>();
        Account account = new Account();

        List<Authority> authorityList;
//        Cache authCache = this.ehCacheCacheManager.getCache("authorities");
//        if (authCache != null && authCache.get(username) != null && authCache.get(username).get() != null) {
//            authorityList = (List<Authority>) authCache.get(username).get();
//        } else {
            account.setUsername(username);
            authorityList = this.accountService.queryForAuthorities(account);
           // System.out.println(account.getUsername()+""+account.getToken()+""+account.getId());
           //System.out.println("authorityList.get(0).getId()::::::"+authorityList.get(0).getId());
//            if (authorityList.size() > 0) {
//                authCache.put(username, authorityList);
//            }
//        }

        if (authorityList == null || authorityList.size() == 0) {
            return autthorities;
        } else {
            for (Authority auth : authorityList) {
                autthorities.add(new SimpleGrantedAuthority(auth.getId()));
            }
            return autthorities;
        }
    }
}
