/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50556
Source Host           : localhost:3306
Source Database       : isc

Target Server Type    : MYSQL
Target Server Version : 50556
File Encoding         : 65001

Date: 2018-08-29 02:30:03
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `account`
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) DEFAULT NULL COMMENT '用户名',
  `nickname` varchar(32) DEFAULT NULL COMMENT '昵称',
  `password` varchar(50) DEFAULT NULL COMMENT '密码',
  `mobile` varchar(16) DEFAULT NULL COMMENT '手机',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `lock` enum('N','Y') DEFAULT 'N' COMMENT '状态',
  `email` varchar(50) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_name` (`username`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account
-- ----------------------------
INSERT INTO `account` VALUES ('1', 'admin', 'admin', 'E10ADC3949BA59ABBE56E057F20F883E', '13318668638', '2016-12-18 23:06:04', 'N', '312265264@qq.com', '');
INSERT INTO `account` VALUES ('48', 'test', 'test', '21218CCA77804D2BA1922C33E0151105', null, '2018-08-25 10:14:17', 'N', '', '');

-- ----------------------------
-- Table structure for `app`
-- ----------------------------
DROP TABLE IF EXISTS `app`;
CREATE TABLE `app` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `effective_date` date DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `contacts_id` bigint(20) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  `unsign_file` varchar(100) DEFAULT NULL,
  `sign_file` varchar(100) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_delete` int(11) DEFAULT NULL,
  `cert_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of app
-- ----------------------------
INSERT INTO `app` VALUES ('5', '速来应急', '2018-08-24', '2018-09-24', '6', '', '/app/20180829015914/速来应急.ipa', '/app/20180829015914/速来应急_resigned.ipa', '2018-08-24 01:59:14', '2018-08-24 01:59:14', '0', '5');
INSERT INTO `app` VALUES ('6', '秒钱贷', '2018-08-24', '2018-09-24', '7', '', '/app/20180829020201/人人花.ipa', '/app/20180829020201/人人花_resigned.ipa', '2018-08-24 02:02:01', '2018-08-24 02:02:01', '0', '3');
INSERT INTO `app` VALUES ('7', '快快钱包', '2018-08-27', '2018-11-27', '8', '', '/app/20180829020244/快快钱包.ipa', '/app/20180829020244/快快钱包_resigned.ipa', '2018-08-27 02:02:44', '2018-08-27 02:02:44', '0', '5');
INSERT INTO `app` VALUES ('8', '安心花', '2018-08-27', '2018-09-27', '9', '', '/app/20180829020319/安心花.ipa', '/app/20180829020319/安心花_resigned.ipa', '2018-08-27 02:03:19', '2018-08-27 02:03:19', '0', '3');
INSERT INTO `app` VALUES ('9', '来来宝', '2018-08-27', '2018-09-27', '10', '', '/app/20180829020421/来来宝.ipa', '/app/20180829020421/来来宝_resigned.ipa', '2018-08-27 02:04:21', '2018-08-27 02:04:21', '0', '3');
INSERT INTO `app` VALUES ('10', '提钱周转', '2018-08-28', '2018-09-28', '11', '', '/app/20180829020521/提钱周转.ipa', '/app/20180829020521/提钱周转_resigned.ipa', '2018-08-28 02:05:21', '2018-08-28 02:05:21', '0', '5');
INSERT INTO `app` VALUES ('11', '菠萝钱包', '2018-08-28', '2018-09-28', '11', '', '/app/20180829020556/菠萝钱包.ipa', '/app/20180829020556/菠萝钱包_resigned.ipa', '2018-08-28 02:05:56', '2018-08-28 02:05:56', '0', '5');
INSERT INTO `app` VALUES ('12', '曙光贷', '2018-08-28', '2018-09-28', '12', '', '/app/20180829020646/曙光贷.ipa', '/app/20180829020646/曙光贷_resigned.ipa', '2018-08-28 02:06:46', '2018-08-28 02:06:46', '0', '5');
INSERT INTO `app` VALUES ('13', '我养你', '2018-08-28', '2018-11-28', '13', '', '/app/20180829020724/我养你.ipa', '/app/20180829020724/我养你_resigned.ipa', '2018-08-28 02:07:24', '2018-08-28 02:07:24', '0', '5');
INSERT INTO `app` VALUES ('14', '芝麻花', '2018-08-28', '2018-09-28', '14', '', '/app/20180829020752/芝麻花.ipa', '/app/20180829020752/芝麻花_resigned.ipa', '2018-08-28 02:07:52', '2018-08-28 02:07:52', '0', '5');
INSERT INTO `app` VALUES ('15', '人人花', '2018-08-28', '2018-09-28', '15', '', '/app/20180829020843/人人花.ipa', '/app/20180829020843/人人花_resigned.ipa', '2018-08-28 02:08:43', '2018-08-28 02:08:43', '0', '3');
INSERT INTO `app` VALUES ('16', '溜溜花', '2018-08-28', '2018-09-28', '16', '', '/app/20180829020916/溜溜花.ipa', '/app/20180829020916/溜溜花_resigned.ipa', '2018-08-28 02:09:16', '2018-08-28 02:09:16', '0', '3');
INSERT INTO `app` VALUES ('17', '58钱站', '2018-08-28', '2018-11-28', '17', '', '/app/20180829020946/58钱站.ipa', '/app/20180829020946/58钱站_resigned.ipa', '2018-08-28 02:09:46', '2018-08-28 02:09:46', '0', '3');
INSERT INTO `app` VALUES ('18', '喜贷钱包', '2018-08-28', '2018-11-28', '18', '', '/app/20180829021014/58钱站.ipa', '/app/20180829021014/58钱站_resigned.ipa', '2018-08-28 02:10:14', '2018-08-28 02:10:14', '0', '3');
INSERT INTO `app` VALUES ('19', '蚂蚁口袋', '2018-08-28', '2018-09-28', '19', '', '/app/20180829021038/蚂蚁口袋.ipa', '/app/20180829021038/蚂蚁口袋_resigned.ipa', '2018-08-28 02:10:38', '2018-08-28 02:10:38', '0', '3');

-- ----------------------------
-- Table structure for `certificate`
-- ----------------------------
DROP TABLE IF EXISTS `certificate`;
CREATE TABLE `certificate` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `cert_expire_date` date DEFAULT NULL,
  `desc_expire_date` date DEFAULT NULL,
  `cert_file` varchar(200) DEFAULT NULL,
  `desc_file` varchar(200) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  `is_delete` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of certificate
-- ----------------------------
INSERT INTO `certificate` VALUES ('3', 'SunShine', '2021-08-17', '2019-08-18', '/certification/3/SunShine Insurance Distribution.p12', '/certification/3/SunShine_Insurance_distribution.mobileprovision', '2018-08-29 01:51:37', '租4k', '0');
INSERT INTO `certificate` VALUES ('4', 'yunxun', '2019-10-18', '2019-03-08', '/certification/4/证书.p12', '/certification/4/shenzhenyunxun.mobileprovision', '2018-08-29 01:52:45', '租500', '0');
INSERT INTO `certificate` VALUES ('5', 'digigen', '2021-08-25', '2019-08-26', '/certification/5/DIGIGEN TECHNOLOGY Distribution.p12', '/certification/5/DigigenTechnology_Distribution.mobileprovision', '2018-08-29 01:55:01', '', '0');

-- ----------------------------
-- Table structure for `combo`
-- ----------------------------
DROP TABLE IF EXISTS `combo`;
CREATE TABLE `combo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `is_delete` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of combo
-- ----------------------------
INSERT INTO `combo` VALUES ('2', '套餐1-内测版', '分发量较小 安装量上限：1万,适用于个人测试', '300', '1', '0', '2018-08-29 01:34:20');
INSERT INTO `combo` VALUES ('3', '套餐2-公测版/1个月', '分发量中等  安装量上限：1万-3万,适用于公司内部分发使用', '600', '1', '0', '2018-08-29 01:34:59');
INSERT INTO `combo` VALUES ('4', '套餐2-公测版/3个月', '分发量中等  安装量上限：1万-3万,适用于公司内部分发使用', '1500', '3', '0', '2018-08-29 01:35:50');
INSERT INTO `combo` VALUES ('5', '套餐2-公测版/6个月', '分发量中等  安装量上限：1万-3万,适用于公司内部分发使用', '2500', '6', '0', '2018-08-29 01:44:38');
INSERT INTO `combo` VALUES ('6', '套餐3-分发版/1个月', '分发量较大  无限制安装,适用于对外投放,金融,彩票,直播类建议用该版本', '1500', '1', '0', '2018-08-29 01:45:02');
INSERT INTO `combo` VALUES ('7', '套餐3-分发版/3个月', '分发量较大  无限制安装,适用于对外投放,金融,彩票,直播类建议用该版本', '3888', '3', '0', '2018-08-29 01:45:23');
INSERT INTO `combo` VALUES ('8', '套餐3-分发版/6个月', '分发量较大  无限制安装,适用于对外投放,金融,彩票,直播类建议用该版本', '5888', '6', '0', '2018-08-29 01:45:48');
INSERT INTO `combo` VALUES ('9', '套餐4-尊享版/1个月', '全新账号，签名app不超20个，稳定性极高', '2500', '1', '0', '2018-08-29 01:46:30');
INSERT INTO `combo` VALUES ('10', '套餐4-尊享版/3个月', '全新账号，签名app不超20个，稳定性极高', '6888', '3', '0', '2018-08-29 01:46:56');

-- ----------------------------
-- Table structure for `contacts`
-- ----------------------------
DROP TABLE IF EXISTS `contacts`;
CREATE TABLE `contacts` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `wechat` varchar(50) DEFAULT NULL,
  `alipay` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  `is_delete` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of contacts
-- ----------------------------
INSERT INTO `contacts` VALUES ('6', '', 'Xiaohua19870805', '', '', '', '0', '2018-08-29 01:59:14');
INSERT INTO `contacts` VALUES ('7', null, 'Mimei45', null, null, null, '0', '2018-08-29 02:21:53');
INSERT INTO `contacts` VALUES ('8', null, 'jsj920821', null, null, null, '0', '2018-08-29 02:22:07');
INSERT INTO `contacts` VALUES ('9', null, 'ttmtxo328', null, null, null, '0', '2018-08-29 02:22:18');
INSERT INTO `contacts` VALUES ('10', null, 'shehuiyelang', null, null, null, '0', '2018-08-29 02:22:30');
INSERT INTO `contacts` VALUES ('11', null, 'ZZ1158774090', null, null, null, '0', '2018-08-29 02:22:40');
INSERT INTO `contacts` VALUES ('12', null, 'xht6959220', null, null, null, '0', '2018-08-29 02:22:50');
INSERT INTO `contacts` VALUES ('13', null, 'raxdd1314', null, null, null, '0', '2018-08-29 02:22:59');
INSERT INTO `contacts` VALUES ('14', null, 'ydc177', null, null, null, '0', '2018-08-29 02:23:10');
INSERT INTO `contacts` VALUES ('15', null, 'mu20120118', null, null, null, '0', '2018-08-29 02:23:19');
INSERT INTO `contacts` VALUES ('16', null, 'XLJ1143667143', null, null, null, '0', '2018-08-29 02:23:33');
INSERT INTO `contacts` VALUES ('17', null, 'pjqb4935', null, null, null, '0', '2018-08-29 02:23:42');
INSERT INTO `contacts` VALUES ('18', null, 'langki7366', null, null, null, '0', '2018-08-29 02:24:03');
INSERT INTO `contacts` VALUES ('19', null, 'four88888888four', null, null, null, '0', '2018-08-29 02:24:16');

-- ----------------------------
-- Table structure for `menu`
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `url` varchar(100) DEFAULT NULL,
  `p_id` bigint(20) DEFAULT NULL,
  `sort_num` int(11) DEFAULT NULL,
  `is_parent` enum('N','Y') DEFAULT 'N',
  `alias` varchar(50) DEFAULT NULL COMMENT '别名，必须唯一',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', '系统管理', 'system/index', null, '10', 'Y', 'system');
INSERT INTO `menu` VALUES ('2', '用户管理', 'account/list', '1', '1', 'N', 'account');
INSERT INTO `menu` VALUES ('3', '角色管理', 'role/list', '1', '2', 'N', 'role');
INSERT INTO `menu` VALUES ('10', '字典管理', 'dictionary/list', '1', '6', 'N', 'dictionary');
INSERT INTO `menu` VALUES ('11', '日志管理', 'operationlog/list', '1', '4', 'N', 'log');
INSERT INTO `menu` VALUES ('12', '区域管理', 'area/list', '1', '2', 'N', 'area');
INSERT INTO `menu` VALUES ('13', '机构管理', 'org/list', '1', '3', 'N', 'org');
INSERT INTO `menu` VALUES ('14', '菜单管理', 'menu/list', '1', '5', 'N', 'menu');
INSERT INTO `menu` VALUES ('15', '任务管理', '', null, '1', 'Y', 'info');
INSERT INTO `menu` VALUES ('16', '车型OTS阶段任务', 'ots/index?taskType=1', '15', '1', 'N', 'otsTask');
INSERT INTO `menu` VALUES ('17', '任务申请', 'ots/requireList?taskType=1', '16', '1', 'N', 'otsRequire');
INSERT INTO `menu` VALUES ('18', '信息审核', 'ots/examineList?taskType=1', '16', '2', 'N', 'otsExamine');
INSERT INTO `menu` VALUES ('19', '任务下达', 'ots/transmitList?taskType=1', '16', '3', 'N', 'otsOrder');
INSERT INTO `menu` VALUES ('20', '任务审批', 'ots/approveList?taskType=1', '16', '4', 'N', 'otsApprove');
INSERT INTO `menu` VALUES ('21', '车型PPAP阶段任务', 'ppap/index?taskType=2', '15', '2', 'N', 'ppapTask');
INSERT INTO `menu` VALUES ('22', '任务下达 ', 'ppap/transmitList?taskType=2', '21', '1', 'N', 'ppapOrder');
INSERT INTO `menu` VALUES ('23', '任务审批', 'ppap/approveList?taskType=2', '21', '2', 'N', 'ppapApprove');
INSERT INTO `menu` VALUES ('24', '结果确认', 'ppap/confirmList?taskType=2', '21', '3', 'N', 'ppapConfirm');
INSERT INTO `menu` VALUES ('25', '车型SOP阶段任务', 'ppap/index?taskType=3', '15', '3', 'N', 'sopTask');
INSERT INTO `menu` VALUES ('26', '任务下达 ', 'ppap/transmitList?taskType=3', '25', '1', 'N', 'sopOrder');
INSERT INTO `menu` VALUES ('27', '任务审批 ', 'ppap/approveList?taskType=3', '25', '2', 'N', 'sopApprove');
INSERT INTO `menu` VALUES ('28', '结果确认', 'ppap/confirmList?taskType=3', '25', '3', 'N', 'sopConfirm');
INSERT INTO `menu` VALUES ('36', '非车型材料任务', 'ots/index?taskType=4', '15', '4', 'N', 'gsTask');
INSERT INTO `menu` VALUES ('37', '任务申请', 'ots/requireList?taskType=4', '36', '1', 'N', 'gsRequire');
INSERT INTO `menu` VALUES ('38', '信息审核 ', 'ots/examineList?taskType=4', '36', '2', 'N', 'gsExamine');
INSERT INTO `menu` VALUES ('39', '任务下达 ', 'ots/transmitList?taskType=4', '36', '3', 'N', 'gsOrder');
INSERT INTO `menu` VALUES ('40', '任务审批 ', 'ots/approveList?taskType=4', '36', '4', 'N', 'gsApprove');
INSERT INTO `menu` VALUES ('41', '实验管理', null, null, '2', 'Y', '');
INSERT INTO `menu` VALUES ('42', '结果上传', null, '41', null, 'N', 'result');
INSERT INTO `menu` VALUES ('43', '型式试验结果上传', 'result/uploadList?type=1', '42', '1', 'N', 'patternUpload');
INSERT INTO `menu` VALUES ('44', '图谱结果上传', 'result/uploadList?type=2', '42', '2', 'N', 'atlasUpload');
INSERT INTO `menu` VALUES ('45', '结果比对', 'result/compareList', '41', null, 'N', 'compare');
INSERT INTO `menu` VALUES ('46', '结果发送', 'result/sendList', '41', null, 'N', 'send');
INSERT INTO `menu` VALUES ('47', '结果确认', null, '41', null, 'N', 'confirm');
INSERT INTO `menu` VALUES ('48', '待上传结果', 'result/confirmList?type=1', '47', '1', 'N', 'waitConfirm');
INSERT INTO `menu` VALUES ('49', '已上传结果', 'result/confirmList?type=2', '47', null, 'N', 'finishConfirm');
INSERT INTO `menu` VALUES ('50', '申请管理', null, null, '3', 'Y', 'apply');
INSERT INTO `menu` VALUES ('51', '修改申请', 'apply/taskList', '50', null, 'N', 'updateApply');
INSERT INTO `menu` VALUES ('52', '终止申请', 'apply/applyList', '50', null, 'N', 'endApply');
INSERT INTO `menu` VALUES ('54', '查询管理', 'query/list', null, '4', 'Y', 'query');
INSERT INTO `menu` VALUES ('55', '统计管理', null, null, '5', 'Y', 'statistic');
INSERT INTO `menu` VALUES ('57', '结果统计', 'statistic/result', '55', null, 'N', 'resultStatistic');
INSERT INTO `menu` VALUES ('58', '费用管理', '', null, '6', 'Y', 'cost');
INSERT INTO `menu` VALUES ('59', '待发送列表', 'cost/list?type=1', '58', null, 'N', 'tosend');
INSERT INTO `menu` VALUES ('60', '收费通知单列表', 'cost/list?type=2', '58', null, 'N', 'sent');
INSERT INTO `menu` VALUES ('61', '消息管理', 'message/list', null, '5', 'Y', 'message');

-- ----------------------------
-- Table structure for `operation_log`
-- ----------------------------
DROP TABLE IF EXISTS `operation_log`;
CREATE TABLE `operation_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) DEFAULT NULL,
  `user_agent` varchar(200) DEFAULT NULL,
  `client_ip` varchar(50) DEFAULT NULL,
  `time` timestamp NULL DEFAULT NULL,
  `detail` longtext,
  `type` varchar(100) DEFAULT NULL,
  `operation` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3603 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of operation_log
-- ----------------------------
INSERT INTO `operation_log` VALUES ('3553', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 01:34:20', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"name\\\" : \\\"内测版\\\",\\r\\n  \\\"remark\\\" : \\\"分发量较小 安装量上限：1万,适用于个人测试\\\",\\r\\n  \\\"price\\\" : 300.0,\\r\\n  \\\"duration\\\" : 1,\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"createTime\\\" : 1535477660523\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.Combo\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '套餐管理', '新建');
INSERT INTO `operation_log` VALUES ('3554', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 01:34:59', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"name\\\" : \\\"公测版/1个月\\\",\\r\\n  \\\"remark\\\" : \\\"分发量中等  安装量上限：1万-3万,适用于公司内部分发使用\\\",\\r\\n  \\\"price\\\" : 600.0,\\r\\n  \\\"duration\\\" : 1,\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"createTime\\\" : 1535477699545\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.Combo\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '套餐管理', '新建');
INSERT INTO `operation_log` VALUES ('3555', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 01:35:50', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"name\\\" : \\\"公测版/3个月\\\",\\r\\n  \\\"remark\\\" : \\\"分发量中等  安装量上限：1万-3万,适用于公司内部分发使用\\\",\\r\\n  \\\"price\\\" : 1500.0,\\r\\n  \\\"duration\\\" : 3,\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"createTime\\\" : 1535477750055\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.Combo\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '套餐管理', '新建');
INSERT INTO `operation_log` VALUES ('3556', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 01:44:38', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"name\\\" : \\\"公测版/6个月\\\",\\r\\n  \\\"remark\\\" : \\\"分发量中等  安装量上限：1万-3万,适用于公司内部分发使用\\\",\\r\\n  \\\"price\\\" : 2500.0,\\r\\n  \\\"duration\\\" : 6,\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"createTime\\\" : 1535478278970\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.Combo\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '套餐管理', '新建');
INSERT INTO `operation_log` VALUES ('3557', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 01:45:02', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"name\\\" : \\\"分发版/1个月\\\",\\r\\n  \\\"remark\\\" : \\\"分发量较大  无限制安装,适用于对外投放,金融,彩票,直播类建议用该版本\\\",\\r\\n  \\\"price\\\" : 1500.0,\\r\\n  \\\"duration\\\" : 1,\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"createTime\\\" : 1535478302368\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.Combo\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '套餐管理', '新建');
INSERT INTO `operation_log` VALUES ('3558', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 01:45:23', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"name\\\" : \\\"分发版/3个月\\\",\\r\\n  \\\"remark\\\" : \\\"分发量较大  无限制安装,适用于对外投放,金融,彩票,直播类建议用该版本\\\",\\r\\n  \\\"price\\\" : 3888.0,\\r\\n  \\\"duration\\\" : 3,\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"createTime\\\" : 1535478323766\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.Combo\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '套餐管理', '新建');
INSERT INTO `operation_log` VALUES ('3559', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 01:45:48', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"name\\\" : \\\"分发版/6个月\\\",\\r\\n  \\\"remark\\\" : \\\"分发量较大  无限制安装,适用于对外投放,金融,彩票,直播类建议用该版本\\\",\\r\\n  \\\"price\\\" : 5888.0,\\r\\n  \\\"duration\\\" : 6,\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"createTime\\\" : 1535478348367\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.Combo\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '套餐管理', '新建');
INSERT INTO `operation_log` VALUES ('3560', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 01:46:30', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"name\\\" : \\\"尊享版/1个月\\\",\\r\\n  \\\"remark\\\" : \\\"全新账号，签名app不超20个，稳定性极高\\\",\\r\\n  \\\"price\\\" : 2500.0,\\r\\n  \\\"duration\\\" : 1,\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"createTime\\\" : 1535478390382\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.Combo\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '套餐管理', '新建');
INSERT INTO `operation_log` VALUES ('3561', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 01:46:56', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"name\\\" : \\\"尊享版/3个月\\\",\\r\\n  \\\"remark\\\" : \\\"全新账号，签名app不超20个，稳定性极高\\\",\\r\\n  \\\"price\\\" : 6888.0,\\r\\n  \\\"duration\\\" : 3,\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"createTime\\\" : 1535478416342\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.Combo\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '套餐管理', '新建');
INSERT INTO `operation_log` VALUES ('3562', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 01:51:37', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"id\\\" : 3,\\r\\n  \\\"name\\\" : \\\"SunShine\\\",\\r\\n  \\\"certExpireDate\\\" : 1629129600000,\\r\\n  \\\"descExpireDate\\\" : 1566057600000,\\r\\n  \\\"certFileName\\\" : \\\"\\\",\\r\\n  \\\"descFileName\\\" : \\\"\\\",\\r\\n  \\\"createTime\\\" : 1535478697680,\\r\\n  \\\"remark\\\" : \\\"租4k\\\",\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"primaryKey\\\" : 3\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.Certificate\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '证书管理', '新建');
INSERT INTO `operation_log` VALUES ('3563', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 01:51:37', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"id\\\" : 3,\\r\\n  \\\"name\\\" : \\\"SunShine\\\",\\r\\n  \\\"certExpireDate\\\" : 1629129600000,\\r\\n  \\\"descExpireDate\\\" : 1566057600000,\\r\\n  \\\"certFile\\\" : \\\"/certification/3/SunShine Insurance Distribution.p12\\\",\\r\\n  \\\"certFileName\\\" : \\\"SunShine Insurance Distribution.p12\\\",\\r\\n  \\\"descFile\\\" : \\\"/certification/3/SunShine_Insurance_distribution.mobileprovision\\\",\\r\\n  \\\"descFileName\\\" : \\\"SunShine_Insurance_distribution.mobileprovision\\\",\\r\\n  \\\"createTime\\\" : 1535478697680,\\r\\n  \\\"remark\\\" : \\\"租4k\\\",\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"primaryKey\\\" : 3\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.Certificate\",\r\n  \"OLDENTITY\" : \"{\\r\\n  \\\"id\\\" : 3,\\r\\n  \\\"name\\\" : \\\"SunShine\\\",\\r\\n  \\\"certExpireDate\\\" : 1629129600000,\\r\\n  \\\"descExpireDate\\\" : 1566057600000,\\r\\n  \\\"certFileName\\\" : \\\"\\\",\\r\\n  \\\"descFileName\\\" : \\\"\\\",\\r\\n  \\\"createTime\\\" : 1535478697000,\\r\\n  \\\"remark\\\" : \\\"租4k\\\",\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"primaryKey\\\" : 3\\r\\n}\",\r\n  \"OPERATION\" : \"编辑\"\r\n}', '证书管理', '编辑');
INSERT INTO `operation_log` VALUES ('3564', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 01:52:45', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"id\\\" : 4,\\r\\n  \\\"name\\\" : \\\"yunxun\\\",\\r\\n  \\\"certExpireDate\\\" : 1571328000000,\\r\\n  \\\"descExpireDate\\\" : 1551974400000,\\r\\n  \\\"certFileName\\\" : \\\"\\\",\\r\\n  \\\"descFileName\\\" : \\\"\\\",\\r\\n  \\\"createTime\\\" : 1535478765749,\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"primaryKey\\\" : 4\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.Certificate\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '证书管理', '新建');
INSERT INTO `operation_log` VALUES ('3565', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 01:52:45', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"id\\\" : 4,\\r\\n  \\\"name\\\" : \\\"yunxun\\\",\\r\\n  \\\"certExpireDate\\\" : 1571328000000,\\r\\n  \\\"descExpireDate\\\" : 1551974400000,\\r\\n  \\\"certFile\\\" : \\\"/certification/4/证书.p12\\\",\\r\\n  \\\"certFileName\\\" : \\\"证书.p12\\\",\\r\\n  \\\"descFile\\\" : \\\"/certification/4/shenzhenyunxun.mobileprovision\\\",\\r\\n  \\\"descFileName\\\" : \\\"shenzhenyunxun.mobileprovision\\\",\\r\\n  \\\"createTime\\\" : 1535478765749,\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"primaryKey\\\" : 4\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.Certificate\",\r\n  \"OLDENTITY\" : \"{\\r\\n  \\\"id\\\" : 4,\\r\\n  \\\"name\\\" : \\\"yunxun\\\",\\r\\n  \\\"certExpireDate\\\" : 1571328000000,\\r\\n  \\\"descExpireDate\\\" : 1551974400000,\\r\\n  \\\"certFileName\\\" : \\\"\\\",\\r\\n  \\\"descFileName\\\" : \\\"\\\",\\r\\n  \\\"createTime\\\" : 1535478765000,\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"primaryKey\\\" : 4\\r\\n}\",\r\n  \"OPERATION\" : \"编辑\"\r\n}', '证书管理', '编辑');
INSERT INTO `operation_log` VALUES ('3566', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 01:52:55', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"id\\\" : 4,\\r\\n  \\\"name\\\" : \\\"yunxun\\\",\\r\\n  \\\"certExpireDate\\\" : 1571328000000,\\r\\n  \\\"descExpireDate\\\" : 1551974400000,\\r\\n  \\\"certFile\\\" : \\\"/certification/4/证书.p12\\\",\\r\\n  \\\"certFileName\\\" : \\\"证书.p12\\\",\\r\\n  \\\"descFile\\\" : \\\"/certification/4/shenzhenyunxun.mobileprovision\\\",\\r\\n  \\\"descFileName\\\" : \\\"shenzhenyunxun.mobileprovision\\\",\\r\\n  \\\"createTime\\\" : 1535478765000,\\r\\n  \\\"remark\\\" : \\\"租500\\\",\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"primaryKey\\\" : 4\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.Certificate\",\r\n  \"OLDENTITY\" : \"{\\r\\n  \\\"id\\\" : 4,\\r\\n  \\\"name\\\" : \\\"yunxun\\\",\\r\\n  \\\"certExpireDate\\\" : 1571328000000,\\r\\n  \\\"descExpireDate\\\" : 1551974400000,\\r\\n  \\\"certFile\\\" : \\\"/certification/4/证书.p12\\\",\\r\\n  \\\"certFileName\\\" : \\\"证书.p12\\\",\\r\\n  \\\"descFile\\\" : \\\"/certification/4/shenzhenyunxun.mobileprovision\\\",\\r\\n  \\\"descFileName\\\" : \\\"shenzhenyunxun.mobileprovision\\\",\\r\\n  \\\"createTime\\\" : 1535478765000,\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"primaryKey\\\" : 4\\r\\n}\",\r\n  \"OPERATION\" : \"编辑\"\r\n}', '证书管理', '编辑');
INSERT INTO `operation_log` VALUES ('3567', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 01:55:01', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"id\\\" : 5,\\r\\n  \\\"name\\\" : \\\"digigen\\\",\\r\\n  \\\"certExpireDate\\\" : 1629820800000,\\r\\n  \\\"descExpireDate\\\" : 1566748800000,\\r\\n  \\\"certFileName\\\" : \\\"\\\",\\r\\n  \\\"descFileName\\\" : \\\"\\\",\\r\\n  \\\"createTime\\\" : 1535478901183,\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"primaryKey\\\" : 5\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.Certificate\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '证书管理', '新建');
INSERT INTO `operation_log` VALUES ('3568', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 01:55:01', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"id\\\" : 5,\\r\\n  \\\"name\\\" : \\\"digigen\\\",\\r\\n  \\\"certExpireDate\\\" : 1629820800000,\\r\\n  \\\"descExpireDate\\\" : 1566748800000,\\r\\n  \\\"certFile\\\" : \\\"/certification/5/DIGIGEN TECHNOLOGY Distribution.p12\\\",\\r\\n  \\\"certFileName\\\" : \\\"DIGIGEN TECHNOLOGY Distribution.p12\\\",\\r\\n  \\\"descFile\\\" : \\\"/certification/5/DigigenTechnology_Distribution.mobileprovision\\\",\\r\\n  \\\"descFileName\\\" : \\\"DigigenTechnology_Distribution.mobileprovision\\\",\\r\\n  \\\"createTime\\\" : 1535478901183,\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"primaryKey\\\" : 5\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.Certificate\",\r\n  \"OLDENTITY\" : \"{\\r\\n  \\\"id\\\" : 5,\\r\\n  \\\"name\\\" : \\\"digigen\\\",\\r\\n  \\\"certExpireDate\\\" : 1629820800000,\\r\\n  \\\"descExpireDate\\\" : 1566748800000,\\r\\n  \\\"certFileName\\\" : \\\"\\\",\\r\\n  \\\"descFileName\\\" : \\\"\\\",\\r\\n  \\\"createTime\\\" : 1535478901000,\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"primaryKey\\\" : 5\\r\\n}\",\r\n  \"OPERATION\" : \"编辑\"\r\n}', '证书管理', '编辑');
INSERT INTO `operation_log` VALUES ('3569', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 01:59:14', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"id\\\" : 6,\\r\\n  \\\"name\\\" : \\\"\\\",\\r\\n  \\\"wechat\\\" : \\\"Xiaohua19870805\\\",\\r\\n  \\\"alipay\\\" : \\\"\\\",\\r\\n  \\\"phone\\\" : \\\"\\\",\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"createTime\\\" : 1535479154416,\\r\\n  \\\"primaryKey\\\" : 6\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.Contacts\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '客户管理', '新建');
INSERT INTO `operation_log` VALUES ('3570', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 01:59:14', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"name\\\" : \\\"速来应急\\\",\\r\\n  \\\"effectiveDate\\\" : 1535479154416,\\r\\n  \\\"expireDate\\\" : 1538157554416,\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"unsignFile\\\" : \\\"/app/20180829015914/速来应急.ipa\\\",\\r\\n  \\\"unsignFileName\\\" : \\\"速来应急.ipa\\\",\\r\\n  \\\"signFile\\\" : \\\"/app/20180829015914/速来应急_resigned.ipa\\\",\\r\\n  \\\"signFileName\\\" : \\\"速来应急_resigned.ipa\\\",\\r\\n  \\\"createTime\\\" : 1535479154416,\\r\\n  \\\"updateTime\\\" : 1535479154416,\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"certId\\\" : 5\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.App\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', 'APP管理', '新建');
INSERT INTO `operation_log` VALUES ('3571', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 01:59:14', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"type\\\" : 1,\\r\\n  \\\"comboId\\\" : 9,\\r\\n  \\\"price\\\" : 2500.0,\\r\\n  \\\"effectiveDate\\\" : 1535479154416,\\r\\n  \\\"expireDate\\\" : 1538157554416,\\r\\n  \\\"appId\\\" : 5,\\r\\n  \\\"createTime\\\" : 1535479154416,\\r\\n  \\\"certId\\\" : 5\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.SignRecord\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '签名记录', '新建');
INSERT INTO `operation_log` VALUES ('3572', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:02:01', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"name\\\" : \\\"秒钱贷\\\",\\r\\n  \\\"effectiveDate\\\" : 1535479321278,\\r\\n  \\\"expireDate\\\" : 1538157721278,\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"unsignFile\\\" : \\\"/app/20180829020201/人人花.ipa\\\",\\r\\n  \\\"unsignFileName\\\" : \\\"人人花.ipa\\\",\\r\\n  \\\"signFile\\\" : \\\"/app/20180829020201/人人花_resigned.ipa\\\",\\r\\n  \\\"signFileName\\\" : \\\"人人花_resigned.ipa\\\",\\r\\n  \\\"createTime\\\" : 1535479321278,\\r\\n  \\\"updateTime\\\" : 1535479321278,\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"certId\\\" : 3\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.App\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', 'APP管理', '新建');
INSERT INTO `operation_log` VALUES ('3573', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:02:01', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"type\\\" : 1,\\r\\n  \\\"comboId\\\" : 6,\\r\\n  \\\"price\\\" : 1500.0,\\r\\n  \\\"effectiveDate\\\" : 1535479321278,\\r\\n  \\\"expireDate\\\" : 1538157721278,\\r\\n  \\\"appId\\\" : 6,\\r\\n  \\\"createTime\\\" : 1535479321278,\\r\\n  \\\"certId\\\" : 3\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.SignRecord\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '签名记录', '新建');
INSERT INTO `operation_log` VALUES ('3574', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:02:44', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"name\\\" : \\\"快快钱包\\\",\\r\\n  \\\"effectiveDate\\\" : 1535479364890,\\r\\n  \\\"expireDate\\\" : 1543428164890,\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"unsignFile\\\" : \\\"/app/20180829020244/快快钱包.ipa\\\",\\r\\n  \\\"unsignFileName\\\" : \\\"快快钱包.ipa\\\",\\r\\n  \\\"signFile\\\" : \\\"/app/20180829020244/快快钱包_resigned.ipa\\\",\\r\\n  \\\"signFileName\\\" : \\\"快快钱包_resigned.ipa\\\",\\r\\n  \\\"createTime\\\" : 1535479364890,\\r\\n  \\\"updateTime\\\" : 1535479364890,\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"certId\\\" : 5\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.App\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', 'APP管理', '新建');
INSERT INTO `operation_log` VALUES ('3575', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:02:44', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"type\\\" : 1,\\r\\n  \\\"comboId\\\" : 10,\\r\\n  \\\"price\\\" : 6888.0,\\r\\n  \\\"effectiveDate\\\" : 1535479364890,\\r\\n  \\\"expireDate\\\" : 1543428164890,\\r\\n  \\\"appId\\\" : 7,\\r\\n  \\\"createTime\\\" : 1535479364890,\\r\\n  \\\"certId\\\" : 5\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.SignRecord\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '签名记录', '新建');
INSERT INTO `operation_log` VALUES ('3576', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:03:19', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"name\\\" : \\\"安心花\\\",\\r\\n  \\\"effectiveDate\\\" : 1535479399745,\\r\\n  \\\"expireDate\\\" : 1538157799745,\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"unsignFile\\\" : \\\"/app/20180829020319/安心花.ipa\\\",\\r\\n  \\\"unsignFileName\\\" : \\\"安心花.ipa\\\",\\r\\n  \\\"signFile\\\" : \\\"/app/20180829020319/安心花_resigned.ipa\\\",\\r\\n  \\\"signFileName\\\" : \\\"安心花_resigned.ipa\\\",\\r\\n  \\\"createTime\\\" : 1535479399745,\\r\\n  \\\"updateTime\\\" : 1535479399745,\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"certId\\\" : 3\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.App\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', 'APP管理', '新建');
INSERT INTO `operation_log` VALUES ('3577', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:03:19', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"type\\\" : 1,\\r\\n  \\\"comboId\\\" : 6,\\r\\n  \\\"price\\\" : 1500.0,\\r\\n  \\\"effectiveDate\\\" : 1535479399745,\\r\\n  \\\"expireDate\\\" : 1538157799745,\\r\\n  \\\"appId\\\" : 8,\\r\\n  \\\"createTime\\\" : 1535479399745,\\r\\n  \\\"certId\\\" : 3\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.SignRecord\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '签名记录', '新建');
INSERT INTO `operation_log` VALUES ('3578', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:04:21', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"name\\\" : \\\"来来宝\\\",\\r\\n  \\\"effectiveDate\\\" : 1535479461638,\\r\\n  \\\"expireDate\\\" : 1538157861638,\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"unsignFile\\\" : \\\"/app/20180829020421/来来宝.ipa\\\",\\r\\n  \\\"unsignFileName\\\" : \\\"来来宝.ipa\\\",\\r\\n  \\\"signFile\\\" : \\\"/app/20180829020421/来来宝_resigned.ipa\\\",\\r\\n  \\\"signFileName\\\" : \\\"来来宝_resigned.ipa\\\",\\r\\n  \\\"createTime\\\" : 1535479461638,\\r\\n  \\\"updateTime\\\" : 1535479461638,\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"certId\\\" : 3\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.App\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', 'APP管理', '新建');
INSERT INTO `operation_log` VALUES ('3579', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:04:21', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"type\\\" : 1,\\r\\n  \\\"comboId\\\" : 6,\\r\\n  \\\"price\\\" : 1500.0,\\r\\n  \\\"effectiveDate\\\" : 1535479461638,\\r\\n  \\\"expireDate\\\" : 1538157861638,\\r\\n  \\\"appId\\\" : 9,\\r\\n  \\\"createTime\\\" : 1535479461638,\\r\\n  \\\"certId\\\" : 3\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.SignRecord\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '签名记录', '新建');
INSERT INTO `operation_log` VALUES ('3580', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:05:21', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"name\\\" : \\\"提钱周转\\\",\\r\\n  \\\"effectiveDate\\\" : 1535479521015,\\r\\n  \\\"expireDate\\\" : 1538157921015,\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"unsignFile\\\" : \\\"/app/20180829020521/提钱周转.ipa\\\",\\r\\n  \\\"unsignFileName\\\" : \\\"提钱周转.ipa\\\",\\r\\n  \\\"signFile\\\" : \\\"/app/20180829020521/提钱周转_resigned.ipa\\\",\\r\\n  \\\"signFileName\\\" : \\\"提钱周转_resigned.ipa\\\",\\r\\n  \\\"createTime\\\" : 1535479521015,\\r\\n  \\\"updateTime\\\" : 1535479521015,\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"certId\\\" : 5\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.App\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', 'APP管理', '新建');
INSERT INTO `operation_log` VALUES ('3581', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:05:21', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"type\\\" : 1,\\r\\n  \\\"comboId\\\" : 9,\\r\\n  \\\"price\\\" : 2500.0,\\r\\n  \\\"effectiveDate\\\" : 1535479521015,\\r\\n  \\\"expireDate\\\" : 1538157921015,\\r\\n  \\\"appId\\\" : 10,\\r\\n  \\\"createTime\\\" : 1535479521015,\\r\\n  \\\"certId\\\" : 5\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.SignRecord\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '签名记录', '新建');
INSERT INTO `operation_log` VALUES ('3582', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:05:56', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"name\\\" : \\\"菠萝钱包\\\",\\r\\n  \\\"effectiveDate\\\" : 1535479556560,\\r\\n  \\\"expireDate\\\" : 1538157956560,\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"unsignFile\\\" : \\\"/app/20180829020556/菠萝钱包.ipa\\\",\\r\\n  \\\"unsignFileName\\\" : \\\"菠萝钱包.ipa\\\",\\r\\n  \\\"signFile\\\" : \\\"/app/20180829020556/菠萝钱包_resigned.ipa\\\",\\r\\n  \\\"signFileName\\\" : \\\"菠萝钱包_resigned.ipa\\\",\\r\\n  \\\"createTime\\\" : 1535479556560,\\r\\n  \\\"updateTime\\\" : 1535479556560,\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"certId\\\" : 5\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.App\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', 'APP管理', '新建');
INSERT INTO `operation_log` VALUES ('3583', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:05:56', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"type\\\" : 1,\\r\\n  \\\"comboId\\\" : 9,\\r\\n  \\\"price\\\" : 2500.0,\\r\\n  \\\"effectiveDate\\\" : 1535479556560,\\r\\n  \\\"expireDate\\\" : 1538157956560,\\r\\n  \\\"appId\\\" : 11,\\r\\n  \\\"createTime\\\" : 1535479556560,\\r\\n  \\\"certId\\\" : 5\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.SignRecord\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '签名记录', '新建');
INSERT INTO `operation_log` VALUES ('3584', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:06:46', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"name\\\" : \\\"曙光贷\\\",\\r\\n  \\\"effectiveDate\\\" : 1535479606422,\\r\\n  \\\"expireDate\\\" : 1538158006422,\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"unsignFile\\\" : \\\"/app/20180829020646/曙光贷.ipa\\\",\\r\\n  \\\"unsignFileName\\\" : \\\"曙光贷.ipa\\\",\\r\\n  \\\"signFile\\\" : \\\"/app/20180829020646/曙光贷_resigned.ipa\\\",\\r\\n  \\\"signFileName\\\" : \\\"曙光贷_resigned.ipa\\\",\\r\\n  \\\"createTime\\\" : 1535479606422,\\r\\n  \\\"updateTime\\\" : 1535479606422,\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"certId\\\" : 5\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.App\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', 'APP管理', '新建');
INSERT INTO `operation_log` VALUES ('3585', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:06:46', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"type\\\" : 1,\\r\\n  \\\"comboId\\\" : 9,\\r\\n  \\\"price\\\" : 2500.0,\\r\\n  \\\"effectiveDate\\\" : 1535479606422,\\r\\n  \\\"expireDate\\\" : 1538158006422,\\r\\n  \\\"appId\\\" : 12,\\r\\n  \\\"createTime\\\" : 1535479606422,\\r\\n  \\\"certId\\\" : 5\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.SignRecord\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '签名记录', '新建');
INSERT INTO `operation_log` VALUES ('3586', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:07:24', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"name\\\" : \\\"我养你\\\",\\r\\n  \\\"effectiveDate\\\" : 1535479644572,\\r\\n  \\\"expireDate\\\" : 1543428444572,\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"unsignFile\\\" : \\\"/app/20180829020724/我养你.ipa\\\",\\r\\n  \\\"unsignFileName\\\" : \\\"我养你.ipa\\\",\\r\\n  \\\"signFile\\\" : \\\"/app/20180829020724/我养你_resigned.ipa\\\",\\r\\n  \\\"signFileName\\\" : \\\"我养你_resigned.ipa\\\",\\r\\n  \\\"createTime\\\" : 1535479644572,\\r\\n  \\\"updateTime\\\" : 1535479644572,\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"certId\\\" : 5\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.App\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', 'APP管理', '新建');
INSERT INTO `operation_log` VALUES ('3587', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:07:24', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"type\\\" : 1,\\r\\n  \\\"comboId\\\" : 10,\\r\\n  \\\"price\\\" : 6888.0,\\r\\n  \\\"effectiveDate\\\" : 1535479644572,\\r\\n  \\\"expireDate\\\" : 1543428444572,\\r\\n  \\\"appId\\\" : 13,\\r\\n  \\\"createTime\\\" : 1535479644572,\\r\\n  \\\"certId\\\" : 5\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.SignRecord\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '签名记录', '新建');
INSERT INTO `operation_log` VALUES ('3588', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:07:52', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"name\\\" : \\\"芝麻花\\\",\\r\\n  \\\"effectiveDate\\\" : 1535479672119,\\r\\n  \\\"expireDate\\\" : 1538158072119,\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"unsignFile\\\" : \\\"/app/20180829020752/芝麻花.ipa\\\",\\r\\n  \\\"unsignFileName\\\" : \\\"芝麻花.ipa\\\",\\r\\n  \\\"signFile\\\" : \\\"/app/20180829020752/芝麻花_resigned.ipa\\\",\\r\\n  \\\"signFileName\\\" : \\\"芝麻花_resigned.ipa\\\",\\r\\n  \\\"createTime\\\" : 1535479672119,\\r\\n  \\\"updateTime\\\" : 1535479672119,\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"certId\\\" : 5\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.App\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', 'APP管理', '新建');
INSERT INTO `operation_log` VALUES ('3589', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:07:52', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"type\\\" : 1,\\r\\n  \\\"comboId\\\" : 9,\\r\\n  \\\"price\\\" : 2500.0,\\r\\n  \\\"effectiveDate\\\" : 1535479672119,\\r\\n  \\\"expireDate\\\" : 1538158072119,\\r\\n  \\\"appId\\\" : 14,\\r\\n  \\\"createTime\\\" : 1535479672119,\\r\\n  \\\"certId\\\" : 5\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.SignRecord\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '签名记录', '新建');
INSERT INTO `operation_log` VALUES ('3590', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:08:43', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"name\\\" : \\\"人人花\\\",\\r\\n  \\\"effectiveDate\\\" : 1535479723524,\\r\\n  \\\"expireDate\\\" : 1538158123524,\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"unsignFile\\\" : \\\"/app/20180829020843/人人花.ipa\\\",\\r\\n  \\\"unsignFileName\\\" : \\\"人人花.ipa\\\",\\r\\n  \\\"signFile\\\" : \\\"/app/20180829020843/人人花_resigned.ipa\\\",\\r\\n  \\\"signFileName\\\" : \\\"人人花_resigned.ipa\\\",\\r\\n  \\\"createTime\\\" : 1535479723524,\\r\\n  \\\"updateTime\\\" : 1535479723524,\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"certId\\\" : 3\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.App\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', 'APP管理', '新建');
INSERT INTO `operation_log` VALUES ('3591', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:08:43', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"type\\\" : 1,\\r\\n  \\\"comboId\\\" : 6,\\r\\n  \\\"price\\\" : 1500.0,\\r\\n  \\\"effectiveDate\\\" : 1535479723524,\\r\\n  \\\"expireDate\\\" : 1538158123524,\\r\\n  \\\"appId\\\" : 15,\\r\\n  \\\"createTime\\\" : 1535479723524,\\r\\n  \\\"certId\\\" : 3\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.SignRecord\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '签名记录', '新建');
INSERT INTO `operation_log` VALUES ('3592', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:09:16', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"name\\\" : \\\"溜溜花\\\",\\r\\n  \\\"effectiveDate\\\" : 1535479756956,\\r\\n  \\\"expireDate\\\" : 1538158156956,\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"unsignFile\\\" : \\\"/app/20180829020916/溜溜花.ipa\\\",\\r\\n  \\\"unsignFileName\\\" : \\\"溜溜花.ipa\\\",\\r\\n  \\\"signFile\\\" : \\\"/app/20180829020916/溜溜花_resigned.ipa\\\",\\r\\n  \\\"signFileName\\\" : \\\"溜溜花_resigned.ipa\\\",\\r\\n  \\\"createTime\\\" : 1535479756956,\\r\\n  \\\"updateTime\\\" : 1535479756956,\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"certId\\\" : 3\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.App\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', 'APP管理', '新建');
INSERT INTO `operation_log` VALUES ('3593', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:09:16', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"type\\\" : 1,\\r\\n  \\\"comboId\\\" : 6,\\r\\n  \\\"price\\\" : 1500.0,\\r\\n  \\\"effectiveDate\\\" : 1535479756956,\\r\\n  \\\"expireDate\\\" : 1538158156956,\\r\\n  \\\"appId\\\" : 16,\\r\\n  \\\"createTime\\\" : 1535479756956,\\r\\n  \\\"certId\\\" : 3\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.SignRecord\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '签名记录', '新建');
INSERT INTO `operation_log` VALUES ('3594', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:09:46', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"name\\\" : \\\"58钱站\\\",\\r\\n  \\\"effectiveDate\\\" : 1535479786884,\\r\\n  \\\"expireDate\\\" : 1543428586884,\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"unsignFile\\\" : \\\"/app/20180829020946/58钱站.ipa\\\",\\r\\n  \\\"unsignFileName\\\" : \\\"58钱站.ipa\\\",\\r\\n  \\\"signFile\\\" : \\\"/app/20180829020946/58钱站_resigned.ipa\\\",\\r\\n  \\\"signFileName\\\" : \\\"58钱站_resigned.ipa\\\",\\r\\n  \\\"createTime\\\" : 1535479786884,\\r\\n  \\\"updateTime\\\" : 1535479786884,\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"certId\\\" : 3\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.App\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', 'APP管理', '新建');
INSERT INTO `operation_log` VALUES ('3595', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:09:46', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"type\\\" : 1,\\r\\n  \\\"comboId\\\" : 7,\\r\\n  \\\"price\\\" : 3888.0,\\r\\n  \\\"effectiveDate\\\" : 1535479786884,\\r\\n  \\\"expireDate\\\" : 1543428586884,\\r\\n  \\\"appId\\\" : 17,\\r\\n  \\\"createTime\\\" : 1535479786884,\\r\\n  \\\"certId\\\" : 3\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.SignRecord\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '签名记录', '新建');
INSERT INTO `operation_log` VALUES ('3596', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:10:14', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"name\\\" : \\\"喜贷钱包\\\",\\r\\n  \\\"effectiveDate\\\" : 1535479814171,\\r\\n  \\\"expireDate\\\" : 1543428614171,\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"unsignFile\\\" : \\\"/app/20180829021014/58钱站.ipa\\\",\\r\\n  \\\"unsignFileName\\\" : \\\"58钱站.ipa\\\",\\r\\n  \\\"signFile\\\" : \\\"/app/20180829021014/58钱站_resigned.ipa\\\",\\r\\n  \\\"signFileName\\\" : \\\"58钱站_resigned.ipa\\\",\\r\\n  \\\"createTime\\\" : 1535479814171,\\r\\n  \\\"updateTime\\\" : 1535479814171,\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"certId\\\" : 3\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.App\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', 'APP管理', '新建');
INSERT INTO `operation_log` VALUES ('3597', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:10:14', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"type\\\" : 1,\\r\\n  \\\"comboId\\\" : 7,\\r\\n  \\\"price\\\" : 3888.0,\\r\\n  \\\"effectiveDate\\\" : 1535479814171,\\r\\n  \\\"expireDate\\\" : 1543428614171,\\r\\n  \\\"appId\\\" : 18,\\r\\n  \\\"createTime\\\" : 1535479814171,\\r\\n  \\\"certId\\\" : 3\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.SignRecord\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '签名记录', '新建');
INSERT INTO `operation_log` VALUES ('3598', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:10:38', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"name\\\" : \\\"蚂蚁口袋\\\",\\r\\n  \\\"effectiveDate\\\" : 1535479838169,\\r\\n  \\\"expireDate\\\" : 1538158238169,\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"unsignFile\\\" : \\\"/app/20180829021038/蚂蚁口袋.ipa\\\",\\r\\n  \\\"unsignFileName\\\" : \\\"蚂蚁口袋.ipa\\\",\\r\\n  \\\"signFile\\\" : \\\"/app/20180829021038/蚂蚁口袋_resigned.ipa\\\",\\r\\n  \\\"signFileName\\\" : \\\"蚂蚁口袋_resigned.ipa\\\",\\r\\n  \\\"createTime\\\" : 1535479838169,\\r\\n  \\\"updateTime\\\" : 1535479838169,\\r\\n  \\\"isDelete\\\" : 0,\\r\\n  \\\"certId\\\" : 3\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.App\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', 'APP管理', '新建');
INSERT INTO `operation_log` VALUES ('3599', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:10:38', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"type\\\" : 1,\\r\\n  \\\"comboId\\\" : 6,\\r\\n  \\\"price\\\" : 1500.0,\\r\\n  \\\"effectiveDate\\\" : 1535479838169,\\r\\n  \\\"expireDate\\\" : 1538158238169,\\r\\n  \\\"appId\\\" : 19,\\r\\n  \\\"createTime\\\" : 1535479838169,\\r\\n  \\\"certId\\\" : 3\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.SignRecord\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '签名记录', '新建');
INSERT INTO `operation_log` VALUES ('3600', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:18:22', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"remark\\\" : \\\"购买digigen 账号\\\",\\r\\n  \\\"price\\\" : 90000.0,\\r\\n  \\\"createTime\\\" : 1535480302793,\\r\\n  \\\"isDelete\\\" : 0\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.Pay\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '支出记录', '新建');
INSERT INTO `operation_log` VALUES ('3601', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:18:36', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"remark\\\" : \\\"租 sunshine 证书\\\",\\r\\n  \\\"price\\\" : 4000.0,\\r\\n  \\\"createTime\\\" : 1535480316178,\\r\\n  \\\"isDelete\\\" : 0\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.Pay\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '支出记录', '新建');
INSERT INTO `operation_log` VALUES ('3602', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2018-08-29 02:18:51', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"remark\\\" : \\\"租 yunxun 证书\\\",\\r\\n  \\\"price\\\" : 500.0,\\r\\n  \\\"createTime\\\" : 1535480331468,\\r\\n  \\\"isDelete\\\" : 0\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.Pay\",\r\n  \"OLDENTITY\" : null,\r\n  \"OPERATION\" : \"新建\"\r\n}', '支出记录', '新建');

-- ----------------------------
-- Table structure for `pay`
-- ----------------------------
DROP TABLE IF EXISTS `pay`;
CREATE TABLE `pay` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `remark` varchar(200) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `is_delete` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay
-- ----------------------------
INSERT INTO `pay` VALUES ('2', '购买digigen 账号', '90000', '2018-08-29 02:18:22', '0');
INSERT INTO `pay` VALUES ('3', '租 sunshine 证书', '4000', '2018-08-29 02:18:36', '0');
INSERT INTO `pay` VALUES ('4', '租 yunxun 证书', '500', '2018-08-29 02:18:51', '0');

-- ----------------------------
-- Table structure for `sign_record`
-- ----------------------------
DROP TABLE IF EXISTS `sign_record`;
CREATE TABLE `sign_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL,
  `cert_id` bigint(20) DEFAULT NULL,
  `combo_id` bigint(20) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `effective_date` date DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `app_id` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sign_record
-- ----------------------------
INSERT INTO `sign_record` VALUES ('10', '1', '5', '9', '2500', '2018-08-24', '2018-09-24', '5', '2018-08-24 01:59:14');
INSERT INTO `sign_record` VALUES ('11', '1', '3', '6', '1500', '2018-08-24', '2018-09-24', '6', '2018-08-24 02:02:01');
INSERT INTO `sign_record` VALUES ('12', '1', '5', '10', '6888', '2018-08-27', '2018-11-27', '7', '2018-08-27 02:02:44');
INSERT INTO `sign_record` VALUES ('13', '1', '3', '6', '1500', '2018-08-27', '2018-09-27', '8', '2018-08-27 02:03:19');
INSERT INTO `sign_record` VALUES ('14', '1', '3', '6', '1500', '2018-08-27', '2018-09-27', '9', '2018-08-27 02:04:21');
INSERT INTO `sign_record` VALUES ('15', '1', '5', '9', '2500', '2018-08-28', '2018-09-28', '10', '2018-08-28 02:05:21');
INSERT INTO `sign_record` VALUES ('16', '1', '5', '9', '2500', '2018-08-28', '2018-09-28', '11', '2018-08-28 02:05:56');
INSERT INTO `sign_record` VALUES ('17', '1', '5', '9', '2500', '2018-08-28', '2018-09-28', '12', '2018-08-28 02:06:46');
INSERT INTO `sign_record` VALUES ('18', '1', '5', '10', '6888', '2018-08-28', '2018-11-28', '13', '2018-08-28 02:07:24');
INSERT INTO `sign_record` VALUES ('19', '1', '5', '9', '2500', '2018-08-28', '2018-09-28', '14', '2018-08-28 02:07:52');
INSERT INTO `sign_record` VALUES ('20', '1', '3', '6', '1500', '2018-08-28', '2018-09-28', '15', '2018-08-28 02:08:43');
INSERT INTO `sign_record` VALUES ('21', '1', '3', '6', '1500', '2018-08-28', '2018-09-28', '16', '2018-08-28 02:09:16');
INSERT INTO `sign_record` VALUES ('22', '1', '3', '7', '3888', '2018-08-28', '2018-11-28', '17', '2018-08-28 02:09:46');
INSERT INTO `sign_record` VALUES ('23', '1', '3', '7', '3888', '2018-08-28', '2018-11-28', '18', '2018-08-28 02:10:14');
INSERT INTO `sign_record` VALUES ('24', '1', '3', '6', '1500', '2018-08-28', '2018-09-28', '19', '2018-08-28 02:10:38');
