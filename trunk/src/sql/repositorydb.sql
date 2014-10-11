/*
MySQL Data Transfer
Source Host: localhost
Source Database: repository
Target Host: localhost
Target Database: repository
Date: 2013/12/1 0:01:41
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

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
  `dloadneedpoints` int(11) NOT NULL default '0',
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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

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
  `userid` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `fk_topic_gscatalog` (`gscatalogid`),
  KEY `fk_topic_zycatalogid` (`zycatalogid`),
  KEY `fk_topic_user` (`userid`),
  CONSTRAINT `fk_topic_gscatalog` FOREIGN KEY (`gscatalogid`) REFERENCES `rep_gscatalog` (`id`),
  CONSTRAINT `fk_topic_user` FOREIGN KEY (`userid`) REFERENCES `rep_user` (`id`),
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `rep_admin` VALUES ('1', 'admin', '5F1D65F27E370C36DFD845F6DC78B869', '464631487@qq.com', '1', '0', null, '', '', '1', '经济与管理学院', '', '', '', '127.0.0.1', '2013-12-01 00:00:50');
INSERT INTO `rep_admin` VALUES ('2', 'yy11', '202CB962AC59075B964B07152D234B70', '464631487@qq.com', '1', '1', '2013-10-04 15:53:00', '201236533333', '', '1', '化学与生物工程学院', '电气化', '132243', '135435345454', null, null);
INSERT INTO `rep_folder` VALUES ('3', '我的上传', null, null, '2');
INSERT INTO `rep_folder` VALUES ('4', '我的收藏', null, null, '2');
INSERT INTO `rep_folder` VALUES ('5', '我的上传', null, null, '3');
INSERT INTO `rep_folder` VALUES ('6', '我的收藏', null, null, '3');
INSERT INTO `rep_folder` VALUES ('7', '我的上传', null, null, '4');
INSERT INTO `rep_folder` VALUES ('8', '我的收藏', null, null, '4');
INSERT INTO `rep_folder` VALUES ('11', 'MyPic', null, '3', '2');
INSERT INTO `rep_folder` VALUES ('12', '我的上传', null, null, '5');
INSERT INTO `rep_folder` VALUES ('13', '我的收藏', null, null, '5');
INSERT INTO `rep_gscatalog` VALUES ('1', '文档类资源', '文档类资源', null);
INSERT INTO `rep_gscatalog` VALUES ('2', '视频类资源', '视频类资源', null);
INSERT INTO `rep_gscatalog` VALUES ('3', '教学软件', '音频类资源', null);
INSERT INTO `rep_gscatalog` VALUES ('4', '图文类资源', '图文类资源', null);
INSERT INTO `rep_gscatalog` VALUES ('5', '综合类', '综合类', null);
INSERT INTO `rep_log` VALUES ('1', '1', '0:0:0:0:0:0:0:1', '登录', '登录后台', '2013-11-11 17:59:52', 'admin');
INSERT INTO `rep_log` VALUES ('2', '1', '127.0.0.1', '登录', '登录后台', '2013-11-13 21:20:42', 'admin');
INSERT INTO `rep_log` VALUES ('3', '1', '10.6.16.150', '登录', '登录后台', '2013-11-13 23:31:42', 'admin');
INSERT INTO `rep_log` VALUES ('4', '1', '127.0.0.1', '登录', '登录后台', '2013-11-15 22:27:30', 'admin');
INSERT INTO `rep_log` VALUES ('5', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-11-15 22:27:40', 'admin');
INSERT INTO `rep_log` VALUES ('6', '1', '127.0.0.1', '新增', '新增专题', '2013-11-15 22:28:23', 'admin');
INSERT INTO `rep_log` VALUES ('7', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-11-15 22:28:27', 'admin');
INSERT INTO `rep_log` VALUES ('8', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-11-15 22:28:52', 'admin');
INSERT INTO `rep_log` VALUES ('9', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-11-15 22:31:00', 'admin');
INSERT INTO `rep_log` VALUES ('10', '1', '127.0.0.1', '新增', '上传资源', '2013-11-15 22:31:31', 'admin');
INSERT INTO `rep_log` VALUES ('11', '1', '127.0.0.1', '删除', '删除资源', '2013-11-15 22:38:14', 'admin');
INSERT INTO `rep_log` VALUES ('12', '1', '127.0.0.1', '登录', '登录后台', '2013-11-15 23:53:36', 'admin');
INSERT INTO `rep_log` VALUES ('13', '1', '127.0.0.1', '修改', '编辑前台用户', '2013-11-16 00:11:43', 'admin');
INSERT INTO `rep_log` VALUES ('14', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-11-16 00:26:12', 'admin');
INSERT INTO `rep_log` VALUES ('15', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-11-16 00:27:54', 'admin');
INSERT INTO `rep_log` VALUES ('16', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-11-16 00:37:07', 'admin');
INSERT INTO `rep_log` VALUES ('17', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-11-16 00:37:10', 'admin');
INSERT INTO `rep_log` VALUES ('18', '1', '127.0.0.1', '修改', '参数配置', '2013-11-16 01:04:06', 'admin');
INSERT INTO `rep_log` VALUES ('19', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-11-16 01:04:18', 'admin');
INSERT INTO `rep_log` VALUES ('20', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-11-16 01:04:55', 'admin');
INSERT INTO `rep_log` VALUES ('21', '1', '127.0.0.1', '修改', '修改资源', '2013-11-16 01:10:29', 'admin');
INSERT INTO `rep_log` VALUES ('22', '1', '127.0.0.1', '修改', '修改资源', '2013-11-16 01:14:55', 'admin');
INSERT INTO `rep_log` VALUES ('23', '1', '127.0.0.1', '修改', '修改资源', '2013-11-16 01:15:10', 'admin');
INSERT INTO `rep_log` VALUES ('24', '1', '127.0.0.1', '修改', '修改资源', '2013-11-16 01:16:30', 'admin');
INSERT INTO `rep_log` VALUES ('25', '1', '127.0.0.1', '修改', '修改资源', '2013-11-16 01:21:00', 'admin');
INSERT INTO `rep_log` VALUES ('26', '1', '127.0.0.1', '修改', '修改资源', '2013-11-16 01:22:26', 'admin');
INSERT INTO `rep_log` VALUES ('27', '1', '127.0.0.1', '修改', '修改资源', '2013-11-16 01:22:41', 'admin');
INSERT INTO `rep_log` VALUES ('28', '1', '127.0.0.1', '修改', '修改资源', '2013-11-16 01:24:01', 'admin');
INSERT INTO `rep_log` VALUES ('29', '1', '127.0.0.1', '修改', '修改资源', '2013-11-16 01:24:58', 'admin');
INSERT INTO `rep_log` VALUES ('30', '1', '127.0.0.1', '登录', '登录后台', '2013-11-22 21:22:48', 'admin');
INSERT INTO `rep_log` VALUES ('31', '1', '127.0.0.1', '登录', '登录后台', '2013-11-22 21:23:02', 'admin');
INSERT INTO `rep_log` VALUES ('32', '1', '127.0.0.1', '删除', '删除资源', '2013-11-22 21:23:14', 'admin');
INSERT INTO `rep_log` VALUES ('33', '1', '127.0.0.1', '删除', '删除前台用户', '2013-11-22 21:23:55', 'admin');
INSERT INTO `rep_log` VALUES ('34', '1', '127.0.0.1', '修改', '审核前台用户', '2013-11-22 21:24:55', 'admin');
INSERT INTO `rep_log` VALUES ('35', '1', '127.0.0.1', '修改', '审核前台用户', '2013-11-22 21:32:37', 'admin');
INSERT INTO `rep_log` VALUES ('36', '1', '127.0.0.1', '修改', '审核前台用户', '2013-11-22 21:46:40', 'admin');
INSERT INTO `rep_log` VALUES ('37', '1', '127.0.0.1', '修改', '审核通过资源', '2013-11-22 21:54:02', 'admin');
INSERT INTO `rep_log` VALUES ('38', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-11-22 23:00:27', 'admin');
INSERT INTO `rep_log` VALUES ('39', '1', '127.0.0.1', '新增', '新增公告', '2013-11-22 23:15:27', 'admin');
INSERT INTO `rep_log` VALUES ('40', '1', '127.0.0.1', '新增', '批量上传专题资源', '2013-11-22 23:35:37', 'admin');
INSERT INTO `rep_log` VALUES ('41', '1', '127.0.0.1', '登录', '登录后台', '2013-11-24 20:31:16', 'admin');
INSERT INTO `rep_log` VALUES ('42', '1', '127.0.0.1', '登录', '登录后台', '2013-11-24 22:13:56', 'admin');
INSERT INTO `rep_log` VALUES ('43', '1', '127.0.0.1', '登录', '登录后台', '2013-11-24 22:49:17', 'admin');
INSERT INTO `rep_log` VALUES ('44', '1', '127.0.0.1', '登录', '登录后台', '2013-11-24 22:49:35', 'admin');
INSERT INTO `rep_log` VALUES ('45', '1', '127.0.0.1', '登录', '登录后台', '2013-11-25 21:47:03', 'admin');
INSERT INTO `rep_log` VALUES ('46', '1', '127.0.0.1', '新增', '上传资源', '2013-11-25 21:47:39', 'admin');
INSERT INTO `rep_log` VALUES ('47', '1', '127.0.0.1', '修改', '修改资源', '2013-11-25 21:48:01', 'admin');
INSERT INTO `rep_log` VALUES ('48', '1', '127.0.0.1', '修改', '修改资源', '2013-11-25 21:50:58', 'admin');
INSERT INTO `rep_log` VALUES ('49', '1', '127.0.0.1', '修改', '修改资源', '2013-11-25 21:51:08', 'admin');
INSERT INTO `rep_log` VALUES ('50', '1', '127.0.0.1', '修改', '审核通过资源', '2013-11-25 22:05:55', 'admin');
INSERT INTO `rep_log` VALUES ('51', '1', '127.0.0.1', '修改', '参数配置', '2013-11-25 22:17:02', 'admin');
INSERT INTO `rep_log` VALUES ('52', '1', '127.0.0.1', '登录', '登录后台', '2013-11-25 22:22:48', 'admin');
INSERT INTO `rep_log` VALUES ('53', '1', '127.0.0.1', '修改', '审核通过资源', '2013-11-25 22:23:05', 'admin');
INSERT INTO `rep_log` VALUES ('54', '1', '10.6.16.150', '登录', '登录后台', '2013-11-25 22:46:11', 'admin');
INSERT INTO `rep_log` VALUES ('55', '1', '10.6.16.150', '新增', '批量上传专题资源', '2013-11-25 22:46:15', 'admin');
INSERT INTO `rep_log` VALUES ('56', '1', '10.6.16.150', '新增', '批量上传专题资源', '2013-11-25 22:46:29', 'admin');
INSERT INTO `rep_log` VALUES ('57', '1', '10.6.16.150', '新增', '批量上传专题资源', '2013-11-25 22:46:34', 'admin');
INSERT INTO `rep_log` VALUES ('58', '1', '10.6.16.150', '登录', '登录后台', '2013-11-25 23:27:55', 'admin');
INSERT INTO `rep_log` VALUES ('59', '1', '10.6.16.150', '删除', '删除专题', '2013-11-25 23:28:07', 'admin');
INSERT INTO `rep_log` VALUES ('60', '1', '10.8.66.222', '登录', '登录后台', '2013-11-26 21:08:02', 'admin');
INSERT INTO `rep_log` VALUES ('61', '1', '10.8.66.222', '登录', '登录后台', '2013-11-26 21:19:45', 'admin');
INSERT INTO `rep_log` VALUES ('62', '1', '10.8.66.222', '修改', '审核前台用户', '2013-11-26 21:20:26', 'admin');
INSERT INTO `rep_log` VALUES ('63', '1', '127.0.0.1', '登录', '登录后台', '2013-11-30 21:49:01', 'admin');
INSERT INTO `rep_log` VALUES ('64', '1', '127.0.0.1', '登录', '登录后台', '2013-11-30 23:27:27', 'admin');
INSERT INTO `rep_log` VALUES ('65', '1', '127.0.0.1', '登录', '登录后台', '2013-12-01 00:00:20', 'admin');
INSERT INTO `rep_log` VALUES ('66', '1', '127.0.0.1', '登录', '登录后台', '2013-12-01 00:00:50', 'admin');
INSERT INTO `rep_notice` VALUES ('1', '教学资源库使用注意事项', '2013-11-22 23:10:00', '<ol>\r\n	<li>\r\n		上传的文档如果出现乱码，可能是因为字体编码的问题，修改字体为宋体或其他word中含有的字体后再重新上传就可以了。\r\n	</li>\r\n</ol>', '1', '0', '1', '杨真', null, '46');
INSERT INTO `rep_params` VALUES ('1', '1', '1', '0', '1', '0', '1', '0', '0', 'doc:20,docx:20,xls:20,xlsx:20,ppt:20,pptx:20,pdf:200,txt:20,jpg:20,gif:20,mp4:500,flv:500,swf:500,wmv:500', '1');
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
INSERT INTO `rep_resource` VALUES ('6', '（会议记录）经管资源库项目数据库设计文档----杨真 2', '/uploads/2/2/6d7008ba-b282-472c-b3b2-95c48bdcfa6f.doc', '0', '2', null, '2013-11-22 21:50:55', '2013-11-22 21:50:55', '0', '4', '1', '2013-11-22 21:54:02', '', '6', '/thirdparty/officetranslate/swfs/7d8c77bd-79a0-435c-96f2-19a69210fabd.swf', '1', '就这样吧。', null, '/repository/attached/image/20131108/20131108203924_763.jpg', 'user', null, '0');
INSERT INTO `rep_resource` VALUES ('11', '数据结构最后一次作业', '/uploads/5/2/806e658e-2a64-4328-8ff8-7eabae2e2804.doc', '29184', null, '1', '2013-11-25 21:47:39', '2013-11-25 21:47:39', '0', '0', '1', '2013-11-25 21:51:08', '', '1', '/thirdparty/officetranslate/swfs/ca4e6e83-9598-47e2-b114-59419bb7fbe2.swf', '1', '', null, '', '', '', '100');
INSERT INTO `rep_resource` VALUES ('12', '数据结构_第123章作业', '/uploads/6/1/fc6b47bc-e8c3-41dd-a195-e58bd287964a.doc', '0', '2', null, '2013-11-25 22:04:56', '2013-11-25 22:04:56', '0', '4', '1', '2013-11-25 22:05:55', '', '1', '/thirdparty/officetranslate/swfs/9bd1c9bb-5ad6-4359-a7d9-19d470f65865.swf', '1', '', null, '', 'user', null, '100');
INSERT INTO `rep_resource` VALUES ('13', '数据结构_第6章作业', '/uploads/12/10/04bf1692-550c-4566-ab82-224645661e4f.doc', '32256', '2', null, '2013-11-25 22:08:53', '2013-11-25 22:08:53', '0', '0', '1', '2013-11-25 22:23:05', '', '1', '/thirdparty/officetranslate/swfs/f30fe003-5325-4865-a596-d45c40429448.swf', '1', '', null, '', 'user', null, '0');
INSERT INTO `rep_resource` VALUES ('18', 'psb1', '/uploads/8/2/46037cd5-b968-47fb-a1fa-30c4b3792d38.jpg', '86160', null, '1', '2013-11-25 22:46:29', '2013-11-25 22:46:29', '0', '0', '1', '2013-11-25 22:46:29', '', '5', null, '4', '', null, '', '', null, '0');
INSERT INTO `rep_resource` VALUES ('19', 'psb', '/uploads/5/10/adc5eae1-90d5-4148-b8c6-32cbaff41e77.jpg', '232991', null, '1', '2013-11-25 22:46:29', '2013-11-25 22:46:29', '0', '0', '1', '2013-11-25 22:46:29', '', '5', null, '4', '', null, '', '', null, '0');
INSERT INTO `rep_resource` VALUES ('20', 'psb', '/uploads/1/12/d66c5695-a4c0-4d04-9018-fb4583bbba13.gif', '1045834', null, '1', '2013-11-25 22:46:29', '2013-11-25 22:46:29', '0', '0', '1', '2013-11-25 22:46:29', '', '5', null, '4', '', null, '', '', null, '0');
INSERT INTO `rep_resource` VALUES ('21', 'p1991841135', '/uploads/7/0/dd25f80c-fae1-4c0d-a56a-005c126fe5aa.jpg', '29189', null, '1', '2013-11-25 22:46:29', '2013-11-25 22:46:29', '0', '0', '1', '2013-11-25 22:46:29', '', '5', null, '4', '', null, '', '', null, '0');
INSERT INTO `rep_resource` VALUES ('22', 'p1991557378', '/uploads/0/14/5b57e78f-7f28-4687-9062-c93e847c0d01.jpg', '28257', null, '1', '2013-11-25 22:46:29', '2013-11-25 22:46:29', '0', '0', '1', '2013-11-25 22:46:29', '', '5', null, '4', '', null, '', '', null, '0');
INSERT INTO `rep_resource` VALUES ('23', '阿甘正传BD版[www.qire123.com][25201305214945GMT]', '/uploads/0/13/1ff11df2-f4bb-4ac8-8838-70ba20dc9773.jpg', '107675', null, '1', '2013-11-25 22:46:29', '2013-11-25 22:46:29', '0', '0', '1', '2013-11-25 22:46:29', '', '5', null, '4', '', null, '', '', null, '0');
INSERT INTO `rep_resource` VALUES ('24', 's1db8ae3e_1377ef27c55__78f5', '/uploads/1/14/d7336b25-a238-4c3c-abab-66f7023e2464.jpg', '30726', null, '1', '2013-11-25 22:46:29', '2013-11-25 22:46:29', '0', '0', '1', '2013-11-25 22:46:29', '', '5', null, '4', '', null, '', '', null, '0');
INSERT INTO `rep_resource` VALUES ('25', 'QQ图片20130618101933', '/uploads/13/8/246f5622-7298-4012-ba27-8169adc47c5a.jpg', '41454', null, '1', '2013-11-25 22:46:29', '2013-11-25 22:46:29', '0', '0', '1', '2013-11-25 22:46:29', '', '5', null, '4', '', null, '', '', null, '0');
INSERT INTO `rep_resource` VALUES ('26', 's1db8ae3e_1377ef27c55__78f5', '/uploads/6/14/8cf21e95-0276-4937-aa8a-ef38c58a999e.jpg', '30726', '2', null, '2013-11-26 00:24:27', '2013-11-26 00:24:27', '0', '0', '0', null, '', '3', null, '4', '', '1', '', 'user', null, '10');
INSERT INTO `rep_resource` VALUES ('27', 'QQ图片20130618101933', '/uploads/9/1/33cd5d93-07dd-41f5-adfa-51038d2e7152.jpg', '41454', '2', null, '2013-11-26 00:24:27', '2013-11-26 00:24:27', '0', '0', '0', null, '', '3', null, '4', '', '1', '', 'user', null, '10');
INSERT INTO `rep_resource` VALUES ('28', 'psb1', '/uploads/8/3/a90736b0-bb27-4cdf-9f4c-aa339478954a.jpg', '86160', '2', null, '2013-11-26 00:24:27', '2013-11-26 00:24:27', '0', '0', '0', null, '', '3', null, '4', '', '1', '', 'user', null, '10');
INSERT INTO `rep_resource` VALUES ('29', 'psb', '/uploads/10/1/26a9c8c7-3308-48f5-9f2a-f7be4d7f0066.jpg', '232991', '2', null, '2013-11-26 00:24:27', '2013-11-26 00:24:27', '0', '0', '0', null, '', '3', null, '4', '', '1', '', 'user', null, '10');
INSERT INTO `rep_resource` VALUES ('30', 'psb', '/uploads/11/10/40bccf4c-7385-4fb9-a7ec-07d49da038d8.gif', '1045834', '2', null, '2013-11-26 00:24:27', '2013-11-26 00:24:27', '0', '0', '0', null, '', '3', null, '4', '', '1', '', 'user', null, '10');
INSERT INTO `rep_resource` VALUES ('31', '社交网络BD1280高清中英双字[02201306192929GMT]', '/uploads/15/15/af372a33-1bd0-4442-8567-22e9cb09b9db.jpg', '56370', '2', null, '2013-11-26 00:24:27', '2013-11-26 00:24:27', '0', '0', '0', null, '', '3', null, '4', '', '1', '', 'user', null, '10');
INSERT INTO `rep_resource` VALUES ('32', '湖南版笑傲江湖56.HDTV完[09201303164257GMT]-副本', '/uploads/1/0/19436b33-d61f-4dc4-a41c-da36a1ae321d.jpg', '77694', '2', null, '2013-11-26 00:24:27', '2013-11-26 00:24:27', '0', '0', '0', null, '', '3', null, '4', '', '1', '', 'user', null, '10');
INSERT INTO `rep_resource` VALUES ('33', '湖南版笑傲江湖56.HDTV完[09201303164257GMT]', '/uploads/12/15/792c2fc0-e640-4e90-99e1-b5a6003cad6a.jpg', '77694', '2', null, '2013-11-26 00:24:27', '2013-11-26 00:24:27', '0', '0', '0', null, '', '3', null, '4', '', '1', '', 'user', null, '10');
INSERT INTO `rep_resource` VALUES ('34', '湖南版笑傲江湖56.HDTV完[09201303164231GMT]', '/uploads/0/1/78866d82-372b-4969-8e8b-af0637f35fe1.jpg', '73870', '2', null, '2013-11-26 00:24:27', '2013-11-26 00:24:27', '0', '0', '0', null, '', '3', null, '4', '', '1', '', 'user', null, '10');
INSERT INTO `rep_resource` VALUES ('35', '阿甘正传BD版[www.qire123.com][25201305214945GMT]', '/uploads/13/2/f36b4eb4-a95b-4143-b1e7-321786cd7869.jpg', '107675', '2', null, '2013-11-26 00:24:27', '2013-11-26 00:24:27', '0', '0', '0', null, '', '3', null, '4', '', '1', '', 'user', null, '10');
INSERT INTO `rep_resource_folder` VALUES ('7', '6', '4');
INSERT INTO `rep_resource_folder` VALUES ('10', '6', '3');
INSERT INTO `rep_resource_folder` VALUES ('11', '12', '3');
INSERT INTO `rep_resource_folder` VALUES ('12', '13', '3');
INSERT INTO `rep_resource_folder` VALUES ('17', '33', '11');
INSERT INTO `rep_resource_folder` VALUES ('18', '34', '11');
INSERT INTO `rep_resource_folder` VALUES ('19', '35', '11');
INSERT INTO `rep_resource_folder` VALUES ('20', '28', '11');
INSERT INTO `rep_resource_folder` VALUES ('21', '27', '11');
INSERT INTO `rep_resource_folder` VALUES ('22', '26', '11');
INSERT INTO `rep_resource_folder` VALUES ('23', '32', '11');
INSERT INTO `rep_resource_folder` VALUES ('24', '31', '11');
INSERT INTO `rep_resource_folder` VALUES ('25', '30', '11');
INSERT INTO `rep_resource_folder` VALUES ('26', '29', '11');
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
INSERT INTO `rep_tag` VALUES ('10', 'mp4');
INSERT INTO `rep_tag` VALUES ('11', 'doc');
INSERT INTO `rep_tag` VALUES ('12', '图片');
INSERT INTO `rep_tag` VALUES ('13', 'wmv');
INSERT INTO `rep_topic` VALUES ('4', null, 'MyPic', '3', '1', '2');
INSERT INTO `rep_user` VALUES ('2', 'user', 'E10ADC3949BA59ABBE56E057F20F883E', '464631487@qq.com', '0', '1', '2013-11-22 21:46:41', '2013-11-22 21:24:42', null, '杨真', '1', null, '计算机与通信工程学院', '通信工程', null, '464631487', '', '127.0.0.1', '2013-11-30 21:52:30', '1', null, '900');
INSERT INTO `rep_user` VALUES ('3', '杨真开源', 'E10ADC3949BA59ABBE56E057F20F883E', 'yzknight@126.com', '0', '1', '2013-11-22 21:46:41', '2013-11-22 21:31:59', null, '杨真', '1', null, '计算机与通信工程学院', '通信工程', null, '464631487', '', '127.0.0.1', '2013-11-25 22:28:24', '2', null, '4800');
INSERT INTO `rep_user` VALUES ('4', 'user2', 'E10ADC3949BA59ABBE56E057F20F883E', '4646@qq.com', '0', '1', '2013-11-22 21:46:40', '2013-11-22 21:46:12', null, '杨真', '0', null, '经济与管理学院', '', null, '', '', '127.0.0.1', '2013-11-22 21:47:00', '1', null, '1000');
INSERT INTO `rep_user` VALUES ('5', '小草11', '999D1A54A7BD5367D91B012AD7F86BF4', '1006082777@qq.com', '0', '1', '2013-11-26 21:20:26', '2013-11-26 21:17:57', null, '陈琳琳', '2', null, '计算机与通信工程学院', '通信', null, '1006082777', '15574897467', null, null, '1', null, '1000');
INSERT INTO `rep_zycatalog` VALUES ('1', '会计学专业', '会计学专业', null);
INSERT INTO `rep_zycatalog` VALUES ('2', '财务管理学专业', '财务管理学专业', null);
INSERT INTO `rep_zycatalog` VALUES ('3', '企业管理专业', '企业管理专业', null);
INSERT INTO `rep_zycatalog` VALUES ('4', '市场营销专业', '市场营销专业', null);
INSERT INTO `rep_zycatalog` VALUES ('5', '信息管理与信息系统专业', '信息管理与信息系统专业', null);
INSERT INTO `rep_zycatalog` VALUES ('6', '金融学专业', '金融学专业', null);
INSERT INTO `rep_zycatalog` VALUES ('7', '国际经济与贸易专业', '国际经济与贸易专业', null);
INSERT INTO `rep_zycatalog` VALUES ('8', '其他', '其他', null);
