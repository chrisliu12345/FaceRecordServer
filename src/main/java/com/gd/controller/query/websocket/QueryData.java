package com.gd.controller.query.websocket;

import com.gd.domain.query.DetectImages;
import com.gd.domain.query.DetectImagesTemp;
import com.gd.domain.userinfo.SignIn;
import com.gd.domain.userinfo.UserInfoPicture;
import com.gd.service.query.IQueryService;
import com.gd.service.query.impl.QueryServiceImpl;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

public  class QueryData {
   /* @Autowired*/
    private QueryServiceImpl queryService=(QueryServiceImpl) ApplicationHelper.getBean(QueryServiceImpl.class);
    private Integer sum=this.queryService.signSum();
    public static List<Integer> list=new ArrayList<>();

    public String getNewPeople(Integer maxId) {
        Map<String, Object> map = new HashMap<>();
        Gson gson = new Gson();//查询1条collectId


        List<DetectImages> detectImages=this.queryService.queryForCollectIdByFive(maxId);
        List<Integer> resultDetects=new ArrayList<>();
        List<Integer> siginincollects=this.queryService.getSignCollectid();
        for(int i=0;i<detectImages.size();i++){
           if(list.contains(detectImages.get(i).getCollectId())){
              // return "exist";
           }else{
               list.add(detectImages.get(i).getCollectId());
               resultDetects.add(detectImages.get(i).getCollectId());
           }
        }
        if(resultDetects.size()==0){
            return "exist";
        }else {
            List<UserInfoPicture> userInfoPictures = this.queryService.queryForObjectSimple(resultDetects);
            //获取图片所在的文件夹根路径
            String pictureRootUrl = this.queryService.getPictSaveRootDirectory();
            for (int i = 0; i < userInfoPictures.size(); i++) {
                userInfoPictures.get(i).setDate(userInfoPictures.get(i).getDate().substring(0, userInfoPictures.get(i).getDate().length() - 2));
                userInfoPictures.get(i).setUrl(pictureRootUrl);
                // userInfoPictures.get(i).setCollectId(detectImages.getCollectId());
                System.out.println(userInfoPictures.get(i).getRealName() + "已签到！");
            }
            //将siginin表的signin字段置为1
            for(UserInfoPicture uu: userInfoPictures){
                DetectImages detectImages1=new DetectImages();
                detectImages1.setCollectId(uu.getCollectId());
                detectImages1.setDate(Timestamp.valueOf(uu.getDate()));
                this.queryService.updateSignin(detectImages1);
            }


            //返回签到率
            Float sginResult = getSignRate();
            map.put("data", userInfoPictures);  //返回一个签到的人员
            map.put("rate", sginResult); //返回签到率
            return gson.toJson(map);
        }
    }
    public String getListPeople(){
        Map<String, Object> map = new HashMap<>();
        Gson gson = new Gson();
        String pictureRootUrl = this.queryService.getPictSaveRootDirectory();
        //获取sigin中的所有人员collectID
        List<Integer> siginincollects=this.queryService.getSignCollectidRes();
        //获取当天的日期，加入进去
        Date date=new Date();
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
        List<UserInfoPicture> userInfoPictures = this.queryService.queryForObjectList(df.format(date));
        userInfoPictures=removeDuplicate(userInfoPictures);
        List<UserInfoPicture> resultList=new ArrayList<>();
        for (int i = 0; i < userInfoPictures.size(); i++) {
            if(siginincollects.contains(userInfoPictures.get(i).getCollectId())) {
                list.add(userInfoPictures.get(i).getCollectId());
                userInfoPictures.get(i).setDate(userInfoPictures.get(i).getDate().substring(0, userInfoPictures.get(i).getDate().length() - 2));
                userInfoPictures.get(i).setUrl(pictureRootUrl);
                DetectImages detectImages=new DetectImages();
                detectImages.setDate(Timestamp.valueOf(userInfoPictures.get(i).getDate()));
                detectImages.setCollectId(userInfoPictures.get(i).getCollectId());
                this.queryService.updateSignin(detectImages);
                resultList.add(userInfoPictures.get(i));
            }
        }
        List<SignIn> siginList=getSignIn();
        Float sginResult=getSignRate();
        System.out.println("已签到人员总数："+resultList.size());
        System.out.println("未签到人员总数："+siginList.size());
        System.out.println("签到率："+sginResult);
        map.put("data", resultList);//返回所有已签到的人员
        map.put("sign",siginList); //返回所有未签到的人员
        map.put("rate",sginResult); //返回签到率
        return gson.toJson(map);

    }
    //查询所有未签到会议人员信息
    public List<SignIn> getSignIn(){
        String pictureRootUrl = this.queryService.getPictSaveRootDirectory();
        List<SignIn> list=this.queryService.queryForSignIn();
        for(int i=0;i<list.size();i++){
            list.get(i).setUrl(pictureRootUrl);
        }
        return list;
    }
    //统计签到率
    public float getSignRate(){
        //System.out.println("会议总人数:"+sum);

        Integer sign=this.queryService.signPeople();
        //System.out.println("会议签到人数"+sign);
        return (float)sign/sum;

    }
    //去重
    public   static   List<UserInfoPicture>  removeDuplicate(List<UserInfoPicture> list)  {
        System.out.println("过滤之前的数据"+list.size());
        for  ( int  i  =   0 ; i  <  list.size()  -   1 ; i ++ )  {
            for  ( int  j  =  list.size()  -   1 ; j  >  i; j -- )  {
                if  (list.get(j).getCollectId()==(list.get(i)).getCollectId())  {
                    list.remove(j);
                }
            }
        }
        return list;
    }
    //查询fr_origin_record最大值
     public  Integer getMaxid(){
        return this.queryService.getMaxTime();
     }

}
