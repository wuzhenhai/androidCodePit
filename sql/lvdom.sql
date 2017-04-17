/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50709
Source Host           : localhost:3306
Source Database       : think_admin_sys

Target Server Type    : MYSQL
Target Server Version : 50709
File Encoding         : 65001

Date: 2017-04-17 11:05:51
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
INSERT INTO `zxcms_admin` VALUES ('1', '毛神', '21232f297a57a5a743894a0e4a801fc3', '', '-1062728958', '1492397832', '1956186114@qq.com', '', '毛神', '', '1', '1489647846');
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
) ENGINE=InnoDB AUTO_INCREMENT=3872 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of zxcms_admin_log
-- ----------------------------
INSERT INTO `zxcms_admin_log` VALUES ('3822', 'admin', 'Admin', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:25:49');
INSERT INTO `zxcms_admin_log` VALUES ('3823', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:25:51');
INSERT INTO `zxcms_admin_log` VALUES ('3824', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:25:52');
INSERT INTO `zxcms_admin_log` VALUES ('3825', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:25:53');
INSERT INTO `zxcms_admin_log` VALUES ('3826', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:25:54');
INSERT INTO `zxcms_admin_log` VALUES ('3827', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:25:55');
INSERT INTO `zxcms_admin_log` VALUES ('3828', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:25:55');
INSERT INTO `zxcms_admin_log` VALUES ('3829', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:25:57');
INSERT INTO `zxcms_admin_log` VALUES ('3830', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:25:57');
INSERT INTO `zxcms_admin_log` VALUES ('3831', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:25:58');
INSERT INTO `zxcms_admin_log` VALUES ('3832', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:25:59');
INSERT INTO `zxcms_admin_log` VALUES ('3833', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:25:59');
INSERT INTO `zxcms_admin_log` VALUES ('3834', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:26:00');
INSERT INTO `zxcms_admin_log` VALUES ('3835', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:26:00');
INSERT INTO `zxcms_admin_log` VALUES ('3836', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:26:01');
INSERT INTO `zxcms_admin_log` VALUES ('3837', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:26:01');
INSERT INTO `zxcms_admin_log` VALUES ('3838', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:26:01');
INSERT INTO `zxcms_admin_log` VALUES ('3839', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:26:02');
INSERT INTO `zxcms_admin_log` VALUES ('3840', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:26:02');
INSERT INTO `zxcms_admin_log` VALUES ('3841', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:26:03');
INSERT INTO `zxcms_admin_log` VALUES ('3842', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:26:03');
INSERT INTO `zxcms_admin_log` VALUES ('3843', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:26:04');
INSERT INTO `zxcms_admin_log` VALUES ('3844', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:26:05');
INSERT INTO `zxcms_admin_log` VALUES ('3845', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:26:06');
INSERT INTO `zxcms_admin_log` VALUES ('3846', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:26:06');
INSERT INTO `zxcms_admin_log` VALUES ('3847', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:26:07');
INSERT INTO `zxcms_admin_log` VALUES ('3848', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:26:08');
INSERT INTO `zxcms_admin_log` VALUES ('3849', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:26:09');
INSERT INTO `zxcms_admin_log` VALUES ('3850', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:26:10');
INSERT INTO `zxcms_admin_log` VALUES ('3851', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 17:26:11');
INSERT INTO `zxcms_admin_log` VALUES ('3852', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 18:38:39');
INSERT INTO `zxcms_admin_log` VALUES ('3853', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 18:38:40');
INSERT INTO `zxcms_admin_log` VALUES ('3854', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 18:38:44');
INSERT INTO `zxcms_admin_log` VALUES ('3855', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 18:40:31');
INSERT INTO `zxcms_admin_log` VALUES ('3856', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-14 18:40:32');
INSERT INTO `zxcms_admin_log` VALUES ('3857', 'admin', 'Index', 'favicon.ico', '', '1', '毛神', '-1062728958', '2017-04-17 10:57:15');
INSERT INTO `zxcms_admin_log` VALUES ('3858', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-17 10:57:16');
INSERT INTO `zxcms_admin_log` VALUES ('3859', 'admin', 'Topic', 'favicon.ico', '', '1', '毛神', '-1062728958', '2017-04-17 10:57:17');
INSERT INTO `zxcms_admin_log` VALUES ('3860', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-17 10:57:21');
INSERT INTO `zxcms_admin_log` VALUES ('3861', 'admin', 'Skill', 'favicon.ico', '', '1', '毛神', '-1062728958', '2017-04-17 10:57:21');
INSERT INTO `zxcms_admin_log` VALUES ('3862', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-17 11:04:10');
INSERT INTO `zxcms_admin_log` VALUES ('3863', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-17 11:04:11');
INSERT INTO `zxcms_admin_log` VALUES ('3864', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-17 11:04:12');
INSERT INTO `zxcms_admin_log` VALUES ('3865', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-17 11:04:13');
INSERT INTO `zxcms_admin_log` VALUES ('3866', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-17 11:04:13');
INSERT INTO `zxcms_admin_log` VALUES ('3867', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-17 11:04:13');
INSERT INTO `zxcms_admin_log` VALUES ('3868', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-17 11:04:14');
INSERT INTO `zxcms_admin_log` VALUES ('3869', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-17 11:04:14');
INSERT INTO `zxcms_admin_log` VALUES ('3870', 'admin', 'Skill', 'index', '', '1', '毛神', '-1062728958', '2017-04-17 11:04:15');
INSERT INTO `zxcms_admin_log` VALUES ('3871', 'admin', 'Topic', 'index', '', '1', '毛神', '-1062728958', '2017-04-17 11:04:15');

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
  `article_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '文章id',
  `article_diff` varchar(10) CHARACTER SET utf8 DEFAULT NULL COMMENT '文章难度',
  `article_url` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '文章的url',
  `article_content` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `article_pic` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `article_title` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '文章标题',
  `user_id` int(11) unsigned zerofill DEFAULT NULL COMMENT '文章发布者',
  `article_group_name` varchar(255) CHARACTER SET utf8 DEFAULT '',
  `user_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `tech_name` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '大类标签',
  `tech_id` int(11) NOT NULL,
  `module_id` int(11) DEFAULT NULL,
  `module_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `topic_id` int(11) NOT NULL,
  `topic_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`article_id`)
) ENGINE=MyISAM AUTO_INCREMENT=69 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of zxcms_article
-- ----------------------------
INSERT INTO `zxcms_article` VALUES ('66', '1 ', 'http://www.devstore.cn/essay/essayInfo/4187.html?utm_source=tuicool&utm_medium=referral', '', 'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3794412597,3281047334&fm=23&gp=0.jpg', '5个Android开发中比较常见的内存泄漏问题及解决办法', '00000000001', '', 'admin', '1489642916', 'Android', '1', '6', '其它', '9', '性能优化');
INSERT INTO `zxcms_article` VALUES ('67', '1 ', 'https://github.com/GcsSloop/AndroidNote/tree/master/CustomView', '', 'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=531054887,3910685704&fm=23&gp=0.jpg', '自定义View系列', '00000000001', '', 'admin', '1489643123', 'Android', '1', '4', 'UI界面', '10', '自定义View');
INSERT INTO `zxcms_article` VALUES ('65', '1 ', 'http://www.jianshu.com/p/f68d6ef2dcf0', '', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=717801912,1001476792&fm=23&gp=0.jpg', 'Final of Java，这一篇差不多了', '00000000001', '', 'admin', '1489640662', 'Android', '1', '2', 'java基础', '8', '关键字');

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
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

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
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of zxcms_topic
-- ----------------------------
INSERT INTO `zxcms_topic` VALUES ('1', 'Activity', '1', '00000000000');

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
