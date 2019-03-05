package com.gd.controller.common;

import com.gd.domain.video.Camera1;
import com.gd.domain.video.Res_Attr;
import com.gd.service.common.IResService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.sql.Timestamp;
import java.util.Map;


public class CameraAdd {
    public int RandomNumber() {
        int r = (int) (Math.random() * 999999999);
        return r;
    }
    /**
     * 添加设备
     */
    public Res_Attr add(Map<String, String> paramMap) {
        //添加到资源表的信息
        Res_Attr res_attr = new Res_Attr();
        /*Integer q1 = Integer.parseInt(paramMap.get("ResID"));
        res_attr.setResID(q1);*/
        if (paramMap.get("ProtocolType") == null || paramMap.get("ProtocolType").equals("")) {
            String q30 = "null";
            res_attr.setProtocolType(q30);
        } else {
            String q30 = paramMap.get("ProtocolType");
            res_attr.setProtocolType(q30);
        }
        if (paramMap.get("DeviceID") == null || paramMap.get("DeviceID").equals("")) {

            res_attr.setDeviceID(String.valueOf(RandomNumber()));
        } else {
            res_attr.setDeviceID(String.valueOf(RandomNumber()));
        }
        if (paramMap.get("Name") == null || paramMap.get("Name").equals("")) {
            String q3 = "null";
            res_attr.setName(q3);
        } else {
            String q3 = paramMap.get("Name");
            res_attr.setName(q3);
        }
        if (paramMap.get("Manufacturer") == null || paramMap.get("Manufacturer").equals("")) {
            String q4 = paramMap.get("ProtocolType");
            res_attr.setManufacturer(q4);
        } else {
            String q4 =paramMap.get("ProtocolType");
            res_attr.setManufacturer(q4);
        }
        if (paramMap.get("Model") == null || paramMap.get("Model").equals("")) {
            String q5 = paramMap.get("ProtocolType");
            res_attr.setModel(q5);
        } else {
            String q5 = paramMap.get("ProtocolType");
            res_attr.setModel(q5);
        }
        if (paramMap.get("Owner") == null || paramMap.get("Owner").equals("")) {
            String q6 = "0";
            res_attr.setOwner(q6);
        } else {
            String q6 = paramMap.get("Owner");
            res_attr.setOwner(q6);
        }
        if (paramMap.get("CivilCode") == null || paramMap.get("CivilCode").equals("")) {
            String q7 = "null";
            res_attr.setCivilCode(q7);
        } else {
            String q7 = paramMap.get("CivilCode");
            res_attr.setCivilCode(q7);
        }
        if (paramMap.get("Block") == null || paramMap.get("Block").equals("")) {
            String q8 = "null";
            res_attr.setBlock(q8);
        } else {
            String q8 = paramMap.get("Block");
            res_attr.setBlock(q8);
        }
        if (paramMap.get("Address") == null || paramMap.get("Address").equals("")) {
            String q9 = paramMap.get("Name");
            res_attr.setAddress(q9);
        } else {
            String q9 = paramMap.get("Address");
            res_attr.setAddress(q9);
        }
        if (paramMap.get("Parental") == null || paramMap.get("Parental").equals("")) {
            Integer q10 = 0;
            res_attr.setParental(q10);
        } else {
            Integer q10 = Integer.parseInt(paramMap.get("Parental"));
            res_attr.setParental(q10);
        }
        if (paramMap.get("ParentID") == null || paramMap.get("ParentID").equals("")) {
            //如果是没选，就是自身的DeviceID
            String q11 = "null";
            res_attr.setParentID(q11);
        } else {
            String q11 = paramMap.get("ParentID");
            res_attr.setParentID(q11);
        }
        if (paramMap.get("SafetyWay") == null || paramMap.get("SafetyWay").equals("")) {
        } else {
            Integer q12 = (0);
            res_attr.setSafetyWay(q12);
        }
        if (paramMap.get("RegisterWay") == null || paramMap.get("RegisterWay").equals("")) {
            Integer q13 = 1;
            res_attr.setRegisterWay(q13);
        } else {
            Integer q13 = Integer.parseInt(paramMap.get("RegisterWay"));
            res_attr.setRegisterWay(q13);
        }
        if (paramMap.get("CertNum") == null || paramMap.get("CertNum").equals("")) {
        } else {
            String q14 = paramMap.get("CertNum");
            res_attr.setCertNum(q14);
        }
        if (paramMap.get("Certifiable") == null || paramMap.get("Certifiable").equals("")) {
        } else {
            Integer q15 = Integer.parseInt(paramMap.get("Certifiable"));
            res_attr.setCertifiable(q15);
        }

        if (paramMap.get("ErrCode") == null || paramMap.get("ErrCode").equals("")) {
        } else {
            Integer q16 = Integer.parseInt(paramMap.get("ErrCode"));
            res_attr.setErrCode(q16);
        }
        if (paramMap.get("EndTime") == null || paramMap.get("EndTime").equals("")) {
        } else {
            Timestamp q17 = Timestamp.valueOf(paramMap.get("EndTime"));
            res_attr.setEndTime(q17);
        }
        if (paramMap.get("Secrecy") == null || paramMap.get("Secrecy").equals("")) {
            Integer q18 = 0;
            res_attr.setSecrecy(q18);
        } else {
            Integer q18 = Integer.parseInt(paramMap.get("Secrecy"));
            res_attr.setSecrecy(q18);
        }
        if (paramMap.get("IPAddress") == null || paramMap.get("IPAddress").equals("")) {
        } else {
            String q19 = paramMap.get("IPAddress");
            res_attr.setIPAddress(q19);
        }
        if (paramMap.get("Port") == null || paramMap.get("Port").equals("")) {
        } else {
            Integer q20 = Integer.parseInt(paramMap.get("Port"));
            res_attr.setPort(q20);
        }
        if ((paramMap.get("UsrName") == null) || paramMap.get("UsrName").equals("")) {
        } else {
            String q21 = paramMap.get("UsrName");
            res_attr.setUsrName(q21);
        }
        if ((paramMap.get("Password") == null) || paramMap.get("Password").equals("")) {
        } else {
            res_attr.setPassword(paramMap.get("Password"));

        }
        if (paramMap.get("Status") == null || paramMap.get("Status").equals("")) {
            String q23 = "ON";
            res_attr.setStatus(q23);
        } else {
            String q23 = paramMap.get("Status");
            res_attr.setStatus(q23);
        }

        if ((paramMap.get("Longitude") == null) || paramMap.get("Longitude").equals("")) {
        } else {
            double q24 = Double.parseDouble(paramMap.get("Longitude"));
            res_attr.setLongitude(q24);
        }
        if (paramMap.get("Latitude") == null || paramMap.get("Latitude").equals("")) {
        } else {
            double q25 = Double.parseDouble(paramMap.get("Latitude"));
            res_attr.setLatitude(q25);
        }
        if (paramMap.get("PlatformID") == null || paramMap.get("PlatformID").equals("")) {
            Integer q26 = 1;
            res_attr.setPlatformID(q26);
        } else {
            Integer q26 = Integer.parseInt(paramMap.get("PlatformID"));
            res_attr.setPlatformID(q26);
        }
        if (paramMap.get("ResType") == null || paramMap.get("ResType").equals("")) {
            Integer q27 = 0;
            res_attr.setResType(q27);
        } else {
            Integer q27 = Integer.parseInt(paramMap.get("ResType"));
            res_attr.setResType(q27);
        }

        if (paramMap.get("SipServiceID") == null || paramMap.get("SipServiceID").equals("")) {
            if (paramMap.get("SipServiceID1") == null || paramMap.get("SipServiceID1").equals("")) {
                Integer q28 = 2;
                res_attr.setSipServiceID(q28);
            } else {
                Integer q28 = Integer.parseInt(paramMap.get("SipServiceID1"));
                res_attr.setSipServiceID(q28);
            }
        } else {
            Integer q123 = Integer.parseInt(paramMap.get("SipServiceID"));
            res_attr.setSipServiceID(q123);
        }
        if (paramMap.get("GuardFlag") == null || paramMap.get("GuardFlag").equals("")) {
            Integer q29 = 0;
            res_attr.setGuardFlag(q29);
        } else {
            Integer q29 = Integer.parseInt(paramMap.get("GuardFlag"));
            res_attr.setGuardFlag(q29);
        }
       return res_attr;
    }
    /**
     * 添加摄像机
     */
     public Camera1 addCam(Map<String, String> paramMap){
         Camera1 so = new Camera1();
         so.setResID(Integer.parseInt(paramMap.get("ResID")));

         if (paramMap.get("selectPlaceID") == null || paramMap.get("selectPlaceID").equals("")) {
         } else {
             so.setPlaceID(paramMap.get("selectPlaceID"));
         }
         if (paramMap.get("Alias") == null || paramMap.get("Alias").equals("")) {
         } else {
             so.setAlias(paramMap.get("Alias"));
         }
         if (paramMap.get("Azimuth") == null || paramMap.get("Azimuth").equals("")) {
         } else {
             so.setAzimuth(Double.parseDouble(paramMap.get("Azimuth")));
         }
         if (paramMap.get("BusinessGroupID") == null || paramMap.get("BusinessGroupID").equals("")) {
         } else {
             so.setBusinessGroupID(paramMap.get("BusinessGroupID"));
         }
         if (paramMap.get("DirectionType") == null || paramMap.get("DirectionType").equals("")) {
         } else {
             so.setDirectionType(Integer.parseInt(paramMap.get("DirectionType")));
         }
         if (paramMap.get("DownLoadSpeed") == null || paramMap.get("DownLoadSpeed").equals("")) {
         } else {
             so.setDownLoadSpeed(paramMap.get("DownLoadSpeed"));
         }


         if (paramMap.get("Height") == null || paramMap.get("Height").equals("")) {
         } else {
             so.setHeight(Double.parseDouble(paramMap.get("Height")));
         }
         if (paramMap.get("LockedUsr") == null || paramMap.get("LockedUsr").equals("")) {
         } else {
             so.setLockedUsr(Integer.parseInt(paramMap.get("LockedUsr")));
         }

         if (paramMap.get("PitchAngle") == null || paramMap.get("PitchAngle").equals("")) {
         } else {
             so.setPitchAngle(Double.parseDouble(paramMap.get("PitchAngle")));
         }
         if (paramMap.get("PositionType") == null || paramMap.get("PositionType").equals("")) {
         } else {
             so.setPositionType(Integer.parseInt(paramMap.get("PositionType")));
         }
         if (paramMap.get("PtzType") == null || paramMap.get("PtzType").equals("")) {
             so.setPtzType(0);
         } else {
             so.setPtzType(Integer.parseInt(paramMap.get("PtzType")));
         }
         if (paramMap.get("PtzURL") == null || paramMap.get("PtzURL").equals("")) {
         } else {
             so.setPtzURL(paramMap.get("PtzURL"));
         }

         if (paramMap.get("ReplayID") == null || paramMap.get("ReplayID").equals("")) {
         } else {
             so.setReplayID(Integer.parseInt(paramMap.get("ReplayID")));
         }
         if (paramMap.get("Resolution") == null || paramMap.get("Resolution").equals("")) {
         } else {
             so.setResolution(paramMap.get("Resolution"));
         }
         if (paramMap.get("RoomType") == null || paramMap.get("RoomType").equals("")) {
             so.setRoomType(1);
         } else {
             so.setRoomType(Integer.parseInt(paramMap.get("RoomType")));
         }

         if (paramMap.get("StreamId") == null || paramMap.get("StreamId").equals("")) {
         } else {
             so.setStreamingID(Integer.parseInt(paramMap.get("StreamId")));
         }

         if (paramMap.get("SupplyLightType") == null || paramMap.get("SupplyLightType").equals("")) {
             so.setSupplyLightType(1);
         } else {
             so.setSupplyLightType(Integer.parseInt(paramMap.get("SupplyLightType")));
         }
         if (paramMap.get("SVCSpaceSupportMode") == null || paramMap.get("SVCSpaceSupportMode").equals("")) {
         } else {
             so.setSVCSpaceSupportMode(Integer.parseInt(paramMap.get("SVCSpaceSupportMode")));
         }
         if (paramMap.get("SVCTimeSupportMode") == null || paramMap.get("SVCTimeSupportMode").equals("")) {
         } else {
             so.setSVCTimeSupportMode(Integer.parseInt(paramMap.get("SVCTimeSupportMode")));
         }
         if (paramMap.get("UseType") == null || paramMap.get("UseType").equals("")) {
         } else {
             so.setUseType(Integer.parseInt(paramMap.get("UseType")));
         }
        return so;
     }
}
