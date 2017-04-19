/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50709
Source Host           : localhost:3306
Source Database       : think_admin_sys

Target Server Type    : MYSQL
Target Server Version : 50709
File Encoding         : 65001

Date: 2017-04-19 13:12:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tp_admins
-- ----------------------------
DROP TABLE IF EXISTS `tp_admins`;
CREATE TABLE `tp_admins` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(80) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '密码MD5',
  `salt` char(6) NOT NULL DEFAULT '',
  `realname` varchar(60) DEFAULT '' COMMENT '联系人',
  `avatar` varchar(200) DEFAULT '' COMMENT '头像',
  `gender` tinyint(1) DEFAULT '0' COMMENT '性别, 0保密, 1男 2女',
  `mobile` varchar(20) DEFAULT '' COMMENT '手机',
  `email` varchar(200) DEFAULT '' COMMENT '邮件',
  `last_ip` varchar(15) DEFAULT '' COMMENT '最后登录IP',
  `last_time` int(10) DEFAULT '0' COMMENT '最后登录时间',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态, 0 锁定, 1 正常',
  `remark` varchar(400) DEFAULT '' COMMENT '锁定说明',
  `add_time` int(10) NOT NULL COMMENT '添加时间',
  `del_time` int(10) DEFAULT NULL COMMENT '删除时间',
  `creat_time` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `ip` (`last_ip`),
  KEY `time` (`add_time`,`last_time`),
  KEY `del` (`del_time`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='管理员';

-- ----------------------------
-- Records of tp_admins
-- ----------------------------
INSERT INTO `tp_admins` VALUES ('1', 'admin', 'd45e845aa4bdf6e32aa39b70274d259c', 'kmPaTp', 'Admin', '', '0', '12345678901', 'cbwfree@163.com', '', '0', '1', '', '1471428121', null, '0');

-- ----------------------------
-- Table structure for tp_setting
-- ----------------------------
DROP TABLE IF EXISTS `tp_setting`;
CREATE TABLE `tp_setting` (
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '设置名',
  `value` text NOT NULL COMMENT '设置值(JSON数据)',
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='设置';

-- ----------------------------
-- Records of tp_setting
-- ----------------------------

-- ----------------------------
-- Table structure for zxcms_admin
-- ----------------------------
DROP TABLE IF EXISTS `zxcms_admin`;
CREATE TABLE `zxcms_admin` (
  `id` mediumint(6) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) NOT NULL DEFAULT '',
  `encrypt` varchar(6) NOT NULL DEFAULT '',
  `lastloginip` int(10) NOT NULL DEFAULT '0',
  `lastlogintime` int(10) unsigned NOT NULL DEFAULT '0',
  `email` varchar(40) NOT NULL DEFAULT '',
  `mobile` varchar(11) NOT NULL DEFAULT '',
  `realname` varchar(50) NOT NULL DEFAULT '',
  `openid` varchar(255) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(2:无效,1:有效)',
  `updatetime` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of zxcms_admin
-- ----------------------------
INSERT INTO `zxcms_admin` VALUES ('1', '毛神', '21232f297a57a5a743894a0e4a801fc3', '', '-1062728958', '1492576735', '1956186114@qq.com', '', '毛神', '', '1', '1489647846');
INSERT INTO `zxcms_admin` VALUES ('2', 'zhenxun', 'c2785bf6585103658d34413683ac36f8', '', '2130706433', '1476067533', '', '18888873646', '', '', '1', '1476067742');
INSERT INTO `zxcms_admin` VALUES ('4', '毛振坚', 'e10adc3949ba59abbe56e057f20f883e', '', '2130706433', '1488871314', '598750822', '15757855290', '毛振坚', '', '1', '0');

-- ----------------------------
-- Table structure for zxcms_admin_group
-- ----------------------------
DROP TABLE IF EXISTS `zxcms_admin_group`;
CREATE TABLE `zxcms_admin_group` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` text,
  `rules` varchar(500) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id，多个规则 , 隔开',
  `listorder` smallint(5) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `listorder` (`listorder`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of zxcms_admin_group
-- ----------------------------
INSERT INTO `zxcms_admin_group` VALUES ('1', '普通管理员', '密码加密只是MD5', '', '0', '1477622552');
INSERT INTO `zxcms_admin_group` VALUES ('2', '工作人员', '仅拥有日志管理权限', '18,23,27', '0', '1476067479');

-- ----------------------------
-- Table structure for zxcms_admin_group_access
-- ----------------------------
DROP TABLE IF EXISTS `zxcms_admin_group_access`;
CREATE TABLE `zxcms_admin_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of zxcms_admin_group_access
-- ----------------------------
INSERT INTO `zxcms_admin_group_access` VALUES ('2', '2');
INSERT INTO `zxcms_admin_group_access` VALUES ('4', '2');

-- ----------------------------
-- Table structure for zxcms_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `zxcms_admin_log`;
CREATE TABLE `zxcms_admin_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `m` varchar(15) NOT NULL,
  `c` varchar(20) NOT NULL,
  `a` varchar(20) NOT NULL,
  `querystring` varchar(255) NOT NULL,
  `userid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `username` varchar(20) NOT NULL,
  `ip` int(10) NOT NULL,
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4631 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of zxcms_admin_log
-- ----------------------------
INSERT INTO `zxcms_admin_log` VALUES ('4269', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 11:47:11');
INSERT INTO `zxcms_admin_log` VALUES ('4270', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 11:47:12');
INSERT INTO `zxcms_admin_log` VALUES ('4271', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 11:47:12');
INSERT INTO `zxcms_admin_log` VALUES ('4272', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 11:47:13');
INSERT INTO `zxcms_admin_log` VALUES ('4273', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 11:47:13');
INSERT INTO `zxcms_admin_log` VALUES ('4274', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:54:40');
INSERT INTO `zxcms_admin_log` VALUES ('4275', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:54:41');
INSERT INTO `zxcms_admin_log` VALUES ('4276', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:54:42');
INSERT INTO `zxcms_admin_log` VALUES ('4277', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:54:42');
INSERT INTO `zxcms_admin_log` VALUES ('4278', 'admin', 'Article', 'del', '', '1', '毛神', '-1062728958', '2017-04-18 12:54:45');
INSERT INTO `zxcms_admin_log` VALUES ('4279', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:54:45');
INSERT INTO `zxcms_admin_log` VALUES ('4280', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:54:49');
INSERT INTO `zxcms_admin_log` VALUES ('4281', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:55:15');
INSERT INTO `zxcms_admin_log` VALUES ('4282', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-18 12:56:25');
INSERT INTO `zxcms_admin_log` VALUES ('4283', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-18 12:56:29');
INSERT INTO `zxcms_admin_log` VALUES ('4284', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-18 12:56:31');
INSERT INTO `zxcms_admin_log` VALUES ('4285', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-18 12:56:34');
INSERT INTO `zxcms_admin_log` VALUES ('4286', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-18 12:56:35');
INSERT INTO `zxcms_admin_log` VALUES ('4287', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-18 12:56:37');
INSERT INTO `zxcms_admin_log` VALUES ('4288', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:56:40');
INSERT INTO `zxcms_admin_log` VALUES ('4289', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:56:43');
INSERT INTO `zxcms_admin_log` VALUES ('4290', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:56:46');
INSERT INTO `zxcms_admin_log` VALUES ('4291', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:56:47');
INSERT INTO `zxcms_admin_log` VALUES ('4292', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:56:51');
INSERT INTO `zxcms_admin_log` VALUES ('4293', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:56:53');
INSERT INTO `zxcms_admin_log` VALUES ('4294', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:56:57');
INSERT INTO `zxcms_admin_log` VALUES ('4295', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:56:59');
INSERT INTO `zxcms_admin_log` VALUES ('4296', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:57:00');
INSERT INTO `zxcms_admin_log` VALUES ('4297', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:57:01');
INSERT INTO `zxcms_admin_log` VALUES ('4298', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:57:05');
INSERT INTO `zxcms_admin_log` VALUES ('4299', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:57:07');
INSERT INTO `zxcms_admin_log` VALUES ('4300', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:57:07');
INSERT INTO `zxcms_admin_log` VALUES ('4301', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:57:09');
INSERT INTO `zxcms_admin_log` VALUES ('4302', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:57:09');
INSERT INTO `zxcms_admin_log` VALUES ('4303', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:57:22');
INSERT INTO `zxcms_admin_log` VALUES ('4304', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:57:26');
INSERT INTO `zxcms_admin_log` VALUES ('4305', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:57:28');
INSERT INTO `zxcms_admin_log` VALUES ('4306', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:57:29');
INSERT INTO `zxcms_admin_log` VALUES ('4307', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:57:30');
INSERT INTO `zxcms_admin_log` VALUES ('4308', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:57:31');
INSERT INTO `zxcms_admin_log` VALUES ('4309', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:57:37');
INSERT INTO `zxcms_admin_log` VALUES ('4310', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 12:57:37');
INSERT INTO `zxcms_admin_log` VALUES ('4311', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:01:55');
INSERT INTO `zxcms_admin_log` VALUES ('4312', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:01:55');
INSERT INTO `zxcms_admin_log` VALUES ('4313', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:01:56');
INSERT INTO `zxcms_admin_log` VALUES ('4314', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:01:57');
INSERT INTO `zxcms_admin_log` VALUES ('4315', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:01:57');
INSERT INTO `zxcms_admin_log` VALUES ('4316', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:02:00');
INSERT INTO `zxcms_admin_log` VALUES ('4317', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:02:00');
INSERT INTO `zxcms_admin_log` VALUES ('4318', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:02:41');
INSERT INTO `zxcms_admin_log` VALUES ('4319', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:02:42');
INSERT INTO `zxcms_admin_log` VALUES ('4320', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:02:43');
INSERT INTO `zxcms_admin_log` VALUES ('4321', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:02:43');
INSERT INTO `zxcms_admin_log` VALUES ('4322', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:03:02');
INSERT INTO `zxcms_admin_log` VALUES ('4323', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:03:03');
INSERT INTO `zxcms_admin_log` VALUES ('4324', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:05:37');
INSERT INTO `zxcms_admin_log` VALUES ('4325', 'admin', 'Index', 'favicon.ico', '', '1', '毛神', '-1062728958', '2017-04-18 13:05:40');
INSERT INTO `zxcms_admin_log` VALUES ('4326', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:05:42');
INSERT INTO `zxcms_admin_log` VALUES ('4327', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:05:43');
INSERT INTO `zxcms_admin_log` VALUES ('4328', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:05:44');
INSERT INTO `zxcms_admin_log` VALUES ('4329', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:05:44');
INSERT INTO `zxcms_admin_log` VALUES ('4330', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:05:45');
INSERT INTO `zxcms_admin_log` VALUES ('4331', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:05:45');
INSERT INTO `zxcms_admin_log` VALUES ('4332', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:05:46');
INSERT INTO `zxcms_admin_log` VALUES ('4333', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:05:55');
INSERT INTO `zxcms_admin_log` VALUES ('4334', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:13:17');
INSERT INTO `zxcms_admin_log` VALUES ('4335', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:20:08');
INSERT INTO `zxcms_admin_log` VALUES ('4336', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:20:09');
INSERT INTO `zxcms_admin_log` VALUES ('4337', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:24:10');
INSERT INTO `zxcms_admin_log` VALUES ('4338', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:24:11');
INSERT INTO `zxcms_admin_log` VALUES ('4339', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:24:11');
INSERT INTO `zxcms_admin_log` VALUES ('4340', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:24:19');
INSERT INTO `zxcms_admin_log` VALUES ('4341', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:24:27');
INSERT INTO `zxcms_admin_log` VALUES ('4342', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:24:28');
INSERT INTO `zxcms_admin_log` VALUES ('4343', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:24:38');
INSERT INTO `zxcms_admin_log` VALUES ('4344', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:26:47');
INSERT INTO `zxcms_admin_log` VALUES ('4345', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:27:03');
INSERT INTO `zxcms_admin_log` VALUES ('4346', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:27:25');
INSERT INTO `zxcms_admin_log` VALUES ('4347', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-18 13:27:30');
INSERT INTO `zxcms_admin_log` VALUES ('4348', 'admin', 'Article', 'add', '', '1', '毛神', '-1062728958', '2017-04-18 13:27:32');
INSERT INTO `zxcms_admin_log` VALUES ('4349', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:27:32');
INSERT INTO `zxcms_admin_log` VALUES ('4350', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-18 13:27:43');
INSERT INTO `zxcms_admin_log` VALUES ('4351', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-18 13:27:44');
INSERT INTO `zxcms_admin_log` VALUES ('4352', 'admin', 'Article', 'add', '', '1', '毛神', '-1062728958', '2017-04-18 13:27:45');
INSERT INTO `zxcms_admin_log` VALUES ('4353', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:27:45');
INSERT INTO `zxcms_admin_log` VALUES ('4354', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:27:49');
INSERT INTO `zxcms_admin_log` VALUES ('4355', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:29:50');
INSERT INTO `zxcms_admin_log` VALUES ('4356', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-18 13:30:00');
INSERT INTO `zxcms_admin_log` VALUES ('4357', 'admin', 'Article', 'add', '', '1', '毛神', '-1062728958', '2017-04-18 13:30:01');
INSERT INTO `zxcms_admin_log` VALUES ('4358', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:30:02');
INSERT INTO `zxcms_admin_log` VALUES ('4359', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:30:04');
INSERT INTO `zxcms_admin_log` VALUES ('4360', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:30:06');
INSERT INTO `zxcms_admin_log` VALUES ('4361', 'admin', 'Article', 'acccc', '', '1', '毛神', '-1062728958', '2017-04-18 13:33:54');
INSERT INTO `zxcms_admin_log` VALUES ('4362', 'admin', 'Article', 'acccc', '', '1', '毛神', '-1062728958', '2017-04-18 13:33:58');
INSERT INTO `zxcms_admin_log` VALUES ('4363', 'admin', 'Article', 'acccc', '', '1', '毛神', '-1062728958', '2017-04-18 13:34:00');
INSERT INTO `zxcms_admin_log` VALUES ('4364', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:36:53');
INSERT INTO `zxcms_admin_log` VALUES ('4365', 'admin', 'Menu', 'info', '?parentid=38', '1', '毛神', '-1062728958', '2017-04-18 13:38:02');
INSERT INTO `zxcms_admin_log` VALUES ('4366', 'admin', 'Menu', 'favicon.ico', '', '1', '毛神', '-1062728958', '2017-04-18 13:38:02');
INSERT INTO `zxcms_admin_log` VALUES ('4367', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:38:08');
INSERT INTO `zxcms_admin_log` VALUES ('4368', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:39:16');
INSERT INTO `zxcms_admin_log` VALUES ('4369', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:39:52');
INSERT INTO `zxcms_admin_log` VALUES ('4370', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:40:18');
INSERT INTO `zxcms_admin_log` VALUES ('4371', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:41:32');
INSERT INTO `zxcms_admin_log` VALUES ('4372', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:42:34');
INSERT INTO `zxcms_admin_log` VALUES ('4373', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:42:57');
INSERT INTO `zxcms_admin_log` VALUES ('4374', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:43:31');
INSERT INTO `zxcms_admin_log` VALUES ('4375', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:43:37');
INSERT INTO `zxcms_admin_log` VALUES ('4376', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:43:51');
INSERT INTO `zxcms_admin_log` VALUES ('4377', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:44:01');
INSERT INTO `zxcms_admin_log` VALUES ('4378', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:44:43');
INSERT INTO `zxcms_admin_log` VALUES ('4379', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:49:31');
INSERT INTO `zxcms_admin_log` VALUES ('4380', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:49:41');
INSERT INTO `zxcms_admin_log` VALUES ('4381', 'admin', 'Admin', 'public_edit_info', '', '1', '毛神', '-1062728958', '2017-04-18 13:49:50');
INSERT INTO `zxcms_admin_log` VALUES ('4382', 'admin', 'Admin', 'public_edit_info', '', '1', '毛神', '-1062728958', '2017-04-18 13:49:51');
INSERT INTO `zxcms_admin_log` VALUES ('4383', 'admin', 'Admin', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:49:55');
INSERT INTO `zxcms_admin_log` VALUES ('4384', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 13:50:44');
INSERT INTO `zxcms_admin_log` VALUES ('4385', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 14:14:42');
INSERT INTO `zxcms_admin_log` VALUES ('4386', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:10:31');
INSERT INTO `zxcms_admin_log` VALUES ('4387', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:11:07');
INSERT INTO `zxcms_admin_log` VALUES ('4388', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:11:09');
INSERT INTO `zxcms_admin_log` VALUES ('4389', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:11:13');
INSERT INTO `zxcms_admin_log` VALUES ('4390', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:13:18');
INSERT INTO `zxcms_admin_log` VALUES ('4391', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:20:44');
INSERT INTO `zxcms_admin_log` VALUES ('4392', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:20:49');
INSERT INTO `zxcms_admin_log` VALUES ('4393', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:22:18');
INSERT INTO `zxcms_admin_log` VALUES ('4394', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:22:36');
INSERT INTO `zxcms_admin_log` VALUES ('4395', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:25:44');
INSERT INTO `zxcms_admin_log` VALUES ('4396', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:28:25');
INSERT INTO `zxcms_admin_log` VALUES ('4397', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:28:25');
INSERT INTO `zxcms_admin_log` VALUES ('4398', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:28:28');
INSERT INTO `zxcms_admin_log` VALUES ('4399', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:28:28');
INSERT INTO `zxcms_admin_log` VALUES ('4400', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:28:29');
INSERT INTO `zxcms_admin_log` VALUES ('4401', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:28:29');
INSERT INTO `zxcms_admin_log` VALUES ('4402', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:28:30');
INSERT INTO `zxcms_admin_log` VALUES ('4403', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:28:30');
INSERT INTO `zxcms_admin_log` VALUES ('4404', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:28:31');
INSERT INTO `zxcms_admin_log` VALUES ('4405', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:28:31');
INSERT INTO `zxcms_admin_log` VALUES ('4406', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:28:32');
INSERT INTO `zxcms_admin_log` VALUES ('4407', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:28:32');
INSERT INTO `zxcms_admin_log` VALUES ('4408', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:28:33');
INSERT INTO `zxcms_admin_log` VALUES ('4409', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:28:33');
INSERT INTO `zxcms_admin_log` VALUES ('4410', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:28:35');
INSERT INTO `zxcms_admin_log` VALUES ('4411', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:28:35');
INSERT INTO `zxcms_admin_log` VALUES ('4412', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:28:35');
INSERT INTO `zxcms_admin_log` VALUES ('4413', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:28:36');
INSERT INTO `zxcms_admin_log` VALUES ('4414', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:28:36');
INSERT INTO `zxcms_admin_log` VALUES ('4415', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:28:36');
INSERT INTO `zxcms_admin_log` VALUES ('4416', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:29:34');
INSERT INTO `zxcms_admin_log` VALUES ('4417', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:29:35');
INSERT INTO `zxcms_admin_log` VALUES ('4418', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:29:36');
INSERT INTO `zxcms_admin_log` VALUES ('4419', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:29:36');
INSERT INTO `zxcms_admin_log` VALUES ('4420', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:29:37');
INSERT INTO `zxcms_admin_log` VALUES ('4421', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:29:37');
INSERT INTO `zxcms_admin_log` VALUES ('4422', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:29:38');
INSERT INTO `zxcms_admin_log` VALUES ('4423', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:29:38');
INSERT INTO `zxcms_admin_log` VALUES ('4424', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:29:38');
INSERT INTO `zxcms_admin_log` VALUES ('4425', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:29:39');
INSERT INTO `zxcms_admin_log` VALUES ('4426', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:30:43');
INSERT INTO `zxcms_admin_log` VALUES ('4427', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:30:46');
INSERT INTO `zxcms_admin_log` VALUES ('4428', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:30:46');
INSERT INTO `zxcms_admin_log` VALUES ('4429', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:30:48');
INSERT INTO `zxcms_admin_log` VALUES ('4430', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:30:48');
INSERT INTO `zxcms_admin_log` VALUES ('4431', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:30:49');
INSERT INTO `zxcms_admin_log` VALUES ('4432', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:30:49');
INSERT INTO `zxcms_admin_log` VALUES ('4433', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:30:50');
INSERT INTO `zxcms_admin_log` VALUES ('4434', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:30:50');
INSERT INTO `zxcms_admin_log` VALUES ('4435', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:30:51');
INSERT INTO `zxcms_admin_log` VALUES ('4436', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:30:51');
INSERT INTO `zxcms_admin_log` VALUES ('4437', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:30:52');
INSERT INTO `zxcms_admin_log` VALUES ('4438', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:30:52');
INSERT INTO `zxcms_admin_log` VALUES ('4439', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:30:52');
INSERT INTO `zxcms_admin_log` VALUES ('4440', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:30:52');
INSERT INTO `zxcms_admin_log` VALUES ('4441', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:30:54');
INSERT INTO `zxcms_admin_log` VALUES ('4442', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:30:54');
INSERT INTO `zxcms_admin_log` VALUES ('4443', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:30:55');
INSERT INTO `zxcms_admin_log` VALUES ('4444', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:30:55');
INSERT INTO `zxcms_admin_log` VALUES ('4445', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:30:56');
INSERT INTO `zxcms_admin_log` VALUES ('4446', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:30:57');
INSERT INTO `zxcms_admin_log` VALUES ('4447', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:30:58');
INSERT INTO `zxcms_admin_log` VALUES ('4448', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:30:58');
INSERT INTO `zxcms_admin_log` VALUES ('4449', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:30:59');
INSERT INTO `zxcms_admin_log` VALUES ('4450', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:30:59');
INSERT INTO `zxcms_admin_log` VALUES ('4451', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:31:33');
INSERT INTO `zxcms_admin_log` VALUES ('4452', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:31:43');
INSERT INTO `zxcms_admin_log` VALUES ('4453', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:31:45');
INSERT INTO `zxcms_admin_log` VALUES ('4454', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:32:15');
INSERT INTO `zxcms_admin_log` VALUES ('4455', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:32:26');
INSERT INTO `zxcms_admin_log` VALUES ('4456', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:38:02');
INSERT INTO `zxcms_admin_log` VALUES ('4457', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:50:16');
INSERT INTO `zxcms_admin_log` VALUES ('4458', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:51:34');
INSERT INTO `zxcms_admin_log` VALUES ('4459', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:51:35');
INSERT INTO `zxcms_admin_log` VALUES ('4460', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:51:36');
INSERT INTO `zxcms_admin_log` VALUES ('4461', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:52:22');
INSERT INTO `zxcms_admin_log` VALUES ('4462', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:52:22');
INSERT INTO `zxcms_admin_log` VALUES ('4463', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:52:22');
INSERT INTO `zxcms_admin_log` VALUES ('4464', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:52:23');
INSERT INTO `zxcms_admin_log` VALUES ('4465', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:52:23');
INSERT INTO `zxcms_admin_log` VALUES ('4466', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:52:23');
INSERT INTO `zxcms_admin_log` VALUES ('4467', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:52:51');
INSERT INTO `zxcms_admin_log` VALUES ('4468', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:52:51');
INSERT INTO `zxcms_admin_log` VALUES ('4469', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:52:52');
INSERT INTO `zxcms_admin_log` VALUES ('4470', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:52:52');
INSERT INTO `zxcms_admin_log` VALUES ('4471', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:52:52');
INSERT INTO `zxcms_admin_log` VALUES ('4472', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:52:52');
INSERT INTO `zxcms_admin_log` VALUES ('4473', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:52:53');
INSERT INTO `zxcms_admin_log` VALUES ('4474', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:52:54');
INSERT INTO `zxcms_admin_log` VALUES ('4475', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:52:54');
INSERT INTO `zxcms_admin_log` VALUES ('4476', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:52:54');
INSERT INTO `zxcms_admin_log` VALUES ('4477', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:52:54');
INSERT INTO `zxcms_admin_log` VALUES ('4478', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:54:02');
INSERT INTO `zxcms_admin_log` VALUES ('4479', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:54:02');
INSERT INTO `zxcms_admin_log` VALUES ('4480', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:55:54');
INSERT INTO `zxcms_admin_log` VALUES ('4481', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:55:55');
INSERT INTO `zxcms_admin_log` VALUES ('4482', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:55:56');
INSERT INTO `zxcms_admin_log` VALUES ('4483', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:55:56');
INSERT INTO `zxcms_admin_log` VALUES ('4484', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:56:00');
INSERT INTO `zxcms_admin_log` VALUES ('4485', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:56:01');
INSERT INTO `zxcms_admin_log` VALUES ('4486', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:56:01');
INSERT INTO `zxcms_admin_log` VALUES ('4487', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:56:02');
INSERT INTO `zxcms_admin_log` VALUES ('4488', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:56:03');
INSERT INTO `zxcms_admin_log` VALUES ('4489', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:56:03');
INSERT INTO `zxcms_admin_log` VALUES ('4490', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:56:14');
INSERT INTO `zxcms_admin_log` VALUES ('4491', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:56:15');
INSERT INTO `zxcms_admin_log` VALUES ('4492', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:56:15');
INSERT INTO `zxcms_admin_log` VALUES ('4493', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:56:15');
INSERT INTO `zxcms_admin_log` VALUES ('4494', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:56:18');
INSERT INTO `zxcms_admin_log` VALUES ('4495', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:56:18');
INSERT INTO `zxcms_admin_log` VALUES ('4496', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:56:18');
INSERT INTO `zxcms_admin_log` VALUES ('4497', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:56:18');
INSERT INTO `zxcms_admin_log` VALUES ('4498', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:56:29');
INSERT INTO `zxcms_admin_log` VALUES ('4499', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:56:29');
INSERT INTO `zxcms_admin_log` VALUES ('4500', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 15:56:29');
INSERT INTO `zxcms_admin_log` VALUES ('4501', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:56:29');
INSERT INTO `zxcms_admin_log` VALUES ('4502', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:56:46');
INSERT INTO `zxcms_admin_log` VALUES ('4503', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:56:47');
INSERT INTO `zxcms_admin_log` VALUES ('4504', 'admin', 'Admin', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:56:48');
INSERT INTO `zxcms_admin_log` VALUES ('4505', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:57:02');
INSERT INTO `zxcms_admin_log` VALUES ('4506', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:57:05');
INSERT INTO `zxcms_admin_log` VALUES ('4507', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-18 15:57:18');
INSERT INTO `zxcms_admin_log` VALUES ('4508', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:59:56');
INSERT INTO `zxcms_admin_log` VALUES ('4509', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:59:59');
INSERT INTO `zxcms_admin_log` VALUES ('4510', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 15:59:59');
INSERT INTO `zxcms_admin_log` VALUES ('4511', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:00:00');
INSERT INTO `zxcms_admin_log` VALUES ('4512', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:00:00');
INSERT INTO `zxcms_admin_log` VALUES ('4513', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:09:29');
INSERT INTO `zxcms_admin_log` VALUES ('4514', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:09:30');
INSERT INTO `zxcms_admin_log` VALUES ('4515', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:09:31');
INSERT INTO `zxcms_admin_log` VALUES ('4516', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:09:32');
INSERT INTO `zxcms_admin_log` VALUES ('4517', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:09:32');
INSERT INTO `zxcms_admin_log` VALUES ('4518', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:09:33');
INSERT INTO `zxcms_admin_log` VALUES ('4519', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:15:50');
INSERT INTO `zxcms_admin_log` VALUES ('4520', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 16:15:55');
INSERT INTO `zxcms_admin_log` VALUES ('4521', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:15:55');
INSERT INTO `zxcms_admin_log` VALUES ('4522', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 16:15:56');
INSERT INTO `zxcms_admin_log` VALUES ('4523', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:15:56');
INSERT INTO `zxcms_admin_log` VALUES ('4524', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 16:15:56');
INSERT INTO `zxcms_admin_log` VALUES ('4525', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:15:56');
INSERT INTO `zxcms_admin_log` VALUES ('4526', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 16:15:57');
INSERT INTO `zxcms_admin_log` VALUES ('4527', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:15:57');
INSERT INTO `zxcms_admin_log` VALUES ('4528', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-18 16:15:58');
INSERT INTO `zxcms_admin_log` VALUES ('4529', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:15:58');
INSERT INTO `zxcms_admin_log` VALUES ('4530', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:18:52');
INSERT INTO `zxcms_admin_log` VALUES ('4531', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:22:37');
INSERT INTO `zxcms_admin_log` VALUES ('4532', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:23:18');
INSERT INTO `zxcms_admin_log` VALUES ('4533', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:23:19');
INSERT INTO `zxcms_admin_log` VALUES ('4534', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:25:34');
INSERT INTO `zxcms_admin_log` VALUES ('4535', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:25:35');
INSERT INTO `zxcms_admin_log` VALUES ('4536', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:42:42');
INSERT INTO `zxcms_admin_log` VALUES ('4537', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-18 16:42:48');
INSERT INTO `zxcms_admin_log` VALUES ('4538', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-18 16:42:49');
INSERT INTO `zxcms_admin_log` VALUES ('4539', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-18 16:42:55');
INSERT INTO `zxcms_admin_log` VALUES ('4540', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-18 16:42:57');
INSERT INTO `zxcms_admin_log` VALUES ('4541', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:43:10');
INSERT INTO `zxcms_admin_log` VALUES ('4542', 'admin', 'Topic', 'add', '', '1', '毛神', '-1062728958', '2017-04-18 16:43:21');
INSERT INTO `zxcms_admin_log` VALUES ('4543', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:43:21');
INSERT INTO `zxcms_admin_log` VALUES ('4544', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:43:23');
INSERT INTO `zxcms_admin_log` VALUES ('4545', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:43:35');
INSERT INTO `zxcms_admin_log` VALUES ('4546', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:43:36');
INSERT INTO `zxcms_admin_log` VALUES ('4547', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-18 16:43:40');
INSERT INTO `zxcms_admin_log` VALUES ('4548', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-18 16:43:41');
INSERT INTO `zxcms_admin_log` VALUES ('4549', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-18 16:43:45');
INSERT INTO `zxcms_admin_log` VALUES ('4550', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-18 16:43:49');
INSERT INTO `zxcms_admin_log` VALUES ('4551', 'admin', 'Article', 'add', '', '1', '毛神', '-1062728958', '2017-04-18 16:43:54');
INSERT INTO `zxcms_admin_log` VALUES ('4552', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:43:54');
INSERT INTO `zxcms_admin_log` VALUES ('4553', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:45:17');
INSERT INTO `zxcms_admin_log` VALUES ('4554', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:45:19');
INSERT INTO `zxcms_admin_log` VALUES ('4555', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:49:10');
INSERT INTO `zxcms_admin_log` VALUES ('4556', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 16:50:17');
INSERT INTO `zxcms_admin_log` VALUES ('4557', 'admin', 'Index', 'favicon.ico', '', '1', '毛神', '-1062728958', '2017-04-18 17:55:43');
INSERT INTO `zxcms_admin_log` VALUES ('4558', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 17:55:46');
INSERT INTO `zxcms_admin_log` VALUES ('4559', 'admin', 'Article', 'favicon.ico', '', '1', '毛神', '-1062728958', '2017-04-18 17:55:47');
INSERT INTO `zxcms_admin_log` VALUES ('4560', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 17:55:49');
INSERT INTO `zxcms_admin_log` VALUES ('4561', 'admin', 'Topic', 'favicon.ico', '', '1', '毛神', '-1062728958', '2017-04-18 17:55:50');
INSERT INTO `zxcms_admin_log` VALUES ('4562', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 17:55:50');
INSERT INTO `zxcms_admin_log` VALUES ('4563', 'admin', 'Skill', 'favicon.ico', '', '1', '毛神', '-1062728958', '2017-04-18 17:55:50');
INSERT INTO `zxcms_admin_log` VALUES ('4564', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 17:55:50');
INSERT INTO `zxcms_admin_log` VALUES ('4565', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 17:56:18');
INSERT INTO `zxcms_admin_log` VALUES ('4566', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 17:57:20');
INSERT INTO `zxcms_admin_log` VALUES ('4567', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 17:57:37');
INSERT INTO `zxcms_admin_log` VALUES ('4568', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 18:00:50');
INSERT INTO `zxcms_admin_log` VALUES ('4569', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 18:01:03');
INSERT INTO `zxcms_admin_log` VALUES ('4570', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-18 18:06:26');
INSERT INTO `zxcms_admin_log` VALUES ('4571', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-18 18:06:28');
INSERT INTO `zxcms_admin_log` VALUES ('4572', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-18 18:06:34');
INSERT INTO `zxcms_admin_log` VALUES ('4573', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-18 18:06:42');
INSERT INTO `zxcms_admin_log` VALUES ('4574', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 18:08:51');
INSERT INTO `zxcms_admin_log` VALUES ('4575', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-18 18:46:12');
INSERT INTO `zxcms_admin_log` VALUES ('4576', 'admin', 'Index', 'favicon.ico', '', '1', '毛神', '-1062728958', '2017-04-19 12:38:57');
INSERT INTO `zxcms_admin_log` VALUES ('4577', 'admin', 'Admin', 'public_edit_info', '', '1', '毛神', '-1062728958', '2017-04-19 12:38:59');
INSERT INTO `zxcms_admin_log` VALUES ('4578', 'admin', 'Admin', 'favicon.ico', '', '1', '毛神', '-1062728958', '2017-04-19 12:39:00');
INSERT INTO `zxcms_admin_log` VALUES ('4579', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 12:39:01');
INSERT INTO `zxcms_admin_log` VALUES ('4580', 'admin', 'Article', 'favicon.ico', '', '1', '毛神', '-1062728958', '2017-04-19 12:39:01');
INSERT INTO `zxcms_admin_log` VALUES ('4581', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 12:39:03');
INSERT INTO `zxcms_admin_log` VALUES ('4582', 'admin', 'Topic', 'favicon.ico', '', '1', '毛神', '-1062728958', '2017-04-19 12:39:04');
INSERT INTO `zxcms_admin_log` VALUES ('4583', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 12:39:04');
INSERT INTO `zxcms_admin_log` VALUES ('4584', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-19 12:39:06');
INSERT INTO `zxcms_admin_log` VALUES ('4585', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 12:39:06');
INSERT INTO `zxcms_admin_log` VALUES ('4586', 'admin', 'Article', 'hot', '', '1', '毛神', '-1062728958', '2017-04-19 12:39:24');
INSERT INTO `zxcms_admin_log` VALUES ('4587', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 12:39:24');
INSERT INTO `zxcms_admin_log` VALUES ('4588', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-19 12:45:06');
INSERT INTO `zxcms_admin_log` VALUES ('4589', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-19 12:45:09');
INSERT INTO `zxcms_admin_log` VALUES ('4590', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-19 12:45:11');
INSERT INTO `zxcms_admin_log` VALUES ('4591', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-19 12:45:12');
INSERT INTO `zxcms_admin_log` VALUES ('4592', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-19 12:45:14');
INSERT INTO `zxcms_admin_log` VALUES ('4593', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-19 12:45:17');
INSERT INTO `zxcms_admin_log` VALUES ('4594', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 12:59:12');
INSERT INTO `zxcms_admin_log` VALUES ('4595', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-19 12:59:21');
INSERT INTO `zxcms_admin_log` VALUES ('4596', 'admin', 'Article', 'ajax_topic_list', '', '1', '毛神', '-1062728958', '2017-04-19 12:59:24');
INSERT INTO `zxcms_admin_log` VALUES ('4597', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:00:11');
INSERT INTO `zxcms_admin_log` VALUES ('4598', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:00:32');
INSERT INTO `zxcms_admin_log` VALUES ('4599', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:00:33');
INSERT INTO `zxcms_admin_log` VALUES ('4600', 'admin', 'Skill', 'favicon.ico', '', '1', '毛神', '-1062728958', '2017-04-19 13:00:33');
INSERT INTO `zxcms_admin_log` VALUES ('4601', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:00:34');
INSERT INTO `zxcms_admin_log` VALUES ('4602', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:00:50');
INSERT INTO `zxcms_admin_log` VALUES ('4603', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:00:51');
INSERT INTO `zxcms_admin_log` VALUES ('4604', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:00:59');
INSERT INTO `zxcms_admin_log` VALUES ('4605', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:01:00');
INSERT INTO `zxcms_admin_log` VALUES ('4606', 'admin', 'Article', '会不会', '', '1', '毛神', '-1062728958', '2017-04-19 13:01:06');
INSERT INTO `zxcms_admin_log` VALUES ('4607', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:01:48');
INSERT INTO `zxcms_admin_log` VALUES ('4608', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:05:32');
INSERT INTO `zxcms_admin_log` VALUES ('4609', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:05:34');
INSERT INTO `zxcms_admin_log` VALUES ('4610', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:05:35');
INSERT INTO `zxcms_admin_log` VALUES ('4611', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:05:36');
INSERT INTO `zxcms_admin_log` VALUES ('4612', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:05:37');
INSERT INTO `zxcms_admin_log` VALUES ('4613', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:05:38');
INSERT INTO `zxcms_admin_log` VALUES ('4614', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:05:38');
INSERT INTO `zxcms_admin_log` VALUES ('4615', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:05:39');
INSERT INTO `zxcms_admin_log` VALUES ('4616', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:05:39');
INSERT INTO `zxcms_admin_log` VALUES ('4617', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:05:40');
INSERT INTO `zxcms_admin_log` VALUES ('4618', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:05:40');
INSERT INTO `zxcms_admin_log` VALUES ('4619', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:05:41');
INSERT INTO `zxcms_admin_log` VALUES ('4620', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:05:41');
INSERT INTO `zxcms_admin_log` VALUES ('4621', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:05:42');
INSERT INTO `zxcms_admin_log` VALUES ('4622', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:05:42');
INSERT INTO `zxcms_admin_log` VALUES ('4623', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:09:53');
INSERT INTO `zxcms_admin_log` VALUES ('4624', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:09:53');
INSERT INTO `zxcms_admin_log` VALUES ('4625', 'admin', 'Article', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:09:54');
INSERT INTO `zxcms_admin_log` VALUES ('4626', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:09:55');
INSERT INTO `zxcms_admin_log` VALUES ('4627', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:09:56');
INSERT INTO `zxcms_admin_log` VALUES ('4628', 'admin', 'Topic', 'index', '?skill_type=21', '1', '毛神', '-1062728958', '2017-04-19 13:10:01');
INSERT INTO `zxcms_admin_log` VALUES ('4629', 'admin', 'Topic', 'index', '?skill_type=22', '1', '毛神', '-1062728958', '2017-04-19 13:10:03');
INSERT INTO `zxcms_admin_log` VALUES ('4630', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-19 13:10:06');

-- ----------------------------
-- Table structure for zxcms_app
-- ----------------------------
DROP TABLE IF EXISTS `zxcms_app`;
CREATE TABLE `zxcms_app` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyword` varchar(100) NOT NULL DEFAULT '',
  `price` decimal(10,0) NOT NULL DEFAULT '0',
  `icon` varchar(100) NOT NULL DEFAULT '' COMMENT '图标',
  `total` int(11) NOT NULL DEFAULT '0' COMMENT '数量',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1软件，2游戏，3付费',
  `add_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `user_id` int(11) NOT NULL COMMENT '发布人ID',
  `position` smallint(5) NOT NULL DEFAULT '0' COMMENT '位置',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '标记说明',
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL COMMENT '开始时间',
  `s_time` time DEFAULT NULL,
  `date_total` int(11) DEFAULT NULL,
  `time_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '时间类型：1全天，2时间段',
  PRIMARY KEY (`id`),
  KEY `nums` (`total`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of zxcms_app
-- ----------------------------

-- ----------------------------
-- Table structure for zxcms_article
-- ----------------------------
DROP TABLE IF EXISTS `zxcms_article`;
CREATE TABLE `zxcms_article` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '文章id',
  `url` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '文章的url',
  `desc` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `pic` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '文章标题',
  `user_id` int(11) unsigned zerofill DEFAULT NULL COMMENT '文章发布者',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `skill_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `is_hot` tinyint(1) unsigned zerofill NOT NULL DEFAULT '0' COMMENT '是否设为推荐：0 否；1 是',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=80 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of zxcms_article
-- ----------------------------
INSERT INTO `zxcms_article` VALUES ('73', 'http://mrfu.me/2016/02/28/Glide_Series_Roundup/?hmsr=toutiao.io&utm_medium=toutiao.io&utm_source=toutiao.io', null, null, 'Glide-系列综述', '00000000001', '1492486799', '22', '15', '0');
INSERT INTO `zxcms_article` VALUES ('74', 'http://blog.csdn.net/superbigcupid/article/details/51800194', null, null, 'Glide详解', '00000000001', '1492486827', '22', '18', '0');
INSERT INTO `zxcms_article` VALUES ('76', 'dwwe', null, null, 'dew', '00000000001', '1492493252', '22', '17', '1');
INSERT INTO `zxcms_article` VALUES ('77', 'acccc', null, null, 'aaaaa', '00000000001', '1492493265', '22', '15', '1');
INSERT INTO `zxcms_article` VALUES ('78', 'wqq', null, null, 'QQQQ', '00000000001', '1492493402', '22', '18', '1');
INSERT INTO `zxcms_article` VALUES ('79', '会不会', null, null, '纽约纽约', '00000000001', '1492505034', '24', '19', '0');

-- ----------------------------
-- Table structure for zxcms_article_diff
-- ----------------------------
DROP TABLE IF EXISTS `zxcms_article_diff`;
CREATE TABLE `zxcms_article_diff` (
  `article_diff_id` int(11) NOT NULL AUTO_INCREMENT,
  `article_diff_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`article_diff_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of zxcms_article_diff
-- ----------------------------
INSERT INTO `zxcms_article_diff` VALUES ('1', '入门');
INSERT INTO `zxcms_article_diff` VALUES ('2', '中级');
INSERT INTO `zxcms_article_diff` VALUES ('3', '高级');

-- ----------------------------
-- Table structure for zxcms_config
-- ----------------------------
DROP TABLE IF EXISTS `zxcms_config`;
CREATE TABLE `zxcms_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置说明',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` varchar(100) NOT NULL COMMENT '配置说明',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `value` text NOT NULL COMMENT '配置值',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `type` (`type`),
  KEY `group` (`group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of zxcms_config
-- ----------------------------

-- ----------------------------
-- Table structure for zxcms_menu
-- ----------------------------
DROP TABLE IF EXISTS `zxcms_menu`;
CREATE TABLE `zxcms_menu` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(40) NOT NULL DEFAULT '',
  `parentid` smallint(6) DEFAULT '0',
  `icon` varchar(20) NOT NULL DEFAULT '',
  `c` varchar(20) DEFAULT NULL,
  `a` varchar(20) DEFAULT NULL,
  `data` varchar(50) NOT NULL DEFAULT '',
  `tip` varchar(255) NOT NULL DEFAULT '' COMMENT '提示',
  `group` varchar(50) DEFAULT '' COMMENT '分组',
  `listorder` smallint(6) unsigned NOT NULL DEFAULT '999',
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示(1:显示,2:不显示)',
  `updatetime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `listorder` (`listorder`),
  KEY `parentid` (`parentid`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of zxcms_menu
-- ----------------------------
INSERT INTO `zxcms_menu` VALUES ('1', '管理设置', '0', 'fa-users', 'Admin', 'admin', '', '', '', '99', '1', '1489473100');
INSERT INTO `zxcms_menu` VALUES ('2', '管理员管理', '1', '', 'Admin', 'index', '', '', '', '0', '1', '1489473100');
INSERT INTO `zxcms_menu` VALUES ('3', '详情', '2', '', 'Admin', 'info', '', '', '', '0', '2', '1489473100');
INSERT INTO `zxcms_menu` VALUES ('4', '添加', '2', '', 'Admin', 'add', '', '', '', '0', '2', '1489473100');
INSERT INTO `zxcms_menu` VALUES ('5', '修改', '2', '', 'Admin', 'edit', '', '', '', '0', '2', '1489473100');
INSERT INTO `zxcms_menu` VALUES ('6', '删除', '2', '', 'Admin', 'del', '', '', '', '0', '2', '1489473100');
INSERT INTO `zxcms_menu` VALUES ('7', '分组管理', '1', '', 'Group', 'index', '', '', '', '0', '1', '1489473100');
INSERT INTO `zxcms_menu` VALUES ('8', '详情', '7', '', 'Group', 'info', '', '', '', '0', '2', '1489473100');
INSERT INTO `zxcms_menu` VALUES ('9', '添加', '7', '', 'Group', 'add', '', '', '', '0', '2', '1489473100');
INSERT INTO `zxcms_menu` VALUES ('10', '修改', '7', '', 'Group', 'edit', '', '', '', '0', '2', '1489473100');
INSERT INTO `zxcms_menu` VALUES ('11', '删除', '7', '', 'Group', 'del', '', '', '', '0', '2', '1489473100');
INSERT INTO `zxcms_menu` VALUES ('12', '菜单管理', '18', '', 'Menu', 'index', '', '', '', '0', '1', '1489473100');
INSERT INTO `zxcms_menu` VALUES ('13', '查看', '12', '', 'Menu', 'info', '', '', '', '0', '2', '1489473101');
INSERT INTO `zxcms_menu` VALUES ('14', '添加', '12', '', 'Menu', 'add', '', '', '', '0', '2', '1489473101');
INSERT INTO `zxcms_menu` VALUES ('15', '修改', '12', '', 'Menu', 'edit', '', '', '', '0', '2', '1489473101');
INSERT INTO `zxcms_menu` VALUES ('16', '删除', '12', '', 'Menu', 'del', '', '', '', '0', '2', '1489473101');
INSERT INTO `zxcms_menu` VALUES ('18', '系统设置', '0', 'fa-cogs', 'Menu', 'index', '', '', '', '100', '1', '1489473100');
INSERT INTO `zxcms_menu` VALUES ('22', '权限设置', '2', '', 'Group', 'rule', '', '', '', '999', '2', '1489473100');
INSERT INTO `zxcms_menu` VALUES ('23', '个人设置', '1', '', 'Admin', 'public_edit_info', '', '', '', '999', '1', '1489473100');
INSERT INTO `zxcms_menu` VALUES ('27', '日志管理', '18', '', 'Log', 'index', '', '', '', '999', '1', '1489473101');
INSERT INTO `zxcms_menu` VALUES ('31', '系统首页', '0', 'fa-bank', 'Index', 'index', '', '', '', '0', '1', '1489473099');
INSERT INTO `zxcms_menu` VALUES ('32', '', '13', '', '', '', '', '', '', '999', '1', '1489473101');
INSERT INTO `zxcms_menu` VALUES ('37', '文章管理', '33', '', 'Article', 'index', '', '', '', '999', '1', '1489473100');
INSERT INTO `zxcms_menu` VALUES ('38', '文章管理', '0', 'fa-joomla', '', '', '', '', '', '1', '1', '1492150643');
INSERT INTO `zxcms_menu` VALUES ('41', '技能列表', '38', 'fa-ioxhost', 'Skill', 'index', '', '', '', '999', '1', '1492154818');
INSERT INTO `zxcms_menu` VALUES ('42', '模块列表', '39', '', 'Module', 'index', '', '', '', '999', '1', '1489473245');
INSERT INTO `zxcms_menu` VALUES ('43', '专题列表', '40', '', 'Topic', 'index', '', '', '', '999', '1', null);
INSERT INTO `zxcms_menu` VALUES ('44', '专题管理', '38', 'fa-newspaper-o', 'Topic', 'index', '', '', '', '999', '1', null);
INSERT INTO `zxcms_menu` VALUES ('45', '文章管理', '38', 'fa-book', 'Article', 'index', '', '', '', '999', '1', null);

-- ----------------------------
-- Table structure for zxcms_module_group
-- ----------------------------
DROP TABLE IF EXISTS `zxcms_module_group`;
CREATE TABLE `zxcms_module_group` (
  `module_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '专题id',
  `module_name` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '专题名',
  `tech_id` int(11) unsigned NOT NULL COMMENT '模块id',
  `tech_name` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '模块名',
  PRIMARY KEY (`module_id`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of zxcms_module_group
-- ----------------------------
INSERT INTO `zxcms_module_group` VALUES ('2', 'java基础', '1', 'Android');
INSERT INTO `zxcms_module_group` VALUES ('3', 'Android基本技能', '1', 'Android');
INSERT INTO `zxcms_module_group` VALUES ('4', 'UI界面', '1', 'Android');
INSERT INTO `zxcms_module_group` VALUES ('5', '第三方框架', '1', 'Android');
INSERT INTO `zxcms_module_group` VALUES ('6', '其它', '1', 'Android');
INSERT INTO `zxcms_module_group` VALUES ('1', '全部文章', '1', 'Android');

-- ----------------------------
-- Table structure for zxcms_skill
-- ----------------------------
DROP TABLE IF EXISTS `zxcms_skill`;
CREATE TABLE `zxcms_skill` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '技能id',
  `skill_name` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '技能名称',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of zxcms_skill
-- ----------------------------
INSERT INTO `zxcms_skill` VALUES ('22', 'Android');
INSERT INTO `zxcms_skill` VALUES ('21', 'PHP');
INSERT INTO `zxcms_skill` VALUES ('23', 'iOS');
INSERT INTO `zxcms_skill` VALUES ('24', 'JAVA');
INSERT INTO `zxcms_skill` VALUES ('25', '前端');
INSERT INTO `zxcms_skill` VALUES ('26', 'C\\C++');
INSERT INTO `zxcms_skill` VALUES ('30', 'Python');

-- ----------------------------
-- Table structure for zxcms_topic
-- ----------------------------
DROP TABLE IF EXISTS `zxcms_topic`;
CREATE TABLE `zxcms_topic` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '专题id',
  `topic_name` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '专题名称',
  `skill_id` int(11) unsigned NOT NULL COMMENT '技能id',
  `article_num` int(11) unsigned zerofill NOT NULL DEFAULT '00000000000' COMMENT '文章数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of zxcms_topic
-- ----------------------------
INSERT INTO `zxcms_topic` VALUES ('15', 'Activity', '22', '00000000000');
INSERT INTO `zxcms_topic` VALUES ('17', 'Fragment', '22', '00000000000');
INSERT INTO `zxcms_topic` VALUES ('18', '图片加载框架', '22', '00000000000');
INSERT INTO `zxcms_topic` VALUES ('19', '反射', '24', '00000000000');

-- ----------------------------
-- Table structure for zxcms_topic_group
-- ----------------------------
DROP TABLE IF EXISTS `zxcms_topic_group`;
CREATE TABLE `zxcms_topic_group` (
  `topic_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `topic_name` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '一号标签（大类）',
  `module_id` int(11) unsigned NOT NULL COMMENT '技能分类的id',
  `module_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`topic_id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of zxcms_topic_group
-- ----------------------------
INSERT INTO `zxcms_topic_group` VALUES ('5', '四大组件', '3', 'Android基本技能');
INSERT INTO `zxcms_topic_group` VALUES ('6', '第三方UI框架', '4', 'UI界面');
INSERT INTO `zxcms_topic_group` VALUES ('7', 'Fragment', '3', 'Android基本技能');
INSERT INTO `zxcms_topic_group` VALUES ('8', '关键字', '2', 'java基础');
INSERT INTO `zxcms_topic_group` VALUES ('9', '性能优化', '6', '其它');
INSERT INTO `zxcms_topic_group` VALUES ('10', '自定义View', '4', 'UI界面');
INSERT INTO `zxcms_topic_group` VALUES ('11', '图片缓存框架--UIL', '5', '第三方框架');
INSERT INTO `zxcms_topic_group` VALUES ('12', 'Intent', '3', 'Android基本技能');
INSERT INTO `zxcms_topic_group` VALUES ('13', '面试', '6', '其它');
