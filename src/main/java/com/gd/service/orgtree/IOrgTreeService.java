package com.gd.service.orgtree;



import com.gd.domain.config.CameraLocation;
import com.gd.domain.org.Org;
import com.gd.domain.userinfo.UserInfo;

import java.util.List;
import java.util.Map;

public interface IOrgTreeService {
    int insert(Map<String, String> map);

    List<Map<String, String>> queryForList(Map<String, String> map);

    int delete(String id);

    List<CameraLocation> queryForCameraLoaction();

    CameraLocation queryForlocationNow(Integer id);

    List<UserInfo> queryForGroupToUser(String id);
    List<Org> queryForGroupToGroup(String id);
}
