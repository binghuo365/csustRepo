/*
MySQL Data Transfer
Source Host: localhost
Source Database: repository
Target Host: localhost
Target Database: repository
Date: 2013/11/5 17:31:29
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for rep_admin
-- ----------------------------
DROP TABLE IF EXISTS `rep_admin`;
CREATE TABLE `rep_admin` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(50) default NULL,
  `password` varchar(50) default NULL,
  `email` varchar(100) default NULL,
  `roleid` int(11) default NULL,
  `islock` int(11) NOT NULL default '0',
  `addtime` datetime default NULL,
  `snumber` varchar(100) default NULL,
  `realname` varchar(255) default NULL,
  `gender` int(11) default '0',
  `school` varchar(255) default NULL,
  `major` varchar(255) default NULL,
  `qq` varchar(50) default NULL,
  `phone` varchar(50) default NULL,
  `lastloginip` varchar(30) default NULL,
  `lastlogintime` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `fk` (`roleid`),
  CONSTRAINT `fk` FOREIGN KEY (`roleid`) REFERENCES `rep_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rep_comment
-- ----------------------------
DROP TABLE IF EXISTS `rep_comment`;
CREATE TABLE `rep_comment` (
  `id` int(11) NOT NULL auto_increment,
  `resourceid` int(11) default NULL,
  `userid` int(11) default NULL,
  `addtime` datetime default NULL,
  `content` text,
  `ispassed` int(11) NOT NULL default '1',
  `passtime` datetime default NULL,
  `notpassreason` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `fk_userid3` (`userid`),
  KEY `rep_resource35` (`resourceid`),
  CONSTRAINT `fk_userid3` FOREIGN KEY (`userid`) REFERENCES `rep_user` (`id`),
  CONSTRAINT `rep_resource35` FOREIGN KEY (`resourceid`) REFERENCES `rep_resource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rep_folder
-- ----------------------------
DROP TABLE IF EXISTS `rep_folder`;
CREATE TABLE `rep_folder` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) default NULL,
  `fatherid` int(11) default NULL,
  `userid` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `fk_folder` (`fatherid`),
  KEY `fk_user_folder` (`userid`),
  CONSTRAINT `fk_folder` FOREIGN KEY (`fatherid`) REFERENCES `rep_folder` (`id`),
  CONSTRAINT `fk_user_folder` FOREIGN KEY (`userid`) REFERENCES `rep_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rep_format
-- ----------------------------
DROP TABLE IF EXISTS `rep_format`;
CREATE TABLE `rep_format` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `size` int(11) NOT NULL default '10',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rep_gscatalog
-- ----------------------------
DROP TABLE IF EXISTS `rep_gscatalog`;
CREATE TABLE `rep_gscatalog` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) default NULL,
  `fatherid` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `fk_gscatalog1` (`fatherid`),
  CONSTRAINT `fk_gscatalog1` FOREIGN KEY (`fatherid`) REFERENCES `rep_gscatalog` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rep_log
-- ----------------------------
DROP TABLE IF EXISTS `rep_log`;
CREATE TABLE `rep_log` (
  `id` int(11) NOT NULL auto_increment,
  `adminid` int(11) default NULL,
  `operationip` varchar(30) default NULL,
  `operationtype` varchar(30) default NULL,
  `description` varchar(100) default NULL,
  `operationtime` datetime default NULL,
  `operator` varchar(50) default NULL,
  PRIMARY KEY  (`id`),
  KEY `fk_adminid5` (`adminid`),
  CONSTRAINT `fk_adminid5` FOREIGN KEY (`adminid`) REFERENCES `rep_admin` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=781 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rep_message
-- ----------------------------
DROP TABLE IF EXISTS `rep_message`;
CREATE TABLE `rep_message` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(50) default NULL,
  `addtime` datetime default NULL,
  `content` text,
  `ispassed` int(11) NOT NULL default '1',
  `passtime` datetime default NULL,
  `userid` int(11) default NULL,
  `repadminid` int(11) default NULL,
  `reptime` datetime default NULL,
  `repcontent` text,
  `sort` int(11) NOT NULL default '0',
  `isreplied` int(11) default NULL,
  `replyer` varchar(50) default NULL,
  `notpassreason` varchar(255) default NULL,
  `asker` varchar(50) default NULL,
  PRIMARY KEY  (`id`),
  KEY `fk_repadminid` (`repadminid`),
  KEY `fk_userid5` (`userid`),
  CONSTRAINT `fk_repadminid` FOREIGN KEY (`repadminid`) REFERENCES `rep_admin` (`id`),
  CONSTRAINT `fk_userid5` FOREIGN KEY (`userid`) REFERENCES `rep_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rep_notice
-- ----------------------------
DROP TABLE IF EXISTS `rep_notice`;
CREATE TABLE `rep_notice` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(200) default NULL,
  `addtime` datetime default NULL,
  `content` text,
  `adminid` int(11) default NULL,
  `sort` int(11) NOT NULL default '0',
  `ispassed` int(11) default NULL,
  `author` varchar(50) default NULL,
  `notpassreason` varchar(255) default NULL,
  `viewtimes` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `fk_adminid3` (`adminid`),
  CONSTRAINT `fk_adminid3` FOREIGN KEY (`adminid`) REFERENCES `rep_admin` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rep_params
-- ----------------------------
DROP TABLE IF EXISTS `rep_params`;
CREATE TABLE `rep_params` (
  `id` int(11) NOT NULL auto_increment,
  `tisneedpass` int(11) NOT NULL default '0',
  `sisneedpass` int(11) NOT NULL default '0',
  `tuploadneedpass` int(11) NOT NULL default '0',
  `suploadneedpass` int(11) NOT NULL default '1',
  `tctneedpass` int(11) NOT NULL default '0',
  `sctneedpass` int(11) NOT NULL default '1',
  `askneedpass` int(11) NOT NULL default '0',
  `visitordownload` int(11) NOT NULL default '0',
  `format` varchar(500) NOT NULL default 'doc,docx,xls,xlsx,ppt,pptx,pdf,txt,jpg,gif,mp4,flv,swf,zip',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rep_permission
-- ----------------------------
DROP TABLE IF EXISTS `rep_permission`;
CREATE TABLE `rep_permission` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) default NULL,
  `sort` int(11) NOT NULL default '0',
  `actionname` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rep_resource
-- ----------------------------
DROP TABLE IF EXISTS `rep_resource`;
CREATE TABLE `rep_resource` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `path` varchar(512) default NULL,
  `length` bigint(11) NOT NULL default '0',
  `userid` int(11) default NULL,
  `adminid` int(11) default NULL,
  `addtime` datetime default NULL,
  `updatetime` datetime default NULL,
  `likenum` int(11) NOT NULL default '0',
  `downloadnum` int(11) NOT NULL default '0',
  `ispassed` int(11) NOT NULL default '1',
  `passtime` datetime default NULL,
  `description` varchar(255) default NULL,
  `zycatalogid` int(11) default NULL,
  `translateurl` varchar(512) default NULL,
  `gscatalogid` int(11) default NULL,
  `content` text,
  `topicid` int(11) default NULL,
  `topimg` varchar(100) default NULL,
  `uploader` varchar(50) default NULL,
  `notpassreason` varchar(255) default NULL,
  `pointsneed` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `fk_user` (`userid`),
  KEY `fk_admin` (`adminid`),
  KEY `fk_zycatalog` (`zycatalogid`),
  KEY `fk_format` (`gscatalogid`),
  KEY `fk_topic` (`topicid`),
  CONSTRAINT `fk_admin` FOREIGN KEY (`adminid`) REFERENCES `rep_admin` (`id`),
  CONSTRAINT `fk_gscatalog3` FOREIGN KEY (`gscatalogid`) REFERENCES `rep_gscatalog` (`id`),
  CONSTRAINT `fk_topic` FOREIGN KEY (`topicid`) REFERENCES `rep_topic` (`id`),
  CONSTRAINT `fk_user` FOREIGN KEY (`userid`) REFERENCES `rep_user` (`id`),
  CONSTRAINT `fk_zycatalog` FOREIGN KEY (`zycatalogid`) REFERENCES `rep_zycatalog` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=537 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rep_resource_folder
-- ----------------------------
DROP TABLE IF EXISTS `rep_resource_folder`;
CREATE TABLE `rep_resource_folder` (
  `id` int(11) NOT NULL auto_increment,
  `resourceid` int(11) default NULL,
  `folderid` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `fk_resource2` (`resourceid`),
  KEY `fk_folder2` (`folderid`),
  CONSTRAINT `fk_folder2` FOREIGN KEY (`folderid`) REFERENCES `rep_folder` (`id`),
  CONSTRAINT `fk_resource2` FOREIGN KEY (`resourceid`) REFERENCES `rep_resource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rep_resource_tag
-- ----------------------------
DROP TABLE IF EXISTS `rep_resource_tag`;
CREATE TABLE `rep_resource_tag` (
  `resourceid` int(11) NOT NULL,
  `tagid` int(11) NOT NULL default '0',
  PRIMARY KEY  (`resourceid`,`tagid`),
  KEY `fk_resource` (`resourceid`),
  KEY `fk_tag` (`tagid`),
  CONSTRAINT `fk_resource` FOREIGN KEY (`resourceid`) REFERENCES `rep_resource` (`id`),
  CONSTRAINT `fk_tag` FOREIGN KEY (`tagid`) REFERENCES `rep_tag` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rep_role
-- ----------------------------
DROP TABLE IF EXISTS `rep_role`;
CREATE TABLE `rep_role` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) default NULL,
  `sort` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rep_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `rep_role_permission`;
CREATE TABLE `rep_role_permission` (
  `roleid` int(11) NOT NULL,
  `permissionid` int(11) NOT NULL,
  PRIMARY KEY  (`roleid`,`permissionid`),
  KEY `fk_role` (`roleid`),
  KEY `fk_permission` (`permissionid`),
  CONSTRAINT `fk_permission` FOREIGN KEY (`permissionid`) REFERENCES `rep_permission` (`id`),
  CONSTRAINT `fk_role` FOREIGN KEY (`roleid`) REFERENCES `rep_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rep_tag
-- ----------------------------
DROP TABLE IF EXISTS `rep_tag`;
CREATE TABLE `rep_tag` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rep_topic
-- ----------------------------
DROP TABLE IF EXISTS `rep_topic`;
CREATE TABLE `rep_topic` (
  `gscatalogid` int(11) default NULL,
  `description` text,
  `title` varchar(500) default NULL,
  `zycatalogid` int(11) default NULL,
  `id` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`id`),
  KEY `fk_topic_gscatalog` (`gscatalogid`),
  KEY `fk_topic_zycatalogid` (`zycatalogid`),
  CONSTRAINT `fk_topic_gscatalog` FOREIGN KEY (`gscatalogid`) REFERENCES `rep_gscatalog` (`id`),
  CONSTRAINT `fk_topic_zycatalogid` FOREIGN KEY (`zycatalogid`) REFERENCES `rep_zycatalog` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rep_user
-- ----------------------------
DROP TABLE IF EXISTS `rep_user`;
CREATE TABLE `rep_user` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(50) default NULL,
  `password` varchar(50) default NULL,
  `email` varchar(100) default NULL,
  `islock` int(11) NOT NULL default '0',
  `ispassed` int(11) NOT NULL default '1',
  `passtime` datetime default NULL,
  `regtime` datetime default NULL,
  `snumber` varchar(100) default NULL,
  `realname` varchar(255) default NULL,
  `gender` int(11) default '0',
  `grade` varchar(10) default NULL,
  `school` varchar(255) default NULL,
  `major` varchar(255) default NULL,
  `birthday` datetime default NULL,
  `qq` varchar(50) default NULL,
  `phone` varchar(50) default NULL,
  `lastloginip` varchar(30) default NULL,
  `lastlogintime` datetime default NULL,
  `teacherorstu` int(11) NOT NULL default '1',
  `notpassreason` varchar(255) default NULL,
  `points` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rep_zycatalog
-- ----------------------------
DROP TABLE IF EXISTS `rep_zycatalog`;
CREATE TABLE `rep_zycatalog` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) default NULL,
  `fatherid` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `fk_zycatalog1` (`fatherid`),
  CONSTRAINT `fk_zycatalog1` FOREIGN KEY (`fatherid`) REFERENCES `rep_zycatalog` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `rep_admin` VALUES ('1', 'admin', '5F1D65F27E370C36DFD845F6DC78B869', '464631487@qq.com', '1', '0', null, '201236533333', '张校铭', '1', ' 继续教育学院', '工商管理', '132243', '135435345454', '0:0:0:0:0:0:0:1', '2013-10-03 14:40:57');
INSERT INTO `rep_admin` VALUES ('2', 'yy11', '202CB962AC59075B964B07152D234B70', '464631487@qq.com', null, '0', '2013-10-04 15:53:00', '201236533333', '', '1', '化学与生物工程学院', '电气化', '132243', '135435345454', null, null);
INSERT INTO `rep_gscatalog` VALUES ('1', '文档类资源', '文档类资源', null);
INSERT INTO `rep_gscatalog` VALUES ('2', '视频类资源', '视频类资源', null);
INSERT INTO `rep_gscatalog` VALUES ('3', '教学软件', '音频类资源', null);
INSERT INTO `rep_gscatalog` VALUES ('4', '图文类资源', '图文类资源', null);
INSERT INTO `rep_gscatalog` VALUES ('5', '综合类', '综合类', null);
INSERT INTO `rep_gscatalog` VALUES ('8', 'flash', '', '2');
INSERT INTO `rep_gscatalog` VALUES ('9', '企业管理学', '', '8');
INSERT INTO `rep_log` VALUES ('251', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-11 23:57:38', 'admin');
INSERT INTO `rep_log` VALUES ('252', '1', '0:0:0:0:0:0:0:1', '删除', '删除类型类别', '2013-09-11 23:59:52', 'admin');
INSERT INTO `rep_log` VALUES ('253', '1', '0:0:0:0:0:0:0:1', '删除', '删除类型类别', '2013-09-12 00:00:06', 'admin');
INSERT INTO `rep_log` VALUES ('254', '1', '0:0:0:0:0:0:0:1', '新增', '新增类型类别', '2013-09-12 00:07:38', 'admin');
INSERT INTO `rep_log` VALUES ('255', '1', '0:0:0:0:0:0:0:1', '新增', '新增类型类别', '2013-09-12 00:07:45', 'admin');
INSERT INTO `rep_log` VALUES ('256', '1', '0:0:0:0:0:0:0:1', '修改', '修改类型类别', '2013-09-12 00:07:53', 'admin');
INSERT INTO `rep_log` VALUES ('257', '1', '0:0:0:0:0:0:0:1', '删除', '删除类型类别', '2013-09-12 00:07:58', 'admin');
INSERT INTO `rep_log` VALUES ('258', '1', '0:0:0:0:0:0:0:1', '删除', '删除类型类别', '2013-09-12 00:08:04', 'admin');
INSERT INTO `rep_log` VALUES ('259', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-12 21:39:45', 'admin');
INSERT INTO `rep_log` VALUES ('260', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-12 21:53:51', 'admin');
INSERT INTO `rep_log` VALUES ('261', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-12 21:57:04', 'admin');
INSERT INTO `rep_log` VALUES ('262', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-13 09:29:24', 'admin');
INSERT INTO `rep_log` VALUES ('263', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-13 09:50:50', 'admin');
INSERT INTO `rep_log` VALUES ('264', '1', '0:0:0:0:0:0:0:1', '修改', '审核前台用户', '2013-09-13 10:16:16', 'admin');
INSERT INTO `rep_log` VALUES ('265', '1', '0:0:0:0:0:0:0:1', '修改', '编辑前台用户', '2013-09-13 10:51:35', 'admin');
INSERT INTO `rep_log` VALUES ('266', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-13 21:35:15', 'admin');
INSERT INTO `rep_log` VALUES ('267', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-13 21:42:25', 'admin');
INSERT INTO `rep_log` VALUES ('268', '1', '0:0:0:0:0:0:0:1', '修改', '编辑前台用户', '2013-09-13 21:45:12', 'admin');
INSERT INTO `rep_log` VALUES ('269', '1', '0:0:0:0:0:0:0:1', '修改', '编辑前台用户', '2013-09-13 22:00:17', 'admin');
INSERT INTO `rep_log` VALUES ('270', '1', '0:0:0:0:0:0:0:1', '修改', '编辑前台用户', '2013-09-13 22:01:55', 'admin');
INSERT INTO `rep_log` VALUES ('271', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-14 22:35:22', 'admin');
INSERT INTO `rep_log` VALUES ('272', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-15 09:46:43', 'admin');
INSERT INTO `rep_log` VALUES ('273', '1', '0:0:0:0:0:0:0:1', '修改', '参数配置', '2013-09-15 10:46:26', 'admin');
INSERT INTO `rep_log` VALUES ('274', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-15 14:06:34', 'admin');
INSERT INTO `rep_log` VALUES ('275', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-15 15:56:04', 'admin');
INSERT INTO `rep_log` VALUES ('276', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-15 16:35:39', 'admin');
INSERT INTO `rep_log` VALUES ('277', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-15 19:10:27', 'admin');
INSERT INTO `rep_log` VALUES ('278', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-15 20:53:16', 'admin');
INSERT INTO `rep_log` VALUES ('279', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-15 21:34:33', 'admin');
INSERT INTO `rep_log` VALUES ('280', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-15 23:07:00', 'admin');
INSERT INTO `rep_log` VALUES ('281', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-16 00:11:03', 'admin');
INSERT INTO `rep_log` VALUES ('282', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-17 14:41:36', 'admin');
INSERT INTO `rep_log` VALUES ('283', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-17 15:32:01', 'admin');
INSERT INTO `rep_log` VALUES ('284', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-17 17:48:15', 'admin');
INSERT INTO `rep_log` VALUES ('285', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-17 18:49:17', 'admin');
INSERT INTO `rep_log` VALUES ('286', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-17 20:17:41', 'admin');
INSERT INTO `rep_log` VALUES ('287', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-17 21:02:47', 'admin');
INSERT INTO `rep_log` VALUES ('288', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-17 21:11:17', 'admin');
INSERT INTO `rep_log` VALUES ('289', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-18 12:40:34', 'admin');
INSERT INTO `rep_log` VALUES ('290', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-18 18:37:44', 'admin');
INSERT INTO `rep_log` VALUES ('291', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-18 19:44:05', 'admin');
INSERT INTO `rep_log` VALUES ('292', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-18 20:17:34', 'admin');
INSERT INTO `rep_log` VALUES ('293', '1', '127.0.0.1', '登录', '登录后台', '2013-09-18 20:53:10', 'admin');
INSERT INTO `rep_log` VALUES ('294', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-18 20:58:59', 'admin');
INSERT INTO `rep_log` VALUES ('295', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-18 21:27:59', 'admin');
INSERT INTO `rep_log` VALUES ('296', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-18 21:29:14', 'admin');
INSERT INTO `rep_log` VALUES ('297', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-19 01:11:25', 'admin');
INSERT INTO `rep_log` VALUES ('298', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-25 22:08:20', 'admin');
INSERT INTO `rep_log` VALUES ('299', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-25 22:08:20', 'admin');
INSERT INTO `rep_log` VALUES ('300', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-25 22:16:22', 'admin');
INSERT INTO `rep_log` VALUES ('301', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-25 22:16:23', 'admin');
INSERT INTO `rep_log` VALUES ('302', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-25 22:24:39', 'admin');
INSERT INTO `rep_log` VALUES ('303', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-25 22:46:53', 'admin');
INSERT INTO `rep_log` VALUES ('304', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-26 22:55:14', 'admin');
INSERT INTO `rep_log` VALUES ('305', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-27 00:08:40', 'admin');
INSERT INTO `rep_log` VALUES ('306', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-27 00:14:44', 'admin');
INSERT INTO `rep_log` VALUES ('307', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-27 00:23:41', 'admin');
INSERT INTO `rep_log` VALUES ('308', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-27 00:24:49', 'admin');
INSERT INTO `rep_log` VALUES ('309', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-28 22:35:28', 'admin');
INSERT INTO `rep_log` VALUES ('310', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-09-28 23:48:40', 'admin');
INSERT INTO `rep_log` VALUES ('311', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-01 21:41:59', 'admin');
INSERT INTO `rep_log` VALUES ('312', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-01 22:02:56', 'admin');
INSERT INTO `rep_log` VALUES ('313', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-01 23:04:04', 'admin');
INSERT INTO `rep_log` VALUES ('314', '1', '0:0:0:0:0:0:0:1', '新增', '新增专题', '2013-10-01 23:27:38', 'admin');
INSERT INTO `rep_log` VALUES ('315', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-02 08:02:40', 'admin');
INSERT INTO `rep_log` VALUES ('316', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-02 08:45:34', 'admin');
INSERT INTO `rep_log` VALUES ('317', '1', '0:0:0:0:0:0:0:1', '修改', '解锁前台用户', '2013-10-02 09:19:18', 'admin');
INSERT INTO `rep_log` VALUES ('318', '1', '0:0:0:0:0:0:0:1', '修改', '审核前台用户', '2013-10-02 09:19:23', 'admin');
INSERT INTO `rep_log` VALUES ('319', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-02 11:12:48', 'admin');
INSERT INTO `rep_log` VALUES ('320', '1', '0:0:0:0:0:0:0:1', '修改', '编辑前台用户', '2013-10-02 11:17:19', 'admin');
INSERT INTO `rep_log` VALUES ('321', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-02 18:44:07', 'admin');
INSERT INTO `rep_log` VALUES ('322', '1', '192.168.0.100', '登录', '登录后台', '2013-10-02 19:43:15', 'admin');
INSERT INTO `rep_log` VALUES ('323', '1', '192.168.0.102', '登录', '登录后台', '2013-10-02 20:25:13', 'admin');
INSERT INTO `rep_log` VALUES ('324', '1', '192.168.0.102', '登录', '登录后台', '2013-10-02 21:43:42', 'admin');
INSERT INTO `rep_log` VALUES ('325', '1', '192.168.0.102', '登录', '登录后台', '2013-10-02 22:36:35', 'admin');
INSERT INTO `rep_log` VALUES ('326', '1', '127.0.0.1', '登录', '登录后台', '2013-10-02 22:43:26', 'admin');
INSERT INTO `rep_log` VALUES ('327', '1', '192.168.0.102', '登录', '登录后台', '2013-10-02 23:01:58', 'admin');
INSERT INTO `rep_log` VALUES ('328', '1', '192.168.0.102', '登录', '登录后台', '2013-10-03 07:37:52', 'admin');
INSERT INTO `rep_log` VALUES ('329', '1', '192.168.0.102', '登录', '登录后台', '2013-10-03 10:51:15', 'admin');
INSERT INTO `rep_log` VALUES ('330', '1', '192.168.0.102', '登录', '登录后台', '2013-10-03 11:47:09', 'admin');
INSERT INTO `rep_log` VALUES ('331', '1', '192.168.0.102', '登录', '登录后台', '2013-10-03 13:01:02', 'admin');
INSERT INTO `rep_log` VALUES ('332', '1', '192.168.0.102', '登录', '登录后台', '2013-10-03 13:31:28', 'admin');
INSERT INTO `rep_log` VALUES ('333', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-03 14:40:57', 'admin');
INSERT INTO `rep_log` VALUES ('334', '1', '0:0:0:0:0:0:0:1', '修改', '参数配置', '2013-10-03 14:41:09', 'admin');
INSERT INTO `rep_log` VALUES ('335', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-03 18:31:14', 'admin');
INSERT INTO `rep_log` VALUES ('336', '1', '192.168.0.102', '登录', '登录后台', '2013-10-03 18:49:20', 'admin');
INSERT INTO `rep_log` VALUES ('337', '1', '192.168.0.102', '修改', '编辑前台用户', '2013-10-03 18:55:44', 'admin');
INSERT INTO `rep_log` VALUES ('338', '1', '192.168.0.102', '修改', '编辑前台用户', '2013-10-03 18:55:51', 'admin');
INSERT INTO `rep_log` VALUES ('339', '1', '192.168.0.102', '修改', '编辑前台用户', '2013-10-03 18:55:58', 'admin');
INSERT INTO `rep_log` VALUES ('340', '1', '192.168.0.102', '修改', '编辑前台用户', '2013-10-03 18:56:02', 'admin');
INSERT INTO `rep_log` VALUES ('341', '1', '192.168.0.102', '登录', '登录后台', '2013-10-03 18:56:12', 'admin');
INSERT INTO `rep_log` VALUES ('342', '1', '192.168.0.102', '修改', '编辑前台用户', '2013-10-03 18:57:07', 'admin');
INSERT INTO `rep_log` VALUES ('343', '1', '192.168.0.102', '修改', '编辑前台用户', '2013-10-03 18:58:01', 'admin');
INSERT INTO `rep_log` VALUES ('344', '1', '192.168.0.102', '修改', '编辑前台用户', '2013-10-03 18:58:28', 'admin');
INSERT INTO `rep_log` VALUES ('345', '1', '192.168.0.102', '修改', '审核前台用户', '2013-10-03 18:59:42', 'admin');
INSERT INTO `rep_log` VALUES ('346', '1', '192.168.0.102', '修改', '解锁前台用户', '2013-10-03 18:59:47', 'admin');
INSERT INTO `rep_log` VALUES ('347', '1', '192.168.0.102', '登录', '登录后台', '2013-10-03 19:00:14', 'admin');
INSERT INTO `rep_log` VALUES ('348', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-03 19:29:02', 'admin');
INSERT INTO `rep_log` VALUES ('349', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-03 19:29:02', 'admin');
INSERT INTO `rep_log` VALUES ('350', '1', '0:0:0:0:0:0:0:1', '修改', '修改角色', '2013-10-03 19:29:32', 'admin');
INSERT INTO `rep_log` VALUES ('351', '1', '0:0:0:0:0:0:0:1', '修改', '修改角色', '2013-10-03 19:29:38', 'admin');
INSERT INTO `rep_log` VALUES ('352', '1', '0:0:0:0:0:0:0:1', '修改', '修改角色', '2013-10-03 19:30:29', 'admin');
INSERT INTO `rep_log` VALUES ('353', '1', '0:0:0:0:0:0:0:1', '删除', '删除角色', '2013-10-03 19:30:44', 'admin');
INSERT INTO `rep_log` VALUES ('354', '1', '192.168.0.102', '登录', '登录后台', '2013-10-03 19:33:58', 'admin');
INSERT INTO `rep_log` VALUES ('355', '1', '0:0:0:0:0:0:0:1', '修改', '编辑前台用户', '2013-10-03 19:34:03', 'admin');
INSERT INTO `rep_log` VALUES ('356', '1', '0:0:0:0:0:0:0:1', '修改', '编辑后台用户', '2013-10-03 19:34:10', 'admin');
INSERT INTO `rep_log` VALUES ('357', '1', '192.168.0.102', '登录', '登录后台', '2013-10-03 19:56:32', 'admin');
INSERT INTO `rep_log` VALUES ('358', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-03 20:44:54', 'admin');
INSERT INTO `rep_log` VALUES ('359', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-03 22:39:24', 'admin');
INSERT INTO `rep_log` VALUES ('360', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-03 22:40:45', 'admin');
INSERT INTO `rep_log` VALUES ('361', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-03 23:34:32', 'admin');
INSERT INTO `rep_log` VALUES ('362', '1', '192.168.0.102', '登录', '登录后台', '2013-10-04 09:53:22', 'admin');
INSERT INTO `rep_log` VALUES ('363', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-04 09:55:14', 'admin');
INSERT INTO `rep_log` VALUES ('364', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-04 09:59:05', 'admin');
INSERT INTO `rep_log` VALUES ('365', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-04 10:10:24', 'admin');
INSERT INTO `rep_log` VALUES ('366', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-04 11:05:22', 'admin');
INSERT INTO `rep_log` VALUES ('367', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-04 11:20:24', 'admin');
INSERT INTO `rep_log` VALUES ('368', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-04 11:20:58', 'admin');
INSERT INTO `rep_log` VALUES ('369', '1', '192.168.0.102', '登录', '登录后台', '2013-10-04 12:05:03', 'admin');
INSERT INTO `rep_log` VALUES ('370', '1', '192.168.0.102', '登录', '登录后台', '2013-10-04 13:16:55', 'admin');
INSERT INTO `rep_log` VALUES ('371', '1', '192.168.0.102', '登录', '登录后台', '2013-10-04 15:13:07', 'admin');
INSERT INTO `rep_log` VALUES ('372', '1', '192.168.0.102', '登录', '登录后台', '2013-10-04 15:14:52', 'admin');
INSERT INTO `rep_log` VALUES ('373', '1', '192.168.0.102', '修改', '锁定前台用户', '2013-10-04 15:37:24', 'admin');
INSERT INTO `rep_log` VALUES ('374', '1', '192.168.0.102', '修改', '解锁前台用户', '2013-10-04 15:37:32', 'admin');
INSERT INTO `rep_log` VALUES ('375', '1', '192.168.0.102', '修改', '修改角色', '2013-10-04 15:45:10', 'admin');
INSERT INTO `rep_log` VALUES ('376', '1', '192.168.0.102', '修改', '修改角色', '2013-10-04 15:49:29', 'admin');
INSERT INTO `rep_log` VALUES ('377', '1', '192.168.0.102', '修改', '修改角色', '2013-10-04 15:49:43', 'admin');
INSERT INTO `rep_log` VALUES ('378', '1', '192.168.0.102', '新增', '新增角色', '2013-10-04 15:50:23', 'admin');
INSERT INTO `rep_log` VALUES ('379', '1', '192.168.0.102', '修改', '修改角色', '2013-10-04 15:50:28', 'admin');
INSERT INTO `rep_log` VALUES ('380', '1', '192.168.0.102', '删除', '删除角色', '2013-10-04 15:50:33', 'admin');
INSERT INTO `rep_log` VALUES ('381', '1', '192.168.0.102', '新增', '新增角色', '2013-10-04 15:52:27', 'admin');
INSERT INTO `rep_log` VALUES ('382', '1', '192.168.0.102', '新增', '新增后台用户', '2013-10-04 15:53:00', 'admin');
INSERT INTO `rep_log` VALUES ('383', '1', '192.168.0.102', '删除', '删除角色', '2013-10-04 15:53:22', 'admin');
INSERT INTO `rep_log` VALUES ('384', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-04 15:57:03', 'admin');
INSERT INTO `rep_log` VALUES ('385', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-04 15:57:36', 'admin');
INSERT INTO `rep_log` VALUES ('386', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-04 15:58:03', 'admin');
INSERT INTO `rep_log` VALUES ('387', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-04 16:09:17', 'admin');
INSERT INTO `rep_log` VALUES ('388', '1', '0:0:0:0:0:0:0:1', '修改', '修改角色', '2013-10-04 16:12:48', 'admin');
INSERT INTO `rep_log` VALUES ('389', '1', '0:0:0:0:0:0:0:1', '修改', '修改角色', '2013-10-04 16:13:58', 'admin');
INSERT INTO `rep_log` VALUES ('390', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-04 16:31:04', 'admin');
INSERT INTO `rep_log` VALUES ('391', '1', '0:0:0:0:0:0:0:1', '修改', '修改角色', '2013-10-04 16:44:46', 'admin');
INSERT INTO `rep_log` VALUES ('392', '1', '192.168.0.102', '登录', '登录后台', '2013-10-04 17:05:48', 'admin');
INSERT INTO `rep_log` VALUES ('393', '1', '192.168.0.102', '修改', '修改角色', '2013-10-04 17:18:42', 'admin');
INSERT INTO `rep_log` VALUES ('394', '1', '192.168.0.102', '修改', '修改角色', '2013-10-04 17:19:01', 'admin');
INSERT INTO `rep_log` VALUES ('395', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-04 17:36:16', 'admin');
INSERT INTO `rep_log` VALUES ('396', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-04 21:53:33', 'admin');
INSERT INTO `rep_log` VALUES ('397', '1', '192.168.0.102', '登录', '登录后台', '2013-10-05 07:51:44', 'admin');
INSERT INTO `rep_log` VALUES ('398', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-05 07:53:40', 'admin');
INSERT INTO `rep_log` VALUES ('399', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-05 07:54:31', 'admin');
INSERT INTO `rep_log` VALUES ('400', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-05 07:55:33', 'admin');
INSERT INTO `rep_log` VALUES ('401', '1', '192.168.0.102', '登录', '登录后台', '2013-10-05 09:02:05', 'admin');
INSERT INTO `rep_log` VALUES ('402', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-05 10:07:26', 'admin');
INSERT INTO `rep_log` VALUES ('403', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-05 10:10:05', 'admin');
INSERT INTO `rep_log` VALUES ('404', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-05 10:10:05', 'admin');
INSERT INTO `rep_log` VALUES ('405', '1', '192.168.0.102', '登录', '登录后台', '2013-10-05 10:31:43', 'admin');
INSERT INTO `rep_log` VALUES ('406', '1', '192.168.0.102', '登录', '登录后台', '2013-10-05 14:02:15', 'admin');
INSERT INTO `rep_log` VALUES ('407', '1', '192.168.0.102', '登录', '登录后台', '2013-10-05 14:16:10', 'admin');
INSERT INTO `rep_log` VALUES ('408', '1', '192.168.0.102', '登录', '登录后台', '2013-10-05 16:25:51', 'admin');
INSERT INTO `rep_log` VALUES ('409', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-05 16:53:55', 'admin');
INSERT INTO `rep_log` VALUES ('410', '1', '192.168.0.102', '修改', '编辑后台用户', '2013-10-05 17:17:01', 'admin');
INSERT INTO `rep_log` VALUES ('411', '1', '192.168.0.102', '登录', '登录后台', '2013-10-05 17:20:00', 'admin');
INSERT INTO `rep_log` VALUES ('412', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-05 17:26:24', 'admin');
INSERT INTO `rep_log` VALUES ('413', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-05 21:53:56', 'admin');
INSERT INTO `rep_log` VALUES ('414', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-09 09:41:39', 'admin');
INSERT INTO `rep_log` VALUES ('415', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-09 09:45:20', 'admin');
INSERT INTO `rep_log` VALUES ('416', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-09 10:37:04', 'admin');
INSERT INTO `rep_log` VALUES ('417', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-09 11:35:00', 'admin');
INSERT INTO `rep_log` VALUES ('418', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-09 13:49:46', 'admin');
INSERT INTO `rep_log` VALUES ('419', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-09 15:14:56', 'admin');
INSERT INTO `rep_log` VALUES ('420', '1', '192.168.22.10', '登录', '登录后台', '2013-10-09 16:04:45', 'admin');
INSERT INTO `rep_log` VALUES ('421', '1', '192.168.22.10', '修改', '修改角色', '2013-10-09 16:31:10', 'admin');
INSERT INTO `rep_log` VALUES ('422', '1', '192.168.22.10', '修改', '修改角色', '2013-10-09 16:42:17', 'admin');
INSERT INTO `rep_log` VALUES ('423', '1', '192.168.22.10', '登录', '登录后台', '2013-10-09 16:46:43', 'admin');
INSERT INTO `rep_log` VALUES ('424', '1', '192.168.22.10', '修改', '修改资源', '2013-10-09 16:46:53', 'admin');
INSERT INTO `rep_log` VALUES ('425', '1', '192.168.22.10', '修改', '修改资源', '2013-10-09 16:46:56', 'admin');
INSERT INTO `rep_log` VALUES ('426', '1', '192.168.22.10', '新增', '新增公告', '2013-10-09 16:47:16', 'admin');
INSERT INTO `rep_log` VALUES ('427', '1', '192.168.22.10', '修改', '修改公告', '2013-10-09 16:47:30', 'admin');
INSERT INTO `rep_log` VALUES ('428', '1', '192.168.22.10', '新增', '批量上传专题资源', '2013-10-09 16:48:48', 'admin');
INSERT INTO `rep_log` VALUES ('429', '1', '192.168.22.10', '新增', '批量上传专题资源', '2013-10-09 16:50:16', 'admin');
INSERT INTO `rep_log` VALUES ('430', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-09 16:52:02', 'admin');
INSERT INTO `rep_log` VALUES ('431', '1', '10.6.16.150', '登录', '登录后台', '2013-10-09 16:58:24', 'admin');
INSERT INTO `rep_log` VALUES ('432', '1', '10.6.16.150', '修改', '审核通过资源评论', '2013-10-09 17:14:17', 'admin');
INSERT INTO `rep_log` VALUES ('433', '1', '10.6.16.150', '删除', '删除资源', '2013-10-09 17:15:48', 'admin');
INSERT INTO `rep_log` VALUES ('434', '1', '10.6.16.150', '登录', '登录后台', '2013-10-09 17:47:37', 'admin');
INSERT INTO `rep_log` VALUES ('435', '1', '10.6.16.150', '修改', '修改资源', '2013-10-09 17:48:04', 'admin');
INSERT INTO `rep_log` VALUES ('436', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-09 18:00:29', 'admin');
INSERT INTO `rep_log` VALUES ('437', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-09 18:11:51', 'admin');
INSERT INTO `rep_log` VALUES ('438', '1', '0:0:0:0:0:0:0:1', '修改', '修改公告', '2013-10-09 18:30:17', 'admin');
INSERT INTO `rep_log` VALUES ('439', '1', '0:0:0:0:0:0:0:1', '修改', '修改公告', '2013-10-09 19:01:01', 'admin');
INSERT INTO `rep_log` VALUES ('440', '1', '0:0:0:0:0:0:0:1', '修改', '修改公告', '2013-10-09 19:25:16', 'admin');
INSERT INTO `rep_log` VALUES ('441', '1', '0:0:0:0:0:0:0:1', '修改', '修改公告', '2013-10-09 19:31:04', 'admin');
INSERT INTO `rep_log` VALUES ('442', '1', '0:0:0:0:0:0:0:1', '修改', '修改公告', '2013-10-09 19:31:19', 'admin');
INSERT INTO `rep_log` VALUES ('443', '1', '0:0:0:0:0:0:0:1', '修改', '修改公告', '2013-10-09 19:36:16', 'admin');
INSERT INTO `rep_log` VALUES ('444', '1', '0:0:0:0:0:0:0:1', '修改', '修改公告', '2013-10-09 19:37:32', 'admin');
INSERT INTO `rep_log` VALUES ('445', '1', '0:0:0:0:0:0:0:1', '修改', '修改公告', '2013-10-09 19:42:38', 'admin');
INSERT INTO `rep_log` VALUES ('446', '1', '0:0:0:0:0:0:0:1', '新增', '新增公告', '2013-10-09 19:44:49', 'admin');
INSERT INTO `rep_log` VALUES ('447', '1', '0:0:0:0:0:0:0:1', '修改', '修改公告', '2013-10-09 19:52:03', 'admin');
INSERT INTO `rep_log` VALUES ('448', '1', '0:0:0:0:0:0:0:1', '修改', '修改公告', '2013-10-09 19:55:24', 'admin');
INSERT INTO `rep_log` VALUES ('449', '1', '0:0:0:0:0:0:0:1', '修改', '修改公告', '2013-10-09 19:58:25', 'admin');
INSERT INTO `rep_log` VALUES ('450', '1', '0:0:0:0:0:0:0:1', '修改', '修改公告', '2013-10-09 20:10:38', 'admin');
INSERT INTO `rep_log` VALUES ('451', '1', '0:0:0:0:0:0:0:1', '修改', '修改公告', '2013-10-09 20:11:06', 'admin');
INSERT INTO `rep_log` VALUES ('452', '1', '0:0:0:0:0:0:0:1', '修改', '修改公告', '2013-10-09 20:11:52', 'admin');
INSERT INTO `rep_log` VALUES ('453', '1', '0:0:0:0:0:0:0:1', '修改', '修改公告', '2013-10-09 20:15:15', 'admin');
INSERT INTO `rep_log` VALUES ('454', '1', '0:0:0:0:0:0:0:1', '修改', '修改公告', '2013-10-09 20:15:26', 'admin');
INSERT INTO `rep_log` VALUES ('455', '1', '0:0:0:0:0:0:0:1', '修改', '修改公告', '2013-10-09 20:17:31', 'admin');
INSERT INTO `rep_log` VALUES ('456', '1', '0:0:0:0:0:0:0:1', '修改', '修改公告', '2013-10-09 20:22:29', 'admin');
INSERT INTO `rep_log` VALUES ('457', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-19 21:39:47', 'admin');
INSERT INTO `rep_log` VALUES ('458', '1', '0:0:0:0:0:0:0:1', '修改', '发布公告', '2013-10-19 21:40:37', 'admin');
INSERT INTO `rep_log` VALUES ('459', '1', '0:0:0:0:0:0:0:1', '修改', '修改公告', '2013-10-19 21:40:47', 'admin');
INSERT INTO `rep_log` VALUES ('460', '1', '0:0:0:0:0:0:0:1', '修改', '修改公告', '2013-10-19 21:40:57', 'admin');
INSERT INTO `rep_log` VALUES ('461', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-19 22:49:44', 'admin');
INSERT INTO `rep_log` VALUES ('462', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-19 23:11:23', 'admin');
INSERT INTO `rep_log` VALUES ('463', '1', '0:0:0:0:0:0:0:1', '新增', '新增前台用户', '2013-10-19 23:40:25', 'admin');
INSERT INTO `rep_log` VALUES ('464', '1', '0:0:0:0:0:0:0:1', '修改', '编辑前台用户', '2013-10-19 23:40:46', 'admin');
INSERT INTO `rep_log` VALUES ('465', '1', '0:0:0:0:0:0:0:1', '修改', '编辑前台用户', '2013-10-19 23:41:07', 'admin');
INSERT INTO `rep_log` VALUES ('466', '1', '0:0:0:0:0:0:0:1', '新增', '新增公告', '2013-10-20 01:23:39', 'admin');
INSERT INTO `rep_log` VALUES ('467', '1', '10.6.16.150', '登录', '登录后台', '2013-10-20 21:59:39', 'admin');
INSERT INTO `rep_log` VALUES ('468', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-20 22:01:34', 'admin');
INSERT INTO `rep_log` VALUES ('469', '1', '10.6.16.150', '修改', '审核通过答疑帮助', '2013-10-20 22:05:45', 'admin');
INSERT INTO `rep_log` VALUES ('470', '1', '10.6.16.150', '修改', '审核通过答疑帮助', '2013-10-20 22:05:56', 'admin');
INSERT INTO `rep_log` VALUES ('471', '1', '0:0:0:0:0:0:0:1', '修改', '修改公告', '2013-10-20 22:10:36', 'admin');
INSERT INTO `rep_log` VALUES ('472', '1', '0:0:0:0:0:0:0:1', '修改', '修改公告', '2013-10-20 22:10:45', 'admin');
INSERT INTO `rep_log` VALUES ('473', '1', '0:0:0:0:0:0:0:1', '修改', '修改公告', '2013-10-20 22:12:02', 'admin');
INSERT INTO `rep_log` VALUES ('474', '1', '0:0:0:0:0:0:0:1', '修改', '修改公告', '2013-10-20 22:13:31', 'admin');
INSERT INTO `rep_log` VALUES ('475', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-21 18:36:04', 'admin');
INSERT INTO `rep_log` VALUES ('476', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-21 21:00:52', 'admin');
INSERT INTO `rep_log` VALUES ('477', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-21 21:38:10', 'admin');
INSERT INTO `rep_log` VALUES ('478', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-21 21:39:02', 'admin');
INSERT INTO `rep_log` VALUES ('479', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-21 21:40:12', 'admin');
INSERT INTO `rep_log` VALUES ('480', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-21 21:44:50', 'admin');
INSERT INTO `rep_log` VALUES ('481', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-22 16:05:09', 'admin');
INSERT INTO `rep_log` VALUES ('482', '1', '0:0:0:0:0:0:0:1', '新增', '新增公告', '2013-10-22 16:07:11', 'admin');
INSERT INTO `rep_log` VALUES ('483', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-25 13:07:13', 'admin');
INSERT INTO `rep_log` VALUES ('484', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-26 13:11:34', 'admin');
INSERT INTO `rep_log` VALUES ('485', '1', '0:0:0:0:0:0:0:1', '新增', '上传资源', '2013-10-26 13:42:20', 'admin');
INSERT INTO `rep_log` VALUES ('486', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-26 13:56:02', 'admin');
INSERT INTO `rep_log` VALUES ('487', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-26 13:56:09', 'admin');
INSERT INTO `rep_log` VALUES ('488', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-26 13:56:33', 'admin');
INSERT INTO `rep_log` VALUES ('489', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-26 14:00:36', 'admin');
INSERT INTO `rep_log` VALUES ('490', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-26 14:00:48', 'admin');
INSERT INTO `rep_log` VALUES ('491', '1', '0:0:0:0:0:0:0:1', '新增', '上传资源', '2013-10-26 15:09:06', 'admin');
INSERT INTO `rep_log` VALUES ('492', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:09:18', 'admin');
INSERT INTO `rep_log` VALUES ('493', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:09:27', 'admin');
INSERT INTO `rep_log` VALUES ('494', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:19:40', 'admin');
INSERT INTO `rep_log` VALUES ('495', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:20:12', 'admin');
INSERT INTO `rep_log` VALUES ('496', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:20:23', 'admin');
INSERT INTO `rep_log` VALUES ('497', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:22:08', 'admin');
INSERT INTO `rep_log` VALUES ('498', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:22:40', 'admin');
INSERT INTO `rep_log` VALUES ('499', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:23:00', 'admin');
INSERT INTO `rep_log` VALUES ('500', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:23:13', 'admin');
INSERT INTO `rep_log` VALUES ('501', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:23:58', 'admin');
INSERT INTO `rep_log` VALUES ('502', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:24:10', 'admin');
INSERT INTO `rep_log` VALUES ('503', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:24:33', 'admin');
INSERT INTO `rep_log` VALUES ('504', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:25:02', 'admin');
INSERT INTO `rep_log` VALUES ('505', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:25:24', 'admin');
INSERT INTO `rep_log` VALUES ('506', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:25:51', 'admin');
INSERT INTO `rep_log` VALUES ('507', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:26:09', 'admin');
INSERT INTO `rep_log` VALUES ('508', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:27:51', 'admin');
INSERT INTO `rep_log` VALUES ('509', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:28:41', 'admin');
INSERT INTO `rep_log` VALUES ('510', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:28:46', 'admin');
INSERT INTO `rep_log` VALUES ('511', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:29:46', 'admin');
INSERT INTO `rep_log` VALUES ('512', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:29:55', 'admin');
INSERT INTO `rep_log` VALUES ('513', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:30:02', 'admin');
INSERT INTO `rep_log` VALUES ('514', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:30:27', 'admin');
INSERT INTO `rep_log` VALUES ('515', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:31:06', 'admin');
INSERT INTO `rep_log` VALUES ('516', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:31:30', 'admin');
INSERT INTO `rep_log` VALUES ('517', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:31:40', 'admin');
INSERT INTO `rep_log` VALUES ('518', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:31:55', 'admin');
INSERT INTO `rep_log` VALUES ('519', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:36:01', 'admin');
INSERT INTO `rep_log` VALUES ('520', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:40:32', 'admin');
INSERT INTO `rep_log` VALUES ('521', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:41:40', 'admin');
INSERT INTO `rep_log` VALUES ('522', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:42:52', 'admin');
INSERT INTO `rep_log` VALUES ('523', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 15:49:30', 'admin');
INSERT INTO `rep_log` VALUES ('524', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-26 16:13:34', 'admin');
INSERT INTO `rep_log` VALUES ('525', '1', '0:0:0:0:0:0:0:1', '新增', '新增前台用户', '2013-10-26 16:26:12', 'admin');
INSERT INTO `rep_log` VALUES ('526', '1', '0:0:0:0:0:0:0:1', '删除', '删除前台用户', '2013-10-26 16:26:17', 'admin');
INSERT INTO `rep_log` VALUES ('527', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 16:35:58', 'admin');
INSERT INTO `rep_log` VALUES ('528', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 16:38:03', 'admin');
INSERT INTO `rep_log` VALUES ('529', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 16:44:22', 'admin');
INSERT INTO `rep_log` VALUES ('530', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 16:45:12', 'admin');
INSERT INTO `rep_log` VALUES ('531', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 16:45:37', 'admin');
INSERT INTO `rep_log` VALUES ('532', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 16:45:53', 'admin');
INSERT INTO `rep_log` VALUES ('533', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 16:46:09', 'admin');
INSERT INTO `rep_log` VALUES ('534', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 16:52:37', 'admin');
INSERT INTO `rep_log` VALUES ('535', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-26 21:25:56', 'admin');
INSERT INTO `rep_log` VALUES ('536', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-26 21:26:01', 'admin');
INSERT INTO `rep_log` VALUES ('537', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-27 08:45:23', 'admin');
INSERT INTO `rep_log` VALUES ('538', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-27 08:45:28', 'admin');
INSERT INTO `rep_log` VALUES ('539', '1', '0:0:0:0:0:0:0:1', '新增', '上传资源', '2013-10-27 08:46:29', 'admin');
INSERT INTO `rep_log` VALUES ('540', '1', '0:0:0:0:0:0:0:1', '新增', '上传资源', '2013-10-27 08:55:20', 'admin');
INSERT INTO `rep_log` VALUES ('541', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-27 12:16:12', 'admin');
INSERT INTO `rep_log` VALUES ('542', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:16:18', 'admin');
INSERT INTO `rep_log` VALUES ('543', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:17:16', 'admin');
INSERT INTO `rep_log` VALUES ('544', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:20:43', 'admin');
INSERT INTO `rep_log` VALUES ('545', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:21:01', 'admin');
INSERT INTO `rep_log` VALUES ('546', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:21:04', 'admin');
INSERT INTO `rep_log` VALUES ('547', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:21:11', 'admin');
INSERT INTO `rep_log` VALUES ('548', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:21:32', 'admin');
INSERT INTO `rep_log` VALUES ('549', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:27:06', 'admin');
INSERT INTO `rep_log` VALUES ('550', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:27:14', 'admin');
INSERT INTO `rep_log` VALUES ('551', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-27 12:45:20', 'admin');
INSERT INTO `rep_log` VALUES ('552', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:47:38', 'admin');
INSERT INTO `rep_log` VALUES ('553', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:47:42', 'admin');
INSERT INTO `rep_log` VALUES ('554', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:47:47', 'admin');
INSERT INTO `rep_log` VALUES ('555', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:47:52', 'admin');
INSERT INTO `rep_log` VALUES ('556', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:47:55', 'admin');
INSERT INTO `rep_log` VALUES ('557', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:48:15', 'admin');
INSERT INTO `rep_log` VALUES ('558', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:48:41', 'admin');
INSERT INTO `rep_log` VALUES ('559', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:48:37', 'admin');
INSERT INTO `rep_log` VALUES ('560', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:48:49', 'admin');
INSERT INTO `rep_log` VALUES ('561', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-27 12:46:44', 'admin');
INSERT INTO `rep_log` VALUES ('562', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:50:52', 'admin');
INSERT INTO `rep_log` VALUES ('563', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:50:55', 'admin');
INSERT INTO `rep_log` VALUES ('564', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:51:08', 'admin');
INSERT INTO `rep_log` VALUES ('565', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:51:17', 'admin');
INSERT INTO `rep_log` VALUES ('566', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:51:27', 'admin');
INSERT INTO `rep_log` VALUES ('567', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:51:32', 'admin');
INSERT INTO `rep_log` VALUES ('568', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:51:37', 'admin');
INSERT INTO `rep_log` VALUES ('569', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:51:41', 'admin');
INSERT INTO `rep_log` VALUES ('570', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:52:14', 'admin');
INSERT INTO `rep_log` VALUES ('571', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-27 12:52:29', 'admin');
INSERT INTO `rep_log` VALUES ('572', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:52:55', 'admin');
INSERT INTO `rep_log` VALUES ('573', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:53:16', 'admin');
INSERT INTO `rep_log` VALUES ('574', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 12:53:50', 'admin');
INSERT INTO `rep_log` VALUES ('575', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-27 12:59:18', 'admin');
INSERT INTO `rep_log` VALUES ('576', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 13:00:15', 'admin');
INSERT INTO `rep_log` VALUES ('577', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 13:03:09', 'admin');
INSERT INTO `rep_log` VALUES ('578', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 13:04:09', 'admin');
INSERT INTO `rep_log` VALUES ('579', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 13:04:33', 'admin');
INSERT INTO `rep_log` VALUES ('580', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 13:08:24', 'admin');
INSERT INTO `rep_log` VALUES ('581', '1', '0:0:0:0:0:0:0:1', '新增', '上传资源', '2013-10-27 13:08:47', 'admin');
INSERT INTO `rep_log` VALUES ('582', '1', '0:0:0:0:0:0:0:1', '新增', '上传资源', '2013-10-27 13:44:30', 'admin');
INSERT INTO `rep_log` VALUES ('583', '1', '0:0:0:0:0:0:0:1', '新增', '上传资源', '2013-10-27 13:44:46', 'admin');
INSERT INTO `rep_log` VALUES ('584', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-27 13:46:13', 'admin');
INSERT INTO `rep_log` VALUES ('585', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-27 13:48:17', 'admin');
INSERT INTO `rep_log` VALUES ('586', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 13:48:23', 'admin');
INSERT INTO `rep_log` VALUES ('587', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 13:48:46', 'admin');
INSERT INTO `rep_log` VALUES ('588', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 13:49:53', 'admin');
INSERT INTO `rep_log` VALUES ('589', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 13:49:56', 'admin');
INSERT INTO `rep_log` VALUES ('590', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 13:50:01', 'admin');
INSERT INTO `rep_log` VALUES ('591', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 13:50:50', 'admin');
INSERT INTO `rep_log` VALUES ('592', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 13:51:05', 'admin');
INSERT INTO `rep_log` VALUES ('593', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 13:52:23', 'admin');
INSERT INTO `rep_log` VALUES ('594', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 13:51:22', 'admin');
INSERT INTO `rep_log` VALUES ('595', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 13:52:48', 'admin');
INSERT INTO `rep_log` VALUES ('596', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 13:54:41', 'admin');
INSERT INTO `rep_log` VALUES ('597', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 13:56:02', 'admin');
INSERT INTO `rep_log` VALUES ('598', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 13:56:19', 'admin');
INSERT INTO `rep_log` VALUES ('599', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 13:56:22', 'admin');
INSERT INTO `rep_log` VALUES ('600', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-27 13:56:34', 'admin');
INSERT INTO `rep_log` VALUES ('601', '1', '127.0.0.1', '登录', '登录后台', '2013-10-27 13:57:37', 'admin');
INSERT INTO `rep_log` VALUES ('602', '1', '127.0.0.1', '修改', '修改资源', '2013-10-27 13:57:43', 'admin');
INSERT INTO `rep_log` VALUES ('603', '1', '127.0.0.1', '修改', '修改资源', '2013-10-27 13:57:46', 'admin');
INSERT INTO `rep_log` VALUES ('604', '1', '127.0.0.1', '修改', '修改资源', '2013-10-27 13:57:56', 'admin');
INSERT INTO `rep_log` VALUES ('605', '1', '127.0.0.1', '修改', '修改资源', '2013-10-27 13:58:13', 'admin');
INSERT INTO `rep_log` VALUES ('606', '1', '127.0.0.1', '修改', '修改资源', '2013-10-27 13:59:02', 'admin');
INSERT INTO `rep_log` VALUES ('607', '1', '127.0.0.1', '修改', '修改资源', '2013-10-27 13:59:13', 'admin');
INSERT INTO `rep_log` VALUES ('608', '1', '127.0.0.1', '修改', '修改资源', '2013-10-27 14:00:49', 'admin');
INSERT INTO `rep_log` VALUES ('609', '1', '127.0.0.1', '修改', '修改资源', '2013-10-27 14:01:11', 'admin');
INSERT INTO `rep_log` VALUES ('610', '1', '127.0.0.1', '修改', '修改资源', '2013-10-27 14:03:50', 'admin');
INSERT INTO `rep_log` VALUES ('611', '1', '127.0.0.1', '修改', '修改资源', '2013-10-27 14:04:07', 'admin');
INSERT INTO `rep_log` VALUES ('612', '1', '127.0.0.1', '修改', '修改资源', '2013-10-27 14:09:12', 'admin');
INSERT INTO `rep_log` VALUES ('613', '1', '127.0.0.1', '修改', '修改资源', '2013-10-27 14:09:24', 'admin');
INSERT INTO `rep_log` VALUES ('614', '1', '127.0.0.1', '修改', '修改资源', '2013-10-27 14:09:26', 'admin');
INSERT INTO `rep_log` VALUES ('615', '1', '127.0.0.1', '修改', '修改资源', '2013-10-27 14:09:59', 'admin');
INSERT INTO `rep_log` VALUES ('616', '1', '127.0.0.1', '修改', '修改资源', '2013-10-27 14:10:06', 'admin');
INSERT INTO `rep_log` VALUES ('617', '1', '127.0.0.1', '修改', '修改资源', '2013-10-27 14:17:38', 'admin');
INSERT INTO `rep_log` VALUES ('618', '1', '127.0.0.1', '修改', '修改资源', '2013-10-27 14:17:41', 'admin');
INSERT INTO `rep_log` VALUES ('619', '1', '127.0.0.1', '修改', '修改资源', '2013-10-27 14:18:33', 'admin');
INSERT INTO `rep_log` VALUES ('620', '1', '127.0.0.1', '修改', '修改资源', '2013-10-27 14:18:39', 'admin');
INSERT INTO `rep_log` VALUES ('621', '1', '127.0.0.1', '修改', '修改资源', '2013-10-27 14:18:51', 'admin');
INSERT INTO `rep_log` VALUES ('622', '1', '127.0.0.1', '修改', '修改资源', '2013-10-27 14:18:54', 'admin');
INSERT INTO `rep_log` VALUES ('623', '1', '127.0.0.1', '登录', '登录后台', '2013-10-27 17:06:35', 'admin');
INSERT INTO `rep_log` VALUES ('624', '1', '127.0.0.1', '登录', '登录后台', '2013-10-27 18:49:53', 'admin');
INSERT INTO `rep_log` VALUES ('625', '1', '127.0.0.1', '登录', '登录后台', '2013-10-27 20:07:25', 'admin');
INSERT INTO `rep_log` VALUES ('626', '1', '127.0.0.1', '登录', '登录后台', '2013-10-27 20:53:21', 'admin');
INSERT INTO `rep_log` VALUES ('627', '1', '127.0.0.1', '新增', '新增学科类别', '2013-10-27 20:53:38', 'admin');
INSERT INTO `rep_log` VALUES ('628', '1', '127.0.0.1', '新增', '新增学科类别', '2013-10-27 20:53:48', 'admin');
INSERT INTO `rep_log` VALUES ('629', '1', '127.0.0.1', '新增', '新增学科类别', '2013-10-27 20:53:59', 'admin');
INSERT INTO `rep_log` VALUES ('630', '1', '127.0.0.1', '登录', '登录后台', '2013-10-27 23:33:40', 'admin');
INSERT INTO `rep_log` VALUES ('631', '1', '127.0.0.1', '修改', '修改资源', '2013-10-27 23:34:58', 'admin');
INSERT INTO `rep_log` VALUES ('632', '1', '127.0.0.1', '修改', '修改资源', '2013-10-27 23:43:03', 'admin');
INSERT INTO `rep_log` VALUES ('633', '1', '127.0.0.1', '登录', '登录后台', '2013-10-28 20:50:27', 'admin');
INSERT INTO `rep_log` VALUES ('634', '1', '127.0.0.1', '删除', '删除资源', '2013-10-28 20:50:35', 'admin');
INSERT INTO `rep_log` VALUES ('635', '1', '127.0.0.1', '删除', '删除资源', '2013-10-28 20:50:43', 'admin');
INSERT INTO `rep_log` VALUES ('636', '1', '127.0.0.1', '删除', '删除资源', '2013-10-28 20:50:50', 'admin');
INSERT INTO `rep_log` VALUES ('637', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-10-28 20:50:56', 'admin');
INSERT INTO `rep_log` VALUES ('638', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-10-28 20:51:16', 'admin');
INSERT INTO `rep_log` VALUES ('639', '1', '127.0.0.1', '登录', '登录后台', '2013-10-28 21:53:52', 'admin');
INSERT INTO `rep_log` VALUES ('640', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-10-28 21:53:56', 'admin');
INSERT INTO `rep_log` VALUES ('641', '1', '127.0.0.1', '新增', '上传资源', '2013-10-28 21:54:14', 'admin');
INSERT INTO `rep_log` VALUES ('642', '1', '127.0.0.1', '修改', '修改资源', '2013-10-28 21:55:30', 'admin');
INSERT INTO `rep_log` VALUES ('643', '1', '127.0.0.1', '修改', '修改类型类别', '2013-10-28 21:55:44', 'admin');
INSERT INTO `rep_log` VALUES ('644', '1', '127.0.0.1', '新增', '新增类型类别', '2013-10-28 22:06:15', 'admin');
INSERT INTO `rep_log` VALUES ('645', '1', '127.0.0.1', '修改', '修改类型类别', '2013-10-28 22:06:23', 'admin');
INSERT INTO `rep_log` VALUES ('646', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-10-28 22:07:18', 'admin');
INSERT INTO `rep_log` VALUES ('647', '1', '127.0.0.1', '新增', '上传资源', '2013-10-28 22:09:48', 'admin');
INSERT INTO `rep_log` VALUES ('648', '1', '127.0.0.1', '修改', '修改资源', '2013-10-28 22:10:01', 'admin');
INSERT INTO `rep_log` VALUES ('649', '1', '127.0.0.1', '修改', '修改资源', '2013-10-28 22:10:06', 'admin');
INSERT INTO `rep_log` VALUES ('650', '1', '127.0.0.1', '修改', '修改资源', '2013-10-28 22:11:56', 'admin');
INSERT INTO `rep_log` VALUES ('651', '1', '127.0.0.1', '修改', '修改资源', '2013-10-28 22:12:15', 'admin');
INSERT INTO `rep_log` VALUES ('652', '1', '127.0.0.1', '删除', '删除资源', '2013-10-28 22:46:00', 'admin');
INSERT INTO `rep_log` VALUES ('653', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-10-28 22:46:07', 'admin');
INSERT INTO `rep_log` VALUES ('654', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-10-28 22:46:28', 'admin');
INSERT INTO `rep_log` VALUES ('655', '1', '127.0.0.1', '新增', '上传资源', '2013-10-28 22:58:44', 'admin');
INSERT INTO `rep_log` VALUES ('656', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-10-28 23:24:42', 'admin');
INSERT INTO `rep_log` VALUES ('657', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-10-28 23:27:46', 'admin');
INSERT INTO `rep_log` VALUES ('658', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-10-28 23:30:24', 'admin');
INSERT INTO `rep_log` VALUES ('659', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-10-28 23:30:36', 'admin');
INSERT INTO `rep_log` VALUES ('660', '1', '127.0.0.1', '修改', '修改资源', '2013-10-28 23:30:43', 'admin');
INSERT INTO `rep_log` VALUES ('661', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-10-28 23:37:38', 'admin');
INSERT INTO `rep_log` VALUES ('662', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-10-28 23:37:49', 'admin');
INSERT INTO `rep_log` VALUES ('663', '1', '127.0.0.1', '修改', '修改资源', '2013-10-28 23:39:35', 'admin');
INSERT INTO `rep_log` VALUES ('664', '1', '127.0.0.1', '修改', '修改资源', '2013-10-28 23:39:57', 'admin');
INSERT INTO `rep_log` VALUES ('665', '1', '127.0.0.1', '修改', '修改资源', '2013-10-28 23:40:27', 'admin');
INSERT INTO `rep_log` VALUES ('666', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-10-28 23:41:02', 'admin');
INSERT INTO `rep_log` VALUES ('667', '1', '127.0.0.1', '新增', '上传资源', '2013-10-28 23:41:13', 'admin');
INSERT INTO `rep_log` VALUES ('668', '1', '127.0.0.1', '新增', '上传资源', '2013-10-29 00:00:01', 'admin');
INSERT INTO `rep_log` VALUES ('669', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-29 15:39:25', 'admin');
INSERT INTO `rep_log` VALUES ('670', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-29 15:39:35', 'admin');
INSERT INTO `rep_log` VALUES ('671', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-29 15:39:46', 'admin');
INSERT INTO `rep_log` VALUES ('672', '1', '0:0:0:0:0:0:0:1', '删除', '删除资源', '2013-10-29 15:39:57', 'admin');
INSERT INTO `rep_log` VALUES ('673', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-29 16:37:32', 'admin');
INSERT INTO `rep_log` VALUES ('674', '1', '0:0:0:0:0:0:0:1', '新增', '上传资源', '2013-10-29 16:37:58', 'admin');
INSERT INTO `rep_log` VALUES ('675', '1', '0:0:0:0:0:0:0:1', '新增', '上传资源', '2013-10-29 16:55:30', 'admin');
INSERT INTO `rep_log` VALUES ('676', '1', '0:0:0:0:0:0:0:1', '新增', '上传资源', '2013-10-29 16:55:44', 'admin');
INSERT INTO `rep_log` VALUES ('677', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-29 16:55:49', 'admin');
INSERT INTO `rep_log` VALUES ('678', '1', '0:0:0:0:0:0:0:1', '新增', '上传资源', '2013-10-29 16:56:26', 'admin');
INSERT INTO `rep_log` VALUES ('679', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-29 18:23:17', 'admin');
INSERT INTO `rep_log` VALUES ('680', '1', '0:0:0:0:0:0:0:1', '新增', '上传资源', '2013-10-29 18:44:41', 'admin');
INSERT INTO `rep_log` VALUES ('681', '1', '0:0:0:0:0:0:0:1', '新增', '上传资源', '2013-10-29 19:05:46', 'admin');
INSERT INTO `rep_log` VALUES ('682', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-29 19:07:08', 'admin');
INSERT INTO `rep_log` VALUES ('683', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-29 19:12:52', 'admin');
INSERT INTO `rep_log` VALUES ('684', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-10-29 19:13:07', 'admin');
INSERT INTO `rep_log` VALUES ('685', '1', '0:0:0:0:0:0:0:1', '新增', '上传资源', '2013-10-29 19:14:16', 'admin');
INSERT INTO `rep_log` VALUES ('686', '1', '0:0:0:0:0:0:0:1', '新增', '上传资源', '2013-10-29 19:24:00', 'admin');
INSERT INTO `rep_log` VALUES ('687', '1', '0:0:0:0:0:0:0:1', '新增', '上传资源', '2013-10-29 19:55:30', 'admin');
INSERT INTO `rep_log` VALUES ('688', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-29 20:01:44', 'admin');
INSERT INTO `rep_log` VALUES ('689', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-29 20:02:14', 'admin');
INSERT INTO `rep_log` VALUES ('690', '1', '0:0:0:0:0:0:0:1', '删除', '删除资源', '2013-10-29 20:03:15', 'admin');
INSERT INTO `rep_log` VALUES ('691', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-29 20:02:11', 'admin');
INSERT INTO `rep_log` VALUES ('692', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-29 20:02:47', 'admin');
INSERT INTO `rep_log` VALUES ('693', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-30 23:35:56', 'admin');
INSERT INTO `rep_log` VALUES ('694', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-30 23:36:01', 'admin');
INSERT INTO `rep_log` VALUES ('695', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-10-30 23:36:20', 'admin');
INSERT INTO `rep_log` VALUES ('696', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-10-31 22:25:21', 'admin');
INSERT INTO `rep_log` VALUES ('697', '1', '0:0:0:0:0:0:0:1', '新增', '上传资源', '2013-10-31 22:25:56', 'admin');
INSERT INTO `rep_log` VALUES ('698', '1', '0:0:0:0:0:0:0:1', '新增', '上传资源', '2013-10-31 22:33:12', 'admin');
INSERT INTO `rep_log` VALUES ('699', '1', '127.0.0.1', '登录', '登录后台', '2013-11-01 00:14:41', 'admin');
INSERT INTO `rep_log` VALUES ('700', '1', '127.0.0.1', '修改', '修改角色', '2013-11-01 00:15:01', 'admin');
INSERT INTO `rep_log` VALUES ('701', '1', '127.0.0.1', '修改', '修改角色', '2013-11-01 00:15:09', 'admin');
INSERT INTO `rep_log` VALUES ('702', '1', '127.0.0.1', '登录', '登录后台', '2013-11-01 00:20:53', 'admin');
INSERT INTO `rep_log` VALUES ('703', '1', '127.0.0.1', '删除', '删除资源', '2013-11-01 00:21:19', 'admin');
INSERT INTO `rep_log` VALUES ('704', '1', '127.0.0.1', '修改', '修改资源', '2013-11-01 00:21:23', 'admin');
INSERT INTO `rep_log` VALUES ('705', '1', '127.0.0.1', '修改', '修改资源', '2013-11-01 00:21:26', 'admin');
INSERT INTO `rep_log` VALUES ('706', '1', '127.0.0.1', '修改', '审核通过资源', '2013-11-01 00:21:43', 'admin');
INSERT INTO `rep_log` VALUES ('707', '1', '127.0.0.1', '新增', '上传资源', '2013-11-01 00:22:05', 'admin');
INSERT INTO `rep_log` VALUES ('708', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-11-01 00:22:07', 'admin');
INSERT INTO `rep_log` VALUES ('709', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-11-01 00:22:15', 'admin');
INSERT INTO `rep_log` VALUES ('710', '1', '127.0.0.1', '新增', '新增类型类别', '2013-11-01 00:22:37', 'admin');
INSERT INTO `rep_log` VALUES ('711', '1', '127.0.0.1', '新增', '新增前台用户', '2013-11-01 00:22:53', 'admin');
INSERT INTO `rep_log` VALUES ('712', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-11-01 16:39:51', 'admin');
INSERT INTO `rep_log` VALUES ('713', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-11-01 17:07:39', 'admin');
INSERT INTO `rep_log` VALUES ('714', '1', '127.0.0.1', '登录', '登录后台', '2013-11-01 17:09:38', 'admin');
INSERT INTO `rep_log` VALUES ('715', '1', '127.0.0.1', '登录', '登录后台', '2013-11-01 20:41:12', 'admin');
INSERT INTO `rep_log` VALUES ('716', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-11-01 20:41:15', 'admin');
INSERT INTO `rep_log` VALUES ('717', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-11-01 20:42:55', 'admin');
INSERT INTO `rep_log` VALUES ('718', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-11-01 20:44:43', 'admin');
INSERT INTO `rep_log` VALUES ('719', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-11-01 20:43:50', 'admin');
INSERT INTO `rep_log` VALUES ('720', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-11-01 20:45:00', 'admin');
INSERT INTO `rep_log` VALUES ('721', '1', '127.0.0.1', '登录', '登录后台', '2013-11-01 21:19:41', 'admin');
INSERT INTO `rep_log` VALUES ('722', '1', '127.0.0.1', '修改', '修改资源', '2013-11-01 21:19:45', 'admin');
INSERT INTO `rep_log` VALUES ('723', '1', '127.0.0.1', '修改', '修改资源', '2013-11-01 21:19:56', 'admin');
INSERT INTO `rep_log` VALUES ('724', '1', '127.0.0.1', '修改', '修改资源', '2013-11-01 21:21:53', 'admin');
INSERT INTO `rep_log` VALUES ('725', '1', '127.0.0.1', '修改', '修改资源', '2013-11-01 21:22:04', 'admin');
INSERT INTO `rep_log` VALUES ('726', '1', '127.0.0.1', '修改', '修改资源', '2013-11-01 21:32:23', 'admin');
INSERT INTO `rep_log` VALUES ('727', '1', '127.0.0.1', '修改', '修改资源', '2013-11-01 21:32:32', 'admin');
INSERT INTO `rep_log` VALUES ('728', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-11-01 22:16:50', 'admin');
INSERT INTO `rep_log` VALUES ('729', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-11-01 22:17:03', 'admin');
INSERT INTO `rep_log` VALUES ('730', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-11-01 22:17:18', 'admin');
INSERT INTO `rep_log` VALUES ('731', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-11-01 22:21:18', 'admin');
INSERT INTO `rep_log` VALUES ('732', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-11-01 22:21:36', 'admin');
INSERT INTO `rep_log` VALUES ('733', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-11-01 22:23:13', 'admin');
INSERT INTO `rep_log` VALUES ('734', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-11-01 22:23:27', 'admin');
INSERT INTO `rep_log` VALUES ('735', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-11-01 22:25:10', 'admin');
INSERT INTO `rep_log` VALUES ('736', '1', '0:0:0:0:0:0:0:1', '修改', '修改资源', '2013-11-01 22:28:09', 'admin');
INSERT INTO `rep_log` VALUES ('737', '1', '0:0:0:0:0:0:0:1', '删除', '删除资源', '2013-11-01 22:30:27', 'admin');
INSERT INTO `rep_log` VALUES ('738', '1', '127.0.0.1', '登录', '登录后台', '2013-11-01 22:30:31', 'admin');
INSERT INTO `rep_log` VALUES ('739', '1', '127.0.0.1', '删除', '删除资源', '2013-11-01 22:30:48', 'admin');
INSERT INTO `rep_log` VALUES ('740', '1', '127.0.0.1', '删除', '删除资源', '2013-11-01 22:30:57', 'admin');
INSERT INTO `rep_log` VALUES ('741', '1', '127.0.0.1', '新增', '上传资源', '2013-11-01 22:31:21', 'admin');
INSERT INTO `rep_log` VALUES ('742', '1', '127.0.0.1', '修改', '修改资源', '2013-11-01 22:42:47', 'admin');
INSERT INTO `rep_log` VALUES ('743', '1', '127.0.0.1', '修改', '修改资源', '2013-11-01 22:44:50', 'admin');
INSERT INTO `rep_log` VALUES ('744', '1', '127.0.0.1', '修改', '修改资源', '2013-11-01 22:46:39', 'admin');
INSERT INTO `rep_log` VALUES ('745', '1', '127.0.0.1', '修改', '修改资源', '2013-11-01 22:46:55', 'admin');
INSERT INTO `rep_log` VALUES ('746', '1', '127.0.0.1', '新增', '上传资源', '2013-11-01 22:49:03', 'admin');
INSERT INTO `rep_log` VALUES ('747', '1', '127.0.0.1', '修改', '修改资源', '2013-11-01 22:59:14', 'admin');
INSERT INTO `rep_log` VALUES ('748', '1', '127.0.0.1', '新增', '上传资源', '2013-11-01 23:01:23', 'admin');
INSERT INTO `rep_log` VALUES ('749', '1', '127.0.0.1', '新增', '上传资源', '2013-11-01 23:02:09', 'admin');
INSERT INTO `rep_log` VALUES ('750', '1', '127.0.0.1', '新增', '上传资源', '2013-11-01 23:23:43', 'admin');
INSERT INTO `rep_log` VALUES ('751', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-11-01 23:28:44', 'admin');
INSERT INTO `rep_log` VALUES ('752', '1', '0:0:0:0:0:0:0:1', '新增', '上传资源', '2013-11-01 23:29:13', 'admin');
INSERT INTO `rep_log` VALUES ('753', '1', '0:0:0:0:0:0:0:1', '修改', '修改公告', '2013-11-01 23:32:46', 'admin');
INSERT INTO `rep_log` VALUES ('754', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-11-02 20:09:47', 'admin');
INSERT INTO `rep_log` VALUES ('755', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-11-03 14:40:56', 'admin');
INSERT INTO `rep_log` VALUES ('756', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-11-03 14:44:12', 'admin');
INSERT INTO `rep_log` VALUES ('757', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-11-03 14:44:17', 'admin');
INSERT INTO `rep_log` VALUES ('758', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-11-03 14:44:24', 'admin');
INSERT INTO `rep_log` VALUES ('759', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-11-03 14:44:54', 'admin');
INSERT INTO `rep_log` VALUES ('760', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-11-03 21:09:23', 'admin');
INSERT INTO `rep_log` VALUES ('761', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-11-04 19:08:06', 'admin');
INSERT INTO `rep_log` VALUES ('762', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-11-04 19:48:34', 'admin');
INSERT INTO `rep_log` VALUES ('763', '1', '0:0:0:0:0:0:0:1', '删除', '删除公告', '2013-11-04 19:50:43', 'admin');
INSERT INTO `rep_log` VALUES ('764', '1', '0:0:0:0:0:0:0:1', '修改', '修改类型类别', '2013-11-04 19:51:02', 'admin');
INSERT INTO `rep_log` VALUES ('765', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-11-05 15:13:12', 'admin');
INSERT INTO `rep_log` VALUES ('766', '1', '0:0:0:0:0:0:0:1', '删除', '删除资源', '2013-11-05 15:13:25', 'admin');
INSERT INTO `rep_log` VALUES ('767', '1', '0:0:0:0:0:0:0:1', '新增', '上传资源', '2013-11-05 15:13:51', 'admin');
INSERT INTO `rep_log` VALUES ('768', '1', '0:0:0:0:0:0:0:1', '新增', '上传资源', '2013-11-05 15:14:25', 'admin');
INSERT INTO `rep_log` VALUES ('769', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-11-05 15:15:25', 'admin');
INSERT INTO `rep_log` VALUES ('770', '1', '0:0:0:0:0:0:0:1', '新增', '新增专题', '2013-11-05 15:15:52', 'admin');
INSERT INTO `rep_log` VALUES ('771', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-11-05 15:15:55', 'admin');
INSERT INTO `rep_log` VALUES ('772', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-11-05 15:16:16', 'admin');
INSERT INTO `rep_log` VALUES ('773', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-11-05 15:16:33', 'admin');
INSERT INTO `rep_log` VALUES ('774', '1', '0:0:0:0:0:0:0:1', '删除', '删除专题', '2013-11-05 15:16:50', 'admin');
INSERT INTO `rep_log` VALUES ('775', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-11-05 15:16:53', 'admin');
INSERT INTO `rep_log` VALUES ('776', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-11-05 15:17:22', 'admin');
INSERT INTO `rep_log` VALUES ('777', '1', '0:0:0:0:0:0:0:1', '新增', '上传资源', '2013-11-05 15:28:45', 'admin');
INSERT INTO `rep_log` VALUES ('778', '1', '0:0:0:0:0:0:0:1', '新增', '新增公告', '2013-11-05 15:40:48', 'admin');
INSERT INTO `rep_log` VALUES ('779', '1', '0:0:0:0:0:0:0:1', '新增', '批量上传专题资源', '2013-11-05 15:46:08', 'admin');
INSERT INTO `rep_log` VALUES ('780', '1', '0:0:0:0:0:0:0:1', '删除', '删除前台用户', '2013-11-05 16:39:02', 'admin');
INSERT INTO `rep_message` VALUES ('11', 'ch1数制和码制ss', '2013-10-20 22:30:32', '搜索xxsx', '1', '2013-10-20 22:05:56', null, '1', '2013-10-30 01:10:35', 'xxxxxx', '0', '0', '管理员dd', null, '管理员sxs');
INSERT INTO `rep_notice` VALUES ('7', 'ch1数制和码制', '2013-11-15 13:35:00', 'xxxxxxxxxxxxxxxxxxxxxxx', '1', '0', '1', '杨真', null, '2');
INSERT INTO `rep_params` VALUES ('1', '0', '0', '0', '1', '0', '1', '0', '0', 'doc:20,docx:20,xls:20,xlsx:20,ppt:20,pptx:20,pdf:200,txt:20,jpg:20,gif:20,mp4:500,flv:500,swf:500');
INSERT INTO `rep_permission` VALUES ('1', '查询前台用户', '查询前台用户', '0', 'user_list');
INSERT INTO `rep_permission` VALUES ('2', '审核前台用户', '审核前台用户', '0', 'user_pass');
INSERT INTO `rep_permission` VALUES ('3', '锁定前台用户', '锁定前台用户', '0', 'user_lock');
INSERT INTO `rep_permission` VALUES ('4', '解锁前台用户', '解锁前台用户', '0', 'user_unlock');
INSERT INTO `rep_permission` VALUES ('5', '删除前台用户', '删除前台用户', '0', 'user_delete');
INSERT INTO `rep_permission` VALUES ('6', '新增前台用户', '新增前台用户', '0', 'user_add');
INSERT INTO `rep_permission` VALUES ('7', '编辑前台用户', '编辑前台用户', '0', 'user_update');
INSERT INTO `rep_permission` VALUES ('8', '查询后台用户', '查询后台用户', '0', 'admin_list');
INSERT INTO `rep_permission` VALUES ('9', '锁定后台用户', '锁定后台用户', '0', 'admin_lock');
INSERT INTO `rep_permission` VALUES ('10', '解锁后台用户', '解锁后台用户', '0', 'admin_unlock');
INSERT INTO `rep_permission` VALUES ('11', '删除后台用户', '删除前台用户', '0', 'admin_delete');
INSERT INTO `rep_permission` VALUES ('12', '新增后台用户', '新增后台用户', '0', 'admin_add');
INSERT INTO `rep_permission` VALUES ('13', '编辑后台用户', '编辑后台用户', '0', 'admin_update');
INSERT INTO `rep_permission` VALUES ('14', '参数配置', '参数配置', '0', 'param_update');
INSERT INTO `rep_permission` VALUES ('15', '修改角色', '修改角色', '0', 'role_update');
INSERT INTO `rep_permission` VALUES ('16', '查询角色', '查询角色', '0', 'role_list');
INSERT INTO `rep_permission` VALUES ('17', '删除角色', '删除角色', '0', 'role_delete');
INSERT INTO `rep_permission` VALUES ('18', '新增角色', '新增角色', '0', 'role_add');
INSERT INTO `rep_permission` VALUES ('19', '查询操作日志', '查询操作日志', '0', 'log_list');
INSERT INTO `rep_permission` VALUES ('20', '删除操作日志', '删除操作日志', '0', 'lod_delete');
INSERT INTO `rep_permission` VALUES ('21', '查询类型类别', '查询类型类别', '0', 'gscatalog_list');
INSERT INTO `rep_permission` VALUES ('22', '新增类型类别', '新增类型类别', '0', 'gscatalog_add');
INSERT INTO `rep_permission` VALUES ('23', '修改类型类别', '修改类型类别', '0', 'gscatalog_update');
INSERT INTO `rep_permission` VALUES ('24', '删除类型类别', '删除类型类别', '0', 'gscatalog_delete');
INSERT INTO `rep_permission` VALUES ('25', '查询学科类别', '查询学科类别', '0', 'zycatalog_list');
INSERT INTO `rep_permission` VALUES ('26', '新增学科类别', '新增学科类别', '0', 'zycatalog_add');
INSERT INTO `rep_permission` VALUES ('27', '修改学科类别', '修改学科类别', '0', 'zycatalog_update');
INSERT INTO `rep_permission` VALUES ('28', '删除学科类别', '删除学科类别', '0', 'zycatalog_delete');
INSERT INTO `rep_permission` VALUES ('29', '查询标签', '查询标签', '0', 'tag_list');
INSERT INTO `rep_permission` VALUES ('30', '新增标签', '新增标签', '0', 'tag_add');
INSERT INTO `rep_permission` VALUES ('31', '修改标签', '修改标签', '0', 'tag_update');
INSERT INTO `rep_permission` VALUES ('32', '删除标签', '删除标签', '0', 'tag_delete');
INSERT INTO `rep_permission` VALUES ('33', '查询专题', '查询专题', '0', 'topic_list');
INSERT INTO `rep_permission` VALUES ('34', '新增专题', '新增专题', '0', 'topic_add');
INSERT INTO `rep_permission` VALUES ('35', '修改专题', '修改专题', '0', 'topic_update');
INSERT INTO `rep_permission` VALUES ('36', '删除专题', '删除专题', '0', 'topic_delete');
INSERT INTO `rep_permission` VALUES ('37', '查询资源', '查询资源', '0', 'resource_list');
INSERT INTO `rep_permission` VALUES ('38', '删除资源', '删除资源', '0', 'resource_delete');
INSERT INTO `rep_permission` VALUES ('39', '审核通过资源', '审核通过资源', '0', 'resource_pass');
INSERT INTO `rep_permission` VALUES ('40', '退回资源', '退回资源', '0', 'resource_reject');
INSERT INTO `rep_permission` VALUES ('41', '修改资源', '修改资源', '0', 'resource_update');
INSERT INTO `rep_permission` VALUES ('42', '上传资源', '上传资源', '0', 'resource_add');
INSERT INTO `rep_permission` VALUES ('43', '批量上传专题资源', '批量上传专题资源', '0', 'resource_addMulti');
INSERT INTO `rep_permission` VALUES ('44', '查询资源评论', '查询资源评论', '0', 'comment_list');
INSERT INTO `rep_permission` VALUES ('45', '删除资源评论', '删除资源评论', '0', 'comment_delete');
INSERT INTO `rep_permission` VALUES ('46', '审核通过资源评论', '审核通过资源评论', '0', 'comment_pass');
INSERT INTO `rep_permission` VALUES ('47', '退回资源评论', '退回资源评论', '0', 'comment_reject');
INSERT INTO `rep_permission` VALUES ('48', '修改资源评论', '修改资源评论', '0', 'comment_update');
INSERT INTO `rep_permission` VALUES ('49', '查询公告', '查询公告', '0', 'notice_list');
INSERT INTO `rep_permission` VALUES ('50', '新增公告', '新增公告', '0', 'notice_add');
INSERT INTO `rep_permission` VALUES ('51', '修改公告', '修改公告', '0', 'notice_update');
INSERT INTO `rep_permission` VALUES ('52', '发布公告', '发布公告', '0', 'notice_pass');
INSERT INTO `rep_permission` VALUES ('53', '删除公告', '删除公告', '0', 'notice_delete');
INSERT INTO `rep_permission` VALUES ('54', '查询答疑帮助', '查询答疑帮助', '0', 'asks_list');
INSERT INTO `rep_permission` VALUES ('55', '修改答疑帮助', '修改答疑帮助', '0', 'asks_edit');
INSERT INTO `rep_permission` VALUES ('56', '回复答疑帮助', '回复答疑帮助', '0', 'asks_reply');
INSERT INTO `rep_permission` VALUES ('57', '修改回复', '修改回复', '0', 'asks_replyEdit');
INSERT INTO `rep_permission` VALUES ('58', '删除答疑帮助', '删除答疑帮助', '0', 'asks-_delete');
INSERT INTO `rep_permission` VALUES ('59', '审核通过答疑帮助', '审核通过答疑帮助', '0', 'asks_pass');
INSERT INTO `rep_resource` VALUES ('517', '晚上值班', '/uploads/10/3/0b69b7db-bf6b-43b3-b8d4-49f3be77d56b.docx', '9728', null, '1', '2013-11-05 15:13:51', '2013-11-05 15:13:51', '0', '0', '1', '2013-11-05 15:13:51', '', '1', '/thirdparty/officetranslate/swfs/9d29affa-927f-45db-b849-f867bc719976.swf', '1', '', null, '', 'admin', null, '0');
INSERT INTO `rep_resource` VALUES ('518', '老妇人与死神_H264高清_480x360', '/uploads/10/0/d8ac82fa-5c68-43a4-9407-67d51e0e4f7f.mp4', '39250656', null, '1', '2013-11-05 15:14:25', '2013-11-05 15:14:25', '0', '0', '1', '2013-11-05 15:14:25', '', '5', null, '2', '', null, '', 'admin', null, '0');
INSERT INTO `rep_resource` VALUES ('519', '经管资源库项目需求说明书（终结）', '/uploads/6/9/46b19efa-5740-43f6-b9a6-4734b3615ef5.doc', '431616', null, '1', '2013-11-05 15:17:22', '2013-11-05 15:17:22', '0', '0', '1', '2013-11-05 15:17:22', '', null, '/thirdparty/officetranslate/swfs/6adb0e04-8fe3-4cfc-af43-13280246877b.swf', null, '', null, '', 'admin', null, '0');
INSERT INTO `rep_resource` VALUES ('520', '经管资源库项目数据库设计文档----杨真(高伟改后)', '/uploads/1/12/df91934d-8b1c-4eb5-8362-929ee1cd8c05.doc', '247296', null, '1', '2013-11-05 15:17:22', '2013-11-05 15:17:22', '0', '0', '1', '2013-11-05 15:17:22', '', null, '/thirdparty/officetranslate/swfs/d27ba7f8-cafc-42dc-91a5-5269d877cba0.swf', null, '', null, '', 'admin', null, '0');
INSERT INTO `rep_resource` VALUES ('521', '经管资源库项目软件需求说明书----杨真(修改)', '/uploads/0/0/ee50c0a3-6900-4d88-ab4d-144187bb5622.doc', '486812', null, '1', '2013-11-05 15:17:22', '2013-11-05 15:17:22', '0', '0', '1', '2013-11-05 15:17:22', '', null, '/thirdparty/officetranslate/swfs/a51c0666-5f7f-4627-8905-cd9cea2d7a9a.swf', null, '', null, '', 'admin', null, '0');
INSERT INTO `rep_resource` VALUES ('522', '经管资源库项目软件需求说明书（杨真） ', '/uploads/0/12/f51705ed-57e0-404f-b672-30b067bcc1d4.doc', '384044', null, '1', '2013-11-05 15:17:22', '2013-11-05 15:17:22', '0', '0', '1', '2013-11-05 15:17:22', '', null, '/thirdparty/officetranslate/swfs/f238abba-c2fa-4dd0-a477-0dd449a37939.swf', null, '', null, '', 'admin', null, '0');
INSERT INTO `rep_resource` VALUES ('523', '教学资源管理(数据库)彭倩', '/uploads/10/12/322f0196-3882-4878-8bc1-dc7c1827613b.doc', '225792', null, '1', '2013-11-05 15:17:22', '2013-11-05 15:17:22', '0', '0', '1', '2013-11-05 15:17:22', '', null, '/thirdparty/officetranslate/swfs/4c3bace3-7202-4602-8873-03c1f5124f15.swf', null, '', null, '', 'admin', null, '0');
INSERT INTO `rep_resource` VALUES ('524', '彭倩——需求分析', '/uploads/3/5/2bb13457-4494-4083-9501-e7345d94bb7b.doc', '213282', null, '1', '2013-11-05 15:17:22', '2013-11-05 15:17:22', '0', '0', '1', '2013-11-05 15:17:22', '', null, '/thirdparty/officetranslate/swfs/ff59e48f-f0d8-458c-9b1d-ad99fb101dc4.swf', null, '', null, '', 'admin', null, '0');
INSERT INTO `rep_resource` VALUES ('525', '彭倩——需求分析(dsh modify) ', '/uploads/0/8/a33b9cc0-a5c0-46a5-be3e-a7af42cf5117.doc', '181984', null, '1', '2013-11-05 15:17:22', '2013-11-05 15:17:22', '0', '0', '1', '2013-11-05 15:17:22', '', null, '/thirdparty/officetranslate/swfs/6955359b-45b6-44b5-917e-2c95fed84cce.swf', null, '', null, '', 'admin', null, '0');
INSERT INTO `rep_resource` VALUES ('526', '彭倩——经管资源库项目需求说明书', '/uploads/9/0/94c5112c-4a81-415f-857a-30cf884ec222.doc', '251932', null, '1', '2013-11-05 15:17:22', '2013-11-05 15:17:22', '0', '0', '1', '2013-11-05 15:17:22', '', null, '/thirdparty/officetranslate/swfs/e3feb73b-9f03-4fa5-a6a3-6f967c2ee673.swf', null, '', null, '', 'admin', null, '0');
INSERT INTO `rep_resource` VALUES ('527', '彭倩——经管资源库项目需求说明书（修改）', '/uploads/0/5/96df5eaa-ce5e-4efa-97c0-fbeca7280b33.doc', '391168', null, '1', '2013-11-05 15:17:22', '2013-11-05 15:17:22', '0', '0', '1', '2013-11-05 15:17:22', '', null, '/thirdparty/officetranslate/swfs/dff75b29-b03d-40c0-be5a-6558ba94f015.swf', null, '', null, '', 'admin', null, '0');
INSERT INTO `rep_resource` VALUES ('528', '彭大帅—教学资源库调研报告', '/uploads/9/3/3ec2732d-7253-4439-88e6-e6ef0ce22ffd.doc', '325120', null, '1', '2013-11-05 15:17:22', '2013-11-05 15:17:22', '0', '0', '1', '2013-11-05 15:17:22', '', null, '/thirdparty/officetranslate/swfs/678751e8-022b-4d4c-8f1a-aa3d625846e1.swf', null, '', null, '', 'admin', null, '0');
INSERT INTO `rep_resource` VALUES ('529', '资源库功能设计方案调研报告(杨真)', '/uploads/9/8/a99f1b2c-f470-476f-978d-2e5440d3cb71.doc', '345600', null, '1', '2013-11-05 15:17:22', '2013-11-05 15:17:22', '0', '0', '1', '2013-11-05 15:17:22', '', null, '/thirdparty/officetranslate/swfs/82fe81de-4c7a-4723-bed4-92172b593d71.swf', null, '', null, '', 'admin', null, '0');
INSERT INTO `rep_resource` VALUES ('530', '数字资源管理系统的选择方略', '/uploads/7/10/128f2540-56c2-499b-89be-4686efa6eb35.doc', '39936', null, '1', '2013-11-05 15:17:22', '2013-11-05 15:17:22', '0', '0', '1', '2013-11-05 15:17:22', '', null, '/thirdparty/officetranslate/swfs/a91dae19-c770-4e20-96d2-be1eed9a0acd.swf', null, '', null, '', 'admin', null, '0');
INSERT INTO `rep_resource` VALUES ('531', '前台界面设计要求', '/uploads/12/7/8177e69e-469a-4c17-aa5f-255281983b50.doc', '24313', null, '1', '2013-11-05 15:17:22', '2013-11-05 15:17:22', '0', '0', '1', '2013-11-05 15:17:22', '', null, '/thirdparty/officetranslate/swfs/c502a35c-ff23-4b85-b860-fc8f0dcab7b5.swf', null, '', null, '', 'admin', null, '0');
INSERT INTO `rep_resource` VALUES ('532', '前台界面设计要求 （杨真修改  ）', '/uploads/9/9/30ada8eb-8e63-4c58-95df-926ed4369197.doc', '332288', null, '1', '2013-11-05 15:17:22', '2013-11-05 15:17:22', '0', '0', '1', '2013-11-05 15:17:22', '', null, '/thirdparty/officetranslate/swfs/e40f1a37-d543-46f4-8c07-d9b0b90d2c96.swf', null, '', null, '', 'admin', null, '0');
INSERT INTO `rep_resource` VALUES ('533', '资源库功能设计方案调研报告（重新整合）', '/uploads/1/10/053bdc31-217a-45e3-8eec-5d9508206d8d.doc', '412668', null, '1', '2013-11-05 15:17:22', '2013-11-05 15:17:22', '0', '0', '1', '2013-11-05 15:17:22', '', null, '/thirdparty/officetranslate/swfs/0cf6d413-a108-492a-8f57-ac2fabaad512.swf', null, '', null, '', 'admin', null, '0');
INSERT INTO `rep_resource` VALUES ('534', '资源库功能设计方案调研报告（整合版）', '/uploads/11/12/3b5f1a5b-e6ba-4915-9211-842bd5cb934b.doc', '409852', null, '1', '2013-11-05 15:17:22', '2013-11-05 15:17:22', '0', '0', '1', '2013-11-05 15:17:22', '', null, '/thirdparty/officetranslate/swfs/dcc14a8c-d125-44e5-a412-c98da3e3b5af.swf', null, '', null, '', 'admin', null, '0');
INSERT INTO `rep_resource` VALUES ('535', '长沙理工大学主站改版说明', '/uploads/12/8/d2544a69-edbf-45cf-9ad7-34bb5c40aba4.doc', '2571776', null, '1', '2013-11-05 15:17:22', '2013-11-05 15:17:22', '0', '0', '1', '2013-11-05 15:17:22', '', null, '/thirdparty/officetranslate/swfs/73b14bac-459d-498b-8270-624f5f8543aa.swf', null, '', null, '', 'admin', null, '0');
INSERT INTO `rep_resource` VALUES ('536', '动量守恒数据处理(1)', '/uploads/9/7/284cb4f2-1101-4909-a09a-8037a6bbe575.xls', '15360', null, '1', '2013-11-05 15:28:45', '2013-11-05 15:28:45', '0', '0', '1', '2013-11-05 15:28:45', '', '1', '/thirdparty/officetranslate/swfs/18d2044d-911d-4569-ab99-3a5946ceedfb.swf', '1', '', null, '', 'admin', null, '0');
INSERT INTO `rep_role` VALUES ('1', '超级管理员', '超级管理员', '9');
INSERT INTO `rep_role_permission` VALUES ('1', '1');
INSERT INTO `rep_role_permission` VALUES ('1', '2');
INSERT INTO `rep_role_permission` VALUES ('1', '3');
INSERT INTO `rep_role_permission` VALUES ('1', '4');
INSERT INTO `rep_role_permission` VALUES ('1', '5');
INSERT INTO `rep_role_permission` VALUES ('1', '6');
INSERT INTO `rep_role_permission` VALUES ('1', '7');
INSERT INTO `rep_role_permission` VALUES ('1', '8');
INSERT INTO `rep_role_permission` VALUES ('1', '9');
INSERT INTO `rep_role_permission` VALUES ('1', '10');
INSERT INTO `rep_role_permission` VALUES ('1', '11');
INSERT INTO `rep_role_permission` VALUES ('1', '12');
INSERT INTO `rep_role_permission` VALUES ('1', '13');
INSERT INTO `rep_role_permission` VALUES ('1', '14');
INSERT INTO `rep_role_permission` VALUES ('1', '15');
INSERT INTO `rep_role_permission` VALUES ('1', '16');
INSERT INTO `rep_role_permission` VALUES ('1', '17');
INSERT INTO `rep_role_permission` VALUES ('1', '18');
INSERT INTO `rep_role_permission` VALUES ('1', '19');
INSERT INTO `rep_role_permission` VALUES ('1', '20');
INSERT INTO `rep_role_permission` VALUES ('1', '21');
INSERT INTO `rep_role_permission` VALUES ('1', '22');
INSERT INTO `rep_role_permission` VALUES ('1', '23');
INSERT INTO `rep_role_permission` VALUES ('1', '24');
INSERT INTO `rep_role_permission` VALUES ('1', '25');
INSERT INTO `rep_role_permission` VALUES ('1', '26');
INSERT INTO `rep_role_permission` VALUES ('1', '27');
INSERT INTO `rep_role_permission` VALUES ('1', '28');
INSERT INTO `rep_role_permission` VALUES ('1', '29');
INSERT INTO `rep_role_permission` VALUES ('1', '30');
INSERT INTO `rep_role_permission` VALUES ('1', '31');
INSERT INTO `rep_role_permission` VALUES ('1', '32');
INSERT INTO `rep_role_permission` VALUES ('1', '33');
INSERT INTO `rep_role_permission` VALUES ('1', '34');
INSERT INTO `rep_role_permission` VALUES ('1', '35');
INSERT INTO `rep_role_permission` VALUES ('1', '36');
INSERT INTO `rep_role_permission` VALUES ('1', '37');
INSERT INTO `rep_role_permission` VALUES ('1', '38');
INSERT INTO `rep_role_permission` VALUES ('1', '39');
INSERT INTO `rep_role_permission` VALUES ('1', '40');
INSERT INTO `rep_role_permission` VALUES ('1', '41');
INSERT INTO `rep_role_permission` VALUES ('1', '42');
INSERT INTO `rep_role_permission` VALUES ('1', '43');
INSERT INTO `rep_role_permission` VALUES ('1', '44');
INSERT INTO `rep_role_permission` VALUES ('1', '45');
INSERT INTO `rep_role_permission` VALUES ('1', '46');
INSERT INTO `rep_role_permission` VALUES ('1', '47');
INSERT INTO `rep_role_permission` VALUES ('1', '48');
INSERT INTO `rep_role_permission` VALUES ('1', '49');
INSERT INTO `rep_role_permission` VALUES ('1', '50');
INSERT INTO `rep_role_permission` VALUES ('1', '51');
INSERT INTO `rep_role_permission` VALUES ('1', '52');
INSERT INTO `rep_role_permission` VALUES ('1', '53');
INSERT INTO `rep_role_permission` VALUES ('1', '54');
INSERT INTO `rep_role_permission` VALUES ('1', '55');
INSERT INTO `rep_role_permission` VALUES ('1', '56');
INSERT INTO `rep_role_permission` VALUES ('1', '57');
INSERT INTO `rep_role_permission` VALUES ('1', '58');
INSERT INTO `rep_role_permission` VALUES ('1', '59');
INSERT INTO `rep_tag` VALUES ('4', '企业管理学');
INSERT INTO `rep_tag` VALUES ('5', 'aa');
INSERT INTO `rep_tag` VALUES ('6', 'jkd');
INSERT INTO `rep_tag` VALUES ('7', 'jhjh');
INSERT INTO `rep_tag` VALUES ('8', 'vv');
INSERT INTO `rep_tag` VALUES ('9', 'df');
INSERT INTO `rep_zycatalog` VALUES ('1', '会计学专业', '会计学专业', null);
INSERT INTO `rep_zycatalog` VALUES ('2', '财务管理学专业', '财务管理学专业', null);
INSERT INTO `rep_zycatalog` VALUES ('3', '企业管理专业', '企业管理专业', null);
INSERT INTO `rep_zycatalog` VALUES ('4', '市场营销专业', '市场营销专业', null);
INSERT INTO `rep_zycatalog` VALUES ('5', '信息管理与信息系统专业', '信息管理与信息系统专业', null);
INSERT INTO `rep_zycatalog` VALUES ('6', '金融学专业', '金融学专业', null);
INSERT INTO `rep_zycatalog` VALUES ('7', '国际经济与贸易专业', '国际经济与贸易专业', null);
INSERT INTO `rep_zycatalog` VALUES ('8', '其他', '其他', null);
INSERT INTO `rep_zycatalog` VALUES ('9', '中国', '', '1');
INSERT INTO `rep_zycatalog` VALUES ('10', '超级', '', '1');
INSERT INTO `rep_zycatalog` VALUES ('11', '企业管理学', '', '9');
