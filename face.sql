/*
Navicat MySQL Data Transfer

Source Server         : 本机
Source Server Version : 50638
Source Host           : localhost:3306
Source Database       : face

Target Server Type    : MYSQL
Target Server Version : 50638
File Encoding         : 65001

Date: 2019-06-11 14:16:05
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `fr_attendance_location`
-- ----------------------------
DROP TABLE IF EXISTS `fr_attendance_location`;
CREATE TABLE `fr_attendance_location` (
  `AttendanceLocationID` int(10) NOT NULL AUTO_INCREMENT COMMENT '考勤地点编号',
  `AttendanceLocationName` varchar(100) NOT NULL COMMENT '考勤地点（包含多个摄像头对）',
  `BeShowOnIdentifyResults` int(10) NOT NULL DEFAULT '0' COMMENT '是否显示此考勤地点所有入口摄像机的识别结果，1为显示，0为不显示',
  `BeShowOffIdentifyResults` int(10) NOT NULL DEFAULT '0' COMMENT '是否显示此考勤地点所有出口摄像机的识别结果，1为显示，0为不显示',
  `BeShowOnOffIdentifyResults` int(10) NOT NULL DEFAULT '0' COMMENT '是否显示此考勤地点所有出入口摄像机的识别结果，1为显示，0为不显示',
  `SoundEquipmentID` int(10) DEFAULT NULL COMMENT '发声设备ID，不为空则发声，为空则不发声',
  PRIMARY KEY (`AttendanceLocationID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fr_attendance_location
-- ----------------------------
INSERT INTO `fr_attendance_location` VALUES ('1', '长峰大楼', '1', '1', '1', '1');
INSERT INTO `fr_attendance_location` VALUES ('2', '32号楼', '1', '1', '1', '2');

-- ----------------------------
-- Table structure for `fr_attendance_record`
-- ----------------------------
DROP TABLE IF EXISTS `fr_attendance_record`;
CREATE TABLE `fr_attendance_record` (
  `id` int(10) NOT NULL COMMENT '考勤记录表：行号',
  `EmployeeId` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '员工号(暂时不用)',
  `CollectId` int(10) DEFAULT NULL COMMENT '采集人员编号（唯一）',
  `ClockIn` datetime DEFAULT NULL COMMENT '上班打卡时间',
  `ClockOff` datetime DEFAULT NULL COMMENT '下班打卡时间',
  `AttendanceFlag` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '迟到标志位：没有迟到为空',
  `WorkOverTime` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '加班时长',
  `AttendanceLocationId` int(10) DEFAULT NULL COMMENT '考勤地点ID',
  `CreateTime` date DEFAULT NULL COMMENT '考勤日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of fr_attendance_record
-- ----------------------------
INSERT INTO `fr_attendance_record` VALUES ('0', '25', '25', '2019-06-01 08:21:48', '2019-06-01 18:08:15', '', null, null, '2019-06-01');

-- ----------------------------
-- Table structure for `fr_camera`
-- ----------------------------
DROP TABLE IF EXISTS `fr_camera`;
CREATE TABLE `fr_camera` (
  `CamerId` int(10) NOT NULL AUTO_INCREMENT COMMENT '摄像机编号',
  `Site` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '安装地点，摄像机名称',
  `url` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '摄像机url',
  `ip` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '摄像机地址',
  `username` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '摄像机用户名',
  `pwd` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '摄像机密码',
  `vender` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '摄像机厂家',
  `groupid` varchar(100) COLLATE utf8_bin DEFAULT '1' COMMENT '组id',
  `TaskType` int(10) DEFAULT '2' COMMENT '出入口类型：0-入口、1-出口，2-出入口',
  `ServiceId` int(10) DEFAULT '1' COMMENT '服务ID',
  `AttendanceLocationID` int(10) DEFAULT '1' COMMENT '考勤地点ID',
  `ServiceCameraID` int(10) DEFAULT NULL COMMENT 'BS播放摄像头编号',
  `featureID` int(10) DEFAULT '1' COMMENT '人脸底库ID，关联fr_featuresLib表的featureID；值为0时，表示无特征底库',
  `camConfigID` int(10) DEFAULT '1' COMMENT '摄像机识别参数ID，关联fr_camera_recognize表的id',
  `soundID` int(10) DEFAULT '0' COMMENT '播放声音设备ID，关联fr_sound_equipment表中的soundID',
  PRIMARY KEY (`CamerId`)
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of fr_camera
-- ----------------------------
INSERT INTO `fr_camera` VALUES ('174', '测试', 'rtsp://admin:admin12345@192.168.6.5/main/av_stream', null, null, null, null, '1', '0', '2', '1', '61894', '1', '1', '25');

-- ----------------------------
-- Table structure for `fr_camera_recognize`
-- ----------------------------
DROP TABLE IF EXISTS `fr_camera_recognize`;
CREATE TABLE `fr_camera_recognize` (
  `id` int(11) NOT NULL COMMENT 'id自增',
  `MatchThresh` float DEFAULT NULL COMMENT '匹配阈值',
  `UnMatchThresh` float DEFAULT NULL COMMENT '不匹配阈值',
  `RecogSumVoteThresh` int(11) DEFAULT NULL,
  `noFaceThresh` int(11) DEFAULT NULL,
  `IOUThresh` float DEFAULT NULL,
  `IOUAutoHThresh` float DEFAULT NULL,
  `IOUAutoLThresh` float DEFAULT NULL,
  `MaxBatchSize` int(11) DEFAULT NULL COMMENT '一次处理的最大批大小',
  `IntervalShow` int(11) DEFAULT NULL COMMENT '显示帧间隔调整系数',
  `MaxObjCoeff` int(11) DEFAULT NULL COMMENT '设置检测人数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of fr_camera_recognize
-- ----------------------------
INSERT INTO `fr_camera_recognize` VALUES ('1', '90', '60', '1', '600', '0.7', '0.5', '0', '2', '25', '5');

-- ----------------------------
-- Table structure for `fr_config`
-- ----------------------------
DROP TABLE IF EXISTS `fr_config`;
CREATE TABLE `fr_config` (
  `id` int(10) NOT NULL COMMENT '配置表',
  `name` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `value` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `account` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '字段说明',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of fr_config
-- ----------------------------
INSERT INTO `fr_config` VALUES ('0', 'WorkingDays', '星期一,星期四,星期二,星期三,星期五', '工作日');
INSERT INTO `fr_config` VALUES ('1', 'NationalHolidays', '2018-05-05,2018-06-05,2018-09-05', '法定假日');
INSERT INTO `fr_config` VALUES ('2', 'ClockIn', '08:30', '上班打卡时间');
INSERT INTO `fr_config` VALUES ('3', 'ClockOff', '17:30', '下班打卡时间');
INSERT INTO `fr_config` VALUES ('4', 'LunchTimeBegin', '11:40', '午休开始时间');
INSERT INTO `fr_config` VALUES ('5', 'LunchTimeEnd', '13:30', '午休结束时间');
INSERT INTO `fr_config` VALUES ('6', 'ClockInExtraTime', '0', '上班打卡宽限时间');
INSERT INTO `fr_config` VALUES ('7', 'ClockOffExtraTime', '0', '下班打卡宽限时间');
INSERT INTO `fr_config` VALUES ('8', 'OffDutyTime', '50', '不在岗时长');
INSERT INTO `fr_config` VALUES ('9', 'OvertimeBegin', '18:00', '加班开始时间');
INSERT INTO `fr_config` VALUES ('10', 'TimeoutClearingSetting', '3', '定期清除过期数据');
INSERT INTO `fr_config` VALUES ('11', 'DisplayContentSetting', '7', 'CS端展示标题头内容ID');
INSERT INTO `fr_config` VALUES ('12', 'SystemInterfaceSetting', '1', 'CS端显示面板ID');
INSERT INTO `fr_config` VALUES ('13', 'DisplayCameraIdSetting', '173', 'CS端显示视频对应摄像头ID');
INSERT INTO `fr_config` VALUES ('14', 'CollectNewResult', '0', '采集新结果标志位：1为CS端产生采集结果，0为BS端采集结果已被加载');
INSERT INTO `fr_config` VALUES ('15', 'ModelBeFinished', '1', '模型完成标志：1为后台服务通知CS端模型完成，0为当前无模型,2为开始注册建模，3为开始更新建模');
INSERT INTO `fr_config` VALUES ('16', 'phase', '0', '0代表进入首次训练模式,1代表增量训练模式（暂时不用）');
INSERT INTO `fr_config` VALUES ('17', 'batch_size', '500', '批处理大小，极其性能不佳时可适当调小');
INSERT INTO `fr_config` VALUES ('18', 'max_to_keep', '3', '最多保存的模型个数');
INSERT INTO `fr_config` VALUES ('19', 'max_nrof_epochs', '50000', 'SOFTMAX迭代上限');
INSERT INTO `fr_config` VALUES ('20', 'PictSavedHttpURL', 'http://127.0.0.1:8866/', '被访问图片的对应的http服务url前缀');
INSERT INTO `fr_config` VALUES ('21', 'PictSaveRootDirectory', 'D:/FaceIdentify/FaceIdentifyFolder-winform/', '被访问图片对应的http服务在本地的根目录');
INSERT INTO `fr_config` VALUES ('22', 'StartOrEnd', '1', '判断CS端是否启动。0为未启动，1为使用中');
INSERT INTO `fr_config` VALUES ('23', 'RegisterNewHttp', 'false', '是否收到http注册建模请求');
INSERT INTO `fr_config` VALUES ('24', 'UpdateNewHttp', 'false', '是否收到http更新建模请求');
INSERT INTO `fr_config` VALUES ('25', 'FaceSampleFoder', 'SamplePhotos', '样本图片存放文件夹');
INSERT INTO `fr_config` VALUES ('26', 'FaceCertificateFoder', 'CertificatePhotos', '证件照存放文件夹');
INSERT INTO `fr_config` VALUES ('27', 'FaceIdentifyFoder', 'RecognizeResultImage', '识别结果存放文件夹');
INSERT INTO `fr_config` VALUES ('28', 'FaceModelFoder', 'ModelFoder', '后台dll模型存放文件夹');
INSERT INTO `fr_config` VALUES ('29', 'FaceFeaturesLibFoder', 'FeaturesLibFoder', '人脸底库存放文件夹');
INSERT INTO `fr_config` VALUES ('30', 'FaceVoiceFoder', 'VoicePlayback', '人员姓名mp3存放文件夹');
INSERT INTO `fr_config` VALUES ('31', 'MorningSoundBeginTime', '06:30', '早上声音播放开始时间');
INSERT INTO `fr_config` VALUES ('32', 'MorningSoundEndTime', '09:00', '早上声音播放结束时间');
INSERT INTO `fr_config` VALUES ('33', 'NightSoundBeginTime', '16:30', '晚上声音播放开始时间');
INSERT INTO `fr_config` VALUES ('34', 'NightSoundEndTime', '23:00', '晚上声音播放结束时间');
INSERT INTO `fr_config` VALUES ('35', 'CurFeaturelibSetting', '1', '提特征所要追加的人脸底库ID');
INSERT INTO `fr_config` VALUES ('36', 'OvertimeEndSecondDay', '06:30', '加班时第二天早上最晚时间');
INSERT INTO `fr_config` VALUES ('37', 'FaceCertificateFaceFoder', 'CertificatePhotosFace', '证件照人脸抠图存放文件夹');
INSERT INTO `fr_config` VALUES ('38', 'FaceContrastFoder', 'ContrastResultImage', '人脸比对结果存放文件夹');

-- ----------------------------
-- Table structure for `fr_cs_panel`
-- ----------------------------
DROP TABLE IF EXISTS `fr_cs_panel`;
CREATE TABLE `fr_cs_panel` (
  `PanelId` int(10) NOT NULL COMMENT 'CS端显示面板ID',
  `PanelName` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'CS端显示面板名称',
  PRIMARY KEY (`PanelId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of fr_cs_panel
-- ----------------------------
INSERT INTO `fr_cs_panel` VALUES ('1', '考勤识别');

-- ----------------------------
-- Table structure for `fr_cs_panel_old`
-- ----------------------------
DROP TABLE IF EXISTS `fr_cs_panel_old`;
CREATE TABLE `fr_cs_panel_old` (
  `PanelId` int(10) NOT NULL COMMENT 'CS端显示面板ID',
  `PanelName` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'CS端显示面板名称',
  PRIMARY KEY (`PanelId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of fr_cs_panel_old
-- ----------------------------
INSERT INTO `fr_cs_panel_old` VALUES ('0', '人脸采集');
INSERT INTO `fr_cs_panel_old` VALUES ('1', '考勤识别');
INSERT INTO `fr_cs_panel_old` VALUES ('2', '欢迎面板');
INSERT INTO `fr_cs_panel_old` VALUES ('3', '人脸比对');

-- ----------------------------
-- Table structure for `fr_cs_services`
-- ----------------------------
DROP TABLE IF EXISTS `fr_cs_services`;
CREATE TABLE `fr_cs_services` (
  `ServiceId` int(10) NOT NULL AUTO_INCREMENT COMMENT 'cs服务ID',
  `ServiceIp` varchar(100) NOT NULL COMMENT 'cs服务设备IP',
  `BeIsCharactered` int(10) NOT NULL DEFAULT '-1' COMMENT '指示是否是提特征设备，1为是，-1就不做处理',
  `ShowCameraID` int(10) NOT NULL COMMENT 'cs服务显示视频的摄像头编号',
  `ShowOnCamID` int(10) NOT NULL COMMENT 'cs服务上班默认显示摄像机编号',
  `ShowOffCamID` int(10) NOT NULL COMMENT 'cs服务下班默认显示摄像机编号',
  UNIQUE KEY `ServiceId` (`ServiceId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of fr_cs_services
-- ----------------------------
INSERT INTO `fr_cs_services` VALUES ('1', '192.168.5.190', '1', '173', '173', '173');
INSERT INTO `fr_cs_services` VALUES ('2', '192.168.5.213', '-1', '170', '170', '170');

-- ----------------------------
-- Table structure for `fr_display_text`
-- ----------------------------
DROP TABLE IF EXISTS `fr_display_text`;
CREATE TABLE `fr_display_text` (
  `ContentId` int(10) NOT NULL AUTO_INCREMENT COMMENT '展示文字ID',
  `DisplayContent` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '展示文字内容',
  PRIMARY KEY (`ContentId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of fr_display_text
-- ----------------------------
INSERT INTO `fr_display_text` VALUES ('1', '航天长峰恭祝大家元旦快乐！');
INSERT INTO `fr_display_text` VALUES ('2', '热烈欢迎公司领导莅临指导！');
INSERT INTO `fr_display_text` VALUES ('3', '欢迎刘博士检查工作！');
INSERT INTO `fr_display_text` VALUES ('4', '人脸识别系统演示');
INSERT INTO `fr_display_text` VALUES ('5', '研发部欢迎您');
INSERT INTO `fr_display_text` VALUES ('6', '航天长峰欢迎您！');
INSERT INTO `fr_display_text` VALUES ('7', '欢迎各位领导莅临参观指导！');

-- ----------------------------
-- Table structure for `fr_error_contrast`
-- ----------------------------
DROP TABLE IF EXISTS `fr_error_contrast`;
CREATE TABLE `fr_error_contrast` (
  `errorCodeID` int(11) NOT NULL COMMENT '错误码编号',
  `errorCodeName` varchar(256) DEFAULT NULL COMMENT '错误码名称',
  `errorCodeAccount` varchar(256) DEFAULT NULL COMMENT '错误码说明',
  PRIMARY KEY (`errorCodeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of fr_error_contrast
-- ----------------------------
INSERT INTO `fr_error_contrast` VALUES ('0', 'ErrorCode_OK', '无错误');
INSERT INTO `fr_error_contrast` VALUES ('1', 'ErrorCode_ErrDecodeType', '解码类型错误');
INSERT INTO `fr_error_contrast` VALUES ('2', 'ErrorCode_ErrInputParam', '视频名为空或参数数量错误');
INSERT INTO `fr_error_contrast` VALUES ('3', 'ErrorCode_ErrInputVideo', '输入视频无法解码');
INSERT INTO `fr_error_contrast` VALUES ('4', 'ErrorCode_ErrDetectModel', '人脸检测模型路径错误或者文件破坏');
INSERT INTO `fr_error_contrast` VALUES ('5', 'ErrorCode_ErrAlignModel', '人脸对齐模型路径错误或者文件破坏');
INSERT INTO `fr_error_contrast` VALUES ('6', 'ErrorCode_ErrExtractModel', '人脸特征提取模型错误或者文件破坏');
INSERT INTO `fr_error_contrast` VALUES ('7', 'ErrorCode_ErrRecogModel', '人脸分类识别模型错误或者文件破坏');
INSERT INTO `fr_error_contrast` VALUES ('8', 'ErrorCode_ErrDrawWindow', '非法选取检测区域');

-- ----------------------------
-- Table structure for `fr_error_contrast_pictdetect`
-- ----------------------------
DROP TABLE IF EXISTS `fr_error_contrast_pictdetect`;
CREATE TABLE `fr_error_contrast_pictdetect` (
  `errorCodeID` int(11) NOT NULL COMMENT '错误码编号',
  `errorCodeName` varchar(256) DEFAULT NULL COMMENT '错误码名称',
  `errorCodeAccount` varchar(256) DEFAULT NULL COMMENT '错误码说明',
  PRIMARY KEY (`errorCodeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of fr_error_contrast_pictdetect
-- ----------------------------
INSERT INTO `fr_error_contrast_pictdetect` VALUES ('0', 'LoadInvalidCode_OK', '无错误');
INSERT INTO `fr_error_contrast_pictdetect` VALUES ('1', 'LoadInvalidCode_ImagePath', '无效路径');
INSERT INTO `fr_error_contrast_pictdetect` VALUES ('2', 'LoadInvalidCode_ImageSuffix', '无效图像格式');
INSERT INTO `fr_error_contrast_pictdetect` VALUES ('3', 'LoadInvalidCode_ImageSize', '图像尺寸不达标');
INSERT INTO `fr_error_contrast_pictdetect` VALUES ('4', 'LoadInvalidCode_FaceProbThresh', '人脸置信度不达标，无法检测到');
INSERT INTO `fr_error_contrast_pictdetect` VALUES ('5', 'LoadInvalidCode_FaceSharpThresh', '两眼间距小或人脸不清晰、完整');

-- ----------------------------
-- Table structure for `fr_error_featurereload`
-- ----------------------------
DROP TABLE IF EXISTS `fr_error_featurereload`;
CREATE TABLE `fr_error_featurereload` (
  `errorCodeID` int(11) NOT NULL COMMENT '错误码编号',
  `errorCodeName` varchar(256) DEFAULT NULL COMMENT '错误码名称',
  `errorCodeAccount` varchar(256) DEFAULT NULL COMMENT '错误码说明',
  PRIMARY KEY (`errorCodeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of fr_error_featurereload
-- ----------------------------

-- ----------------------------
-- Table structure for `fr_error_identify`
-- ----------------------------
DROP TABLE IF EXISTS `fr_error_identify`;
CREATE TABLE `fr_error_identify` (
  `errorCodeID` int(11) NOT NULL COMMENT '错误码编号',
  `errorCodeName` varchar(256) DEFAULT NULL COMMENT '错误码名称',
  `errorCodeAccount` varchar(256) DEFAULT NULL COMMENT '错误码说明',
  PRIMARY KEY (`errorCodeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of fr_error_identify
-- ----------------------------
INSERT INTO `fr_error_identify` VALUES ('0', 'ErrorCode_OK', '无错误');
INSERT INTO `fr_error_identify` VALUES ('1', 'ErrorCode_DecodeType', '解码类型错误');
INSERT INTO `fr_error_identify` VALUES ('2', 'ErrorCode_InputParam', '视频名为空或参数数量错误');
INSERT INTO `fr_error_identify` VALUES ('3', 'ErrorCode_InputVideo', '输入视频无法解码');
INSERT INTO `fr_error_identify` VALUES ('4', 'ErrorCode_DetectModel', '人脸检测模型路径错误或者文件破坏');
INSERT INTO `fr_error_identify` VALUES ('5', 'ErrorCode_LandmarkModel', '人脸关键点提取模型路径错误或者文件破坏');
INSERT INTO `fr_error_identify` VALUES ('6', 'ErrorCode_SelectModel', '人脸对齐模型路径错误或者文件破坏');
INSERT INTO `fr_error_identify` VALUES ('7', 'ErrorCode_DescribeModel', '人脸特征提取模型错误或者文件破坏');
INSERT INTO `fr_error_identify` VALUES ('8', 'ErrorCode_BaseLibrary', '人脸特征底库错误或者文件破坏');
INSERT INTO `fr_error_identify` VALUES ('9', 'ErrorCode_DrawWindow', '非法选取检测区域');
INSERT INTO `fr_error_identify` VALUES ('10', 'ErrorCode_HardWare', '硬件问题，如显卡无法检测');
INSERT INTO `fr_error_identify` VALUES ('11', 'ErrorCode_ProgramRuning', '待修改引擎已被占用');
INSERT INTO `fr_error_identify` VALUES ('12', 'ErrorCode_ModelPath', '传入模型路径为空');
INSERT INTO `fr_error_identify` VALUES ('13', 'ErrorCode_StartParam', '传入识别参数为空');
INSERT INTO `fr_error_identify` VALUES ('14', 'ErrorCode_WidthHeight', '传入窗口宽度或者高度为零');
INSERT INTO `fr_error_identify` VALUES ('15', 'ErrorCode_hWndShow', '传入窗口句柄为空');
INSERT INTO `fr_error_identify` VALUES ('16', 'ErrorCode_ResultPath', '传入识别结果根目录为空');
INSERT INTO `fr_error_identify` VALUES ('17', 'ErrorCode_StopFunc', '传入返回停止信息回调函数为空');
INSERT INTO `fr_error_identify` VALUES ('18', 'ErrorCode_RegisFunc', '传入个人识别信息回调函数为空');
INSERT INTO `fr_error_identify` VALUES ('19', 'ErrorCode_XmlPath', 'XML输入或者输出路径为空');

-- ----------------------------
-- Table structure for `fr_error_pictdetect`
-- ----------------------------
DROP TABLE IF EXISTS `fr_error_pictdetect`;
CREATE TABLE `fr_error_pictdetect` (
  `errorCodeID` int(11) NOT NULL,
  `errorCodeName` varchar(256) DEFAULT NULL,
  `errorCodeAccount` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`errorCodeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of fr_error_pictdetect
-- ----------------------------
INSERT INTO `fr_error_pictdetect` VALUES ('0', 'InvalidCode_OK ', '无错误');
INSERT INTO `fr_error_pictdetect` VALUES ('1', 'InvalidCode_FaceProbThresh', '人脸置信度不达标，无法检测到');
INSERT INTO `fr_error_pictdetect` VALUES ('2', 'InvalidCode_SideFaceThresh', '侧脸严重');
INSERT INTO `fr_error_pictdetect` VALUES ('3', 'InvalidCode_UpFaceThresh', '抬头');
INSERT INTO `fr_error_pictdetect` VALUES ('4', 'InvalidCode_DownFaceThresh', '低头');
INSERT INTO `fr_error_pictdetect` VALUES ('5', 'InvalidCode_EyesDistThresh', '两眼间距');
INSERT INTO `fr_error_pictdetect` VALUES ('6', 'InvalidCode_FaceSharpThresh', '人脸不清晰');
INSERT INTO `fr_error_pictdetect` VALUES ('7', '	InvalidCode_DataError', '数据有问题');

-- ----------------------------
-- Table structure for `fr_error_register`
-- ----------------------------
DROP TABLE IF EXISTS `fr_error_register`;
CREATE TABLE `fr_error_register` (
  `errorCodeID` int(11) NOT NULL COMMENT '错误码编号',
  `errorCodeName` varchar(256) DEFAULT NULL COMMENT '错误码名称',
  `errorCodeAccount` varchar(256) DEFAULT NULL COMMENT '错误码说明',
  PRIMARY KEY (`errorCodeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of fr_error_register
-- ----------------------------

-- ----------------------------
-- Table structure for `fr_featureslib`
-- ----------------------------
DROP TABLE IF EXISTS `fr_featureslib`;
CREATE TABLE `fr_featureslib` (
  `featureID` int(11) NOT NULL COMMENT 'äººè„¸åº•åº“ID',
  `featureName` varchar(256) DEFAULT NULL COMMENT 'äººè„¸åº•åº“åç§°',
  `featureRelativePath` varchar(256) DEFAULT NULL COMMENT 'äººè„¸åº•åº“æ‰€å­˜åœ¨çš„ç›¸å¯¹è·¯å¾„ï¼Œæ ¹ç›®å½•æ˜¯configå¯¹åº”çš„PictSaveRootDirectoryå€¼',
  `bMouse` int(10) DEFAULT NULL,
  `eyesDistThresh` int(10) DEFAULT NULL,
  `DetectThresh` float(10,2) DEFAULT NULL,
  PRIMARY KEY (`featureID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of fr_featureslib
-- ----------------------------
INSERT INTO `fr_featureslib` VALUES ('0', '无底库', '', '1', '30', '0.90');
INSERT INTO `fr_featureslib` VALUES ('1', '航天长峰', 'FeaturesLibFoder/CCF', '1', '30', '0.90');
INSERT INTO `fr_featureslib` VALUES ('2', '外来人员', 'FeaturesLibFoder/External', '1', '30', '0.90');

-- ----------------------------
-- Table structure for `fr_group`
-- ----------------------------
DROP TABLE IF EXISTS `fr_group`;
CREATE TABLE `fr_group` (
  `uid` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一值（无实际意义）',
  `groupid` varchar(30) NOT NULL COMMENT '组ID',
  `groupname` varchar(128) NOT NULL COMMENT '组名',
  `parentgroupid` varchar(30) DEFAULT NULL COMMENT '上级组ID',
  `type` int(11) DEFAULT '1' COMMENT '组类型',
  PRIMARY KEY (`uid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of fr_group
-- ----------------------------
INSERT INTO `fr_group` VALUES ('1', '1', '航天长峰', '-1', '1');

-- ----------------------------
-- Table structure for `fr_metting`
-- ----------------------------
DROP TABLE IF EXISTS `fr_metting`;
CREATE TABLE `fr_metting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `value` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of fr_metting
-- ----------------------------
INSERT INTO `fr_metting` VALUES ('1', '当前会议ID', '1');

-- ----------------------------
-- Table structure for `fr_original_record`
-- ----------------------------
DROP TABLE IF EXISTS `fr_original_record`;
CREATE TABLE `fr_original_record` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '原始记录表：行号',
  `EmployeeId` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '员工号(暂时不用)',
  `CollectId` int(10) DEFAULT NULL COMMENT '采集人员编号（唯一）',
  `similarValue` float(10,5) DEFAULT NULL,
  `Date` datetime DEFAULT NULL COMMENT '识别时间',
  `DetectetFaceImage` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '检测图像名称（工号+时间-face.jpg），相对路径',
  `CurrFrame` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '完整帧图像名称（工号+时间-frame.jpg），相对路径',
  `TaskType` int(10) DEFAULT NULL COMMENT '出入口类型',
  `CamerId` int(10) DEFAULT NULL COMMENT '摄像头ID',
  `BeforeNum` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '校正前员工号',
  `AttendanceLocationID` int(10) DEFAULT NULL COMMENT '考勤地点ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31599 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of fr_original_record
-- ----------------------------
INSERT INTO `fr_original_record` VALUES ('31526', '', '18', '92.39561', '2019-05-27 09:50:52', 'RecognizeResultImage/2019-05-27/18-09-50-52-face.jpg', 'RecognizeResultImage/2019-05-27/18-09-50-52-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31527', '', '43', '90.16718', '2019-05-27 09:51:37', 'RecognizeResultImage/2019-05-27/43-09-51-37-face.jpg', 'RecognizeResultImage/2019-05-27/43-09-51-37-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31528', '', '18', '92.24779', '2019-05-27 09:51:39', 'RecognizeResultImage/2019-05-27/18-09-51-39-face.jpg', 'RecognizeResultImage/2019-05-27/18-09-51-39-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31529', '', '43', '92.39092', '2019-05-27 09:51:43', 'RecognizeResultImage/2019-05-27/43-09-51-43-face.jpg', 'RecognizeResultImage/2019-05-27/43-09-51-43-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31530', '', '18', '91.98221', '2019-05-27 09:51:45', 'RecognizeResultImage/2019-05-27/18-09-51-45-face.jpg', 'RecognizeResultImage/2019-05-27/18-09-51-45-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31531', '', '43', '92.31485', '2019-05-27 09:51:55', 'RecognizeResultImage/2019-05-27/43-09-51-55-face.jpg', 'RecognizeResultImage/2019-05-27/43-09-51-55-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31532', '', '18', '93.60099', '2019-05-27 09:53:11', 'RecognizeResultImage/2019-05-27/18-09-53-11-face.jpg', 'RecognizeResultImage/2019-05-27/18-09-53-11-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31533', '', '445', '94.23452', '2019-05-27 09:53:56', 'RecognizeResultImage/2019-05-27/445-09-53-56-face.jpg', 'RecognizeResultImage/2019-05-27/445-09-53-56-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31534', '', '442', '91.01857', '2019-05-27 09:54:29', 'RecognizeResultImage/2019-05-27/442-09-54-29-face.jpg', 'RecognizeResultImage/2019-05-27/442-09-54-29-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31535', '', '5', '90.56263', '2019-05-27 09:55:05', 'RecognizeResultImage/2019-05-27/5-09-55-05-face.jpg', 'RecognizeResultImage/2019-05-27/5-09-55-05-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31536', '', '42', '90.94098', '2019-05-27 09:55:11', 'RecognizeResultImage/2019-05-27/42-09-55-11-face.jpg', 'RecognizeResultImage/2019-05-27/42-09-55-11-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31537', '', '43', '90.46709', '2019-05-27 09:55:12', 'RecognizeResultImage/2019-05-27/43-09-55-12-face.jpg', 'RecognizeResultImage/2019-05-27/43-09-55-12-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31538', '', '46', '91.62627', '2019-05-27 09:55:13', 'RecognizeResultImage/2019-05-27/46-09-55-13-face.jpg', 'RecognizeResultImage/2019-05-27/46-09-55-13-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31539', '', '2', '90.97224', '2019-05-27 09:55:13', 'RecognizeResultImage/2019-05-27/2-09-55-13-face.jpg', 'RecognizeResultImage/2019-05-27/2-09-55-13-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31540', '', '38', '90.07510', '2019-05-27 09:55:14', 'RecognizeResultImage/2019-05-27/38-09-55-14-face.jpg', 'RecognizeResultImage/2019-05-27/38-09-55-14-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31541', '', '33', '90.16730', '2019-05-27 09:55:14', 'RecognizeResultImage/2019-05-27/33-09-55-14-face.jpg', 'RecognizeResultImage/2019-05-27/33-09-55-14-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31542', '', '5', '91.62814', '2019-05-27 09:55:14', 'RecognizeResultImage/2019-05-27/5-09-55-14-face.jpg', 'RecognizeResultImage/2019-05-27/5-09-55-14-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31543', '', '25', '90.05098', '2019-05-27 09:55:14', 'RecognizeResultImage/2019-05-27/25-09-55-14-face.jpg', 'RecognizeResultImage/2019-05-27/25-09-55-14-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31544', '', '18', '91.05547', '2019-05-27 09:55:14', 'RecognizeResultImage/2019-05-27/18-09-55-14-face.jpg', 'RecognizeResultImage/2019-05-27/18-09-55-14-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31545', '', '14', '91.74721', '2019-05-27 09:55:14', 'RecognizeResultImage/2019-05-27/14-09-55-14-face.jpg', 'RecognizeResultImage/2019-05-27/14-09-55-14-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31546', '', '21', '92.29782', '2019-05-27 09:55:14', 'RecognizeResultImage/2019-05-27/21-09-55-14-face.jpg', 'RecognizeResultImage/2019-05-27/21-09-55-14-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31547', '', '11', '91.29036', '2019-05-27 09:55:14', 'RecognizeResultImage/2019-05-27/11-09-55-14-face.jpg', 'RecognizeResultImage/2019-05-27/11-09-55-14-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31548', '', '10', '92.55141', '2019-05-27 09:55:14', 'RecognizeResultImage/2019-05-27/10-09-55-14-face.jpg', 'RecognizeResultImage/2019-05-27/10-09-55-14-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31549', '', '19', '91.71919', '2019-05-27 09:55:15', 'RecognizeResultImage/2019-05-27/19-09-55-15-face.jpg', 'RecognizeResultImage/2019-05-27/19-09-55-15-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31550', '', '47', '90.72943', '2019-05-27 09:55:15', 'RecognizeResultImage/2019-05-27/47-09-55-15-face.jpg', 'RecognizeResultImage/2019-05-27/47-09-55-15-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31551', '', '29', '90.91601', '2019-05-27 09:55:15', 'RecognizeResultImage/2019-05-27/29-09-55-15-face.jpg', 'RecognizeResultImage/2019-05-27/29-09-55-15-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31552', '', '26', '91.92949', '2019-05-27 09:55:17', 'RecognizeResultImage/2019-05-27/26-09-55-17-face.jpg', 'RecognizeResultImage/2019-05-27/26-09-55-17-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31553', '', '42', '95.64220', '2019-05-27 09:55:17', 'RecognizeResultImage/2019-05-27/42-09-55-17-face.jpg', 'RecognizeResultImage/2019-05-27/42-09-55-17-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31554', '', '43', '93.91560', '2019-05-27 09:55:18', 'RecognizeResultImage/2019-05-27/43-09-55-18-face.jpg', 'RecognizeResultImage/2019-05-27/43-09-55-18-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31555', '', '46', '92.84248', '2019-05-27 09:55:19', 'RecognizeResultImage/2019-05-27/46-09-55-19-face.jpg', 'RecognizeResultImage/2019-05-27/46-09-55-19-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31556', '', '2', '95.04658', '2019-05-27 09:55:19', 'RecognizeResultImage/2019-05-27/2-09-55-19-face.jpg', 'RecognizeResultImage/2019-05-27/2-09-55-19-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31557', '', '33', '94.35922', '2019-05-27 09:55:20', 'RecognizeResultImage/2019-05-27/33-09-55-20-face.jpg', 'RecognizeResultImage/2019-05-27/33-09-55-20-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31558', '', '21', '93.58766', '2019-05-27 09:55:20', 'RecognizeResultImage/2019-05-27/21-09-55-20-face.jpg', 'RecognizeResultImage/2019-05-27/21-09-55-20-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31559', '', '5', '94.92703', '2019-05-27 09:55:20', 'RecognizeResultImage/2019-05-27/5-09-55-20-face.jpg', 'RecognizeResultImage/2019-05-27/5-09-55-20-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31560', '', '10', '93.62794', '2019-05-27 09:55:20', 'RecognizeResultImage/2019-05-27/10-09-55-20-face.jpg', 'RecognizeResultImage/2019-05-27/10-09-55-20-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31561', '', '11', '92.79491', '2019-05-27 09:55:20', 'RecognizeResultImage/2019-05-27/11-09-55-20-face.jpg', 'RecognizeResultImage/2019-05-27/11-09-55-20-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31562', '', '14', '92.45069', '2019-05-27 09:55:20', 'RecognizeResultImage/2019-05-27/14-09-55-20-face.jpg', 'RecognizeResultImage/2019-05-27/14-09-55-20-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31563', '', '19', '92.22623', '2019-05-27 09:55:21', 'RecognizeResultImage/2019-05-27/19-09-55-21-face.jpg', 'RecognizeResultImage/2019-05-27/19-09-55-21-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31564', '', '18', '92.83897', '2019-05-27 09:55:21', 'RecognizeResultImage/2019-05-27/18-09-55-21-face.jpg', 'RecognizeResultImage/2019-05-27/18-09-55-21-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31565', '', '29', '92.06976', '2019-05-27 09:55:21', 'RecognizeResultImage/2019-05-27/29-09-55-21-face.jpg', 'RecognizeResultImage/2019-05-27/29-09-55-21-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31566', '', '25', '90.20431', '2019-05-27 09:55:22', 'RecognizeResultImage/2019-05-27/25-09-55-22-face.jpg', 'RecognizeResultImage/2019-05-27/25-09-55-22-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31567', '', '38', '92.96609', '2019-05-27 09:55:22', 'RecognizeResultImage/2019-05-27/38-09-55-22-face.jpg', 'RecognizeResultImage/2019-05-27/38-09-55-22-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31568', '', '26', '92.00351', '2019-05-27 09:55:23', 'RecognizeResultImage/2019-05-27/26-09-55-23-face.jpg', 'RecognizeResultImage/2019-05-27/26-09-55-23-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31569', '', '42', '94.91904', '2019-05-27 09:55:23', 'RecognizeResultImage/2019-05-27/42-09-55-23-face.jpg', 'RecognizeResultImage/2019-05-27/42-09-55-23-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31570', '', '47', '91.23281', '2019-05-27 09:55:24', 'RecognizeResultImage/2019-05-27/47-09-55-24-face.jpg', 'RecognizeResultImage/2019-05-27/47-09-55-24-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31571', '', '43', '92.76923', '2019-05-27 09:55:24', 'RecognizeResultImage/2019-05-27/43-09-55-24-face.jpg', 'RecognizeResultImage/2019-05-27/43-09-55-24-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31572', '', '46', '93.60860', '2019-05-27 09:55:25', 'RecognizeResultImage/2019-05-27/46-09-55-25-face.jpg', 'RecognizeResultImage/2019-05-27/46-09-55-25-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31573', '', '2', '95.12624', '2019-05-27 09:55:25', 'RecognizeResultImage/2019-05-27/2-09-55-25-face.jpg', 'RecognizeResultImage/2019-05-27/2-09-55-25-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31574', '', '5', '91.85423', '2019-05-27 09:55:26', 'RecognizeResultImage/2019-05-27/5-09-55-26-face.jpg', 'RecognizeResultImage/2019-05-27/5-09-55-26-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31575', '', '14', '90.98151', '2019-05-27 09:55:26', 'RecognizeResultImage/2019-05-27/14-09-55-26-face.jpg', 'RecognizeResultImage/2019-05-27/14-09-55-26-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31576', '', '11', '90.71068', '2019-05-27 09:55:26', 'RecognizeResultImage/2019-05-27/11-09-55-26-face.jpg', 'RecognizeResultImage/2019-05-27/11-09-55-26-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31577', '', '10', '92.24796', '2019-05-27 09:55:26', 'RecognizeResultImage/2019-05-27/10-09-55-26-face.jpg', 'RecognizeResultImage/2019-05-27/10-09-55-26-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31578', '', '19', '92.10066', '2019-05-27 09:55:27', 'RecognizeResultImage/2019-05-27/19-09-55-27-face.jpg', 'RecognizeResultImage/2019-05-27/19-09-55-27-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31579', '', '29', '90.56789', '2019-05-27 09:55:27', 'RecognizeResultImage/2019-05-27/29-09-55-27-face.jpg', 'RecognizeResultImage/2019-05-27/29-09-55-27-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31580', '', '21', '90.67980', '2019-05-27 09:55:27', 'RecognizeResultImage/2019-05-27/21-09-55-27-face.jpg', 'RecognizeResultImage/2019-05-27/21-09-55-27-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31581', '', '18', '91.77403', '2019-05-27 09:55:27', 'RecognizeResultImage/2019-05-27/18-09-55-27-face.jpg', 'RecognizeResultImage/2019-05-27/18-09-55-27-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31582', '', '33', '91.66246', '2019-05-27 09:55:27', 'RecognizeResultImage/2019-05-27/33-09-55-27-face.jpg', 'RecognizeResultImage/2019-05-27/33-09-55-27-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31583', '', '2', '90.96335', '2019-05-27 09:55:31', 'RecognizeResultImage/2019-05-27/2-09-55-31-face.jpg', 'RecognizeResultImage/2019-05-27/2-09-55-31-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31584', '', '43', '90.73865', '2019-05-27 09:55:31', 'RecognizeResultImage/2019-05-27/43-09-55-31-face.jpg', 'RecognizeResultImage/2019-05-27/43-09-55-31-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31585', '', '5', '90.31426', '2019-05-27 09:55:32', 'RecognizeResultImage/2019-05-27/5-09-55-32-face.jpg', 'RecognizeResultImage/2019-05-27/5-09-55-32-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31586', '', '42', '94.20210', '2019-05-27 09:55:32', 'RecognizeResultImage/2019-05-27/42-09-55-32-face.jpg', 'RecognizeResultImage/2019-05-27/42-09-55-32-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31587', '', '38', '90.11279', '2019-05-27 09:55:32', 'RecognizeResultImage/2019-05-27/38-09-55-32-face.jpg', 'RecognizeResultImage/2019-05-27/38-09-55-32-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31588', '', '14', '90.61671', '2019-05-27 09:55:32', 'RecognizeResultImage/2019-05-27/14-09-55-32-face.jpg', 'RecognizeResultImage/2019-05-27/14-09-55-32-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31589', '', '46', '91.64294', '2019-05-27 09:55:32', 'RecognizeResultImage/2019-05-27/46-09-55-32-face.jpg', 'RecognizeResultImage/2019-05-27/46-09-55-32-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31590', '', '19', '91.17025', '2019-05-27 09:55:33', 'RecognizeResultImage/2019-05-27/19-09-55-33-face.jpg', 'RecognizeResultImage/2019-05-27/19-09-55-33-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31591', '', '29', '90.59988', '2019-05-27 09:55:34', 'RecognizeResultImage/2019-05-27/29-09-55-34-face.jpg', 'RecognizeResultImage/2019-05-27/29-09-55-34-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31592', '', '33', '90.06496', '2019-05-27 09:55:35', 'RecognizeResultImage/2019-05-27/33-09-55-35-face.jpg', 'RecognizeResultImage/2019-05-27/33-09-55-35-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31593', '', '11', '91.50103', '2019-05-27 09:55:35', 'RecognizeResultImage/2019-05-27/11-09-55-35-face.jpg', 'RecognizeResultImage/2019-05-27/11-09-55-35-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31594', '', '2', '92.78702', '2019-05-27 09:55:37', 'RecognizeResultImage/2019-05-27/2-09-55-37-face.jpg', 'RecognizeResultImage/2019-05-27/2-09-55-37-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31595', '', '43', '91.80933', '2019-05-27 09:55:37', 'RecognizeResultImage/2019-05-27/43-09-55-37-face.jpg', 'RecognizeResultImage/2019-05-27/43-09-55-37-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31596', '', '5', '92.97961', '2019-05-27 09:55:38', 'RecognizeResultImage/2019-05-27/5-09-55-38-face.jpg', 'RecognizeResultImage/2019-05-27/5-09-55-38-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31597', '', '42', '93.60434', '2019-05-27 09:55:38', 'RecognizeResultImage/2019-05-27/42-09-55-38-face.jpg', 'RecognizeResultImage/2019-05-27/42-09-55-38-frame.jpg', '0', '174', '', '1');
INSERT INTO `fr_original_record` VALUES ('31598', '', '18', '90.24068', '2019-05-27 09:55:38', 'RecognizeResultImage/2019-05-27/18-09-55-38-face.jpg', 'RecognizeResultImage/2019-05-27/18-09-55-38-frame.jpg', '0', '174', '', '1');

-- ----------------------------
-- Table structure for `fr_original_record_contrast`
-- ----------------------------
DROP TABLE IF EXISTS `fr_original_record_contrast`;
CREATE TABLE `fr_original_record_contrast` (
  `id` int(10) NOT NULL COMMENT '原始记录表：行号',
  `CollectId` int(10) DEFAULT NULL COMMENT '采集人员编号（唯一）',
  `EmployeeId` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '员工号(暂时不用)',
  `EmployeeName` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `EmployeePhoto` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `ValidateFlag` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `VeriThresh` float(100,5) DEFAULT NULL,
  `Date` datetime DEFAULT NULL COMMENT '识别时间',
  `CurrFrame` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '完整帧图像名称（工号+时间-frame.jpg），相对路径',
  `DetectetFaceImage` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '检测图像名称（工号+时间-face.jpg），相对路径',
  `CamerId` int(10) DEFAULT NULL COMMENT '摄像头ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of fr_original_record_contrast
-- ----------------------------
INSERT INTO `fr_original_record_contrast` VALUES ('0', '1', '', '单鼎一', 'D:/公司各部门照片/研发部/单鼎一.jpg', 'failed', '0.00000', '2018-06-25 19:44:15', 'RecognizeResultImage/', 'RecognizeResultImage/', '69');
INSERT INTO `fr_original_record_contrast` VALUES ('1', '2', '', '程舰', 'D:/公司各部门照片/研发部/程舰.jpg', 'failed', '0.00000', '2018-06-25 19:44:23', 'RecognizeResultImage/', 'RecognizeResultImage/', '69');
INSERT INTO `fr_original_record_contrast` VALUES ('2', '3', '', '郝文娟', 'D:/公司各部门照片/研发部/郝文娟.jpg', 'success', '93.72137', '2018-06-25 19:45:15', 'RecognizeResultImage/2018-6-25/3-19-45-15-frame.jpg', 'RecognizeResultImage/2018-6-25/3-19-45-15-face.jpg', '69');
INSERT INTO `fr_original_record_contrast` VALUES ('3', '4', '', '单鼎一', 'D:/公司各部门照片/研发部/单鼎一.jpg', 'failed', '0.00000', '2018-06-25 19:45:30', 'RecognizeResultImage/', 'RecognizeResultImage/', '69');
INSERT INTO `fr_original_record_contrast` VALUES ('4', '5', '', '樊龙', 'D:/公司各部门照片/研发部/樊龙.jpg', 'failed', '0.00000', '2018-06-25 19:45:35', 'RecognizeResultImage/', 'RecognizeResultImage/', '69');
INSERT INTO `fr_original_record_contrast` VALUES ('5', '6', '', '郝文娟', 'D:/公司各部门照片/研发部/郝文娟.jpg', 'success', '93.70946', '2018-06-25 19:46:40', 'RecognizeResultImage/2018-6-25/6-19-46-40-frame.jpg', 'RecognizeResultImage/2018-6-25/6-19-46-40-face.jpg', '69');
INSERT INTO `fr_original_record_contrast` VALUES ('6', '7', '', '程舰', 'D:/公司各部门照片/研发部/程舰.jpg', 'failed', '0.00000', '2018-06-25 19:46:50', 'RecognizeResultImage/', 'RecognizeResultImage/', '69');
INSERT INTO `fr_original_record_contrast` VALUES ('7', '8', '', '单鼎一', 'D:/公司各部门照片/研发部/单鼎一.jpg', 'failed', '0.00000', '2018-06-25 19:47:15', 'RecognizeResultImage/', 'RecognizeResultImage/', '69');

-- ----------------------------
-- Table structure for `fr_param_collect`
-- ----------------------------
DROP TABLE IF EXISTS `fr_param_collect`;
CREATE TABLE `fr_param_collect` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '键值',
  `CameraId` int(10) NOT NULL COMMENT '摄像机编号',
  `scale` float(10,2) DEFAULT NULL COMMENT '采样系数',
  `probThresh` float(10,2) DEFAULT NULL COMMENT '人脸判定阈值',
  `distThresh` int(10) DEFAULT NULL COMMENT '人眼间距阈值',
  `sharpnessThresh` int(10) DEFAULT NULL COMMENT '图像清晰度阈值',
  `perDirectNum` int(10) DEFAULT NULL COMMENT '人脸中、左、右、上、下五个方向各采集的张数',
  `rotationThresh` varchar(255) DEFAULT NULL COMMENT '采集时人脸上下左右四个方向转动的阈值，用逗号分割，包括人脸平视时上扬阈值、左偏阈值、右偏阈值、低头阈值，人脸抬头时仰角阈值，人脸左偏时偏角阈值，人脸右偏时偏角阈值，人脸低头时仰角阈值',
  `roiInfo` varchar(100) DEFAULT NULL COMMENT '人脸采集区域x、y、w、h信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of fr_param_collect
-- ----------------------------
INSERT INTO `fr_param_collect` VALUES ('25', '118', '6.00', '0.70', '60', '0', '5', '-3,-11,11,7,-8,-30,30,15', null);
INSERT INTO `fr_param_collect` VALUES ('44', '137', '6.00', '0.70', '60', '0', '5', '-3,-11,11,7,-8,-30,30,15', null);
INSERT INTO `fr_param_collect` VALUES ('45', '138', '6.00', '0.70', '60', '0', '5', '-3,-11,11,7,-8,-30,30,15', null);
INSERT INTO `fr_param_collect` VALUES ('46', '139', '6.00', '0.70', '60', '0', '5', '-3,-11,11,7,-8,-30,30,15', null);
INSERT INTO `fr_param_collect` VALUES ('47', '140', '6.00', '0.70', '60', '0', '5', '-3,-11,11,7,-8,-30,30,15', null);
INSERT INTO `fr_param_collect` VALUES ('48', '141', '6.00', '0.70', '60', '0', '5', '-3,-11,11,7,-8,-30,30,15', null);
INSERT INTO `fr_param_collect` VALUES ('49', '142', '6.00', '0.70', '60', '0', '5', '-3,-11,11,7,-8,-30,30,15', null);
INSERT INTO `fr_param_collect` VALUES ('50', '144', '6.00', '0.70', '60', '0', '5', '-3,-11,11,7,-8,-30,30,15', null);
INSERT INTO `fr_param_collect` VALUES ('59', '153', '6.00', '0.70', '60', '0', '5', '-3,-11,11,7,-8,-30,30,15', null);
INSERT INTO `fr_param_collect` VALUES ('61', '161', '6.00', '0.70', '60', '0', '5', '-3,-11,11,7,-8,-30,30,15', null);
INSERT INTO `fr_param_collect` VALUES ('62', '162', '6.00', '0.70', '60', '0', '5', '-3,-11,11,7,-8,-30,30,15', null);
INSERT INTO `fr_param_collect` VALUES ('69', '169', '6.00', '0.70', '60', '0', '5', '-3,-11,11,7,-8,-30,30,15', null);
INSERT INTO `fr_param_collect` VALUES ('71', '171', '6.00', '0.70', '60', '0', '5', '-3,-11,11,7,-8,-30,30,15', null);
INSERT INTO `fr_param_collect` VALUES ('72', '172', '6.00', '0.70', '60', '0', '5', '-3,-11,11,7,-8,-30,30,15', null);
INSERT INTO `fr_param_collect` VALUES ('73', '173', '6.00', '0.70', '60', '0', '5', '-3,-11,11,7,-8,-30,30,15', null);
INSERT INTO `fr_param_collect` VALUES ('74', '174', '6.00', '0.70', '60', '0', '5', '-3,-11,11,7,-8,-30,30,15', null);

-- ----------------------------
-- Table structure for `fr_param_identify`
-- ----------------------------
DROP TABLE IF EXISTS `fr_param_identify`;
CREATE TABLE `fr_param_identify` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '键值',
  `CameraId` int(10) NOT NULL COMMENT '摄像机编号',
  `recognisePath` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '识别到的人脸图像的保存路径，config中PictSaveRootDirectory是根目录，此处只是保存文件夹名称',
  `modelType` int(10) NOT NULL COMMENT '需要使用的模型类型，0为softmax分类，1为欧氏距离识别',
  `bMouse` int(10) DEFAULT NULL COMMENT 'bUseRecogRoi，是否让用户用鼠标设置识别区域，1表示允许，0表示禁止。画框完成之后点击空格键表示确认设置',
  `skipFrame` int(10) DEFAULT NULL COMMENT '是否跳帧，1表示不跳帧，2表示只保留一半的视频帧',
  `DetectType` int(10) DEFAULT NULL COMMENT '人脸检测方式，0为MTCNN检测人脸',
  `scale` float(10,2) DEFAULT NULL COMMENT '图像缩放倍数',
  `faceProbThresh` float(10,2) DEFAULT NULL COMMENT '人脸检测的置信度阈值',
  `SelectType` int(10) DEFAULT NULL COMMENT '人脸筛选方式，1为dlib68点判断角度',
  `eyesDistThresh` int(10) DEFAULT NULL COMMENT '人双眼间距离阈值',
  `AlignType` int(10) DEFAULT NULL COMMENT '人脸对齐方式，0为仿射变换对齐',
  `DescriberType` int(10) DEFAULT NULL COMMENT '特征提取方式，0为FaceNet模型提取',
  `maxFrameCache` int(10) DEFAULT NULL COMMENT '单人脸识别任务最大帧缓存数目',
  `maxFrameBatch` int(10) DEFAULT NULL COMMENT '单路识别任务内部解码时允许的最大单视频帧batch帧缓存数目',
  `sideFaceThresh` float(10,2) DEFAULT NULL COMMENT '允许的人最大侧脸阈值',
  `upFaceThresh` float(10,2) DEFAULT NULL COMMENT '允许的人最大抬头阈值',
  `downFaceThresh` float(10,2) DEFAULT NULL COMMENT '允许的人最大低头阈值',
  `faceSharpThresh` int(10) DEFAULT NULL COMMENT '人脸图像清晰度阈值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of fr_param_identify
-- ----------------------------
INSERT INTO `fr_param_identify` VALUES ('74', '118', 'RecognizeResultImage', '2', '0', '1', '0', '6.00', '0.90', '0', '30', '1', '2', '100', '3', '0.30', '0.75', '0.30', '0');
INSERT INTO `fr_param_identify` VALUES ('93', '137', 'RecognizeResultImage', '2', '0', '1', '0', '6.00', '0.90', '0', '30', '1', '2', '100', '3', '0.30', '0.75', '0.30', '0');
INSERT INTO `fr_param_identify` VALUES ('94', '138', 'RecognizeResultImage', '2', '0', '1', '0', '6.00', '0.90', '0', '30', '1', '2', '100', '3', '0.30', '0.75', '0.30', '0');
INSERT INTO `fr_param_identify` VALUES ('95', '139', 'RecognizeResultImage', '2', '0', '1', '0', '6.00', '0.90', '0', '30', '1', '2', '100', '3', '0.30', '0.75', '0.30', '0');
INSERT INTO `fr_param_identify` VALUES ('96', '140', 'RecognizeResultImage', '2', '0', '1', '0', '6.00', '0.90', '0', '30', '1', '2', '100', '3', '0.30', '0.75', '0.30', '0');
INSERT INTO `fr_param_identify` VALUES ('97', '141', 'RecognizeResultImage', '2', '0', '1', '0', '6.00', '0.90', '0', '30', '1', '2', '100', '3', '0.30', '0.75', '0.30', '0');
INSERT INTO `fr_param_identify` VALUES ('98', '142', 'RecognizeResultImage', '2', '0', '1', '0', '6.00', '0.90', '0', '30', '1', '2', '100', '3', '0.30', '0.75', '0.30', '0');
INSERT INTO `fr_param_identify` VALUES ('99', '144', 'RecognizeResultImage', '2', '0', '1', '0', '6.00', '0.90', '0', '30', '1', '2', '100', '3', '0.30', '0.75', '0.30', '0');
INSERT INTO `fr_param_identify` VALUES ('108', '153', 'RecognizeResultImage', '2', '0', '1', '0', '6.00', '0.90', '0', '30', '1', '2', '100', '3', '0.30', '0.75', '0.30', '0');
INSERT INTO `fr_param_identify` VALUES ('110', '161', 'RecognizeResultImage', '2', '0', '1', '0', '6.00', '0.90', '0', '30', '1', '2', '100', '3', '0.30', '0.75', '0.30', '0');
INSERT INTO `fr_param_identify` VALUES ('111', '162', 'RecognizeResultImage', '2', '0', '1', '0', '6.00', '0.90', '0', '30', '1', '2', '100', '3', '0.30', '0.75', '0.30', '0');
INSERT INTO `fr_param_identify` VALUES ('118', '169', 'RecognizeResultImage', '2', '0', '1', '0', '6.00', '0.90', '0', '30', '1', '2', '100', '3', '0.30', '0.75', '0.30', '0');
INSERT INTO `fr_param_identify` VALUES ('120', '171', 'RecognizeResultImage', '2', '0', '1', '0', '6.00', '0.90', '0', '30', '1', '2', '100', '3', '0.30', '0.75', '0.30', '0');
INSERT INTO `fr_param_identify` VALUES ('121', '172', 'RecognizeResultImage', '2', '0', '1', '0', '6.00', '0.90', '0', '30', '1', '2', '100', '3', '0.30', '0.75', '0.30', '0');
INSERT INTO `fr_param_identify` VALUES ('122', '173', 'RecognizeResultImage', '2', '0', '1', '0', '6.00', '0.90', '0', '30', '1', '2', '100', '3', '0.30', '0.75', '0.30', '0');
INSERT INTO `fr_param_identify` VALUES ('123', '174', 'RecognizeResultImage', '2', '0', '1', '0', '6.00', '0.90', '0', '30', '1', '2', '100', '3', '0.30', '0.75', '0.30', '0');

-- ----------------------------
-- Table structure for `fr_param_identify_contrast`
-- ----------------------------
DROP TABLE IF EXISTS `fr_param_identify_contrast`;
CREATE TABLE `fr_param_identify_contrast` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '键值',
  `cameraId` int(10) NOT NULL COMMENT '摄像机编号',
  `bMouse` int(10) DEFAULT NULL COMMENT 'bUseRecogRoi，是否让用户用鼠标设置识别区域，1表示允许，0表示禁止。画框完成之后点击空格键表示确认设置',
  `skipFrame` int(10) DEFAULT NULL COMMENT '是否跳帧，1表示不跳帧，2表示只保留一半的视频帧',
  `detectType` int(10) DEFAULT NULL COMMENT '人脸检测方式，0为MTCNN检测人脸',
  `scale` float(10,2) DEFAULT NULL COMMENT '图像缩放倍数',
  `faceProbThresh` float(10,2) DEFAULT NULL COMMENT '人脸检测的置信度阈值',
  `selectType` int(10) DEFAULT NULL COMMENT '人脸筛选方式，1为dlib68点判断角度',
  `eyesDistThresh` float(10,2) DEFAULT NULL COMMENT '人双眼间距离阈值',
  `alignType` int(10) DEFAULT NULL COMMENT '人脸对齐方式，1为deepInsight对齐',
  `describerType` int(10) DEFAULT NULL COMMENT '特征提取方式，2为MXNet模型提取',
  `maxFrameCache` int(10) DEFAULT NULL COMMENT '单人脸识别任务最大帧缓存数目',
  `maxFrameBatch` int(10) DEFAULT NULL COMMENT '单路识别任务内部解码时允许的最大单视频帧batch帧缓存数目',
  `veriThresh` float(10,2) DEFAULT NULL COMMENT '人脸验证置信度阈值',
  `accFrames` int(10) DEFAULT NULL COMMENT '连续通过验证的帧数阈值',
  `prob` float(10,2) DEFAULT NULL COMMENT '连续帧中大于阈值的帧数比例',
  `sumFrames` int(10) DEFAULT NULL COMMENT '运行验证的总帧数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of fr_param_identify_contrast
-- ----------------------------
INSERT INTO `fr_param_identify_contrast` VALUES ('49', '118', '0', '1', '0', '6.00', '0.90', '0', '30.00', '1', '2', '100', '3', '90.00', '10', '0.80', '250');
INSERT INTO `fr_param_identify_contrast` VALUES ('68', '137', '0', '1', '0', '6.00', '0.90', '0', '30.00', '1', '2', '100', '3', '90.00', '10', '0.80', '250');
INSERT INTO `fr_param_identify_contrast` VALUES ('69', '138', '0', '1', '0', '6.00', '0.90', '0', '30.00', '1', '2', '100', '3', '90.00', '10', '0.80', '250');
INSERT INTO `fr_param_identify_contrast` VALUES ('70', '139', '0', '1', '0', '6.00', '0.90', '0', '30.00', '1', '2', '100', '3', '90.00', '10', '0.80', '250');
INSERT INTO `fr_param_identify_contrast` VALUES ('71', '140', '0', '1', '0', '6.00', '0.90', '0', '30.00', '1', '2', '100', '3', '90.00', '10', '0.80', '250');
INSERT INTO `fr_param_identify_contrast` VALUES ('72', '141', '0', '1', '0', '6.00', '0.90', '0', '30.00', '1', '2', '100', '3', '90.00', '10', '0.80', '250');
INSERT INTO `fr_param_identify_contrast` VALUES ('73', '142', '0', '1', '0', '6.00', '0.90', '0', '30.00', '1', '2', '100', '3', '90.00', '10', '0.80', '250');
INSERT INTO `fr_param_identify_contrast` VALUES ('74', '144', '0', '1', '0', '6.00', '0.90', '0', '30.00', '1', '2', '100', '3', '90.00', '10', '0.80', '250');
INSERT INTO `fr_param_identify_contrast` VALUES ('83', '153', '0', '1', '0', '6.00', '0.90', '0', '30.00', '1', '2', '100', '3', '90.00', '10', '0.80', '250');
INSERT INTO `fr_param_identify_contrast` VALUES ('85', '161', '0', '1', '0', '6.00', '0.90', '0', '30.00', '1', '2', '100', '3', '90.00', '10', '0.80', '250');
INSERT INTO `fr_param_identify_contrast` VALUES ('86', '162', '0', '1', '0', '6.00', '0.90', '0', '30.00', '1', '2', '100', '3', '90.00', '10', '0.80', '250');
INSERT INTO `fr_param_identify_contrast` VALUES ('93', '169', '0', '1', '0', '6.00', '0.90', '0', '30.00', '1', '2', '100', '3', '90.00', '10', '0.80', '250');
INSERT INTO `fr_param_identify_contrast` VALUES ('95', '171', '0', '1', '0', '6.00', '0.90', '0', '30.00', '1', '2', '100', '3', '90.00', '10', '0.80', '250');
INSERT INTO `fr_param_identify_contrast` VALUES ('96', '172', '0', '1', '0', '6.00', '0.90', '0', '30.00', '1', '2', '100', '3', '90.00', '10', '0.80', '250');
INSERT INTO `fr_param_identify_contrast` VALUES ('97', '173', '0', '1', '0', '6.00', '0.90', '0', '30.00', '1', '2', '100', '3', '90.00', '10', '0.80', '250');
INSERT INTO `fr_param_identify_contrast` VALUES ('98', '174', '0', '1', '0', '6.00', '0.90', '0', '30.00', '1', '2', '100', '3', '90.00', '10', '0.80', '250');

-- ----------------------------
-- Table structure for `fr_param_model_deepinsight`
-- ----------------------------
DROP TABLE IF EXISTS `fr_param_model_deepinsight`;
CREATE TABLE `fr_param_model_deepinsight` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '键值',
  `CameraId` int(10) NOT NULL COMMENT '摄像机编号',
  `modelType` int(10) DEFAULT NULL COMMENT '模型类别，0为softmax分类，1为欧氏距离分类，2为512维欧氏距离识别',
  `modelPath` varchar(100) DEFAULT NULL COMMENT '模型的存放路径，config中PictSaveRootDirectory是根目录，此处只是保存文件夹名称',
  `matchThresh` float(10,2) DEFAULT NULL COMMENT '单张图像匹配时的欧氏距离阈值',
  `unMatchThresh` float(10,2) DEFAULT NULL COMMENT '单张图像不匹配时的欧氏距离阈值',
  `IOUThresh` float(10,2) DEFAULT NULL COMMENT '单张图像匹配时的IOU阈值',
  `recogSumVoteThresh` int(10) DEFAULT NULL COMMENT '单个行人被识别出时的累计投票次数阈值',
  `maxListLength` int(10) DEFAULT NULL COMMENT '单个行人目标的存储的特征list的长度上限',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fr_param_model_deepinsight
-- ----------------------------
INSERT INTO `fr_param_model_deepinsight` VALUES ('50', '11', '2', 'ModelSoftMax/DeepInsight', '0.86', '1.08', '0.50', '5', '50');
INSERT INTO `fr_param_model_deepinsight` VALUES ('51', '118', '2', 'ModelSoftMax/DeepInsight', '0.57', '0.46', '0.50', '5', '50');
INSERT INTO `fr_param_model_deepinsight` VALUES ('70', '137', '2', 'ModelSoftMax/DeepInsight', '0.57', '0.46', '0.50', '5', '50');
INSERT INTO `fr_param_model_deepinsight` VALUES ('71', '138', '2', 'ModelSoftMax/DeepInsight', '0.57', '0.46', '0.50', '5', '50');
INSERT INTO `fr_param_model_deepinsight` VALUES ('72', '139', '2', 'ModelSoftMax/DeepInsight', '0.57', '0.46', '0.50', '5', '50');
INSERT INTO `fr_param_model_deepinsight` VALUES ('73', '140', '2', 'ModelSoftMax/DeepInsight', '0.57', '0.46', '0.50', '5', '50');
INSERT INTO `fr_param_model_deepinsight` VALUES ('74', '141', '2', 'ModelSoftMax/DeepInsight', '0.57', '0.46', '0.50', '5', '50');
INSERT INTO `fr_param_model_deepinsight` VALUES ('75', '142', '2', 'ModelSoftMax/DeepInsight', '0.57', '0.46', '0.50', '5', '50');
INSERT INTO `fr_param_model_deepinsight` VALUES ('76', '144', '2', 'ModelSoftMax/DeepInsight', '0.57', '0.46', '0.50', '5', '50');
INSERT INTO `fr_param_model_deepinsight` VALUES ('85', '153', '2', 'ModelSoftMax/DeepInsight', '0.57', '0.46', '0.50', '5', '50');
INSERT INTO `fr_param_model_deepinsight` VALUES ('87', '161', '2', 'ModelSoftMax/DeepInsight', '0.57', '0.46', '0.50', '5', '50');
INSERT INTO `fr_param_model_deepinsight` VALUES ('88', '162', '2', 'ModelSoftMax/DeepInsight', '0.57', '0.46', '0.50', '5', '50');
INSERT INTO `fr_param_model_deepinsight` VALUES ('95', '169', '2', 'ModelSoftMax/DeepInsight', '0.57', '0.46', '0.50', '5', '50');
INSERT INTO `fr_param_model_deepinsight` VALUES ('97', '171', '2', 'ModelSoftMax/DeepInsight', '0.57', '0.46', '0.50', '5', '50');
INSERT INTO `fr_param_model_deepinsight` VALUES ('98', '172', '2', 'ModelSoftMax/DeepInsight', '0.57', '0.46', '0.50', '5', '50');
INSERT INTO `fr_param_model_deepinsight` VALUES ('99', '173', '2', 'ModelSoftMax/DeepInsight', '0.57', '0.46', '0.50', '5', '50');
INSERT INTO `fr_param_model_deepinsight` VALUES ('100', '174', '2', 'ModelSoftMax/DeepInsight', '0.57', '0.46', '0.50', '5', '50');

-- ----------------------------
-- Table structure for `fr_param_model_edulian`
-- ----------------------------
DROP TABLE IF EXISTS `fr_param_model_edulian`;
CREATE TABLE `fr_param_model_edulian` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '键值',
  `CameraId` int(10) NOT NULL COMMENT '摄像机编号',
  `modelType` int(10) DEFAULT NULL COMMENT '模型类别，0为softmax分类，1为欧氏距离分类，2为512维欧氏距离识别',
  `modelPath` varchar(100) DEFAULT NULL COMMENT '模型的存放路径，config中PictSaveRootDirectory是根目录，此处只是保存文件夹名称',
  `matchThresh` float(10,2) DEFAULT NULL COMMENT '单张图像匹配时的欧氏距离阈值',
  `unMatchThresh` float(10,2) DEFAULT NULL COMMENT '单张图像不匹配时的欧氏距离阈值',
  `IOUThresh` float(10,2) DEFAULT NULL COMMENT '单张图像匹配时的IOU阈值',
  `recogSumVoteThresh` int(10) DEFAULT NULL COMMENT '单个行人被识别出时的累计投票次数阈值',
  `maxListLength` int(10) DEFAULT NULL COMMENT '单个行人目标的存储的特征list的长度上限',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fr_param_model_edulian
-- ----------------------------
INSERT INTO `fr_param_model_edulian` VALUES ('63', '118', '1', 'ModelSoftMax/Edulian', '0.40', '0.50', '0.50', '3', '50');
INSERT INTO `fr_param_model_edulian` VALUES ('82', '137', '1', 'ModelSoftMax/Edulian', '0.40', '0.50', '0.50', '3', '50');
INSERT INTO `fr_param_model_edulian` VALUES ('83', '138', '1', 'ModelSoftMax/Edulian', '0.40', '0.50', '0.50', '3', '50');
INSERT INTO `fr_param_model_edulian` VALUES ('84', '139', '1', 'ModelSoftMax/Edulian', '0.40', '0.50', '0.50', '3', '50');
INSERT INTO `fr_param_model_edulian` VALUES ('85', '140', '1', 'ModelSoftMax/Edulian', '0.40', '0.50', '0.50', '3', '50');
INSERT INTO `fr_param_model_edulian` VALUES ('86', '141', '1', 'ModelSoftMax/Edulian', '0.40', '0.50', '0.50', '3', '50');
INSERT INTO `fr_param_model_edulian` VALUES ('87', '142', '1', 'ModelSoftMax/Edulian', '0.40', '0.50', '0.50', '3', '50');
INSERT INTO `fr_param_model_edulian` VALUES ('88', '144', '1', 'ModelSoftMax/Edulian', '0.40', '0.50', '0.50', '3', '50');
INSERT INTO `fr_param_model_edulian` VALUES ('97', '153', '1', 'ModelSoftMax/Edulian', '0.40', '0.50', '0.50', '3', '50');
INSERT INTO `fr_param_model_edulian` VALUES ('99', '161', '1', 'ModelSoftMax/Edulian', '0.40', '0.50', '0.50', '3', '50');
INSERT INTO `fr_param_model_edulian` VALUES ('100', '162', '1', 'ModelSoftMax/Edulian', '0.40', '0.50', '0.50', '3', '50');
INSERT INTO `fr_param_model_edulian` VALUES ('107', '169', '1', 'ModelSoftMax/Edulian', '0.40', '0.50', '0.50', '3', '50');
INSERT INTO `fr_param_model_edulian` VALUES ('109', '171', '1', 'ModelSoftMax/Edulian', '0.40', '0.50', '0.50', '3', '50');
INSERT INTO `fr_param_model_edulian` VALUES ('110', '172', '1', 'ModelSoftMax/Edulian', '0.40', '0.50', '0.50', '3', '50');
INSERT INTO `fr_param_model_edulian` VALUES ('111', '173', '1', 'ModelSoftMax/Edulian', '0.40', '0.50', '0.50', '3', '50');
INSERT INTO `fr_param_model_edulian` VALUES ('112', '174', '1', 'ModelSoftMax/Edulian', '0.40', '0.50', '0.50', '3', '50');

-- ----------------------------
-- Table structure for `fr_param_model_softmax`
-- ----------------------------
DROP TABLE IF EXISTS `fr_param_model_softmax`;
CREATE TABLE `fr_param_model_softmax` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '键值',
  `CameraId` int(10) NOT NULL COMMENT '摄像机编号',
  `modelType` int(10) DEFAULT NULL COMMENT '模型类别，0为softmax分类，1为欧氏距离分类，2为512维欧氏距离识别',
  `modelPath` varchar(100) DEFAULT NULL COMMENT '模型的存放路径，config中PictSaveRootDirectory是根目录，此处只是保存文件夹名称',
  `fRecogPossibleThresh` float(10,2) DEFAULT NULL COMMENT '单幅图像分类结果置信度阈值',
  `fRecogSumVoteThreash` float(10,2) DEFAULT NULL COMMENT '单个行人识别出时的累计阈值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fr_param_model_softmax
-- ----------------------------
INSERT INTO `fr_param_model_softmax` VALUES ('63', '118', '0', 'ModelSoftMax/Softmax', '0.70', '2.00');
INSERT INTO `fr_param_model_softmax` VALUES ('82', '137', '0', 'ModelSoftMax/Softmax', '0.70', '2.00');
INSERT INTO `fr_param_model_softmax` VALUES ('83', '138', '0', 'ModelSoftMax/Softmax', '0.70', '2.00');
INSERT INTO `fr_param_model_softmax` VALUES ('84', '139', '0', 'ModelSoftMax/Softmax', '0.70', '2.00');
INSERT INTO `fr_param_model_softmax` VALUES ('85', '140', '0', 'ModelSoftMax/Softmax', '0.70', '2.00');
INSERT INTO `fr_param_model_softmax` VALUES ('86', '141', '0', 'ModelSoftMax/Softmax', '0.70', '2.00');
INSERT INTO `fr_param_model_softmax` VALUES ('87', '142', '0', 'ModelSoftMax/Softmax', '0.70', '2.00');
INSERT INTO `fr_param_model_softmax` VALUES ('88', '144', '0', 'ModelSoftMax/Softmax', '0.70', '2.00');
INSERT INTO `fr_param_model_softmax` VALUES ('97', '153', '0', 'ModelSoftMax/Softmax', '0.70', '2.00');
INSERT INTO `fr_param_model_softmax` VALUES ('99', '161', '0', 'ModelSoftMax/Softmax', '0.70', '2.00');
INSERT INTO `fr_param_model_softmax` VALUES ('100', '162', '0', 'ModelSoftMax/Softmax', '0.70', '2.00');
INSERT INTO `fr_param_model_softmax` VALUES ('107', '169', '0', 'ModelSoftMax/Softmax', '0.70', '2.00');
INSERT INTO `fr_param_model_softmax` VALUES ('109', '171', '0', 'ModelSoftMax/Softmax', '0.70', '2.00');
INSERT INTO `fr_param_model_softmax` VALUES ('110', '172', '0', 'ModelSoftMax/Softmax', '0.70', '2.00');
INSERT INTO `fr_param_model_softmax` VALUES ('111', '173', '0', 'ModelSoftMax/Softmax', '0.70', '2.00');
INSERT INTO `fr_param_model_softmax` VALUES ('112', '174', '0', 'ModelSoftMax/Softmax', '0.70', '2.00');

-- ----------------------------
-- Table structure for `fr_param_register`
-- ----------------------------
DROP TABLE IF EXISTS `fr_param_register`;
CREATE TABLE `fr_param_register` (
  `id` int(11) NOT NULL COMMENT 'id自增',
  `MatchThresh` float DEFAULT NULL COMMENT '匹配阈值',
  `UnMatchThresh` float DEFAULT NULL COMMENT '不匹配阈值',
  `RecogSumVoteThresh` int(11) DEFAULT NULL,
  `noFaceThresh` int(11) DEFAULT NULL,
  `IOUThresh` float DEFAULT NULL,
  `IOUAutoHThresh` float DEFAULT NULL,
  `IOUAutoLThresh` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of fr_param_register
-- ----------------------------
INSERT INTO `fr_param_register` VALUES ('1', '90', '60', '10', '600', '0.7', '0.5', '0');

-- ----------------------------
-- Table structure for `fr_sample_photo`
-- ----------------------------
DROP TABLE IF EXISTS `fr_sample_photo`;
CREATE TABLE `fr_sample_photo` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '样本照片表：行号',
  `CollectId` int(10) DEFAULT NULL COMMENT '采集序号',
  `RelativePath` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '采集图像名称，相对路径',
  `UsedToUpdate` int(10) DEFAULT NULL COMMENT '模型是否更新：0采集照片，1识别照片或校正模型照片',
  `SelectedFlag` int(10) DEFAULT NULL COMMENT '标记是否选中：0未选中，1选中',
  `BeIsRegistered` int(10) DEFAULT NULL COMMENT '通过上传照片方式来判断是否注册上：0为未注册上，1为注册上',
  `FailReasons` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `CollectId` (`CollectId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=771 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of fr_sample_photo
-- ----------------------------
INSERT INTO `fr_sample_photo` VALUES ('1', '1', 'SamplePhotos/54/1.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('2', '2', 'SamplePhotos/54/2.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('3', '3', 'SamplePhotos/54/3.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('5', '5', 'SamplePhotos/54/5.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('6', '6', 'SamplePhotos/54/6.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('7', '7', 'SamplePhotos/54/7.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('8', '8', 'SamplePhotos/35/8.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('9', '9', 'SamplePhotos/35/9.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('10', '10', 'SamplePhotos/35/10.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('11', '11', 'SamplePhotos/35/11.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('12', '12', 'SamplePhotos/35/12.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('13', '13', 'SamplePhotos/35/13.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('14', '14', 'SamplePhotos/35/14.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('15', '15', 'SamplePhotos/35/15.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('16', '16', 'SamplePhotos/35/16.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('17', '17', 'SamplePhotos/35/17.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('18', '18', 'SamplePhotos/35/18.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('19', '19', 'SamplePhotos/55/19.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('20', '20', 'SamplePhotos/35/20.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('21', '21', 'SamplePhotos/35/21.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('23', '23', 'SamplePhotos/35/23.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('24', '24', 'SamplePhotos/35/24.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('25', '25', 'SamplePhotos/35/25.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('26', '26', 'SamplePhotos/35/26.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('27', '27', 'SamplePhotos/54/27.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('28', '28', 'SamplePhotos/35/28.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('29', '29', 'SamplePhotos/35/29.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('30', '30', 'SamplePhotos/35/30.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('31', '31', 'SamplePhotos/35/31.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('32', '32', 'SamplePhotos/35/32.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('33', '33', 'SamplePhotos/35/33.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('34', '34', 'SamplePhotos/35/34.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('35', '35', 'SamplePhotos/35/35.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('36', '36', 'SamplePhotos/35/36.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('37', '37', 'SamplePhotos/35/37.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('38', '38', 'SamplePhotos/35/38.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('39', '39', 'SamplePhotos/63/39.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('40', '40', 'SamplePhotos/35/40.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('42', '42', 'SamplePhotos/35/42.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('43', '43', 'SamplePhotos/35/43.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('44', '44', 'SamplePhotos/35/44.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('45', '45', 'SamplePhotos/35/45.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('46', '46', 'SamplePhotos/48/46.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('47', '47', 'SamplePhotos/48/47.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('48', '48', 'SamplePhotos/48/48.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('49', '49', 'SamplePhotos/48/49.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('50', '50', 'SamplePhotos/48/50.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('51', '51', 'SamplePhotos/48/51.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('52', '52', 'SamplePhotos/48/52.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('53', '53', 'SamplePhotos/48/53.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('54', '54', 'SamplePhotos/51/54.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('55', '55', 'SamplePhotos/47/55.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('56', '56', 'SamplePhotos/51/56.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('57', '57', 'SamplePhotos/51/57.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('58', '58', 'SamplePhotos/59/58.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('59', '59', 'SamplePhotos/51/59.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('60', '60', 'SamplePhotos/51/60.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('61', '61', 'SamplePhotos/51/61.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('62', '62', 'SamplePhotos/51/62.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('63', '63', 'SamplePhotos/68/63.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('64', '64', 'SamplePhotos/59/64.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('65', '65', 'SamplePhotos/61/65.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('66', '66', 'SamplePhotos/59/66.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('67', '67', 'SamplePhotos/52/67.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('68', '68', 'SamplePhotos/69/68.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('70', '70', 'SamplePhotos/57/70.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('71', '71', 'SamplePhotos/70/71.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('72', '72', 'SamplePhotos/38/72.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('73', '73', 'SamplePhotos/59/73.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('74', '74', 'SamplePhotos/58/74.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('75', '75', 'SamplePhotos/68/75.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('76', '76', 'SamplePhotos/63/76.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('77', '77', 'SamplePhotos/59/77.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('78', '78', 'SamplePhotos/59/78.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('79', '79', 'SamplePhotos/52/79.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('80', '80', 'SamplePhotos/72/80.jpg', null, null, '0', '两眼间距');
INSERT INTO `fr_sample_photo` VALUES ('81', '81', 'SamplePhotos/59/81.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('82', '82', 'SamplePhotos/58/82.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('83', '83', 'SamplePhotos/52/83.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('84', '84', 'SamplePhotos/63/84.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('85', '85', 'SamplePhotos/38/85.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('86', '86', 'SamplePhotos/71/86.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('87', '87', 'SamplePhotos/52/87.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('88', '88', 'SamplePhotos/57/88.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('89', '89', 'SamplePhotos/69/89.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('90', '90', 'SamplePhotos/71/90.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('92', '92', 'SamplePhotos/52/92.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('93', '93', 'SamplePhotos/38/93.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('94', '94', 'SamplePhotos/72/94.jpg', null, null, '0', '两眼间距');
INSERT INTO `fr_sample_photo` VALUES ('95', '95', 'SamplePhotos/72/95.jpg', null, null, '0', '两眼间距');
INSERT INTO `fr_sample_photo` VALUES ('96', '96', 'SamplePhotos/62/96.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('97', '97', 'SamplePhotos/72/97.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('98', '98', 'SamplePhotos/63/98.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('99', '99', 'SamplePhotos/52/99.jpg', null, null, '0', '两眼间距');
INSERT INTO `fr_sample_photo` VALUES ('100', '100', 'SamplePhotos/58/100.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('101', '101', 'SamplePhotos/59/101.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('102', '102', 'SamplePhotos/59/102.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('103', '103', 'SamplePhotos/57/103.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('104', '104', 'SamplePhotos/71/104.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('105', '105', 'SamplePhotos/59/105.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('106', '106', 'SamplePhotos/57/106.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('108', '108', 'SamplePhotos/72/108.jpg', null, null, '0', '两眼间距');
INSERT INTO `fr_sample_photo` VALUES ('109', '109', 'SamplePhotos/38/109.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('112', '112', 'SamplePhotos/72/112.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('113', '113', 'SamplePhotos/58/113.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('114', '114', 'SamplePhotos/62/114.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('115', '115', 'SamplePhotos/61/115.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('116', '116', 'SamplePhotos/60/116.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('117', '117', 'SamplePhotos/60/117.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('118', '118', 'SamplePhotos/61/118.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('119', '119', 'SamplePhotos/57/119.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('120', '120', 'SamplePhotos/59/120.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('121', '121', 'SamplePhotos/69/121.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('122', '122', 'SamplePhotos/68/122.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('124', '124', 'SamplePhotos/52/124.jpg', null, null, '0', '两眼间距');
INSERT INTO `fr_sample_photo` VALUES ('125', '125', 'SamplePhotos/64/125.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('126', '126', 'SamplePhotos/63/126.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('127', '127', 'SamplePhotos/59/127.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('128', '128', 'SamplePhotos/41/128.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('129', '129', 'SamplePhotos/38/129.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('131', '131', 'SamplePhotos/59/131.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('132', '132', 'SamplePhotos/48/132.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('134', '134', 'SamplePhotos/71/134.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('136', '136', 'SamplePhotos/52/136.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('137', '137', 'SamplePhotos/57/137.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('138', '138', 'SamplePhotos/68/138.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('140', '140', 'SamplePhotos/57/140.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('142', '142', 'SamplePhotos/57/142.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('143', '143', 'SamplePhotos/64/143.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('144', '144', 'SamplePhotos/68/144.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('145', '145', 'SamplePhotos/68/145.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('146', '146', 'SamplePhotos/41/146.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('147', '147', 'SamplePhotos/41/147.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('148', '148', 'SamplePhotos/41/148.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('149', '149', 'SamplePhotos/41/149.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('150', '150', 'SamplePhotos/41/150.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('151', '151', 'SamplePhotos/41/151.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('152', '152', 'SamplePhotos/41/152.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('153', '153', 'SamplePhotos/41/153.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('154', '154', 'SamplePhotos/41/154.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('155', '155', 'SamplePhotos/41/155.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('156', '156', 'SamplePhotos/41/156.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('157', '157', 'SamplePhotos/41/157.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('158', '158', 'SamplePhotos/41/158.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('159', '159', 'SamplePhotos/41/159.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('160', '160', 'SamplePhotos/41/160.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('161', '161', 'SamplePhotos/41/161.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('162', '162', 'SamplePhotos/41/162.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('163', '163', 'SamplePhotos/43/163.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('164', '164', 'SamplePhotos/56/164.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('165', '165', 'SamplePhotos/41/165.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('166', '166', 'SamplePhotos/41/166.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('167', '167', 'SamplePhotos/41/167.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('168', '168', 'SamplePhotos/41/168.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('169', '169', 'SamplePhotos/41/169.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('170', '170', 'SamplePhotos/41/170.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('171', '171', 'SamplePhotos/41/171.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('172', '172', 'SamplePhotos/41/172.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('173', '173', 'SamplePhotos/41/173.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('174', '174', 'SamplePhotos/41/174.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('175', '175', 'SamplePhotos/41/175.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('176', '176', 'SamplePhotos/41/176.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('177', '177', 'SamplePhotos/41/177.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('178', '178', 'SamplePhotos/41/178.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('179', '179', 'SamplePhotos/41/179.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('180', '180', 'SamplePhotos/41/180.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('181', '181', 'SamplePhotos/41/181.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('182', '182', 'SamplePhotos/41/182.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('183', '183', 'SamplePhotos/41/183.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('184', '184', 'SamplePhotos/41/184.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('185', '185', 'SamplePhotos/41/185.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('186', '186', 'SamplePhotos/41/186.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('187', '187', 'SamplePhotos/41/187.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('188', '188', 'SamplePhotos/41/188.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('189', '189', 'SamplePhotos/41/189.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('190', '190', 'SamplePhotos/41/190.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('191', '191', 'SamplePhotos/41/191.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('192', '192', 'SamplePhotos/41/192.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('194', '194', 'SamplePhotos/41/194.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('195', '195', 'SamplePhotos/41/195.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('196', '196', 'SamplePhotos/41/196.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('197', '197', 'SamplePhotos/41/197.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('198', '198', 'SamplePhotos/41/198.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('199', '199', 'SamplePhotos/41/199.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('200', '200', 'SamplePhotos/41/200.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('201', '201', 'SamplePhotos/41/201.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('202', '202', 'SamplePhotos/41/202.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('203', '203', 'SamplePhotos/41/203.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('204', '204', 'SamplePhotos/41/204.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('205', '205', 'SamplePhotos/41/205.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('206', '206', 'SamplePhotos/41/206.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('207', '207', 'SamplePhotos/41/207.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('208', '208', 'SamplePhotos/41/208.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('209', '209', 'SamplePhotos/41/209.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('210', '210', 'SamplePhotos/41/210.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('211', '211', 'SamplePhotos/41/211.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('212', '212', 'SamplePhotos/41/212.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('213', '213', 'SamplePhotos/41/213.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('214', '214', 'SamplePhotos/41/214.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('215', '215', 'SamplePhotos/41/215.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('216', '216', 'SamplePhotos/41/216.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('217', '217', 'SamplePhotos/41/217.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('218', '218', 'SamplePhotos/41/218.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('219', '219', 'SamplePhotos/41/219.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('220', '220', 'SamplePhotos/41/220.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('221', '221', 'SamplePhotos/41/221.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('222', '222', 'SamplePhotos/41/222.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('223', '223', 'SamplePhotos/41/223.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('224', '224', 'SamplePhotos/41/224.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('225', '225', 'SamplePhotos/41/225.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('226', '226', 'SamplePhotos/41/226.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('227', '227', 'SamplePhotos/41/227.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('228', '228', 'SamplePhotos/41/228.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('229', '229', 'SamplePhotos/41/229.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('230', '230', 'SamplePhotos/41/230.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('231', '231', 'SamplePhotos/67/231.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('233', '233', 'SamplePhotos/41/233.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('234', '234', 'SamplePhotos/41/234.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('235', '235', 'SamplePhotos/41/235.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('236', '236', 'SamplePhotos/41/236.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('238', '238', 'SamplePhotos/65/238.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('239', '239', 'SamplePhotos/41/239.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('240', '240', 'SamplePhotos/41/240.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('242', '242', 'SamplePhotos/41/242.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('243', '243', 'SamplePhotos/46/243.jpg', null, null, '1', '');
INSERT INTO `fr_sample_photo` VALUES ('244', '244', 'SamplePhotos/43/244.jpg', null, null, '1', '');
INSERT INTO `fr_sample_photo` VALUES ('245', '245', 'SamplePhotos/43/245.jpg', null, null, '1', '');
INSERT INTO `fr_sample_photo` VALUES ('246', '246', 'SamplePhotos/43/246.jpg', null, null, '1', '');
INSERT INTO `fr_sample_photo` VALUES ('247', '247', 'SamplePhotos/43/247.jpg', null, null, '1', '');
INSERT INTO `fr_sample_photo` VALUES ('249', '249', 'SamplePhotos/49/249.jpg', null, null, '1', '');
INSERT INTO `fr_sample_photo` VALUES ('250', '250', 'SamplePhotos/49/250.jpg', null, null, '1', '');
INSERT INTO `fr_sample_photo` VALUES ('251', '251', 'SamplePhotos/49/251.jpg', null, null, '1', '');
INSERT INTO `fr_sample_photo` VALUES ('252', '252', 'SamplePhotos/49/252.jpg', null, null, '1', '');
INSERT INTO `fr_sample_photo` VALUES ('253', '253', 'SamplePhotos/49/253.jpg', null, null, '1', '');
INSERT INTO `fr_sample_photo` VALUES ('254', '254', 'SamplePhotos/49/254.jpg', null, null, '1', '');
INSERT INTO `fr_sample_photo` VALUES ('255', '255', 'SamplePhotos/42/255.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('256', '256', 'SamplePhotos/42/256.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('257', '257', 'SamplePhotos/42/257.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('258', '258', 'SamplePhotos/42/258.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('259', '259', 'SamplePhotos/42/259.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('261', '261', 'SamplePhotos/42/261.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('262', '262', 'SamplePhotos/42/262.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('263', '263', 'SamplePhotos/42/263.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('264', '264', 'SamplePhotos/42/264.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('265', '265', 'SamplePhotos/42/265.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('266', '266', 'SamplePhotos/42/266.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('267', '267', 'SamplePhotos/42/267.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('268', '268', 'SamplePhotos/42/268.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('269', '269', 'SamplePhotos/42/269.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('270', '270', 'SamplePhotos/42/270.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('271', '271', 'SamplePhotos/42/271.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('272', '272', 'SamplePhotos/42/272.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('273', '273', 'SamplePhotos/42/273.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('274', '274', 'SamplePhotos/42/274.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('275', '275', 'SamplePhotos/42/275.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('277', '277', 'SamplePhotos/42/277.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('278', '278', 'SamplePhotos/42/278.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('279', '279', 'SamplePhotos/42/279.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('280', '280', 'SamplePhotos/42/280.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('281', '281', 'SamplePhotos/42/281.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('282', '282', 'SamplePhotos/42/282.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('285', '285', 'SamplePhotos/42/285.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('286', '286', 'SamplePhotos/42/286.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('287', '287', 'SamplePhotos/42/287.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('288', '288', 'SamplePhotos/50/288.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('289', '289', 'SamplePhotos/50/289.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('290', '290', 'SamplePhotos/50/290.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('291', '291', 'SamplePhotos/50/291.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('292', '292', 'SamplePhotos/50/292.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('293', '293', 'SamplePhotos/50/293.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('294', '294', 'SamplePhotos/55/294.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('295', '295', 'SamplePhotos/55/295.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('296', '296', 'SamplePhotos/55/296.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('297', '297', 'SamplePhotos/55/297.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('298', '298', 'SamplePhotos/55/298.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('299', '299', 'SamplePhotos/55/299.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('300', '300', 'SamplePhotos/55/300.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('301', '301', 'SamplePhotos/55/301.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('302', '302', 'SamplePhotos/55/302.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('303', '303', 'SamplePhotos/55/303.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('304', '304', 'SamplePhotos/35/304.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('305', '305', 'SamplePhotos/55/305.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('306', '306', 'SamplePhotos/55/306.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('307', '307', 'SamplePhotos/55/307.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('308', '308', 'SamplePhotos/45/308.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('309', '309', 'SamplePhotos/45/309.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('310', '310', 'SamplePhotos/45/310.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('311', '311', 'SamplePhotos/45/311.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('312', '312', 'SamplePhotos/45/312.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('313', '313', 'SamplePhotos/45/313.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('314', '314', 'SamplePhotos/45/314.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('315', '315', 'SamplePhotos/45/315.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('316', '316', 'SamplePhotos/56/316.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('317', '317', 'SamplePhotos/45/317.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('318', '318', 'SamplePhotos/45/318.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('320', '320', 'SamplePhotos/45/320.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('321', '321', 'SamplePhotos/45/321.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('322', '322', 'SamplePhotos/45/322.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('323', '323', 'SamplePhotos/45/323.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('324', '324', 'SamplePhotos/45/324.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('325', '325', 'SamplePhotos/45/325.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('326', '326', 'SamplePhotos/45/326.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('327', '327', 'SamplePhotos/45/327.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('328', '328', 'SamplePhotos/45/328.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('329', '329', 'SamplePhotos/45/329.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('330', '330', 'SamplePhotos/45/330.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('331', '331', 'SamplePhotos/45/331.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('332', '332', 'SamplePhotos/45/332.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('333', '333', 'SamplePhotos/45/333.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('334', '334', 'SamplePhotos/45/334.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('335', '335', 'SamplePhotos/45/335.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('336', '336', 'SamplePhotos/45/336.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('337', '337', 'SamplePhotos/45/337.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('338', '338', 'SamplePhotos/45/338.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('339', '339', 'SamplePhotos/45/339.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('340', '340', 'SamplePhotos/45/340.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('341', '341', 'SamplePhotos/45/341.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('342', '342', 'SamplePhotos/45/342.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('343', '343', 'SamplePhotos/75/343.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('344', '344', 'SamplePhotos/45/344.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('345', '345', 'SamplePhotos/45/345.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('346', '346', 'SamplePhotos/45/346.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('347', '347', 'SamplePhotos/45/347.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('348', '348', 'SamplePhotos/45/348.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('349', '349', 'SamplePhotos/66/349.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('350', '350', 'SamplePhotos/45/350.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('351', '351', 'SamplePhotos/45/351.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('352', '352', 'SamplePhotos/45/352.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('353', '353', 'SamplePhotos/56/353.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('354', '354', 'SamplePhotos/56/354.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('355', '355', 'SamplePhotos/56/355.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('356', '356', 'SamplePhotos/56/356.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('357', '357', 'SamplePhotos/56/357.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('358', '358', 'SamplePhotos/56/358.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('359', '359', 'SamplePhotos/56/359.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('360', '360', 'SamplePhotos/56/360.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('361', '361', 'SamplePhotos/56/361.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('362', '362', 'SamplePhotos/56/362.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('363', '363', 'SamplePhotos/47/363.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('364', '364', 'SamplePhotos/47/364.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('365', '365', 'SamplePhotos/47/365.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('366', '366', 'SamplePhotos/47/366.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('367', '367', 'SamplePhotos/47/367.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('368', '368', 'SamplePhotos/46/368.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('369', '369', 'SamplePhotos/46/369.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('370', '370', 'SamplePhotos/46/370.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('371', '371', 'SamplePhotos/46/371.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('372', '372', 'SamplePhotos/46/372.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('373', '373', 'SamplePhotos/46/373.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('374', '374', 'SamplePhotos/46/374.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('479', '375', 'SamplePhotos/35/375_431.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('489', '376', 'SamplePhotos/54/376_233.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('490', '377', 'SamplePhotos/42/377_462.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('491', '378', 'SamplePhotos/42/378_106.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('492', '379', 'SamplePhotos/43/379_765.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('493', '380', 'SamplePhotos/35/380.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('495', '381', 'SamplePhotos/57/381_855.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('500', '386', 'SamplePhotos/61/386_349.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('501', '387', 'SamplePhotos/62/387_534.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('502', '388', 'SamplePhotos/63/388_957.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('503', '389', 'SamplePhotos/63/389_603.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('504', '390', 'SamplePhotos/63/390_908.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('505', '391', 'SamplePhotos/64/391_652.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('510', '69', 'SamplePhotos/58/69_343.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('511', '139', 'SamplePhotos/38/139_450.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('519', '91', 'SamplePhotos/69/91_257.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('522', '110', 'SamplePhotos/69/110_729.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('525', '130', 'SamplePhotos/68/130_407.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('530', '111', 'SamplePhotos/64/111_455.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('533', '133', 'SamplePhotos/61/133_146.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('536', '141', 'SamplePhotos/62/141_428.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('537', '383', 'SamplePhotos/58/383_208.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('538', '384', 'SamplePhotos/59/384_193.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('541', '394', 'SamplePhotos/63/394_533.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('549', '107', 'SamplePhotos/68/107.jpg', null, null, '0', '两眼间距');
INSERT INTO `fr_sample_photo` VALUES ('553', '396', 'SamplePhotos/48/396_801.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('564', '398', 'SamplePhotos/45/398_141.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('565', '400', 'SamplePhotos/73/400_120.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('567', '401', 'SamplePhotos/45/401_462.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('568', '402', 'SamplePhotos/77/402_908.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('569', '403', 'SamplePhotos/77/403_605.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('570', '404', 'SamplePhotos/78/404_781.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('573', '407', 'SamplePhotos/73/407_196.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('574', '408', 'SamplePhotos/76/408_423.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('575', '397', 'SamplePhotos/76/397_449.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('576', '409', 'SamplePhotos/48/409_233.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('577', '399', 'SamplePhotos/45/399_49.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('578', '410', 'SamplePhotos/48/410_546.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('579', '411', 'SamplePhotos/73/411_508.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('580', '412', 'SamplePhotos/73/412_327.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('581', '413', 'SamplePhotos/73/413_43.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('582', '414', 'SamplePhotos/65/414_946.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('583', '415', 'SamplePhotos/65/415_606.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('584', '319', 'SamplePhotos/45/319_162.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('585', '405', 'SamplePhotos/79/405_786.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('586', '406', 'SamplePhotos/80/406_924.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('587', '416', 'SamplePhotos/45/416_58.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('588', '417', 'SamplePhotos/45/417_79.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('591', '418', 'SamplePhotos/45/418_726.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('592', '419', 'SamplePhotos/41/419_457.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('593', '420', 'SamplePhotos/44/420_755.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('594', '421', 'SamplePhotos/81/421_889.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('595', '422', 'SamplePhotos/82/422_35.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('596', '423', 'SamplePhotos/79/423_85.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('597', '424', 'SamplePhotos/83/424_833.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('598', '425', 'SamplePhotos/43/425_740.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('599', '426', 'SamplePhotos/42/426_774.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('600', '427', 'SamplePhotos/42/427_8.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('601', '428', 'SamplePhotos/56/428_532.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('602', '429', 'SamplePhotos/44/429_553.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('604', '431', 'SamplePhotos/44/431_767.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('606', '432', 'SamplePhotos/44/432_226.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('607', '433', 'SamplePhotos/44/433_605.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('609', '434', 'SamplePhotos/49/434_920.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('610', '435', 'SamplePhotos/67/435_474.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('611', '436', 'SamplePhotos/67/436_543.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('612', '437', 'SamplePhotos/75/437_188.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('613', '438', 'SamplePhotos/75/438_142.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('621', '439', 'SamplePhotos/66/439_336.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('623', '440', 'SamplePhotos/44/440_756.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('624', '441', 'SamplePhotos/73/441_697.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('625', '442', 'SamplePhotos/84/442_278.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('626', '443', 'SamplePhotos/85/443_188.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('627', '444', 'SamplePhotos/85/444_919.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('628', '445', 'SamplePhotos/86/445_380.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('629', '446', 'SamplePhotos/86/446_322.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('630', '447', 'SamplePhotos/87/447_529.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('631', '448', 'SamplePhotos/88/448_688.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('632', '449', 'SamplePhotos/89/449_373.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('633', '135', 'SamplePhotos/68/135_961.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('634', '450', 'SamplePhotos/63/450_808.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('635', '451', 'SamplePhotos/63/451_854.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('636', '452', 'SamplePhotos/63/452_259.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('637', '430', 'SamplePhotos/44/430_34.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('638', '453', 'SamplePhotos/56/453_982.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('639', '454', 'SamplePhotos/56/454_604.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('640', '455', 'SamplePhotos/65/455_394.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('641', '456', 'SamplePhotos/84/456_864.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('644', '458', 'SamplePhotos/67/458_722.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('646', '460', 'SamplePhotos/90/460_725.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('647', '461', 'SamplePhotos/84/461_111.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('648', '123', 'SamplePhotos/57/123_382.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('649', '382', 'SamplePhotos/57/382_856.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('650', '385', 'SamplePhotos/60/385_999.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('651', '393', 'SamplePhotos/63/393_145.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('652', '457', 'SamplePhotos/67/457_531.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('653', '459', 'SamplePhotos/67/459_843.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('654', '395', 'SamplePhotos/35/395_835.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('655', '462', 'SamplePhotos/54/462_599.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('657', '463', 'SamplePhotos/91/463_451.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('658', '464', 'SamplePhotos/91/464_289.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('659', '465', 'SamplePhotos/91/465_579.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('660', '466', 'SamplePhotos/91/466_807.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('661', '467', 'SamplePhotos/91/467_323.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('662', '468', 'SamplePhotos/91/468_38.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('663', '469', 'SamplePhotos/91/469_345.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('664', '470', 'SamplePhotos/91/470_490.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('665', '471', 'SamplePhotos/91/471_746.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('666', '472', 'SamplePhotos/36/472_379.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('667', '473', 'SamplePhotos/36/473_896.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('668', '474', 'SamplePhotos/36/474_760.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('669', '475', 'SamplePhotos/36/475_467.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('670', '476', 'SamplePhotos/36/476_234.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('671', '477', 'SamplePhotos/36/477_840.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('672', '478', 'SamplePhotos/36/478_735.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('673', '479', 'SamplePhotos/36/479_109.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('674', '480', 'SamplePhotos/36/480_274.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('675', '481', 'SamplePhotos/36/481_11.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('676', '482', 'SamplePhotos/36/482_489.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('677', '483', 'SamplePhotos/36/483_925.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('678', '484', 'SamplePhotos/36/484_200.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('679', '485', 'SamplePhotos/36/485_246.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('680', '486', 'SamplePhotos/36/486_872.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('681', '487', 'SamplePhotos/36/487_537.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('682', '488', 'SamplePhotos/36/488_760.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('683', '489', 'SamplePhotos/36/489_623.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('684', '490', 'SamplePhotos/36/490_187.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('685', '491', 'SamplePhotos/36/491_987.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('686', '492', 'SamplePhotos/36/492_149.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('687', '493', 'SamplePhotos/36/493_882.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('688', '494', 'SamplePhotos/36/494_676.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('689', '495', 'SamplePhotos/36/495_567.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('690', '496', 'SamplePhotos/36/496_328.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('691', '497', 'SamplePhotos/36/497_583.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('707', '498', 'SamplePhotos/42/498_309.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('708', '499', 'SamplePhotos/28/499_712.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('711', '501', 'SamplePhotos/35/501_758.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('712', '502', 'SamplePhotos/54/502_366.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('713', '503', 'SamplePhotos/35/503_168.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('714', '504', 'SamplePhotos/35/504_713.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('717', '284', 'SamplePhotos/42/284_380.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('718', '505', 'SamplePhotos/42/505_95.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('719', '506', 'SamplePhotos/42/506_627.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('729', '260', 'SamplePhotos/42/260_168.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('730', '283', 'SamplePhotos/42/283_366.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('742', '4', 'SamplePhotos/54/4_774.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('743', '248', 'SamplePhotos/43/248_805.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('746', '508', 'SamplePhotos/91/508_957.jpg', null, null, '0', '侧脸严重');
INSERT INTO `fr_sample_photo` VALUES ('748', '510', 'SamplePhotos/91/510_509.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('752', '22', 'SamplePhotos/35/22_965.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('754', '507', 'SamplePhotos/91/507_788.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('755', '509', 'SamplePhotos/91/509_216.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('758', '511', 'SamplePhotos/91/511_396.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('759', '237', 'SamplePhotos/41/237_677.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('762', '276', 'SamplePhotos/42/276_524.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('763', '512', 'SamplePhotos/41/512_942.jpg', null, null, '1', null);
INSERT INTO `fr_sample_photo` VALUES ('767', '513', 'SamplePhotos/41/513_574.jpg', null, null, '1', '');
INSERT INTO `fr_sample_photo` VALUES ('768', '514', 'SamplePhotos/42/514_660.jpg', null, null, '1', '');
INSERT INTO `fr_sample_photo` VALUES ('769', '515', 'SamplePhotos/41/515_522.jpg', null, null, '1', '');
INSERT INTO `fr_sample_photo` VALUES ('770', '516', 'SamplePhotos/35/516_322.jpg', null, null, '1', null);

-- ----------------------------
-- Table structure for `fr_signin`
-- ----------------------------
DROP TABLE IF EXISTS `fr_signin`;
CREATE TABLE `fr_signin` (
  `collectId` int(10) NOT NULL COMMENT '关联userinfo表的CollectId',
  `name` varchar(50) DEFAULT NULL COMMENT '签到人员姓名',
  `phone` varchar(50) DEFAULT NULL COMMENT '签到人员电话',
  `signIn` int(10) DEFAULT '0' COMMENT '判断是否签到：1：是；0：否',
  `signTime` datetime DEFAULT NULL COMMENT '签到时间',
  `signTime2` datetime DEFAULT NULL,
  `mettingId` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of fr_signin
-- ----------------------------
INSERT INTO `fr_signin` VALUES ('1', '高洁', '13900000000', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('2', '高昊飞', '13900000001', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('3', '陈舜媚', '13900000002', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('4', '赵倩', '13900000003', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('5', '王春华', '13900000004', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('6', '朱辰光', '13900000005', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('7', '余进', '13900000006', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('8', '颜羽鹏', '13900000007', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('9', '陈静', '13900000008', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('10', '陈肖', '13900000009', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('11', '闫聪聪', '13900000010', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('12', '李月平', '13900000011', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('13', '李任杰', '13900000012', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('14', '张艳', '13900000013', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('15', '张丹普', '13900000014', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('16', '崔定波', '13900000015', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('18', '孔令远', '13900000016', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('19', '唐金辉', '13900000017', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('21', '刘惟锦', '13900000018', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('22', '刘房', '13900000019', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('23', '刘立明', '13900000020', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('24', '刘  颖', '13900000021', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('25', '单鼎一', '13900000022', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('26', '吕春花', '13900000023', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('27', '吴蔚', '13900000024', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('29', '李雪', '13900000025', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('30', '杨启', '13900000026', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('31', '樊龙', '13900000027', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('33', '滕一', '13900000028', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('34', '王亚静', '13900000029', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('36', '白国峰', '13900000030', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('37', '程舰', '13900000031', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('38', '耿雪冰', '13900000032', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('39', '范宇', '13900000033', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('40', '贾承翰', '13900000034', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('42', '赵曼', '13900000035', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('43', '郄梦岩', '13900000036', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('44', '郑志国', '13900000037', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('45', '郝文娟', '13900000038', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('46', '陈晓锋', '13900000039', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('47', '刘婧', '13900000040', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('48', '刘鑫', '13900000041', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('49', '周子奥', '13900000042', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('50', '崔瑜', '13900000043', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('51', '许咏梅', '13900000044', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('52', '田辉', '13900000045', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('53', '阚博伦', '13900000046', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('54', '韩金海', '13900000047', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('55', '谢美程', '13900000048', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('56', '于广兴', '13900000049', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('57', '宋南南', '13900000050', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('58', '彭朝流', '13900000051', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('59', '梅敏敏', '13900000052', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('60', '王昊宸', '13900000053', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('61', '田磊', '13900000054', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('62', '袁冲', '13900000055', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('63', '黄抒敏', '13900000056', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('64', '鹿晓松', '13900000057', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('65', '魏英博', '13900000058', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('66', '高雁鸬', '13900000059', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('68', '陈鸿如', '13900000060', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('69', '陈淼', '13900000061', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('70', '都志正', '13900000062', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('71', '郭智勇', '13900000063', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('72', '郭会明', '13900000064', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('73', '赵金洪', '13900000065', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('74', '赵赟', '13900000066', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('75', '赵志华', '13900000067', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('76', '张梦巧', '13900000068', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('77', '张文飞', '13900000069', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('78', '张占华', '13900000070', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('80', '庄涛', '13900000071', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('81', '庄开山', '13900000072', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('82', '崔雪妍', '13900000073', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('84', '山丹', '13900000074', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('85', '尚珊萍', '13900000075', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('86', '孙钦涛', '13900000076', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('88', '姜华', '13900000077', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('89', '姜升海', '13900000078', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('90', '吴琼', '13900000079', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('91', '吴洪波', '13900000080', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('93', '史燕中', '13900000081', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('94', '侯云龙', '13900000082', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('95', '侯业', '13900000083', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('96', '何隽秀', '13900000084', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('97', '任洪江', '13900000085', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('98', '付建祖', '13900000086', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('100', '于文杰', '13900000087', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('101', '冯志钢', '13900000088', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('102', '刘京京', '13900000089', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('103', '刘伟辉', '13900000090', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('104', '刘娇龙', '13900000091', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('105', '刘婉滢', '13900000092', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('106', '刘宁', '13900000093', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('107', '刘恺洁', '13900000094', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('108', '刘欣浩', '13900000095', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('109', '刘磊', '13900000096', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('110', '张涛', '13900000097', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('111', '张章', '13900000098', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('112', '曾爱军', '13900000099', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('113', '李明', '13900000100', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('114', '李晓青', '13900000101', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('115', '李涛', '13900000102', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('116', '李茹', '13900000103', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('117', '李雅娟', '13900000104', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('118', '段裕晁', '13900000105', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('119', '汪志伟', '13900000106', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('120', '焦娜', '13900000107', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('121', '焦长军', '13900000108', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('122', '熊伟', '13900000109', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('123', '王世娟', '13900000110', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('125', '王咏', '13900000111', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('126', '王姝', '13900000112', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('127', '王琮', '13900000113', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('128', '王红叶', '13900000114', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('129', '王艳彬', '13900000115', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('130', '王艳美', '13900000116', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('131', '王鑫', '13900000117', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('132', '田粮', '13900000118', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('133', '程凌峰', '13900000119', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('134', '童伟', '13900000120', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('135', '缴振雷', '13900000121', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('137', '罗欣', '13900000122', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('138', '罗琼', '13900000123', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('139', '苏子华', '13900000124', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('140', '苏荣', '13900000125', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('141', '范小丽', '13900000126', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('142', '范晨亮', '13900000127', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('143', '薛井红', '13900000128', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('144', '费博研', '13900000129', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('145', '贾文涛', '13900000130', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('147', '麻博', '13900000131', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('148', '鲍海涛', '13900000132', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('150', '魏凯', '13900000133', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('152', '高凤贤', '13900000134', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('153', '马利伟', '13900000135', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('154', '颜亦文', '13900000136', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('155', '靳华山', '13900000137', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('156', '霍脱园', '13900000138', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('157', '雷婧', '13900000139', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('158', '陈永进', '13900000140', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('159', '陈曦', '13900000141', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('161', '陈守峰', '13900000142', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('162', '陈加', '13900000143', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('163', '陆景鹏', '13900000144', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('164', '闫文智', '13900000145', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('165', '金圣锋', '13900000146', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('166', '里根', '13900000147', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('169', '邵延涛', '13900000148', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('170', '赵然', '13900000149', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('171', '赵晓伟', '13900000150', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('172', '赵天雯', '13900000151', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('173', '张鹏', '13900000152', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('174', '张青', '13900000153', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('175', '张陈欢', '13900000154', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('177', '张苗苗', '13900000155', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('178', '张林杰', '13900000156', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('179', '张志国', '13900000157', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('181', '张凯', '13900000158', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('182', '张军委', '13900000159', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('183', '廖玲丽', '13900000160', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('184', '常毅', '13900000161', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('185', '常存磊', '13900000162', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('186', '崔硕', '13900000163', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('187', '尚向燕', '13900000164', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('188', '宋建巩', '13900000165', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('189', '宋坤涛', '13900000166', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('190', '孙靖淇', '13900000167', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('191', '刘钧', '13900000168', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('192', '刘金涛', '13900000169', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('194', '刘刚', '13900000170', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('195', '冯明', '13900000171', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('196', '任仁', '13900000172', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('197', '丁思强', '13900000173', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('198', '刘颂秋', '13900000174', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('200', '卢绪哲', '13900000175', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('201', '叶汝新', '13900000176', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('202', '周云成', '13900000177', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('203', '喻鑫', '13900000178', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('204', '夏文莉', '13900000179', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('205', '孙宝鸣', '13900000180', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('206', '孙震宇', '13900000181', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('207', '戴志强', '13900000182', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('208', '戴斌', '13900000183', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('209', '曲秋楠', '13900000184', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('210', '曹晓红', '13900000185', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('212', '朱越', '13900000186', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('213', '李京波', '13900000187', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('215', '李树鑫', '13900000188', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('216', '杜佳悦', '13900000189', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('217', '杜龙洋', '13900000190', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('218', '杨建超', '13900000191', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('219', '杨征宇', '13900000192', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('220', '杨羿', '13900000193', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('221', '梁冠华', '13900000194', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('222', '武超', '13900000195', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('223', '汪圣', '13900000196', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('224', '焦佳岩', '13900000197', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('225', '王学飞', '13900000198', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('226', '王思明', '13900000199', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('227', '王海涛', '13900000200', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('228', '王须', '13900000201', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('229', '申雅华', '13900000202', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('230', '石磊', '13900000203', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('231', '罗峤伊', '13900000204', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('233', '耿宏捷', '13900000205', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('234', '肖金萍', '13900000206', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('235', '胡一静', '13900000207', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('236', '苏洋旸', '13900000208', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('237', '范亚琼', '13900000209', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('238', '薛振宇', '13900000210', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('239', '袁江明', '13900000211', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('242', '詹俊妮', '13900000212', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('243', '陈冬雪', '13900000213', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('244', '邓世雄', '13900000214', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('245', '程晓鹏', '13900000215', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('246', '申佳斌', '13900000216', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('248', '李水', '13900000217', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('249', '董石峰', '13900000218', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('250', '王悦', '13900000219', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('251', '李朝晖', '13900000220', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('252', '李晓峰', '13900000221', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('253', '张云', '13900000222', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('254', '孙大鹏', '13900000223', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('255', '黄昕', '13900000224', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('256', '马小利', '13900000225', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('257', '马劲峰', '13900000226', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('258', '陈楠', '13900000227', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('259', '陈嘉末', '13900000228', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('260', '闫红丽', '13900000229', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('261', '郭春燕', '13900000230', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('262', '郭昊', '13900000231', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('263', '郝琳波', '13900000232', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('266', '赵斌', '13900000233', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('267', '赵凯', '13900000234', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('268', '谭青杨', '13900000235', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('269', '蔡大河', '13900000236', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('270', '芦艳', '13900000237', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('271', '田力', '13900000238', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('272', '张军伟', '13900000239', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('273', '庞路明', '13900000240', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('274', '宫德利', '13900000241', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('275', '吴晨阳', '13900000242', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('276', '吴慧贤', '13900000243', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('277', '刘诗娟', '13900000244', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('278', '倪文顺', '13900000245', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('279', '张树环', '13900000246', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('280', '张超', '13900000247', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('281', '徐佩', '13900000248', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('282', '曹德峰', '13900000249', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('283', '曾庆贺', '13900000250', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('284', '朱琪', '13900000251', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('285', '李义夫', '13900000252', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('287', '王海峰', '13900000253', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('288', '高昆', '13900000254', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('289', '谷小頔', '13900000255', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('290', '田金星', '13900000256', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('291', '王馨培', '13900000257', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('292', '沈媛', '13900000258', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('293', '宋扬', '13900000259', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('294', '邓华阳', '13900000260', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('295', '王高磊', '13900000261', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('296', '武玉亭', '13900000262', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('297', '柴秀英', '13900000263', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('298', '杨瑞瑞', '13900000264', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('299', '杨剑锋', '13900000265', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('300', '李鑫', '13900000266', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('301', '侯晓娟', '13900000267', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('302', '刘园', '13900000268', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('303', '卢鑫', '13900000269', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('304', '张晓林', '13900000270', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('305', '朱彤', '13900000271', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('306', '朱静静', '13900000272', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('307', '李浩', '13900000273', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('308', '黄颖', '13900000274', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('310', '黄农运', '13900000275', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('311', '韦艳红', '13900000276', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('312', '雷蕾', '13900000277', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('313', '雷焕春', '13900000278', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('314', '陈浩', '13900000279', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('315', '闫伟夏', '13900000280', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('316', '邓榕', '13900000281', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('317', '赵维君', '13900000282', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('318', '贺妮佑', '13900000283', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('319', '徐晋洲', '13900000284', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('320', '张文婷', '13900000285', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('321', '张岩', '13900000286', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('322', '张妍', '13900000287', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('323', '张嘉诚', '13900000288', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('324', '周华', '13900000289', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('325', '吕慧', '13900000290', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('326', '刘鸽', '13900000291', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('327', '刘菲', '13900000292', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('328', '于薇', '13900000293', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('329', '于雪', '13900000294', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('330', '任如意', '13900000295', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('331', '刘嘉翼', '13900000296', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('332', '刘春燕', '13900000297', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('333', '刘月', '13900000298', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('334', '刘洋', '13900000299', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('335', '徐琳粤', '13900000300', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('336', '朱晓东', '13900000301', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('337', '李伟祎', '13900000302', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('338', '李健', '13900000303', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('339', '李大鹏', '13900000304', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('341', '杨敏', '13900000305', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('343', '栗晓杰', '13900000306', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('344', '段少伟', '13900000307', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('345', '焦丹', '13900000308', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('346', '王亚超', '13900000309', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('347', '王宇', '13900000310', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('348', '石鹏飞', '13900000311', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('349', '穆童', '13900000312', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('350', '蔡潇霄', '13900000313', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('351', '虞涛', '13900000314', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('352', '谭静', '13900000315', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('353', '顾正阳', '13900000316', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('354', '邓刚', '13900000317', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('355', '解通', '13900000318', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('356', '姜思琪', '13900000319', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('357', '张静娟', '13900000320', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('358', '李春阳', '13900000321', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('359', '李祥', '13900000322', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('360', '罗芳', '13900000323', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('361', '袁百辉', '13900000324', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('362', '解冰', '13900000325', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('363', '邱学志', '13900000326', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('364', '边晓娟', '13900000327', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('365', '彭爱平', '13900000328', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('366', '刘荩珊', '13900000329', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('367', '刘健', '13900000330', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('368', '王智广', '13900000331', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('369', '李维红', '13900000332', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('370', '徐睿', '13900000333', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('371', '张雪', '13900000334', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('372', '刘海涛', '13900000335', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('373', '张冬雪', '13900000336', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('374', '吴婧', '13900000337', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('375', '梅丹玮', '13900000338', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('376', '杨鹏举', '13900000339', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('377', '宋星毅', '13900000340', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('378', '唐嘉宇', '13900000341', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('379', '张旭', '13900000342', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('380', '魏鑫', '13900000343', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('381', '高天翔', '13900000344', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('382', '满凌然', '13900000345', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('383', '杨欣', '13900000346', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('384', '邵奇', '13900000347', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('385', '朱嘉琳', '13900000348', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('386', '王琦', '13900000349', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('387', '王献朋', '13900000350', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('388', '焦函', '13900000351', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('389', '罗涵徽', '13900000352', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('390', '王鑫龙', '13900000353', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('391', '张万斌', '13900000354', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('393', '王诗情', '13900000355', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('394', '武卫文', '13900000356', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('395', '董雪梅', '13900000357', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('396', '刘培苗', '13900000358', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('397', '杨淼', '13900000359', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('398', '郑素兰', '13900000360', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('399', '白钢', '13900000361', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('400', '程鹏', '13900000362', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('401', '褚明霞', '13900000363', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('402', '陈瑞', '13900000364', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('403', '郭仕', '13900000365', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('404', '薛军平', '13900000366', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('405', '张永', '13900000367', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('406', '郭凯', '13900000368', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('407', '刘璐', '13900000369', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('408', '吴哲', '13900000370', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('409', '雷明君', '13900000371', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('410', '刘康宁', '13900000372', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('411', '夏青', '13900000373', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('412', '徐璐', '13900000374', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('413', '庄楠', '13900000375', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('414', '宁勇', '13900000376', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('415', '冉海燕', '13900000377', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('416', '于飞龙', '13900000378', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('417', '张彤', '13900000379', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('418', '敖丹妮', '13900000380', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('419', '张大海', '13900000381', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('420', '张国力', '13900000382', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('421', '钱彬', '13900000383', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('422', '徐进军', '13900000384', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('423', '许明', '13900000385', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('424', '张嘉城', '13900000386', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('425', '张世贤', '13900000387', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('426', '王晓云', '13900000388', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('427', '周万金', '13900000389', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('428', '王华', '13900000390', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('429', '贺中', '13900000391', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('430', '林华', '13900000392', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('431', '鲁明', '13900000393', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('432', '马连轶', '13900000394', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('433', '田培森', '13900000395', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('434', '王海仙', '13900000396', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('435', '闫庚翔', '13900000397', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('436', '李健', '13900000398', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('437', '程义', '13900000399', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('438', '胡建国', '13900000400', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('439', '熊彬', '13900000401', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('440', '李大鹏', '13900000402', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('441', '李佳', '13900000403', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('442', '吕洋', '13900000404', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('443', '郭平', '13900000405', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('444', '张振兴', '13900000406', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('445', '安延群', '13900000407', '0', null, null, '1');
INSERT INTO `fr_signin` VALUES ('446', '吴蔚', '13900000408', '0', null, null, '1');

-- ----------------------------
-- Table structure for `fr_sound_equipment`
-- ----------------------------
DROP TABLE IF EXISTS `fr_sound_equipment`;
CREATE TABLE `fr_sound_equipment` (
  `soundID` int(10) NOT NULL AUTO_INCREMENT COMMENT '发声设备ID',
  `soundEquipmentIp` varchar(100) NOT NULL COMMENT '发声设备IP',
  `username` varchar(100) NOT NULL COMMENT '设备登录用户名',
  `password` varchar(100) NOT NULL COMMENT '设备登录密码',
  PRIMARY KEY (`soundID`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of fr_sound_equipment
-- ----------------------------
INSERT INTO `fr_sound_equipment` VALUES ('10', '192.168.6.6', 'admin', 'admin12345');
INSERT INTO `fr_sound_equipment` VALUES ('20', '192.168.6.66', 'admin', 'admin12345');
INSERT INTO `fr_sound_equipment` VALUES ('22', '192.168.5.83', 'admin', 'admin12345');
INSERT INTO `fr_sound_equipment` VALUES ('23', '192.168.6.7', 'admin', 'abcd111111');
INSERT INTO `fr_sound_equipment` VALUES ('24', '192.168.6.8', 'admin', 'abcd111111');
INSERT INTO `fr_sound_equipment` VALUES ('25', '192.168.6.5', 'admin', 'admin12345');

-- ----------------------------
-- Table structure for `sys_account`
-- ----------------------------
DROP TABLE IF EXISTS `sys_account`;
CREATE TABLE `sys_account` (
  `ID` varchar(50) COLLATE utf8_bin NOT NULL,
  `USERNAME` varchar(50) COLLATE utf8_bin NOT NULL,
  `PASSWORD` varchar(50) COLLATE utf8_bin NOT NULL,
  `SALT` varchar(20) COLLATE utf8_bin NOT NULL,
  `CREATETIME` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `UPDATETIME` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `IFUSE` varchar(2) COLLATE utf8_bin DEFAULT NULL,
  `ORDERNUM` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `TOKEN` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `APPID` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `COMMUNICATIONID` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '环信ID',
  `validategroupid` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='账户信息';

-- ----------------------------
-- Records of sys_account
-- ----------------------------
INSERT INTO `sys_account` VALUES ('33c66e16-b347-48c4-a405-b6934a1675ac', 'zhaotianwen', 'aa7102686a51752907f3e4b767f1050d', '818966', '2019-05-15 16:34:51', '2019-05-15 16:34:51', 'Y', '查询及导出考勤数据', null, '123456', 'zhaotianwen', null);
INSERT INTO `sys_account` VALUES ('63c68bcb-4208-4ed5-9a61-0f7c2dca0f01', 'zhangxu', 'ea6619026946e71af75b856caee2b1e3', '389639', '2019-05-15 16:35:08', '2019-05-15 16:35:08', 'Y', '查询及导出考勤数据', null, '123456', 'zhangxu', null);
INSERT INTO `sys_account` VALUES ('a1', 'admin', 'dc606b29d3216861d03014fffa9d3e09', '773659', '2017-1-11 12:12:12', '2017-1-11 12:12:12', 'y', '0', '1', '111111', 'admin', '11111');
INSERT INTO `sys_account` VALUES ('b50d50a6-9312-45d4-9a28-acc3cdff93d8', 'liuying', 'e05e5c57f55e1ccf9485923b8c5e0c87', '782187', '2019-01-18 11:12:28', '2019-01-18 11:12:28', 'Y', '查询及导出考勤数据', null, '788499', 'liuying', '22222');
INSERT INTO `sys_account` VALUES ('c2f6d3dc-265c-4b95-9dd2-cb203ca053df', 'liushijuan', '828fe52c7bd70ba118c5b506559afec9', '571142', '2019-05-15 16:34:22', '2019-05-15 16:34:22', 'Y', '查询及导出考勤数据', null, '123456', 'liushijuan', null);

-- ----------------------------
-- Table structure for `sys_account_role`
-- ----------------------------
DROP TABLE IF EXISTS `sys_account_role`;
CREATE TABLE `sys_account_role` (
  `ID` varchar(50) COLLATE utf8_bin NOT NULL,
  `ACCOUNTID` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `ROLEID` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of sys_account_role
-- ----------------------------
INSERT INTO `sys_account_role` VALUES ('1e03b77f-373f-11e8-b886-001a7dda7111', '94cda673-eeb5-4bbc-a910-21e509c00cd8', 'r1');
INSERT INTO `sys_account_role` VALUES ('3ebddafd-76ec-11e9-b1cc-1831bfb08376', 'c2f6d3dc-265c-4b95-9dd2-cb203ca053df', '17f80704-1a24-4dc5-adc7-bccb31c746dd');
INSERT INTO `sys_account_role` VALUES ('46de95aa-1b5c-11e8-881c-1831bf2ffe4d', '12cf8b50-e4c1-4d0d-a752-e7d381be595c', 'c3ceb4c0-f4a3-46b3-802e-19e4ad6e8f3a');
INSERT INTO `sys_account_role` VALUES ('4fd34d78-76ec-11e9-b1cc-1831bfb08376', '33c66e16-b347-48c4-a405-b6934a1675ac', '17f80704-1a24-4dc5-adc7-bccb31c746dd');
INSERT INTO `sys_account_role` VALUES ('5289badb-06ea-11e8-86ac-28936c61a107', 'b5762e61-d997-42e7-8d85-5e1ae6e45f2a', 'r1');
INSERT INTO `sys_account_role` VALUES ('5a561886-76ec-11e9-b1cc-1831bfb08376', '63c68bcb-4208-4ed5-9a61-0f7c2dca0f01', '17f80704-1a24-4dc5-adc7-bccb31c746dd');
INSERT INTO `sys_account_role` VALUES ('8821aea1-0fbe-11e8-881c-1831bf2ffe4d', '537d8acf-28f4-49ed-bc62-f41e3e69ee80', 'c3ceb4c0-f4a3-46b3-802e-19e4ad6e8f3a');
INSERT INTO `sys_account_role` VALUES ('92bf43b4-0564-11e8-86ac-28936c61a107', '861a74a2-4c1e-4a79-8cb2-7e8d3df908c6', '30b4f3b5-9f26-487f-a4b2-63d5caf0fcec');
INSERT INTO `sys_account_role` VALUES ('9bfc7c74-0fb7-11e8-881c-1831bf2ffe4d', '25008036-e10a-4a80-8190-f764f9edacc3', '374e51d4-31a4-4749-ab55-4cf6841aca16');
INSERT INTO `sys_account_role` VALUES ('ar1', 'a1', 'r1');
INSERT INTO `sys_account_role` VALUES ('c59125ac-0564-11e8-86ac-28936c61a107', '5c940a8f-a5c5-4b9b-ae0d-a732ef22aacd', 'c3ceb4c0-f4a3-46b3-802e-19e4ad6e8f3a');
INSERT INTO `sys_account_role` VALUES ('ca630c20-0f97-11e8-a3d1-1831bf2ffe4d', 'f2abd777-5b87-441d-a28b-d029b3a63efa', 'c3ceb4c0-f4a3-46b3-802e-19e4ad6e8f3a');
INSERT INTO `sys_account_role` VALUES ('e2cd5ac4-1ace-11e9-849c-1831bfb08376', 'b50d50a6-9312-45d4-9a28-acc3cdff93d8', '17f80704-1a24-4dc5-adc7-bccb31c746dd');
INSERT INTO `sys_account_role` VALUES ('f1f46b1f-33bd-11e8-9d5f-1831bf2ffe4d', '4f536e4b-4041-458b-b99d-a757738da6b9', 'r1');

-- ----------------------------
-- Table structure for `sys_account_user`
-- ----------------------------
DROP TABLE IF EXISTS `sys_account_user`;
CREATE TABLE `sys_account_user` (
  `ID` varchar(50) COLLATE utf8_bin NOT NULL,
  `ACCOUNTID` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `USERID` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of sys_account_user
-- ----------------------------
INSERT INTO `sys_account_user` VALUES ('02f4893f-75a0-4979-be66-e8eb795185cd', '63c68bcb-4208-4ed5-9a61-0f7c2dca0f01', '3cc2fce0-fc2f-447a-a6fe-1ae1b8a58489');
INSERT INTO `sys_account_user` VALUES ('0ddcc227-5838-44e7-992a-3a4153ab95b7', '12cf8b50-e4c1-4d0d-a752-e7d381be595c', '1bc5bbea-a3bc-4b31-97fe-9dcf9599f9d1');
INSERT INTO `sys_account_user` VALUES ('1126c824-d9fc-4981-a028-1d457785bd32', '25008036-e10a-4a80-8190-f764f9edacc3', 'a4d664ed-183b-4d43-9d6a-6712dedff15c');
INSERT INTO `sys_account_user` VALUES ('311a1522-3f3e-486d-aee8-ae7165bb55d7', '5c940a8f-a5c5-4b9b-ae0d-a732ef22aacd', '1bc5bbea-a3bc-4b31-97fe-9dcf9599f9d1');
INSERT INTO `sys_account_user` VALUES ('33514d2b-9ec4-4a5e-8100-9e38f3284f25', '537d8acf-28f4-49ed-bc62-f41e3e69ee80', 'a4d664ed-183b-4d43-9d6a-6712dedff15c');
INSERT INTO `sys_account_user` VALUES ('5280714f-2e9a-4850-bdc4-28dbb664daf1', '94cda673-eeb5-4bbc-a910-21e509c00cd8', '69148317-c85c-4631-8cf6-91b487942d40');
INSERT INTO `sys_account_user` VALUES ('5442fa11-7fde-4990-ae97-ffd35e4e0ff7', '861a74a2-4c1e-4a79-8cb2-7e8d3df908c6', '1bc5bbea-a3bc-4b31-97fe-9dcf9599f9d1');
INSERT INTO `sys_account_user` VALUES ('7a780def-8b7e-46cf-8516-4313e99cb78d', '33c66e16-b347-48c4-a405-b6934a1675ac', 'd17a3399-957a-4f1b-9169-6689125546bb');
INSERT INTO `sys_account_user` VALUES ('91d5f0c6-4a43-4ab9-a446-09d543af399a', 'f2abd777-5b87-441d-a28b-d029b3a63efa', 'edfe5822-6dee-43bc-b22b-8643771a23bb');
INSERT INTO `sys_account_user` VALUES ('9adfb793-204e-463e-9a6a-5cd7476634d1', '4f536e4b-4041-458b-b99d-a757738da6b9', '991a2a4c-6b31-4e23-a80d-3829df58b8f3');
INSERT INTO `sys_account_user` VALUES ('a8a474c3-604e-4ff9-b2bd-07e8287f4612', 'b5762e61-d997-42e7-8d85-5e1ae6e45f2a', '1bc5bbea-a3bc-4b31-97fe-9dcf9599f9d1');
INSERT INTO `sys_account_user` VALUES ('ab537c68-c67c-4ed7-b05b-53948468df56', 'c2f6d3dc-265c-4b95-9dd2-cb203ca053df', '4c62f9bc-86fa-433e-a540-5c23b71148a2');
INSERT INTO `sys_account_user` VALUES ('au1', 'a1', '1');
INSERT INTO `sys_account_user` VALUES ('fe09ea8b-0e6e-452a-ae68-54b7dd3125cd', 'b50d50a6-9312-45d4-9a28-acc3cdff93d8', '62636c99-d4d3-4117-b7a4-5be38cb786c5');

-- ----------------------------
-- Table structure for `sys_authority`
-- ----------------------------
DROP TABLE IF EXISTS `sys_authority`;
CREATE TABLE `sys_authority` (
  `ID` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `CREATETIME` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `UPDATETIME` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `IFUSE` varchar(2) COLLATE utf8_bin DEFAULT NULL,
  `AUTHORITYNAME` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `ORDERNUM` varchar(10) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of sys_authority
-- ----------------------------
INSERT INTO `sys_authority` VALUES ('auth1', '2017-08-29 09:37:10', '2017-08-29 09:37:10', 'y', '最高级权限', '获取所有内容', '01');
INSERT INTO `sys_authority` VALUES ('a5d626b8-da75-47a6-9289-67e35f0ede9b', '2019-01-18 11:11:23', '2019-01-18 11:11:23', 'y', '助理权限', '助理权限', null);

-- ----------------------------
-- Table structure for `sys_csresult`
-- ----------------------------
DROP TABLE IF EXISTS `sys_csresult`;
CREATE TABLE `sys_csresult` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '存放CS端返回的数据',
  `photoId` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `result` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of sys_csresult
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_csresult1`
-- ----------------------------
DROP TABLE IF EXISTS `sys_csresult1`;
CREATE TABLE `sys_csresult1` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'BS端存储样本信息的ID和CollectId',
  `photoId` int(10) DEFAULT NULL,
  `photoCollectId` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of sys_csresult1
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_importuser1_tmp`
-- ----------------------------
DROP TABLE IF EXISTS `sys_importuser1_tmp`;
CREATE TABLE `sys_importuser1_tmp` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `parentOrgName` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `orgName` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `orgId` int(10) DEFAULT NULL,
  `employee` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `placeId` int(10) DEFAULT NULL,
  `collectId` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of sys_importuser1_tmp
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_importuser_tmp`
-- ----------------------------
DROP TABLE IF EXISTS `sys_importuser_tmp`;
CREATE TABLE `sys_importuser_tmp` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `orgId` int(10) DEFAULT NULL,
  `placeId` int(10) DEFAULT NULL,
  `type` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of sys_importuser_tmp
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_org`
-- ----------------------------
DROP TABLE IF EXISTS `sys_org`;
CREATE TABLE `sys_org` (
  `ID` int(50) NOT NULL AUTO_INCREMENT,
  `ORGNAME` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `CREATETIME` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `UPDATETIME` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `IFUSE` varchar(1) COLLATE utf8_bin DEFAULT NULL,
  `ORDERNUM` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `PARENTID` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `PARENTNAME` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `PATH` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of sys_org
-- ----------------------------
INSERT INTO `sys_org` VALUES ('1', '航天长峰', '2017-04-30 12:12:12', '2017-04-30 12:12:12', 'y', '1', 'root', '总部', 'root-航天长峰');
INSERT INTO `sys_org` VALUES ('28', '外来人员', '2018-01-15 09:10:31', '2018-01-15 09:10:31', 'n', '2', '1', '航天长峰', null);
INSERT INTO `sys_org` VALUES ('35', '产品部', '2018-01-25 17:48:14', '2018-01-25 17:48:14', 'y', '3', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('36', '科工二院领导', '2018-01-26 08:27:40', '2018-01-26 08:27:40', 'n', '3', '28', '外来人员', null);
INSERT INTO `sys_org` VALUES ('38', '股份领导', '2018-01-29 15:22:22', '2018-01-29 15:22:22', 'y', '3', '40', '长峰股份', null);
INSERT INTO `sys_org` VALUES ('39', '长峰科技', '2018-03-21 01:57:28', '2018-03-21 01:57:28', 'y', '3', '1', '航天长峰', null);
INSERT INTO `sys_org` VALUES ('40', '长峰股份', '2018-03-30 10:36:51', '2018-03-30 10:36:51', 'y', '2', '1', '航天长峰', null);
INSERT INTO `sys_org` VALUES ('41', '集成项目部', '2018-03-30 10:45:37', '2018-03-30 10:45:37', 'y', '3', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('42', '军工事业部', '2018-03-30 10:45:53', '2018-03-30 10:45:53', 'y', '3', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('43', '交通事业部', '2018-03-30 10:46:02', '2018-03-30 10:46:02', 'y', '3', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('44', '科技领导', '2018-03-30 10:46:31', '2018-03-30 10:46:31', 'y', '3', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('45', '营销部', '2018-03-30 10:47:21', '2018-03-30 10:47:21', 'y', '3', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('46', '综合管理部', '2018-03-30 10:50:01', '2018-03-30 10:50:01', 'y', '3', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('47', '质量技术部', '2018-04-03 20:28:22', '2018-04-03 20:28:22', 'y', '3', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('48', '财务部', '2018-04-03 20:28:57', '2018-04-03 20:28:57', 'y', '3', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('49', '经营计划部', '2018-04-03 20:29:15', '2018-04-03 20:29:15', 'y', '3', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('50', '人力资源部', '2018-04-03 20:29:52', '2018-04-03 20:29:52', 'y', '3', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('51', '采购部', '2018-04-27 17:45:27', '2018-04-27 17:45:27', 'y', '00', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('52', '股份员工', '2018-04-27 18:03:42', '2018-04-27 18:03:42', 'y', '00', '40', '长峰股份', null);
INSERT INTO `sys_org` VALUES ('54', '总工程师办公室', '2018-11-01 10:39:53', '2018-11-01 10:39:53', 'y', '00', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('55', '西南研发中心', '2018-11-01 15:05:14', '2018-11-01 15:05:14', 'y', '00', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('56', '战略合作发展部', '2018-11-01 15:27:14', '2018-11-01 15:27:14', 'y', '00', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('57', '财务部', '2019-01-03 15:30:02', '2019-01-03 15:30:02', 'y', '00', '40', '长峰股份', null);
INSERT INTO `sys_org` VALUES ('58', '党群纪检部', '2019-01-03 15:50:14', '2019-01-03 15:50:14', 'y', '00', '40', '长峰股份', null);
INSERT INTO `sys_org` VALUES ('59', '行政保障部', '2019-01-03 15:51:25', '2019-01-03 15:51:25', 'y', '00', '40', '长峰股份', null);
INSERT INTO `sys_org` VALUES ('60', '风险管控部', '2019-01-03 16:01:06', '2019-01-03 16:01:06', 'y', '00', '40', '长峰股份', null);
INSERT INTO `sys_org` VALUES ('61', '人力资源部', '2019-01-03 16:03:49', '2019-01-03 16:03:49', 'y', '00', '40', '长峰股份', null);
INSERT INTO `sys_org` VALUES ('62', '审计部', '2019-01-03 16:04:38', '2019-01-03 16:04:38', 'y', '00', '40', '长峰股份', null);
INSERT INTO `sys_org` VALUES ('63', '研究院', '2019-01-03 16:07:42', '2019-01-03 16:07:42', 'y', '00', '40', '长峰股份', null);
INSERT INTO `sys_org` VALUES ('64', '总裁办公室', '2019-01-03 16:12:08', '2019-01-03 16:12:08', 'y', '00', '40', '长峰股份', null);
INSERT INTO `sys_org` VALUES ('65', '新疆分公司', '2019-01-09 08:23:07', '2019-01-09 08:23:07', 'y', '00', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('66', '湖南分公司', '2019-01-09 09:19:58', '2019-01-09 09:19:58', 'y', '00', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('67', '广东分公司', '2019-01-09 10:00:14', '2019-01-09 10:00:14', 'y', '00', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('68', '企业发展部', '2019-01-09 10:16:59', '2019-01-09 10:16:59', 'y', '00', '40', '长峰股份', null);
INSERT INTO `sys_org` VALUES ('69', '航丰路六号院', '2019-01-09 10:26:34', '2019-01-09 10:26:34', 'y', '00', '40', '长峰股份', null);
INSERT INTO `sys_org` VALUES ('70', '科技委', '2019-01-09 10:35:09', '2019-01-09 10:35:09', 'y', '00', '40', '长峰股份', null);
INSERT INTO `sys_org` VALUES ('71', '证券投资部', '2019-01-09 11:00:42', '2019-01-09 11:00:42', 'y', '00', '40', '长峰股份', null);
INSERT INTO `sys_org` VALUES ('72', '其他', '2019-01-09 11:20:02', '2019-01-09 11:20:02', 'y', '00', '40', '长峰股份', null);
INSERT INTO `sys_org` VALUES ('73', '国际事业部', '2019-01-09 15:55:34', '2019-01-09 15:55:34', 'y', '00', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('74', '其他', '2019-01-09 16:10:38', '2019-01-09 16:10:38', 'y', '00', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('75', '深圳分公司', '2019-01-11 09:16:28', '2019-01-11 09:16:28', 'y', '00', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('76', '江苏分公司', '2019-01-11 09:44:45', '2019-01-11 09:44:45', 'y', '00', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('77', '四川分公司', '2019-01-11 13:50:05', '2019-01-11 13:50:05', 'y', '00', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('78', '甘肃分公司', '2019-01-11 13:53:16', '2019-01-11 13:53:16', 'y', '00', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('79', '广西分公司', '2019-01-11 13:56:10', '2019-01-11 13:56:10', 'y', '00', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('80', '吉林分公司', '2019-01-11 14:00:56', '2019-01-11 14:00:56', 'y', '00', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('81', '河南分公司', '2019-01-11 15:03:05', '2019-01-11 15:03:05', 'y', '00', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('82', '河北分公司', '2019-01-11 15:04:40', '2019-01-11 15:04:40', 'y', '00', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('83', '陕西办事处', '2019-01-11 15:07:10', '2019-01-11 15:07:10', 'y', '00', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('84', '浙江子公司', '2019-01-15 09:02:07', '2019-01-15 09:02:07', 'y', '00', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('85', '上海分公司', '2019-01-15 09:04:01', '2019-01-15 09:04:01', 'y', '00', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('86', '辽宁分公司', '2019-01-15 09:06:20', '2019-01-15 09:06:20', 'y', '00', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('87', '湖北分公司', '2019-01-18 10:10:46', '2019-01-18 10:10:46', 'y', '00', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('88', '江西分公司', '2019-01-18 10:12:35', '2019-01-18 10:12:35', 'y', '00', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('89', '云南办事处', '2019-01-18 10:14:00', '2019-01-18 10:14:00', 'y', '00', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('90', '航天精一', '2019-01-23 14:59:50', '2019-01-23 14:59:50', 'y', '00', '39', '长峰科技', null);
INSERT INTO `sys_org` VALUES ('91', '科工集团领导', '2019-02-26 09:52:26', '2019-02-26 09:52:26', 'n', '00', '28', '外来人员', null);
INSERT INTO `sys_org` VALUES ('92', '北京分公司', '2019-05-16 11:05:51', '2019-05-16 11:05:51', 'y', '00', '39', '长峰科技', null);

-- ----------------------------
-- Table structure for `sys_orgtree`
-- ----------------------------
DROP TABLE IF EXISTS `sys_orgtree`;
CREATE TABLE `sys_orgtree` (
  `ID` varchar(50) COLLATE utf8_bin NOT NULL,
  `ORGID` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `CHILDRENID` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of sys_orgtree
-- ----------------------------
INSERT INTO `sys_orgtree` VALUES ('017231de-54e1-4838-9058-61730bb88426', '1', 'd6be153d-a133-43bd-a945-bf2570391e07');
INSERT INTO `sys_orgtree` VALUES ('07ae65ee-1f6a-4866-a6aa-ee409dc07dea', 'a07d1b93-855d-4636-a5ae-575f45d0f6b5', '5a9ed7fd-47a8-4850-b535-aba5a9ae2257');
INSERT INTO `sys_orgtree` VALUES ('07bb28d0-dc00-440e-84c0-83753f8f76ca', '1', '96617674-6a65-4b1d-ae85-f814414f1cdb');
INSERT INTO `sys_orgtree` VALUES ('084c0593-19a2-4586-9582-3d8f6bb81b2a', 'b31cdec5-65f8-4f41-8267-98efd0f5ddde', '084c0593-19a2-4586-9582-3d8f6bb81b2a');
INSERT INTO `sys_orgtree` VALUES ('130cccfe-9387-4dd6-a5c7-c2098584185e', 'a07d1b93-855d-4636-a5ae-575f45d0f6b5', '2dd17e9e-943d-49a6-a0ea-8f0e73d8ddb6');
INSERT INTO `sys_orgtree` VALUES ('281247fb-babc-42c5-be9f-80bb1fba2c07', 'd6be153d-a133-43bd-a945-bf2570391e07', '0b9eadcf-fa67-49a3-bbe9-b5ee7186db7d');
INSERT INTO `sys_orgtree` VALUES ('45227c3f-fd63-415f-9f5e-385e1fcf5e67', '96617674-6a65-4b1d-ae85-f814414f1cdb', 'ebf28e8f-133a-47ff-966f-3cc6061a95b8');
INSERT INTO `sys_orgtree` VALUES ('68670fb1-0048-47d3-bc3b-6d244d5cb72c', '2dd17e9e-943d-49a6-a0ea-8f0e73d8ddb6', '8de844bc-89c7-40e4-af6b-0017c8547868');
INSERT INTO `sys_orgtree` VALUES ('7a6768ec-992d-4554-9ff9-caed6a2a837a', 'd6be153d-a133-43bd-a945-bf2570391e07', '3614bcee-06a1-4639-a352-eaee4538145c');
INSERT INTO `sys_orgtree` VALUES ('a36ebee7-38d1-412f-9dc0-23d772e400f4', 'a07d1b93-855d-4636-a5ae-575f45d0f6b5', 'e0502c03-e130-4f70-bec9-32f1fd22d48f');
INSERT INTO `sys_orgtree` VALUES ('cf36f723-d89b-478d-8687-08dc0f2736c6', '1', 'a07d1b93-855d-4636-a5ae-575f45d0f6b5');

-- ----------------------------
-- Table structure for `sys_resource`
-- ----------------------------
DROP TABLE IF EXISTS `sys_resource`;
CREATE TABLE `sys_resource` (
  `ID` varchar(50) COLLATE utf8_bin NOT NULL,
  `RESOURCENAME` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `TYPE` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `PARENTID` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `PARENTNAME` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `APPNAME` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `URL` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `LEVEL` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `ISMENULEAF` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `CREATETIME` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `UPDATETIME` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `IFUSE` varchar(2) COLLATE utf8_bin DEFAULT NULL,
  `ORDERNUM` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of sys_resource
-- ----------------------------
INSERT INTO `sys_resource` VALUES ('1', 'app.user', '人员管理', 'MENU', 'root', 'root', null, '/user/list', '1', 'y', '2017-04-05 12:12:12', '2017-04-05 12:12:12', 'y', '4');
INSERT INTO `sys_resource` VALUES ('14', 'ACCOUNT_ALL', '查询所有用户', 'web', 'c', 'root', 'maApp', '/login', '1', 'y', '2017-01-13 12:12:12', '2017-01-13 12:12:12', 'y', '0');
INSERT INTO `sys_resource` VALUES ('15', '/resource/menus', '获取菜单', 'api', 'root', 'root', null, '/resource/menus/', '1', 'y', '2017-04-05 12:12:12', '2017-04-05 12:12:12', 'y', '8');
INSERT INTO `sys_resource` VALUES ('16', 'app.config', '配置数据', 'MENU', 'root', 'root', null, '/save/list', '1', 'y', '2017-04-05 12:12:12', '2017-04-05 12:12:12', 'y', '15');
INSERT INTO `sys_resource` VALUES ('17', 'app.query', '查询统计', 'MENU', 'root', 'root', null, '/query/list', '1', 'y', '2017-04-05 12:12:12', '2017-04-05 12:12:12', 'y', '17');
INSERT INTO `sys_resource` VALUES ('18', 'app.face', '实时识别', 'MENU', 'root', 'root', null, '/face/list', '1', 'y', '2017-04-05 12:12:12', '2017-04-05 12:12:12', 'y', '18');
INSERT INTO `sys_resource` VALUES ('2', 'app.account', '账户列表', 'MENU', 'root', 'root', null, '/account/list', '1', 'y', '2017-04-05 12:12:12', '2017-04-05 12:12:12', 'y', '9');
INSERT INTO `sys_resource` VALUES ('3', 'app.role', '角色管理', 'MENU', 'root', 'root', null, '/role/list', '1', 'y', '2017-04-05 12:12:12', '2017-04-05 12:12:12', 'y', '5');
INSERT INTO `sys_resource` VALUES ('4', 'app.authority', '权限管理', 'MENU', 'root', 'root', null, '/authority/list', '1', 'y', '2017-04-05 12:12:12', '2017-04-05 12:12:12', 'y', '7');
INSERT INTO `sys_resource` VALUES ('5', 'app.resource', '菜单管理', 'web', 'root', 'root', null, '/resource/list', '1', 'y', '2017-04-05 12:12:12', '2017-04-05 12:12:12', 'y', '6');

-- ----------------------------
-- Table structure for `sys_resource_authority`
-- ----------------------------
DROP TABLE IF EXISTS `sys_resource_authority`;
CREATE TABLE `sys_resource_authority` (
  `ID` varchar(50) COLLATE utf8_bin NOT NULL,
  `AUTHORITYID` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `RESOURCEID` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of sys_resource_authority
-- ----------------------------
INSERT INTO `sys_resource_authority` VALUES ('1db29a18-8f4c-4115-bfbb-5834a676a9ec', 'auth1', '14');
INSERT INTO `sys_resource_authority` VALUES ('31a4e929-98af-45a0-8b7b-b1bc1dfdc463', 'auth1', '17');
INSERT INTO `sys_resource_authority` VALUES ('3d92ec1c-dc32-4e2d-a568-6a339301f20f', 'a5d626b8-da75-47a6-9289-67e35f0ede9b', '15');
INSERT INTO `sys_resource_authority` VALUES ('43754d56-a0d8-4b18-841c-9faeedf6a67e', 'auth1', '15');
INSERT INTO `sys_resource_authority` VALUES ('74db3925-0357-44b9-93ad-c9fe66f6a27e', 'auth1', '16');
INSERT INTO `sys_resource_authority` VALUES ('7b51f38d-aee5-4f2e-a55a-925d5c7d319d', 'a5d626b8-da75-47a6-9289-67e35f0ede9b', '16');
INSERT INTO `sys_resource_authority` VALUES ('8c7f46bb-a8f5-43e3-8974-797255efe90a', 'a5d626b8-da75-47a6-9289-67e35f0ede9b', '17');
INSERT INTO `sys_resource_authority` VALUES ('a9a933cf-7899-4e91-8ae0-c31f7a0d8456', 'a5d626b8-da75-47a6-9289-67e35f0ede9b', '14');
INSERT INTO `sys_resource_authority` VALUES ('aae035a7-3a22-4611-8027-c6c18a201f98', 'auth1', '2');
INSERT INTO `sys_resource_authority` VALUES ('b21d82ca-2b1f-49da-b53e-8a43f1429c0f', 'auth1', '4');
INSERT INTO `sys_resource_authority` VALUES ('c05baaea-417e-438e-bcce-2a43f9830cc7', 'auth1', '1');
INSERT INTO `sys_resource_authority` VALUES ('dda80be4-ae95-432c-8e55-edbb846e6954', 'auth1', '3');
INSERT INTO `sys_resource_authority` VALUES ('df6d27d8-6c1c-49d8-a5e9-26c2bd2115af', 'auth1', '18');
INSERT INTO `sys_resource_authority` VALUES ('e968fea2-6780-4879-9cc0-e01339123f7e', 'a5d626b8-da75-47a6-9289-67e35f0ede9b', '1');

-- ----------------------------
-- Table structure for `sys_role`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `ID` varchar(50) COLLATE utf8_bin NOT NULL,
  `ROLENAME` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `CREATETIME` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `UPDATETIME` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `IFUSE` varchar(2) COLLATE utf8_bin DEFAULT NULL,
  `ORDERNUM` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('17f80704-1a24-4dc5-adc7-bccb31c746dd', '助理', '查询及导出考勤数据', '2019-01-18 11:11:49', '2019-01-18 11:11:49', 'y', '2');
INSERT INTO `sys_role` VALUES ('r1', '管理员', '1', '2018-02-12 13:41:16', '2018-02-12 13:41:16', 'y', '1');

-- ----------------------------
-- Table structure for `sys_role_authority`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_authority`;
CREATE TABLE `sys_role_authority` (
  `ID` varchar(50) COLLATE utf8_bin NOT NULL,
  `AUTHORITYID` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `ROLEID` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of sys_role_authority
-- ----------------------------
INSERT INTO `sys_role_authority` VALUES ('5029546f-b4e1-4d71-b48f-a7fa36450f7e', 'auth1', '2170f81b-1fc3-49af-bbc7-15aa7fec86ff');
INSERT INTO `sys_role_authority` VALUES ('b293e8cd-2dbd-4b43-9440-e8ada9763bd6', 'a5d626b8-da75-47a6-9289-67e35f0ede9b', '17f80704-1a24-4dc5-adc7-bccb31c746dd');
INSERT INTO `sys_role_authority` VALUES ('fdee9360-dc97-4e7b-938a-d25e1ea23414', 'auth1', '59b9cfff-b040-488a-89f5-38da565dbd38');
INSERT INTO `sys_role_authority` VALUES ('role1', 'auth1', 'r1');

-- ----------------------------
-- Table structure for `sys_userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `sys_userinfo`;
CREATE TABLE `sys_userinfo` (
  `ID` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '用户id',
  `REALNAME` varchar(200) COLLATE utf8_bin NOT NULL COMMENT '用户姓名',
  `PICTURE` varchar(300) COLLATE utf8_bin DEFAULT NULL COMMENT '头像',
  `PARENTORG` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `ORG` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '部门',
  `POLICENUM` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '工号',
  `AUTOGRAPH` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '考勤地点',
  `CREATETIME` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `UPDATETIME` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `ORGID` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '部门id',
  `CollectId` int(10) DEFAULT NULL COMMENT '采集人员编号（唯一）',
  `BeIsRegistered` int(10) DEFAULT '0',
  `BeIsDeleted` int(10) DEFAULT '0' COMMENT '人员信息不再使用状态：1为删除，2为离职，3为退休，4转出，',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of sys_userinfo
-- ----------------------------
INSERT INTO `sys_userinfo` VALUES ('00da4154-fd31-4278-beaa-a630f6a110bc', '汪霞', 'fbafc567-b57e-4389-9358-d2e55b8c7a17', '外来人员', '科工二院领导', '无', '1', '2019-02-26 11:36:27', '2019-02-26 11:36:27', '36', '486', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('018f152f-0e7c-4751-aa48-375ace4727af', '张宏利', 'bc027ec3-f5da-43f0-94d3-e45800761b24', '长峰科技', '航天精一', '无', '1', '2019-01-23 15:00:08', '2019-01-23 15:00:08', '36', '460', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('02c79f98-d246-435c-bcf1-703c9965364d', '张世贤', '4663716e-a39a-4312-b960-95167d821549', '长峰科技', '交通事业部', '无', '2', '2019-01-11 15:08:26', '2019-01-11 15:08:41', '43', '425', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('02e096b1-3990-42a8-ab36-a7e1727c9946', '邵延涛', 'd2be19a5-680f-4ddf-831c-d039e85e6b6c', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:05', '2018-11-01 14:18:05', '41', '169', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('03af8cee-21a2-4d2a-a2e9-96b5cda9b4e1', '李维娜', 'f584852e-d95e-47b9-93f7-7d5c94dfc9a0', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:09', '2018-11-01 15:23:09', '45', '340', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('044a5f72-3369-4a88-915a-be64beb9187d', '李大鹏', '009e1925-765c-408d-8f3d-520d3bb94f21', '长峰科技', '科技领导', '无', '1', '2019-01-15 08:56:54', '2019-01-15 08:56:54', '44', '440', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('050116af-66db-44a1-ad8b-7eb486392cea', '卢鑫', '703944c9-a7fa-450e-aa29-fcb54e0a2ffc', '长峰科技', '西南研发中心', ' ', '2', '2018-11-01 15:05:34', '2018-11-01 15:05:34', '55', '303', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('05b78850-1f64-47a1-8f4a-4794d189897b', '高雁鸬', 'f9321a5e-9202-4b74-ac7f-2b72f59e70f2', '长峰股份', '行政保障部', ' ', '1', '2018-11-01 14:15:19', '2019-01-09 10:23:47', '59', '66', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('07a8d42d-6ab4-4322-8d6b-c5e2b6b981f7', '缪新华', '3a092873-1cf0-4026-aff7-a91095d5dc23', '长峰科技', '湖北分公司', '无', '1', '2019-01-18 10:11:23', '2019-01-18 10:11:23', '87', '447', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('080756f9-7125-4c3a-9dc9-68b0313d3985', '沈媛', '58b57931-9e2f-49a2-97d0-eb9630ce55be', '长峰科技', '人力资源部', ' ', '1', '2018-11-01 14:56:14', '2018-11-01 14:56:14', '50', '292', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('085c52ee-59f1-465b-ada9-d7a37bd09354', '史燕中', 'c2a0025e-3c1b-4111-9927-44cb9fe19b1d', '长峰股份', '股份领导', ' ', '1', '2018-11-01 14:15:22', '2019-01-09 11:17:28', '38', '93', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('089de019-88e8-4fbc-b6c7-cd139e836836', '李浩', '1c9a2474-dee5-422d-ab18-19d779b15fb1', '长峰科技', '西南研发中心', ' ', '2', '2018-11-01 15:05:34', '2018-11-01 15:05:34', '55', '307', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('09387116-2621-4e2d-b1e6-a66df5862c2d', '王智广', '10c6e61d-2dc3-4225-a188-75ae28383a0f', '长峰科技', '综合管理部', ' ', '1', '2018-11-01 15:32:26', '2018-11-01 15:32:26', '46', '368', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('094d6148-46c1-4062-a558-229ac2a9b5ff', '高天翔', 'eb499f40-2ea4-4441-b780-75f824e1a09f', '长峰股份', '财务部', '', '1', '2019-01-03 15:45:40', '2019-01-03 15:45:40', '57', '381', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('09c97870-4c03-4bcc-9c91-38d9cae4e680', '庄楠', '17f54da7-4ff0-4c89-9673-138b189d245b', '长峰科技', '国际事业部', '无', '1', '2019-01-11 14:18:31', '2019-01-11 14:18:31', '73', '413', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('09c98bfb-612e-4019-a425-a0cf97fe4cf7', '叶汝新', '8b792e68-5cad-4256-b393-10504f8c7055', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:08', '2018-11-01 14:18:08', '41', '201', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('0a2d0a38-0220-4424-bda9-f6bfbb8361ea', '徐强', '62250183-1df5-4f64-8d14-a003dc2f9497', '外来人员', '科工集团领导', '无', '1', '2019-02-26 10:00:45', '2019-02-26 10:00:45', '91', '471', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('0a78f54e-7d2c-4947-8dda-4f31aaeddde7', '彭爱平', '8a27a89e-20c7-418d-9c4f-0aab0ff4f4ab', '长峰科技', '质量技术部', ' ', '1', '2018-11-01 15:31:18', '2018-11-01 15:31:18', '47', '365', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('0b362a79-ed8f-490c-aa8b-42c067f70339', '唐金辉', '498f7243-cdf9-48b7-b9de-078602ac697f', '长峰科技', '西南研发中心', ' ', '2', '2018-11-01 10:46:33', '2019-01-08 13:52:55', '55', '19', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('0b5be358-feac-435b-b1e0-8130295e62b3', '高凤贤', '9b78d905-20bd-4ede-b2ef-f4d66ce36e66', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:03', '2018-11-01 14:18:03', '41', '152', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('0bb2000b-2baf-4256-80ab-24dfca039cae', '杨建超', '4221fa0c-6829-4ebd-bb91-01f688dda02c', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:10', '2018-11-01 14:18:10', '41', '218', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('0bb925c0-949b-4745-a5b1-803986c8b5b9', '苏子华', '07940cf7-3380-424c-aeb2-fcc34b8ad726', '长峰股份', '股份领导', ' ', '1', '2018-11-01 14:15:25', '2019-01-03 16:52:28', '38', '139', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('0c2e0fbb-4c90-420d-906d-f682e4356177', '田培森', 'd4e1a3fd-ec26-4721-9f63-1b254b2d14c1', '长峰科技', '科技领导', '无', '1', '2019-01-14 09:51:19', '2019-01-14 09:51:19', '44', '433', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('0ec758e4-ef60-46e2-982f-8449436de98f', '赵辉', '1c776acd-dca9-4cbc-867a-2c07e38c8541', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:06', '2018-11-01 14:53:06', '42', '265', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('0f3b001f-aba5-40a6-9e3f-4f7f84dd9a7c', '郭平', '5d77a3fe-2dcf-4877-b6b7-2d564ae5d4cc', '长峰科技', '上海分公司', '无', '1', '2019-01-15 09:04:18', '2019-01-15 09:04:18', '85', '443', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('0fa93539-1661-448b-bb7b-71a40c1b3059', '刘刚', '428afdc6-a2ee-47f5-adef-82a65cc345bf', '长峰科技', '北京分公司', ' ', '1', '2018-11-01 14:18:08', '2019-05-16 11:14:34', '92', '194', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('0fafbac6-4b5e-4e05-8e9d-851be0033636', '白钢', 'd107f9ee-b35d-4c68-93cc-075b4941c66d', '长峰科技', '营销部', '无', '1', '2019-01-11 09:56:25', '2019-01-11 14:09:57', '45', '399', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('1', '管理员', '56c014ec-9b89-4dd6-aba3-e76ca881d208', '长峰科技', '产品部', 'admin', '2', '2017-08-22 08:58:20', '2018-11-01 10:44:58', '35', '0', '1', '1');
INSERT INTO `sys_userinfo` VALUES ('101d30df-d453-4651-bedc-57ac86d59302', '孙大鹏', '0218246e-6595-4709-82d3-382eebc322dd', '长峰科技', '经营计划部', ' ', '1', '2018-11-01 14:43:14', '2018-11-01 14:43:14', '49', '254', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('10361c04-5d29-4a6c-b708-8c5f07e567e7', '贾承翰', 'ee365a34-4f8b-4407-b8ea-5db6fdee865f', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:35', '2018-11-01 10:46:35', '35', '40', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('1098ff2a-f7b0-4f4c-8cd2-0b9e62c1d65a', '张静娟', 'cde56d26-6715-4f31-8f2c-db7d30eb0688', '长峰科技', '战略合作发展部', ' ', '1', '2018-11-01 15:27:28', '2018-11-01 15:27:28', '56', '357', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('11855500-b9e0-4121-b3a7-70dd54144513', '曹庆杰', 'e7cde09c-97b9-413e-843e-9579b5524549', '长峰科技', '广东分公司', '无', '1', '2019-01-23 14:24:46', '2019-01-29 10:38:38', '67', '457', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('1197a56b-6919-4e50-9ad4-cf656e99ad66', '王咏', '287ae547-5baf-4b97-8204-c4dc56a1f491', '长峰股份', '总裁办公室', ' ', '1', '2018-11-01 14:15:24', '2018-11-01 14:15:24', '64', '125', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('11b5e40b-10ea-42f9-8376-05fbafe6a73c', '赵赟', 'efa5903c-986f-4201-9124-f0cf4997f65f', '长峰股份', '党群纪检部', ' ', '1', '2018-11-01 14:15:20', '2019-01-09 10:40:21', '58', '74', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('11b98fc1-15fa-4eb0-97cc-2bbc9ae1f537', '赵凯', '955bcf7b-8c69-4c94-a790-c635fe24d937', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:06', '2018-11-01 14:53:06', '42', '267', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('12203530-4021-4729-b7d2-f10008a496f3', '刘钧', 'b5358e54-a897-43a7-8d82-a665889cce05', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:07', '2018-11-01 14:18:07', '41', '191', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('124e36ea-0f08-4fd5-a4db-8a15a70a87e5', '高昊飞', '40b40bc6-f26b-428e-8b0c-deb64a26c06d', '长峰科技', '总工程师办公室', ' ', '2', '2018-11-01 10:41:23', '2018-11-01 10:41:23', '54', '2', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('128899f4-c26e-483f-9c87-b75a332d62ea', '张雪', 'a26a0173-422d-465a-87da-9a2cf0771480', '长峰科技', '综合管理部', ' ', '1', '2018-11-01 15:32:26', '2018-11-01 15:32:26', '46', '371', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('133613f8-45f9-4e1d-9626-fbf28e7cc76b', '庄开山', '132efebc-d604-4f81-9237-817b3392b6cc', '长峰股份', '行政保障部', ' ', '1', '2018-11-01 14:15:21', '2019-01-09 10:49:42', '59', '81', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('1376d0ae-d550-4a12-b3c3-639cff80d2ae', '徐晋洲', '00df2d2b-fdb8-476a-822a-00ad7ea15e16', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:06', '2019-01-11 14:22:52', '45', '319', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('1493332d-57b5-4595-8f8c-4f5da58f6edc', '刘康宁', 'fe92e6eb-6763-4fe5-87c9-8405276aa8e8', '长峰科技', '财务部', '无', '1', '2019-01-11 14:14:32', '2019-01-11 14:14:32', '48', '410', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('14aa20c6-9148-4f43-80e1-874dd95ac5ab', '杨笔豪', '2daa2d4a-e52e-417d-b153-0afe3b1a5b23', '外来人员', '科工二院领导', '无', '1', '2019-02-26 11:38:36', '2019-02-26 11:38:36', '36', '491', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('14be19cb-91fa-4cde-b977-bbad2e65ad8e', '宁勇', '7b0034f9-74b2-481e-a95a-0ae604d6da56', '长峰科技', '新疆分公司', '无', '1', '2019-01-11 14:20:17', '2019-01-11 14:20:17', '65', '414', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('14c88b58-c71d-488e-945a-ff054a107deb', '张文飞', 'f4477210-32a3-451a-9bd3-c5562e69b4e2', '长峰股份', '行政保障部', ' ', '1', '2018-11-01 14:15:20', '2019-01-09 10:44:39', '59', '77', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('15a96e34-de3e-420d-b0ab-a9a870a5da23', '马利伟', 'a3aaf520-8891-46e7-a45e-6d4fb90d002f', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:04', '2018-11-01 14:18:04', '41', '153', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('15c6c66e-c6a3-4787-b2e1-b61554d35a8e', '郭智勇', 'e43bd52b-96c3-40f3-b69c-6e6b74b1f799', '长峰股份', '科技委', ' ', '1', '2018-11-01 14:15:20', '2019-01-09 10:35:27', '70', '71', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('15cf38ab-1461-4964-aaf5-e62fcaba0c4f', '廖玲丽', 'c20d61f4-590d-458a-88f7-3e3f9100b965', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:06', '2018-11-01 14:18:06', '41', '183', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('16728b3d-cd08-411f-b6c2-0bb0f06a2f18', '张有维', 'bffe18fa-4314-4a2a-9aad-56da8777d630', '外来人员', '科工二院领导', '无', '1', '2019-02-26 11:40:07', '2019-02-26 11:40:07', '36', '494', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('16995181-8b48-436c-b141-8e4ed6a89123', '赵斌', 'bcd537dd-a0a9-492d-b45c-5491f58cbd02', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:06', '2018-11-01 14:53:06', '42', '266', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('16efa7fd-a617-4595-852e-9621f9673617', '王玥', 'bb6352f3-3315-4dd1-b78c-3e5d6e2a5b5f', '长峰科技', '产品部', '无', '2', '2019-03-28 16:40:28', '2019-03-28 16:40:28', '35', '503', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('1784dd21-224c-4694-8668-7e18f937d2b5', '崔玮怡', '33f9a2d4-8c16-47b8-afa9-4d1ca008e6fd', '长峰科技', '战略合作发展部', '无', '1', '2019-01-23 09:07:31', '2019-01-23 09:07:31', '56', '454', '1', '1');
INSERT INTO `sys_userinfo` VALUES ('17b239a1-96d8-43ad-9d28-18ddb2bf41a2', '鹿晓松', 'ad76c5aa-05f0-457a-86ab-f529e2e18fb2', '长峰股份', '行政保障部', ' ', '1', '2018-11-01 14:15:19', '2019-01-09 10:19:54', '59', '64', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('17bed9c1-61ae-42cd-9729-20824ba8a883', '樊龙', '08831ec1-219b-49ff-a556-8acf37991b3c', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:34', '2018-11-01 10:46:34', '35', '31', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('1873c631-3806-4ab4-88e9-873553f451ec', '邓榕', '49724559-c026-4a0e-8327-6ae6e9cadda9', '长峰科技', '战略合作发展部', ' ', '1', '2018-11-01 15:23:06', '2019-01-09 09:16:57', '56', '316', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('18df5bae-fff4-4455-9993-7f8967ef9fab', '周万金', 'cd4fa236-8b57-4feb-9241-da8adc148744', '长峰科技', '军工事业部', '无', '2', '2019-01-11 16:52:35', '2019-01-11 16:52:35', '42', '427', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('196d1960-1d5a-4ca3-8f4a-9a78a20b34b4', '徐明', '34d73081-ed87-4f94-be00-3e5e58358bad', '长峰科技', '新疆分公司', '无', '1', '2019-01-23 14:21:44', '2019-01-23 14:21:44', '65', '455', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('19717dad-c774-410d-a7fa-b2c293cf6e9d', '李立超', '6b74c177-40a4-4844-ae6e-826501eded97', '长峰科技', '产品部', '无', '2', '2019-04-01 08:22:07', '2019-04-01 08:22:07', '35', '504', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('1a0da168-77f9-4d8e-843f-f30ced16ae52', '高原', '2292121f-83df-4798-8205-0ce2c59dfec2', '外来人员', '科工二院领导', '无', '1', '2019-02-26 11:31:47', '2019-02-26 11:31:47', '36', '474', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('1a39911d-ac61-4645-88e3-e10cd51da69a', '邓华阳', '12ec6e01-51bc-4a53-8fb9-926aee2e2096', '长峰科技', '西南研发中心', ' ', '2', '2018-11-01 15:05:33', '2018-11-01 15:05:33', '55', '294', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('1a67e67c-baf1-4e90-8b4f-a07644e10040', '罗芳', 'f1b4c8b8-5134-415f-bfa5-bdc18928ce7d', '长峰科技', '战略合作发展部', ' ', '1', '2018-11-01 15:27:28', '2018-11-01 15:27:28', '56', '360', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('1ab64f92-45d9-430d-a950-2fb926b5ec27', '刘洋', 'cb29b776-3786-425f-9fed-b6b35f05f7a7', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:08', '2018-11-01 15:23:08', '45', '334', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('1b3ed2b2-1ac7-4aa9-8120-3ef03936247d', '闫庚翔', '4430a2d5-1fe3-4a4a-84e5-01f553bc239d', '长峰科技', '广东分公司', '无', '1', '2019-01-14 10:06:41', '2019-01-14 10:06:41', '67', '435', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('1baa0a91-eb30-40e8-b960-a44b45c2fdac', '袁百辉', 'b988fd93-e102-4bed-a50a-412cee7df088', '长峰科技', '战略合作发展部', ' ', '1', '2018-11-01 15:27:28', '2019-01-09 08:29:46', '56', '361', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('1c04676a-42f2-4ce1-a3b3-9787e7257521', '张嘉诚', '66e458e6-867f-4cf5-8d9e-f8613a120b76', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:07', '2018-11-01 15:23:07', '45', '323', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('1c3f27c1-4445-4230-b6e7-766fa38bc9de', '罗涵徽', '984c296c-9bd6-400b-8c40-ae85ffb130f9', '长峰股份', '研究院', '', '1', '2019-01-03 16:09:38', '2019-01-03 16:09:38', '63', '389', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('1cf89505-3996-4e80-90b1-0917f0c42b16', '杨敏', 'dd812a54-dcba-41ca-bf51-3be9cd33929b', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:09', '2018-11-01 15:23:09', '45', '341', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('1cfb462c-d421-449f-a4c0-231f0697d612', '于文杰', '3994c668-7c1b-49fa-80b6-032213a3cd5c', '长峰股份', '党群纪检部', ' ', '1', '2018-11-01 14:15:22', '2019-01-09 11:26:31', '58', '100', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('1d6168de-9d8e-43fd-b0e6-24273814ec51', '汪圣', '71c3f973-3072-4292-ab24-e34ee9864c9f', '长峰科技', '北京分公司', ' ', '1', '2018-11-01 14:18:10', '2019-05-16 11:25:43', '92', '223', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('1e176eac-7efd-423c-8ee7-1a7df92c58ae', '贺存军', '7438eeaf-2e36-40bb-b3dd-81909b44ba0a', '外来人员', '科工二院领导', '无', '1', '2019-02-26 11:32:53', '2019-02-26 11:32:53', '36', '477', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('1e429086-97a6-4d6c-901b-665d29803ac4', '田金星', '445dcd84-5a28-4495-841b-c8adf51e7d33', '长峰科技', '人力资源部', ' ', '1', '2018-11-01 14:56:14', '2018-11-01 14:56:14', '50', '290', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('1e7d2a32-7d3d-4586-8fa0-45d518c24c1c', '张文婷', '66cbdd9f-63d7-468b-9375-a7f8a0e335ad', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:07', '2018-11-01 15:23:07', '45', '320', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('1f29ecf7-2d47-4a76-ae2c-f06679f4e7b8', '段少伟', 'd03075bc-7582-4b7b-a053-f2e4cadb4470', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:10', '2018-11-01 15:23:10', '45', '344', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('1f5400ca-deb6-4fb7-a724-4ea7634e2671', '刘春燕', 'b9180322-9b78-4bcf-bec4-0d6293c0a028', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:08', '2018-11-01 15:23:08', '45', '332', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('20114b72-f7dd-4a99-a141-9ed773f8ea1c', '薛井红', 'a8d34266-31b8-4907-b494-eeb0a5573c7d', '长峰股份', '总裁办公室', ' ', '1', '2018-11-01 14:15:26', '2018-11-01 14:15:26', '64', '143', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('2027e55a-70ab-483f-a031-23045aeead8f', '高昆', 'a724acb0-0dff-4c2a-b146-2ab94baf1130', '长峰科技', '人力资源部', ' ', '1', '2018-11-01 14:56:14', '2018-11-01 14:56:14', '50', '288', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('207f1c20-f17e-46d7-848d-ea4725f36b3d', '王红叶', '0bc6fbab-f7e8-4c1e-9fbd-17bc8c34e14d', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:15:24', '2019-01-09 15:38:57', '41', '128', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('214e9bc8-bb88-445f-b350-f4f2ef92419d', '宋星毅', '7bed7551-cb5a-42df-aa40-afe62d9e1a8e', '长峰科技', '军工事业部', '', '2', '2018-11-30 16:39:59', '2018-11-30 16:39:59', '42', '377', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('219c1797-b45d-438c-917b-c67c9021ef65', '罗有彪', '6d0f98f2-7637-469b-aad9-6b7252573d5f', '长峰股份', '股份员工', ' ', '1', '2018-11-01 14:15:25', '2018-11-01 14:15:25', '52', '136', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('22048eff-b293-4168-8745-0d74fbcd3709', '徐运动', '0bfc7de7-bc20-45c3-878f-ac9327b566f4', '长峰科技', '江西分公司', '无', '1', '2019-01-18 10:13:01', '2019-01-18 10:13:01', '88', '448', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('225cb599-89b8-4e72-8894-b2db46e72457', '吴慧贤', 'f6c10093-8663-4376-bcf5-906e235e8a56', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:07', '2019-04-18 15:01:37', '42', '276', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('22c9b549-15b0-47a0-a93a-56e758ccd6a8', '缴振雷', '1d180b6b-3188-49e4-a812-1ebf04f6ec71', '长峰股份', '企业发展部', ' ', '1', '2018-11-01 14:15:25', '2019-01-18 17:55:55', '68', '135', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('2348c4d2-8a46-4687-aff7-2442db009ba9', '杨瑞瑞', '6ed2aebd-cc7e-4e02-bc75-f060181cd894', '长峰科技', '西南研发中心', ' ', '2', '2018-11-01 15:05:33', '2018-11-01 15:05:33', '55', '298', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('23e44544-2e43-4f47-958a-3ff0771ebccf', '吴婧', '71d5ee21-ca61-4ff2-98d0-4ebc50eec243', '长峰科技', '综合管理部', ' ', '1', '2018-11-01 15:32:26', '2018-11-01 15:32:26', '46', '374', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('240fded6-115d-4efb-b6e1-be6a04542681', '范小丽', '2e4a8c1d-58a5-4805-9fa3-8a37cfb283f2', '长峰股份', '审计部', ' ', '1', '2018-11-01 14:15:26', '2019-01-09 14:37:18', '62', '141', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('249a305a-6402-4d1c-b3db-c10599632c90', '蔡大河', 'bf813017-9c5c-449e-8170-71d734a58b60', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:06', '2018-11-01 14:53:06', '42', '269', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('256410ff-af57-4217-bec2-a50fb89ed4cc', '吴蔚', '23739e26-c064-4e9d-8a92-c698b3e9a726', '长峰科技', '辽宁分公司', '无', '1', '2019-01-15 09:07:05', '2019-01-15 09:07:05', '86', '446', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('25e5004a-1687-4f36-a91e-0d660d205ed1', '朱越', 'd960a34b-a5d4-4cff-b860-41177eb6d859', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:09', '2018-11-01 14:18:09', '41', '212', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('26fcc3ff-7f09-4097-a053-5dd63fa30503', '李朝晖', 'abdf0aa8-cf4e-4dbf-a298-8241a8f61a13', '长峰科技', '经营计划部', ' ', '1', '2018-11-01 14:43:13', '2018-11-01 14:43:13', '49', '251', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('274f8177-95be-4798-bee2-f26e1a101d22', '刘伟辉', '66993a43-e7d6-4e08-b3a7-31ed3d340d9a', '长峰股份', '财务部', ' ', '1', '2018-11-01 14:15:22', '2019-01-09 11:33:26', '57', '103', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('27ad98fe-ba4f-4b11-9342-010d64724568', '刘嘉翼', '2749c118-e0c3-4739-938c-90618d2e17db', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:08', '2018-11-01 15:23:08', '45', '331', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('280d0e67-f363-4007-8fa8-f4cd63dff681', '李逊', '074c94d5-ca60-4c52-bdb8-c4d5ae0bd630', '长峰科技', '总工程师办公室', '无', '2', '2019-02-19 14:17:35', '2019-02-19 14:17:35', '54', '462', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('2811e58b-9ffe-4c71-a555-def22aa10470', '郑志国', '8159e44f-b958-443d-87d0-570afe5ca320', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:36', '2018-11-01 10:46:36', '35', '44', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('281b3ee7-74f0-4abe-b04f-c57ca0aa55d5', '崔雪妍', '79a85d16-2dac-4350-a19c-73ca0474aced', '长峰股份', '党群纪检部', ' ', '1', '2018-11-01 14:15:21', '2019-01-09 10:50:58', '58', '82', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('2a48d6c6-a521-44be-b814-159db545e565', '张永', '1b1deb35-5d83-4c6d-bcf7-68f08c7f3e47', '长峰科技', '广西分公司', '无', '1', '2019-01-11 13:56:34', '2019-01-11 14:25:12', '79', '405', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('2a5452bd-a279-48bd-8e2b-1fe2802ef968', '刘立明', '4796adb9-c30b-4dc2-b813-70ca5125891a', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:33', '2018-11-01 10:46:33', '35', '23', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('2b6970e8-7680-4acc-ad55-093ccb667681', '单鼎一', 'ed319a34-4805-40f9-9ff0-800568e49741', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:34', '2018-11-01 10:46:34', '35', '25', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('2be95ddf-77cf-481d-9ceb-4a201c6c1320', '黄永刚', '3779e10f-56e8-497e-9234-ba3f936d4d06', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:05', '2018-11-01 15:23:05', '45', '309', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('2c30e754-d490-41a1-9c65-7f0d30b81266', '朱弘', '28e7f958-f91f-4711-8f10-e284eb8f2f83', '外来人员', '科工二院领导', '无', '1', '2019-02-26 11:41:15', '2019-02-26 11:41:15', '36', '497', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('2ccdf54d-4927-4cdf-98dc-f63f7a1dd519', '陈嘉末', 'f0b1797b-58c3-4fc4-b045-60419efcabb0', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:05', '2018-11-01 14:53:05', '42', '259', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('2ce2c9fa-c205-41de-bbb5-311cb5eac56d', '谢美程', 'f6d491b6-845a-44b8-b194-96c6dadd0e97', '长峰科技', '质量技术部', ' ', '1', '2018-11-01 14:07:53', '2019-01-08 14:06:46', '47', '55', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('2d0b08fb-42c3-4ebd-8097-dbe6f141d581', '冯明', '0c069c86-3569-41ee-adc1-b670f0463d1e', '长峰科技', '北京分公司', ' ', '1', '2018-11-01 14:18:08', '2019-05-16 11:23:04', '92', '195', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('2d78de4a-d6a6-4498-af6e-8db15ef706c2', '都志正', '955377bb-e2f3-4e7b-ab4d-54ce00223d0b', '长峰股份', '财务部', ' ', '1', '2018-11-01 14:15:20', '2019-01-09 10:32:54', '57', '70', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('2e532410-557e-4320-902a-c85e452eb8f1', '张玄', '378a8de4-41d8-4a4f-89d2-28a2f359b68a', '长峰科技', '军工事业部', '无', '2', '2019-03-01 10:16:43', '2019-03-01 16:26:46', '42', '498', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('2e70199e-ee61-4dd9-8529-7d32682c2eb1', '韦艳红', '4fa3fc3d-4433-4166-925a-7571f833b3e5', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:06', '2018-11-01 15:23:06', '45', '311', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('2e8bd591-ce78-4e33-90c0-32265702acfc', '马劲峰', 'ab3c4698-c66f-481b-bf4e-674e07ea3679', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:05', '2018-11-01 14:53:05', '42', '257', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('2fbaf744-ec80-4d26-9934-5fbe5b5b44e2', '刘浩', 'efb90130-0c4f-4f19-b5ab-51f45d5e1a36', '外来人员', '科工二院领导', '无', '1', '2019-02-26 11:34:56', '2019-02-26 11:34:56', '36', '482', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('3004e192-ba9d-4ca3-8132-528ccef1e189', '金圣锋', '82d5f881-7e42-4efa-a1f6-a92745219d77', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:05', '2018-11-01 14:18:05', '41', '165', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('30321a91-62e2-47d4-85f3-b287e7c84e22', '陈国瑛', 'b4103e99-e841-4fc4-8fce-e13fc40acdf9', '外来人员', '科工集团领导', '无', '1', '2019-02-26 09:53:41', '2019-02-26 09:53:41', '91', '463', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('30bc676e-1e11-42e7-b5f0-624424e7290e', '朱辰光', 'fbeb52dd-6120-46a7-ba3a-a928a79c9c85', '长峰科技', '总工程师办公室', ' ', '2', '2018-11-01 10:41:24', '2018-11-01 10:41:24', '54', '6', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('31ae87c8-1371-4de1-89ee-206840ec7ab6', '曾庆贺', 'd94b000d-9707-4930-b3a4-275c13861005', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:08', '2019-04-15 16:16:53', '42', '283', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('323572e2-ea9c-4653-a1a7-7b343dbe1c88', '张维刚', '03c5839a-37b0-4af4-ab38-09e02f7f14bd', '外来人员', '科工二院领导', '无', '1', '2019-02-26 11:39:21', '2019-02-26 11:39:21', '36', '493', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('32f7a347-048c-414c-bdf6-e24fe826fdbf', '李月平', 'e6f6fd9d-6675-457a-8ff5-50de968c27d5', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:32', '2018-11-01 10:46:32', '35', '12', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('3573f5e6-3bb7-4b9e-8e2f-8ea641a6347a', '李京波', 'ac0a853c-5716-4695-b05d-0abaf425de8d', '长峰科技', '北京分公司', ' ', '1', '2018-11-01 14:18:09', '2019-05-16 11:17:03', '92', '213', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('36e755a5-073e-4a41-97b7-517db715456e', '李雪', '8e2fccc2-c04e-4ddc-87e3-0a09ff1e00c7', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:34', '2018-11-01 10:46:34', '35', '29', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('36f0c2c9-7ce0-44c5-b764-3858ef60d52d', '郭仕', '8c649a9d-4670-4d30-8b99-e9736f8659ee', '长峰科技', '四川分公司', '无', '1', '2019-01-11 13:51:56', '2019-01-11 13:51:56', '77', '403', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('3718e355-72ce-4927-996e-ae7c51037b11', '常毅', '73162d62-63f6-4062-86c3-e5708516fb2d', '长峰科技', '北京分公司', ' ', '1', '2018-11-01 14:18:07', '2019-05-16 11:26:12', '92', '184', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('3726b597-a128-49f9-bf13-f9e9f10af602', '周云成', 'da83d0e9-78cc-414d-a114-d77de25ab01a', '长峰科技', '北京分公司', ' ', '1', '2018-11-01 14:18:08', '2019-05-16 11:23:34', '92', '202', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('37897959-7072-44ac-a98b-f21192259411', '阚博伦', 'fda81102-bb4d-459e-ae68-33eddd06f06d', '长峰科技', '财务部', ' ', '1', '2018-11-01 14:01:38', '2018-11-01 14:01:38', '48', '53', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('37b4e9fc-5636-4c45-9755-2ab127997fa5', '闫文智', 'eb1e867c-028b-4624-ba76-e3288a5cba46', '长峰科技', '战略合作发展部', ' ', '1', '2018-11-01 14:18:05', '2019-01-09 09:52:08', '56', '164', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('37ed048c-91c1-4f95-ad99-e1aec0fd12d1', '刘园', '68652e1a-88df-40aa-8871-a608eed77d84', '长峰科技', '西南研发中心', ' ', '2', '2018-11-01 15:05:34', '2018-11-01 15:05:34', '55', '302', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('383e6aef-df98-4bec-813b-115aeeb5d8a4', '杨近文', 'df6bc7e4-c08a-42ef-a085-25bd40d5bc95', '外来人员', '科工二院领导', '无', '1', '2019-02-26 11:38:58', '2019-02-26 11:38:58', '36', '492', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('38686162-43ee-4133-97aa-26a185e51f5f', '何隽秀', '21022939-30c6-495e-957c-501103eb5288', '长峰股份', '审计部', ' ', '1', '2018-11-01 14:15:22', '2019-01-09 11:18:44', '62', '96', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('38912698-2f50-44da-a4bc-e5c84b8809b0', '卜琦', '32f96933-0208-4a06-969a-9cda338123de', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:08', '2018-11-01 14:18:08', '41', '199', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('38ac0a68-d602-4bcc-a09e-1a46f0137e9f', '段裕晁', '622652b3-4515-461b-88e2-acc8098a921e', '长峰股份', '人力资源部', ' ', '1', '2018-11-01 14:15:24', '2018-11-01 14:15:24', '61', '118', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('390c9d9e-d04b-4c72-a391-860e30ef5a9d', '郝琳波', 'fc0794c4-85ae-4934-9c65-070080dfb78b', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:06', '2018-11-01 14:53:06', '42', '263', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('39ca9efa-8497-457c-a7aa-13280149a602', '谭青杨', 'e5eb0ba3-79ae-4dd0-af3a-4de6cc7b2509', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:06', '2018-11-01 14:53:06', '42', '268', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('3a773b03-3634-4172-a394-76e6cba5c80a', '焦丹', '819e2145-1fcd-4e0f-b4d3-38cec7e296a2', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:10', '2018-11-01 15:23:10', '45', '345', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('3bf9f538-6483-461f-bb75-e4d6c8dff85d', '张鹏', 'f6ad80e1-da36-40da-9b4d-e91659388c29', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:06', '2018-11-01 14:18:06', '41', '173', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('3c0a8d22-f376-485e-ab09-6a026eb75d2d', '陈舜媚', '219a1966-d1ee-479e-a546-47a1e9a2a2f8', '长峰科技', '总工程师办公室', ' ', '2', '2018-11-01 10:41:23', '2018-11-01 10:41:23', '54', '3', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('3cc2fce0-fc2f-447a-a6fe-1ae1b8a58489', '张旭', '8028faae-0375-4015-80d4-52758c1748b6', '长峰科技', '交通事业部', '', '2', '2018-12-14 17:11:21', '2018-12-14 17:11:21', '43', '379', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('3e72e51e-bc45-47a3-976e-cb9a1d538ba9', '刘荩珊', 'c0e5d08f-321b-41ce-83a6-60ccf1b28174', '长峰科技', '质量技术部', ' ', '1', '2018-11-01 15:31:18', '2018-11-01 15:31:18', '47', '366', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('3edaf908-532a-4573-a76c-0d3a0aa93c83', '王渤海', '71621afa-3fb7-427f-94cb-e671e43d8756', '长峰科技', '交通事业部', ' ', '2', '2018-11-01 14:39:45', '2018-11-01 14:39:45', '43', '247', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('3ee5fd56-a9be-4d8f-99d9-d673279c59a3', '吴蔚', '06270af0-4aa5-4c4f-a9b2-10bd279df8fd', '长峰科技', '总工程师办公室', ' ', '2', '2018-11-01 10:46:34', '2019-01-08 13:56:08', '54', '27', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('4021570f-3761-4416-a062-1ff0fb17e5c5', '王思明', '3cb67b68-eb43-4c3d-a5c4-f0099a70485b', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:10', '2018-11-01 14:18:10', '41', '226', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('409a8c63-b5d8-494f-b527-476fa49fd64f', '张大海', '61d725bc-ae37-4bfb-9a09-3d63fa5f5f45', '长峰科技', '集成项目部', '无', '2', '2019-01-11 14:45:11', '2019-01-11 14:45:11', '41', '419', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('40d6ee83-c3a9-4d9f-82d0-27a8c05f6b89', '邓刚', '8d61c023-6307-4f6f-a181-550447cda1c4', '长峰科技', '战略合作发展部', ' ', '1', '2018-11-01 15:27:28', '2018-11-01 15:27:28', '56', '354', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('41979f7d-4fca-4f42-9cab-bcb6fdcfbdef', '梅敏敏', 'ef355d96-88bf-4e5b-8e1d-ed5b421b261f', '长峰科技', '采购部', ' ', '1', '2018-11-01 14:07:53', '2018-11-01 14:07:53', '51', '59', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('41a55fe2-eb80-403d-8b9c-1559339f816d', '王海仙', 'c07ba7f0-dacf-4afd-abba-941b701ae030', '长峰科技', '经营计划部', '无', '1', '2019-01-14 10:05:18', '2019-01-14 10:05:18', '49', '434', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('41ed6bb9-6f36-44dc-97eb-f58075a8abf8', '张梦巧', '49af86e4-c31e-48dd-8c66-4298d73a3bb0', '长峰股份', '研究院', ' ', '1', '2018-11-01 14:15:20', '2019-01-09 10:43:27', '63', '76', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('421329e7-fcf6-4479-b189-0735fc33f42d', '李鹏', '23de3be0-2b1d-42cb-9392-24bca01fb6d7', '长峰股份', '研究院', '无', '1', '2019-01-18 17:59:56', '2019-01-18 17:59:56', '63', '450', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('427ef3be-f6dc-44d2-8ef0-355e19a364b4', '常存磊', '25e7a9af-e005-4b71-b0c9-ee0463eb35c0', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:07', '2018-11-01 14:18:07', '41', '185', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('42b3ead8-02fe-4929-8ea7-f565e3a911f2', '于雪', 'ef450ac0-eef3-4db1-8741-b4713e15dd1e', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:08', '2019-01-11 09:36:48', '45', '329', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('42ceb054-fd0e-4843-aebd-0265b4e89c32', '张林杰', 'c628885e-99ca-45ac-892f-9bea34f59583', '长峰科技', '北京分公司', ' ', '1', '2018-11-01 14:18:06', '2019-05-16 11:18:03', '92', '178', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('432278ff-0d31-4e11-984d-19d295b49577', '高红卫', '71c13fb5-51a4-4149-92af-d7563cc7bc51', '外来人员', '科工集团领导', '无', '1', '2019-02-26 09:55:26', '2019-02-26 09:55:26', '91', '464', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('433ef81d-f2a5-4fd1-90c8-2e303fda243c', '王姝', '7260c0b2-2916-452b-aca8-2c2ad9df37f9', '长峰股份', '研究院', ' ', '1', '2018-11-01 14:15:24', '2019-01-09 15:20:23', '63', '126', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('446b6b81-6fa8-4224-9484-3687ffa7e09b', '熊彬', '8bafd641-3018-4cc8-a750-5f3449013a6a', '长峰科技', '湖南分公司', '无', '1', '2019-01-14 14:41:47', '2019-01-14 14:41:47', '66', '439', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('452bd6e9-b2a2-44bb-b036-94a2b654140f', '郝威傑', '5d0afc19-2b33-46aa-a725-c3f2201ada6e', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:06', '2018-11-01 14:53:06', '42', '264', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('4564f6c9-7451-4612-8efd-57c8b065c142', '宋建巩', '16d870ea-2da9-4f23-bfbe-7b0879acce54', '长峰科技', '北京分公司', ' ', '1', '2018-11-01 14:18:07', '2019-05-16 11:16:03', '92', '188', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('45ac15e6-d263-4a6c-a9ff-0affae11307d', '刘鑫', '7bc83d79-0620-43a7-82b1-449563b482d7', '长峰科技', '财务部', ' ', '1', '2018-11-01 14:01:38', '2018-11-01 14:01:38', '48', '48', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('45b97db7-8895-4a6e-b4b5-83daab3770c7', '张艳', '65453795-0417-4d44-89ee-cbf902f86584', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:32', '2018-11-01 10:46:32', '35', '14', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('4673d7f0-8f33-41b3-be0f-dbdbe4be9122', '王欢', '350e2948-75ad-4d7a-beca-82cd3e6fc0ab', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:35', '2018-11-01 10:46:35', '35', '35', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('47260ae1-9c06-4bfe-bc45-80e4fd396a15', '尚向燕', '9f432f44-edd3-4d1c-afbc-f312f60df24e', '长峰科技', '北京分公司', ' ', '1', '2018-11-01 14:18:07', '2019-05-16 11:15:20', '92', '187', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('4780883f-841f-42bf-be68-c449a5c2f7c3', '吕春花', 'e8f9d3f7-9578-4644-8990-89714c4f7cfb', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:34', '2018-11-01 10:46:34', '35', '26', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('48273db2-7428-403b-a215-17d639d09770', '魏鑫', 'fbd5ed16-c280-4155-b2a3-cee037954fff', '长峰科技', '产品部', '', '2', '2018-12-25 16:05:42', '2018-12-25 16:05:42', '35', '380', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('4893b9e2-c078-4a37-98fe-2bdb93ed5a35', '马小利', '7ae97306-73c9-4bb8-929b-d8a9b1e29750', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:05', '2018-11-01 14:53:05', '42', '256', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('48fc3fd1-1235-4be8-8e2c-e3b698c5ff5b', '张洪毅', '9abbf31e-6897-4f53-8b6a-1e11b54c6d14', '外来人员', '科工集团领导', '无', '1', '2019-04-15 17:07:49', '2019-04-15 17:07:49', '91', '508', '0', '0');
INSERT INTO `sys_userinfo` VALUES ('496d59b4-ecf7-4b9b-90f7-9e26d4960bd8', '于方文', '4ec8be99-20fb-44e1-a67e-b91b0136494c', '长峰股份', '股份员工', '离职', '1', '2018-11-01 14:15:22', '2018-11-01 14:15:22', '52', '99', '-1', '2');
INSERT INTO `sys_userinfo` VALUES ('49760e02-a90d-4672-bbbb-6e0d981ed98a', '朱葛', '47e82e10-30f3-4ac6-b764-45405568c1f5', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:09', '2018-11-01 14:18:09', '41', '211', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('49b445b1-ee1e-4db0-9056-77cbb911998e', '李健', 'fe5a5ed6-6c9e-4d21-aac6-f2deaefefab1', '长峰科技', '北京分公司', ' ', '1', '2018-11-01 15:23:09', '2019-05-16 11:37:58', '92', '338', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('49bba60a-e50b-48a1-9e96-724c4d5fbfd0', '芦艳', '037b567a-4948-4148-902e-704e7b939b74', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:06', '2018-11-01 14:53:06', '42', '270', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('4bb0308d-947a-4687-b860-43773e75dbe1', '于广兴', '56ca616d-be56-4bf0-8301-4f6b92c78d2a', '长峰科技', '采购部', ' ', '1', '2018-11-01 14:07:53', '2018-11-01 14:07:53', '51', '56', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('4be786e3-56ae-4e8d-b710-1879706ccd31', '赵一帆', '677f0e4c-c655-47cb-a8c5-9d58f6a6eaac', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:35', '2018-11-01 10:46:35', '35', '41', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('4c154735-e0b5-4ac4-b701-ce23deb8d082', '魏英博', 'f380d4d4-ee80-405c-97df-91b9cc731fa8', '长峰股份', '人力资源部', ' ', '1', '2018-11-01 14:15:19', '2019-01-09 10:22:24', '61', '65', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('4c62f9bc-86fa-433e-a540-5c23b71148a2', '刘诗娟', 'c37c92cc-5d7f-4dcc-9d99-2ad42155c5de', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:07', '2018-11-01 14:53:07', '42', '277', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('4c855f4b-14dd-49a3-9ddb-ed293f7626a8', '梁冠华', '08f59141-bf04-47a9-bfce-13dabeb46d78', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:10', '2018-11-01 14:18:10', '41', '221', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('4cecaed0-741f-4715-bb3f-5ee2764252ca', '杨欣', '0e5cabd6-eda9-44c8-b3f2-6745545f9c51', '长峰股份', '党群纪检部', '', '1', '2019-01-03 15:50:30', '2019-01-04 10:44:21', '58', '383', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('4d2fa400-674e-4932-8c6c-9370e0bbab85', '郭昊', '31aedeb0-35ce-42e3-b750-c4de1f8a08e2', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:06', '2018-11-01 14:53:06', '42', '262', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('4ecbc14c-5cc1-4241-ae41-b67a2ae21b67', '王兆阳', 'c34b2760-f9e3-44d9-807c-1f3a934eb6d6', '长峰股份', '股份员工', '离职', '1', '2018-11-01 14:15:24', '2019-01-04 09:19:28', '52', '124', '-1', '2');
INSERT INTO `sys_userinfo` VALUES ('4ee34375-136d-4e3d-ace4-f8197619fa1f', '陈瑞', 'e9fc0da3-9869-4800-8122-7398c87c9312', '长峰科技', '四川分公司', '无', '1', '2019-01-11 13:50:21', '2019-01-11 13:50:21', '77', '402', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('4ee5b7c8-3d3c-4793-88ea-58e59568a791', '杨振', '47d6ea80-640e-4dc1-b149-3cdc7ef81a24', '长峰科技', '产品部', '无', '2', '2019-01-18 18:02:16', '2019-04-17 12:25:59', '35', '452', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('4f47401c-491c-4b9c-a6ae-b306bdd5754c', '刘砺岩', '70166bbd-90f3-415f-95e7-cf15b1e73150', '长峰科技', '广东分公司', '无', '1', '2019-01-23 14:30:03', '2019-01-29 10:41:36', '67', '459', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('4fd296b8-6629-4216-baab-c0fc7332dd42', '申佳斌', '1dd5ab01-0a51-4f51-8062-bde4cef594b6', '长峰科技', '交通事业部', ' ', '2', '2018-11-01 14:39:45', '2018-11-01 14:39:45', '43', '246', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('50214818-4f97-44e0-b02d-0ed6450feea2', '肖海潮', '054480f9-378c-472d-9229-bf7743acb94c', '外来人员', '科工二院领导', '无', '1', '2019-02-26 11:37:13', '2019-02-26 11:37:13', '36', '488', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('509963b0-dfd3-4908-b7bf-f3447d92c72c', '韩金海', '8b0c6640-7da9-4bc9-bc32-3d41189420f4', '长峰科技', '采购部', ' ', '1', '2018-11-01 14:07:53', '2018-11-01 14:07:53', '51', '54', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('50f546d0-11c6-4012-a208-a92755fe6800', '焦娜', 'f337b406-39fe-48b3-bf64-e1e2e1688322', '长峰股份', '行政保障部', ' ', '1', '2018-11-01 14:15:24', '2018-11-01 14:15:24', '59', '120', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('5175c510-5b74-4d44-b647-8133a2f5a450', '滕一', '6a92df92-587e-4f72-a68b-99266133f8fb', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:35', '2018-11-01 10:46:35', '35', '33', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('52285212-1379-43d6-a5bd-714ba3a4d68b', '姜华', '0da4c739-1cd4-42c7-bd82-d5b6edbdbdec', '长峰股份', '财务部', ' ', '1', '2018-11-01 14:15:21', '2019-01-09 11:11:52', '57', '88', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('522de384-8c52-48e5-9432-5b671e8390f5', '杨仕颖', '43107621-1556-4b71-81bf-6abee116e1d2', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:08', '2018-11-01 14:53:08', '42', '286', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('526b08bc-7119-414b-ba0b-d9822289b30f', '于哲', 'e25d89b0-0972-4f53-9104-2e3b967eb79d', '长峰科技', '集成项目部', '无', '2', '2019-04-18 08:47:13', '2019-04-18 15:04:57', '41', '512', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('52f93198-bae7-4442-a1a1-2af3fd9c6fdb', '李大鹏', '96b8ed3c-1a34-4553-9875-3ca82da69023', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:09', '2018-11-01 15:23:09', '45', '339', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('54e012cd-5ebc-4b58-96b2-6b81e4b9ac3a', '庄涛', 'd01a7812-79c4-4752-92db-c227636f8556', '长峰股份', '其他', '科威', '1', '2018-11-01 14:15:21', '2019-01-09 15:31:02', '72', '80', '-1', '4');
INSERT INTO `sys_userinfo` VALUES ('54fc0c3f-bda6-42bd-bcae-1fef4c9cdaf7', '张冬雪', '9c6afe9e-350d-4df7-9726-568c8e6b263b', '长峰科技', '综合管理部', ' ', '1', '2018-11-01 15:32:26', '2018-11-01 15:32:26', '46', '373', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('5507b4e6-a111-4908-a0e6-7ac0d4c7e2b6', '邱学志', '6610fdcb-9f57-4960-a86b-2f44b8c7c89c', '长峰科技', '质量技术部', ' ', '1', '2018-11-01 15:31:18', '2018-11-01 15:31:18', '47', '363', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('55cc00dd-ed24-4c4a-a1d6-275103bf051d', '张军委', 'dc09f602-a43f-4b84-ba54-cd59fa763d79', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:06', '2018-11-01 14:18:06', '41', '182', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('573bf567-1d0b-4a66-9ecd-134a611c4a98', '郭会明', '339c5c81-dcc6-4101-a549-90c10939dbe5', '长峰股份', '股份领导', ' ', '1', '2018-11-01 14:15:20', '2019-01-09 10:37:10', '38', '72', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('5842f2f5-07ad-4eec-87ab-eadeb5947f23', '张嘉城', 'd6846068-5b2e-4b62-931e-8123436f9078', '长峰科技', '陕西办事处', '无', '1', '2019-01-11 15:07:31', '2019-01-11 15:07:31', '83', '424', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('586a6d04-2d29-4ed2-b3d3-18bcf3edacd2', '顾正阳', '51614c9a-7865-458d-acd6-0f49feb6daaf', '长峰科技', '战略合作发展部', ' ', '1', '2018-11-01 15:27:27', '2018-11-01 15:27:27', '56', '353', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('58826b3d-849f-481e-9357-95cf6cc17c2a', '邵奇', 'd5fb5f76-4221-4032-8e6a-2963ec8202e4', '长峰股份', '行政保障部', '', '1', '2019-01-03 15:51:47', '2019-01-04 10:45:58', '59', '384', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('58acf566-c26e-4650-8e96-4412f6752b38', '王鑫龙', '54b0af78-8a94-4826-a52c-5934e7e8fbfa', '长峰股份', '研究院', '', '1', '2019-01-03 16:10:12', '2019-01-03 16:10:12', '63', '390', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('59a80b52-50ca-4299-871d-aafc979351d8', '王晓云', '7d56423a-80f3-4969-a746-63fdbe7d14ac', '长峰科技', '军工事业部', '无', '2', '2019-01-11 16:52:03', '2019-01-11 16:52:50', '42', '426', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('59bff5ce-d0cf-492e-88f9-c4582c81fd5a', '童伟', '19bf1102-f7cd-44e1-9187-f06079e5378b', '长峰股份', '证券投资部', ' ', '1', '2018-11-01 14:15:25', '2019-01-09 14:19:37', '71', '134', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('5ac2e91d-9270-4eca-a9ed-987902986b74', '孔令远', 'fff2c5a8-a093-41d9-a69d-ec70e8103d11', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:33', '2018-11-01 10:46:33', '35', '18', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('5ac7fae9-05d1-4b60-91b5-4d2a58ec27b0', '杨剑锋', '0e96a66d-47b9-49e9-a1c9-ad8666b3f496', '长峰科技', '西南研发中心', ' ', '2', '2018-11-01 15:05:33', '2018-11-01 15:05:33', '55', '299', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('5b71b57b-7753-4ebe-844a-f17e33b100ea', '余进', 'a00c694f-17f5-4dd4-892e-72d0683378d7', '长峰科技', '总工程师办公室', ' ', '2', '2018-11-01 10:41:24', '2018-11-01 10:41:24', '54', '7', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('5bbaf549-8efe-4e0d-ad52-bd38f2480a8b', '赵志华', 'c7b13f93-7a16-4f28-ae0b-9c58679a36a6', '长峰股份', '企业发展部', ' ', '1', '2018-11-01 14:15:20', '2019-01-09 10:41:27', '68', '75', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('5c3f68a3-8ea1-4431-bf11-5542229bd3d0', '石鹏飞', '14958557-97cd-46eb-8a4c-12e51c758c48', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:10', '2018-11-01 15:23:10', '45', '348', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('5c547886-33da-45d6-90bc-7e239d18799a', '罗峤伊', 'ddbfab61-067e-41e0-96f7-1e8707d1f840', '长峰科技', '广东分公司', ' ', '1', '2018-11-01 14:18:11', '2019-01-09 10:01:30', '67', '231', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('5c7b8aeb-1858-4392-ad0c-81b6badfdf3d', '陈晓锋', '18320a7b-5206-4ceb-b136-0a195ca2e3e9', '长峰科技', '财务部', ' ', '1', '2018-11-01 14:01:37', '2018-11-01 14:01:37', '48', '46', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('5d5fd323-8513-4488-af7b-40af374a0bd0', '付建祖', '380922f0-3038-4c83-9285-2455cd439756', '长峰股份', '研究院', ' ', '1', '2018-11-01 14:15:22', '2019-01-09 11:24:08', '63', '98', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('5d77d995-9381-4e0b-a8e4-4077cb5bd7e3', '李晓青', '14319904-cefc-42a1-941c-78cbd25ff0c0', '长峰股份', '审计部', ' ', '1', '2018-11-01 14:15:23', '2019-01-09 11:48:51', '62', '114', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('5e21b720-dff2-4aaa-9959-603751249fdc', '林青', '6ceefcec-0192-4b8e-9862-ff9759a61da2', '外来人员', '科工集团领导', '无', '1', '2019-02-26 09:58:58', '2019-02-26 09:58:58', '91', '467', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('5ec73025-b66a-490e-a954-01047bdf6ad5', '董雪梅', '120ff6a8-ba62-4a9b-8f0b-0de8b8325656', '长峰科技', '产品部', '无', '2', '2019-01-08 09:38:58', '2019-01-30 17:04:59', '35', '395', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('5f7082d9-9e2b-435b-a40d-86b1290513ee', '任仁', '1dbd1828-1280-4eab-a0fa-e0c3cebef53a', '长峰科技', '北京分公司', ' ', '1', '2018-11-01 14:18:08', '2019-05-16 11:26:44', '92', '196', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('5fd5d892-e711-4894-b9ef-883f435e49af', '白国峰', '3f1ddda6-03f4-441f-a3f1-7ac56a497a92', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:35', '2018-11-01 10:46:35', '35', '36', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('603f8e07-0f4c-4091-8aed-dc7f23a1a06e', '吴晓辉', '1c722a45-98de-437a-8d75-ec1c5841493f', '长峰股份', '股份员工', ' ', '1', '2018-11-01 14:15:22', '2018-11-01 14:15:22', '52', '92', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('60684d09-fc43-4eed-9479-7cac74aa6462', '钱彬', 'c40a9813-a9cb-4cb7-abbd-d4acd51b645d', '长峰科技', '河南分公司', '无', '1', '2019-01-11 15:03:26', '2019-01-11 15:03:26', '81', '421', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('607236f3-b5af-4b86-a57b-4d8e576507ac', '倪文顺', '4c35e557-8717-4c91-9411-3aa6d6b0ed5f', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:07', '2018-11-01 14:53:07', '42', '278', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('60ad6dad-0b90-47e6-be0b-051b1bd11a3a', '陈肖', 'e341b442-e50e-4152-937b-bdb956ab724b', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:32', '2018-11-01 10:46:32', '35', '10', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('61213d12-5999-4ae9-b3f4-9d3cf67a04f7', '王琳', 'a7f51904-322d-40f1-92ba-0424e2381913', '长峰科技', '军工事业部', '无', '2', '2019-04-28 10:21:16', '2019-04-28 10:21:16', '42', '514', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('62059884-f376-428b-927c-d9fd6c9cf85d', '宋坤涛', 'df376508-bf2f-4b25-abe5-7cb19480dcfc', '长峰科技', '北京分公司', ' ', '1', '2018-11-01 14:18:07', '2019-05-16 11:25:17', '92', '189', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('62636c99-d4d3-4117-b7a4-5be38cb786c5', '刘  颖', '16032c1e-388e-45d2-b8e7-f7edeac8ef64', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:33', '2018-11-01 10:46:33', '35', '24', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('6271c5b1-e8ef-4e10-b25c-444490e5db8f', '刘月', '91ace27d-efd8-4197-994b-0a00b68a707f', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:08', '2018-11-01 15:23:08', '45', '333', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('62f13559-f643-4a3b-8c72-b661d0651d6f', '郭大勇', '5897bc72-c3cd-4833-83a7-adb9057c178b', '外来人员', '科工二院领导', '无', '1', '2019-02-26 11:32:08', '2019-02-26 11:32:08', '36', '475', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('63b352b1-5ae2-4e41-abff-b32857cd255a', '张青', '9d0d983a-210d-4b2b-a24d-82339aa9dee0', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:06', '2018-11-01 14:18:06', '41', '174', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('644ff16f-b924-43f1-b2c9-de1882079200', '张军伟', 'd7dc4563-0a0a-4286-a16d-81639d4a965e', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:07', '2018-11-01 14:53:07', '42', '272', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('6481e34e-3fcd-4d34-8c18-a8154a6ad286', '曲秋楠', 'bb35972c-9296-4570-a44d-e3dd3e11372e', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:09', '2018-11-01 14:18:09', '41', '209', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('64d4aa80-82e2-424e-a695-fee357f8e1ab', '王海涛', 'c3df907a-bf29-495d-8c56-49ae4f38e8c7', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:10', '2018-11-01 14:18:10', '41', '227', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('65bfca06-19d1-4306-b53b-11093ea76004', '陈曦', 'd4453986-ebcf-4297-8858-dc326da95432', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:04', '2018-11-01 14:18:04', '41', '159', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('6634f63c-4502-49f2-94e0-f89d8c185552', '崔定波', 'ca02eb30-74fd-4305-82e1-163eea870018', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:33', '2018-11-01 10:46:33', '35', '16', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('67d5e4ef-7287-4d91-b52b-4dcb5d8c1789', '吴洪波', 'eef574ef-6782-4556-bbf3-f65da4167ea4', '长峰股份', '航丰路六号院', ' ', '1', '2018-11-01 14:15:21', '2019-01-09 11:15:31', '69', '91', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('685709e7-a0a1-439a-9b62-2ed2952c0f30', '魏凯', '5d69188b-db1f-4950-9a63-c0213325d97d', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:03', '2018-11-01 14:18:03', '41', '150', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('68813e56-ff92-4353-ad0a-9c9a1b73c0fc', '李佳', 'ac6c54d8-8292-47ec-b722-6eb45009a867', '长峰科技', '国际事业部', '无', '1', '2019-01-15 08:59:55', '2019-01-15 08:59:55', '73', '441', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('6897ffeb-e44f-4797-be5a-59157c568807', '丁思强', '7c568ab0-8371-4d9d-8e6a-53fb841b3ba3', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:08', '2018-11-01 14:18:08', '41', '197', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('68d861b3-ef8c-4c45-96b3-7a393b619fb9', '郭俊三', '55c1a315-cdc0-45f0-bcfd-678106834985', '外来人员', '科工二院领导', '无', '1', '2019-02-26 11:32:30', '2019-02-26 11:32:30', '36', '476', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('68d8a1f5-3c19-48a8-b4ce-7b0ad5c5bd62', '刘金涛', 'c0c0bac2-d6ec-4ce4-8eab-474451613518', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:08', '2018-11-01 14:18:08', '41', '192', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('690d6ad0-25b4-40b2-b073-2ac9e0f90662', '林小丹', 'f69e2265-e3e5-45a6-a789-b3c1e8ca19a2', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:09', '2018-11-01 15:23:09', '45', '342', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('693a6d61-6966-4204-ace5-fc1a87623130', '江德宇', '7af28ac8-9c4d-4c01-96db-304feabf6865', '外来人员', '科工二院领导', '无', '1', '2019-02-26 11:34:04', '2019-02-26 11:34:04', '36', '480', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('6956c204-0234-49fe-a941-4efdf87989a6', '张苗苗', '8acf84aa-1c24-453d-a8c4-52b28883cbd9', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:06', '2018-11-01 14:18:06', '41', '177', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('69cca87f-657d-4181-95e4-3c9556a95c21', '陆景鹏', '9c280e46-788f-4e89-bfd5-5c2623548407', '长峰科技', '交通事业部', ' ', '2', '2018-11-01 14:18:05', '2019-01-08 14:22:00', '43', '163', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('6a50c1b9-d98a-483b-8553-e422525e6bcc', '杜佳悦', '12b1a6f3-80e9-4f26-9a3a-8946e69265a7', '长峰科技', '北京分公司', ' ', '1', '2018-11-01 14:18:09', '2019-05-16 11:24:45', '92', '216', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('6a50c600-c069-4fa5-98a8-a6e5200d3b75', '郑艳芳', 'a25e95a5-e271-40d3-ace5-b1adbfb9dd8b', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:05', '2018-11-01 14:18:05', '41', '167', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('6ca65c66-e71d-48df-9f87-503cd0b2743e', '周华', 'c31469f1-d5f2-469f-ab1c-8dc0f17a4e9e', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:07', '2018-11-01 15:23:07', '45', '324', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('6db0b48e-6430-48fb-b76a-84561e97eed2', '边晓娟', '032ebf5d-e46f-4e3b-86a8-e6eade4213ca', '长峰科技', '质量技术部', ' ', '1', '2018-11-01 15:31:18', '2018-11-01 15:31:18', '47', '364', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('6de9a637-8165-47d4-8c4c-7924b72fd6a4', '龚波', 'cc340761-7cc3-47e6-b486-dc092af6615a', '外来人员', '科工集团领导', '无', '1', '2019-02-26 09:57:16', '2019-02-26 09:57:16', '91', '465', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('6dfaf29e-5cbb-4444-9bb2-31552405424f', '孙震宇', 'e7fc26ba-4061-43df-8fd0-1a4d4416edc6', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:09', '2018-11-01 14:18:09', '41', '206', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('6e218fef-ea16-40b1-87f3-50cf24c7bc2f', '王春华', '86f35df0-c19f-42a8-898a-497f158ace47', '长峰科技', '总工程师办公室', ' ', '2', '2018-11-01 10:41:24', '2018-11-01 10:41:24', '54', '5', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('6e59650c-b7fb-4c66-89b7-7ce94d4529d7', '胡一静', '3b9947ff-f944-4af9-9f90-d67d30d21429', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:11', '2018-11-01 14:18:11', '41', '235', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('6edbaf24-97f8-4dd7-a85b-29d8e4839a8f', '苏洋旸', '4137653d-fbb0-469f-9105-4e84ae9a89e7', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:11', '2018-11-01 14:18:11', '41', '236', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('6f90dcf3-ae18-40b1-a3cc-6e852175e1d0', '王学飞', '20b3383a-67e7-4d9a-bcbe-efbabdb3914c', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:10', '2018-11-01 14:18:10', '41', '225', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('6fa8d427-9ab1-4fe9-a3cd-00d7c237f2ca', '杨羿', '2b6f6c5e-1a0d-4b62-84e6-33c21d9aece0', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:10', '2018-11-01 14:18:10', '41', '220', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('713c2f39-6298-4b01-b413-59603fcc8ac8', '颜羽鹏', 'd75cba75-e3b3-4181-8d6d-2a3e9736070d', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:31', '2018-11-01 10:46:31', '35', '8', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('7186fb90-5fec-41de-81d8-5fdcc03dc069', '焦函', '70a3832b-8e0d-4aff-b650-487c1e5c2ed4', '长峰股份', '研究院', '', '1', '2019-01-03 16:08:10', '2019-01-03 16:08:10', '63', '388', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('72455d94-8edd-487c-beae-363dac579f4f', '杜江红', '8d953d4c-aba1-45b1-b6db-1d89e973b8b2', '外来人员', '科工集团领导', '无', '1', '2019-04-15 17:08:14', '2019-04-16 11:06:10', '91', '509', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('728cf868-b580-4b25-b321-4b34438bb274', '张国力', '6f039f0b-e314-43da-9dc0-015a79329c8b', '长峰科技', '科技领导', '无', '1', '2019-01-11 15:01:45', '2019-01-11 15:01:45', '44', '420', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('734e820b-f8b9-4fd8-b024-404368251973', '王献朋', '973fadda-b356-4050-81ef-fba3b3542b02', '长峰股份', '审计部', '', '1', '2019-01-03 16:05:22', '2019-01-03 16:05:22', '62', '387', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('73978779-0529-49ee-b897-f13af1975205', '张树环', '1b606dc8-d07e-4012-8ea1-c673121ec0cd', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:07', '2018-11-01 14:53:07', '42', '279', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('73c27320-7508-4352-bcc9-1108ad2c4d17', '张涛', 'a7e39de0-1637-4820-b102-16c2ea3a1ef0', '长峰股份', '航丰路六号院', ' ', '1', '2018-11-01 14:15:23', '2019-01-09 11:43:46', '69', '110', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('745c93d8-4a5b-44c3-96e2-119469513a3c', '徐睿', 'c1239e9e-ca7c-4fc6-ba74-91466233a777', '长峰科技', '综合管理部', ' ', '1', '2018-11-01 15:32:26', '2018-11-01 15:32:26', '46', '370', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('753a0b9b-c404-4c0b-be27-2c7bf612dc97', '金苍松', '5a0449a5-9910-43ce-9624-280d8806a0e5', '外来人员', '科工二院领导', '无', '1', '2019-02-26 11:34:31', '2019-02-26 11:34:31', '36', '481', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('756a5fa4-0b8d-48f0-b05c-3b12e79b4ae1', '焦长军', '9048fd59-28a3-450c-9f52-7dffb0a20d66', '长峰股份', '航丰路六号院', ' ', '1', '2018-11-01 14:15:24', '2019-01-09 14:56:21', '69', '121', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('76291e39-41e3-44f2-89e3-8a20c3561d5d', '李涛', '7a8c3f5b-2680-4742-a161-026e9fb5ac6f', '长峰股份', '人力资源部', ' ', '1', '2018-11-01 14:15:23', '2019-01-09 11:49:41', '61', '115', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('777c36aa-35b6-4f89-88c9-2a91b34bb3da', '宋南南', '41e382a6-f160-439f-ac4e-1355f0033e35', '长峰科技', '北京分公司', ' ', '1', '2018-11-01 14:07:53', '2019-05-16 11:40:46', '92', '57', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('77f3da63-1798-4eee-8161-1b883a802ea3', '王艳美', '57fae87a-1f87-4516-ad4e-a2a531d902a6', '长峰股份', '企业发展部', ' ', '1', '2018-11-01 14:15:25', '2019-01-04 09:52:36', '68', '130', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('7844e4ae-3875-4977-9515-9b075fbb5cd6', '杨鹏举', 'f59a1a47-d9ef-4b05-911f-a351a5014741', '长峰科技', '总工程师办公室', '', '2', '2018-11-30 16:38:39', '2018-11-30 16:38:39', '54', '376', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('78cdc6c9-a0e2-4e7b-ae2f-ee640f066bcc', '麻博', '97aa26de-58ff-47cf-a95c-60d02ce37d94', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:03', '2018-11-01 14:18:03', '41', '147', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('7a08ef92-a024-4822-8cd7-62e2dff73395', '曹晓红', '44d59a5e-e59e-481c-934e-74781b7eb1d1', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:09', '2018-11-01 14:18:09', '41', '210', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('7a440512-7ec9-46f6-a241-c9660d99d45c', '高振峰', '70d7361d-16d0-488f-a2f3-2c9814c1cdaf', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:03', '2018-11-01 14:18:03', '41', '151', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('7a9f4e01-509e-4f3d-b1bb-a0c7b3931329', '满凌然', '1ed01665-b0c3-44e7-9d83-5b5e52db6ba5', '长峰股份', '财务部', '', '1', '2019-01-03 15:48:31', '2019-01-29 10:34:41', '57', '382', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('7ac699a2-dd4a-4e88-86fb-9ff2028d73b6', '朱晓东', '03201d60-e736-4e4a-85c4-e65e72f7a478', '长峰科技', '北京分公司', ' ', '1', '2018-11-01 15:23:08', '2019-05-16 11:38:48', '92', '336', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('7b8c80c9-a45c-4c41-80d3-ba5d0fd5e913', '冯雅晴', 'acdf8d85-8e6f-4d39-aea1-18e8bbb99336', '长峰科技', '产品部', '无', '2', '2019-03-20 11:07:42', '2019-03-20 11:07:42', '35', '501', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('7d3fa5cc-28d0-4730-986e-5eb20a2ef29a', '彭朝流', '666a3ab8-1f45-49eb-ab52-18b7b3f167b3', '长峰股份', '行政保障部', ' ', '1', '2018-11-01 14:07:53', '2019-01-09 09:31:41', '59', '58', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('7d81d410-0106-43bb-b4fa-32d5c89105f1', '卢绪哲', '2cc340a1-332a-4661-9c1d-4daf66be550b', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:08', '2018-11-01 14:18:08', '41', '200', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('7e017495-e0ff-479f-a98c-328f472c11b3', '李庆河', 'c06dcaeb-2fc9-4f2f-9752-48506f75a16f', '长峰科技', '军工事业部', '无', '2', '2019-04-08 11:28:15', '2019-04-08 11:28:15', '42', '506', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('7e4644ba-5926-4784-9207-a4f2a7e7ec42', '许咏梅', '158918ea-4774-477f-a4a4-2dea25c51fff', '长峰科技', '财务部', ' ', '1', '2018-11-01 14:01:38', '2019-01-08 14:04:41', '48', '51', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('7e59297c-cdeb-4579-afc8-6ab9466c6952', '张志国', 'dc6f8e81-d555-44bf-ad52-c52775610588', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:06', '2018-11-01 14:18:06', '41', '179', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('80b6ee57-431d-468f-a85e-cba194bd831d', '徐进军', 'e9e0e91b-98b3-42d6-b57c-cbd6ec309f88', '长峰科技', '河北分公司', '无', '1', '2019-01-11 15:04:54', '2019-01-11 15:04:54', '82', '422', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('81ce45bc-ed16-46a3-a408-10beba72d244', '刘海涛', '32689d93-8ae4-4220-a622-f5ef6dcdd092', '长峰科技', '综合管理部', ' ', '1', '2018-11-01 15:32:26', '2018-11-01 15:32:26', '46', '372', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('81f09cf7-b657-4760-9aa4-15cb252ea3b7', '周子奥', 'edf1c127-7ee5-40a5-97cd-6078b35cbee1', '长峰科技', '财务部', ' ', '1', '2018-11-01 14:01:38', '2018-11-01 14:01:38', '48', '49', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('823bb5d9-38ac-47dd-a34b-7965b8fee76c', '王琮', 'ed596ccd-febe-485a-a8fa-fa0ae99778f1', '长峰股份', '行政保障部', ' ', '1', '2018-11-01 14:15:24', '2018-11-01 14:15:24', '59', '127', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('825199aa-fc1e-40a7-8d57-d3086e5412c1', '崔硕', 'bc257cb2-9198-4a73-820f-8749249690a4', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:07', '2018-11-01 14:18:07', '41', '186', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('82692432-5176-43c2-ad92-ae715df08e7c', '刘恺洁', '648ff0ca-2a11-456b-afd8-b2962c6e650e', '长峰股份', '企业发展部', ' ', '1', '2018-11-01 14:15:23', '2019-01-09 11:37:12', '68', '107', '0', '0');
INSERT INTO `sys_userinfo` VALUES ('840fce96-9802-4c1d-a1ea-1ffe24f6c0c5', '解冰', '62544f61-95a4-465c-a7bf-85bf86dad349', '长峰科技', '战略合作发展部', ' ', '1', '2018-11-01 15:27:29', '2018-11-01 15:27:29', '56', '362', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('84790ca1-3ad6-4fc0-9cbe-9bdb00dcf8d1', '罗琼', 'dfcc8c5f-9816-4f4c-852a-36cb98bb98ee', '长峰股份', '企业发展部', ' ', '1', '2018-11-01 14:15:25', '2018-11-01 14:15:25', '68', '138', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('870da4cf-323b-4084-8ca7-d5a880197b7e', '张克荣', 'bd8b9447-1455-44ab-b5f9-401e2701f88c', '长峰股份', '股份员工', ' ', '1', '2018-11-01 14:15:20', '2018-11-01 14:15:20', '52', '79', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('8760f891-fc08-4f6e-87e5-5a620c697a2d', '李雅娟', '5f9d851e-362f-41bd-bd7e-0e316d435823', '长峰股份', '风险管控部', ' ', '1', '2018-11-01 14:15:24', '2019-01-09 11:51:58', '60', '117', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('87d323cb-12cc-46dc-95b2-822976a87848', '袁冲', '73265be0-5de0-4bd8-b151-680a79765933', '长峰科技', '采购部', ' ', '1', '2018-11-01 14:07:53', '2018-11-01 14:07:53', '51', '62', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('87ec32fc-71a5-4b82-be2d-bd772657fce4', '夏青', 'd3fbcf95-c46a-48ca-a644-a15fea14492f', '长峰科技', '国际事业部', '无', '1', '2019-01-11 14:17:39', '2019-01-11 14:17:39', '73', '411', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('88f63d66-ef28-4694-946b-a3176a0d3d8a', '吕大波', '7991913b-6120-4960-922a-c88dc4467d05', '外来人员', '科工二院领导', '无', '1', '2019-02-26 11:35:44', '2019-02-26 11:35:44', '36', '484', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('8aa3684e-95a4-4247-a159-9f3a5452a521', '崔建国', '5fc74ac8-cea7-425b-b577-285b291ad208', '长峰股份', '股份员工', ' ', '1', '2018-11-01 14:15:21', '2018-11-01 14:15:21', '52', '83', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('8ae7afd2-4cb6-41d0-a044-6b74bcc0a234', '李任杰', '4899f2f4-b19c-46da-8735-911a8fbfa18d', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:32', '2018-11-01 10:46:32', '35', '13', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('8bf23f38-9219-475e-b42c-44d9f3ede6e6', '王鑫', '57213349-3a5e-46d7-9bcd-839672b31479', '长峰股份', '行政保障部', ' ', '1', '2018-11-01 14:15:25', '2018-11-01 14:15:25', '59', '131', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('8ca065c4-51f5-4c06-af8f-ea2f18927ace', '敖丹妮', '13c77385-8465-4c6f-832d-ad2737f38441', '长峰科技', '营销部', '无', '1', '2019-01-11 14:40:17', '2019-01-11 14:43:02', '45', '418', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('8cadcdf9-dbf0-4510-82fc-bf9578539267', '安延群', '7d864416-361e-47fe-a6b8-6a4a8251030f', '长峰科技', '辽宁分公司', '无', '1', '2019-01-15 09:06:36', '2019-01-15 09:06:36', '86', '445', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('8ccf5a78-16ad-4014-afa5-ba022df3cca2', '汪志伟', 'ec37647a-6aab-45aa-bdd6-836ac41ab02d', '长峰股份', '财务部', ' ', '1', '2018-11-01 14:15:24', '2018-11-01 14:15:24', '57', '119', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('8d79450e-9284-49d8-80a2-189e55607dab', '赵然', 'd0606bc1-ef91-420f-af67-9e13b8b0b061', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:05', '2018-11-01 14:18:05', '41', '170', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('8d8c4b76-b420-45d4-9bb9-eeaa6fedd451', '刘京京', '8a25f13e-0ede-4130-8e24-23dce542e9d5', '长峰股份', '行政保障部', ' ', '1', '2018-11-01 14:15:22', '2019-01-09 11:32:10', '59', '102', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('8d96a0a9-a7ee-4bc9-aadd-2f6082f566f2', '高洁', 'de63773f-c093-462f-94fb-abae3bc8cf79', '长峰科技', '总工程师办公室', ' ', '2', '2018-11-01 10:41:23', '2018-11-01 10:41:23', '54', '1', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('8f0417db-edc6-4832-8fb3-c911b6d695d6', '孙珮朕', 'fce07c27-aace-4ee8-b27f-4819b5ee7d19', '长峰科技', '集成项目部', '无', '2', '2019-05-05 17:10:32', '2019-05-05 17:10:32', '41', '515', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('91f276a2-c269-4b47-b282-34e737c1d09f', '李维红', '27dc726b-63c3-454e-a21c-4660bef317ad', '长峰科技', '综合管理部', ' ', '1', '2018-11-01 15:32:26', '2018-11-01 15:32:26', '46', '369', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('93bdb916-2d7e-417e-95ba-3dd9350de425', '吕洋', '93c95a87-0d32-4e33-8a7e-083e83679084', '长峰科技', '浙江子公司', '无', '1', '2019-01-15 09:02:30', '2019-01-15 09:02:30', '84', '442', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('93dec737-92ca-45ba-84a0-77cd742c9dc5', '田粮', 'a37167b0-a506-4677-9a76-f2635a657dc9', '长峰科技', '财务部', ' ', '1', '2018-11-01 14:15:25', '2019-01-09 15:44:04', '48', '132', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('944326d6-5c30-4c04-8ff4-e7a3d376217a', '耿宏捷', 'cd573962-2d74-41b3-95c9-b078792cb0cd', '长峰科技', '北京分公司', ' ', '1', '2018-11-01 14:18:11', '2019-05-16 11:28:42', '92', '233', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('9506c8b3-6357-4408-85c6-529d589626d9', '朱静静', '9ca87c1d-ea0d-4c02-8dbd-6886e0720129', '长峰科技', '西南研发中心', ' ', '2', '2018-11-01 15:05:34', '2018-11-01 15:05:34', '55', '306', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('9538ca69-4f92-4a02-ac49-bf7fd123ce76', '邓世雄', '3f038309-af1b-4ca1-87c4-b0199ad7c91f', '长峰科技', '交通事业部', ' ', '2', '2018-11-01 14:39:45', '2018-11-01 14:39:45', '43', '244', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('960c470b-c739-45d9-a53d-c24b6e07ee28', '黄可', 'c70ecb2f-cb61-431f-a116-11cc3bf3a12f', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:03', '2018-11-01 14:18:03', '41', '146', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('96254cef-774d-4641-91a0-8ca9b8d1722f', '栾晓丹', 'ebd0cda6-f6fd-48d0-a64f-b36f9fdcd8c0', '长峰股份', '研究院', '无', '1', '2019-01-18 18:01:40', '2019-01-18 18:01:40', '63', '451', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('968cd2a9-1ee5-4839-b4e8-c968e4a44548', '陈浩', '21a53145-19fb-4453-8402-38a3f46a2af3', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:06', '2018-11-01 15:23:06', '45', '314', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('96b41bdb-b775-4e45-b77f-faf468c39874', '褚明霞', '08e59956-8bd7-42ae-b6c7-a393a48f4fce', '长峰科技', '营销部', '无', '1', '2019-01-11 13:45:52', '2019-01-11 13:48:03', '45', '401', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('975a2e16-e533-4ba2-806e-953be55d9e27', '袁江明', '74521aa5-17a4-4908-8f1a-e30c116d4df5', '长峰科技', '北京分公司', ' ', '1', '2018-11-01 14:18:12', '2019-05-16 11:24:15', '92', '239', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('977691b7-b82f-407b-8b64-98b3aa9d0590', '魏爱红', 'be57a863-eca7-4617-bfc6-041f906252ae', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:03', '2018-11-01 14:18:03', '41', '149', '1', '3');
INSERT INTO `sys_userinfo` VALUES ('97b24859-2a07-4d10-b5e4-fcc0d7e4dfa0', '姜思琪', '9849b280-d7cd-474e-977f-6086450901fa', '长峰科技', '战略合作发展部', ' ', '1', '2018-11-01 15:27:28', '2018-11-01 15:27:28', '56', '356', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('97fe0640-a58f-4257-89a0-b8690456369f', '侯云龙', '409871ba-a61f-4fba-898d-a486527edf32', '长峰股份', '其他', '科威', '1', '2018-11-01 14:15:22', '2019-01-09 15:31:21', '72', '94', '-1', '4');
INSERT INTO `sys_userinfo` VALUES ('9837592e-e4d7-48f4-a8b7-9b2660680a76', '詹俊妮', '7b0562bb-e56d-45f0-9dfa-50e17c4b61cd', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:12', '2018-11-01 14:18:12', '41', '242', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('9845cc15-bcf5-4ed1-ac21-280943622e6b', '张忠阳', '60886b4a-1614-4c35-8289-2e577e2a1aae', '外来人员', '科工二院领导', '无', '1', '2019-02-26 11:40:30', '2019-02-26 11:40:30', '36', '495', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('9870b913-97af-43ca-bb98-6cdf0cdd209f', '冯志钢', '172c4585-1d78-4ee7-8ffb-1c1a8f3c0443', '长峰股份', '行政保障部', ' ', '1', '2018-11-01 14:15:22', '2019-01-09 11:27:46', '59', '101', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('992c7ca1-3ddd-49e1-af90-e262325fda3d', '黄颖', '7d590405-9a3a-43f1-94f1-686b7665bf31', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:05', '2018-11-01 15:23:05', '45', '308', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('993a008b-ece8-41f8-8041-a26351a9b760', '于菲', '6f15e12c-0c0d-42f2-9ce3-4c9be490028e', '航天长峰', '外来人员', '无', '1', '2019-03-10 17:57:17', '2019-03-10 17:57:17', '28', '499', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('99b0fd03-8f86-4b7b-a1b5-9225504ddf68', '吕慧', 'eafc7094-5683-437c-ad41-f5ea17686266', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:07', '2018-11-01 15:23:07', '45', '325', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('9aa19dbc-618e-4659-be61-88aea2b783ba', '李春阳', '237743f4-676d-4865-863b-c5dd62ec4066', '长峰科技', '战略合作发展部', ' ', '1', '2018-11-01 15:27:28', '2018-11-01 15:27:28', '56', '358', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('9b71a20a-8251-40cd-9d9f-46bad8fd1a0b', '冯杰鸿', '167e82cc-bf9b-4bb4-908d-679b356d4aef', '外来人员', '科工二院领导', '无', '1', '2019-02-26 11:31:25', '2019-02-26 11:31:25', '36', '473', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('9c9b194d-69ca-46d3-a139-ef194695abdf', '孙宝鸣', 'adbcba98-fe3c-4e33-af2d-101454a072b1', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:09', '2018-11-01 14:18:09', '41', '205', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('9e14707d-a6ef-4bd4-be90-6bf690945cf4', '马杰', '492dde2b-ead4-4eb4-b9ac-b8fbc4fcf883', '外来人员', '科工二院领导', '无', '1', '2019-02-26 11:36:05', '2019-02-26 11:36:05', '36', '485', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('9e21643f-80d4-4fdc-ac5f-6debacebea3d', '李树鑫', '3495d869-a036-4eda-b689-acd91bffb4c5', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:09', '2018-11-01 14:18:09', '41', '215', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('9e2c665f-2240-4931-9ddf-83a6595c2562', '张章', '92da9e67-9578-4e23-b1f3-2ab4839cf405', '长峰股份', '总裁办公室', ' ', '1', '2018-11-01 14:15:23', '2019-01-09 11:45:06', '64', '111', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('9eefbc85-2c3c-4ad2-9729-2f8a952e9ca4', '王亚超', '9f372191-0ac4-4d3a-b3a4-e72af3957595', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:10', '2018-11-01 15:23:10', '45', '346', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('9f4f6407-4ed1-4702-bb2c-9b29f744d17b', '里根', 'bb2102b2-d75c-4ec1-8f21-9a02e9babf61', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:05', '2018-11-01 14:18:05', '41', '166', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('9fc845c2-9189-46fd-9a35-40b61d216b7a', '徐建良', '7ef3d6c4-ca0a-4625-8cbc-4d168c01e621', '外来人员', '科工二院领导', '无', '1', '2019-02-26 11:37:37', '2019-02-26 11:37:37', '36', '489', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('a150be43-551c-4b09-9892-d7bb010b41ee', '唐嘉宇', '5004f1e3-fac2-41e1-b71a-4eaf585614b7', '长峰科技', '军工事业部', '', '2', '2018-11-30 16:43:26', '2018-11-30 16:43:26', '42', '378', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('a182e51f-44b5-42ed-9ea7-55fd7b54fc6b', '王琦', 'b8027dd0-1e45-489e-b89f-0a3d521cc973', '长峰股份', '人力资源部', '', '1', '2019-01-03 16:04:09', '2019-01-03 16:04:09', '61', '386', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('a25d877d-e1f5-45a1-9ac2-60d97cae8f8e', '许明', '90753d02-8b11-4411-bd7f-0a7595ae642b', '长峰科技', '广西分公司', '无', '1', '2019-01-11 15:05:57', '2019-01-11 15:05:57', '79', '423', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('a2d74b67-77b4-4b60-b936-fb6ad28da791', '朱琪', '780788d9-8ee5-4766-b4c2-a27661ee5ae7', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:08', '2019-04-03 16:51:07', '42', '284', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('a318588b-c51d-4ca2-a5e3-4d7dd6416f9c', '田辉', '4a73942a-7336-434c-a23f-f09fa7c6419a', '长峰科技', '财务部', ' ', '1', '2018-11-01 14:01:38', '2018-11-01 14:01:38', '48', '52', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('a367bfff-bf7d-4734-a052-79916ef0aa4a', '梅丹玮', '84899fde-9c5e-43ae-80e9-540fcb66b649', '长峰科技', '产品部', '', '2', '2018-11-13 16:29:15', '2018-11-13 16:29:15', '35', '375', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('a3a107bb-6a2f-480f-bc3c-7d7629f13792', '申雅华', '08dc94da-8af7-4c98-abb7-736c2dd2025a', '长峰科技', '北京分公司', ' ', '1', '2018-11-01 14:18:10', '2019-05-16 11:21:05', '92', '229', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('a40211bf-2342-4aca-b3d8-8bd9a4b30763', '孟凡芹', '794cd951-ad79-4f50-a2e8-3efb3d69d130', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:33', '2018-11-01 10:46:33', '35', '17', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('a59fe270-8c2a-45bd-bd2e-cdea1c82c394', '曾爱军', '4baaebb0-98f7-40cb-a448-7302755019c5', '长峰股份', '其他', ' ', '1', '2018-11-01 14:15:23', '2019-01-09 11:41:06', '72', '112', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('a627542a-3a1a-4352-9028-3d608d137ab5', '王宇', '7e84cc36-7f41-4299-a147-0564269a3c1b', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:10', '2018-11-01 15:23:10', '45', '347', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('a64e3c00-5e19-4f4d-a2be-a0b60dd2181d', '贺中', '0c74bf37-f625-4bfd-b3cd-3c0aad7f8199', '长峰科技', '科技领导', '无', '1', '2019-01-14 09:45:37', '2019-01-14 09:45:37', '44', '429', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('a67a38fc-2b32-412c-8c10-a6fbac3c4214', '虞涛', '8e7965f6-e964-43ed-add2-52c8470b4bbd', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:10', '2018-11-01 15:23:10', '45', '351', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('a6e80488-2036-4512-a0ae-f158a3cbad09', '陈淼', 'e523a97e-7f0d-4f25-97a3-9bbfaef40420', '长峰股份', '党群纪检部', ' ', '1', '2018-11-01 14:15:20', '2019-01-09 10:29:47', '58', '69', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('a74b362d-abc1-408f-aa1c-1e2cd2885bd0', '杨征宇', '8c9847b1-5a37-4e86-ae6e-0aabd3ff55c2', '长峰科技', '北京分公司', ' ', '1', '2018-11-01 14:18:10', '2019-05-16 11:28:01', '92', '219', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('a7bac709-58f7-4ad4-8c36-16ee1ec19a35', '张彤', 'ce447f0d-5535-4cc4-896a-1f6238be9876', '长峰科技', '营销部', '无', '1', '2019-01-11 14:39:46', '2019-01-11 14:39:46', '45', '417', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('a825e56a-e091-4acf-9abb-976c2a55df0c', '田鹏', '2352f17c-5dc3-4f57-9cb1-310e70bc18e3', '长峰科技', '集成项目部', '无', '2', '2019-04-25 09:16:12', '2019-04-25 09:16:12', '41', '513', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('a8c49d81-ef8c-49d7-92ff-bb55ba20d4ea', '陈鸿如', 'fef61dcc-46d9-41c4-83f6-5bafd0958ea6', '长峰股份', '航丰路六号院', ' ', '1', '2018-11-01 14:15:19', '2019-01-09 10:26:49', '69', '68', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('a997ebf8-b2a8-4c47-afe2-cebedafa5f3a', '郑伟', '1f1321a1-62e3-4a58-9155-4adfdba4d061', '外来人员', '科工二院领导', '无', '1', '2019-02-26 11:40:53', '2019-02-26 11:40:53', '36', '496', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('aae51819-0f81-40f6-8bb7-ce99de74e175', '陈鹏', '0a351277-9ddf-4121-abe0-ec5473e80132', '长峰科技', '云南办事处', '无', '1', '2019-01-18 10:14:16', '2019-01-18 10:14:16', '89', '449', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('ab4edcf1-a897-437b-90d6-d440e9c644ec', '谷小頔', '7f46f491-f936-4cdf-8afe-e7f46225af34', '长峰科技', '人力资源部', ' ', '1', '2018-11-01 14:56:14', '2018-11-01 14:56:14', '50', '289', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('ab515ab7-d466-4e46-a5d9-78cbe5883181', '徐璐', 'fb9d81db-4bb6-4e9c-930b-a0d034e0523b', '长峰科技', '国际事业部', '无', '1', '2019-01-11 14:18:08', '2019-01-11 14:18:08', '73', '412', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('abbbf973-8fc3-429d-838b-833432bf172b', '陈永进', '57a12f7c-8e0a-4791-9f4a-b90b2cc8d9e8', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:04', '2018-11-01 14:18:04', '41', '158', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('ac2146bb-0aa3-419f-9e6c-8697038467e3', '范亚琼', '29786623-b9d3-4fff-bc2f-485f60a828a2', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:11', '2019-04-16 11:38:53', '41', '237', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('acbcc386-5f30-496b-87b0-252ec859717a', '任如意', 'bb77a9c2-8c81-4e80-8b85-477bc9361666', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:08', '2018-11-01 15:23:08', '45', '330', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('acf8f7fc-a310-48e7-a38a-3202eed78a6e', '鲍海涛', 'bcd66c20-f6d0-4c0f-9f13-2416b7e0d1e4', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:03', '2018-11-01 14:18:03', '41', '148', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('ad1fd075-8459-490e-83e4-1ce370c72db0', '贺妮佑', '26e43d50-139e-4814-9a85-4743c14aef7c', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:06', '2018-11-01 15:23:06', '45', '318', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('ad76e8bb-0fe9-4b20-ac3d-9d33c7a70dbe', '任洪江', '56b9b591-d3ab-436d-a387-0ccdb3c5f09b', '长峰股份', '其他', ' ', '1', '2018-11-01 14:15:22', '2019-01-09 11:22:19', '72', '97', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('ae75edb3-1419-44f9-b80e-f5aa8e1de3b8', '程庆文', '937a4d55-7089-4ffa-b0b5-0a4241f72ce8', '外来人员', '科工集团领导', '无', '1', '2019-04-15 17:03:33', '2019-04-16 11:05:24', '91', '507', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('af669ff2-1372-4973-b00e-26bd64885081', '陈冬雪', 'ec928780-6ea3-4d7d-b105-b824a9640e23', '长峰科技', '综合管理部', ' ', '1', '2018-11-01 14:39:45', '2019-01-09 08:55:04', '46', '243', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('aff25c15-e0ce-4397-97f0-b2c1fb10d332', '陈静', 'bb0479d2-d320-4d9f-8de2-cf1f6cc0ae38', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:31', '2018-11-01 10:46:31', '35', '9', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('b01ceab3-3101-4a68-9324-f6204ec918bd', '熊伟', 'b0c917a7-405c-4590-8942-c893cbd8195d', '长峰股份', '企业发展部', ' ', '1', '2018-11-01 14:15:24', '2018-11-01 14:15:24', '68', '122', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('b0575839-b6e2-4a84-9d2c-943dd1ca8116', '赵金洪', 'e285924a-3a6b-4649-acda-5240af2bcaff', '长峰股份', '行政保障部', ' ', '1', '2018-11-01 14:15:20', '2019-01-09 10:38:48', '59', '73', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('b05906ad-12b1-42f5-aaac-a0c331ca1221', '柴秀英', '57cb6667-b986-4825-b079-712a64119f04', '长峰科技', '西南研发中心', ' ', '2', '2018-11-01 15:05:33', '2018-11-01 15:05:33', '55', '297', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('b1bda643-32a4-47f4-a6b7-e64fa2167931', '庞路明', 'a44f6e15-9427-4ed1-93e1-f156a33b8e96', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:07', '2018-11-01 14:53:07', '42', '273', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('b1d395b9-87ec-4e82-883b-b786f1798552', '陈守峰', '089dfbb0-191f-4d1e-b9ea-44ea88af0c16', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:05', '2018-11-01 14:18:05', '41', '161', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('b23e0720-0fcd-4559-945e-2e867e5f6284', '黄云海', '95b1a20a-f072-499a-acf8-227223667b19', '外来人员', '科工二院领导', '无', '1', '2019-02-26 11:33:42', '2019-02-26 11:33:42', '36', '479', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('b2bd2ef0-9bff-40e2-8c46-99a713dd9578', '张振兴', '4563935f-5366-4691-8665-08a8aa7fa609', '长峰科技', '上海分公司', '无', '1', '2019-01-15 09:04:46', '2019-01-15 09:04:46', '85', '444', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('b2cab46d-87aa-4fcc-9bb0-158357f3632d', '曹德峰', '654e7d35-d9cc-4479-9b1e-dc4e321eb1fa', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:08', '2018-11-01 14:53:08', '42', '282', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('b31dd75b-8172-4826-bef0-1ece4134172b', '李明', 'b9d58e8f-15b6-4cb4-87aa-dd78398eadf9', '长峰股份', '党群纪检部', ' ', '1', '2018-11-01 14:15:23', '2019-01-09 11:47:47', '58', '113', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('b3364acd-f4f6-47d5-9d84-9f7fe23a82c9', '张凯', '17d453e6-7ed0-423f-b54b-3afb3709fcad', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:06', '2018-11-01 14:18:06', '41', '181', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('b369daf8-fc59-45ed-8edc-38babcc905b9', '贺云宝', '6ce40833-921a-4e1f-b7ae-ef576ba55ee1', '长峰科技', '浙江子公司', '无', '1', '2019-01-23 14:24:06', '2019-01-23 14:24:06', '84', '456', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('b3824a08-7a8f-4666-962c-76fe60017935', '王高磊', 'a50c7397-6d33-4133-a54e-3591f757cffa', '长峰科技', '西南研发中心', ' ', '2', '2018-11-01 15:05:33', '2018-11-01 15:05:33', '55', '295', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('b3df1f47-a53c-4f81-ac40-856c18d04bdb', '武超', '718210d3-e8e6-4fa1-9c49-e0402a1b0b7d', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:10', '2018-11-01 14:18:10', '41', '222', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('b42f9c0c-e34c-45d1-8b6f-5644d60e3ae0', '闫伟夏', '33aca440-2fc3-420a-91bd-1311d9b843d5', '长峰科技', '北京分公司', ' ', '1', '2018-11-01 15:23:06', '2019-05-16 11:39:48', '92', '315', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('b4d5c154-5d4a-4c67-bc68-9781fb2f16e7', '张喜明', '97a2d7f0-b90d-48a2-af5b-ed175bcef4e4', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:06', '2018-11-01 14:18:06', '41', '180', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('b57b87be-818f-4b78-84a4-21187a154469', '夏文莉', '49b6df94-0024-4fe6-8e2e-73fb40ba5613', '长峰科技', '北京分公司', ' ', '1', '2018-11-01 14:18:09', '2019-05-16 11:22:16', '92', '204', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('b5a657a9-9b88-43d2-a63f-4110d161cb2f', '王艳彬', '73c6c3bd-1eb4-4769-bf97-4e0450946c5f', '长峰股份', '股份领导', ' ', '1', '2018-11-01 14:15:24', '2018-11-01 14:15:24', '38', '129', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('b5c7bf55-940d-4ffd-b590-79c1c49009e4', '田磊', 'f07fa9ee-dbe0-49d4-a97e-4eeed37a29d6', '长峰科技', '采购部', ' ', '1', '2018-11-01 14:07:53', '2018-11-01 14:07:53', '51', '61', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('b60c0621-3d76-478b-9ff1-a94fd89fa275', '杨淼', 'b0e1912b-0bad-47c6-b991-f2505fb22262', '长峰科技', '江苏分公司', '无', '1', '2019-01-11 09:45:52', '2019-01-11 14:06:40', '76', '397', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('b7796db8-5677-4e33-b8c5-3b2489930ed1', '刘石泉', 'bcd8ea64-5390-4693-85e7-9fab6ab8df85', '外来人员', '科工集团领导', '无', '1', '2019-02-26 09:59:54', '2019-02-26 09:59:54', '91', '469', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('b7f2c08d-f3cd-4577-b191-ea7ee1e67d0b', '徐佩', '5730aa3e-b8d1-4aa3-a421-eba11b576cd7', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:08', '2018-11-01 14:53:08', '42', '281', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('b867df19-2742-4cd1-bc4c-b19b5dc3e7a8', '王悦', '9f73d797-1b63-4629-b28f-0fb8099617d0', '长峰科技', '经营计划部', ' ', '1', '2018-11-01 14:43:13', '2018-11-01 14:43:13', '49', '250', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('b8a84fe0-907e-440a-afe0-6d3f0217a4c7', '郭春燕', 'e97e6ad7-5009-4bbf-a791-e00bcd6f4b35', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:05', '2018-11-01 14:53:05', '42', '261', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('b8bc9a6d-d571-41f1-8d9d-751a9bad00b6', '王世娟', '22271053-b3de-4a4a-be99-76cb2fef70fc', '长峰股份', '财务部', ' ', '1', '2018-11-01 14:15:24', '2019-01-29 10:32:07', '57', '123', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('b9267268-9376-4ba8-abad-982e29c0168c', '刘颂秋', '1006d2ec-f859-418b-8b87-f1661ffc7929', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:08', '2018-11-01 14:18:08', '41', '198', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('b947d1cd-4724-4165-a13d-3a6284291504', '魏毅寅', '67fbadd6-ef18-4c5d-8f48-51f592386d85', '外来人员', '科工集团领导', '无', '1', '2019-02-26 10:00:20', '2019-02-26 10:00:20', '91', '470', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('b9de6aff-cd66-4248-b64c-dbea9e32e3b4', '徐敏刚', '59b835e8-3380-4bf5-9672-a43f18ad2b79', '外来人员', '科工二院领导', '无', '1', '2019-02-26 11:38:15', '2019-02-26 11:38:15', '36', '490', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('ba0a246f-fc38-4aeb-a6d4-81389179087f', '刘著平', '495769be-7783-4319-90ad-3590371eaf42', '外来人员', '科工二院领导', '无', '1', '2019-02-26 11:35:20', '2019-02-26 11:35:20', '36', '483', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('bb5d332b-ad10-4314-9c82-ff121d6fbb04', '霍脱园', '61bd07d3-8b58-4d3f-bc5b-88431be80819', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:04', '2018-11-01 14:18:04', '41', '156', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('bbf782f2-9fd6-465b-9d36-7ff50b33e6bd', '武玉亭', '3283829b-f00f-4f9a-875b-8c3e5da0530b', '长峰科技', '西南研发中心', ' ', '2', '2018-11-01 15:05:33', '2018-11-01 15:05:33', '55', '296', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('bdd99c2f-d584-4443-a72d-2d42c93cb4e3', '郭凯', 'de5f0d9e-27e1-44a3-a6cc-def193552aff', '长峰科技', '吉林分公司', '无', '1', '2019-01-11 14:01:57', '2019-01-11 14:26:33', '80', '406', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('be5d952f-6afd-4430-8725-e8d92142371b', '黄农运', '651f3fbb-f1c2-4cb4-a91f-80f100f58f37', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:05', '2018-11-01 15:23:05', '45', '310', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('bf5b82e1-bc22-4dbd-aaa3-f7b2734cd531', '陈旭均', 'ffb219ec-3306-479e-bafa-5821f3c75527', '长峰科技', '广东分公司', '无', '1', '2019-01-23 14:27:43', '2019-01-23 14:27:43', '67', '458', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('bf6fa824-6b17-48d8-b989-7e96fa83026d', '吴哲', '97a25117-8aef-474b-aeda-11b8db13e6ab', '长峰科技', '江苏分公司', '无', '1', '2019-01-11 14:05:00', '2019-01-11 14:05:00', '76', '408', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('bf8b5830-54c6-4845-bada-2f0627fb8bb6', '陈楠', '92ce653c-a8ae-45d3-a793-b581a1f6f089', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:05', '2018-11-01 14:53:05', '42', '258', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('c045f4bd-f32c-4708-aa30-d3cc5bdfa1e6', '毕春艳', '2c4eb3d9-5390-4869-8a47-bbfc24a995b9', '长峰科技', '产品部', '无', '2', '2019-05-16 13:25:51', '2019-05-16 13:25:51', '35', '516', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('c06d744c-768f-4a15-b953-f84799ca20fb', '费海伦', '1d9734c2-5ea7-4ebd-8f3d-398b4060a592', '外来人员', '科工二院领导', '无', '1', '2019-02-26 11:30:48', '2019-02-26 11:30:48', '36', '472', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('c0db391b-d02e-4c07-8575-fd6b8f56e296', '张超', 'e5197f58-d5c4-4a5c-bc0a-dacef00e7533', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:07', '2018-11-01 14:53:07', '42', '280', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('c1999765-3273-412b-84b5-337f640b7379', '贾文涛', '12eaebb3-37f9-4e23-9d5d-bc3a6e9ca464', '长峰股份', '企业发展部', ' ', '1', '2018-11-01 14:15:26', '2018-11-01 14:15:26', '68', '145', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('c1da0ece-f644-4284-8c8d-5165f4931c95', '董石峰', '986927e5-ccaf-4b53-bc1f-a9589b5120bf', '长峰科技', '经营计划部', ' ', '1', '2018-11-01 14:43:13', '2018-11-01 14:43:13', '49', '249', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('c3896925-3891-44a8-8cb3-8a4f9f3ba0ba', '程义', '25abf145-8e65-49f2-bd78-242adec97010', '长峰科技', '深圳分公司', '无', '1', '2019-01-14 10:08:51', '2019-01-14 10:08:51', '75', '437', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('c3c95cda-3875-4d00-810c-a97c77314f65', '王馨培', '78affb1f-85ac-4ca3-8268-c42528e91934', '长峰科技', '人力资源部', ' ', '1', '2018-11-01 14:56:14', '2018-11-01 14:56:14', '50', '291', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('c3ca63f2-c9b1-43a4-b358-3e7f238be73b', '薛振宇', '072a19e6-0fdd-44a4-805d-0798302fe219', '长峰科技', '新疆分公司', ' ', '1', '2018-11-01 14:18:11', '2019-01-09 08:24:09', '65', '238', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('c511b29e-8ac5-4e91-9d06-ebb8732e93cf', '程凌峰', '8a765bae-47f6-4b4a-b3bb-9544a3c93490', '长峰股份', '人力资源部', ' ', '1', '2018-11-01 14:15:25', '2019-01-04 10:18:06', '61', '133', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('c54ae56e-b25b-455b-bfd5-5a47b62001f2', '薛军平', 'dce0e7a4-39cc-43c7-99d2-8cd64c95165e', '长峰科技', '甘肃分公司', '无', '1', '2019-01-11 13:53:36', '2019-01-11 13:53:36', '78', '404', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('c5e4d13b-ec64-4d63-aba1-091ae9919486', '郭百强', 'f0f46d12-3781-4f6e-9844-f4026877bb13', '长峰科技', '总工程师办公室', '无', '2', '2019-03-22 11:11:02', '2019-03-22 11:11:02', '54', '502', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('c61f51b3-6a79-4aad-b44e-20b83022cc20', '刘菲', '70fdb029-7daf-45e0-81c5-b10ad39577a6', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:07', '2018-11-01 15:23:07', '45', '327', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('c62478b1-e447-4e2c-83d1-99a6e6c7f7a1', '田力', '6292f78e-8d6c-4c52-a9f7-649fb1be088c', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:07', '2018-11-01 14:53:07', '42', '271', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('c653a70b-bcdd-4357-a82e-93a8959f45bb', '苏荣', '612504fa-8372-43cc-9370-198581e874e2', '长峰股份', '财务部', ' ', '1', '2018-11-01 14:15:25', '2018-11-01 14:15:25', '57', '140', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('c65ee0c3-023b-4054-ae95-5c99e5074c7a', '费博研', 'e18b8cd5-763d-4da1-a268-c2e24415de4b', '长峰股份', '企业发展部', ' ', '1', '2018-11-01 14:15:26', '2018-11-01 14:15:26', '68', '144', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('c67dd141-3f19-4807-ab51-25b60bd282c9', '韦祎炜', '61d0df6a-3f3e-424b-a012-f114d72ccece', '长峰股份', '股份员工', ' ', '1', '2018-11-01 14:15:19', '2018-11-01 14:15:19', '52', '67', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('c74b2588-dd4e-4a0e-bbce-62707e1995bd', '王文松', '9ab891a3-804b-413c-a483-6484c39cbab3', '外来人员', '科工二院领导', '无', '1', '2019-02-26 11:36:49', '2019-02-26 11:36:49', '36', '487', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('c77e7028-6362-42d8-bbd8-27d771d814d7', '冉海燕', '21899a97-24b2-4c37-af4b-088bf3489d57', '长峰科技', '新疆分公司', '无', '1', '2019-01-11 14:20:40', '2019-01-11 14:20:40', '65', '415', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('c8332968-31a2-48a2-80f9-6dd5e1a1946e', '程舰', '772f8e5c-fe60-495d-a02b-64b4e28887ea', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:35', '2018-11-01 10:46:35', '35', '37', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('c9016f9b-1330-4e16-b37f-97c1df4e955d', '石磊', '03bdc540-7560-4b74-8342-bb7e169abf77', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:10', '2018-11-01 14:18:10', '41', '230', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('c97a6021-a6df-4b57-91f5-37527875251e', '刘磊', '4713910e-9d91-477a-9fb2-45cff76b67ce', '长峰科技', '军工事业部', '无', '2', '2019-04-08 11:05:47', '2019-04-08 11:05:47', '42', '505', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('c9bc0cb8-d638-4acc-a5c5-ccb44a8d164e', '李明柯', '81042cd2-9569-4935-a22c-1a2f14df1fc8', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:09', '2018-11-01 14:18:09', '41', '214', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('ca185cb2-44ff-461d-936d-2f933a949cde', '李健', '981e715e-4f0c-4649-b930-88afc52ab5d4', '长峰科技', '广东分公司', '无', '1', '2019-01-14 10:07:09', '2019-01-14 10:07:09', '67', '436', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('caa9976c-4895-47bb-93e3-0de73846d193', '程鹏', '56578d45-fa48-45bb-b5a9-ad7475040737', '长峰科技', '国际事业部', '无', '1', '2019-01-11 13:41:28', '2019-01-11 13:41:28', '73', '400', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('cac32bfb-da54-4db1-bb92-1cd967920b92', '张云', 'eed9b6fe-69e8-4053-9650-2050a3156f77', '长峰科技', '经营计划部', ' ', '1', '2018-11-01 14:43:13', '2018-11-01 14:43:13', '49', '253', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('cb7c6112-1dc3-404a-88c2-7328061f29ef', '林华', 'c499ac6c-dae9-4062-b873-c5bc4ec55d61', '长峰科技', '科技领导', '无', '1', '2019-01-14 09:48:46', '2019-01-21 11:04:28', '44', '430', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('cbd7c56a-6f5f-4825-98cf-51f6602b0eb9', '栗晓杰', 'cc048c30-4ac9-4da3-855f-67c3288a672d', '长峰科技', '深圳分公司', ' ', '1', '2018-11-01 15:23:09', '2019-01-11 09:17:00', '75', '343', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('cc09a660-5e80-4948-890c-d11d30b8d149', '雷蕾', '7d7b2922-a03e-4958-abcc-9552d82025af', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:06', '2018-11-01 15:23:06', '45', '312', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('cc37ac89-336a-4a36-83da-56614465264e', '张妍', '201b9f78-2e49-49cd-adda-e69e615d2215', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:07', '2018-11-01 15:23:07', '45', '322', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('cc92b583-94ed-4199-a32e-af02fc00d481', '程晓鹏', 'd41d7eff-9533-446a-83d2-96ed7de0cd18', '长峰科技', '交通事业部', ' ', '2', '2018-11-01 14:39:45', '2018-11-01 14:39:45', '43', '245', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('cddc8dfa-848f-42c7-aa35-acbe948310b7', '武卫文', 'a0a7ce18-6326-4009-8901-e2f955aad36d', '长峰股份', '研究院', '无', '1', '2019-01-04 15:59:58', '2019-01-04 16:01:17', '63', '394', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('ce3e8b8f-fb96-4bf3-b027-50a5a5e46a84', '姜升海', '675884fe-65ad-4d56-b75a-b1f32d850f2c', '长峰股份', '航丰路六号院', ' ', '1', '2018-11-01 14:15:21', '2019-01-09 11:13:07', '69', '89', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('cf514663-c022-4e08-9f13-c26bfdd9df4c', '孙靖淇', '9ae8d41a-22aa-4cef-aad6-4c9379027fb9', '长峰科技', '北京分公司', ' ', '1', '2018-11-01 14:18:07', '2019-05-16 11:27:16', '92', '190', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('cfce7148-46bc-48da-8b93-30a1d9a46fdd', '刘欣浩', 'c97d9948-0a5e-45cf-ba10-68ff18b575b0', '长峰股份', '其他', '内退', '1', '2018-11-01 14:15:23', '2019-01-09 11:38:39', '72', '108', '-1', '3');
INSERT INTO `sys_userinfo` VALUES ('d00bf2ba-c247-467a-9334-0354868d3118', '王海峰', '390a90ae-2ac3-4a2f-9a1b-088e2005708e', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:08', '2018-11-01 14:53:08', '42', '287', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('d082b52e-0eed-4f71-a380-172ad4d14b82', '马连轶', '79ddcc09-4118-4d51-a1f8-90d4889942c7', '长峰科技', '科技领导', '无', '1', '2019-01-14 09:50:28', '2019-01-14 09:50:28', '44', '432', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('d17a3399-957a-4f1b-9169-6689125546bb', '赵天雯', 'e9b4f99e-6053-4fea-804e-884befd8e58c', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:05', '2018-11-01 14:18:05', '41', '172', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('d191de06-3e52-4bc1-bac9-5734be2ba2db', '于飞龙', 'ce58a9d6-a707-4c9f-84b0-93e0eb3f8abb', '长峰科技', '营销部', '无', '1', '2019-01-11 14:39:06', '2019-01-11 14:39:06', '45', '416', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('d1d7d0e8-4470-4999-8d6d-34642a67fed3', '赵晓伟', 'd6e3091a-c461-4423-a3cd-533ecb9c6ac8', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:05', '2018-11-01 14:18:05', '41', '171', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('d226bd81-938b-49e5-b2a5-a01099861ec2', '喻鑫', 'cf2fdf5b-5117-4c6b-8903-81e70e5915e3', '长峰科技', '北京分公司', ' ', '1', '2018-11-01 14:18:08', '2019-05-16 11:29:16', '92', '203', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('d2b66250-39af-41ab-986c-3d96a7b1192a', '陈慧娟', '9ffa10ff-e6b7-442e-bd46-9954ffce8d35', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:04', '2018-11-01 14:18:04', '41', '160', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('d2e39967-894b-43d7-9a60-73414a742797', '吴晨阳', 'd30a1aeb-9f22-414c-822d-e187c95bc744', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:07', '2018-11-01 14:53:07', '42', '275', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('d2f1dd99-c33f-4e7d-94a4-7a968a645c3c', '王昊宸', '37023f2e-67f3-4e4d-bd15-77389e283a89', '长峰科技', '采购部', ' ', '1', '2018-11-01 14:07:53', '2018-11-01 14:07:53', '51', '60', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('d322235e-2889-4649-94a2-2f961b25a0c6', '尚珊萍', '98944174-5a3c-4751-b267-b20c87d9c3ba', '长峰股份', '股份领导', ' ', '1', '2018-11-01 14:15:21', '2019-01-09 10:55:24', '38', '85', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('d48a4ea7-bf2d-462a-9d9a-c2984f5ac0e5', '雷焕春', '914b1d13-16ef-4d86-a32c-8b651e3c944d', '长峰科技', '北京分公司', ' ', '1', '2018-11-01 15:23:06', '2019-05-16 11:40:22', '92', '313', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('d4987f9e-127b-476d-a0b9-1901285c8279', '侯业', '0cb11020-5e64-4ba5-923d-6906d99f76a2', '长峰股份', '其他', '退休', '1', '2018-11-01 14:15:22', '2019-01-09 11:20:51', '72', '95', '-1', '3');
INSERT INTO `sys_userinfo` VALUES ('d5ce1dd4-92a3-4049-990d-7ed2f10b2963', '赵曼', 'f39855e2-b4a2-4ec8-bb74-5a722cf800d6', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:36', '2018-11-01 10:46:36', '35', '42', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('d8277168-c854-4f87-b419-2e01fe45fe4b', '李灵杰', 'ab238678-76bb-4f00-abfc-2966f27063ea', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:34', '2018-11-01 10:46:34', '35', '28', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('d88d1baf-567f-4fa1-b685-64fa6ed8bae1', '范晨亮', 'fb2f7dc4-3b76-4716-8cc5-fd16e47d9666', '长峰股份', '财务部', ' ', '1', '2018-11-01 14:15:26', '2018-11-01 14:15:26', '57', '142', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('d8d98a87-d7c4-416c-b1ec-3371242e27b5', '刘传东', '4c62dd3b-3c38-4a06-b559-d3c7a26c2638', '外来人员', '科工集团领导', '无', '1', '2019-02-26 09:59:28', '2019-02-26 09:59:28', '91', '468', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('da867173-83fa-40eb-bb12-66399998fa33', '黄昕', '57d73f76-be2b-4868-814e-cb05ac8b8a0f', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:05', '2018-11-01 14:53:05', '42', '255', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('daec14b8-20e4-44d9-992e-13eaa42734a1', '李水', '7bce6ae5-bed7-4328-84be-b174eabc492f', '长峰科技', '交通事业部', ' ', '2', '2018-11-01 14:39:45', '2019-04-15 17:02:18', '43', '248', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('daf2780c-b6d2-4f6f-87b2-edf6074086ce', '罗欣', '70c4d641-364e-46bd-b926-ebd7b3645788', '长峰股份', '财务部', ' ', '1', '2018-11-01 14:15:25', '2018-11-01 14:15:25', '57', '137', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('db6deabc-b3e7-4cd7-85b2-1511e67a3c47', '刘磊', '6b0888f6-1173-479a-85c0-8cbeb990fcc4', '长峰股份', '股份领导', ' ', '1', '2018-11-01 14:15:23', '2019-01-09 11:42:43', '38', '109', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('dc0af6ff-4096-4c22-8e9b-fcfc5f2c1643', '徐琳粤', '5150c27b-4678-40a0-aba7-311d8ccf4088', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:08', '2018-11-01 15:23:08', '45', '335', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('dc1e49c9-1fcf-4998-b678-152fd06e349a', '刘璐', '17486962-abd1-4a7c-bb0e-866a8e6888b9', '长峰科技', '国际事业部', '无', '1', '2019-01-11 14:03:23', '2019-01-11 14:03:23', '73', '407', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('dc2e11e6-3f92-4ac2-af47-3853beeabbe6', '汤滔', 'e00d8884-97a1-4119-860a-717c02fb4ec6', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:34', '2018-11-01 10:46:34', '35', '32', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('dc637d32-f0eb-478e-8417-32b84ff9464d', '陈加', '5f2db1b1-e2d6-4922-9133-f1bd24c3ce5f', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:05', '2018-11-01 14:18:05', '41', '162', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('dd09f942-b798-4df2-b866-0ab3d0531d76', '李祥', 'bee453ce-ab37-4540-adfa-c3c6760d170c', '长峰科技', '战略合作发展部', ' ', '1', '2018-11-01 15:27:28', '2018-11-01 15:27:28', '56', '359', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('de22cc08-4c29-4f09-a969-986d2cf64948', '刘宁', '35854204-ce89-4a5e-8720-f53252add979', '长峰股份', '财务部', ' ', '1', '2018-11-01 14:15:23', '2019-01-09 11:36:16', '57', '106', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('ded9741b-d781-4901-83f2-0af9d93db6cd', '谭静', '309159d8-d3c1-4622-bf85-bffa13bff4ca', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:10', '2018-11-01 15:23:10', '45', '352', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('df1e3d18-b49d-49d8-9bb6-6c5ba73c30c4', '焦佳岩', '5b548ecb-85fb-4b25-999c-8ae5c56b0fa2', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:10', '2018-11-01 14:18:10', '41', '224', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('e0297c3a-73cf-4ac3-bb06-13dd44ce6668', '刘房', '5df5cae4-eaa2-4279-b996-a95d3f25a96a', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:33', '2019-04-16 08:51:24', '35', '22', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('e114a366-05aa-497f-b227-46c272718129', '颜亦文', '48abd40f-0ab9-428b-9b94-2cd45709f78f', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:04', '2018-11-01 14:18:04', '41', '154', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('e18f6170-ab43-4001-897e-3c0e84939c93', '李茹', '83129ad4-1a56-4e4f-b556-5e8f2a475e6d', '长峰股份', '风险管控部', ' ', '1', '2018-11-01 14:15:24', '2019-01-09 11:50:36', '60', '116', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('e1b3277f-a543-479f-9308-4156df1faed0', '闫聪聪', 'ab233ff9-6032-456b-ae29-f53891873749', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:32', '2018-11-01 10:46:32', '35', '11', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('e28857be-a46f-4f67-ac77-914e04e935e7', '于薇', '31efa23d-bea9-4c18-a7a8-fc66cf3b3d28', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:08', '2018-11-01 15:23:08', '45', '328', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('e39b4633-8bdb-4e4c-b8da-0e191aa70dd0', '朱嘉琳', 'cacacc9e-f008-426b-8dd1-4fd5d0b25871', '长峰股份', '风险管控部', '', '1', '2019-01-03 16:01:25', '2019-01-29 10:36:02', '60', '385', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('e3ac976f-d736-4283-9e42-1d26956a4992', '黄抒敏', 'd7af7d1b-198c-4c47-99e0-9b4afc4446aa', '长峰股份', '企业发展部', ' ', '1', '2018-11-01 14:15:19', '2019-01-09 10:18:02', '68', '63', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('e4064d7b-7672-4a44-9c11-4f5eaba1f926', '雷明君', 'e0941d67-938b-4d07-86b6-f6ae0853c1f7', '长峰科技', '财务部', '无', '1', '2019-01-11 14:09:09', '2019-01-11 14:09:09', '48', '409', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('e4f4c8bc-ca8d-4fe1-a430-ceb1eb2c8726', '雷婧', 'a32bd3a8-5ecd-47cb-96e1-44d105311c7c', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:04', '2018-11-01 14:18:04', '41', '157', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('e51d4fcf-5cb6-4125-af68-68f7a3dfae63', '李鑫', 'ebc552ef-52cc-490c-a4d8-1500d2c928e0', '长峰科技', '西南研发中心', ' ', '2', '2018-11-01 15:05:33', '2018-11-01 15:05:33', '55', '300', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('e56f88fe-286b-467c-b9fd-55db53543e8b', '山丹', '919558df-25b2-441f-9af0-d3ebeda37641', '长峰股份', '研究院', ' ', '1', '2018-11-01 14:15:21', '2019-01-09 10:52:09', '63', '84', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('e5e1fe80-cfa8-4587-b87d-0ee2b35baa34', '穆童', '416b89ff-572d-4ffd-b533-e309ef4b1a8d', '长峰科技', '湖南分公司', ' ', '1', '2018-11-01 15:23:10', '2019-01-09 09:20:16', '66', '349', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('e69db357-9a08-4904-866c-f9895f752272', '刘婉滢', '031cc210-0613-4a46-a6fe-615c26e95de9', '长峰股份', '行政保障部', ' ', '1', '2018-11-01 14:15:23', '2019-01-09 11:35:23', '59', '105', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('e71aad7f-60cb-47e7-8a5e-ae23b7f42538', '王诗情', '48199f64-ace4-43ad-85a6-18c8d5e6289a', '长峰股份', '研究院', '无', '1', '2019-01-04 15:58:50', '2019-01-29 10:37:20', '63', '393', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('e7775e7f-0460-4974-b469-cf6aecf2f7c2', '宋扬', 'c0f7c83c-b9a7-4f8c-b20b-41ea8cba449b', '长峰科技', '人力资源部', ' ', '1', '2018-11-01 14:56:14', '2018-11-01 14:56:14', '50', '293', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('e78de84d-c6c8-43b2-9559-caead03ef2d2', '孙钦涛', '1886231a-defe-4145-aaf2-a5ab356dc220', '长峰股份', '证券投资部', ' ', '1', '2018-11-01 14:15:21', '2019-01-09 11:02:59', '71', '86', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('e7edc1d1-2696-4996-9bf1-f3ceb9d12cba', '张占华', 'eadd5f5f-47a2-408c-b429-e4825ef00ae8', '长峰股份', '行政保障部', ' ', '1', '2018-11-01 14:15:20', '2019-01-09 10:47:16', '59', '78', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('e8412f7f-fbcd-405e-90cb-d2d7820ffee3', '朱彤', 'fb9405db-2e89-488c-ab65-632dfd6f2e22', '长峰科技', '西南研发中心', ' ', '2', '2018-11-01 15:05:34', '2018-11-01 15:05:34', '55', '305', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('e84705c4-6850-4f2d-ab9a-4eeaa44e93e0', '杨卫尧', '056a0822-9f36-4941-bcd5-8abe28a27546', '长峰科技', '浙江子公司', '无', '1', '2019-01-23 15:30:13', '2019-01-23 15:30:13', '84', '461', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('e8517464-16d4-4ef1-a7e5-4359bbed74b2', '李晓峰', '62b8b1c4-fa05-4ef2-92a9-f5be58f45e0e', '长峰科技', '经营计划部', ' ', '1', '2018-11-01 14:43:13', '2018-11-01 14:43:13', '49', '252', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('e8f63d15-bf85-4ca8-9b8f-f450c873d05d', '李伟祎', 'b0b69cf0-b6df-47a5-923a-1ad570165081', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:09', '2018-11-01 15:23:09', '45', '337', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('e965b30b-c04f-424a-8e34-d955a109c82b', '刘鸽', '07fcf74f-49ed-435c-9c9a-872924b5147b', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:07', '2018-11-01 15:23:07', '45', '326', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('e992d845-3d21-4c42-ad2d-8ef28d6c7fc0', '张陈欢', '2067b9cc-15d1-4610-a595-101dbe26b401', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:06', '2018-11-01 14:18:06', '41', '175', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('ea51a774-e7ec-400e-b4a8-4970b7ad5c29', '娄岩峰', '77c58ae5-9467-427b-a9b9-0077d0d3bfba', '长峰股份', '股份员工', ' ', '1', '2018-11-01 14:15:21', '2018-11-01 14:15:21', '52', '87', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('ea84e1c5-d11d-4fc6-95ec-84c9a330d3ea', '王须', 'b9dd9a80-972a-4095-a8e1-58c423835abc', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:10', '2018-11-01 14:18:10', '41', '228', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('eb7d8e14-6d24-4a53-9e11-b7f77842309d', '杨启', '90b98c63-8794-47bd-b540-c10256ab9ae2', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:34', '2018-11-01 10:46:34', '35', '30', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('eb8f69fb-5829-48d4-91b6-affb9f585a3d', '李跃', '635d27ce-5b8b-427c-90a3-8082a3c49982', '外来人员', '科工集团领导', '无', '1', '2019-02-26 09:58:20', '2019-02-26 09:58:20', '91', '466', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('ec234242-5ddb-4b4a-81d8-9e50c03fa330', '靳华山', '1ff48337-545f-48ed-b6d5-e2ae80b7b99e', '长峰科技', '北京分公司', ' ', '1', '2018-11-01 14:18:04', '2019-05-16 11:06:59', '92', '155', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('ecbbb528-3327-4882-be4d-7899e09f9202', '赵倩', '21f2e824-b987-49e6-855a-4e4cdbecc453', '长峰科技', '总工程师办公室', ' ', '2', '2018-11-01 10:41:24', '2019-04-15 16:38:52', '54', '4', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('ecd1f290-f25a-4e96-a720-a39898182ae4', '肖金萍', '9d95659a-4c26-433b-b2a7-865335a82b6d', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:11', '2018-11-01 14:18:11', '41', '234', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('ee89c5a9-0a0f-47b9-b586-daa44776aab7', '闫红丽', 'faff4e26-bb5d-4b73-9544-c8dd420a7d3d', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:05', '2019-04-15 16:15:06', '42', '260', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('ef2474bb-bc00-4794-9145-5354738eaf89', '刘娇龙', '39de2410-7acc-4769-a4c4-72297416493a', '长峰股份', '证券投资部', ' ', '1', '2018-11-01 14:15:23', '2019-01-09 11:34:19', '71', '104', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('ef43e898-08a2-41d1-bf56-d50160bba7d6', '刘健', '5cb7db49-cd2d-4afd-aeaf-34315f0dd647', '长峰科技', '质量技术部', ' ', '1', '2018-11-01 15:31:19', '2018-11-01 15:31:19', '47', '367', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('f00ae202-5190-44b8-b786-28969f1e118d', '郄梦岩', 'ccd10ab1-108f-411e-beb8-4bdb3e0eea8f', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:36', '2019-04-08 15:38:20', '35', '43', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('f015caa1-8f69-454d-9cd3-af38f658a25e', '吴琼', 'bedcb6a2-4e44-4616-a840-aa07b55f24b4', '长峰股份', '证券投资部', ' ', '1', '2018-11-01 14:15:21', '2019-01-09 11:14:28', '71', '90', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('f03f85e8-68a8-470a-9e30-19d803475bb6', '周鹏', 'ce025503-51a8-4352-af64-dfbd3a8f54c6', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:33', '2018-11-01 10:46:33', '35', '20', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('f074ed67-1ccf-4c8e-9968-94e2c54e1861', '解通', '18502d8b-9a69-4ee4-9aeb-f154d7215122', '长峰科技', '战略合作发展部', ' ', '1', '2018-11-01 15:27:28', '2018-11-01 15:27:28', '56', '355', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('f0d6f47d-aa2b-4532-8ba2-c58b9dc4ed89', '赵维君', '8a181522-d73c-4902-94f3-5b40bfc71b97', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:06', '2018-11-01 15:23:06', '45', '317', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('f0ec8e42-17a5-40e0-aacb-d1fc9b8e08b2', '戴斌', '13c3603b-1f33-45e8-a6d0-2ef6489fc32e', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:09', '2018-11-01 14:18:09', '41', '208', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('f1adf968-9d95-4908-b030-9abbfd3bfdad', '侯晓娟', '1ad40312-2738-4bcc-bbcb-04d4cc7fdc4e', '长峰科技', '西南研发中心', ' ', '2', '2018-11-01 15:05:33', '2018-11-01 15:05:33', '55', '301', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('f1ccca0f-456c-4ac2-bcaf-647572321c48', '郝文娟', 'f1c79f05-1223-4ca6-bcaf-a08a64289b24', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:36', '2018-11-01 10:46:36', '35', '45', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('f2a07ccf-2bd5-43c6-a9ad-02761792da0b', '胡雪梅', '02caf176-7594-4aee-a9c8-ae91f4415fbd', '外来人员', '科工集团领导', '无', '1', '2019-04-15 17:58:42', '2019-04-16 11:07:00', '91', '510', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('f2f297d8-4eae-4e66-bb3f-c6b420d1baf6', '蔡潇霄', 'd8061f32-0161-4f1e-9c71-21e43e9e8478', '长峰科技', '营销部', ' ', '1', '2018-11-01 15:23:10', '2018-11-01 15:23:10', '45', '350', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('f39601cd-dc86-4cf5-a3e1-1b53359eb445', '郑夏星', '9fbe55c7-bd8e-4af8-9d88-53ad89bd4862', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:05', '2018-11-01 14:18:05', '41', '168', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('f3b226bf-bcfc-46fa-8629-3e0f3ac20215', '赵延', '102242bc-793b-4c1a-b094-e4e707b3dae9', '长峰科技', '战略合作发展部', '无', '1', '2019-01-23 09:07:02', '2019-01-23 09:07:02', '56', '453', '1', '1');
INSERT INTO `sys_userinfo` VALUES ('f42ff50e-ffe5-465d-8151-b2540b8b1a6a', '刘惟锦', 'd780aa96-df42-40a8-9122-149effcaaef8', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:33', '2018-11-01 10:46:33', '35', '21', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('f45732e6-0fa6-4713-b5a1-7f9cce0ea716', '李义夫', 'f9804340-d63c-412b-8cbc-5d55cb7af607', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:08', '2018-11-01 14:53:08', '42', '285', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('f480179f-eafa-4d33-8556-ce9a2d62438d', '张晓林', 'e1b535d5-f405-4050-8072-e29e8f2c67f2', '长峰科技', '产品部', ' ', '2', '2018-11-01 15:05:34', '2019-01-08 15:42:13', '35', '304', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('f4f117dd-2767-49b4-844c-2901aaa5c6ab', '王亚静', '86f866f3-d275-4298-8214-f17c3f9693c9', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:35', '2018-11-01 10:46:35', '35', '34', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('f57508de-ab80-49ca-aa6c-260658ccac56', '王华', '763e4897-5c87-4a9b-b133-72f4a2608fc8', '长峰科技', '战略合作发展部', '无', '1', '2019-01-11 16:53:31', '2019-01-11 16:53:31', '56', '428', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('f57bb4f5-6a0d-4dac-9f68-c19f2e0ee029', '张丹普', 'd83dbfe3-635f-4cbb-ab8d-ab1791bfa330', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:32', '2018-11-01 10:46:32', '35', '15', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('f6369879-17a7-4e47-b7dd-6bd278721dd6', '范宇', '40923e79-1891-4ae1-b083-f723dd2afeb6', '长峰股份', '研究院', ' ', '1', '2018-11-01 10:46:35', '2019-01-08 13:56:53', '63', '39', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('f677b33a-cd6c-425d-b67e-2ad84c0a6442', '宫德利', '00735329-a19d-4f6e-be26-9efc1b03ca2a', '长峰科技', '军工事业部', ' ', '2', '2018-11-01 14:53:07', '2018-11-01 14:53:07', '42', '274', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('f81a3942-5891-4126-bfa6-bacbf0a48f17', '程建中', 'd6a9c0f2-2fbb-487f-a034-07cafba9b03b', '外来人员', '科工集团领导', '无', '1', '2019-04-16 11:10:27', '2019-04-16 11:13:00', '91', '511', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('f8414b06-3bcc-4b39-84db-5dd9d1994b4a', '杜龙洋', 'fb0ecc84-73fd-46c4-92a5-f3f3f000ffd1', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:10', '2018-11-01 14:18:10', '41', '217', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('f98da685-d225-4d02-b312-b6a49bfd4a0f', '郑素兰', '6c74e824-7915-461c-bd3d-af749a325555', '长峰科技', '营销部', '无', '1', '2019-01-11 09:52:32', '2019-01-11 11:11:04', '45', '398', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('f9d1f2cd-5dcc-4906-ba0c-a16d5f1c73df', '刘婧', '21d982c2-07bf-4eb5-8d9c-b979630f7c48', '长峰科技', '财务部', ' ', '1', '2018-11-01 14:01:37', '2018-11-01 14:01:37', '48', '47', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('fcb4c8a7-f4e3-43da-95e6-d6acaeff93e6', '胡建国', '7580b02a-337e-48d7-a6b6-9d47967b79e7', '长峰科技', '深圳分公司', '无', '1', '2019-01-14 10:09:23', '2019-01-14 10:09:23', '75', '438', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('fd079f3a-c691-4325-82a4-80a021ea9791', '侯军华', '29f9ba43-176b-4361-afcc-b8efff79a60a', '外来人员', '科工二院领导', '无', '1', '2019-02-26 11:33:19', '2019-02-26 11:33:19', '36', '478', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('fd473a37-fc10-4749-9877-1e772b62c1e3', '张赞', '094ac235-ae20-41e6-8e38-67f861f439a0', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:06', '2018-11-01 14:18:06', '41', '176', '1', '2');
INSERT INTO `sys_userinfo` VALUES ('fd9d9dee-4172-4e3b-85c9-39f03aee45cb', '崔瑜', '8f2015c7-be5d-4bc2-bd4d-c8bb3ff47e21', '长峰科技', '财务部', ' ', '1', '2018-11-01 14:01:38', '2018-11-01 14:01:38', '48', '50', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('fda98ca4-b0fa-4a25-aaec-9bcae06281d3', '鲁明', 'e8494699-5cbb-429f-ba93-9fc76417d951', '长峰科技', '科技领导', '无', '1', '2019-01-14 09:49:22', '2019-01-14 09:49:22', '44', '431', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('fdd7248f-a581-4d32-b722-007aee36e0ea', '刘培苗', 'f75eb1bb-4249-463e-9b79-2c44f129fe08', '长峰科技', '财务部', '无', '1', '2019-01-11 09:43:09', '2019-01-11 09:43:09', '48', '396', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('fe941bc7-fabf-4156-8b8f-d2a05df28399', '张万斌', '8efa637c-83a3-4fa2-9bbe-c2abc083a344', '长峰股份', '总裁办公室', '', '1', '2019-01-03 16:12:36', '2019-01-03 16:12:36', '64', '391', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('feb70d2f-a4f3-4c1c-8fc5-a65140c71dc4', '耿雪冰', '3aa03025-e2e3-4dcb-a1bb-30c8045f4b51', '长峰科技', '产品部', ' ', '2', '2018-11-01 10:46:35', '2018-11-01 10:46:35', '35', '38', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('fed0731a-01cc-4409-aefd-35356b422d1c', '戴志强', 'ba47b51b-4e10-452d-adc4-bd641ca4604f', '长峰科技', '集成项目部', ' ', '2', '2018-11-01 14:18:09', '2018-11-01 14:18:09', '41', '207', '1', '0');
INSERT INTO `sys_userinfo` VALUES ('ffef7a7e-9917-42a6-a455-3020e560cd03', '张岩', 'f5ae1cbe-f13d-4ab4-9aca-c28205011148', '长峰科技', '北京分公司', ' ', '1', '2018-11-01 15:23:07', '2019-05-16 11:39:18', '92', '321', '1', '0');

-- ----------------------------
-- Table structure for `sys_userinfo_picture`
-- ----------------------------
DROP TABLE IF EXISTS `sys_userinfo_picture`;
CREATE TABLE `sys_userinfo_picture` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `name2` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `voice` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `uuid` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2902 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of sys_userinfo_picture
-- ----------------------------
INSERT INTO `sys_userinfo_picture` VALUES ('2373', 'CertificatePhotos/1.jpg', 'CertificatePhotosFace/1.jpg', 'VoicePlayback/1.mp3', 'de63773f-c093-462f-94fb-abae3bc8cf79');
INSERT INTO `sys_userinfo_picture` VALUES ('2374', 'CertificatePhotos/2.jpg', 'CertificatePhotosFace/2.jpg', 'VoicePlayback/2.mp3', '40b40bc6-f26b-428e-8b0c-deb64a26c06d');
INSERT INTO `sys_userinfo_picture` VALUES ('2375', 'CertificatePhotos/3.jpg', 'CertificatePhotosFace/3.jpg', 'VoicePlayback/3.mp3', '219a1966-d1ee-479e-a546-47a1e9a2a2f8');
INSERT INTO `sys_userinfo_picture` VALUES ('2376', 'CertificatePhotos/4.jpg', 'CertificatePhotosFace/4.jpg', 'VoicePlayback/4.mp3', '21f2e824-b987-49e6-855a-4e4cdbecc453');
INSERT INTO `sys_userinfo_picture` VALUES ('2377', 'CertificatePhotos/5.jpg', 'CertificatePhotosFace/5.jpg', 'VoicePlayback/5.mp3', '86f35df0-c19f-42a8-898a-497f158ace47');
INSERT INTO `sys_userinfo_picture` VALUES ('2378', 'CertificatePhotos/6.jpg', 'CertificatePhotosFace/6.jpg', 'VoicePlayback/6.mp3', 'fbeb52dd-6120-46a7-ba3a-a928a79c9c85');
INSERT INTO `sys_userinfo_picture` VALUES ('2379', 'CertificatePhotos/7.jpg', 'CertificatePhotosFace/7.jpg', 'VoicePlayback/7.mp3', 'a00c694f-17f5-4dd4-892e-72d0683378d7');
INSERT INTO `sys_userinfo_picture` VALUES ('2380', 'CertificatePhotos/8.jpg', 'CertificatePhotosFace/8.jpg', 'VoicePlayback/8.mp3', 'd75cba75-e3b3-4181-8d6d-2a3e9736070d');
INSERT INTO `sys_userinfo_picture` VALUES ('2381', 'CertificatePhotos/9.jpg', 'CertificatePhotosFace/9.jpg', 'VoicePlayback/9.mp3', 'bb0479d2-d320-4d9f-8de2-cf1f6cc0ae38');
INSERT INTO `sys_userinfo_picture` VALUES ('2382', 'CertificatePhotos/10.jpg', 'CertificatePhotosFace/10.jpg', 'VoicePlayback/10.mp3', 'e341b442-e50e-4152-937b-bdb956ab724b');
INSERT INTO `sys_userinfo_picture` VALUES ('2383', 'CertificatePhotos/11.jpg', 'CertificatePhotosFace/11.jpg', 'VoicePlayback/11.mp3', 'ab233ff9-6032-456b-ae29-f53891873749');
INSERT INTO `sys_userinfo_picture` VALUES ('2384', 'CertificatePhotos/12.jpg', 'CertificatePhotosFace/12.jpg', 'VoicePlayback/12.mp3', 'e6f6fd9d-6675-457a-8ff5-50de968c27d5');
INSERT INTO `sys_userinfo_picture` VALUES ('2385', 'CertificatePhotos/13.jpg', 'CertificatePhotosFace/13.jpg', 'VoicePlayback/13.mp3', '4899f2f4-b19c-46da-8735-911a8fbfa18d');
INSERT INTO `sys_userinfo_picture` VALUES ('2386', 'CertificatePhotos/14.jpg', 'CertificatePhotosFace/14.jpg', 'VoicePlayback/14.mp3', '65453795-0417-4d44-89ee-cbf902f86584');
INSERT INTO `sys_userinfo_picture` VALUES ('2387', 'CertificatePhotos/15.jpg', 'CertificatePhotosFace/15.jpg', 'VoicePlayback/15.mp3', 'd83dbfe3-635f-4cbb-ab8d-ab1791bfa330');
INSERT INTO `sys_userinfo_picture` VALUES ('2388', 'CertificatePhotos/16.jpg', 'CertificatePhotosFace/16.jpg', 'VoicePlayback/16.mp3', 'ca02eb30-74fd-4305-82e1-163eea870018');
INSERT INTO `sys_userinfo_picture` VALUES ('2389', 'CertificatePhotos/17.jpg', 'CertificatePhotosFace/17.jpg', 'VoicePlayback/17.mp3', '794cd951-ad79-4f50-a2e8-3efb3d69d130');
INSERT INTO `sys_userinfo_picture` VALUES ('2390', 'CertificatePhotos/18.jpg', 'CertificatePhotosFace/18.jpg', 'VoicePlayback/18.mp3', 'fff2c5a8-a093-41d9-a69d-ec70e8103d11');
INSERT INTO `sys_userinfo_picture` VALUES ('2391', 'CertificatePhotos/19.jpg', 'CertificatePhotosFace/19.jpg', 'VoicePlayback/19.mp3', '498f7243-cdf9-48b7-b9de-078602ac697f');
INSERT INTO `sys_userinfo_picture` VALUES ('2392', 'CertificatePhotos/20.jpg', 'CertificatePhotosFace/20.jpg', 'VoicePlayback/20.mp3', 'ce025503-51a8-4352-af64-dfbd3a8f54c6');
INSERT INTO `sys_userinfo_picture` VALUES ('2393', 'CertificatePhotos/21.jpg', 'CertificatePhotosFace/21.jpg', 'VoicePlayback/21.mp3', 'd780aa96-df42-40a8-9122-149effcaaef8');
INSERT INTO `sys_userinfo_picture` VALUES ('2394', 'CertificatePhotos/22.jpg', 'CertificatePhotosFace/22.jpg', 'VoicePlayback/22.mp3', '5df5cae4-eaa2-4279-b996-a95d3f25a96a');
INSERT INTO `sys_userinfo_picture` VALUES ('2395', 'CertificatePhotos/23.jpg', 'CertificatePhotosFace/23.jpg', 'VoicePlayback/23.mp3', '4796adb9-c30b-4dc2-b813-70ca5125891a');
INSERT INTO `sys_userinfo_picture` VALUES ('2396', 'CertificatePhotos/24.jpg', 'CertificatePhotosFace/24.jpg', 'VoicePlayback/24.mp3', '16032c1e-388e-45d2-b8e7-f7edeac8ef64');
INSERT INTO `sys_userinfo_picture` VALUES ('2397', 'CertificatePhotos/25.jpg', 'CertificatePhotosFace/25.jpg', 'VoicePlayback/25.mp3', 'ed319a34-4805-40f9-9ff0-800568e49741');
INSERT INTO `sys_userinfo_picture` VALUES ('2398', 'CertificatePhotos/26.jpg', 'CertificatePhotosFace/26.jpg', 'VoicePlayback/26.mp3', 'e8f9d3f7-9578-4644-8990-89714c4f7cfb');
INSERT INTO `sys_userinfo_picture` VALUES ('2399', 'CertificatePhotos/27.jpg', 'CertificatePhotosFace/27.jpg', 'VoicePlayback/27.mp3', '06270af0-4aa5-4c4f-a9b2-10bd279df8fd');
INSERT INTO `sys_userinfo_picture` VALUES ('2400', 'CertificatePhotos/28.jpg', 'CertificatePhotosFace/28.jpg', 'VoicePlayback/28.mp3', 'ab238678-76bb-4f00-abfc-2966f27063ea');
INSERT INTO `sys_userinfo_picture` VALUES ('2401', 'CertificatePhotos/29.jpg', 'CertificatePhotosFace/29.jpg', 'VoicePlayback/29.mp3', '8e2fccc2-c04e-4ddc-87e3-0a09ff1e00c7');
INSERT INTO `sys_userinfo_picture` VALUES ('2402', 'CertificatePhotos/30.jpg', 'CertificatePhotosFace/30.jpg', 'VoicePlayback/30.mp3', '90b98c63-8794-47bd-b540-c10256ab9ae2');
INSERT INTO `sys_userinfo_picture` VALUES ('2403', 'CertificatePhotos/31.jpg', 'CertificatePhotosFace/31.jpg', 'VoicePlayback/31.mp3', '08831ec1-219b-49ff-a556-8acf37991b3c');
INSERT INTO `sys_userinfo_picture` VALUES ('2404', 'CertificatePhotos/32.jpg', 'CertificatePhotosFace/32.jpg', 'VoicePlayback/32.mp3', 'e00d8884-97a1-4119-860a-717c02fb4ec6');
INSERT INTO `sys_userinfo_picture` VALUES ('2405', 'CertificatePhotos/33.jpg', 'CertificatePhotosFace/33.jpg', 'VoicePlayback/33.mp3', '6a92df92-587e-4f72-a68b-99266133f8fb');
INSERT INTO `sys_userinfo_picture` VALUES ('2406', 'CertificatePhotos/34.jpg', 'CertificatePhotosFace/34.jpg', 'VoicePlayback/34.mp3', '86f866f3-d275-4298-8214-f17c3f9693c9');
INSERT INTO `sys_userinfo_picture` VALUES ('2407', 'CertificatePhotos/35.jpg', 'CertificatePhotosFace/35.jpg', 'VoicePlayback/35.mp3', '350e2948-75ad-4d7a-beca-82cd3e6fc0ab');
INSERT INTO `sys_userinfo_picture` VALUES ('2408', 'CertificatePhotos/36.jpg', 'CertificatePhotosFace/36.jpg', 'VoicePlayback/36.mp3', '3f1ddda6-03f4-441f-a3f1-7ac56a497a92');
INSERT INTO `sys_userinfo_picture` VALUES ('2409', 'CertificatePhotos/37.jpg', 'CertificatePhotosFace/37.jpg', 'VoicePlayback/37.mp3', '772f8e5c-fe60-495d-a02b-64b4e28887ea');
INSERT INTO `sys_userinfo_picture` VALUES ('2410', 'CertificatePhotos/38.jpg', 'CertificatePhotosFace/38.jpg', 'VoicePlayback/38.mp3', '3aa03025-e2e3-4dcb-a1bb-30c8045f4b51');
INSERT INTO `sys_userinfo_picture` VALUES ('2411', 'CertificatePhotos/39.jpg', 'CertificatePhotosFace/39.jpg', 'VoicePlayback/39.mp3', '40923e79-1891-4ae1-b083-f723dd2afeb6');
INSERT INTO `sys_userinfo_picture` VALUES ('2412', 'CertificatePhotos/40.jpg', 'CertificatePhotosFace/40.jpg', 'VoicePlayback/40.mp3', 'ee365a34-4f8b-4407-b8ea-5db6fdee865f');
INSERT INTO `sys_userinfo_picture` VALUES ('2413', 'CertificatePhotos/41.jpg', 'CertificatePhotosFace/41.jpg', 'VoicePlayback/41.mp3', '677f0e4c-c655-47cb-a8c5-9d58f6a6eaac');
INSERT INTO `sys_userinfo_picture` VALUES ('2414', 'CertificatePhotos/42.jpg', 'CertificatePhotosFace/42.jpg', 'VoicePlayback/42.mp3', 'f39855e2-b4a2-4ec8-bb74-5a722cf800d6');
INSERT INTO `sys_userinfo_picture` VALUES ('2415', 'CertificatePhotos/43.jpg', 'CertificatePhotosFace/43.jpg', 'VoicePlayback/43.mp3', 'ccd10ab1-108f-411e-beb8-4bdb3e0eea8f');
INSERT INTO `sys_userinfo_picture` VALUES ('2416', 'CertificatePhotos/44.jpg', 'CertificatePhotosFace/44.jpg', 'VoicePlayback/44.mp3', '8159e44f-b958-443d-87d0-570afe5ca320');
INSERT INTO `sys_userinfo_picture` VALUES ('2417', 'CertificatePhotos/45.jpg', 'CertificatePhotosFace/45.jpg', 'VoicePlayback/45.mp3', 'f1c79f05-1223-4ca6-bcaf-a08a64289b24');
INSERT INTO `sys_userinfo_picture` VALUES ('2418', 'CertificatePhotos/46.jpg', 'CertificatePhotosFace/46.jpg', 'VoicePlayback/46.mp3', '18320a7b-5206-4ceb-b136-0a195ca2e3e9');
INSERT INTO `sys_userinfo_picture` VALUES ('2419', 'CertificatePhotos/47.jpg', 'CertificatePhotosFace/47.jpg', 'VoicePlayback/47.mp3', '21d982c2-07bf-4eb5-8d9c-b979630f7c48');
INSERT INTO `sys_userinfo_picture` VALUES ('2420', 'CertificatePhotos/48.jpg', 'CertificatePhotosFace/48.jpg', 'VoicePlayback/48.mp3', '7bc83d79-0620-43a7-82b1-449563b482d7');
INSERT INTO `sys_userinfo_picture` VALUES ('2421', 'CertificatePhotos/49.jpg', 'CertificatePhotosFace/49.jpg', 'VoicePlayback/49.mp3', 'edf1c127-7ee5-40a5-97cd-6078b35cbee1');
INSERT INTO `sys_userinfo_picture` VALUES ('2422', 'CertificatePhotos/50.jpg', 'CertificatePhotosFace/50.jpg', 'VoicePlayback/50.mp3', '8f2015c7-be5d-4bc2-bd4d-c8bb3ff47e21');
INSERT INTO `sys_userinfo_picture` VALUES ('2423', 'CertificatePhotos/51.jpg', 'CertificatePhotosFace/51.jpg', 'VoicePlayback/51.mp3', '158918ea-4774-477f-a4a4-2dea25c51fff');
INSERT INTO `sys_userinfo_picture` VALUES ('2424', 'CertificatePhotos/52.jpg', 'CertificatePhotosFace/52.jpg', 'VoicePlayback/52.mp3', '4a73942a-7336-434c-a23f-f09fa7c6419a');
INSERT INTO `sys_userinfo_picture` VALUES ('2425', 'CertificatePhotos/53.jpg', 'CertificatePhotosFace/53.jpg', 'VoicePlayback/53.mp3', 'fda81102-bb4d-459e-ae68-33eddd06f06d');
INSERT INTO `sys_userinfo_picture` VALUES ('2426', 'CertificatePhotos/54.jpg', 'CertificatePhotosFace/54.jpg', 'VoicePlayback/54.mp3', '8b0c6640-7da9-4bc9-bc32-3d41189420f4');
INSERT INTO `sys_userinfo_picture` VALUES ('2427', 'CertificatePhotos/55.jpg', 'CertificatePhotosFace/55.jpg', 'VoicePlayback/55.mp3', 'f6d491b6-845a-44b8-b194-96c6dadd0e97');
INSERT INTO `sys_userinfo_picture` VALUES ('2428', 'CertificatePhotos/56.jpg', 'CertificatePhotosFace/56.jpg', 'VoicePlayback/56.mp3', '56ca616d-be56-4bf0-8301-4f6b92c78d2a');
INSERT INTO `sys_userinfo_picture` VALUES ('2429', 'CertificatePhotos/57.jpg', 'CertificatePhotosFace/57.jpg', 'VoicePlayback/57.mp3', '41e382a6-f160-439f-ac4e-1355f0033e35');
INSERT INTO `sys_userinfo_picture` VALUES ('2430', 'CertificatePhotos/58.jpg', 'CertificatePhotosFace/58.jpg', 'VoicePlayback/58.mp3', '666a3ab8-1f45-49eb-ab52-18b7b3f167b3');
INSERT INTO `sys_userinfo_picture` VALUES ('2431', 'CertificatePhotos/59.jpg', 'CertificatePhotosFace/59.jpg', 'VoicePlayback/59.mp3', 'ef355d96-88bf-4e5b-8e1d-ed5b421b261f');
INSERT INTO `sys_userinfo_picture` VALUES ('2432', 'CertificatePhotos/60.jpg', 'CertificatePhotosFace/60.jpg', 'VoicePlayback/60.mp3', '37023f2e-67f3-4e4d-bd15-77389e283a89');
INSERT INTO `sys_userinfo_picture` VALUES ('2433', 'CertificatePhotos/61.jpg', 'CertificatePhotosFace/61.jpg', 'VoicePlayback/61.mp3', 'f07fa9ee-dbe0-49d4-a97e-4eeed37a29d6');
INSERT INTO `sys_userinfo_picture` VALUES ('2434', 'CertificatePhotos/62.jpg', 'CertificatePhotosFace/62.jpg', 'VoicePlayback/62.mp3', '73265be0-5de0-4bd8-b151-680a79765933');
INSERT INTO `sys_userinfo_picture` VALUES ('2435', 'CertificatePhotos/63.jpg', 'CertificatePhotosFace/63.jpg', 'VoicePlayback/63.mp3', 'd7af7d1b-198c-4c47-99e0-9b4afc4446aa');
INSERT INTO `sys_userinfo_picture` VALUES ('2436', 'CertificatePhotos/64.jpg', 'CertificatePhotosFace/64.jpg', 'VoicePlayback/64.mp3', 'ad76c5aa-05f0-457a-86ab-f529e2e18fb2');
INSERT INTO `sys_userinfo_picture` VALUES ('2437', 'CertificatePhotos/65.jpg', 'CertificatePhotosFace/65.jpg', 'VoicePlayback/65.mp3', 'f380d4d4-ee80-405c-97df-91b9cc731fa8');
INSERT INTO `sys_userinfo_picture` VALUES ('2438', 'CertificatePhotos/66.jpg', 'CertificatePhotosFace/66.jpg', 'VoicePlayback/66.mp3', 'f9321a5e-9202-4b74-ac7f-2b72f59e70f2');
INSERT INTO `sys_userinfo_picture` VALUES ('2439', 'CertificatePhotos/67.jpg', 'CertificatePhotosFace/67.jpg', 'VoicePlayback/67.mp3', '61d0df6a-3f3e-424b-a012-f114d72ccece');
INSERT INTO `sys_userinfo_picture` VALUES ('2440', 'CertificatePhotos/68.jpg', 'CertificatePhotosFace/68.jpg', 'VoicePlayback/68.mp3', 'fef61dcc-46d9-41c4-83f6-5bafd0958ea6');
INSERT INTO `sys_userinfo_picture` VALUES ('2441', 'CertificatePhotos/69.jpg', 'CertificatePhotosFace/69.jpg', 'VoicePlayback/69.mp3', 'e523a97e-7f0d-4f25-97a3-9bbfaef40420');
INSERT INTO `sys_userinfo_picture` VALUES ('2442', 'CertificatePhotos/70.jpg', 'CertificatePhotosFace/70.jpg', 'VoicePlayback/70.mp3', '955377bb-e2f3-4e7b-ab4d-54ce00223d0b');
INSERT INTO `sys_userinfo_picture` VALUES ('2443', 'CertificatePhotos/71.jpg', 'CertificatePhotosFace/71.jpg', 'VoicePlayback/71.mp3', 'e43bd52b-96c3-40f3-b69c-6e6b74b1f799');
INSERT INTO `sys_userinfo_picture` VALUES ('2444', 'CertificatePhotos/72.jpg', 'CertificatePhotosFace/72.jpg', 'VoicePlayback/72.mp3', '339c5c81-dcc6-4101-a549-90c10939dbe5');
INSERT INTO `sys_userinfo_picture` VALUES ('2445', 'CertificatePhotos/73.jpg', 'CertificatePhotosFace/73.jpg', 'VoicePlayback/73.mp3', 'e285924a-3a6b-4649-acda-5240af2bcaff');
INSERT INTO `sys_userinfo_picture` VALUES ('2446', 'CertificatePhotos/74.jpg', 'CertificatePhotosFace/74.jpg', 'VoicePlayback/74.mp3', 'efa5903c-986f-4201-9124-f0cf4997f65f');
INSERT INTO `sys_userinfo_picture` VALUES ('2447', 'CertificatePhotos/75.jpg', 'CertificatePhotosFace/75.jpg', 'VoicePlayback/75.mp3', 'c7b13f93-7a16-4f28-ae0b-9c58679a36a6');
INSERT INTO `sys_userinfo_picture` VALUES ('2448', 'CertificatePhotos/76.jpg', 'CertificatePhotosFace/76.jpg', 'VoicePlayback/76.mp3', '49af86e4-c31e-48dd-8c66-4298d73a3bb0');
INSERT INTO `sys_userinfo_picture` VALUES ('2449', 'CertificatePhotos/77.jpg', 'CertificatePhotosFace/77.jpg', 'VoicePlayback/77.mp3', 'f4477210-32a3-451a-9bd3-c5562e69b4e2');
INSERT INTO `sys_userinfo_picture` VALUES ('2450', 'CertificatePhotos/78.jpg', 'CertificatePhotosFace/78.jpg', 'VoicePlayback/78.mp3', 'eadd5f5f-47a2-408c-b429-e4825ef00ae8');
INSERT INTO `sys_userinfo_picture` VALUES ('2451', 'CertificatePhotos/79.jpg', 'CertificatePhotosFace/79.jpg', 'VoicePlayback/79.mp3', 'bd8b9447-1455-44ab-b5f9-401e2701f88c');
INSERT INTO `sys_userinfo_picture` VALUES ('2452', 'CertificatePhotos/80.jpg', 'CertificatePhotosFace/80.jpg', 'VoicePlayback/80.mp3', 'd01a7812-79c4-4752-92db-c227636f8556');
INSERT INTO `sys_userinfo_picture` VALUES ('2453', 'CertificatePhotos/81.jpg', 'CertificatePhotosFace/81.jpg', 'VoicePlayback/81.mp3', '132efebc-d604-4f81-9237-817b3392b6cc');
INSERT INTO `sys_userinfo_picture` VALUES ('2454', 'CertificatePhotos/82.jpg', 'CertificatePhotosFace/82.jpg', 'VoicePlayback/82.mp3', '79a85d16-2dac-4350-a19c-73ca0474aced');
INSERT INTO `sys_userinfo_picture` VALUES ('2455', 'CertificatePhotos/83.jpg', 'CertificatePhotosFace/83.jpg', 'VoicePlayback/83.mp3', '5fc74ac8-cea7-425b-b577-285b291ad208');
INSERT INTO `sys_userinfo_picture` VALUES ('2456', 'CertificatePhotos/84.jpg', 'CertificatePhotosFace/84.jpg', 'VoicePlayback/84.mp3', '919558df-25b2-441f-9af0-d3ebeda37641');
INSERT INTO `sys_userinfo_picture` VALUES ('2457', 'CertificatePhotos/85.jpg', 'CertificatePhotosFace/85.jpg', 'VoicePlayback/85.mp3', '98944174-5a3c-4751-b267-b20c87d9c3ba');
INSERT INTO `sys_userinfo_picture` VALUES ('2458', 'CertificatePhotos/86.jpg', 'CertificatePhotosFace/86.jpg', 'VoicePlayback/86.mp3', '1886231a-defe-4145-aaf2-a5ab356dc220');
INSERT INTO `sys_userinfo_picture` VALUES ('2459', 'CertificatePhotos/87.jpg', 'CertificatePhotosFace/87.jpg', 'VoicePlayback/87.mp3', '77c58ae5-9467-427b-a9b9-0077d0d3bfba');
INSERT INTO `sys_userinfo_picture` VALUES ('2460', 'CertificatePhotos/88.jpg', 'CertificatePhotosFace/88.jpg', 'VoicePlayback/88.mp3', '0da4c739-1cd4-42c7-bd82-d5b6edbdbdec');
INSERT INTO `sys_userinfo_picture` VALUES ('2461', 'CertificatePhotos/89.jpg', 'CertificatePhotosFace/89.jpg', 'VoicePlayback/89.mp3', '675884fe-65ad-4d56-b75a-b1f32d850f2c');
INSERT INTO `sys_userinfo_picture` VALUES ('2462', 'CertificatePhotos/90.jpg', 'CertificatePhotosFace/90.jpg', 'VoicePlayback/90.mp3', 'bedcb6a2-4e44-4616-a840-aa07b55f24b4');
INSERT INTO `sys_userinfo_picture` VALUES ('2463', 'CertificatePhotos/91.jpg', 'CertificatePhotosFace/91.jpg', 'VoicePlayback/91.mp3', 'eef574ef-6782-4556-bbf3-f65da4167ea4');
INSERT INTO `sys_userinfo_picture` VALUES ('2464', 'CertificatePhotos/92.jpg', 'CertificatePhotosFace/92.jpg', 'VoicePlayback/92.mp3', '1c722a45-98de-437a-8d75-ec1c5841493f');
INSERT INTO `sys_userinfo_picture` VALUES ('2465', 'CertificatePhotos/93.jpg', 'CertificatePhotosFace/93.jpg', 'VoicePlayback/93.mp3', 'c2a0025e-3c1b-4111-9927-44cb9fe19b1d');
INSERT INTO `sys_userinfo_picture` VALUES ('2466', 'CertificatePhotos/94.jpg', 'CertificatePhotosFace/94.jpg', 'VoicePlayback/94.mp3', '409871ba-a61f-4fba-898d-a486527edf32');
INSERT INTO `sys_userinfo_picture` VALUES ('2467', 'CertificatePhotos/95.jpg', 'CertificatePhotosFace/95.jpg', 'VoicePlayback/95.mp3', '0cb11020-5e64-4ba5-923d-6906d99f76a2');
INSERT INTO `sys_userinfo_picture` VALUES ('2468', 'CertificatePhotos/96.jpg', 'CertificatePhotosFace/96.jpg', 'VoicePlayback/96.mp3', '21022939-30c6-495e-957c-501103eb5288');
INSERT INTO `sys_userinfo_picture` VALUES ('2469', 'CertificatePhotos/97.jpg', 'CertificatePhotosFace/97.jpg', 'VoicePlayback/97.mp3', '56b9b591-d3ab-436d-a387-0ccdb3c5f09b');
INSERT INTO `sys_userinfo_picture` VALUES ('2470', 'CertificatePhotos/98.jpg', 'CertificatePhotosFace/98.jpg', 'VoicePlayback/98.mp3', '380922f0-3038-4c83-9285-2455cd439756');
INSERT INTO `sys_userinfo_picture` VALUES ('2471', 'CertificatePhotos/99.jpg', 'CertificatePhotosFace/99.jpg', 'VoicePlayback/99.mp3', '4ec8be99-20fb-44e1-a67e-b91b0136494c');
INSERT INTO `sys_userinfo_picture` VALUES ('2472', 'CertificatePhotos/100.jpg', 'CertificatePhotosFace/100.jpg', 'VoicePlayback/100.mp3', '3994c668-7c1b-49fa-80b6-032213a3cd5c');
INSERT INTO `sys_userinfo_picture` VALUES ('2473', 'CertificatePhotos/101.jpg', 'CertificatePhotosFace/101.jpg', 'VoicePlayback/101.mp3', '172c4585-1d78-4ee7-8ffb-1c1a8f3c0443');
INSERT INTO `sys_userinfo_picture` VALUES ('2474', 'CertificatePhotos/102.jpg', 'CertificatePhotosFace/102.jpg', 'VoicePlayback/102.mp3', '8a25f13e-0ede-4130-8e24-23dce542e9d5');
INSERT INTO `sys_userinfo_picture` VALUES ('2475', 'CertificatePhotos/103.jpg', 'CertificatePhotosFace/103.jpg', 'VoicePlayback/103.mp3', '66993a43-e7d6-4e08-b3a7-31ed3d340d9a');
INSERT INTO `sys_userinfo_picture` VALUES ('2476', 'CertificatePhotos/104.jpg', 'CertificatePhotosFace/104.jpg', 'VoicePlayback/104.mp3', '39de2410-7acc-4769-a4c4-72297416493a');
INSERT INTO `sys_userinfo_picture` VALUES ('2477', 'CertificatePhotos/105.jpg', 'CertificatePhotosFace/105.jpg', 'VoicePlayback/105.mp3', '031cc210-0613-4a46-a6fe-615c26e95de9');
INSERT INTO `sys_userinfo_picture` VALUES ('2478', 'CertificatePhotos/106.jpg', 'CertificatePhotosFace/106.jpg', 'VoicePlayback/106.mp3', '35854204-ce89-4a5e-8720-f53252add979');
INSERT INTO `sys_userinfo_picture` VALUES ('2479', 'CertificatePhotos/107.jpg', 'CertificatePhotosFace/107.jpg', 'VoicePlayback/107.mp3', '648ff0ca-2a11-456b-afd8-b2962c6e650e');
INSERT INTO `sys_userinfo_picture` VALUES ('2480', 'CertificatePhotos/108.jpg', 'CertificatePhotosFace/108.jpg', 'VoicePlayback/108.mp3', 'c97d9948-0a5e-45cf-ba10-68ff18b575b0');
INSERT INTO `sys_userinfo_picture` VALUES ('2481', 'CertificatePhotos/109.jpg', 'CertificatePhotosFace/109.jpg', 'VoicePlayback/109.mp3', '6b0888f6-1173-479a-85c0-8cbeb990fcc4');
INSERT INTO `sys_userinfo_picture` VALUES ('2482', 'CertificatePhotos/110.jpg', 'CertificatePhotosFace/110.jpg', 'VoicePlayback/110.mp3', 'a7e39de0-1637-4820-b102-16c2ea3a1ef0');
INSERT INTO `sys_userinfo_picture` VALUES ('2483', 'CertificatePhotos/111.jpg', 'CertificatePhotosFace/111.jpg', 'VoicePlayback/111.mp3', '92da9e67-9578-4e23-b1f3-2ab4839cf405');
INSERT INTO `sys_userinfo_picture` VALUES ('2484', 'CertificatePhotos/112.jpg', 'CertificatePhotosFace/112.jpg', 'VoicePlayback/112.mp3', '4baaebb0-98f7-40cb-a448-7302755019c5');
INSERT INTO `sys_userinfo_picture` VALUES ('2485', 'CertificatePhotos/113.jpg', 'CertificatePhotosFace/113.jpg', 'VoicePlayback/113.mp3', 'b9d58e8f-15b6-4cb4-87aa-dd78398eadf9');
INSERT INTO `sys_userinfo_picture` VALUES ('2486', 'CertificatePhotos/114.jpg', 'CertificatePhotosFace/114.jpg', 'VoicePlayback/114.mp3', '14319904-cefc-42a1-941c-78cbd25ff0c0');
INSERT INTO `sys_userinfo_picture` VALUES ('2487', 'CertificatePhotos/115.jpg', 'CertificatePhotosFace/115.jpg', 'VoicePlayback/115.mp3', '7a8c3f5b-2680-4742-a161-026e9fb5ac6f');
INSERT INTO `sys_userinfo_picture` VALUES ('2488', 'CertificatePhotos/116.jpg', 'CertificatePhotosFace/116.jpg', 'VoicePlayback/116.mp3', '83129ad4-1a56-4e4f-b556-5e8f2a475e6d');
INSERT INTO `sys_userinfo_picture` VALUES ('2489', 'CertificatePhotos/117.jpg', 'CertificatePhotosFace/117.jpg', 'VoicePlayback/117.mp3', '5f9d851e-362f-41bd-bd7e-0e316d435823');
INSERT INTO `sys_userinfo_picture` VALUES ('2490', 'CertificatePhotos/118.jpg', 'CertificatePhotosFace/118.jpg', 'VoicePlayback/118.mp3', '622652b3-4515-461b-88e2-acc8098a921e');
INSERT INTO `sys_userinfo_picture` VALUES ('2491', 'CertificatePhotos/119.jpg', 'CertificatePhotosFace/119.jpg', 'VoicePlayback/119.mp3', 'ec37647a-6aab-45aa-bdd6-836ac41ab02d');
INSERT INTO `sys_userinfo_picture` VALUES ('2492', 'CertificatePhotos/120.jpg', 'CertificatePhotosFace/120.jpg', 'VoicePlayback/120.mp3', 'f337b406-39fe-48b3-bf64-e1e2e1688322');
INSERT INTO `sys_userinfo_picture` VALUES ('2493', 'CertificatePhotos/121.jpg', 'CertificatePhotosFace/121.jpg', 'VoicePlayback/121.mp3', '9048fd59-28a3-450c-9f52-7dffb0a20d66');
INSERT INTO `sys_userinfo_picture` VALUES ('2494', 'CertificatePhotos/122.jpg', 'CertificatePhotosFace/122.jpg', 'VoicePlayback/122.mp3', 'b0c917a7-405c-4590-8942-c893cbd8195d');
INSERT INTO `sys_userinfo_picture` VALUES ('2495', 'CertificatePhotos/123.jpg', 'CertificatePhotosFace/123.jpg', 'VoicePlayback/123.mp3', '22271053-b3de-4a4a-be99-76cb2fef70fc');
INSERT INTO `sys_userinfo_picture` VALUES ('2496', 'CertificatePhotos/124.jpg', 'CertificatePhotosFace/124.jpg', 'VoicePlayback/124.mp3', 'c34b2760-f9e3-44d9-807c-1f3a934eb6d6');
INSERT INTO `sys_userinfo_picture` VALUES ('2497', 'CertificatePhotos/125.jpg', 'CertificatePhotosFace/125.jpg', 'VoicePlayback/125.mp3', '287ae547-5baf-4b97-8204-c4dc56a1f491');
INSERT INTO `sys_userinfo_picture` VALUES ('2498', 'CertificatePhotos/126.jpg', 'CertificatePhotosFace/126.jpg', 'VoicePlayback/126.mp3', '7260c0b2-2916-452b-aca8-2c2ad9df37f9');
INSERT INTO `sys_userinfo_picture` VALUES ('2499', 'CertificatePhotos/127.jpg', 'CertificatePhotosFace/127.jpg', 'VoicePlayback/127.mp3', 'ed596ccd-febe-485a-a8fa-fa0ae99778f1');
INSERT INTO `sys_userinfo_picture` VALUES ('2500', 'CertificatePhotos/128.jpg', 'CertificatePhotosFace/128.jpg', 'VoicePlayback/128.mp3', '0bc6fbab-f7e8-4c1e-9fbd-17bc8c34e14d');
INSERT INTO `sys_userinfo_picture` VALUES ('2501', 'CertificatePhotos/129.jpg', 'CertificatePhotosFace/129.jpg', 'VoicePlayback/129.mp3', '73c6c3bd-1eb4-4769-bf97-4e0450946c5f');
INSERT INTO `sys_userinfo_picture` VALUES ('2502', 'CertificatePhotos/130.jpg', 'CertificatePhotosFace/130.jpg', 'VoicePlayback/130.mp3', '57fae87a-1f87-4516-ad4e-a2a531d902a6');
INSERT INTO `sys_userinfo_picture` VALUES ('2503', 'CertificatePhotos/131.jpg', 'CertificatePhotosFace/131.jpg', 'VoicePlayback/131.mp3', '57213349-3a5e-46d7-9bcd-839672b31479');
INSERT INTO `sys_userinfo_picture` VALUES ('2504', 'CertificatePhotos/132.jpg', 'CertificatePhotosFace/132.jpg', 'VoicePlayback/132.mp3', 'a37167b0-a506-4677-9a76-f2635a657dc9');
INSERT INTO `sys_userinfo_picture` VALUES ('2505', 'CertificatePhotos/133.jpg', 'CertificatePhotosFace/133.jpg', 'VoicePlayback/133.mp3', '8a765bae-47f6-4b4a-b3bb-9544a3c93490');
INSERT INTO `sys_userinfo_picture` VALUES ('2506', 'CertificatePhotos/134.jpg', 'CertificatePhotosFace/134.jpg', 'VoicePlayback/134.mp3', '19bf1102-f7cd-44e1-9187-f06079e5378b');
INSERT INTO `sys_userinfo_picture` VALUES ('2507', 'CertificatePhotos/135.jpg', 'CertificatePhotosFace/135.jpg', 'VoicePlayback/135.mp3', '1d180b6b-3188-49e4-a812-1ebf04f6ec71');
INSERT INTO `sys_userinfo_picture` VALUES ('2508', 'CertificatePhotos/136.jpg', 'CertificatePhotosFace/136.jpg', 'VoicePlayback/136.mp3', '6d0f98f2-7637-469b-aad9-6b7252573d5f');
INSERT INTO `sys_userinfo_picture` VALUES ('2509', 'CertificatePhotos/137.jpg', 'CertificatePhotosFace/137.jpg', 'VoicePlayback/137.mp3', '70c4d641-364e-46bd-b926-ebd7b3645788');
INSERT INTO `sys_userinfo_picture` VALUES ('2510', 'CertificatePhotos/138.jpg', 'CertificatePhotosFace/138.jpg', 'VoicePlayback/138.mp3', 'dfcc8c5f-9816-4f4c-852a-36cb98bb98ee');
INSERT INTO `sys_userinfo_picture` VALUES ('2511', 'CertificatePhotos/139.jpg', 'CertificatePhotosFace/139.jpg', 'VoicePlayback/139.mp3', '07940cf7-3380-424c-aeb2-fcc34b8ad726');
INSERT INTO `sys_userinfo_picture` VALUES ('2512', 'CertificatePhotos/140.jpg', 'CertificatePhotosFace/140.jpg', 'VoicePlayback/140.mp3', '612504fa-8372-43cc-9370-198581e874e2');
INSERT INTO `sys_userinfo_picture` VALUES ('2513', 'CertificatePhotos/141.jpg', 'CertificatePhotosFace/141.jpg', 'VoicePlayback/141.mp3', '2e4a8c1d-58a5-4805-9fa3-8a37cfb283f2');
INSERT INTO `sys_userinfo_picture` VALUES ('2514', 'CertificatePhotos/142.jpg', 'CertificatePhotosFace/142.jpg', 'VoicePlayback/142.mp3', 'fb2f7dc4-3b76-4716-8cc5-fd16e47d9666');
INSERT INTO `sys_userinfo_picture` VALUES ('2515', 'CertificatePhotos/143.jpg', 'CertificatePhotosFace/143.jpg', 'VoicePlayback/143.mp3', 'a8d34266-31b8-4907-b494-eeb0a5573c7d');
INSERT INTO `sys_userinfo_picture` VALUES ('2516', 'CertificatePhotos/144.jpg', 'CertificatePhotosFace/144.jpg', 'VoicePlayback/144.mp3', 'e18b8cd5-763d-4da1-a268-c2e24415de4b');
INSERT INTO `sys_userinfo_picture` VALUES ('2517', 'CertificatePhotos/145.jpg', 'CertificatePhotosFace/145.jpg', 'VoicePlayback/145.mp3', '12eaebb3-37f9-4e23-9d5d-bc3a6e9ca464');
INSERT INTO `sys_userinfo_picture` VALUES ('2518', 'CertificatePhotos/146.jpg', 'CertificatePhotosFace/146.jpg', 'VoicePlayback/146.mp3', 'c70ecb2f-cb61-431f-a116-11cc3bf3a12f');
INSERT INTO `sys_userinfo_picture` VALUES ('2519', 'CertificatePhotos/147.jpg', 'CertificatePhotosFace/147.jpg', 'VoicePlayback/147.mp3', '97aa26de-58ff-47cf-a95c-60d02ce37d94');
INSERT INTO `sys_userinfo_picture` VALUES ('2520', 'CertificatePhotos/148.jpg', 'CertificatePhotosFace/148.jpg', 'VoicePlayback/148.mp3', 'bcd66c20-f6d0-4c0f-9f13-2416b7e0d1e4');
INSERT INTO `sys_userinfo_picture` VALUES ('2521', 'CertificatePhotos/149.jpg', 'CertificatePhotosFace/149.jpg', 'VoicePlayback/149.mp3', 'be57a863-eca7-4617-bfc6-041f906252ae');
INSERT INTO `sys_userinfo_picture` VALUES ('2522', 'CertificatePhotos/150.jpg', 'CertificatePhotosFace/150.jpg', 'VoicePlayback/150.mp3', '5d69188b-db1f-4950-9a63-c0213325d97d');
INSERT INTO `sys_userinfo_picture` VALUES ('2523', 'CertificatePhotos/151.jpg', 'CertificatePhotosFace/151.jpg', 'VoicePlayback/151.mp3', '70d7361d-16d0-488f-a2f3-2c9814c1cdaf');
INSERT INTO `sys_userinfo_picture` VALUES ('2524', 'CertificatePhotos/152.jpg', 'CertificatePhotosFace/152.jpg', 'VoicePlayback/152.mp3', '9b78d905-20bd-4ede-b2ef-f4d66ce36e66');
INSERT INTO `sys_userinfo_picture` VALUES ('2525', 'CertificatePhotos/153.jpg', 'CertificatePhotosFace/153.jpg', 'VoicePlayback/153.mp3', 'a3aaf520-8891-46e7-a45e-6d4fb90d002f');
INSERT INTO `sys_userinfo_picture` VALUES ('2526', 'CertificatePhotos/154.jpg', 'CertificatePhotosFace/154.jpg', 'VoicePlayback/154.mp3', '48abd40f-0ab9-428b-9b94-2cd45709f78f');
INSERT INTO `sys_userinfo_picture` VALUES ('2527', 'CertificatePhotos/155.jpg', 'CertificatePhotosFace/155.jpg', 'VoicePlayback/155.mp3', '1ff48337-545f-48ed-b6d5-e2ae80b7b99e');
INSERT INTO `sys_userinfo_picture` VALUES ('2528', 'CertificatePhotos/156.jpg', 'CertificatePhotosFace/156.jpg', 'VoicePlayback/156.mp3', '61bd07d3-8b58-4d3f-bc5b-88431be80819');
INSERT INTO `sys_userinfo_picture` VALUES ('2529', 'CertificatePhotos/157.jpg', 'CertificatePhotosFace/157.jpg', 'VoicePlayback/157.mp3', 'a32bd3a8-5ecd-47cb-96e1-44d105311c7c');
INSERT INTO `sys_userinfo_picture` VALUES ('2530', 'CertificatePhotos/158.jpg', 'CertificatePhotosFace/158.jpg', 'VoicePlayback/158.mp3', '57a12f7c-8e0a-4791-9f4a-b90b2cc8d9e8');
INSERT INTO `sys_userinfo_picture` VALUES ('2531', 'CertificatePhotos/159.jpg', 'CertificatePhotosFace/159.jpg', 'VoicePlayback/159.mp3', 'd4453986-ebcf-4297-8858-dc326da95432');
INSERT INTO `sys_userinfo_picture` VALUES ('2532', 'CertificatePhotos/160.jpg', 'CertificatePhotosFace/160.jpg', 'VoicePlayback/160.mp3', '9ffa10ff-e6b7-442e-bd46-9954ffce8d35');
INSERT INTO `sys_userinfo_picture` VALUES ('2533', 'CertificatePhotos/161.jpg', 'CertificatePhotosFace/161.jpg', 'VoicePlayback/161.mp3', '089dfbb0-191f-4d1e-b9ea-44ea88af0c16');
INSERT INTO `sys_userinfo_picture` VALUES ('2534', 'CertificatePhotos/162.jpg', 'CertificatePhotosFace/162.jpg', 'VoicePlayback/162.mp3', '5f2db1b1-e2d6-4922-9133-f1bd24c3ce5f');
INSERT INTO `sys_userinfo_picture` VALUES ('2535', 'CertificatePhotos/163.jpg', 'CertificatePhotosFace/163.jpg', 'VoicePlayback/163.mp3', '9c280e46-788f-4e89-bfd5-5c2623548407');
INSERT INTO `sys_userinfo_picture` VALUES ('2536', 'CertificatePhotos/164.jpg', 'CertificatePhotosFace/164.jpg', 'VoicePlayback/164.mp3', 'eb1e867c-028b-4624-ba76-e3288a5cba46');
INSERT INTO `sys_userinfo_picture` VALUES ('2537', 'CertificatePhotos/165.jpg', 'CertificatePhotosFace/165.jpg', 'VoicePlayback/165.mp3', '82d5f881-7e42-4efa-a1f6-a92745219d77');
INSERT INTO `sys_userinfo_picture` VALUES ('2538', 'CertificatePhotos/166.jpg', 'CertificatePhotosFace/166.jpg', 'VoicePlayback/166.mp3', 'bb2102b2-d75c-4ec1-8f21-9a02e9babf61');
INSERT INTO `sys_userinfo_picture` VALUES ('2539', 'CertificatePhotos/167.jpg', 'CertificatePhotosFace/167.jpg', 'VoicePlayback/167.mp3', 'a25e95a5-e271-40d3-ace5-b1adbfb9dd8b');
INSERT INTO `sys_userinfo_picture` VALUES ('2540', 'CertificatePhotos/168.jpg', 'CertificatePhotosFace/168.jpg', 'VoicePlayback/168.mp3', '9fbe55c7-bd8e-4af8-9d88-53ad89bd4862');
INSERT INTO `sys_userinfo_picture` VALUES ('2541', 'CertificatePhotos/169.jpg', 'CertificatePhotosFace/169.jpg', 'VoicePlayback/169.mp3', 'd2be19a5-680f-4ddf-831c-d039e85e6b6c');
INSERT INTO `sys_userinfo_picture` VALUES ('2542', 'CertificatePhotos/170.jpg', 'CertificatePhotosFace/170.jpg', 'VoicePlayback/170.mp3', 'd0606bc1-ef91-420f-af67-9e13b8b0b061');
INSERT INTO `sys_userinfo_picture` VALUES ('2543', 'CertificatePhotos/171.jpg', 'CertificatePhotosFace/171.jpg', 'VoicePlayback/171.mp3', 'd6e3091a-c461-4423-a3cd-533ecb9c6ac8');
INSERT INTO `sys_userinfo_picture` VALUES ('2544', 'CertificatePhotos/172.jpg', 'CertificatePhotosFace/172.jpg', 'VoicePlayback/172.mp3', 'e9b4f99e-6053-4fea-804e-884befd8e58c');
INSERT INTO `sys_userinfo_picture` VALUES ('2545', 'CertificatePhotos/173.jpg', 'CertificatePhotosFace/173.jpg', 'VoicePlayback/173.mp3', 'f6ad80e1-da36-40da-9b4d-e91659388c29');
INSERT INTO `sys_userinfo_picture` VALUES ('2546', 'CertificatePhotos/174.jpg', 'CertificatePhotosFace/174.jpg', 'VoicePlayback/174.mp3', '9d0d983a-210d-4b2b-a24d-82339aa9dee0');
INSERT INTO `sys_userinfo_picture` VALUES ('2547', 'CertificatePhotos/175.jpg', 'CertificatePhotosFace/175.jpg', 'VoicePlayback/175.mp3', '2067b9cc-15d1-4610-a595-101dbe26b401');
INSERT INTO `sys_userinfo_picture` VALUES ('2548', 'CertificatePhotos/176.jpg', 'CertificatePhotosFace/176.jpg', 'VoicePlayback/176.mp3', '094ac235-ae20-41e6-8e38-67f861f439a0');
INSERT INTO `sys_userinfo_picture` VALUES ('2549', 'CertificatePhotos/177.jpg', 'CertificatePhotosFace/177.jpg', 'VoicePlayback/177.mp3', '8acf84aa-1c24-453d-a8c4-52b28883cbd9');
INSERT INTO `sys_userinfo_picture` VALUES ('2550', 'CertificatePhotos/178.jpg', 'CertificatePhotosFace/178.jpg', 'VoicePlayback/178.mp3', 'c628885e-99ca-45ac-892f-9bea34f59583');
INSERT INTO `sys_userinfo_picture` VALUES ('2551', 'CertificatePhotos/179.jpg', 'CertificatePhotosFace/179.jpg', 'VoicePlayback/179.mp3', 'dc6f8e81-d555-44bf-ad52-c52775610588');
INSERT INTO `sys_userinfo_picture` VALUES ('2552', 'CertificatePhotos/180.jpg', 'CertificatePhotosFace/180.jpg', 'VoicePlayback/180.mp3', '97a2d7f0-b90d-48a2-af5b-ed175bcef4e4');
INSERT INTO `sys_userinfo_picture` VALUES ('2553', 'CertificatePhotos/181.jpg', 'CertificatePhotosFace/181.jpg', 'VoicePlayback/181.mp3', '17d453e6-7ed0-423f-b54b-3afb3709fcad');
INSERT INTO `sys_userinfo_picture` VALUES ('2554', 'CertificatePhotos/182.jpg', 'CertificatePhotosFace/182.jpg', 'VoicePlayback/182.mp3', 'dc09f602-a43f-4b84-ba54-cd59fa763d79');
INSERT INTO `sys_userinfo_picture` VALUES ('2555', 'CertificatePhotos/183.jpg', 'CertificatePhotosFace/183.jpg', 'VoicePlayback/183.mp3', 'c20d61f4-590d-458a-88f7-3e3f9100b965');
INSERT INTO `sys_userinfo_picture` VALUES ('2556', 'CertificatePhotos/184.jpg', 'CertificatePhotosFace/184.jpg', 'VoicePlayback/184.mp3', '73162d62-63f6-4062-86c3-e5708516fb2d');
INSERT INTO `sys_userinfo_picture` VALUES ('2557', 'CertificatePhotos/185.jpg', 'CertificatePhotosFace/185.jpg', 'VoicePlayback/185.mp3', '25e7a9af-e005-4b71-b0c9-ee0463eb35c0');
INSERT INTO `sys_userinfo_picture` VALUES ('2558', 'CertificatePhotos/186.jpg', 'CertificatePhotosFace/186.jpg', 'VoicePlayback/186.mp3', 'bc257cb2-9198-4a73-820f-8749249690a4');
INSERT INTO `sys_userinfo_picture` VALUES ('2559', 'CertificatePhotos/187.jpg', 'CertificatePhotosFace/187.jpg', 'VoicePlayback/187.mp3', '9f432f44-edd3-4d1c-afbc-f312f60df24e');
INSERT INTO `sys_userinfo_picture` VALUES ('2560', 'CertificatePhotos/188.jpg', 'CertificatePhotosFace/188.jpg', 'VoicePlayback/188.mp3', '16d870ea-2da9-4f23-bfbe-7b0879acce54');
INSERT INTO `sys_userinfo_picture` VALUES ('2561', 'CertificatePhotos/189.jpg', 'CertificatePhotosFace/189.jpg', 'VoicePlayback/189.mp3', 'df376508-bf2f-4b25-abe5-7cb19480dcfc');
INSERT INTO `sys_userinfo_picture` VALUES ('2562', 'CertificatePhotos/190.jpg', 'CertificatePhotosFace/190.jpg', 'VoicePlayback/190.mp3', '9ae8d41a-22aa-4cef-aad6-4c9379027fb9');
INSERT INTO `sys_userinfo_picture` VALUES ('2563', 'CertificatePhotos/191.jpg', 'CertificatePhotosFace/191.jpg', 'VoicePlayback/191.mp3', 'b5358e54-a897-43a7-8d82-a665889cce05');
INSERT INTO `sys_userinfo_picture` VALUES ('2564', 'CertificatePhotos/192.jpg', 'CertificatePhotosFace/192.jpg', 'VoicePlayback/192.mp3', 'c0c0bac2-d6ec-4ce4-8eab-474451613518');
INSERT INTO `sys_userinfo_picture` VALUES ('2565', 'CertificatePhotos/194.jpg', 'CertificatePhotosFace/194.jpg', 'VoicePlayback/194.mp3', '428afdc6-a2ee-47f5-adef-82a65cc345bf');
INSERT INTO `sys_userinfo_picture` VALUES ('2566', 'CertificatePhotos/195.jpg', 'CertificatePhotosFace/195.jpg', 'VoicePlayback/195.mp3', '0c069c86-3569-41ee-adc1-b670f0463d1e');
INSERT INTO `sys_userinfo_picture` VALUES ('2567', 'CertificatePhotos/196.jpg', 'CertificatePhotosFace/196.jpg', 'VoicePlayback/196.mp3', '1dbd1828-1280-4eab-a0fa-e0c3cebef53a');
INSERT INTO `sys_userinfo_picture` VALUES ('2568', 'CertificatePhotos/197.jpg', 'CertificatePhotosFace/197.jpg', 'VoicePlayback/197.mp3', '7c568ab0-8371-4d9d-8e6a-53fb841b3ba3');
INSERT INTO `sys_userinfo_picture` VALUES ('2569', 'CertificatePhotos/198.jpg', 'CertificatePhotosFace/198.jpg', 'VoicePlayback/198.mp3', '1006d2ec-f859-418b-8b87-f1661ffc7929');
INSERT INTO `sys_userinfo_picture` VALUES ('2570', 'CertificatePhotos/199.jpg', 'CertificatePhotosFace/199.jpg', 'VoicePlayback/199.mp3', '32f96933-0208-4a06-969a-9cda338123de');
INSERT INTO `sys_userinfo_picture` VALUES ('2571', 'CertificatePhotos/200.jpg', 'CertificatePhotosFace/200.jpg', 'VoicePlayback/200.mp3', '2cc340a1-332a-4661-9c1d-4daf66be550b');
INSERT INTO `sys_userinfo_picture` VALUES ('2572', 'CertificatePhotos/201.jpg', 'CertificatePhotosFace/201.jpg', 'VoicePlayback/201.mp3', '8b792e68-5cad-4256-b393-10504f8c7055');
INSERT INTO `sys_userinfo_picture` VALUES ('2573', 'CertificatePhotos/202.jpg', 'CertificatePhotosFace/202.jpg', 'VoicePlayback/202.mp3', 'da83d0e9-78cc-414d-a114-d77de25ab01a');
INSERT INTO `sys_userinfo_picture` VALUES ('2574', 'CertificatePhotos/203.jpg', 'CertificatePhotosFace/203.jpg', 'VoicePlayback/203.mp3', 'cf2fdf5b-5117-4c6b-8903-81e70e5915e3');
INSERT INTO `sys_userinfo_picture` VALUES ('2575', 'CertificatePhotos/204.jpg', 'CertificatePhotosFace/204.jpg', 'VoicePlayback/204.mp3', '49b6df94-0024-4fe6-8e2e-73fb40ba5613');
INSERT INTO `sys_userinfo_picture` VALUES ('2576', 'CertificatePhotos/205.jpg', 'CertificatePhotosFace/205.jpg', 'VoicePlayback/205.mp3', 'adbcba98-fe3c-4e33-af2d-101454a072b1');
INSERT INTO `sys_userinfo_picture` VALUES ('2577', 'CertificatePhotos/206.jpg', 'CertificatePhotosFace/206.jpg', 'VoicePlayback/206.mp3', 'e7fc26ba-4061-43df-8fd0-1a4d4416edc6');
INSERT INTO `sys_userinfo_picture` VALUES ('2578', 'CertificatePhotos/207.jpg', 'CertificatePhotosFace/207.jpg', 'VoicePlayback/207.mp3', 'ba47b51b-4e10-452d-adc4-bd641ca4604f');
INSERT INTO `sys_userinfo_picture` VALUES ('2579', 'CertificatePhotos/208.jpg', 'CertificatePhotosFace/208.jpg', 'VoicePlayback/208.mp3', '13c3603b-1f33-45e8-a6d0-2ef6489fc32e');
INSERT INTO `sys_userinfo_picture` VALUES ('2580', 'CertificatePhotos/209.jpg', 'CertificatePhotosFace/209.jpg', 'VoicePlayback/209.mp3', 'bb35972c-9296-4570-a44d-e3dd3e11372e');
INSERT INTO `sys_userinfo_picture` VALUES ('2581', 'CertificatePhotos/210.jpg', 'CertificatePhotosFace/210.jpg', 'VoicePlayback/210.mp3', '44d59a5e-e59e-481c-934e-74781b7eb1d1');
INSERT INTO `sys_userinfo_picture` VALUES ('2582', 'CertificatePhotos/211.jpg', 'CertificatePhotosFace/211.jpg', 'VoicePlayback/211.mp3', '47e82e10-30f3-4ac6-b764-45405568c1f5');
INSERT INTO `sys_userinfo_picture` VALUES ('2583', 'CertificatePhotos/212.jpg', 'CertificatePhotosFace/212.jpg', 'VoicePlayback/212.mp3', 'd960a34b-a5d4-4cff-b860-41177eb6d859');
INSERT INTO `sys_userinfo_picture` VALUES ('2584', 'CertificatePhotos/213.jpg', 'CertificatePhotosFace/213.jpg', 'VoicePlayback/213.mp3', 'ac0a853c-5716-4695-b05d-0abaf425de8d');
INSERT INTO `sys_userinfo_picture` VALUES ('2585', 'CertificatePhotos/214.jpg', 'CertificatePhotosFace/214.jpg', 'VoicePlayback/214.mp3', '81042cd2-9569-4935-a22c-1a2f14df1fc8');
INSERT INTO `sys_userinfo_picture` VALUES ('2586', 'CertificatePhotos/215.jpg', 'CertificatePhotosFace/215.jpg', 'VoicePlayback/215.mp3', '3495d869-a036-4eda-b689-acd91bffb4c5');
INSERT INTO `sys_userinfo_picture` VALUES ('2587', 'CertificatePhotos/216.jpg', 'CertificatePhotosFace/216.jpg', 'VoicePlayback/216.mp3', '12b1a6f3-80e9-4f26-9a3a-8946e69265a7');
INSERT INTO `sys_userinfo_picture` VALUES ('2588', 'CertificatePhotos/217.jpg', 'CertificatePhotosFace/217.jpg', 'VoicePlayback/217.mp3', 'fb0ecc84-73fd-46c4-92a5-f3f3f000ffd1');
INSERT INTO `sys_userinfo_picture` VALUES ('2589', 'CertificatePhotos/218.jpg', 'CertificatePhotosFace/218.jpg', 'VoicePlayback/218.mp3', '4221fa0c-6829-4ebd-bb91-01f688dda02c');
INSERT INTO `sys_userinfo_picture` VALUES ('2590', 'CertificatePhotos/219.jpg', 'CertificatePhotosFace/219.jpg', 'VoicePlayback/219.mp3', '8c9847b1-5a37-4e86-ae6e-0aabd3ff55c2');
INSERT INTO `sys_userinfo_picture` VALUES ('2591', 'CertificatePhotos/220.jpg', 'CertificatePhotosFace/220.jpg', 'VoicePlayback/220.mp3', '2b6f6c5e-1a0d-4b62-84e6-33c21d9aece0');
INSERT INTO `sys_userinfo_picture` VALUES ('2592', 'CertificatePhotos/221.jpg', 'CertificatePhotosFace/221.jpg', 'VoicePlayback/221.mp3', '08f59141-bf04-47a9-bfce-13dabeb46d78');
INSERT INTO `sys_userinfo_picture` VALUES ('2593', 'CertificatePhotos/222.jpg', 'CertificatePhotosFace/222.jpg', 'VoicePlayback/222.mp3', '718210d3-e8e6-4fa1-9c49-e0402a1b0b7d');
INSERT INTO `sys_userinfo_picture` VALUES ('2594', 'CertificatePhotos/223.jpg', 'CertificatePhotosFace/223.jpg', 'VoicePlayback/223.mp3', '71c3f973-3072-4292-ab24-e34ee9864c9f');
INSERT INTO `sys_userinfo_picture` VALUES ('2595', 'CertificatePhotos/224.jpg', 'CertificatePhotosFace/224.jpg', 'VoicePlayback/224.mp3', '5b548ecb-85fb-4b25-999c-8ae5c56b0fa2');
INSERT INTO `sys_userinfo_picture` VALUES ('2596', 'CertificatePhotos/225.jpg', 'CertificatePhotosFace/225.jpg', 'VoicePlayback/225.mp3', '20b3383a-67e7-4d9a-bcbe-efbabdb3914c');
INSERT INTO `sys_userinfo_picture` VALUES ('2597', 'CertificatePhotos/226.jpg', 'CertificatePhotosFace/226.jpg', 'VoicePlayback/226.mp3', '3cb67b68-eb43-4c3d-a5c4-f0099a70485b');
INSERT INTO `sys_userinfo_picture` VALUES ('2598', 'CertificatePhotos/227.jpg', 'CertificatePhotosFace/227.jpg', 'VoicePlayback/227.mp3', 'c3df907a-bf29-495d-8c56-49ae4f38e8c7');
INSERT INTO `sys_userinfo_picture` VALUES ('2599', 'CertificatePhotos/228.jpg', 'CertificatePhotosFace/228.jpg', 'VoicePlayback/228.mp3', 'b9dd9a80-972a-4095-a8e1-58c423835abc');
INSERT INTO `sys_userinfo_picture` VALUES ('2600', 'CertificatePhotos/229.jpg', 'CertificatePhotosFace/229.jpg', 'VoicePlayback/229.mp3', '08dc94da-8af7-4c98-abb7-736c2dd2025a');
INSERT INTO `sys_userinfo_picture` VALUES ('2601', 'CertificatePhotos/230.jpg', 'CertificatePhotosFace/230.jpg', 'VoicePlayback/230.mp3', '03bdc540-7560-4b74-8342-bb7e169abf77');
INSERT INTO `sys_userinfo_picture` VALUES ('2602', 'CertificatePhotos/231.jpg', 'CertificatePhotosFace/231.jpg', 'VoicePlayback/231.mp3', 'ddbfab61-067e-41e0-96f7-1e8707d1f840');
INSERT INTO `sys_userinfo_picture` VALUES ('2603', 'CertificatePhotos/233.jpg', 'CertificatePhotosFace/233.jpg', 'VoicePlayback/233.mp3', 'cd573962-2d74-41b3-95c9-b078792cb0cd');
INSERT INTO `sys_userinfo_picture` VALUES ('2604', 'CertificatePhotos/234.jpg', 'CertificatePhotosFace/234.jpg', 'VoicePlayback/234.mp3', '9d95659a-4c26-433b-b2a7-865335a82b6d');
INSERT INTO `sys_userinfo_picture` VALUES ('2605', 'CertificatePhotos/235.jpg', 'CertificatePhotosFace/235.jpg', 'VoicePlayback/235.mp3', '3b9947ff-f944-4af9-9f90-d67d30d21429');
INSERT INTO `sys_userinfo_picture` VALUES ('2606', 'CertificatePhotos/236.jpg', 'CertificatePhotosFace/236.jpg', 'VoicePlayback/236.mp3', '4137653d-fbb0-469f-9105-4e84ae9a89e7');
INSERT INTO `sys_userinfo_picture` VALUES ('2607', 'CertificatePhotos/237.jpg', 'CertificatePhotosFace/237.jpg', 'VoicePlayback/237.mp3', '29786623-b9d3-4fff-bc2f-485f60a828a2');
INSERT INTO `sys_userinfo_picture` VALUES ('2608', 'CertificatePhotos/238.jpg', 'CertificatePhotosFace/238.jpg', 'VoicePlayback/238.mp3', '072a19e6-0fdd-44a4-805d-0798302fe219');
INSERT INTO `sys_userinfo_picture` VALUES ('2609', 'CertificatePhotos/239.jpg', 'CertificatePhotosFace/239.jpg', 'VoicePlayback/239.mp3', '74521aa5-17a4-4908-8f1a-e30c116d4df5');
INSERT INTO `sys_userinfo_picture` VALUES ('2610', 'CertificatePhotos/242.jpg', 'CertificatePhotosFace/242.jpg', 'VoicePlayback/242.mp3', '7b0562bb-e56d-45f0-9dfa-50e17c4b61cd');
INSERT INTO `sys_userinfo_picture` VALUES ('2611', 'CertificatePhotos/243.jpg', 'CertificatePhotosFace/243.jpg', 'VoicePlayback/243.mp3', 'ec928780-6ea3-4d7d-b105-b824a9640e23');
INSERT INTO `sys_userinfo_picture` VALUES ('2612', 'CertificatePhotos/244.jpg', 'CertificatePhotosFace/244.jpg', 'VoicePlayback/244.mp3', '3f038309-af1b-4ca1-87c4-b0199ad7c91f');
INSERT INTO `sys_userinfo_picture` VALUES ('2613', 'CertificatePhotos/245.jpg', 'CertificatePhotosFace/245.jpg', 'VoicePlayback/245.mp3', 'd41d7eff-9533-446a-83d2-96ed7de0cd18');
INSERT INTO `sys_userinfo_picture` VALUES ('2614', 'CertificatePhotos/246.jpg', 'CertificatePhotosFace/246.jpg', 'VoicePlayback/246.mp3', '1dd5ab01-0a51-4f51-8062-bde4cef594b6');
INSERT INTO `sys_userinfo_picture` VALUES ('2615', 'CertificatePhotos/247.jpg', 'CertificatePhotosFace/247.jpg', 'VoicePlayback/247.mp3', '71621afa-3fb7-427f-94cb-e671e43d8756');
INSERT INTO `sys_userinfo_picture` VALUES ('2616', 'CertificatePhotos/248.jpg', 'CertificatePhotosFace/248.jpg', 'VoicePlayback/248.mp3', '7bce6ae5-bed7-4328-84be-b174eabc492f');
INSERT INTO `sys_userinfo_picture` VALUES ('2617', 'CertificatePhotos/249.jpg', 'CertificatePhotosFace/249.jpg', 'VoicePlayback/249.mp3', '986927e5-ccaf-4b53-bc1f-a9589b5120bf');
INSERT INTO `sys_userinfo_picture` VALUES ('2618', 'CertificatePhotos/250.jpg', 'CertificatePhotosFace/250.jpg', 'VoicePlayback/250.mp3', '9f73d797-1b63-4629-b28f-0fb8099617d0');
INSERT INTO `sys_userinfo_picture` VALUES ('2619', 'CertificatePhotos/251.jpg', 'CertificatePhotosFace/251.jpg', 'VoicePlayback/251.mp3', 'abdf0aa8-cf4e-4dbf-a298-8241a8f61a13');
INSERT INTO `sys_userinfo_picture` VALUES ('2620', 'CertificatePhotos/252.jpg', 'CertificatePhotosFace/252.jpg', 'VoicePlayback/252.mp3', '62b8b1c4-fa05-4ef2-92a9-f5be58f45e0e');
INSERT INTO `sys_userinfo_picture` VALUES ('2621', 'CertificatePhotos/253.jpg', 'CertificatePhotosFace/253.jpg', 'VoicePlayback/253.mp3', 'eed9b6fe-69e8-4053-9650-2050a3156f77');
INSERT INTO `sys_userinfo_picture` VALUES ('2622', 'CertificatePhotos/254.jpg', 'CertificatePhotosFace/254.jpg', 'VoicePlayback/254.mp3', '0218246e-6595-4709-82d3-382eebc322dd');
INSERT INTO `sys_userinfo_picture` VALUES ('2623', 'CertificatePhotos/255.jpg', 'CertificatePhotosFace/255.jpg', 'VoicePlayback/255.mp3', '57d73f76-be2b-4868-814e-cb05ac8b8a0f');
INSERT INTO `sys_userinfo_picture` VALUES ('2624', 'CertificatePhotos/256.jpg', 'CertificatePhotosFace/256.jpg', 'VoicePlayback/256.mp3', '7ae97306-73c9-4bb8-929b-d8a9b1e29750');
INSERT INTO `sys_userinfo_picture` VALUES ('2625', 'CertificatePhotos/257.jpg', 'CertificatePhotosFace/257.jpg', 'VoicePlayback/257.mp3', 'ab3c4698-c66f-481b-bf4e-674e07ea3679');
INSERT INTO `sys_userinfo_picture` VALUES ('2626', 'CertificatePhotos/258.jpg', 'CertificatePhotosFace/258.jpg', 'VoicePlayback/258.mp3', '92ce653c-a8ae-45d3-a793-b581a1f6f089');
INSERT INTO `sys_userinfo_picture` VALUES ('2627', 'CertificatePhotos/259.jpg', 'CertificatePhotosFace/259.jpg', 'VoicePlayback/259.mp3', 'f0b1797b-58c3-4fc4-b045-60419efcabb0');
INSERT INTO `sys_userinfo_picture` VALUES ('2628', 'CertificatePhotos/260.jpg', 'CertificatePhotosFace/260.jpg', 'VoicePlayback/260.mp3', 'faff4e26-bb5d-4b73-9544-c8dd420a7d3d');
INSERT INTO `sys_userinfo_picture` VALUES ('2629', 'CertificatePhotos/261.jpg', 'CertificatePhotosFace/261.jpg', 'VoicePlayback/261.mp3', 'e97e6ad7-5009-4bbf-a791-e00bcd6f4b35');
INSERT INTO `sys_userinfo_picture` VALUES ('2630', 'CertificatePhotos/262.jpg', 'CertificatePhotosFace/262.jpg', 'VoicePlayback/262.mp3', '31aedeb0-35ce-42e3-b750-c4de1f8a08e2');
INSERT INTO `sys_userinfo_picture` VALUES ('2631', 'CertificatePhotos/263.jpg', 'CertificatePhotosFace/263.jpg', 'VoicePlayback/263.mp3', 'fc0794c4-85ae-4934-9c65-070080dfb78b');
INSERT INTO `sys_userinfo_picture` VALUES ('2632', 'CertificatePhotos/264.jpg', 'CertificatePhotosFace/264.jpg', 'VoicePlayback/264.mp3', '5d0afc19-2b33-46aa-a725-c3f2201ada6e');
INSERT INTO `sys_userinfo_picture` VALUES ('2633', 'CertificatePhotos/265.jpg', 'CertificatePhotosFace/265.jpg', 'VoicePlayback/265.mp3', '1c776acd-dca9-4cbc-867a-2c07e38c8541');
INSERT INTO `sys_userinfo_picture` VALUES ('2634', 'CertificatePhotos/266.jpg', 'CertificatePhotosFace/266.jpg', 'VoicePlayback/266.mp3', 'bcd537dd-a0a9-492d-b45c-5491f58cbd02');
INSERT INTO `sys_userinfo_picture` VALUES ('2635', 'CertificatePhotos/267.jpg', 'CertificatePhotosFace/267.jpg', 'VoicePlayback/267.mp3', '955bcf7b-8c69-4c94-a790-c635fe24d937');
INSERT INTO `sys_userinfo_picture` VALUES ('2636', 'CertificatePhotos/268.jpg', 'CertificatePhotosFace/268.jpg', 'VoicePlayback/268.mp3', 'e5eb0ba3-79ae-4dd0-af3a-4de6cc7b2509');
INSERT INTO `sys_userinfo_picture` VALUES ('2637', 'CertificatePhotos/269.jpg', 'CertificatePhotosFace/269.jpg', 'VoicePlayback/269.mp3', 'bf813017-9c5c-449e-8170-71d734a58b60');
INSERT INTO `sys_userinfo_picture` VALUES ('2638', 'CertificatePhotos/270.jpg', 'CertificatePhotosFace/270.jpg', 'VoicePlayback/270.mp3', '037b567a-4948-4148-902e-704e7b939b74');
INSERT INTO `sys_userinfo_picture` VALUES ('2639', 'CertificatePhotos/271.jpg', 'CertificatePhotosFace/271.jpg', 'VoicePlayback/271.mp3', '6292f78e-8d6c-4c52-a9f7-649fb1be088c');
INSERT INTO `sys_userinfo_picture` VALUES ('2640', 'CertificatePhotos/272.jpg', 'CertificatePhotosFace/272.jpg', 'VoicePlayback/272.mp3', 'd7dc4563-0a0a-4286-a16d-81639d4a965e');
INSERT INTO `sys_userinfo_picture` VALUES ('2641', 'CertificatePhotos/273.jpg', 'CertificatePhotosFace/273.jpg', 'VoicePlayback/273.mp3', 'a44f6e15-9427-4ed1-93e1-f156a33b8e96');
INSERT INTO `sys_userinfo_picture` VALUES ('2642', 'CertificatePhotos/274.jpg', 'CertificatePhotosFace/274.jpg', 'VoicePlayback/274.mp3', '00735329-a19d-4f6e-be26-9efc1b03ca2a');
INSERT INTO `sys_userinfo_picture` VALUES ('2643', 'CertificatePhotos/275.jpg', 'CertificatePhotosFace/275.jpg', 'VoicePlayback/275.mp3', 'd30a1aeb-9f22-414c-822d-e187c95bc744');
INSERT INTO `sys_userinfo_picture` VALUES ('2644', 'CertificatePhotos/276.jpg', 'CertificatePhotosFace/276.jpg', 'VoicePlayback/276.mp3', 'f6c10093-8663-4376-bcf5-906e235e8a56');
INSERT INTO `sys_userinfo_picture` VALUES ('2645', 'CertificatePhotos/277.jpg', 'CertificatePhotosFace/277.jpg', 'VoicePlayback/277.mp3', 'c37c92cc-5d7f-4dcc-9d99-2ad42155c5de');
INSERT INTO `sys_userinfo_picture` VALUES ('2646', 'CertificatePhotos/278.jpg', 'CertificatePhotosFace/278.jpg', 'VoicePlayback/278.mp3', '4c35e557-8717-4c91-9411-3aa6d6b0ed5f');
INSERT INTO `sys_userinfo_picture` VALUES ('2647', 'CertificatePhotos/279.jpg', 'CertificatePhotosFace/279.jpg', 'VoicePlayback/279.mp3', '1b606dc8-d07e-4012-8ea1-c673121ec0cd');
INSERT INTO `sys_userinfo_picture` VALUES ('2648', 'CertificatePhotos/280.jpg', 'CertificatePhotosFace/280.jpg', 'VoicePlayback/280.mp3', 'e5197f58-d5c4-4a5c-bc0a-dacef00e7533');
INSERT INTO `sys_userinfo_picture` VALUES ('2649', 'CertificatePhotos/281.jpg', 'CertificatePhotosFace/281.jpg', 'VoicePlayback/281.mp3', '5730aa3e-b8d1-4aa3-a421-eba11b576cd7');
INSERT INTO `sys_userinfo_picture` VALUES ('2650', 'CertificatePhotos/282.jpg', 'CertificatePhotosFace/282.jpg', 'VoicePlayback/282.mp3', '654e7d35-d9cc-4479-9b1e-dc4e321eb1fa');
INSERT INTO `sys_userinfo_picture` VALUES ('2651', 'CertificatePhotos/283.jpg', 'CertificatePhotosFace/283.jpg', 'VoicePlayback/283.mp3', 'd94b000d-9707-4930-b3a4-275c13861005');
INSERT INTO `sys_userinfo_picture` VALUES ('2652', 'CertificatePhotos/284.jpg', 'CertificatePhotosFace/284.jpg', 'VoicePlayback/284.mp3', '780788d9-8ee5-4766-b4c2-a27661ee5ae7');
INSERT INTO `sys_userinfo_picture` VALUES ('2653', 'CertificatePhotos/285.jpg', 'CertificatePhotosFace/285.jpg', 'VoicePlayback/285.mp3', 'f9804340-d63c-412b-8cbc-5d55cb7af607');
INSERT INTO `sys_userinfo_picture` VALUES ('2654', 'CertificatePhotos/286.jpg', 'CertificatePhotosFace/286.jpg', 'VoicePlayback/286.mp3', '43107621-1556-4b71-81bf-6abee116e1d2');
INSERT INTO `sys_userinfo_picture` VALUES ('2655', 'CertificatePhotos/287.jpg', 'CertificatePhotosFace/287.jpg', 'VoicePlayback/287.mp3', '390a90ae-2ac3-4a2f-9a1b-088e2005708e');
INSERT INTO `sys_userinfo_picture` VALUES ('2656', 'CertificatePhotos/288.jpg', 'CertificatePhotosFace/288.jpg', 'VoicePlayback/288.mp3', 'a724acb0-0dff-4c2a-b146-2ab94baf1130');
INSERT INTO `sys_userinfo_picture` VALUES ('2657', 'CertificatePhotos/289.jpg', 'CertificatePhotosFace/289.jpg', 'VoicePlayback/289.mp3', '7f46f491-f936-4cdf-8afe-e7f46225af34');
INSERT INTO `sys_userinfo_picture` VALUES ('2658', 'CertificatePhotos/290.jpg', 'CertificatePhotosFace/290.jpg', 'VoicePlayback/290.mp3', '445dcd84-5a28-4495-841b-c8adf51e7d33');
INSERT INTO `sys_userinfo_picture` VALUES ('2659', 'CertificatePhotos/291.jpg', 'CertificatePhotosFace/291.jpg', 'VoicePlayback/291.mp3', '78affb1f-85ac-4ca3-8268-c42528e91934');
INSERT INTO `sys_userinfo_picture` VALUES ('2660', 'CertificatePhotos/292.jpg', 'CertificatePhotosFace/292.jpg', 'VoicePlayback/292.mp3', '58b57931-9e2f-49a2-97d0-eb9630ce55be');
INSERT INTO `sys_userinfo_picture` VALUES ('2661', 'CertificatePhotos/293.jpg', 'CertificatePhotosFace/293.jpg', 'VoicePlayback/293.mp3', 'c0f7c83c-b9a7-4f8c-b20b-41ea8cba449b');
INSERT INTO `sys_userinfo_picture` VALUES ('2662', 'CertificatePhotos/294.jpg', 'CertificatePhotosFace/294.jpg', 'VoicePlayback/294.mp3', '12ec6e01-51bc-4a53-8fb9-926aee2e2096');
INSERT INTO `sys_userinfo_picture` VALUES ('2663', 'CertificatePhotos/295.jpg', 'CertificatePhotosFace/295.jpg', 'VoicePlayback/295.mp3', 'a50c7397-6d33-4133-a54e-3591f757cffa');
INSERT INTO `sys_userinfo_picture` VALUES ('2664', 'CertificatePhotos/296.jpg', 'CertificatePhotosFace/296.jpg', 'VoicePlayback/296.mp3', '3283829b-f00f-4f9a-875b-8c3e5da0530b');
INSERT INTO `sys_userinfo_picture` VALUES ('2665', 'CertificatePhotos/297.jpg', 'CertificatePhotosFace/297.jpg', 'VoicePlayback/297.mp3', '57cb6667-b986-4825-b079-712a64119f04');
INSERT INTO `sys_userinfo_picture` VALUES ('2666', 'CertificatePhotos/298.jpg', 'CertificatePhotosFace/298.jpg', 'VoicePlayback/298.mp3', '6ed2aebd-cc7e-4e02-bc75-f060181cd894');
INSERT INTO `sys_userinfo_picture` VALUES ('2667', 'CertificatePhotos/299.jpg', 'CertificatePhotosFace/299.jpg', 'VoicePlayback/299.mp3', '0e96a66d-47b9-49e9-a1c9-ad8666b3f496');
INSERT INTO `sys_userinfo_picture` VALUES ('2668', 'CertificatePhotos/300.jpg', 'CertificatePhotosFace/300.jpg', 'VoicePlayback/300.mp3', 'ebc552ef-52cc-490c-a4d8-1500d2c928e0');
INSERT INTO `sys_userinfo_picture` VALUES ('2669', 'CertificatePhotos/301.jpg', 'CertificatePhotosFace/301.jpg', 'VoicePlayback/301.mp3', '1ad40312-2738-4bcc-bbcb-04d4cc7fdc4e');
INSERT INTO `sys_userinfo_picture` VALUES ('2670', 'CertificatePhotos/302.jpg', 'CertificatePhotosFace/302.jpg', 'VoicePlayback/302.mp3', '68652e1a-88df-40aa-8871-a608eed77d84');
INSERT INTO `sys_userinfo_picture` VALUES ('2671', 'CertificatePhotos/303.jpg', 'CertificatePhotosFace/303.jpg', 'VoicePlayback/303.mp3', '703944c9-a7fa-450e-aa29-fcb54e0a2ffc');
INSERT INTO `sys_userinfo_picture` VALUES ('2672', 'CertificatePhotos/304.jpg', 'CertificatePhotosFace/304.jpg', 'VoicePlayback/304.mp3', 'e1b535d5-f405-4050-8072-e29e8f2c67f2');
INSERT INTO `sys_userinfo_picture` VALUES ('2673', 'CertificatePhotos/305.jpg', 'CertificatePhotosFace/305.jpg', 'VoicePlayback/305.mp3', 'fb9405db-2e89-488c-ab65-632dfd6f2e22');
INSERT INTO `sys_userinfo_picture` VALUES ('2674', 'CertificatePhotos/306.jpg', 'CertificatePhotosFace/306.jpg', 'VoicePlayback/306.mp3', '9ca87c1d-ea0d-4c02-8dbd-6886e0720129');
INSERT INTO `sys_userinfo_picture` VALUES ('2675', 'CertificatePhotos/307.jpg', 'CertificatePhotosFace/307.jpg', 'VoicePlayback/307.mp3', '1c9a2474-dee5-422d-ab18-19d779b15fb1');
INSERT INTO `sys_userinfo_picture` VALUES ('2676', 'CertificatePhotos/308.jpg', 'CertificatePhotosFace/308.jpg', 'VoicePlayback/308.mp3', '7d590405-9a3a-43f1-94f1-686b7665bf31');
INSERT INTO `sys_userinfo_picture` VALUES ('2677', 'CertificatePhotos/309.jpg', 'CertificatePhotosFace/309.jpg', 'VoicePlayback/309.mp3', '3779e10f-56e8-497e-9234-ba3f936d4d06');
INSERT INTO `sys_userinfo_picture` VALUES ('2678', 'CertificatePhotos/310.jpg', 'CertificatePhotosFace/310.jpg', 'VoicePlayback/310.mp3', '651f3fbb-f1c2-4cb4-a91f-80f100f58f37');
INSERT INTO `sys_userinfo_picture` VALUES ('2679', 'CertificatePhotos/311.jpg', 'CertificatePhotosFace/311.jpg', 'VoicePlayback/311.mp3', '4fa3fc3d-4433-4166-925a-7571f833b3e5');
INSERT INTO `sys_userinfo_picture` VALUES ('2680', 'CertificatePhotos/312.jpg', 'CertificatePhotosFace/312.jpg', 'VoicePlayback/312.mp3', '7d7b2922-a03e-4958-abcc-9552d82025af');
INSERT INTO `sys_userinfo_picture` VALUES ('2681', 'CertificatePhotos/313.jpg', 'CertificatePhotosFace/313.jpg', 'VoicePlayback/313.mp3', '914b1d13-16ef-4d86-a32c-8b651e3c944d');
INSERT INTO `sys_userinfo_picture` VALUES ('2682', 'CertificatePhotos/314.jpg', 'CertificatePhotosFace/314.jpg', 'VoicePlayback/314.mp3', '21a53145-19fb-4453-8402-38a3f46a2af3');
INSERT INTO `sys_userinfo_picture` VALUES ('2683', 'CertificatePhotos/315.jpg', 'CertificatePhotosFace/315.jpg', 'VoicePlayback/315.mp3', '33aca440-2fc3-420a-91bd-1311d9b843d5');
INSERT INTO `sys_userinfo_picture` VALUES ('2684', 'CertificatePhotos/316.jpg', 'CertificatePhotosFace/316.jpg', 'VoicePlayback/316.mp3', '49724559-c026-4a0e-8327-6ae6e9cadda9');
INSERT INTO `sys_userinfo_picture` VALUES ('2685', 'CertificatePhotos/317.jpg', 'CertificatePhotosFace/317.jpg', 'VoicePlayback/317.mp3', '8a181522-d73c-4902-94f3-5b40bfc71b97');
INSERT INTO `sys_userinfo_picture` VALUES ('2686', 'CertificatePhotos/318.jpg', 'CertificatePhotosFace/318.jpg', 'VoicePlayback/318.mp3', '26e43d50-139e-4814-9a85-4743c14aef7c');
INSERT INTO `sys_userinfo_picture` VALUES ('2687', 'CertificatePhotos/319.jpg', 'CertificatePhotosFace/319.jpg', 'VoicePlayback/319.mp3', '00df2d2b-fdb8-476a-822a-00ad7ea15e16');
INSERT INTO `sys_userinfo_picture` VALUES ('2688', 'CertificatePhotos/320.jpg', 'CertificatePhotosFace/320.jpg', 'VoicePlayback/320.mp3', '66cbdd9f-63d7-468b-9375-a7f8a0e335ad');
INSERT INTO `sys_userinfo_picture` VALUES ('2689', 'CertificatePhotos/321.jpg', 'CertificatePhotosFace/321.jpg', 'VoicePlayback/321.mp3', 'f5ae1cbe-f13d-4ab4-9aca-c28205011148');
INSERT INTO `sys_userinfo_picture` VALUES ('2690', 'CertificatePhotos/322.jpg', 'CertificatePhotosFace/322.jpg', 'VoicePlayback/322.mp3', '201b9f78-2e49-49cd-adda-e69e615d2215');
INSERT INTO `sys_userinfo_picture` VALUES ('2691', 'CertificatePhotos/323.jpg', 'CertificatePhotosFace/323.jpg', 'VoicePlayback/323.mp3', '66e458e6-867f-4cf5-8d9e-f8613a120b76');
INSERT INTO `sys_userinfo_picture` VALUES ('2692', 'CertificatePhotos/324.jpg', 'CertificatePhotosFace/324.jpg', 'VoicePlayback/324.mp3', 'c31469f1-d5f2-469f-ab1c-8dc0f17a4e9e');
INSERT INTO `sys_userinfo_picture` VALUES ('2693', 'CertificatePhotos/325.jpg', 'CertificatePhotosFace/325.jpg', 'VoicePlayback/325.mp3', 'eafc7094-5683-437c-ad41-f5ea17686266');
INSERT INTO `sys_userinfo_picture` VALUES ('2694', 'CertificatePhotos/326.jpg', 'CertificatePhotosFace/326.jpg', 'VoicePlayback/326.mp3', '07fcf74f-49ed-435c-9c9a-872924b5147b');
INSERT INTO `sys_userinfo_picture` VALUES ('2695', 'CertificatePhotos/327.jpg', 'CertificatePhotosFace/327.jpg', 'VoicePlayback/327.mp3', '70fdb029-7daf-45e0-81c5-b10ad39577a6');
INSERT INTO `sys_userinfo_picture` VALUES ('2696', 'CertificatePhotos/328.jpg', 'CertificatePhotosFace/328.jpg', 'VoicePlayback/328.mp3', '31efa23d-bea9-4c18-a7a8-fc66cf3b3d28');
INSERT INTO `sys_userinfo_picture` VALUES ('2697', 'CertificatePhotos/329.jpg', 'CertificatePhotosFace/329.jpg', 'VoicePlayback/329.mp3', 'ef450ac0-eef3-4db1-8741-b4713e15dd1e');
INSERT INTO `sys_userinfo_picture` VALUES ('2698', 'CertificatePhotos/330.jpg', 'CertificatePhotosFace/330.jpg', 'VoicePlayback/330.mp3', 'bb77a9c2-8c81-4e80-8b85-477bc9361666');
INSERT INTO `sys_userinfo_picture` VALUES ('2699', 'CertificatePhotos/331.jpg', 'CertificatePhotosFace/331.jpg', 'VoicePlayback/331.mp3', '2749c118-e0c3-4739-938c-90618d2e17db');
INSERT INTO `sys_userinfo_picture` VALUES ('2700', 'CertificatePhotos/332.jpg', 'CertificatePhotosFace/332.jpg', 'VoicePlayback/332.mp3', 'b9180322-9b78-4bcf-bec4-0d6293c0a028');
INSERT INTO `sys_userinfo_picture` VALUES ('2701', 'CertificatePhotos/333.jpg', 'CertificatePhotosFace/333.jpg', 'VoicePlayback/333.mp3', '91ace27d-efd8-4197-994b-0a00b68a707f');
INSERT INTO `sys_userinfo_picture` VALUES ('2702', 'CertificatePhotos/334.jpg', 'CertificatePhotosFace/334.jpg', 'VoicePlayback/334.mp3', 'cb29b776-3786-425f-9fed-b6b35f05f7a7');
INSERT INTO `sys_userinfo_picture` VALUES ('2703', 'CertificatePhotos/335.jpg', 'CertificatePhotosFace/335.jpg', 'VoicePlayback/335.mp3', '5150c27b-4678-40a0-aba7-311d8ccf4088');
INSERT INTO `sys_userinfo_picture` VALUES ('2704', 'CertificatePhotos/336.jpg', 'CertificatePhotosFace/336.jpg', 'VoicePlayback/336.mp3', '03201d60-e736-4e4a-85c4-e65e72f7a478');
INSERT INTO `sys_userinfo_picture` VALUES ('2705', 'CertificatePhotos/337.jpg', 'CertificatePhotosFace/337.jpg', 'VoicePlayback/337.mp3', 'b0b69cf0-b6df-47a5-923a-1ad570165081');
INSERT INTO `sys_userinfo_picture` VALUES ('2706', 'CertificatePhotos/338.jpg', 'CertificatePhotosFace/338.jpg', 'VoicePlayback/338.mp3', 'fe5a5ed6-6c9e-4d21-aac6-f2deaefefab1');
INSERT INTO `sys_userinfo_picture` VALUES ('2707', 'CertificatePhotos/339.jpg', 'CertificatePhotosFace/339.jpg', 'VoicePlayback/339.mp3', '96b8ed3c-1a34-4553-9875-3ca82da69023');
INSERT INTO `sys_userinfo_picture` VALUES ('2708', 'CertificatePhotos/340.jpg', 'CertificatePhotosFace/340.jpg', 'VoicePlayback/340.mp3', 'f584852e-d95e-47b9-93f7-7d5c94dfc9a0');
INSERT INTO `sys_userinfo_picture` VALUES ('2709', 'CertificatePhotos/341.jpg', 'CertificatePhotosFace/341.jpg', 'VoicePlayback/341.mp3', 'dd812a54-dcba-41ca-bf51-3be9cd33929b');
INSERT INTO `sys_userinfo_picture` VALUES ('2710', 'CertificatePhotos/342.jpg', 'CertificatePhotosFace/342.jpg', 'VoicePlayback/342.mp3', 'f69e2265-e3e5-45a6-a789-b3c1e8ca19a2');
INSERT INTO `sys_userinfo_picture` VALUES ('2711', 'CertificatePhotos/343.jpg', 'CertificatePhotosFace/343.jpg', 'VoicePlayback/343.mp3', 'cc048c30-4ac9-4da3-855f-67c3288a672d');
INSERT INTO `sys_userinfo_picture` VALUES ('2712', 'CertificatePhotos/344.jpg', 'CertificatePhotosFace/344.jpg', 'VoicePlayback/344.mp3', 'd03075bc-7582-4b7b-a053-f2e4cadb4470');
INSERT INTO `sys_userinfo_picture` VALUES ('2713', 'CertificatePhotos/345.jpg', 'CertificatePhotosFace/345.jpg', 'VoicePlayback/345.mp3', '819e2145-1fcd-4e0f-b4d3-38cec7e296a2');
INSERT INTO `sys_userinfo_picture` VALUES ('2714', 'CertificatePhotos/346.jpg', 'CertificatePhotosFace/346.jpg', 'VoicePlayback/346.mp3', '9f372191-0ac4-4d3a-b3a4-e72af3957595');
INSERT INTO `sys_userinfo_picture` VALUES ('2715', 'CertificatePhotos/347.jpg', 'CertificatePhotosFace/347.jpg', 'VoicePlayback/347.mp3', '7e84cc36-7f41-4299-a147-0564269a3c1b');
INSERT INTO `sys_userinfo_picture` VALUES ('2716', 'CertificatePhotos/348.jpg', 'CertificatePhotosFace/348.jpg', 'VoicePlayback/348.mp3', '14958557-97cd-46eb-8a4c-12e51c758c48');
INSERT INTO `sys_userinfo_picture` VALUES ('2717', 'CertificatePhotos/349.jpg', 'CertificatePhotosFace/349.jpg', 'VoicePlayback/349.mp3', '416b89ff-572d-4ffd-b533-e309ef4b1a8d');
INSERT INTO `sys_userinfo_picture` VALUES ('2718', 'CertificatePhotos/350.jpg', 'CertificatePhotosFace/350.jpg', 'VoicePlayback/350.mp3', 'd8061f32-0161-4f1e-9c71-21e43e9e8478');
INSERT INTO `sys_userinfo_picture` VALUES ('2719', 'CertificatePhotos/351.jpg', 'CertificatePhotosFace/351.jpg', 'VoicePlayback/351.mp3', '8e7965f6-e964-43ed-add2-52c8470b4bbd');
INSERT INTO `sys_userinfo_picture` VALUES ('2720', 'CertificatePhotos/352.jpg', 'CertificatePhotosFace/352.jpg', 'VoicePlayback/352.mp3', '309159d8-d3c1-4622-bf85-bffa13bff4ca');
INSERT INTO `sys_userinfo_picture` VALUES ('2721', 'CertificatePhotos/353.jpg', 'CertificatePhotosFace/353.jpg', 'VoicePlayback/353.mp3', '51614c9a-7865-458d-acd6-0f49feb6daaf');
INSERT INTO `sys_userinfo_picture` VALUES ('2722', 'CertificatePhotos/354.jpg', 'CertificatePhotosFace/354.jpg', 'VoicePlayback/354.mp3', '8d61c023-6307-4f6f-a181-550447cda1c4');
INSERT INTO `sys_userinfo_picture` VALUES ('2723', 'CertificatePhotos/355.jpg', 'CertificatePhotosFace/355.jpg', 'VoicePlayback/355.mp3', '18502d8b-9a69-4ee4-9aeb-f154d7215122');
INSERT INTO `sys_userinfo_picture` VALUES ('2724', 'CertificatePhotos/356.jpg', 'CertificatePhotosFace/356.jpg', 'VoicePlayback/356.mp3', '9849b280-d7cd-474e-977f-6086450901fa');
INSERT INTO `sys_userinfo_picture` VALUES ('2725', 'CertificatePhotos/357.jpg', 'CertificatePhotosFace/357.jpg', 'VoicePlayback/357.mp3', 'cde56d26-6715-4f31-8f2c-db7d30eb0688');
INSERT INTO `sys_userinfo_picture` VALUES ('2726', 'CertificatePhotos/358.jpg', 'CertificatePhotosFace/358.jpg', 'VoicePlayback/358.mp3', '237743f4-676d-4865-863b-c5dd62ec4066');
INSERT INTO `sys_userinfo_picture` VALUES ('2727', 'CertificatePhotos/359.jpg', 'CertificatePhotosFace/359.jpg', 'VoicePlayback/359.mp3', 'bee453ce-ab37-4540-adfa-c3c6760d170c');
INSERT INTO `sys_userinfo_picture` VALUES ('2728', 'CertificatePhotos/360.jpg', 'CertificatePhotosFace/360.jpg', 'VoicePlayback/360.mp3', 'f1b4c8b8-5134-415f-bfa5-bdc18928ce7d');
INSERT INTO `sys_userinfo_picture` VALUES ('2729', 'CertificatePhotos/361.jpg', 'CertificatePhotosFace/361.jpg', 'VoicePlayback/361.mp3', 'b988fd93-e102-4bed-a50a-412cee7df088');
INSERT INTO `sys_userinfo_picture` VALUES ('2730', 'CertificatePhotos/362.jpg', 'CertificatePhotosFace/362.jpg', 'VoicePlayback/362.mp3', '62544f61-95a4-465c-a7bf-85bf86dad349');
INSERT INTO `sys_userinfo_picture` VALUES ('2731', 'CertificatePhotos/363.jpg', 'CertificatePhotosFace/363.jpg', 'VoicePlayback/363.mp3', '6610fdcb-9f57-4960-a86b-2f44b8c7c89c');
INSERT INTO `sys_userinfo_picture` VALUES ('2732', 'CertificatePhotos/364.jpg', 'CertificatePhotosFace/364.jpg', 'VoicePlayback/364.mp3', '032ebf5d-e46f-4e3b-86a8-e6eade4213ca');
INSERT INTO `sys_userinfo_picture` VALUES ('2733', 'CertificatePhotos/365.jpg', 'CertificatePhotosFace/365.jpg', 'VoicePlayback/365.mp3', '8a27a89e-20c7-418d-9c4f-0aab0ff4f4ab');
INSERT INTO `sys_userinfo_picture` VALUES ('2734', 'CertificatePhotos/366.jpg', 'CertificatePhotosFace/366.jpg', 'VoicePlayback/366.mp3', 'c0e5d08f-321b-41ce-83a6-60ccf1b28174');
INSERT INTO `sys_userinfo_picture` VALUES ('2735', 'CertificatePhotos/367.jpg', 'CertificatePhotosFace/367.jpg', 'VoicePlayback/367.mp3', '5cb7db49-cd2d-4afd-aeaf-34315f0dd647');
INSERT INTO `sys_userinfo_picture` VALUES ('2736', 'CertificatePhotos/368.jpg', 'CertificatePhotosFace/368.jpg', 'VoicePlayback/368.mp3', '10c6e61d-2dc3-4225-a188-75ae28383a0f');
INSERT INTO `sys_userinfo_picture` VALUES ('2737', 'CertificatePhotos/369.jpg', 'CertificatePhotosFace/369.jpg', 'VoicePlayback/369.mp3', '27dc726b-63c3-454e-a21c-4660bef317ad');
INSERT INTO `sys_userinfo_picture` VALUES ('2738', 'CertificatePhotos/370.jpg', 'CertificatePhotosFace/370.jpg', 'VoicePlayback/370.mp3', 'c1239e9e-ca7c-4fc6-ba74-91466233a777');
INSERT INTO `sys_userinfo_picture` VALUES ('2739', 'CertificatePhotos/371.jpg', 'CertificatePhotosFace/371.jpg', 'VoicePlayback/371.mp3', 'a26a0173-422d-465a-87da-9a2cf0771480');
INSERT INTO `sys_userinfo_picture` VALUES ('2740', 'CertificatePhotos/372.jpg', 'CertificatePhotosFace/372.jpg', 'VoicePlayback/372.mp3', '32689d93-8ae4-4220-a622-f5ef6dcdd092');
INSERT INTO `sys_userinfo_picture` VALUES ('2741', 'CertificatePhotos/373.jpg', 'CertificatePhotosFace/373.jpg', 'VoicePlayback/373.mp3', '9c6afe9e-350d-4df7-9726-568c8e6b263b');
INSERT INTO `sys_userinfo_picture` VALUES ('2742', 'CertificatePhotos/374.jpg', 'CertificatePhotosFace/374.jpg', 'VoicePlayback/374.mp3', '71d5ee21-ca61-4ff2-98d0-4ebc50eec243');
INSERT INTO `sys_userinfo_picture` VALUES ('2743', 'CertificatePhotos/375_431.jpg', 'CertificatePhotosFace/375_431.jpg', 'VoicePlayback/375.mp3', '84899fde-9c5e-43ae-80e9-540fcb66b649');
INSERT INTO `sys_userinfo_picture` VALUES ('2744', 'CertificatePhotos/376_233.jpg', 'CertificatePhotosFace/376_233.jpg', '', 'f59a1a47-d9ef-4b05-911f-a351a5014741');
INSERT INTO `sys_userinfo_picture` VALUES ('2745', 'CertificatePhotos/377_462.jpg', 'CertificatePhotosFace/377_462.jpg', '', '7bed7551-cb5a-42df-aa40-afe62d9e1a8e');
INSERT INTO `sys_userinfo_picture` VALUES ('2746', 'CertificatePhotos/378_106.jpg', 'CertificatePhotosFace/378_106.jpg', '', '5004f1e3-fac2-41e1-b71a-4eaf585614b7');
INSERT INTO `sys_userinfo_picture` VALUES ('2747', 'CertificatePhotos/379_765.jpg', 'CertificatePhotosFace/379_765.jpg', '', '8028faae-0375-4015-80d4-52758c1748b6');
INSERT INTO `sys_userinfo_picture` VALUES ('2748', 'CertificatePhotos/380.jpg', 'CertificatePhotosFace/380.jpg', '', 'fbd5ed16-c280-4155-b2a3-cee037954fff');
INSERT INTO `sys_userinfo_picture` VALUES ('2749', 'CertificatePhotos/381_855.jpg', 'CertificatePhotosFace/381_855.jpg', '', 'eb499f40-2ea4-4441-b780-75f824e1a09f');
INSERT INTO `sys_userinfo_picture` VALUES ('2750', 'CertificatePhotos/382_664.jpg', 'CertificatePhotosFace/382_664.jpg', '', '1ed01665-b0c3-44e7-9d83-5b5e52db6ba5');
INSERT INTO `sys_userinfo_picture` VALUES ('2751', 'CertificatePhotos/383_838.jpg', 'CertificatePhotosFace/383_838.jpg', '', '0e5cabd6-eda9-44c8-b3f2-6745545f9c51');
INSERT INTO `sys_userinfo_picture` VALUES ('2752', 'CertificatePhotos/384_875.jpg', 'CertificatePhotosFace/384_875.jpg', '', 'd5fb5f76-4221-4032-8e6a-2963ec8202e4');
INSERT INTO `sys_userinfo_picture` VALUES ('2753', 'CertificatePhotos/385_734.jpg', 'CertificatePhotosFace/385_734.jpg', '', 'cacacc9e-f008-426b-8dd1-4fd5d0b25871');
INSERT INTO `sys_userinfo_picture` VALUES ('2754', 'CertificatePhotos/386_349.jpg', 'CertificatePhotosFace/386_349.jpg', '', 'b8027dd0-1e45-489e-b89f-0a3d521cc973');
INSERT INTO `sys_userinfo_picture` VALUES ('2755', 'CertificatePhotos/387_534.jpg', 'CertificatePhotosFace/387_534.jpg', '', '973fadda-b356-4050-81ef-fba3b3542b02');
INSERT INTO `sys_userinfo_picture` VALUES ('2756', 'CertificatePhotos/388_957.jpg', 'CertificatePhotosFace/388_957.jpg', '', '70a3832b-8e0d-4aff-b650-487c1e5c2ed4');
INSERT INTO `sys_userinfo_picture` VALUES ('2757', 'CertificatePhotos/389_603.jpg', 'CertificatePhotosFace/389_603.jpg', '', '984c296c-9bd6-400b-8c40-ae85ffb130f9');
INSERT INTO `sys_userinfo_picture` VALUES ('2758', 'CertificatePhotos/390_908.jpg', 'CertificatePhotosFace/390_908.jpg', '', '54b0af78-8a94-4826-a52c-5934e7e8fbfa');
INSERT INTO `sys_userinfo_picture` VALUES ('2759', 'CertificatePhotos/391_652.jpg', 'CertificatePhotosFace/391_652.jpg', '', '8efa637c-83a3-4fa2-9bbe-c2abc083a344');
INSERT INTO `sys_userinfo_picture` VALUES ('2760', 'CertificatePhotos/393_937.jpg', 'CertificatePhotosFace/393_937.jpg', '', '48199f64-ace4-43ad-85a6-18c8d5e6289a');
INSERT INTO `sys_userinfo_picture` VALUES ('2761', 'CertificatePhotos/394_196.jpg', 'CertificatePhotosFace/394_196.jpg', '', 'a0a7ce18-6326-4009-8901-e2f955aad36d');
INSERT INTO `sys_userinfo_picture` VALUES ('2762', 'CertificatePhotos/395_404.jpg', 'CertificatePhotosFace/395_404.jpg', '', '120ff6a8-ba62-4a9b-8f0b-0de8b8325656');
INSERT INTO `sys_userinfo_picture` VALUES ('2763', 'CertificatePhotos/396_801.jpg', 'CertificatePhotosFace/396_801.jpg', '', 'f75eb1bb-4249-463e-9b79-2c44f129fe08');
INSERT INTO `sys_userinfo_picture` VALUES ('2764', 'CertificatePhotos/397_713.jpg', 'CertificatePhotosFace/397_713.jpg', '', 'b0e1912b-0bad-47c6-b991-f2505fb22262');
INSERT INTO `sys_userinfo_picture` VALUES ('2765', 'CertificatePhotos/398_297.jpg', 'CertificatePhotosFace/398_297.jpg', '', '6c74e824-7915-461c-bd3d-af749a325555');
INSERT INTO `sys_userinfo_picture` VALUES ('2766', 'CertificatePhotos/399_889.jpg', 'CertificatePhotosFace/399_889.jpg', '', 'd107f9ee-b35d-4c68-93cc-075b4941c66d');
INSERT INTO `sys_userinfo_picture` VALUES ('2767', 'CertificatePhotos/400_120.jpg', 'CertificatePhotosFace/400_120.jpg', '', '56578d45-fa48-45bb-b5a9-ad7475040737');
INSERT INTO `sys_userinfo_picture` VALUES ('2768', 'CertificatePhotos/401_913.jpg', 'CertificatePhotosFace/401_913.jpg', '', '08e59956-8bd7-42ae-b6c7-a393a48f4fce');
INSERT INTO `sys_userinfo_picture` VALUES ('2769', 'CertificatePhotos/402_908.jpg', 'CertificatePhotosFace/402_908.jpg', '', 'e9fc0da3-9869-4800-8122-7398c87c9312');
INSERT INTO `sys_userinfo_picture` VALUES ('2770', 'CertificatePhotos/403_605.jpg', 'CertificatePhotosFace/403_605.jpg', '', '8c649a9d-4670-4d30-8b99-e9736f8659ee');
INSERT INTO `sys_userinfo_picture` VALUES ('2771', 'CertificatePhotos/404_781.jpg', 'CertificatePhotosFace/404_781.jpg', '', 'dce0e7a4-39cc-43c7-99d2-8cd64c95165e');
INSERT INTO `sys_userinfo_picture` VALUES ('2772', 'CertificatePhotos/405_35.jpg', 'CertificatePhotosFace/405_35.jpg', '', '1b1deb35-5d83-4c6d-bcf7-68f08c7f3e47');
INSERT INTO `sys_userinfo_picture` VALUES ('2773', 'CertificatePhotos/406_794.jpg', 'CertificatePhotosFace/406_794.jpg', '', 'de5f0d9e-27e1-44a3-a6cc-def193552aff');
INSERT INTO `sys_userinfo_picture` VALUES ('2774', 'CertificatePhotos/407_196.jpg', 'CertificatePhotosFace/407_196.jpg', '', '17486962-abd1-4a7c-bb0e-866a8e6888b9');
INSERT INTO `sys_userinfo_picture` VALUES ('2775', 'CertificatePhotos/408_423.jpg', 'CertificatePhotosFace/408_423.jpg', '', '97a25117-8aef-474b-aeda-11b8db13e6ab');
INSERT INTO `sys_userinfo_picture` VALUES ('2776', 'CertificatePhotos/409_233.jpg', 'CertificatePhotosFace/409_233.jpg', '', 'e0941d67-938b-4d07-86b6-f6ae0853c1f7');
INSERT INTO `sys_userinfo_picture` VALUES ('2777', 'CertificatePhotos/410_546.jpg', 'CertificatePhotosFace/410_546.jpg', '', 'fe92e6eb-6763-4fe5-87c9-8405276aa8e8');
INSERT INTO `sys_userinfo_picture` VALUES ('2778', 'CertificatePhotos/411_508.jpg', 'CertificatePhotosFace/411_508.jpg', '', 'd3fbcf95-c46a-48ca-a644-a15fea14492f');
INSERT INTO `sys_userinfo_picture` VALUES ('2779', 'CertificatePhotos/412_327.jpg', 'CertificatePhotosFace/412_327.jpg', '', 'fb9d81db-4bb6-4e9c-930b-a0d034e0523b');
INSERT INTO `sys_userinfo_picture` VALUES ('2780', 'CertificatePhotos/413_43.jpg', 'CertificatePhotosFace/413_43.jpg', '', '17f54da7-4ff0-4c89-9673-138b189d245b');
INSERT INTO `sys_userinfo_picture` VALUES ('2781', 'CertificatePhotos/414_946.jpg', 'CertificatePhotosFace/414_946.jpg', '', '7b0034f9-74b2-481e-a95a-0ae604d6da56');
INSERT INTO `sys_userinfo_picture` VALUES ('2782', 'CertificatePhotos/415_606.jpg', 'CertificatePhotosFace/415_606.jpg', '', '21899a97-24b2-4c37-af4b-088bf3489d57');
INSERT INTO `sys_userinfo_picture` VALUES ('2783', 'CertificatePhotos/416_58.jpg', 'CertificatePhotosFace/416_58.jpg', '', 'ce58a9d6-a707-4c9f-84b0-93e0eb3f8abb');
INSERT INTO `sys_userinfo_picture` VALUES ('2784', 'CertificatePhotos/417_79.jpg', 'CertificatePhotosFace/417_79.jpg', '', 'ce447f0d-5535-4cc4-896a-1f6238be9876');
INSERT INTO `sys_userinfo_picture` VALUES ('2785', 'CertificatePhotos/418_20.jpg', 'CertificatePhotosFace/418_20.jpg', '', '13c77385-8465-4c6f-832d-ad2737f38441');
INSERT INTO `sys_userinfo_picture` VALUES ('2786', 'CertificatePhotos/419_457.jpg', 'CertificatePhotosFace/419_457.jpg', '', '61d725bc-ae37-4bfb-9a09-3d63fa5f5f45');
INSERT INTO `sys_userinfo_picture` VALUES ('2787', 'CertificatePhotos/420_755.jpg', 'CertificatePhotosFace/420_755.jpg', '', '6f039f0b-e314-43da-9dc0-015a79329c8b');
INSERT INTO `sys_userinfo_picture` VALUES ('2788', 'CertificatePhotos/421_889.jpg', 'CertificatePhotosFace/421_889.jpg', '', 'c40a9813-a9cb-4cb7-abbd-d4acd51b645d');
INSERT INTO `sys_userinfo_picture` VALUES ('2789', 'CertificatePhotos/422_35.jpg', 'CertificatePhotosFace/422_35.jpg', '', 'e9e0e91b-98b3-42d6-b57c-cbd6ec309f88');
INSERT INTO `sys_userinfo_picture` VALUES ('2790', 'CertificatePhotos/423_85.jpg', 'CertificatePhotosFace/423_85.jpg', '', '90753d02-8b11-4411-bd7f-0a7595ae642b');
INSERT INTO `sys_userinfo_picture` VALUES ('2791', 'CertificatePhotos/424_833.jpg', 'CertificatePhotosFace/424_833.jpg', '', 'd6846068-5b2e-4b62-931e-8123436f9078');
INSERT INTO `sys_userinfo_picture` VALUES ('2792', 'CertificatePhotos/425_740.jpg', 'CertificatePhotosFace/425_740.jpg', '', '4663716e-a39a-4312-b960-95167d821549');
INSERT INTO `sys_userinfo_picture` VALUES ('2793', 'CertificatePhotos/426_774.jpg', 'CertificatePhotosFace/426_774.jpg', '', '7d56423a-80f3-4969-a746-63fdbe7d14ac');
INSERT INTO `sys_userinfo_picture` VALUES ('2794', 'CertificatePhotos/427_8.jpg', 'CertificatePhotosFace/427_8.jpg', '', 'cd4fa236-8b57-4feb-9241-da8adc148744');
INSERT INTO `sys_userinfo_picture` VALUES ('2795', 'CertificatePhotos/428_532.jpg', 'CertificatePhotosFace/428_532.jpg', '', '763e4897-5c87-4a9b-b133-72f4a2608fc8');
INSERT INTO `sys_userinfo_picture` VALUES ('2796', 'CertificatePhotos/429_553.jpg', 'CertificatePhotosFace/429_553.jpg', '', '0c74bf37-f625-4bfd-b3cd-3c0aad7f8199');
INSERT INTO `sys_userinfo_picture` VALUES ('2797', 'CertificatePhotos/430_478.jpg', 'CertificatePhotosFace/430_478.jpg', '', 'c499ac6c-dae9-4062-b873-c5bc4ec55d61');
INSERT INTO `sys_userinfo_picture` VALUES ('2798', 'CertificatePhotos/431_767.jpg', 'CertificatePhotosFace/431_767.jpg', '', 'e8494699-5cbb-429f-ba93-9fc76417d951');
INSERT INTO `sys_userinfo_picture` VALUES ('2799', 'CertificatePhotos/432_226.jpg', 'CertificatePhotosFace/432_226.jpg', '', '79ddcc09-4118-4d51-a1f8-90d4889942c7');
INSERT INTO `sys_userinfo_picture` VALUES ('2800', 'CertificatePhotos/433_605.jpg', 'CertificatePhotosFace/433_605.jpg', '', 'd4e1a3fd-ec26-4721-9f63-1b254b2d14c1');
INSERT INTO `sys_userinfo_picture` VALUES ('2801', 'CertificatePhotos/434_920.jpg', 'CertificatePhotosFace/434_920.jpg', '', 'c07ba7f0-dacf-4afd-abba-941b701ae030');
INSERT INTO `sys_userinfo_picture` VALUES ('2802', 'CertificatePhotos/435_474.jpg', 'CertificatePhotosFace/435_474.jpg', '', '4430a2d5-1fe3-4a4a-84e5-01f553bc239d');
INSERT INTO `sys_userinfo_picture` VALUES ('2803', 'CertificatePhotos/436_543.jpg', 'CertificatePhotosFace/436_543.jpg', '', '981e715e-4f0c-4649-b930-88afc52ab5d4');
INSERT INTO `sys_userinfo_picture` VALUES ('2804', 'CertificatePhotos/437_188.jpg', 'CertificatePhotosFace/437_188.jpg', '', '25abf145-8e65-49f2-bd78-242adec97010');
INSERT INTO `sys_userinfo_picture` VALUES ('2805', 'CertificatePhotos/438_142.jpg', 'CertificatePhotosFace/438_142.jpg', '', '7580b02a-337e-48d7-a6b6-9d47967b79e7');
INSERT INTO `sys_userinfo_picture` VALUES ('2806', 'CertificatePhotos/439_336.jpg', 'CertificatePhotosFace/439_336.jpg', '', '8bafd641-3018-4cc8-a750-5f3449013a6a');
INSERT INTO `sys_userinfo_picture` VALUES ('2807', 'CertificatePhotos/440_756.jpg', 'CertificatePhotosFace/440_756.jpg', '', '009e1925-765c-408d-8f3d-520d3bb94f21');
INSERT INTO `sys_userinfo_picture` VALUES ('2808', 'CertificatePhotos/441_697.jpg', 'CertificatePhotosFace/441_697.jpg', '', 'ac6c54d8-8292-47ec-b722-6eb45009a867');
INSERT INTO `sys_userinfo_picture` VALUES ('2809', 'CertificatePhotos/442_278.jpg', 'CertificatePhotosFace/442_278.jpg', '', '93c95a87-0d32-4e33-8a7e-083e83679084');
INSERT INTO `sys_userinfo_picture` VALUES ('2810', 'CertificatePhotos/443_188.jpg', 'CertificatePhotosFace/443_188.jpg', '', '5d77a3fe-2dcf-4877-b6b7-2d564ae5d4cc');
INSERT INTO `sys_userinfo_picture` VALUES ('2811', 'CertificatePhotos/444_919.jpg', 'CertificatePhotosFace/444_919.jpg', '', '4563935f-5366-4691-8665-08a8aa7fa609');
INSERT INTO `sys_userinfo_picture` VALUES ('2812', 'CertificatePhotos/445_380.jpg', 'CertificatePhotosFace/445_380.jpg', '', '7d864416-361e-47fe-a6b8-6a4a8251030f');
INSERT INTO `sys_userinfo_picture` VALUES ('2813', 'CertificatePhotos/446_322.jpg', 'CertificatePhotosFace/446_322.jpg', '', '23739e26-c064-4e9d-8a92-c698b3e9a726');
INSERT INTO `sys_userinfo_picture` VALUES ('2814', 'CertificatePhotos/447_529.jpg', 'CertificatePhotosFace/447_529.jpg', '', '3a092873-1cf0-4026-aff7-a91095d5dc23');
INSERT INTO `sys_userinfo_picture` VALUES ('2815', 'CertificatePhotos/448_688.jpg', 'CertificatePhotosFace/448_688.jpg', '', '0bfc7de7-bc20-45c3-878f-ac9327b566f4');
INSERT INTO `sys_userinfo_picture` VALUES ('2816', 'CertificatePhotos/449_373.jpg', 'CertificatePhotosFace/449_373.jpg', '', '0a351277-9ddf-4121-abe0-ec5473e80132');
INSERT INTO `sys_userinfo_picture` VALUES ('2817', 'CertificatePhotos/450_808.jpg', 'CertificatePhotosFace/450_808.jpg', '', '23de3be0-2b1d-42cb-9392-24bca01fb6d7');
INSERT INTO `sys_userinfo_picture` VALUES ('2818', 'CertificatePhotos/451_854.jpg', 'CertificatePhotosFace/451_854.jpg', '', 'ebd0cda6-f6fd-48d0-a64f-b36f9fdcd8c0');
INSERT INTO `sys_userinfo_picture` VALUES ('2819', 'CertificatePhotos/452_259.jpg', 'CertificatePhotosFace/452_259.jpg', '', '47d6ea80-640e-4dc1-b149-3cdc7ef81a24');
INSERT INTO `sys_userinfo_picture` VALUES ('2820', 'CertificatePhotos/453_982.jpg', 'CertificatePhotosFace/453_982.jpg', null, '102242bc-793b-4c1a-b094-e4e707b3dae9');
INSERT INTO `sys_userinfo_picture` VALUES ('2821', 'CertificatePhotos/454_604.jpg', 'CertificatePhotosFace/454_604.jpg', null, '33f9a2d4-8c16-47b8-afa9-4d1ca008e6fd');
INSERT INTO `sys_userinfo_picture` VALUES ('2822', 'CertificatePhotos/455_394.jpg', 'CertificatePhotosFace/455_394.jpg', null, '34d73081-ed87-4f94-be00-3e5e58358bad');
INSERT INTO `sys_userinfo_picture` VALUES ('2823', 'CertificatePhotos/456_864.jpg', 'CertificatePhotosFace/456_864.jpg', null, '6ce40833-921a-4e1f-b7ae-ef576ba55ee1');
INSERT INTO `sys_userinfo_picture` VALUES ('2824', 'CertificatePhotos/457_397.jpg', 'CertificatePhotosFace/457_397.jpg', null, 'e7cde09c-97b9-413e-843e-9579b5524549');
INSERT INTO `sys_userinfo_picture` VALUES ('2825', 'CertificatePhotos/458_722.jpg', 'CertificatePhotosFace/458_722.jpg', null, 'ffb219ec-3306-479e-bafa-5821f3c75527');
INSERT INTO `sys_userinfo_picture` VALUES ('2826', 'CertificatePhotos/459_730.jpg', 'CertificatePhotosFace/459_730.jpg', null, '70166bbd-90f3-415f-95e7-cf15b1e73150');
INSERT INTO `sys_userinfo_picture` VALUES ('2827', 'CertificatePhotos/460_725.jpg', 'CertificatePhotosFace/460_725.jpg', null, 'bc027ec3-f5da-43f0-94d3-e45800761b24');
INSERT INTO `sys_userinfo_picture` VALUES ('2828', 'CertificatePhotos/461_111.jpg', 'CertificatePhotosFace/461_111.jpg', null, '056a0822-9f36-4941-bcd5-8abe28a27546');
INSERT INTO `sys_userinfo_picture` VALUES ('2829', 'CertificatePhotos/462_599.jpg', 'CertificatePhotosFace/462_599.jpg', null, '074c94d5-ca60-4c52-bdb8-c4d5ae0bd630');
INSERT INTO `sys_userinfo_picture` VALUES ('2831', 'CertificatePhotos/463_451.jpg', 'CertificatePhotosFace/463_451.jpg', null, 'b4103e99-e841-4fc4-8fce-e13fc40acdf9');
INSERT INTO `sys_userinfo_picture` VALUES ('2832', 'CertificatePhotos/464_289.jpg', 'CertificatePhotosFace/464_289.jpg', null, '71c13fb5-51a4-4149-92af-d7563cc7bc51');
INSERT INTO `sys_userinfo_picture` VALUES ('2833', 'CertificatePhotos/465_579.jpg', 'CertificatePhotosFace/465_579.jpg', null, 'cc340761-7cc3-47e6-b486-dc092af6615a');
INSERT INTO `sys_userinfo_picture` VALUES ('2834', 'CertificatePhotos/466_807.jpg', 'CertificatePhotosFace/466_807.jpg', null, '635d27ce-5b8b-427c-90a3-8082a3c49982');
INSERT INTO `sys_userinfo_picture` VALUES ('2835', 'CertificatePhotos/467_323.jpg', 'CertificatePhotosFace/467_323.jpg', null, '6ceefcec-0192-4b8e-9862-ff9759a61da2');
INSERT INTO `sys_userinfo_picture` VALUES ('2836', 'CertificatePhotos/468_38.jpg', 'CertificatePhotosFace/468_38.jpg', null, '4c62dd3b-3c38-4a06-b559-d3c7a26c2638');
INSERT INTO `sys_userinfo_picture` VALUES ('2837', 'CertificatePhotos/469_345.jpg', 'CertificatePhotosFace/469_345.jpg', null, 'bcd8ea64-5390-4693-85e7-9fab6ab8df85');
INSERT INTO `sys_userinfo_picture` VALUES ('2838', 'CertificatePhotos/470_490.jpg', 'CertificatePhotosFace/470_490.jpg', null, '67fbadd6-ef18-4c5d-8f48-51f592386d85');
INSERT INTO `sys_userinfo_picture` VALUES ('2839', 'CertificatePhotos/471_746.jpg', 'CertificatePhotosFace/471_746.jpg', null, '62250183-1df5-4f64-8d14-a003dc2f9497');
INSERT INTO `sys_userinfo_picture` VALUES ('2840', 'CertificatePhotos/472_379.jpg', 'CertificatePhotosFace/472_379.jpg', null, '1d9734c2-5ea7-4ebd-8f3d-398b4060a592');
INSERT INTO `sys_userinfo_picture` VALUES ('2841', 'CertificatePhotos/473_896.jpg', 'CertificatePhotosFace/473_896.jpg', null, '167e82cc-bf9b-4bb4-908d-679b356d4aef');
INSERT INTO `sys_userinfo_picture` VALUES ('2842', 'CertificatePhotos/474_760.jpg', 'CertificatePhotosFace/474_760.jpg', null, '2292121f-83df-4798-8205-0ce2c59dfec2');
INSERT INTO `sys_userinfo_picture` VALUES ('2843', 'CertificatePhotos/475_467.jpg', 'CertificatePhotosFace/475_467.jpg', null, '5897bc72-c3cd-4833-83a7-adb9057c178b');
INSERT INTO `sys_userinfo_picture` VALUES ('2844', 'CertificatePhotos/476_234.jpg', 'CertificatePhotosFace/476_234.jpg', null, '55c1a315-cdc0-45f0-bcfd-678106834985');
INSERT INTO `sys_userinfo_picture` VALUES ('2845', 'CertificatePhotos/477_840.jpg', 'CertificatePhotosFace/477_840.jpg', null, '7438eeaf-2e36-40bb-b3dd-81909b44ba0a');
INSERT INTO `sys_userinfo_picture` VALUES ('2846', 'CertificatePhotos/478_735.jpg', 'CertificatePhotosFace/478_735.jpg', null, '29f9ba43-176b-4361-afcc-b8efff79a60a');
INSERT INTO `sys_userinfo_picture` VALUES ('2847', 'CertificatePhotos/479_109.jpg', 'CertificatePhotosFace/479_109.jpg', null, '95b1a20a-f072-499a-acf8-227223667b19');
INSERT INTO `sys_userinfo_picture` VALUES ('2848', 'CertificatePhotos/480_274.jpg', 'CertificatePhotosFace/480_274.jpg', null, '7af28ac8-9c4d-4c01-96db-304feabf6865');
INSERT INTO `sys_userinfo_picture` VALUES ('2849', 'CertificatePhotos/481_11.jpg', 'CertificatePhotosFace/481_11.jpg', null, '5a0449a5-9910-43ce-9624-280d8806a0e5');
INSERT INTO `sys_userinfo_picture` VALUES ('2850', 'CertificatePhotos/482_489.jpg', 'CertificatePhotosFace/482_489.jpg', null, 'efb90130-0c4f-4f19-b5ab-51f45d5e1a36');
INSERT INTO `sys_userinfo_picture` VALUES ('2851', 'CertificatePhotos/483_925.jpg', 'CertificatePhotosFace/483_925.jpg', null, '495769be-7783-4319-90ad-3590371eaf42');
INSERT INTO `sys_userinfo_picture` VALUES ('2852', 'CertificatePhotos/484_200.jpg', 'CertificatePhotosFace/484_200.jpg', null, '7991913b-6120-4960-922a-c88dc4467d05');
INSERT INTO `sys_userinfo_picture` VALUES ('2853', 'CertificatePhotos/485_246.jpg', 'CertificatePhotosFace/485_246.jpg', null, '492dde2b-ead4-4eb4-b9ac-b8fbc4fcf883');
INSERT INTO `sys_userinfo_picture` VALUES ('2854', 'CertificatePhotos/486_872.jpg', 'CertificatePhotosFace/486_872.jpg', null, 'fbafc567-b57e-4389-9358-d2e55b8c7a17');
INSERT INTO `sys_userinfo_picture` VALUES ('2855', 'CertificatePhotos/487_537.jpg', 'CertificatePhotosFace/487_537.jpg', null, '9ab891a3-804b-413c-a483-6484c39cbab3');
INSERT INTO `sys_userinfo_picture` VALUES ('2856', 'CertificatePhotos/488_760.jpg', 'CertificatePhotosFace/488_760.jpg', null, '054480f9-378c-472d-9229-bf7743acb94c');
INSERT INTO `sys_userinfo_picture` VALUES ('2857', 'CertificatePhotos/489_623.jpg', 'CertificatePhotosFace/489_623.jpg', null, '7ef3d6c4-ca0a-4625-8cbc-4d168c01e621');
INSERT INTO `sys_userinfo_picture` VALUES ('2858', 'CertificatePhotos/490_187.jpg', 'CertificatePhotosFace/490_187.jpg', null, '59b835e8-3380-4bf5-9672-a43f18ad2b79');
INSERT INTO `sys_userinfo_picture` VALUES ('2859', 'CertificatePhotos/491_987.jpg', 'CertificatePhotosFace/491_987.jpg', null, '2daa2d4a-e52e-417d-b153-0afe3b1a5b23');
INSERT INTO `sys_userinfo_picture` VALUES ('2860', 'CertificatePhotos/492_149.jpg', 'CertificatePhotosFace/492_149.jpg', null, 'df6bc7e4-c08a-42ef-a085-25bd40d5bc95');
INSERT INTO `sys_userinfo_picture` VALUES ('2861', 'CertificatePhotos/493_882.jpg', 'CertificatePhotosFace/493_882.jpg', null, '03c5839a-37b0-4af4-ab38-09e02f7f14bd');
INSERT INTO `sys_userinfo_picture` VALUES ('2862', 'CertificatePhotos/494_676.jpg', 'CertificatePhotosFace/494_676.jpg', null, 'bffe18fa-4314-4a2a-9aad-56da8777d630');
INSERT INTO `sys_userinfo_picture` VALUES ('2863', 'CertificatePhotos/495_567.jpg', 'CertificatePhotosFace/495_567.jpg', null, '60886b4a-1614-4c35-8289-2e577e2a1aae');
INSERT INTO `sys_userinfo_picture` VALUES ('2864', 'CertificatePhotos/496_328.jpg', 'CertificatePhotosFace/496_328.jpg', null, '1f1321a1-62e3-4a58-9155-4adfdba4d061');
INSERT INTO `sys_userinfo_picture` VALUES ('2865', 'CertificatePhotos/497_583.jpg', 'CertificatePhotosFace/497_583.jpg', null, '28e7f958-f91f-4711-8f10-e284eb8f2f83');
INSERT INTO `sys_userinfo_picture` VALUES ('2866', 'CertificatePhotos/498_553.jpg', 'CertificatePhotosFace/498_553.jpg', null, '378a8de4-41d8-4a4f-89d2-28a2f359b68a');
INSERT INTO `sys_userinfo_picture` VALUES ('2877', 'CertificatePhotos/499_712.jpg', 'CertificatePhotosFace/499_712.jpg', null, '6f15e12c-0c0d-42f2-9ce3-4c9be490028e');
INSERT INTO `sys_userinfo_picture` VALUES ('2880', 'CertificatePhotos/501_758.jpg', 'CertificatePhotosFace/501_758.jpg', null, 'acdf8d85-8e6f-4d39-aea1-18e8bbb99336');
INSERT INTO `sys_userinfo_picture` VALUES ('2881', 'CertificatePhotos/502_366.jpg', 'CertificatePhotosFace/502_366.jpg', null, 'f0f46d12-3781-4f6e-9844-f4026877bb13');
INSERT INTO `sys_userinfo_picture` VALUES ('2882', 'CertificatePhotos/503_168.jpg', 'CertificatePhotosFace/503_168.jpg', null, 'bb6352f3-3315-4dd1-b78c-3e5d6e2a5b5f');
INSERT INTO `sys_userinfo_picture` VALUES ('2883', 'CertificatePhotos/504_713.jpg', 'CertificatePhotosFace/504_713.jpg', null, '6b74c177-40a4-4844-ae6e-826501eded97');
INSERT INTO `sys_userinfo_picture` VALUES ('2884', 'CertificatePhotos/505_95.jpg', 'CertificatePhotosFace/505_95.jpg', null, '4713910e-9d91-477a-9fb2-45cff76b67ce');
INSERT INTO `sys_userinfo_picture` VALUES ('2885', 'CertificatePhotos/506_627.jpg', 'CertificatePhotosFace/506_627.jpg', null, 'c06dcaeb-2fc9-4f2f-9752-48506f75a16f');
INSERT INTO `sys_userinfo_picture` VALUES ('2889', 'CertificatePhotos/507_304.jpg', 'CertificatePhotosFace/507_304.jpg', null, '937a4d55-7089-4ffa-b0b5-0a4241f72ce8');
INSERT INTO `sys_userinfo_picture` VALUES ('2890', 'CertificatePhotos/508_957.jpg', 'CertificatePhotosFace/508_957.jpg', null, '9abbf31e-6897-4f53-8b6a-1e11b54c6d14');
INSERT INTO `sys_userinfo_picture` VALUES ('2891', 'CertificatePhotos/509_430.jpg', 'CertificatePhotosFace/509_430.jpg', null, '8d953d4c-aba1-45b1-b6db-1d89e973b8b2');
INSERT INTO `sys_userinfo_picture` VALUES ('2892', 'CertificatePhotos/510_509.jpg', 'CertificatePhotosFace/510_509.jpg', null, '02caf176-7594-4aee-a9c8-ae91f4415fbd');
INSERT INTO `sys_userinfo_picture` VALUES ('2893', 'CertificatePhotos/511_877.jpg', 'CertificatePhotosFace/511_877.jpg', null, 'd6a9c0f2-2fbb-487f-a034-07cafba9b03b');
INSERT INTO `sys_userinfo_picture` VALUES ('2894', 'CertificatePhotos/512_113.jpg', 'CertificatePhotosFace/512_113.jpg', null, 'e25d89b0-0972-4f53-9104-2e3b967eb79d');
INSERT INTO `sys_userinfo_picture` VALUES ('2898', 'CertificatePhotos/513_574.jpg', 'CertificatePhotosFace/513_574.jpg', null, '2352f17c-5dc3-4f57-9cb1-310e70bc18e3');
INSERT INTO `sys_userinfo_picture` VALUES ('2899', 'CertificatePhotos/514_660.jpg', 'CertificatePhotosFace/514_660.jpg', null, 'a7f51904-322d-40f1-92ba-0424e2381913');
INSERT INTO `sys_userinfo_picture` VALUES ('2900', 'CertificatePhotos/515_522.jpg', 'CertificatePhotosFace/515_522.jpg', null, 'fce07c27-aace-4ee8-b27f-4819b5ee7d19');
INSERT INTO `sys_userinfo_picture` VALUES ('2901', 'CertificatePhotos/516_322.jpg', 'CertificatePhotosFace/516_322.jpg', null, '2c4eb3d9-5390-4869-8a47-bbfc24a995b9');

-- ----------------------------
-- Table structure for `tbl_arithmetic_info`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_arithmetic_info`;
CREATE TABLE `tbl_arithmetic_info` (
  `id` int(11) NOT NULL,
  `camid` varchar(512) NOT NULL,
  `arithmeticStr` varchar(16) NOT NULL COMMENT '算法中文名',
  `arithmeticInt` int(11) NOT NULL,
  `sensitiveness` varchar(50) NOT NULL COMMENT '灵敏度、阈值',
  `area` varchar(512) DEFAULT NULL COMMENT '设置详情',
  `worktime` varchar(100) NOT NULL,
  `hmin` varchar(20) DEFAULT NULL COMMENT '精度',
  `serviceid` int(11) DEFAULT NULL,
  `camtype` int(11) DEFAULT NULL COMMENT '1、相机，2视频文件',
  KEY `NewIndex1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_arithmetic_info
-- ----------------------------
INSERT INTO `tbl_arithmetic_info` VALUES ('2', 'E:36.avi', '闯入', '0', '10', '<?xml version=\"1.0\" encoding=\"UTF-8\"?><mission type=\"0\"><vertex>474,342;604,284;63,85;226,104;</vertex><sensitivity requency_threshold=\"10\" /></mission>', '', '0.04', null, '2');
INSERT INTO `tbl_arithmetic_info` VALUES ('7', 'E:/workprogram/VideoIntelligentAnalysis/36.avi', '闯出', '1', '10', '<?xml version=\"1.0\" encoding=\"UTF-8\"?><mission type=\"1\"><vertex>419,220;891,214;852,578;79,446;</vertex><sensitivity requency_threshold=\"10\" /></mission>', '', '0.04', null, '2');
INSERT INTO `tbl_arithmetic_info` VALUES ('8', 'E:/workprogram/VideoIntelligentAnalysis/36.avi', '闯入', '0', '10', '<?xml version=\"1.0\" encoding=\"UTF-8\"?><mission type=\"0\"><vertex>219,240;922,146;868,570;178,532;</vertex><sensitivity requency_threshold=\"10\" /></mission>', '', '0.04', null, '2');
INSERT INTO `tbl_arithmetic_info` VALUES ('9', 'E:/workprogram/VideoIntelligentAnalysis/36.avi', '闯入', '0', '10', '<?xml version=\"1.0\" encoding=\"UTF-8\"?><mission type=\"0\"><vertex>401,327;1324,262;744,688;</vertex><sensitivity requency_threshold=\"10\" /></mission>', '', '0.04', null, '2');
INSERT INTO `tbl_arithmetic_info` VALUES ('10', 'E:/36.avi', '闯出', '1', '10', '<?xml version=\"1.0\" encoding=\"UTF-8\"?><mission type=\"1\"><vertex>569,478;1716,369;1839,906;438,980;</vertex><sensitivity requency_threshold=\"10\" /></mission>', '', '0.04', null, '2');
INSERT INTO `tbl_arithmetic_info` VALUES ('11', 'E:/workprogram/VideoIntelligentAnalysis/01.mp4', '双绊线', '6', '10', '<?xml version=\"1.0\" encoding=\"UTF-8\"?><mission type=\"6\"><vertex>106,206;515,143;194,372;628,313;</vertex><sensitivity requency_threshold=\"10\" /></mission>', '', '0.04', null, '2');
INSERT INTO `tbl_arithmetic_info` VALUES ('12', '76', '闯入', '0', '10', '<?xml version=\"1.0\" encoding=\"UTF-8\"?><mission type=\"0\"><vertex>305,343;1142,241;1364,790;490,944;</vertex><sensitivity requency_threshold=\"10\" /></mission>', '', '0.04', null, '1');
INSERT INTO `tbl_arithmetic_info` VALUES ('13', '76', '聚众', '4', '10', '<?xml version=\"1.0\" encoding=\"UTF-8\"?><mission type=\"4\"><vertex>411,357;1246,238;1310,830;587,908;</vertex><sensitivity requency_threshold=\"10\" level_1=\"0.5\" level_2=\"0.7\" level_3=\"0.9\" /></mission>', '', '0.04', null, '1');
INSERT INTO `tbl_arithmetic_info` VALUES ('14', 'E:/workprogram/VideoIntelligentAnalysis/36.avi', '奔跑', '8', '10', '<?xml version=\"1.0\" encoding=\"UTF-8\"?><mission type=\"8\"><vertex>1087,330;1321,976;1138,1002;920,344;</vertex><sensitivity interval=\"5\" run_requency_threshold=\"10\" average_running_speed=\"2.5\" pixel_number_per_metre=\"80\" /></mission>', '', '0.04', null, '2');

-- ----------------------------
-- Table structure for `tbl_camera`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_camera`;
CREATE TABLE `tbl_camera` (
  `ResID` int(10) unsigned NOT NULL,
  `PtzType` int(11) DEFAULT NULL,
  `PositionType` int(11) DEFAULT NULL,
  `Alias` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `RoomType` int(11) DEFAULT NULL,
  `UseType` int(11) DEFAULT NULL,
  `SupplyLightType` int(11) DEFAULT NULL,
  `DirectionType` int(11) DEFAULT NULL,
  `Resolution` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `BusinessGroupID` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `DownLoadSpeed` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `SVCSpaceSupportMode` int(11) DEFAULT NULL,
  `SVCTimeSupportMode` int(11) DEFAULT NULL,
  `PtzURL` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `Height` double DEFAULT NULL,
  `PitchAngle` double DEFAULT NULL,
  `Azimuth` double DEFAULT NULL,
  `LockedUsr` int(11) DEFAULT NULL,
  `StreamingID` int(11) DEFAULT '0',
  `ReplayID` int(11) DEFAULT NULL,
  `GroupID` int(11) DEFAULT NULL,
  `PlaceID` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ResID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of tbl_camera
-- ----------------------------
INSERT INTO `tbl_camera` VALUES ('61894', '0', '0', '测试', '1', '0', '1', '0', null, null, null, '0', '0', null, '0', '0', '0', '0', '5', '0', '0', null);

-- ----------------------------
-- Table structure for `tbl_channel`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_channel`;
CREATE TABLE `tbl_channel` (
  `ChannelID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CamID` int(11) NOT NULL,
  `NVRID` int(11) NOT NULL,
  `NvrChannelID` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `FrameRate` int(11) DEFAULT NULL,
  `BitRateType` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `BitRate` int(11) DEFAULT NULL,
  `PlayUrl` varchar(200) COLLATE utf8_bin NOT NULL,
  `Resolution` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `AudioFlag` int(11) DEFAULT NULL,
  `AudioEncoderType` int(11) DEFAULT NULL,
  `AudioBitRate` int(11) DEFAULT NULL,
  `AudioSampleRate` int(11) DEFAULT NULL,
  `UseType` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ChannelID`)
) ENGINE=InnoDB AUTO_INCREMENT=34509 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of tbl_channel
-- ----------------------------
INSERT INTO `tbl_channel` VALUES ('34508', '61894', '61894', '1', '0', null, '0', 'TCP://1:0', null, '0', '0', '0', '0', '1');

-- ----------------------------
-- Table structure for `tbl_config`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_config`;
CREATE TABLE `tbl_config` (
  `configid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `configname` char(128) COLLATE utf8_bin NOT NULL,
  `configvalue` char(128) COLLATE utf8_bin NOT NULL,
  `serviceid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`configid`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of tbl_config
-- ----------------------------
INSERT INTO `tbl_config` VALUES ('1', 'HttpsPort', '8072', '1');
INSERT INTO `tbl_config` VALUES ('2', 'HttpsPort', '8000', '2');
INSERT INTO `tbl_config` VALUES ('3', 'UsrName', 'admin', '2');
INSERT INTO `tbl_config` VALUES ('4', 'Password', '111111', '2');
INSERT INTO `tbl_config` VALUES ('6', 'GB28181TcpPort', '9000', '2');
INSERT INTO `tbl_config` VALUES ('8', 'RtspPort', '554', '2');
INSERT INTO `tbl_config` VALUES ('10', 'HttpsPort', '8000', '4');
INSERT INTO `tbl_config` VALUES ('11', 'UsrName', 'admin', '4');
INSERT INTO `tbl_config` VALUES ('12', 'Password', '111111', '4');
INSERT INTO `tbl_config` VALUES ('14', 'GB28181TcpPort', '9000', '4');
INSERT INTO `tbl_config` VALUES ('16', 'RtspPort', '554', '4');
INSERT INTO `tbl_config` VALUES ('17', 'HttpsPort', '5066', '5');
INSERT INTO `tbl_config` VALUES ('19', 'HttpsPort', '8000', '6');
INSERT INTO `tbl_config` VALUES ('20', 'RtspPort', '554', '6');
INSERT INTO `tbl_config` VALUES ('21', 'GB28181TcpPort', '8001', '6');
INSERT INTO `tbl_config` VALUES ('22', 'UsrName', 'admin', '6');
INSERT INTO `tbl_config` VALUES ('23', 'Password', '111111', '6');
INSERT INTO `tbl_config` VALUES ('24', 'StorPath', 'D:', '2');
INSERT INTO `tbl_config` VALUES ('25', 'HttpsPort', '8000', '7');
INSERT INTO `tbl_config` VALUES ('26', 'UsrName', 'admin', '7');
INSERT INTO `tbl_config` VALUES ('27', 'Password', '111111', '7');
INSERT INTO `tbl_config` VALUES ('28', 'GB28181TcpPort', '9000', '7');
INSERT INTO `tbl_config` VALUES ('29', 'RtspPort', '554', '7');
INSERT INTO `tbl_config` VALUES ('35', 'StorPath', 'D:', '2');
INSERT INTO `tbl_config` VALUES ('45', 'HttpsPort', '8000', '12');
INSERT INTO `tbl_config` VALUES ('46', 'UsrName', 'admin', '12');
INSERT INTO `tbl_config` VALUES ('47', 'Password', '111111', '12');
INSERT INTO `tbl_config` VALUES ('48', 'GB28181TcpPort', '9000', '12');
INSERT INTO `tbl_config` VALUES ('49', 'RtspPort', '554', '12');
INSERT INTO `tbl_config` VALUES ('50', 'HttpsPort', '8000', '13');
INSERT INTO `tbl_config` VALUES ('51', 'UsrName', 'admin', '13');
INSERT INTO `tbl_config` VALUES ('52', 'Password', '111111', '13');
INSERT INTO `tbl_config` VALUES ('53', 'GB28181TcpPort', '9000', '13');
INSERT INTO `tbl_config` VALUES ('54', 'RtspPort', '554', '13');
INSERT INTO `tbl_config` VALUES ('55', 'HttpsPort', '5066', '14');
INSERT INTO `tbl_config` VALUES ('56', 'seafileIP', '192.168.5.127', '11');
INSERT INTO `tbl_config` VALUES ('57', 'seafilePort', '8000', '11');
INSERT INTO `tbl_config` VALUES ('58', 'HttpsPort', '8072', '15');
INSERT INTO `tbl_config` VALUES ('59', 'HttpsPort', '8000', '16');
INSERT INTO `tbl_config` VALUES ('60', 'UsrName', 'admin', '16');
INSERT INTO `tbl_config` VALUES ('61', 'Password', '111111', '16');
INSERT INTO `tbl_config` VALUES ('62', 'GB28181TcpPort', '9000', '16');
INSERT INTO `tbl_config` VALUES ('63', 'RtspPort', '554', '16');
INSERT INTO `tbl_config` VALUES ('80', 'RtspPort', '664', '17');
INSERT INTO `tbl_config` VALUES ('81', 'HttpsPort', '8000', '17');
INSERT INTO `tbl_config` VALUES ('82', 'GB28181TcpPort', '9000', '17');
INSERT INTO `tbl_config` VALUES ('83', 'StorPath', 'D:', '2');

-- ----------------------------
-- Table structure for `tbl_platform`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_platform`;
CREATE TABLE `tbl_platform` (
  `PlatformID` int(11) NOT NULL AUTO_INCREMENT,
  `PlatformName` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `IPAddress` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ProtocolType` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `PlatformPort` int(11) NOT NULL,
  `SipID` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `SipDomain` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `UpUsrName` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `UpPassword` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `UpRealm` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `DownUsrName` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `DownPassword` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `DownRealm` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SignalTransportType` int(11) DEFAULT NULL,
  `StreamTransportType` int(11) DEFAULT NULL,
  `UsrID` int(11) DEFAULT NULL,
  `Status` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'OFF',
  `ConnectState` int(11) DEFAULT NULL,
  `SipServiceID` int(11) DEFAULT NULL,
  `SubScribeInfo` int(11) DEFAULT NULL,
  `GbVersion` varchar(20) DEFAULT '2011',
  `StreamingID` int(11) DEFAULT '0',
  `ExtStreamingIP` varchar(32) DEFAULT '1',
  PRIMARY KEY (`PlatformID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_platform
-- ----------------------------
INSERT INTO `tbl_platform` VALUES ('1', '长峰139开发平台', '127.0.0.1', null, '5060', '11010102002005000139', '1101010200', null, '12345678', '1101010200', null, '12345678', '1101010200', '0', '0', null, 'OFF', '0', '5', null, '2016', '0', null);
INSERT INTO `tbl_platform` VALUES ('2', 'CentOS', '192.168.5.170', null, '5060', '11010800002005000026', '1101080000', 'admin', '12345678', '1101080000', null, '12345678', '1101080000', '0', '0', null, 'ON', '1', null, null, '2011', '0', '');
INSERT INTO `tbl_platform` VALUES ('3', '174', '192.168.5.170', null, '5060', '11000000002005000174', '1100000000', 'admin', '12345678', '1100000000', '11000000002005000174', '12345678', '1100000000', null, null, null, 'OFF', '2', '5', null, '2011', '0', '1');

-- ----------------------------
-- Table structure for `tbl_res_attr`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_res_attr`;
CREATE TABLE `tbl_res_attr` (
  `ResID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ProtocolType` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `DeviceID` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'Unknowm',
  `Manufacturer` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `Model` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `Owner` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `CivilCode` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Block` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `Address` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `Parental` int(11) DEFAULT NULL,
  `ParentID` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `SafetyWay` int(11) DEFAULT NULL,
  `RegisterWay` int(11) DEFAULT '1',
  `CertNum` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `Certifiable` int(11) DEFAULT NULL,
  `EndTime` datetime DEFAULT NULL,
  `Secrecy` int(11) DEFAULT '1',
  `IPAddress` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `Port` int(11) NOT NULL,
  `UsrName` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `Password` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `Status` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'ON',
  `Longitude` double DEFAULT NULL,
  `Latitude` double DEFAULT NULL,
  `PlatformID` int(10) NOT NULL DEFAULT '1',
  `ResType` int(11) DEFAULT NULL,
  `SipServiceID` int(11) DEFAULT NULL,
  `GuardFlag` int(11) DEFAULT NULL,
  `ErrCode` int(11) DEFAULT NULL,
  PRIMARY KEY (`ResID`),
  UNIQUE KEY `UniKey` (`DeviceID`)
) ENGINE=InnoDB AUTO_INCREMENT=61895 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_res_attr
-- ----------------------------
INSERT INTO `tbl_res_attr` VALUES ('61894', 'HIK', '341454277', '测试', 'HIK', 'HIK', '0', 'null', 'null', '测试', '0', 'null', null, '1', null, null, null, '0', '192.168.6.5', '8000', 'admin', 'admin12345', 'ON', null, null, '1', '132', '2', '0', null);

-- ----------------------------
-- Table structure for `tbl_service`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_service`;
CREATE TABLE `tbl_service` (
  `ServiceID` int(11) NOT NULL AUTO_INCREMENT,
  `ServiceType` int(11) NOT NULL,
  `IPAddress` varchar(50) COLLATE utf8_bin NOT NULL,
  `Status` varchar(10) COLLATE utf8_bin NOT NULL,
  `ServiceName` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ServiceID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of tbl_service
-- ----------------------------
INSERT INTO `tbl_service` VALUES ('2', '2', '192.168.5.213', 'ON', '转发服务');

-- ----------------------------
-- Table structure for `tbl_storfile`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_storfile`;
CREATE TABLE `tbl_storfile` (
  `AutoID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CamID` int(11) NOT NULL,
  `StreamingID` int(11) NOT NULL,
  `StartTime` datetime NOT NULL,
  `StopTime` datetime NOT NULL,
  `DeleteTime` datetime NOT NULL,
  `StorType` int(11) NOT NULL,
  `FilePath` varchar(300) NOT NULL,
  `Address` varchar(50) DEFAULT NULL,
  `Secrecy` int(11) NOT NULL DEFAULT '0',
  `RecorderID` varchar(50) NOT NULL DEFAULT '0',
  `FileSize` int(11) DEFAULT NULL,
  PRIMARY KEY (`AutoID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbl_storfile
-- ----------------------------

-- ----------------------------
-- Table structure for `tbl_storplan`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_storplan`;
CREATE TABLE `tbl_storplan` (
  `PlanID` int(10) NOT NULL AUTO_INCREMENT,
  `CamID` int(10) NOT NULL,
  `StreamingID` int(10) NOT NULL,
  `StartTime` time NOT NULL,
  `StopTime` time NOT NULL,
  `WorkDay` int(11) NOT NULL,
  `KeepTime` int(11) NOT NULL,
  `IslostStop` int(11) NOT NULL,
  PRIMARY KEY (`PlanID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of tbl_storplan
-- ----------------------------

-- ----------------------------
-- View structure for `v_account_authority`
-- ----------------------------
DROP VIEW IF EXISTS `v_account_authority`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_account_authority` AS select distinct `auth`.`ID` AS `ID`,`auth`.`CREATETIME` AS `CREATETIME`,`auth`.`UPDATETIME` AS `UPDATETIME`,`auth`.`IFUSE` AS `IFUSE`,`auth`.`AUTHORITYNAME` AS `AUTHORITYNAME`,`auth`.`DESCRIPTION` AS `DESCRIPTION`,`auth`.`ORDERNUM` AS `ORDERNUM`,`a`.`USERNAME` AS `USERNAME`,`a`.`TOKEN` AS `TOKEN` from ((((`sys_account` `a` join `sys_account_role` `ar`) join `sys_role` `r`) join `sys_role_authority` `ra`) join `sys_authority` `auth`) where ((`a`.`ID` = `ar`.`ACCOUNTID`) and (`ar`.`ROLEID` = `ra`.`ROLEID`) and (`auth`.`ID` = `ra`.`AUTHORITYID`)) ;
