package com.gd.service.role;

import com.gd.domain.base.BaseModel;
import com.gd.domain.role.Role;
import com.gd.domain.role.RoleTmp;

import java.util.List;
import java.util.Map;

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
public interface IRoleService {
    List<Map<String, Object>> queryForObject(BaseModel baseModel);
    int addObject(BaseModel baseModel);
    int deleteObject(BaseModel baseModel);
    List<Role> query1ForObject(BaseModel baseModel);
    void updateRole(BaseModel baseModel);
}
