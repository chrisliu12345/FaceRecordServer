package com.gd.controller.account;

import ch.qos.logback.classic.Logger;
import com.gd.annoation.Log;
import com.gd.annoation.RequestLimit;

import com.gd.domain.account.Account;
import com.gd.domain.account_camera.Account_Camera;
import com.gd.domain.account_role.AccountRole;
import com.gd.domain.account_user.AccountUser;
import com.gd.domain.base.BaseModel;

import com.gd.domain.role.Role;
import com.gd.domain.userinfo.UserInfo;
import com.gd.service.account.IAccountService;

import com.gd.service.account_role.IAccountRoleService;
import com.gd.service.account_user.IAccountUserService;
import com.gd.service.userinfo.IUserInfoService;
import com.gd.util.AccountPasswordUtils;
import com.gd.util.EasemobUtils;
import com.gd.util.MakeFixLenthStringUtils;
import com.gd.util.TimeUtils;
import com.google.gson.Gson;

import io.swagger.annotations.*;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.security.Principal;
import java.util.*;

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
@Controller
@RestController
@RequestMapping("/account")

public class AccountController {
    @Autowired
    private IAccountService accountService;
    @Autowired
    private IUserInfoService userInfoService;
    @Autowired
    private IAccountUserService accountUserService;
    @Autowired
    private IAccountRoleService accountRoleService;


    @GetMapping("/all")
    @RequestLimit(count = 1, limitTime = 2000)
    @CrossOrigin(origins = "*", maxAge = 360000)
    public String getAllAccounts(Principal principal, HttpServletRequest request) {
        boolean flag = validateAccount(principal);
        Map<String, Object> resultMap = new HashMap<>();
        Gson gson = new Gson();
        if (!flag) {
            resultMap.put("code", "0001");//验证失败
            resultMap.put("date", null);
            return gson.toJson(resultMap);
        }

        List<Account> accountList;

        accountList = this.accountService.queryForAllObject(new BaseModel());

        resultMap.put("code", "0000");
        resultMap.put("data", accountList);

        return gson.toJson(resultMap);
    }

    @RequestMapping(method = RequestMethod.GET)
    @ApiOperation(value = "查询账户列表", notes = "查询账户列表", httpMethod = "GET", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiResponses(value = {
            @ApiResponse(code = 401, message = "No Privilege"),
            @ApiResponse(code = 405, message = "Invalid input")
    })
    public String queryForAccountList() {
        List<Account> accountList = new ArrayList<>();
        accountList = this.accountService.queryForAllObject(new BaseModel());
        Map<String, Object> resultMap = new HashMap<>();

        resultMap.put("code", "0000");
        resultMap.put("data", accountList);
        Gson gson = new Gson();
        return gson.toJson(resultMap);
    }

    @RequestMapping(value = "/queryAccount", method = RequestMethod.POST)
    @ApiOperation(value = "查询账户", notes = "查询账户", httpMethod = "GET", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiResponses(value = {
            @ApiResponse(code = 401, message = "No Privilege"),
            @ApiResponse(code = 405, message = "Invalid input")
    })
    public String queryForAccount(@RequestBody Map<String, String> map) {
        Gson gson = new Gson();
        Map<String, Object> resultMap = new HashMap<>();
        Account queryAccount = new Account();
        if (StringUtils.isEmpty(map.get("username")) && StringUtils.isEmpty(map.get("appId")) && StringUtils.isEmpty(map.get("communicationId"))) {
            resultMap.put("code", "0000");
            resultMap.put("data", "query param can not be null");
            return gson.toJson(resultMap);
        }
        queryAccount.setUsername(map.get("username"));
        queryAccount.setAppId(map.get("appId"));
        queryAccount.setCommunicationId(map.get("communicationId"));

        List<Account> accountList = new ArrayList<>();
        accountList = this.accountService.queryForObject(queryAccount);



        resultMap.put("code", "0000");
        resultMap.put("data", accountList);
        return gson.toJson(resultMap);
    }

    @RequestMapping(method = RequestMethod.POST)
    @ApiOperation(value = "新增账户", notes = "新增账户", httpMethod = "POST", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ApiResponses(value = {
            @ApiResponse(code = 401, message = "No Privilege"),
            @ApiResponse(code = 405, message = "Invalid input")
    })
    public String add(@RequestBody Map<String, Object> map) {
        String userId = (String)map.get("userId");   //用户ID
        String username = (String)map.get("username");  //账户名
        String password = (String)map.get("password");//账户密码
        String token = (String)map.get("token");  //token
        String appId = (String)map.get("password");  //账户真实密码
        String communicationId =(String) map.get("communicationId");
        String decription=(String)map.get("description");//判断账户是否是个人账户

        List<Integer> selectCamera=(List<Integer>)map.get("selectCamera");//账户对摄像头的控制ID
        //多个roleId，用逗号分隔
        String roleIds =(String) map.get("roleIds");//角色ID


        Account account = new Account();
        account.setUsername(username);
        account.setPassword(password);
        account.setToken(token);
        account.setAppId(appId);
        account.setCommunicationId(communicationId);
        account.setOrderNum(decription);


        Map<String, Object> resultMap = new HashMap<>();
        Gson gson = new Gson();
        int num=this.accountService.checkAccountName(account);
        if(num>0){
            resultMap.put("code", "0005");
            resultMap.put("data", "账户名已注册，请修改");
            return gson.toJson(resultMap);
        }
        if (StringUtils.isEmpty(userId)) {
            resultMap.put("code", "0001");
            resultMap.put("data", "userId can not be null");
            return gson.toJson(resultMap);
        }
        if (StringUtils.isEmpty(roleIds)) {
            resultMap.put("code", "0001");
            resultMap.put("data", "roleIds can not be null");
            return gson.toJson(resultMap);
        }
        if (StringUtils.isEmpty(account.getUsername())) {
            resultMap.put("code", "0001");
            resultMap.put("data", "username can not be null");
            return gson.toJson(resultMap);
        }
        if (StringUtils.isEmpty(account.getPassword())) {
            resultMap.put("code", "0001");
            resultMap.put("data", "password can not be null");
            return gson.toJson(resultMap);
        }
        if (StringUtils.isEmpty(account.getId())) {
            account.setId(UUID.randomUUID().toString());
        }
        if (StringUtils.isEmpty(account.getCreateTime())) {
            account.setCreateTime(TimeUtils.getCurrentTime());
        }
        account.setUpdateTime(TimeUtils.getCurrentTime());
        if (StringUtils.isEmpty(account.getIfuse())) {
            account.setIfuse("y");
        }
        UserInfo queryUserInfo = new UserInfo();
        queryUserInfo.setId(userId);
        UserInfo userInfo = new UserInfo();

        List<UserInfo> userInfoList = userInfoService.queryForObject(queryUserInfo);
        if (userInfoList.size() == 0) {
            resultMap.put("code", "0001");
            resultMap.put("data", "can not find user");
            return gson.toJson(resultMap);
        }
        userInfo = userInfoList.get(0);
        AccountUser accountUser = new AccountUser();
        accountUser.setId(UUID.randomUUID().toString());
        accountUser.setUserId(userInfo.getId());
        accountUser.setAccountId(account.getId());
        List<String> roleIdsList = new ArrayList<String>();
        for (String roleId : roleIds.split(",")) {
            roleIdsList.add(roleId);
        }
        int flag = this.accountService.insertForObject(account) & this.accountUserService.insertForObject(accountUser) & this.accountRoleService.insertForObject(account.getId(), roleIdsList);
        if (flag == 1) {
            resultMap.put("code", "0000");
            resultMap.put("data", "success");
        } else {
            resultMap.put("code", "0001");
            resultMap.put("data", "account insert failed");
        }
        if(selectCamera!=null) {

        }
        return gson.toJson(resultMap);
    }

    @RequestMapping(value = "/updateAccount", method = RequestMethod.POST)
    public void updateAccount(@RequestBody Map<String, String> map) {

        String username = map.get("username");
        String password = map.get("password");
        String UserRole = map.get("role");
        String sid = map.get("id");
        Role role = new Role();
        role.setRoleName(UserRole);
        Account account = new Account();
        account.setUsername(username);
        account.setPassword(password);
        account.setAppId(password);
        this.accountService.updateForObject(account);
        //准备修改的账户对应的角色
        List<AccountRole> accountRoleList = this.accountService.queryForAccountRole(sid);
        List<Role> roleList = this.accountService.queryNameForRole(role);

        AccountRole accountRole = new AccountRole();
        accountRole.setId(accountRoleList.get(0).getId());
        accountRole.setRoleId(roleList.get(0).getId());
        this.accountService.updateForAccountRole(accountRole);

    }

    @RequestMapping(value = "/updateRoleForAccount", method = RequestMethod.PUT)
    @ApiOperation(value = "为账户授予角色", notes = "为账户授予角色", httpMethod = "PUT", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public String updateRoleForAccount(@RequestBody Map<String, String> map) {
        String accountId = map.get("accountId");
        String roleIds = map.get("roleIds");
        Map<String, Object> resultMap = new HashMap<>();
        Gson gson = new Gson();
        if (StringUtils.isEmpty(accountId)) {
            resultMap.put("code", "0001");
            resultMap.put("data", "accountId can not be null");
            return gson.toJson(resultMap);
        }
        if (StringUtils.isEmpty(roleIds)) {
            resultMap.put("code", "0001");
            resultMap.put("data", "roleIds can not be null");
            return gson.toJson(resultMap);
        }
        List<String> roleIdsList = new ArrayList<String>();
        for (String roleId : roleIds.split(",")) {
            roleIdsList.add(roleId);
        }
        //删除account关联并且关联account和roleIds
        int flag = this.accountRoleService.deleteForObject(accountId) & this.accountRoleService.insertForObject(accountId, roleIdsList);
        if (flag == 1) {
            resultMap.put("code", "0000");
            resultMap.put("data", "updateRoleForAccount success");
        } else {
            resultMap.put("code", "0001");
            resultMap.put("data", "updateRoleForAccount failed");
        }
        return gson.toJson(resultMap);
    }

    @RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
    public String updateAccountPassword(@RequestBody Map<String,String> pasMap) {
        System.out.println("我是更新账户id:"+pasMap.get("id")+"新账户密码："+pasMap.get("password"));
        Map<String, Object> resultMap = new HashMap<>();
        Gson gson = new Gson();
        Account account=new Account();
        account.setId(pasMap.get("id"));
        //先验证旧密码是否正确?
        Account account1=this.accountService.queryForAccountToPassword(account);
        String oldpass=new Md5PasswordEncoder().encodePassword(pasMap.get("oldpassword"), account1.getSalt());
        if(oldpass.equals(account1.getPassword())){
            String randomSalt = MakeFixLenthStringUtils.getFixLenthString(6);
            String currPassWord = pasMap.get("password");
            account.setSalt(randomSalt);
            String usePassWord = new Md5PasswordEncoder().encodePassword(currPassWord, randomSalt);
            account.setPassword(usePassWord);
            this.accountService.updateForPassword(account);
            return null;
        }else{
            resultMap.put("data","errorPassword");
            return gson.toJson(resultMap);
        }
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    @ApiOperation(value = "删除账户", notes = "删除账户", httpMethod = "DELETE", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "账户id", required = true, dataType = "String", paramType = "path")
    })
    public String delete(@PathVariable("id") String id) {

        //删除账户用户表信息
        AccountUser accountUser=new AccountUser();
        accountUser.setAccountId(id);
        this.accountUserService.delete(accountUser);
        //删除账户表信息
        Account account = new Account();
        account.setId(id);
        int flag = this.accountService.deleteForObject(account);
        AccountRole accountRole=new AccountRole();
        accountRole.setAccountId(id);
        //删除账户角色表信息
        this.accountRoleService.deleteForObject(id);

        Map<String, Object> resultMap = new HashMap<>();
        if (flag == 1) {
            resultMap.put("code", "0000");
            resultMap.put("data", "delete success");
        } else {
            resultMap.put("code", "0011");
            resultMap.put("data", "account delete failed");
        }
        Gson gson = new Gson();
        return gson.toJson(resultMap);
    }

    private boolean validateAccount(Principal principal) {
        String username = principal.getName();
        Account account = new Account();
        account.setUsername(username);
        List<Account> accountList = this.accountService.queryForObject(account);
        return accountList.size() >= 1;
    }
}
