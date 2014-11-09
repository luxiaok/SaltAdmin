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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts`
--

LOCK TABLES `hosts` WRITE;
/*!40000 ALTER TABLE `hosts` DISABLE KEYS */;
INSERT INTO `hosts` VALUES (1,'web1.test.com',NULL,'192.168.9.1','','','',NULL,NULL,NULL,NULL,'192.168.0.128','23','31','35','41','18','XK-Server-888','0000-00-00','2014-04-13','0000-00-00 00:00:00',0,0,'21','Public','59','61','xk-web3-14','undefined','OnLine',''),(2,'web2.test.com',NULL,'192.168.10.1','','','',NULL,NULL,NULL,NULL,'192.168.0.128','23','17','35','41','16','XK-Server-888','0000-00-00','2014-04-13','0000-00-00 00:00:00',0,0,'21','Public','59','62','xk-web1-11','undefined','OnLine',''),(3,'redis1.test.com',NULL,'192.168.10.17','','','',NULL,NULL,NULL,NULL,'192.168.0.128','24','31','33','41','48','XK-Server-888','0000-00-00','2014-04-13','0000-00-00 00:00:00',0,0,'25','Public','56','63','xxx','undefined','OnLine',''),(4,'mysql1.test.com',NULL,'192.168.9.12','','','',NULL,NULL,NULL,NULL,'192.168.0.128','24','32','33','40','46','XK-Server-888','0000-00-00','2014-04-13','0000-00-00 00:00:00',0,0,'27','Public','55','63','xxxxx','undefined','OnLine',''),(5,'front1.test.com',NULL,'192.168.10.253','','','',NULL,NULL,NULL,NULL,'192.168.0.128','24','30','33','41','46','XK-Server-888','0000-00-00','2014-04-13','0000-00-00 00:00:00',0,0,'26','Public','56','64','ssa','undefined','OnLine',''),(6,'release1.test.com',NULL,'192.168.0.22','','105.68.98.127','',NULL,NULL,NULL,NULL,'192.168.0.128','24','30','20','40','18','XK-Server-888','0000-00-00','2014-04-13','0000-00-00 00:00:00',0,0,'28','Public','54','65','zdfafda','test0000','OnLine',''),(7,'db2.test.com',NULL,'192.168.10.102','','','',NULL,NULL,NULL,NULL,'192.168.0.128','23','32','38','42','47','XK-Server-888','0000-00-00','2014-04-14','0000-00-00 00:00:00',0,0,'27','Public','56','61','','undefined','OnLine',''),(8,'redis2.test.com',NULL,'192.168.9.102','','','',NULL,NULL,NULL,NULL,'192.168.0.128','22','31','33','44','16','XK-Server-888','0000-00-00','2014-04-14','0000-00-00 00:00:00',0,0,'25','Public','56','66','','undefined','OnLine',''),(9,'db3.test.com',NULL,'192.168.10.103','','','',NULL,NULL,NULL,NULL,'192.168.0.128','23','32','37','42','16','XK-Server-888','0000-00-00','2014-04-14','0000-00-00 00:00:00',0,0,'27','Public','56','65','IDC8-XK-Dell-88','Dell-S888','OnLine','数据库3号机'),(10,'redis3.test.com',NULL,'192.168.0.103','','','',NULL,NULL,NULL,NULL,'192.168.0.128','22','31','33','42','50','XK-Server-888','2014-04-14','2014-04-14','0000-00-00 00:00:00',0,0,'25','Public','54','64','IDC8-XK-Dell-88','Dell-S888','OnLine',''),(11,'db4.test.com',NULL,'192.168.10.104','','','',NULL,NULL,NULL,NULL,'192.168.0.128','23','32','35','42','16','XK-Server-888','2014-04-14','2014-04-14','0000-00-00 00:00:00',0,0,'27','Public','55','62','IDC8-XK-Dell-88','Dell-S888','OnLine',''),(12,'redis5.test.com',NULL,'192.168.10.105','','','',NULL,NULL,NULL,NULL,'192.168.0.128','22','17','33','40','50','XK-Server-888','2014-04-14','2014-04-14','0000-00-00 00:00:00',0,0,'25','Public','54','66','IDC8-XK-Dell-88','Dell-S888','OnLine',''),(13,'web2111.test.com',NULL,'192.168.10.2','','','',NULL,NULL,NULL,NULL,'192.168.0.128','24','32','33','40','48','XK-Server-888','2014-04-16','2014-04-16','0000-00-00 00:00:00',0,3,'21','Public','54','64','IDC8-XK-Dell-88','Dell-S888','OnLine',''),(14,'web5.test.com',NULL,'192.168.10.5','','','',NULL,NULL,NULL,NULL,'192.168.0.128','24','32','33','40','48','XK-Server-888','2014-04-16','2014-04-16','0000-00-00 00:00:00',0,0,'21','Public','54','64','IDC8-XK-Dell-88','Dell-S888','OnLine',''),(15,'web2s8.test.com',NULL,'192.168.10.55','','','',NULL,NULL,NULL,NULL,'192.168.0.128','24','32','33','40','48','XK-Server-888','2014-04-16','2014-04-16','2014-05-03 06:39:28',0,3,'21','Public','54','64','IDC8-XK-Dell-88','Dell-S888','OnLine',''),(16,'db5.test.com',NULL,'192.168.10.106','','','',NULL,NULL,NULL,NULL,'192.168.0.128','23','32','35','42','16','XK-Server-888','2014-04-17','2014-04-17','0000-00-00 00:00:00',0,0,'27','Public','60','61','IDC8-XK-Dell-88','Dell-S888','OnLine',''),(17,'test1.test.com',NULL,'192.168.2.201','','','',NULL,NULL,NULL,NULL,'192.168.0.128','24','30','20','40','16','XK-Server-888','2014-04-20','2014-04-20','0000-00-00 00:00:00',0,0,'67','Public','56','64','IDC8-XK-Dell-88','Dell-S888','OnLine','北京测试机'),(18,'web15.test.com',NULL,'192.168.1.15','','','',NULL,NULL,NULL,NULL,'192.168.0.128','22','31','34','19','16','XK-Server-888','2014-04-25','2014-04-25','2014-04-25 08:38:30',3,3,'21','Public','60','61','IDC8-XK-Dell-88','Dell-S888','OnLine',''),(19,'redis6.test.com',NULL,'192.168.11.106','','','',NULL,NULL,NULL,NULL,'192.168.0.128','22','31','34','42','50','XK-Server-888','2014-04-25','2014-04-25','2014-04-25 14:47:20',3,3,'25','Public','60','61','IDC8-XK-Dell-88','Dell-S888','OnLine',''),(20,'rels.idc8.qq.com',NULL,'172.16.50.68','','','',NULL,NULL,NULL,NULL,'192.168.0.128','69','30','34','42','49','XK-Server-888','2014-05-11','2014-05-11','2014-05-11 03:15:21',3,3,'28','Public','60','63','IDC8-XK-Dell-88','Dell-S888','OnLine','IDC8发布机');
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
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
INSERT INTO `options` VALUES (1,'option','option','no','yes','类型选项'),(2,'option','os','no','yes','操作系统'),(3,'option','role','no','yes','角色'),(4,'option','model','no','yes','服务器型号'),(5,'option','cpu','no','yes','CPU'),(6,'option','hdd','no','yes','硬盘'),(7,'option','mem','no','yes','内存'),(8,'option','idc','no','yes','IDC机房'),(9,'option','idctag','no','yes','机柜编码'),(10,'option','salt','no','yes','SaltStack'),(11,'option','status','no','yes','状态'),(12,'option','project_type','no','yes','业务类型'),(13,'option','test4','no','yes','测试4'),(14,'option','test5','no','yes','测试5'),(15,'option','test6','no','yes','测试6'),(16,'os','rhel 6.5 x64','no','yes','操作系统'),(17,'cpu','Intel Xeon','no','yes','Intel Xeon'),(18,'os','rhel 5.5 x64','no','yes','操作系统'),(19,'mem','16G','no','yes','16G'),(20,'hdd','720G','no','yes','720G'),(21,'role','Web','no','yes','Web服务器'),(22,'model','Dell R520','no','yes','戴尔服务器'),(23,'model','Dell R720','no','yes','戴尔服务器'),(24,'model','Dell R420','no','yes','戴尔服务器'),(25,'role','Redis','no','yes','Redis服务器'),(26,'role','Front','no','yes','前置机'),(27,'role','MySQL','no','yes','数据库服务器'),(28,'role','Release','no','yes','发布机'),(29,'role','Jump','no','yes','跳板机'),(30,'cpu','Intel Xeon E3','no','yes','Intel Xeon E3'),(31,'cpu','Intel Xeon E5','no','yes','Intel Xeon E5'),(32,'cpu','Intel Xeon E7','no','yes','Intel Xeon E7'),(33,'hdd','500G','no','yes','500G'),(34,'hdd','1T','no','yes','1T'),(35,'hdd','2T','no','yes','2T'),(36,'hdd','3T','no','yes','3T'),(37,'hdd','4T','no','yes','4T'),(38,'hdd','5T','no','yes','5T'),(39,'hdd','10T','no','yes','10T'),(40,'mem','8G','no','yes','8G'),(41,'mem','32G','no','yes','32G'),(42,'mem','64G','no','yes','64G'),(43,'mem','128G','no','yes','128G'),(44,'mem','256G','no','yes','256G'),(45,'mem','512G','no','yes','512G'),(46,'os','Ubuntu 12.04 x64','no','yes','Ubuntu操作系统'),(47,'os','CentOS 6.5 x64','no','yes','CentOS操作系统'),(48,'os','CentOS 5.4 x64','no','yes','CentOS 5.4'),(49,'os','CentOS','no','yes','CentOS'),(50,'os','RedHat','no','yes','红帽'),(51,'os','Ubuntu','no','yes','乌班图'),(52,'os','Win 2008 R2','no','yes','Windows操作系统'),(53,'os','Other','no','yes','其他系统'),(54,'idc','人民中 - IDC2','no','yes','广州人民中机房'),(55,'idc','新一代 - IDC1','no','yes','广州新一代机房'),(56,'idc','北京 - IDC3','no','yes','北京电信机房'),(57,'idc','中山 - IDC4','no','yes','中山机房'),(58,'idc','腾讯云 - IDC5','no','yes','腾讯云主机'),(59,'idc','亚太 - IDC6','no','yes','广州亚太IDC'),(60,'idc','上海 - IDC8','no','yes','上海移动机房'),(61,'idctag','G1柜','no','yes','人民中机柜'),(62,'idctag','G2柜','no','yes','北京IDC-G2柜'),(63,'idctag','G8柜','no','yes','北京-G8柜'),(64,'idctag','G3柜','no','yes','新一代 - G柜'),(65,'idctag','H6柜','no','yes','北京 - H6柜'),(66,'idctag','腾讯云QY9','no','yes','腾讯云 - QY9'),(67,'role','Test','no','yes','测试机'),(68,'role','Ohter','no','yes','其他角色'),(69,'model','Dell R410','no','yes','戴尔服务器'),(70,'project_type','广告系统','no','yes','新广告系统'),(71,'project_type','支付平台','no','yes','Payment'),(72,'project_type','用户平台','no','yes','用户平台'),(73,'project_type','核心业务','no','yes','核心业务'),(74,'project_type','网游','no','yes','网游'),(75,'project_type','休闲游戏','no','yes','feed'),(76,'project_type','棋牌游戏','no','yes','棋牌'),(77,'project_type','业务平台','no','yes','业务平台');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_base`
--

LOCK TABLES `project_base` WRITE;
/*!40000 ALTER TABLE `project_base` DISABLE KEYS */;
INSERT INTO `project_base` VALUES (1,'互娱游戏平台','hy2game','hy2game.qq.com',80,'yes','PHP','Xiaok','AST','/data/www/hy2game',75,'online',3,'2014-05-10 22:09:15',3,'2014-05-10 14:09:15',NULL,'测试业务'),(2,'支付平台2期','pay2','pay2.qq.com',80,'yes','PHP','Xiaok','AAAAA','/data/www/pay2',71,'test',3,'2014-05-11 11:10:10',3,'2014-05-11 03:10:10',NULL,'支付2期_Beta'),(3,'用户中心','usercenter','api.uc.qq.com',80,'yes','PHP','陆小K','用户中心团队','/data/www/usercenter/api',72,'online',3,'2014-05-11 11:12:07',3,'2014-05-11 03:12:07',NULL,'用户中心'),(4,'支付2期测试','test_pay2','test.pay2.qq.com',8100,'no','PHP','HYY','XK','/data/www/test_pay2',71,'test',3,'2014-05-11 14:15:41',3,'2014-05-11 06:15:41',NULL,'支付2期测试'),(5,'开放平台','openapi','api.qq.com',80,'yes','PHP','Test','HanLei','/data/www/openapi',77,'online',3,'2014-05-11 15:44:41',3,'2014-05-11 07:44:41',NULL,'开放平台1期'),(6,'开放平台2','openapi2','api2.qq.com',80,'yes','PHP','Test','HanLei','/data/www/openapi2',77,'online',3,'2014-05-11 15:48:23',3,'2014-05-11 07:48:23',NULL,'开放平台2期'),(7,'测试平台','test','test.qq.com',80,'yes','PHP','LiLei','XiaoMing','/data/www/test',70,'dev',3,'2014-05-11 15:51:13',3,'2014-05-11 07:51:13',NULL,'test'),(8,'测试平台2','test2','test2.qq.com',80,'yes','PHP','LiLei','XiaoMing','/data/www/test2',77,'dev',3,'2014-05-11 15:52:44',3,'2014-05-11 07:52:44',NULL,'test2'),(9,'测试平台3','test3','test3.qq.com',80,'yes','PHP','LiLei','XiaoMing','/data/www/test3',77,'dev',3,'2014-05-11 15:54:19',3,'2014-05-11 07:54:19',NULL,'test3'),(10,'测试平台4','test4','test4.com',80,'yes','PHP','TSA','Xiaok','/data/www/test4',77,'dev',3,'2014-05-15 12:08:36',3,'2014-05-15 04:08:36','支付平台','00000');
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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_redis`
--

LOCK TABLES `project_redis` WRITE;
/*!40000 ALTER TABLE `project_redis` DISABLE KEYS */;
INSERT INTO `project_redis` VALUES (1,3,6378,'/etc/redis/test6379.conf','1G',0,0,'2014-04-23 10:33:42','2014-04-23 10:29:33',0,0,'yes',''),(2,8,6379,'/etc/redis/test_6379.conf','1G',0,0,'2014-04-23 10:20:08','2014-04-23 10:30:57',0,0,'yes',''),(3,3,6377,'/etc/redis/test_.conf','1G',0,24,'2014-04-23 10:28:07','2014-04-26 15:55:24',0,3,'yes',''),(4,3,6379,'/etc/redis/test_6369.conf.stop','1G',0,0,'2014-04-23 10:28:07','2014-04-26 13:44:47',0,3,'no',''),(5,3,6380,'/etc/redis/test_6380.conf','1G',0,0,'2014-04-23 10:20:08','2014-04-23 10:40:06',0,0,'yes',''),(6,8,6385,'/etc/redis/test_6385.conf','888M',0,0,'2014-04-24 02:02:55','2014-04-24 07:23:31',0,0,'yes',''),(7,10,6310,'/etc/redis/6310.conf','512M',0,10,'2014-04-24 02:02:55','2014-04-26 14:34:56',0,3,'yes',''),(8,8,6305,'/etc/redis/6305.conf','700M',0,0,'2014-04-24 02:04:43','2014-04-24 08:03:16',0,0,'yes',''),(9,10,6309,'/etc/redis/test_6309.conf','5G',0,0,'2014-04-24 02:04:41','2014-04-26 14:44:30',0,3,'yes','测试实例'),(10,3,6501,'/etc/redis/6501','1G',7,0,'2014-04-24 02:02:55','2014-04-26 13:45:47',0,3,'yes',''),(11,8,6502,'/etc/redis/6502.conf','500M',0,0,'2014-04-24 02:04:43','2014-04-24 08:05:36',0,0,'yes',''),(12,10,6509,'/etc/redis/6509','2G',0,25,'2014-04-24 02:04:42','2014-04-26 16:06:32',0,3,'yes',''),(13,12,6379,'/etc/redis/6379.conf','4G',0,0,'2014-04-24 09:33:01','2014-04-24 09:33:21',0,0,'yes',''),(14,12,6380,'/etc/redis/6380.conf','1G',0,0,'2014-04-24 09:33:30','2014-04-24 09:33:44',0,0,'yes',''),(15,12,6381,'/etc/redis/test6381.conf','512M',0,0,'2014-04-24 09:33:01','2014-04-24 09:37:47',0,0,'yes',''),(16,10,6580,'/etc/redis/test6580.conf','5G',0,0,'2014-04-25 03:35:04','2014-04-25 06:35:16',3,3,'yes',''),(17,19,6379,'/etc/redis/r6_hy_6379.conf','1G',26,0,'2014-04-25 14:47:34','2014-04-26 16:09:27',3,3,'yes',''),(18,19,6401,'/etc/redis/test_6401.conf','2G',14,0,'2014-04-26 06:45:55','2014-04-26 06:46:40',3,3,'yes',''),(19,19,6382,'/etc/redis/slave_6382.conf','1G',0,13,'2014-04-26 06:45:55','2014-04-26 09:08:59',3,3,'yes',''),(20,8,6584,'/etc/redis/6584','8G',0,0,'2014-04-26 11:18:20','2014-04-26 11:18:33',3,3,'yes',''),(21,10,6587,'/etc/redis/6587.conf','8G',0,0,'2014-04-26 11:15:17','2014-04-26 11:23:48',3,3,'yes',''),(22,10,6311,'/etc/redis/6311.conf','8G',6,0,'2014-04-26 14:47:35','2014-04-26 15:03:10',3,3,'yes','测试'),(23,8,6501,'/etc/redis/6501.conf','8G',0,9,'2014-04-26 15:02:20','2014-04-26 15:02:52',3,3,'yes',''),(24,19,6402,'/etc/redis/6402.conf','1G',3,0,'2014-04-26 15:48:15','2014-04-26 15:48:48',3,3,'yes',''),(25,12,6382,'/etc/redis/6382.conf','1G',12,0,'2014-04-26 16:05:30','2014-04-26 16:06:32',3,3,'yes',''),(26,3,6502,'/etc/redis/6502.conf','1G',0,17,'2014-04-26 16:05:30','2014-04-26 16:09:27',3,3,'yes','');
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (0,'System','00000000','系统','88888888','system@test.com',0,'no',0,'2014-03-30 06:18:50','System'),(1,'admin','21232f297a57a5a743894a0e4a801fc3','超级管理员','88888888','admin@test.com',0,'yes',99,'2014-03-30 06:18:50','Super Admin'),(2,'test','4124bc0a9335c27f086f24ba207a4912','测试用户',NULL,NULL,0,'no',0,'2014-03-30 06:19:28',NULL),(3,'luxiaok','6b1230a362a507f432b56d4694cb7846','陆小K','15084862585','xiaok.zhong@idreamsky.com',0,'yes',152,'2014-03-30 06:18:58','深圳陆小K'),(4,'xiaok','db884468559f4c432bf1c1775f3dc9da','None','88888888','xiaok@test.com',1,'yes',0,'2014-05-01 12:55:02','None'),(9,'test6','4cfad7076129962ee70c36839a1e3e15','测试用户6',NULL,NULL,1,'no',0,'2014-05-01 12:55:02',NULL),(11,'test8','5e40d09fa0529781afd1254a42913847','测试用户8',NULL,NULL,1,'yes',0,'2014-05-01 12:55:02','测试用户8'),(13,'test2','ad0234829205b9033196ba818f7a872b','测试用户2',NULL,NULL,1,'yes',0,'2014-05-01 12:55:02',NULL),(14,'test3','47bce5c74f589f4867dbd57e9ca9f808','测试用户3','None','None',1,'yes',0,'2014-05-01 12:55:02','测试用户3'),(15,'test4','86985e105f79b95d6bc918fb45ec7727','测试用户4',NULL,NULL,1,'yes',0,'2014-05-01 12:55:02',NULL),(16,'test5','e3d704f3542b44a621ebed70dc0efe13','测试用户5',NULL,NULL,1,'no',0,'2014-05-01 12:55:02',NULL),(17,'test7','b04083e53e242626595e2b8ea327e525','测试用户7',NULL,NULL,1,'yes',0,'2014-05-01 12:55:02',NULL),(18,'test9','739969b53246b2c727850dbb3490ede6','测试用户9',NULL,NULL,1,'yes',0,'2014-05-01 12:55:02',NULL),(19,'test10','c1a8e059bfd1e911cf10b626340c9a54','测试用户10',NULL,NULL,1,'yes',0,'2014-05-01 12:55:02','测试用户10'),(20,'test11','f696282aa4cd4f614aa995190cf442fe','测试用户11',NULL,NULL,1,'yes',0,'2014-04-07 10:59:10','测试用户'),(21,'test12','60474c9c10d7142b7508ce7a50acf414','测试用户12','111','11111',1,'yes',0,'2014-04-12 15:49:30','测试12'),(22,'test13','33fc3dbd51a8b38a38b1b85b6a76b42b','测试用户13','123225','1423423235',1,'yes',0,'2014-04-12 16:59:59','测试'),(23,'testpost','e10adc3949ba59abbe56e057f20f883e','测试Post漏洞','15084852585','post@test.com',0,'yes',0,'2014-04-26 05:28:44','测试Post漏洞注册的用户'),(24,'test21','202cb962ac59075b964b07152d234b70','测试用户21','123','test21@test.com',1,'yes',0,'2014-04-26 05:42:52','21号测试用户');
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

-- Dump completed on 2014-07-05 20:57:56
