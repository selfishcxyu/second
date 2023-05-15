-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: localhost    Database: communitym
-- ------------------------------------------------------
-- Server version	8.0.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `announcement`
--

DROP TABLE IF EXISTS `announcement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `announcement` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  `content` varchar(1020) DEFAULT NULL COMMENT '公告内容',
  `title` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='公告';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcement`
--

LOCK TABLES `announcement` WRITE;
/*!40000 ALTER TABLE `announcement` DISABLE KEYS */;
INSERT INTO `announcement` VALUES (1,'2022-12-23 09:37:54','哈哈哈哈哈','第一'),(2,'2022-12-23 09:42:59','啊啊啊啊啊啊','第二'),(3,'2022-12-23 09:45:00','啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊','三三'),(5,'2023-02-09 13:08:59','祝大家在新的一年开开心心，健健康康，快快乐乐','新年快乐！！·'),(6,'2023-03-25 16:12:22','大四下学期，快毕业了','开学快乐'),(7,'2023-05-05 13:40:48','快乐','答辩'),(8,'2023-05-05 15:33:00','嗯二分','啊啊啊');
/*!40000 ALTER TABLE `announcement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill`
--

DROP TABLE IF EXISTS `bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(20) NOT NULL COMMENT '采购人名字',
  `name` varchar(50) NOT NULL COMMENT '物品名称',
  `count` int(10) NOT NULL COMMENT '物品数量',
  `price` int(10) NOT NULL COMMENT '物品单价',
  `total` int(11) DEFAULT NULL COMMENT '账单总额',
  `picture` varchar(512) NOT NULL COMMENT '采购支付凭证',
  `time` datetime DEFAULT NULL COMMENT '账单确认时间',
  `note` varchar(200) DEFAULT NULL COMMENT '采购备注',
  `state` varchar(10) DEFAULT '未确认' COMMENT '由管理员确认账单',
  `phone` varchar(20) DEFAULT NULL COMMENT '采购人电话',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='采购物品账单，额外采购表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill`
--

LOCK TABLES `bill` WRITE;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
INSERT INTO `bill` VALUES (2,'管理员','灭火器',1,10,10,'http://localhost:90/file/3a5197abe5704125b2c9ceaea81770b0.jpg','2023-02-27 17:55:45','无','已确认','1231331'),(4,'张二蛋','签字笔',10,1,10,'http://localhost:90/file/abc917f1c7c149eb9142fa050ae02a05.jpg','2023-02-27 18:02:00',NULL,'已确认','11451415411'),(5,'管理员','1',1,1,1,'http://localhost:90/file/20b3babe6c7547d6a9369e987db56313.jpg','2023-05-05 23:36:00',NULL,'已确认','1'),(6,'管理员','灭火器',10,10,100,'http://localhost:90/file/08f9f4c1dc8e4ec9a266b03f5ee82f2d.png','2023-05-05 23:36:00',NULL,'已确认','1');
/*!40000 ALTER TABLE `bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `complaint`
--

DROP TABLE IF EXISTS `complaint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `complaint` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `nickname` varchar(20) NOT NULL COMMENT '投诉人姓名',
  `doorplate` varchar(20) NOT NULL COMMENT '门牌号\n',
  `event` varchar(50) NOT NULL COMMENT '报修事件\n',
  `time` date DEFAULT NULL COMMENT '处理时间',
  `state` varchar(6) DEFAULT NULL COMMENT '处理状态：还未处理/已处理',
  `pid` varchar(10) DEFAULT NULL COMMENT '投诉人的id号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='报修处理表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complaint`
--

LOCK TABLES `complaint` WRITE;
/*!40000 ALTER TABLE `complaint` DISABLE KEYS */;
INSERT INTO `complaint` VALUES (12,'mkm','A102','水龙头坏了','2023-05-05','已处理','2'),(13,'mkm','A102','撒大大','2023-01-05','已处理','2'),(14,'mkm','A102','撒大苏打大大','2023-01-05','已处理','2'),(15,'mkm','A102','huaile',NULL,'正在处理','2'),(16,'mkm','A101','门坏了',NULL,'正在处理','2'),(17,'mkm','A101','门把手坏了',NULL,'正在处理','2');
/*!40000 ALTER TABLE `complaint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file`
--

DROP TABLE IF EXISTS `file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `file` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '文件名称',
  `type` varchar(255) DEFAULT NULL COMMENT '文件类型',
  `size` bigint(20) DEFAULT NULL COMMENT '文件大小',
  `url` varchar(255) DEFAULT NULL COMMENT '下载链接',
  `md5` varchar(255) DEFAULT NULL COMMENT '文件的标识，',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COMMENT='文件';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file`
--

LOCK TABLES `file` WRITE;
/*!40000 ALTER TABLE `file` DISABLE KEYS */;
INSERT INTO `file` VALUES (1,'小红1.jpg','jpg',128,'http://localhost:90/file/82efcf56edf54f25b5bd19374a1ee589.jpg','ee8fb1482b48d3fc963e385631282640'),(2,'心海.jpg','jpg',133,'http://localhost:90/file/8e06ee68f37d4437b98967629681f6e6.jpg','3c3fdb138b0bb69e99ec3ee673c3dc84'),(3,'肉骨茶 个性二次元.jpg','jpg',75,'http://localhost:90/file/436c7b402a8541809263463499ef4f3f.jpg','c0db55e72801185fedea9700c5cbe22e'),(4,'20200721101729_z8iZn.jpeg','jpeg',38,'http://localhost:90/file/17b8357cd7584f479999d6b7cbde8592.jpeg','4b18ebb536455e6e4f807097f9e29dcb'),(5,'原神 雷电将军 同人 .jpg','jpg',245,'http://localhost:90/file/3a5197abe5704125b2c9ceaea81770b0.jpg','5ab2f95335272a38c37b419711ebfac1'),(6,'原神刻晴 美脚美腿 .jpg','jpg',99,'http://localhost:90/file/429707dacca8455ca7d1f8aa6f8abeb9.jpg','1831a4077b61718e78978c16bb3db174'),(7,'可爱猫耳女孩子 蓝色眼睛 尾巴 二次元.jpg','jpg',213,'http://localhost:90/file/abc917f1c7c149eb9142fa050ae02a05.jpg','04c7b50ad33e82b28a38aee6e6c8135d'),(8,'20200721101729_z8iZn.jpeg','jpeg',38,'http://localhost:90/file/17b8357cd7584f479999d6b7cbde8592.jpeg','4b18ebb536455e6e4f807097f9e29dcb'),(9,'20200721101729_z8iZn.jpeg','jpeg',38,'http://localhost:90/file/17b8357cd7584f479999d6b7cbde8592.jpeg','4b18ebb536455e6e4f807097f9e29dcb'),(10,'20200721101729_z8iZn.jpeg','jpeg',38,'http://localhost:90/file/17b8357cd7584f479999d6b7cbde8592.jpeg','4b18ebb536455e6e4f807097f9e29dcb'),(11,'3D绘画 可爱女生 长发 唯美好看.jpg','jpg',211,'http://localhost:90/file/885373287ecd4c189fba66f9b55e07e9.jpg','93770f4155e44fc703e88e2a77c86f9e'),(12,'spring.docx','docx',20,'http://localhost:90/file/fda5d24ff6544cf68379a66a2b637496.docx','5ac35a44debbd7f26dc13717e1d3cc0e'),(13,'spring.docx','docx',20,'http://localhost:90/file/fda5d24ff6544cf68379a66a2b637496.docx','5ac35a44debbd7f26dc13717e1d3cc0e'),(14,'二次元少女 可爱猫耳 萌 电脑 绘画 创作 .jpg','jpg',115,'http://localhost:90/file/cb075a6a1d85426e943e2f50ae98c224.jpg','145c1bfbb007b7afc0ec01eda538a7ee'),(15,'20200721101729_z8iZn.jpeg','jpeg',38,'http://localhost:90/file/17b8357cd7584f479999d6b7cbde8592.jpeg','4b18ebb536455e6e4f807097f9e29dcb'),(16,'肉骨茶 个性二次元.jpg','jpg',75,'http://localhost:90/file/436c7b402a8541809263463499ef4f3f.jpg','c0db55e72801185fedea9700c5cbe22e'),(17,'20200721101729_z8iZn.jpeg','jpeg',38,'http://localhost:90/file/17b8357cd7584f479999d6b7cbde8592.jpeg','4b18ebb536455e6e4f807097f9e29dcb'),(18,'jinmao.jpg','jpg',980,'http://localhost:90/file/20b3babe6c7547d6a9369e987db56313.jpg','74c15c9cd779565cffa66405483d4138'),(19,'jinmao.jpg','jpg',980,'http://localhost:90/file/20b3babe6c7547d6a9369e987db56313.jpg','74c15c9cd779565cffa66405483d4138'),(20,'20200721101729_z8iZn.jpeg','jpeg',38,'http://localhost:90/file/17b8357cd7584f479999d6b7cbde8592.jpeg','4b18ebb536455e6e4f807097f9e29dcb'),(21,'jinmao.jpg','jpg',980,'http://localhost:90/file/20b3babe6c7547d6a9369e987db56313.jpg','74c15c9cd779565cffa66405483d4138'),(22,'erohu.jpg','jpg',1000,'http://localhost:90/file/97fdcd2bd5dc46af921c14fb8331d21a.jpg','961b311aa7f4069fc910254d2372355e'),(23,'好好学习 天天向上 厚涂 女孩子眼镜 笔 工程师 板绘 好看.jpg','jpg',110,'http://localhost:90/file/03bdd8091edf458f81ac526f3b626275.jpg','199c58155c2f2378fd879a7c5ac5741f'),(24,'碧蓝档案 砂狼 插画女子 兽耳少女 二次元.jpg','jpg',98,'http://localhost:90/file/4c2af0be31cb4e75b88c3c682f64fd03.jpg','da6d3b59914ca8371ad31e74e3fe661c'),(25,'可爱女孩 白丝袜长筒袜 兽耳猫耳 休闲吧 笔记本电脑 二次元.jpg','jpg',245,'http://localhost:90/file/3710d36dc9fa4abea2b663d9481ed916.jpg','3e09fcb917cfab892982eb523b495ffe'),(26,'logBG.png','png',362,'http://localhost:90/file/08f9f4c1dc8e4ec9a266b03f5ee82f2d.png','f955feb90d4a5f3880ff8019b70f7d15'),(27,'20200721101729_z8iZn.jpeg','jpeg',38,'http://localhost:90/file/17b8357cd7584f479999d6b7cbde8592.jpeg','4b18ebb536455e6e4f807097f9e29dcb'),(28,'xiaohong.jpeg','jpeg',38,'http://localhost:90/file/17b8357cd7584f479999d6b7cbde8592.jpeg','4b18ebb536455e6e4f807097f9e29dcb'),(29,'波波头.jpg','jpg',72,'http://localhost:90/file/4481723ab7bd4ca1a85727984de08c25.jpg','95bd0b02ea796f08b165c2969c841834'),(30,'3D绘画 可爱女生 长发 唯美好看.jpg','jpg',211,'http://localhost:90/file/885373287ecd4c189fba66f9b55e07e9.jpg','93770f4155e44fc703e88e2a77c86f9e'),(31,'长发黑色.jpg','jpg',175,'http://localhost:90/file/be6d0360fbef4ee8b6f39bab0f678cad.jpg','e6a553955392c4638f7107963d42cd4b'),(32,'扎辫子.jpg','jpg',64,'http://localhost:90/file/73f277fde8554f0786b3a24393bc9c1c.jpg','a07f5b5451db0107bf96a3f5728cfad1'),(33,'扎辫子.jpg','jpg',64,'http://localhost:90/file/73f277fde8554f0786b3a24393bc9c1c.jpg','a07f5b5451db0107bf96a3f5728cfad1'),(34,'扎辫子.jpg','jpg',64,'http://localhost:90/file/73f277fde8554f0786b3a24393bc9c1c.jpg','a07f5b5451db0107bf96a3f5728cfad1'),(35,'好好学习 天天向上 厚涂 女孩子眼镜 笔 工程师 板绘 好看.jpg','jpg',110,'http://localhost:90/file/03bdd8091edf458f81ac526f3b626275.jpg','199c58155c2f2378fd879a7c5ac5741f'),(36,'20200721101729_z8iZn.jpeg','jpeg',38,'http://localhost:90/file/17b8357cd7584f479999d6b7cbde8592.jpeg','4b18ebb536455e6e4f807097f9e29dcb'),(37,'20200721101729_z8iZn.jpeg','jpeg',38,'http://localhost:90/file/17b8357cd7584f479999d6b7cbde8592.jpeg','4b18ebb536455e6e4f807097f9e29dcb'),(38,'20200721101729_z8iZn.jpeg','jpeg',38,'http://localhost:90/file/17b8357cd7584f479999d6b7cbde8592.jpeg','4b18ebb536455e6e4f807097f9e29dcb'),(39,'20200721101729_z8iZn.jpeg','jpeg',38,'http://localhost:90/file/17b8357cd7584f479999d6b7cbde8592.jpeg','4b18ebb536455e6e4f807097f9e29dcb'),(40,'20200721101729_z8iZn.jpeg','jpeg',38,'http://localhost:90/file/17b8357cd7584f479999d6b7cbde8592.jpeg','4b18ebb536455e6e4f807097f9e29dcb'),(41,'20200721101729_z8iZn.jpeg','jpeg',38,'http://localhost:90/file/17b8357cd7584f479999d6b7cbde8592.jpeg','4b18ebb536455e6e4f807097f9e29dcb');
/*!40000 ALTER TABLE `file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `path` varchar(20) DEFAULT NULL COMMENT '路径',
  `name` varchar(20) DEFAULT NULL,
  `icon` varchar(30) DEFAULT NULL COMMENT '图标名',
  `url` varchar(100) DEFAULT NULL COMMENT '根据url导入路由',
  `authority` int(1) NOT NULL DEFAULT '0' COMMENT '0是管理员独有，\n1是普通用户，\n-1是全部共有的，\n2是员工和管理员\n菜单权限获取\n管理员获取0，-1，2\n用户获取1，-1\n员工获取1，-1，2',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COMMENT='菜单权限管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (4,'user','用户管理','user','User/User.vue',0),(6,'files','文件管理','document','Files/Files.vue',0),(9,'residence','住宅管理','house','Residence/Residence.vue',0),(10,'residenceUser','住宅','house','Residence/ResidenceUser.vue',1),(11,'notice','公告','chat-round','Notice/Notice.vue',-1),(12,'complaintUser','报修','warning-outline','Complaint/ComplaintUser.vue',1),(13,'parking','车位管理','chat-round','Parking/Parking.vue',0),(14,'parkingUser','车位','chat-round','Parking/ParkingUser.vue',1),(16,'pay','生活缴费管理','hot-water','Pay/Pay.vue',0),(17,'payUser','生活缴费','hot-water','Pay/PayUser.vue',1),(18,'suggestion','建议留言','microphone','Complaint/Suggestion.vue',-1),(19,'statistics','财务管理','money','Statistics/Statistics.vue',0),(20,'complaint','报修管理','warning-outline','Complaint/Complaint.vue',2),(21,'staff','员工管理','s-custom','Staff/Staff.vue',0),(23,'bill','账单管理','s-marketing','Statistics/Bill.vue',2),(25,'warehouse','仓库管理','refrigerator','Warehouse/Warehouse.vue',2),(27,'condition','情况汇报','notebook-1','Staff/Condition.vue',2);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parking`
--

DROP TABLE IF EXISTS `parking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parking` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `number` varchar(20) NOT NULL COMMENT '车位编号\n',
  `building` varchar(20) DEFAULT NULL COMMENT '车位所在楼宇',
  `nickname` varchar(20) DEFAULT NULL COMMENT '车位所属人\n',
  `pid` int(10) DEFAULT '0' COMMENT '车位所属人的id',
  `req` varchar(100) DEFAULT NULL COMMENT '购买/租用车位的人的请求\n（nickname/pid）',
  `state` varchar(10) DEFAULT '空闲',
  PRIMARY KEY (`id`),
  UNIQUE KEY `parking_number_uindex` (`number`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='车位管理表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parking`
--

LOCK TABLES `parking` WRITE;
/*!40000 ALTER TABLE `parking` DISABLE KEYS */;
INSERT INTO `parking` VALUES (1,'A001','happyA','mkm',2,NULL,'购买'),(3,'A002','happyA',NULL,0,NULL,'空闲'),(4,'A003','happyA','',0,'','空闲'),(5,'A004','happyA',NULL,0,'{\"id\":2,\"nickname\":\"mkm\"}','空闲');
/*!40000 ALTER TABLE `parking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay`
--

DROP TABLE IF EXISTS `pay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pay` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `doorplate` varchar(20) NOT NULL COMMENT '需要缴费用户的门牌号\n',
  `building` varchar(20) NOT NULL COMMENT '需要缴费用户所在的楼宇',
  `type` varchar(10) NOT NULL COMMENT '费用类型',
  `money` int(10) NOT NULL COMMENT '缴费金额\n',
  `state` varchar(10) DEFAULT '未支付' COMMENT '是否已缴费：缴费状态',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '缴费开始时间',
  `payTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8 COMMENT='缴费表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay`
--

LOCK TABLES `pay` WRITE;
/*!40000 ALTER TABLE `pay` DISABLE KEYS */;
INSERT INTO `pay` VALUES (5,'A102','happyA','水费',1222,'已缴费','2023-01-05 13:45:24','2023-01-08 17:19:15'),(14,'A102','happyA','水费',100,'已缴费','2023-01-09 16:00:01','2023-01-28 14:16:00'),(15,'A103','happyA','水费',100,'已缴费','2023-01-09 16:00:01','2023-01-12 17:19:22'),(17,'A102','happyA','物业费',300,'已缴费','2023-01-09 16:00:02','2023-01-14 21:01:00'),(18,'A103','happyA','物业费',300,'已缴费','2023-01-09 16:00:02','2023-01-14 17:19:32'),(29,'A102','happyA','物业费',400,'已缴费','2023-01-11 15:00:01','2023-01-14 17:19:36'),(30,'A103','happyA','物业费',400,'已缴费','2023-01-11 15:00:01','2023-01-14 17:19:41'),(33,'A103','happyA','水费',100,'已缴费','2023-01-11 16:00:00','2023-03-25 22:29:00'),(35,'A102','happyA','物业费',300,'已缴费','2023-01-11 16:00:00','2023-01-14 17:19:47'),(37,'A102','happyA','水费',100,'已缴费','2023-01-12 16:32:23','2023-02-24 19:50:00'),(38,'A103','happyA','水费',100,'未支付','2023-01-12 16:32:23',NULL),(40,'A102','happyA','物业费',300,'已缴费','2023-01-12 16:32:23','2023-01-14 21:01:00'),(41,'A103','happyA','物业费',300,'未支付','2023-01-12 16:32:23',NULL),(43,'A102','happyA','水费',2000,'已缴费','2022-12-15 08:20:50','2022-12-21 16:21:05'),(44,'A102','happyA','水费',100,'已缴费','2023-01-24 16:00:14','2023-01-28 14:17:00'),(45,'A103','happyA','水费',100,'未支付','2023-01-24 16:00:14',NULL),(47,'A102','happyA','物业费',300,'已缴费','2023-01-24 16:00:15','2023-02-24 19:50:00'),(48,'A103','happyA','物业费',300,'未支付','2023-01-24 16:00:15',NULL),(50,'A102','happyA','水费',100,'已缴费','2023-01-29 13:23:05','2023-02-04 17:26:00'),(51,'A103','happyA','水费',100,'未支付','2023-01-29 13:23:05',NULL),(53,'A102','happyA','物业费',300,'已缴费','2023-01-29 13:23:05','2023-02-24 19:50:00'),(54,'A103','happyA','物业费',300,'未支付','2023-01-29 13:23:05',NULL),(56,'A102','happyA','水费',100,'已缴费','2023-02-02 16:39:30','2023-03-13 14:22:00'),(57,'A103','happyA','水费',100,'未支付','2023-02-02 16:39:30',NULL),(59,'A102','happyA','物业费',300,'已缴费','2023-02-02 16:39:30','2023-02-04 17:26:00'),(60,'A103','happyA','物业费',300,'未支付','2023-02-02 16:39:30',NULL),(61,'A102','happyA','水费',100,'已缴费','2023-02-11 08:23:31','2023-02-27 17:45:00'),(62,'A103','happyA','水费',100,'未支付','2023-02-11 08:23:31',NULL),(64,'A102','happyA','物业费',300,'已缴费','2023-02-11 08:23:31','2023-02-27 17:45:00'),(65,'A103','happyA','物业费',300,'未支付','2023-02-11 08:23:31',NULL),(66,'A102','happyA','水费',100,'已缴费','2023-02-16 16:30:15','2023-03-13 14:22:00'),(67,'A103','happyA','水费',100,'未支付','2023-02-16 16:30:15',NULL),(69,'A102','happyA','物业费',300,'已缴费','2023-02-16 16:30:15','2023-02-27 17:45:00'),(70,'A103','happyA','物业费',300,'未支付','2023-02-16 16:30:15',NULL),(72,'A102','happyA','水费',100,'已缴费','2023-02-27 09:19:46','2023-03-13 14:22:00'),(73,'A103','happyA','水费',100,'未支付','2023-02-27 09:19:46',NULL),(75,'A102','happyA','物业费',300,'已缴费','2023-02-27 09:19:46','2023-02-27 17:45:00'),(76,'A103','happyA','物业费',300,'未支付','2023-02-27 09:19:46',NULL),(78,'A102','happyA','水费',100,'已缴费','2023-03-03 04:31:34','2023-03-13 14:22:00'),(79,'A103','happyA','水费',100,'未支付','2023-03-03 04:31:34',NULL),(81,'A102','happyA','物业费',300,'已缴费','2023-03-03 04:31:34','2023-03-13 14:22:00'),(82,'A103','happyA','物业费',300,'已缴费','2023-03-03 04:31:34','2023-03-26 00:34:00'),(84,'A102','happyA','水费',100,'已缴费','2023-03-12 16:02:50','2023-03-13 14:22:00'),(85,'A103','happyA','水费',100,'未支付','2023-03-12 16:02:50',NULL),(87,'A102','happyA','物业费',300,'未支付','2023-03-12 16:02:51',NULL),(88,'A103','happyA','物业费',300,'已缴费','2023-03-12 16:02:51','2023-03-26 00:34:00'),(90,'A102','happyA','水费',100,'已缴费','2023-03-17 04:45:56','2023-03-26 16:53:00'),(91,'A103','happyA','水费',100,'未支付','2023-03-17 04:45:56',NULL),(93,'A102','happyA','物业费',300,'已缴费','2023-03-17 04:45:00','2023-03-25 22:28:00'),(94,'A103','happyA','物业费',300,'未支付','2023-03-17 04:45:57',NULL),(96,'A102','happyA','水费',100,'已缴费','2023-03-26 08:08:56','2023-03-26 16:53:00'),(97,'A103','happyA','水费',100,'未支付','2023-03-26 08:08:56',NULL),(98,'A101','happyA','物业费',300,'已缴费','2023-03-26 08:08:57','2023-05-05 21:38:00'),(99,'A102','happyA','物业费',300,'已缴费','2023-03-26 08:08:57','2023-03-26 16:53:00'),(100,'A103','happyA','物业费',300,'未支付','2023-03-26 08:08:57',NULL),(101,'A101','happyA','水费',100,'未支付','2023-03-26 08:23:00','2023-05-05 21:38:00'),(102,'A102','happyA','水费',100,'未支付','2023-03-26 08:23:55',NULL),(103,'A103','happyA','水费',100,'未支付','2023-03-26 08:23:55',NULL),(104,'A101','happyA','物业费',300,'已缴费','2023-03-26 08:23:00','2023-05-05 23:33:00'),(105,'A102','happyA','物业费',300,'未支付','2023-03-26 08:23:55',NULL),(106,'A103','happyA','物业费',300,'未支付','2023-03-26 08:23:55',NULL),(107,'A101','happyA','水费',100,'已缴费','2023-04-08 05:22:00','2023-05-05 23:30:00'),(108,'A102','happyA','水费',100,'未支付','2023-04-08 05:22:35',NULL),(109,'A103','happyA','水费',100,'未支付','2023-04-08 05:22:35',NULL),(110,'A101','happyA','物业费',300,'未支付','2023-04-08 05:22:00','2023-05-05 22:22:00'),(111,'A102','happyA','物业费',300,'已缴费','2023-04-08 05:22:35','2023-05-05 22:14:00'),(112,'A103','happyA','物业费',300,'未支付','2023-04-08 05:22:35',NULL);
/*!40000 ALTER TABLE `pay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `residence`
--

DROP TABLE IF EXISTS `residence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `residence` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `doorplate` varchar(20) NOT NULL COMMENT '门牌',
  `building` varchar(20) NOT NULL COMMENT '楼宇',
  `size` varchar(20) DEFAULT NULL COMMENT '房的规格',
  `price` varchar(20) DEFAULT NULL,
  `area` varchar(20) DEFAULT NULL COMMENT '大小 /m²',
  `state` varchar(10) DEFAULT '未入住' COMMENT '入住状态',
  `resident` varchar(20) DEFAULT NULL COMMENT '住户姓名',
  `pid` varchar(10) DEFAULT NULL COMMENT '住户id',
  `req` varchar(150) DEFAULT NULL COMMENT '用户发出购买或租用的请求，为对象类型转为string类型\n管理员可查看（点击后弹出对象信息）\n核实确实后点击确认键，上传数据库',
  `time` varchar(20) DEFAULT NULL COMMENT '入住时间',
  `note` varchar(50) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `residence_doorplate_uindex` (`doorplate`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='住宅';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `residence`
--

LOCK TABLES `residence` WRITE;
/*!40000 ALTER TABLE `residence` DISABLE KEYS */;
INSERT INTO `residence` VALUES (1,'A101','happyA','三房一厅','50w','80','已入住','mkm','2','','2023-03-25','法国电视公司呱呱呱呱呱呱呱呱呱古古怪怪水水水水水水水水水水水'),(2,'A102','happyA','三房一厕所','99w','99','已入住','mkm','2',NULL,'2023-01-03',NULL),(3,'A103','happyA','三房一厕所','99w','99','已入住','saire','5',NULL,'2023-01-09',NULL),(4,'A104','happyA','san','22','22','已入住','16','asdf','','2023-05-05',NULL),(7,'B101','happyB','三房一厅','50w','80','未入住',NULL,NULL,NULL,NULL,'B小区的一号房'),(8,'B102','happyB','三房一厅','50w','80','未入住',NULL,NULL,'{\"id\":19,\"nickname\":\"eee\"}',NULL,NULL),(9,'B103','happyB','三房一厅','50w','80','未入住',NULL,NULL,NULL,NULL,NULL),(10,'B201','happyB','三房一厅','50w','80','未入住',NULL,NULL,NULL,NULL,NULL),(11,'A121','happyA','三室一厅','50w','100平','未入住',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `residence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `situation`
--

DROP TABLE IF EXISTS `situation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `situation` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL COMMENT '汇报人',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `place` varchar(50) DEFAULT NULL COMMENT '地点',
  `facility` varchar(50) DEFAULT NULL COMMENT '设备',
  `situation` varchar(200) DEFAULT NULL COMMENT '情况',
  `type` varchar(10) DEFAULT 'community' COMMENT '默认为community\n仓库的另外分',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='员工工作情况汇报（社区管理表）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `situation`
--

LOCK TABLES `situation` WRITE;
/*!40000 ALTER TABLE `situation` DISABLE KEYS */;
INSERT INTO `situation` VALUES (1,'张二蛋','2023-02-08 14:34:28','A101','灯泡','更换灯泡','community'),(2,'张二蛋','2023-02-25 09:36:08','仓库','干粉灭火器','使用了1件物品','warehouse'),(6,'管理员','2023-03-03 10:05:14','仓库','灯泡','新增新物品：灯泡 20件','warehouse'),(7,'管理员','2023-03-03 10:08:49','仓库','灯泡','增添了20件物品','warehouse'),(8,'管理员','2023-05-05 15:36:48','仓库','干粉灭火器','增添了1件物品','warehouse'),(9,'管理员','2023-05-05 15:37:18','仓库','灭火器','增加了一个灭火器','community');
/*!40000 ALTER TABLE `situation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `salary` int(10) NOT NULL COMMENT '月薪',
  `position` varchar(20) NOT NULL COMMENT '职位',
  `pid` varchar(10) DEFAULT NULL COMMENT '员工在user（注册账号的用户信息表上）的id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `staff_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='员工信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'张二蛋','11451415411',8888,'修理工','8'),(2,'老马','11111111111',4500,'保安',NULL);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statistics`
--

DROP TABLE IF EXISTS `statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `statistics` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sum` int(20) NOT NULL COMMENT '总额',
  `type` varchar(10) NOT NULL COMMENT '周/月/年财务\n员工工资staff：staffM 员工月财务\n住户缴纳费用pay：payM 住户月财务\n其他费用other：oM 月',
  `time` varchar(20) NOT NULL COMMENT '统计时间：如2022年2月\n/2022年',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='周月年财务统计报表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistics`
--

LOCK TABLES `statistics` WRITE;
/*!40000 ALTER TABLE `statistics` DISABLE KEYS */;
INSERT INTO `statistics` VALUES (1,13322,'payW','2023/01'),(2,13522,'payM','2023/01'),(3,11166,'staffM','2023/01'),(4,0,'billM','2023/01'),(5,20,'billM','2023/02'),(6,2100,'payM','2023/02'),(7,0,'billM','2023/03'),(8,11166,'staffM','2023/03'),(9,2400,'payM','2023/03');
/*!40000 ALTER TABLE `statistics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suggestion`
--

DROP TABLE IF EXISTS `suggestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suggestion` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `time` datetime NOT NULL,
  `avatar` varchar(255) DEFAULT NULL COMMENT '用户头像',
  `suggestion` varchar(1024) DEFAULT NULL COMMENT '发表的留言建议',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COMMENT='用户建议留言表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suggestion`
--

LOCK TABLES `suggestion` WRITE;
/*!40000 ALTER TABLE `suggestion` DISABLE KEYS */;
INSERT INTO `suggestion` VALUES (5,'admin','2023-01-11 18:15:00','http://localhost:90/file/82efcf56edf54f25b5bd19374a1ee589.jpg','?'),(6,'admin','2023-01-11 21:23:00','http://localhost:90/file/82efcf56edf54f25b5bd19374a1ee589.jpg','en'),(28,'admin','2023-05-05 21:59:00','http://localhost:90/file/82efcf56edf54f25b5bd19374a1ee589.jpg','21'),(29,'admin','2023-05-05 21:59:00','http://localhost:90/file/82efcf56edf54f25b5bd19374a1ee589.jpg','23'),(39,'abcd','2023-05-05 23:38:00','http://localhost:90/file/17b8357cd7584f479999d6b7cbde8592.jpeg','aaaa');
/*!40000 ALTER TABLE `suggestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL DEFAULT '123456',
  `nickname` varchar(20) DEFAULT NULL,
  `gender` varchar(2) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `idcard` varchar(50) DEFAULT NULL COMMENT '身份证号',
  `email` varchar(50) DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建的时间',
  `avatar` varchar(500) DEFAULT NULL,
  `level` varchar(10) NOT NULL DEFAULT 'user' COMMENT '用户、员工或管理员',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_username_uindex` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='用户信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','admin','管理员','男','19927570314','445321200012170615','abcdefg@qq.com','2022-12-24 11:18:23','http://localhost:90/file/82efcf56edf54f25b5bd19374a1ee589.jpg','admin'),(2,'mkm','mkm','mkm','女','19951471734','445322200110100','mkmlll@qq.com','2022-02-09 10:06:23','http://localhost:90/file/73f277fde8554f0786b3a24393bc9c1c.jpg','user'),(3,'dianci','dianci','dianci','男','16666',NULL,'dianci','2022-04-12 15:08:32','http://localhost/file/dda4e37e899847f58fbad2464c6ec6da.jpg','user'),(5,'saire','saire','塞蕾','女','19923231212','445321200112120','521520@qq.com','2022-06-09 09:56:16','https://tse3-mm.cn.bing.net/th/id/OIP-C.xPTtnXDLY9JWFoA2uO0RowHaI0?pid=ImgDet&rs=1','user'),(7,'asd','123456','sa\'d','女',NULL,'123465',NULL,'2023-01-17 09:22:46',NULL,'user'),(8,'zhang','zhang','张二蛋','男','11451471734','213','1234','2023-01-27 14:29:34','http://localhost:90/file/17b8357cd7584f479999d6b7cbde8592.jpeg','staff'),(9,'qiu','qiu',NULL,'男',NULL,NULL,NULL,'2023-02-05 12:58:34','http://localhost:90/file/3710d36dc9fa4abea2b663d9481ed916.jpg','user'),(11,'_123456','123456_',NULL,NULL,NULL,NULL,NULL,'2023-03-07 07:40:03',NULL,'user'),(13,'abccc','abccc','11','女',NULL,NULL,NULL,'2023-03-07 08:47:16',NULL,'user'),(14,'qqq','qqq',NULL,NULL,NULL,NULL,NULL,'2023-05-05 13:28:35',NULL,'user'),(15,'aaaa','aaaa','aaa','男','19922330123','445321201212120611','1599187423@qq.com','2023-05-05 13:29:15','http://localhost:90/file/73f277fde8554f0786b3a24393bc9c1c.jpg','user'),(16,'bbbb','bbbb','asdf','男','19922223333','444321201212120311','123456789@qq.com','2023-05-05 13:36:34','http://localhost:90/file/03bdd8091edf458f81ac526f3b626275.jpg','user'),(17,'ccc','ccc',NULL,NULL,NULL,NULL,NULL,'2023-05-05 14:02:04',NULL,'user'),(18,'dddd','dddd','ddddd','男','17727273333','443212200001010605','123456789@qq.com','2023-05-05 14:03:15','http://localhost:90/file/17b8357cd7584f479999d6b7cbde8592.jpeg','user'),(19,'eee','eee','eee','女','19922223333','444323200010100101','123456789@qq.com','2023-05-05 14:06:22','http://localhost:90/file/17b8357cd7584f479999d6b7cbde8592.jpeg','user'),(20,'fff','fff','fff','女','19922223334','443212200001010103','123456@qq.com','2023-05-05 14:13:09','http://localhost:90/file/17b8357cd7584f479999d6b7cbde8592.jpeg','user'),(21,'ggg','ggg','ggg','男','19922223232','443214201212120101','123465@qq.com','2023-05-05 14:20:37','http://localhost:90/file/17b8357cd7584f479999d6b7cbde8592.jpeg','user'),(22,'aaaaa','aaaaa','aaaaa','男','19922233322','442142200012120201','123323@qq.com','2023-05-05 14:26:03','http://localhost:90/file/17b8357cd7584f479999d6b7cbde8592.jpeg','user'),(23,'abcd','abcd','abcd','男','19924261535','443212201212120201','123123@qq.com','2023-05-05 15:37:46','http://localhost:90/file/17b8357cd7584f479999d6b7cbde8592.jpeg','user');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehouse`
--

DROP TABLE IF EXISTS `warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouse` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '货物名字',
  `count` varchar(10) DEFAULT NULL COMMENT '货物数量',
  `description` varchar(100) DEFAULT NULL COMMENT '货物描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='仓库：存放安保、消防、保洁、维修等工作所需的物品';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouse`
--

LOCK TABLES `warehouse` WRITE;
/*!40000 ALTER TABLE `warehouse` DISABLE KEYS */;
INSERT INTO `warehouse` VALUES (1,'干粉灭火器','50','灭火器'),(4,'灯泡','40','发光的');
/*!40000 ALTER TABLE `warehouse` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-15 15:53:07
