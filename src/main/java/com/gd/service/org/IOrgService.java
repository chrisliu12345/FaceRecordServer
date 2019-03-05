package com.gd.service.org;

import com.gd.domain.base.BaseModel;
import com.gd.domain.org.Org;
import com.gd.domain.org.Org0;
import com.gd.domain.org.Org_User;
import com.gd.domain.userinfo.UserInfo;

import java.util.List;
import java.util.Map;

/**
 * Created by dell on 2017/4/30.
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
public interface IOrgService {
    List<Org0> queryForObject0(BaseModel baseModel);
    List<Org> queryForObject(BaseModel baseModel);
    List<Org_User> queryForObject1(BaseModel baseModel);
    int insertOrg(BaseModel baseModel);
    List<Org> getAllLeaves(String id);
    //查询组织下面是否存在组织
    List<Org> queryChildernByOrg(BaseModel baseModel);
    //查询组织下面是否有人
    List<UserInfo> queryChildernByUserInfo(BaseModel baseModel);
    //删除org
    int deleteOrg(BaseModel baseModel);
    //更新组织
    int updateOrg(BaseModel baseModel);
    //查询org下面的人和APP
    List<Map<String,String>> queryUserInfoApp(String orgId);
    //查询org的map<id,name>
    List<Map<String,String>> queryOrgIdOrgName();

     String selectOrgId(Org org);
     Org getGroupOne(String id);
     void updateUserInfoOrg(UserInfo userInfo);
}
