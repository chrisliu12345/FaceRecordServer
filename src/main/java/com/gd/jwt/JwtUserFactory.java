package com.gd.jwt;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;


import com.gd.domain.account.Account;
import com.gd.domain.saltuser.SaltUser;
import com.gd.util.TimeUtils;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

public final class JwtUserFactory {

    private JwtUserFactory() {
    }

    public static JwtUser create(Account account,List<GrantedAuthority> authotities) {
//        return new JwtUser(
//                account.getId(),
//                account.getUsername(),
//                account.getPassword(),
//                authotities,
//                TimeUtils.strToDate(account.getUpdateTime())
//        );
        return new JwtUser(account.getId(),
                account.getIfuse(),
                account.getCreateTime(),
                account.getUpdateTime(),
                account.getOrderNum(),
                account.getUsername(),
                account.getPassword(),
                account.getSalt(),
                account.getToken(),
                account.getAppId(),
                account.getCommunicationId(),
                authotities);
    }

    private static List<GrantedAuthority> mapToGrantedAuthorities(List<String> authorities) {
        return authorities.stream()
                .map(SimpleGrantedAuthority::new)
                .collect(Collectors.toList());
    }


}

