package com.gd.service.account;

import com.gd.domain.account.Account;
import com.gd.domain.account_role.AccountRole;
import com.gd.domain.authority.Authority;
import com.gd.domain.base.BaseModel;
import com.gd.domain.role.Role;
import com.gd.domain.userinfo.UserInfo;

import java.util.List;

/**
 * Created by dell on 2017/1/12.
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
public interface IAccountService {
    List<Account> queryForObject(BaseModel baseModel);
    List<Account> queryForAllObject(BaseModel baseModel);
    List<Authority> queryForAuthorities(BaseModel baseModel);
    List<UserInfo> queryForUserInfoByAccount(BaseModel baseModel);
    //新增account
    int insertForObject(BaseModel baseModel);
    //删除账户
    int deleteForObject(BaseModel baseModel);
    //更新账户
    int updateForObject(BaseModel baseModel);
    int updateForObject(Account account);
    List<AccountRole> queryForAccountRole(String id);
    List<Role> queryForRole(String id);
   void  updateForRole(BaseModel baseModel);
    List<Role> queryNameForRole(BaseModel baseModel);
     void  updateForAccountRole(AccountRole accountRole);
     void updateForPassword(Account account);
Account queryForAccountToPassword(Account account);
    int checkAccountName(Account account);
}
