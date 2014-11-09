-- MySQL dump 10.13  Distrib 5.5.36-34.1, for Linux (x86_64)
--
-- Host: localhost    Database: saltadmin
-- ------------------------------------------------------
-- Server version	5.5.36-34.1-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `hosts`
--

DROP TABLE IF EXISTS `hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hosts` (
  `id` int(3) NOT NULL AUTO_INCREMENT COMMENT '主机ID',
  `hostname` varchar(30) NOT NULL COMMENT '主机名',
  `domain` varchar(30) DEFAULT NULL COMMENT '访问域名，区别于主机名',
  `priip1` varchar(15) NOT NULL COMMENT '内网IP1',
  `priip2` varchar(15) DEFAULT NULL COMMENT '内网IP2',
  `pubip1` varchar(15) DEFAULT NULL COMMENT '公网IP',
  `pubip2` varchar(15) DEFAULT NULL COMMENT '公网IP2',
  `iface0` varchar(8) DEFAULT NULL COMMENT '内网IP1接口',
  `iface1` varchar(8) DEFAULT NULL COMMENT '公网IP1接口',
  `iface2` varchar(8) DEFAULT NULL COMMENT '内网IP2接口',
  `iface3` varchar(8) DEFAULT NULL COMMENT '公网IP2接口',
  `adminip` varchar(15) DEFAULT NULL COMMENT '远程管理卡IP',
  `model` varchar(30) NOT NULL COMMENT '型号',
  `cpu` varchar(30) NOT NULL COMMENT 'CPU',
  `hdd` varchar(20) NOT NULL COMMENT '硬盘',
  `mem` varchar(20) NOT NULL COMMENT '内存',
  `os` varchar(30) NOT NULL COMMENT '操作系统',
  `rnum` varchar(20) NOT NULL DEFAULT 'XK-Server-888' COMMENT '资产编码',
  `storagedate` date NOT NULL COMMENT '入库日期',
  `startdate` date NOT NULL COMMENT '上架日期',
  `mdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` int(3) NOT NULL DEFAULT '0' COMMENT '入库者',
  `editor` int(3) NOT NULL DEFAULT '0' COMMENT '修改者',
  `role` varchar(20) NOT NULL COMMENT '角色',
  `type` varchar(20) NOT NULL DEFAULT 'Public' COMMENT '类型',
  `idc` varchar(20) NOT NULL COMMENT 'IDC归属',
  `idctag` varchar(20) NOT NULL COMMENT '机柜编码',
  `stag` varchar(20) NOT NULL DEFAULT 'idc8-xk-888' COMMENT '服务器标签',
  `snum` varchar(20) NOT NULL DEFAULT 'Dell-S888' COMMENT '服务编号',
  `status` varchar(10) NOT NULL DEFAULT 'OnLine' COMMENT '主机状态',
  `comment` varchar(20) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `hostname` (`hostname`),
  UNIQUE KEY `priip1` (`priip1`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts`
--

LOCK TABLES `hosts` WRITE;
/*!40000 ALTER TABLE `hosts` DISABLE KEYS */;
/*!40000 ALTER TABLE `hosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_logs`
--

DROP TABLE IF EXISTS `login_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login_logs` (
  `id` int(6) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `uid` int(3) NOT NULL COMMENT '用户ID',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '登录时间',
  `ip` varchar(15) NOT NULL DEFAULT '127.0.0.1' COMMENT '登录客户端IP',
  `location` varchar(30) DEFAULT NULL COMMENT '登录地点',
  `agent` varchar(150) NOT NULL DEFAULT 'User Agent' COMMENT '浏览器',
  `token` varchar(64) DEFAULT NULL COMMENT '令牌(用于记住我自动登录)',
  `expiry` datetime DEFAULT NULL COMMENT '过期时间',
  `status` varchar(3) NOT NULL DEFAULT 'yes' COMMENT '状态：描述该会话是否有效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_logs`
--

LOCK TABLES `login_logs` WRITE;
/*!40000 ALTER TABLE `login_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `login_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `options`
--

DROP TABLE IF EXISTS `options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `options` (
  `id` int(3) NOT NULL AUTO_INCREMENT COMMENT '唯一编号',
  `type` varchar(15) NOT NULL COMMENT '类型：cpu/hdd/mem/os/机柜/model/idc/role/salt',
  `value` varchar(50) NOT NULL COMMENT '配置选项的值',
  `default` varchar(3) NOT NULL DEFAULT 'no' COMMENT '是否为同类组的默认值',
  `status` varchar(3) NOT NULL DEFAULT 'yes' COMMENT '状态：yes/no',
  `comment` varchar(20) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `options`
--

LOCK TABLES `options` WRITE;
/*!40000 ALTER TABLE `options` DISABLE KEYS */;
INSERT INTO `options` VALUES (1,'option','option','no','yes','类型选项'),(2,'option','os','no','yes','操作系统'),(3,'option','role','no','yes','角色'),(4,'option','model','no','yes','服务器型号'),(5,'option','cpu','no','yes','CPU'),(6,'option','hdd','no','yes','硬盘'),(7,'option','mem','no','yes','内存'),(8,'option','idc','no','yes','IDC机房'),(9,'option','idctag','no','yes','机柜编码'),(10,'option','salt','no','yes','SaltStack'),(11,'option','status','no','yes','状态'),(12,'option','project_type','no','yes','业务类型'),(13,'option','test4','no','yes','测试4'),(14,'option','test5','no','yes','测试5'),(15,'option','test6','no','yes','测试6'),(16,'os','rhel 6.5 x64','no','yes','操作系统'),(17,'cpu','Intel Xeon','no','yes','Intel Xeon'),(18,'os','rhel 5.5 x64','no','yes','操作系统'),(19,'mem','16G','no','yes','16G'),(20,'hdd','720G','no','yes','720G'),(21,'role','Web','no','yes','Web服务器'),(22,'model','Dell R520','no','yes','戴尔服务器'),(23,'model','Dell R720','no','yes','戴尔服务器'),(24,'model','Dell R420','no','yes','戴尔服务器'),(25,'role','Redis','no','yes','Redis服务器'),(26,'role','Front','no','yes','前置机'),(27,'role','MySQL','no','yes','数据库服务器'),(28,'role','Release','no','yes','发布机'),(29,'role','Jump','no','yes','跳板机'),(30,'cpu','Intel Xeon E3','no','yes','Intel Xeon E3'),(31,'cpu','Intel Xeon E5','no','yes','Intel Xeon E5'),(32,'cpu','Intel Xeon E7','no','yes','Intel Xeon E7'),(33,'hdd','500G','no','yes','500G'),(34,'hdd','1T','no','yes','1T'),(35,'hdd','2T','no','yes','2T'),(36,'hdd','3T','no','yes','3T'),(37,'hdd','4T','no','yes','4T'),(38,'hdd','5T','no','yes','5T'),(39,'hdd','10T','no','yes','10T'),(40,'mem','8G','no','yes','8G'),(41,'mem','32G','no','yes','32G'),(42,'mem','64G','no','yes','64G'),(43,'mem','128G','no','yes','128G'),(44,'mem','256G','no','yes','256G'),(45,'mem','512G','no','yes','512G'),(46,'os','Ubuntu 12.04 x64','no','yes','Ubuntu操作系统'),(47,'os','CentOS 6.5 x64','no','yes','CentOS操作系统'),(48,'os','CentOS 5.4 x64','no','yes','CentOS 5.4'),(49,'os','CentOS','no','yes','CentOS'),(50,'os','RedHat','no','yes','红帽'),(51,'os','Ubuntu','no','yes','乌班图'),(52,'os','Win 2008 R2','no','yes','Windows操作系统'),(53,'os','Other','no','yes','其他系统'),(54,'idc','亚太IDC1','no','yes',''),(55,'idc','北京电信IDC2','no','yes',''),(56,'idc','广州IDC3','no','yes',''),(57,'idc','上海移动IDC4','no','yes',''),(58,'idc','腾讯云IDC5','no','yes',''),(59,'idc','阿里云IDC6','no','yes',''),(60,'idc','香港IDC8','no','yes',''),(61,'idctag','G1柜','no','yes',''),(62,'idctag','G2柜','no','yes','北京IDC-G2柜'),(63,'idctag','G8柜','no','yes','北京-G8柜'),(64,'idctag','G3柜','no','yes',''),(65,'idctag','H6柜','no','yes','北京 - H6柜'),(66,'idctag','腾讯云QY9','no','yes','腾讯云 - QY9'),(67,'role','Test','no','yes','测试机'),(68,'role','Ohter','no','yes','其他角色'),(69,'model','Dell R410','no','yes','戴尔服务器'),(71,'project_type','支付平台','no','yes','Payment'),(72,'project_type','用户平台','no','yes','用户平台'),(73,'project_type','核心业务','no','yes','核心业务'),(77,'project_type','业务平台','no','yes','业务平台');
/*!40000 ALTER TABLE `options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_base`
--

DROP TABLE IF EXISTS `project_base`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_base` (
  `id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(25) NOT NULL COMMENT '项目名称',
  `cname` varchar(25) NOT NULL COMMENT '项目标识或别名',
  `domain` varchar(30) NOT NULL COMMENT '项目域名',
  `port` int(6) NOT NULL DEFAULT '80' COMMENT '域名端口',
  `public` varchar(3) NOT NULL DEFAULT 'yes' COMMENT '是否公共对外项目',
  `lang` varchar(5) NOT NULL DEFAULT 'PHP' COMMENT '开发框架或开发语言',
  `man` varchar(20) NOT NULL COMMENT '接口人',
  `developer` varchar(20) NOT NULL COMMENT '开发者',
  `directory` varchar(50) NOT NULL COMMENT '项目目录',
  `type` int(4) NOT NULL COMMENT '业务类型',
  `status` varchar(15) NOT NULL COMMENT '状态',
  `creator` int(3) NOT NULL,
  `cdate` datetime NOT NULL,
  `editor` int(3) NOT NULL,
  `mdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `relation` varchar(25) DEFAULT NULL COMMENT '关联项目',
  `comment` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_base`
--

LOCK TABLES `project_base` WRITE;
/*!40000 ALTER TABLE `project_base` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_base` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_config`
--

DROP TABLE IF EXISTS `project_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_config` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `type` varchar(5) NOT NULL DEFAULT 'redis' COMMENT '类型：redis/mysql/oracle/front/backend/release',
  `tid` int(4) NOT NULL COMMENT '类型ID',
  `username` varchar(20) DEFAULT NULL COMMENT '用户名，针对MySQL',
  `password` varchar(20) DEFAULT NULL COMMENT '密码',
  `port` int(6) DEFAULT NULL COMMENT '实例端口',
  `perm` varchar(3) NOT NULL DEFAULT 'rw' COMMENT '权限，默认是rw',
  `conf` varchar(50) DEFAULT NULL COMMENT '配置文件',
  `cdate` timestamp NOT NULL DEFAULT '2008-08-08 00:08:08' COMMENT '创建日期',
  `creator` int(3) NOT NULL DEFAULT '0' COMMENT '创建者',
  `mdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改日期',
  `editor` int(3) NOT NULL DEFAULT '0' COMMENT '修改人',
  `comment` varchar(50) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_config`
--

LOCK TABLES `project_config` WRITE;
/*!40000 ALTER TABLE `project_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_db`
--

DROP TABLE IF EXISTS `project_db`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_db` (
  `id` int(4) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` varchar(5) NOT NULL DEFAULT 'mysql' COMMENT '类型：mysql/oracle/mongodb/other',
  `hid` int(4) NOT NULL COMMENT '主机ID',
  `host` varchar(30) NOT NULL DEFAULT '0' COMMENT '主机名或者IP',
  `port` int(6) NOT NULL DEFAULT '3306' COMMENT '端口',
  `dbname` varchar(20) NOT NULL COMMENT 'DB名字',
  `cdate` timestamp NULL DEFAULT NULL COMMENT '创建日期',
  `creator` int(3) NOT NULL DEFAULT '0' COMMENT '创建者',
  `mdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改日期',
  `editor` int(3) NOT NULL DEFAULT '0' COMMENT '修改人',
  `comment` varchar(50) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_db`
--

LOCK TABLES `project_db` WRITE;
/*!40000 ALTER TABLE `project_db` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_db` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_host`
--

DROP TABLE IF EXISTS `project_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_host` (
  `id` int(3) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(3) NOT NULL COMMENT '项目ID',
  `type` varchar(20) NOT NULL COMMENT '类型Web/Redis/MySQL/Oracle/Mongo/Memcache/Other',
  `host` int(3) NOT NULL COMMENT '存储hosts表里id',
  `port` varchar(5) NOT NULL COMMENT 'MySQL/Redis端口',
  `protocol` varchar(15) NOT NULL DEFAULT 'TCP' COMMENT 'TCP/http',
  `dbname` varchar(30) NOT NULL DEFAULT 'None' COMMENT 'DB名称',
  `dbuser` varchar(20) NOT NULL DEFAULT 'None' COMMENT 'DB用户名',
  `perm` varchar(10) NOT NULL DEFAULT 'rw' COMMENT '权限',
  `conf` varchar(50) NOT NULL DEFAULT 'None' COMMENT '配置文件',
  `func` varchar(30) NOT NULL COMMENT '功能',
  `size` varchar(20) NOT NULL DEFAULT '1' COMMENT '大小/容量',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作日期',
  `status` varchar(3) NOT NULL DEFAULT 'yes' COMMENT '状态',
  `comment` varchar(50) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_host`
--

LOCK TABLES `project_host` WRITE;
/*!40000 ALTER TABLE `project_host` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_log`
--

DROP TABLE IF EXISTS `project_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_log` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `pid` int(3) NOT NULL COMMENT '项目ID',
  `uid` int(3) NOT NULL COMMENT '操作用户ID',
  `log` varchar(200) NOT NULL COMMENT '操作日志，强制录入',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作日期',
  `comment` int(11) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_log`
--

LOCK TABLES `project_log` WRITE;
/*!40000 ALTER TABLE `project_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_logs`
--

DROP TABLE IF EXISTS `project_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_logs` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `pid` int(3) NOT NULL COMMENT '项目ID',
  `uid` int(3) NOT NULL COMMENT '操作用户ID',
  `log` varchar(200) NOT NULL COMMENT '操作日志，强制录入',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作日期',
  `comment` int(11) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_logs`
--

LOCK TABLES `project_logs` WRITE;
/*!40000 ALTER TABLE `project_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_redis`
--

DROP TABLE IF EXISTS `project_redis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_redis` (
  `id` int(3) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `hid` int(3) NOT NULL COMMENT 'host的ID',
  `port` int(6) NOT NULL COMMENT '端口',
  `conf` varchar(50) NOT NULL COMMENT '配置文件',
  `size` varchar(20) NOT NULL COMMENT '大小',
  `master` int(3) DEFAULT '0' COMMENT 'master_id',
  `slave` int(3) DEFAULT '0' COMMENT 'slave_id',
  `cdate` timestamp NOT NULL DEFAULT '2008-08-08 00:08:08' COMMENT '创建日期',
  `mdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改日期',
  `creator` int(3) NOT NULL DEFAULT '0' COMMENT '创建者',
  `editor` int(3) NOT NULL DEFAULT '0' COMMENT '修改者',
  `status` varchar(3) NOT NULL DEFAULT 'yes' COMMENT 'yes/no',
  `comment` varchar(50) NOT NULL COMMENT '注释',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_redis`
--

LOCK TABLES `project_redis` WRITE;
/*!40000 ALTER TABLE `project_redis` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_redis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_release`
--

DROP TABLE IF EXISTS `project_release`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_release` (
  `id` int(3) NOT NULL,
  `pid` int(3) NOT NULL COMMENT '项目ID',
  `uid` int(3) NOT NULL COMMENT '操作用户ID',
  `svn` varchar(80) NOT NULL COMMENT 'SVN地址',
  `version` int(30) NOT NULL COMMENT '版本',
  `content` int(100) NOT NULL COMMENT '内容',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '日期',
  `provider` varchar(20) NOT NULL COMMENT '发布者/提单者',
  `comment` varchar(50) DEFAULT NULL COMMENT '备注信息'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_release`
--

LOCK TABLES `project_release` WRITE;
/*!40000 ALTER TABLE `project_release` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_release` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(3) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(20) NOT NULL,
  `password` varchar(60) NOT NULL,
  `nickname` varchar(20) DEFAULT NULL COMMENT '昵称，用于友好显示在页面上',
  `mobile` varchar(15) DEFAULT NULL COMMENT '手机号',
  `email` varchar(50) DEFAULT NULL COMMENT '用户E-mail地址',
  `level` int(1) NOT NULL DEFAULT '1' COMMENT '用户级别：0为管理员，1为普通用户',
  `status` varchar(3) NOT NULL DEFAULT 'yes' COMMENT '用户状态：yes表示启用，no表示禁用',
  `loginfo` int(5) NOT NULL DEFAULT '0' COMMENT '登录信息，对应login_logs表中的id',
  `regdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '用户注册时间',
  `comment` varchar(50) DEFAULT NULL COMMENT '用户备注信息',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (0,'System','00000000','系统','88888888','system@test.com',0,'no',0,'2014-03-30 06:18:50','System'),(1,'admin','21232f297a57a5a743894a0e4a801fc3','超级管理员','88888888','admin@test.com',0,'yes',99,'2014-03-30 06:18:50','Super Admin');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-11-09 15:42:39
