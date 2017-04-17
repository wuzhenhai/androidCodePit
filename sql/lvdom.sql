/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50709
Source Host           : localhost:3306
Source Database       : lvdom

Target Server Type    : MYSQL
Target Server Version : 50709
File Encoding         : 65001

Date: 2017-04-17 11:03:20
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for ta_auth_access
-- ----------------------------
DROP TABLE IF EXISTS `ta_auth_access`;
CREATE TABLE `ta_auth_access` (
  `role_id` mediumint(8) unsigned NOT NULL COMMENT '角色',
  `rule_id` mediumint(8) unsigned NOT NULL COMMENT '规则唯一英文标识,全小写',
  KEY `role_id` (`role_id`),
  KEY `rule_name` (`rule_id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='权限授权表';

-- ----------------------------
-- Records of ta_auth_access
-- ----------------------------
INSERT INTO `ta_auth_access` VALUES ('2', '3');
INSERT INTO `ta_auth_access` VALUES ('1', '2');
INSERT INTO `ta_auth_access` VALUES ('2', '1');
INSERT INTO `ta_auth_access` VALUES ('3', '2');

-- ----------------------------
-- Table structure for ta_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `ta_auth_rule`;
CREATE TABLE `ta_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '规则中文描述',
  `rule_val` varchar(255) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识,全小写',
  `pid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '父类ID',
  `update_time` int(11) DEFAULT NULL COMMENT '账户最后更新时间',
  `delete_time` int(11) DEFAULT NULL COMMENT '软删除',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='权限规则表';

-- ----------------------------
-- Records of ta_auth_rule
-- ----------------------------
INSERT INTO `ta_auth_rule` VALUES ('1', '内容管理', 'admin/index/index', '3', '1484209924', null);
INSERT INTO `ta_auth_rule` VALUES ('2', '用户管理', 'admin/user/index', '6', '1484145913', null);
INSERT INTO `ta_auth_rule` VALUES ('3', 'Admin/Index', 'admin/index', '0', '1483502713', null);
INSERT INTO `ta_auth_rule` VALUES ('4', 'Admin/Sdd', 'admin/sdd', '0', '1484131420', null);

-- ----------------------------
-- Table structure for ta_log_record
-- ----------------------------
DROP TABLE IF EXISTS `ta_log_record`;
CREATE TABLE `ta_log_record` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `ip` varchar(15) DEFAULT NULL,
  `os` varchar(18) DEFAULT NULL,
  `browser` varchar(30) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=86 DEFAULT CHARSET=utf8 COMMENT='后台操作日志记录';

-- ----------------------------
-- Records of ta_log_record
-- ----------------------------

-- ----------------------------
-- Table structure for ta_role
-- ----------------------------
DROP TABLE IF EXISTS `ta_role`;
CREATE TABLE `ta_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL COMMENT '角色名称',
  `pid` smallint(6) DEFAULT NULL COMMENT '父角色ID',
  `status` tinyint(1) unsigned DEFAULT NULL COMMENT '状态',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `parentId` (`pid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of ta_role
-- ----------------------------
INSERT INTO `ta_role` VALUES ('1', '超级管理员1', '0', '1', '网站最高管理员权限！', '1329633709', '1329633709');
INSERT INTO `ta_role` VALUES ('2', '测试角色', null, '0', '测试角色', '1482389092', '0');

-- ----------------------------
-- Table structure for ta_skill
-- ----------------------------
DROP TABLE IF EXISTS `ta_skill`;
CREATE TABLE `ta_skill` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '技能类型',
  `skill_name` varchar(255) NOT NULL COMMENT '技能名称',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ta_skill
-- ----------------------------
INSERT INTO `ta_skill` VALUES ('18', 'PHP');
INSERT INTO `ta_skill` VALUES ('17', 'Android');

-- ----------------------------
-- Table structure for ta_user
-- ----------------------------
DROP TABLE IF EXISTS `ta_user`;
CREATE TABLE `ta_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(16) DEFAULT NULL COMMENT '账号',
  `mobile` varchar(12) DEFAULT NULL COMMENT '手机号',
  `password` varchar(32) DEFAULT NULL COMMENT '密码',
  `status` int(11) DEFAULT '0' COMMENT '状态 （0禁止 1可用）',
  `create_time` int(11) DEFAULT NULL COMMENT '帐号创建时间',
  `administrator` int(1) DEFAULT '0' COMMENT '是否超级管理员，1是 0否',
  `role_id` int(11) unsigned NOT NULL DEFAULT '0',
  `update_time` int(11) DEFAULT NULL COMMENT '账户最后更新时间',
  `delete_time` int(11) DEFAULT NULL COMMENT '软删除',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of ta_user
-- ----------------------------
INSERT INTO `ta_user` VALUES ('1', '毛振坚', '15757855290', '4c3c8afaf91b4dd81bcf68ba519fa2f6', '1', '1478252401', '1', '2', '1484214600', null);
INSERT INTO `ta_user` VALUES ('3', '程斌', '15116041105', '4c3c8afaf91b4dd81bcf68ba519fa2f6', '1', '1483423025', '0', '0', '1483423039', '1483423039');
INSERT INTO `ta_user` VALUES ('2', '管理员', '15100000000', '4c3c8afaf91b4dd81bcf68ba519fa2f6', '1', '1482835627', '1', '2', '1484148776', null);
INSERT INTO `ta_user` VALUES ('4', 'aierui', '13330613322', '4c3c8afaf91b4dd81bcf68ba519fa2f6', '1', '1484448977', '0', '2', '1484448977', null);
INSERT INTO `ta_user` VALUES ('5', 'test', '13330613012', '4c3c8afaf91b4dd81bcf68ba519fa2f6', '1', '1484449210', '0', '2', '1484449239', '1484449239');
