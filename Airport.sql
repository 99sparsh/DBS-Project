-- MySQL dump 10.13  Distrib 5.7.27, for Linux (x86_64)
--
-- Host: localhost    Database: Airport
-- ------------------------------------------------------
-- Server version	5.7.27-0ubuntu0.18.04.1

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
-- Table structure for table `airlines`
--

DROP TABLE IF EXISTS `airlines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `airlines` (
  `airline_id` int(11) NOT NULL,
  `name` varchar(15) DEFAULT NULL,
  `fleet_size` int(11) DEFAULT NULL,
  `no_staff` int(11) DEFAULT NULL,
  PRIMARY KEY (`airline_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airlines`
--

LOCK TABLES `airlines` WRITE;
/*!40000 ALTER TABLE `airlines` DISABLE KEYS */;
INSERT INTO `airlines` VALUES (1,'Indigo',6,12),(2,'Air Vistara',5,12),(3,'Spicejet',4,12),(4,'Go Air',5,11),(5,'Jet Airways',2,15),(6,'Air India',4,8),(7,'Kingfisher',6,8),(8,'Air Asia',3,10);
/*!40000 ALTER TABLE `airlines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airplanes`
--

DROP TABLE IF EXISTS `airplanes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `airplanes` (
  `airplane_id` int(11) NOT NULL,
  `airline_id` int(11) DEFAULT NULL,
  `model` varchar(5) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  PRIMARY KEY (`airplane_id`),
  KEY `airline_id` (`airline_id`),
  CONSTRAINT `airplanes_ibfk_1` FOREIGN KEY (`airline_id`) REFERENCES `airlines` (`airline_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airplanes`
--

LOCK TABLES `airplanes` WRITE;
/*!40000 ALTER TABLE `airplanes` DISABLE KEYS */;
INSERT INTO `airplanes` VALUES (1,1,'A380',150),(2,1,'A320',100),(3,1,'A320',100),(4,1,'A320',100),(5,1,'A380',150),(6,1,'A320A',80),(7,2,'SG135',120),(8,2,'A380A',135),(9,2,'A320',100),(10,2,'A380',150),(11,3,'SG120',60),(12,2,'SG135',120),(13,3,'A320',100),(14,3,'A380',150),(15,3,'SG120',60),(16,4,'SG120',60),(17,4,'A320A',80),(18,4,'A380',150),(19,4,'A320',100),(20,4,'SG120',60),(21,5,'SG120',60),(22,5,'A320A',80),(23,6,'SG120',60),(24,6,'A320A',80),(25,6,'A380',150),(26,6,'A320',100),(27,7,'SG120',60),(28,7,'A320A',80),(29,7,'A380',150),(30,7,'A320',100),(31,7,'SG120',60),(32,7,'A320',100),(33,8,'SG120',60),(34,8,'A320A',80),(35,8,'A380',150);
/*!40000 ALTER TABLE `airplanes` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger acquire_airplane after insert on airplanes
for each row
begin
update airlines set fleet_size = fleet_size + 1 where airline_id = new.airline_id;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `boarding_gates`
--

DROP TABLE IF EXISTS `boarding_gates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boarding_gates` (
  `id` varchar(2) NOT NULL,
  `floor` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boarding_gates`
--

LOCK TABLES `boarding_gates` WRITE;
/*!40000 ALTER TABLE `boarding_gates` DISABLE KEYS */;
INSERT INTO `boarding_gates` VALUES ('1',1),('2',1),('3',1);
/*!40000 ALTER TABLE `boarding_gates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booking` (
  `booking_id` int(11) NOT NULL AUTO_INCREMENT,
  `flight_id` int(11) DEFAULT NULL,
  `name` varchar(7) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `cost` int(11) DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  PRIMARY KEY (`booking_id`),
  KEY `flight_id` (`flight_id`),
  CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`flight_id`) REFERENCES `schedule` (`flight_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buses`
--

DROP TABLE IF EXISTS `buses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `buses` (
  `bus_id` int(11) NOT NULL,
  `airline_id` int(11) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `registrationNo` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`bus_id`),
  KEY `airline_id` (`airline_id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `buses_ibfk_1` FOREIGN KEY (`airline_id`) REFERENCES `groundStaff` (`airline_id`),
  CONSTRAINT `buses_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `groundStaff` (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buses`
--

LOCK TABLES `buses` WRITE;
/*!40000 ALTER TABLE `buses` DISABLE KEYS */;
INSERT INTO `buses` VALUES (1,1,40,3569,1),(2,2,45,1980,3),(3,2,45,2310,5),(4,3,38,4578,3),(5,4,40,6894,3),(6,5,32,2141,3),(7,5,35,1258,5),(8,6,40,964,3),(9,7,50,8965,3),(10,8,40,219,3),(11,8,35,2157,4);
/*!40000 ALTER TABLE `buses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cabincrew`
--

DROP TABLE IF EXISTS `cabincrew`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cabincrew` (
  `crew_id` int(11) NOT NULL,
  `airline_id` int(11) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `salary` int(11) DEFAULT NULL,
  PRIMARY KEY (`crew_id`,`airline_id`),
  KEY `airline_id` (`airline_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cabincrew`
--

LOCK TABLES `cabincrew` WRITE;
/*!40000 ALTER TABLE `cabincrew` DISABLE KEYS */;
INSERT INTO `cabincrew` VALUES (1,1,'Illena',22,25000),(1,2,'Pinky',25,17000),(1,3,'Akhil',21,27000),(1,4,'Sahil',21,17000),(1,5,'Diksha',24,27000),(1,6,'Akshita',22,19000),(1,7,'Rima',32,39000),(1,8,'Riya',19,17000),(2,1,'Olivia',24,23000),(2,2,'Surbhi',24,13000),(2,3,'Ashwarya',20,16000),(2,4,'Muskan',24,19000),(2,5,'Khushi',20,19000),(2,6,'Tanya',20,25000),(2,7,'Garima',22,15000),(2,8,'Sahithi',21,15000),(3,1,'Eigrid',27,20000),(3,3,'Addy',19,22000),(3,4,'Sushma',29,27000),(3,5,'Swaraj',29,27000),(3,7,'Rithika',19,15000),(3,8,'Rhonda',19,15000),(4,3,'Shalini',21,23000),(4,5,'Yashi',21,23000);
/*!40000 ALTER TABLE `cabincrew` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger add_crew after insert on cabincrew 
for each row
begin
update airlines set no_staff = no_staff + 1 where airline_id = new.airline_id;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary table structure for view `crew_view`
--

DROP TABLE IF EXISTS `crew_view`;
/*!50001 DROP VIEW IF EXISTS `crew_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `crew_view` AS SELECT 
 1 AS `name`,
 1 AS `age`,
 1 AS `airline`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `fare`
--

DROP TABLE IF EXISTS `fare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fare` (
  `airline_id` int(11) NOT NULL,
  `destination` varchar(10) NOT NULL,
  `fare` int(11) DEFAULT NULL,
  PRIMARY KEY (`airline_id`,`destination`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fare`
--

LOCK TABLES `fare` WRITE;
/*!40000 ALTER TABLE `fare` DISABLE KEYS */;
INSERT INTO `fare` VALUES (1,'Ahmedabad',3500),(1,'Bangalore',8500),(1,'Chennai',9000),(1,'Delhi',8700),(1,'Hyderabad',9800),(1,'Kolkata',5150),(1,'Mumbai',7300),(2,'Ahmedabad',4500),(2,'Bangalore',5500),(2,'Chennai',10000),(2,'Delhi',7200),(2,'Hyderabad',6800),(2,'Kolkata',5850),(2,'Mumbai',6300),(3,'Ahmedabad',6500),(3,'Bangalore',8600),(3,'Chennai',11000),(3,'Delhi',9050),(3,'Hyderabad',7800),(3,'Kolkata',9850),(3,'Mumbai',8300),(4,'Ahmedabad',2500),(4,'Bangalore',6600),(4,'Chennai',7000),(4,'Delhi',5950),(4,'Hyderabad',5800),(4,'Kolkata',3850),(4,'Mumbai',5300),(5,'Ahmedabad',5500),(5,'Bangalore',7600),(5,'Chennai',5500),(5,'Delhi',7980),(5,'Hyderabad',3800),(5,'Kolkata',5850),(5,'Mumbai',4300),(6,'Ahmedabad',1500),(6,'Bangalore',6200),(6,'Chennai',7500),(6,'Delhi',5950),(6,'Hyderabad',10800),(6,'Kolkata',5050),(6,'Mumbai',7300),(7,'Ahmedabad',2550),(7,'Bangalore',6950),(7,'Chennai',4900),(7,'Delhi',9500),(7,'Hyderabad',8100),(7,'Kolkata',3950),(7,'Mumbai',4700),(8,'Ahmedabad',3500),(8,'Bangalore',6050),(8,'Chennai',7980),(8,'Delhi',10780),(8,'Hyderabad',8950),(8,'Kolkata',5950),(8,'Mumbai',6700);
/*!40000 ALTER TABLE `fare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groundStaff`
--

DROP TABLE IF EXISTS `groundStaff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groundStaff` (
  `staff_id` int(11) NOT NULL,
  `airline_id` int(11) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `work` varchar(20) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `salary` int(11) DEFAULT NULL,
  PRIMARY KEY (`staff_id`,`airline_id`),
  KEY `airline_id` (`airline_id`),
  CONSTRAINT `groundStaff_ibfk_1` FOREIGN KEY (`airline_id`) REFERENCES `airlines` (`airline_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groundStaff`
--

LOCK TABLES `groundStaff` WRITE;
/*!40000 ALTER TABLE `groundStaff` DISABLE KEYS */;
INSERT INTO `groundStaff` VALUES (1,1,'Harry','driver',31,50000),(1,2,'Tyler','operations',32,23000),(1,3,'Cory','operations',29,53000),(1,4,'Coby','operations',39,47000),(1,5,'Matt','operations',49,67000),(1,6,'Matthew','operations',33,47000),(1,7,'Callum','operations',31,47000),(1,8,'Lucas','operations',37,38000),(2,1,'Bobby','luggage loader',24,42000),(2,2,'Keith','luggage loader',29,12000),(2,3,'Noah','luggage loader',21,22000),(2,4,'Shyane','luggage loader',22,17000),(2,5,'Wes','luggage loader',27,27000),(2,6,'Joven','luggage loader',27,17000),(2,7,'Mari','luggage loader',19,27000),(2,8,'Mari','luggage loader',19,27000),(3,1,'James','operations',45,29000),(3,2,'Jamey','driver',45,21000),(3,3,'Garett','driver',35,20000),(3,4,'Gary','driver',35,20000),(3,5,'Holmes','driver',25,10000),(3,6,'Watson','driver',20,20000),(3,7,'Leo','driver',29,19000),(3,8,'Reese','driver',39,29000),(4,1,'Charlie','signaling',23,60000),(4,2,'Chloe','signaling',27,40000),(4,5,'Choze','signaling',37,12000),(4,8,'Kony','driver',27,20000),(5,2,'Cody','driver',35,18000),(5,5,'Courtney','driver',25,18000),(6,5,'Oscar','luggage loader',31,27000);
/*!40000 ALTER TABLE `groundStaff` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger add_groundStaff after insert on groundStaff 
for each row
begin
update airlines set no_staff = no_staff + 1 where airline_id = new.airline_id;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `hangars`
--

DROP TABLE IF EXISTS `hangars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hangars` (
  `hangar_id` int(11) NOT NULL,
  `airplane_id` int(11) DEFAULT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`hangar_id`,`time`),
  KEY `airplane_id` (`airplane_id`),
  CONSTRAINT `hangars_ibfk_1` FOREIGN KEY (`airplane_id`) REFERENCES `airplanes` (`airplane_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hangars`
--

LOCK TABLES `hangars` WRITE;
/*!40000 ALTER TABLE `hangars` DISABLE KEYS */;
INSERT INTO `hangars` VALUES (1,1,'2019-11-08 12:00:00');
/*!40000 ALTER TABLE `hangars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pilot`
--

DROP TABLE IF EXISTS `pilot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pilot` (
  `pilot_id` int(11) NOT NULL,
  `airline_id` int(11) NOT NULL,
  `name` varchar(15) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `salary` int(11) DEFAULT NULL,
  PRIMARY KEY (`pilot_id`,`airline_id`),
  KEY `airline_id` (`airline_id`),
  CONSTRAINT `pilot_ibfk_1` FOREIGN KEY (`airline_id`) REFERENCES `airlines` (`airline_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pilot`
--

LOCK TABLES `pilot` WRITE;
/*!40000 ALTER TABLE `pilot` DISABLE KEYS */;
INSERT INTO `pilot` VALUES (1,1,'Martin',31,6800000),(1,2,'Mary',25,800000),(1,3,'Vibhav',35,370000),(1,4,'Abhishek',25,920000),(1,5,'Jaanish',35,420000),(1,6,'Ritwik',35,220000),(1,7,'Nitin',45,120000),(1,8,'Akshiti',25,420000),(2,1,'Bob',27,430000),(2,2,'Raghav',37,350000),(2,3,'Raghav',47,350000),(2,4,'Atharva',29,1090000),(2,5,'Anish',59,190000),(2,6,'Arpit',29,690000),(2,7,'Megha',39,610000),(2,8,'Shivani',29,310000),(3,1,'Tom',42,120000),(3,2,'Madhav',30,720000),(3,3,'Avirat',25,120000),(3,4,'Alyona',31,240000),(3,5,'Zander',41,440000),(3,6,'Cynthia',31,540000),(3,8,'Rohit',31,282000),(4,1,'Brady',26,508000),(4,2,'Yash',26,510000),(4,3,'Udit',36,290000),(4,4,'Abhinav',46,340000),(4,5,'Vansh',26,310000),(5,1,'John',39,620000),(5,2,'John',49,680000),(5,3,'Arjun',29,680000),(5,4,'Bhavya',25,230000),(5,5,'Tilak',25,230000);
/*!40000 ALTER TABLE `pilot` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger add_pilot after insert on pilot 
for each row
begin
update airlines set no_staff = no_staff + 1 where airline_id = new.airline_id;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary table structure for view `pilot_view`
--

DROP TABLE IF EXISTS `pilot_view`;
/*!50001 DROP VIEW IF EXISTS `pilot_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `pilot_view` AS SELECT 
 1 AS `name`,
 1 AS `age`,
 1 AS `airline`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedule` (
  `flight_id` int(11) NOT NULL,
  `airplane_id` int(11) DEFAULT NULL,
  `airline_id` int(11) DEFAULT NULL,
  `pilot_id` int(11) DEFAULT NULL,
  `destination` varchar(10) DEFAULT NULL,
  `departure` datetime DEFAULT NULL,
  `base_fare` int(11) DEFAULT NULL,
  `fill` int(11) DEFAULT NULL,
  `bus_id` int(11) DEFAULT NULL,
  `boarding_gate` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`flight_id`),
  KEY `bus_id` (`bus_id`),
  KEY `airline_id` (`airline_id`),
  KEY `pilot_id` (`pilot_id`),
  KEY `airplane_id` (`airplane_id`),
  CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`bus_id`) REFERENCES `buses` (`bus_id`),
  CONSTRAINT `schedule_ibfk_2` FOREIGN KEY (`airline_id`) REFERENCES `pilot` (`airline_id`),
  CONSTRAINT `schedule_ibfk_3` FOREIGN KEY (`pilot_id`) REFERENCES `pilot` (`pilot_id`),
  CONSTRAINT `schedule_ibfk_4` FOREIGN KEY (`airplane_id`) REFERENCES `airplanes` (`airplane_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule`
--

LOCK TABLES `schedule` WRITE;
/*!40000 ALTER TABLE `schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger schedule_check before insert on schedule
for each row
begin
declare d datetime;
set d = CURDATE();
if(new.departure < d) then
signal sqlstate '45000' set message_text = 'Cannot schedule the flight in past';
end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary table structure for view `schedule_view`
--

DROP TABLE IF EXISTS `schedule_view`;
/*!50001 DROP VIEW IF EXISTS `schedule_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `schedule_view` AS SELECT 
 1 AS `flight_id`,
 1 AS `airline`,
 1 AS `destination`,
 1 AS `availibility`,
 1 AS `fare`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `security`
--

DROP TABLE IF EXISTS `security`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security` (
  `security_id` int(11) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `post` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`security_id`),
  KEY `post` (`post`),
  CONSTRAINT `security_ibfk_1` FOREIGN KEY (`post`) REFERENCES `workHours` (`post`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security`
--

LOCK TABLES `security` WRITE;
/*!40000 ALTER TABLE `security` DISABLE KEYS */;
INSERT INTO `security` VALUES (1,'Prabhat',31,'Gates'),(2,'Kaushik',27,'Gates'),(3,'Ribhav',38,'S_check'),(4,'Manik',35,'S_check'),(5,'Tushar',26,'S_check'),(6,'Arya',33,'Bunker'),(7,'Tanav',32,'S_check'),(8,'Shrijit',29,'Gates'),(9,'Shenoy',31,'Parking'),(10,'Ranjan',28,'Patrol'),(11,'Maitriya',32,'Patrol'),(12,'Swapnil',29,'Patrol');
/*!40000 ALTER TABLE `security` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staffContact`
--

DROP TABLE IF EXISTS `staffContact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staffContact` (
  `airline_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `phone` int(11) NOT NULL,
  PRIMARY KEY (`airline_id`,`staff_id`,`phone`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `staffContact_ibfk_1` FOREIGN KEY (`airline_id`) REFERENCES `groundStaff` (`airline_id`),
  CONSTRAINT `staffContact_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `groundStaff` (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staffContact`
--

LOCK TABLES `staffContact` WRITE;
/*!40000 ALTER TABLE `staffContact` DISABLE KEYS */;
/*!40000 ALTER TABLE `staffContact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `staff_view`
--

DROP TABLE IF EXISTS `staff_view`;
/*!50001 DROP VIEW IF EXISTS `staff_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `staff_view` AS SELECT 
 1 AS `name`,
 1 AS `age`,
 1 AS `airline`,
 1 AS `work`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `ticket_booking`
--

DROP TABLE IF EXISTS `ticket_booking`;
/*!50001 DROP VIEW IF EXISTS `ticket_booking`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `ticket_booking` AS SELECT 
 1 AS `flight_id`,
 1 AS `seats`,
 1 AS `airline`,
 1 AS `destination`,
 1 AS `departure`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `airline_id` int(11) DEFAULT NULL,
  `username` varchar(32) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(32) NOT NULL,
  `token` varchar(32) DEFAULT NULL,
  `access` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_users_1_idx` (`airline_id`),
  CONSTRAINT `fk_users_1` FOREIGN KEY (`airline_id`) REFERENCES `airlines` (`airline_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,'test','test@gmail.com','test123','54d7840782ecfa9b',1,'2019-11-08 13:12:30','2019-11-08 13:12:30'),(2,1,'admin','admin@gmail.com','admin123','123',2,'2019-11-08 12:33:23','2019-11-08 12:33:23');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workHours`
--

DROP TABLE IF EXISTS `workHours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workHours` (
  `post` varchar(8) NOT NULL,
  `hours` float DEFAULT NULL,
  PRIMARY KEY (`post`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workHours`
--

LOCK TABLES `workHours` WRITE;
/*!40000 ALTER TABLE `workHours` DISABLE KEYS */;
INSERT INTO `workHours` VALUES ('Bunker',4.5),('Gates',2),('Parking',8),('Patrol',3),('S_check',2.5);
/*!40000 ALTER TABLE `workHours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'Airport'
--
/*!50003 DROP FUNCTION IF EXISTS `scheduledFlights` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `scheduledFlights`() RETURNS int(11)
begin
declare ctr int;
declare d date;
set d = CURDATE();
select count(*) into ctr from schedule where date(departure) = d;
return ctr;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_booking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_booking`(in bid int)
begin
declare fid int;
declare exit handler for SQLException select 'Booking deletion unsuccessful, try again' as Message;
select flight_id into fid from booking where booking_id = bid;
delete from booking where booking_id = bid;
update schedule set fill = fill + 1 where flight_id = fid;
select 'Booking deleted' as Message;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `remove_flights` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_flights`()
begin
declare fid int;
declare isDone int;
declare d datetime;
declare currentD datetime;
declare flightTime cursor for select flight_id,departure from schedule;
declare continue handler for not found 
begin
set isDone = 1;
select 'Table up-to-date' as Message;
end;
set currentD = current_timestamp();
set isDone = 0;
open flightTime;
get_schedule:loop
fetch flightTime into fid,d;
if (isDone = 1) then
leave get_schedule;
end if;
if(d < currentD) then
delete from schedule where flight_id = fid;
end if;
end loop get_schedule;
close flightTime;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `schedule_flight` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `schedule_flight`(in aid int, in apid int, in bid int, in pid int, in dest varchar(10), in dep datetime, in bg varchar(2))
begin
declare fid int;
declare cost int;
declare cap int;
declare exit handler for SQLException
begin
select 'Flight not scheduled' as Message;
rollback;
end;
select max(flight_id)+1 into fid from schedule;
if(fid is null) then
set fid = 1;
end if;
select capacity into cap from airplanes where airplane_id = apid;
select fare into cost from fare where airline_id = aid and destination = dest;
insert into schedule values(fid,apid,aid,pid,dest,dep,cost,cap,bid,bg);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `schedule_hangar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `schedule_hangar`(in hid int, in aid int, in d datetime)
begin
declare exit handler for SQLException
begin
select 'Hangar already busy' as Message;
rollback;
end;
if((select count(*) from hangars where hangar_id = hid and time between DATE_SUB(d,INTERVAL 8 hour) and d) > 0) then
signal SQLState '45000';
else
insert into hangars values(hid,aid,d);
select 'Hangar scheduled' as Message;
end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ticket_booking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ticket_booking`(in fid int, in n varchar(7), in age int, in phone int)
begin
declare f int;
declare c int;
declare Exit handler for SQLException 
begin
select 'Booking unsuccessful, try again' as Message;
rollback;
end;
select fill into f from schedule where flight_id = fid limit 1;
select base_fare into c from schedule where flight_id = fid limit 1;
if (seats > 0 and seats <= f) then
update schedule set fill = fill - 1 where fid = flight_id;
set c = c * 1.17;
insert into booking values(fid,n,age,phone,c);
select 'Booking successfull' as Message;
else
select 'No seats left' as Message;
end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `crew_view`
--

/*!50001 DROP VIEW IF EXISTS `crew_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `crew_view` AS select `cabincrew`.`name` AS `name`,`cabincrew`.`age` AS `age`,`airlines`.`name` AS `airline` from (`cabincrew` join `airlines`) where (`cabincrew`.`airline_id` = `airlines`.`airline_id`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `pilot_view`
--

/*!50001 DROP VIEW IF EXISTS `pilot_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `pilot_view` AS select `pilot`.`name` AS `name`,`pilot`.`age` AS `age`,`airlines`.`name` AS `airline` from (`pilot` join `airlines`) where (`pilot`.`airline_id` = `airlines`.`airline_id`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `schedule_view`
--

/*!50001 DROP VIEW IF EXISTS `schedule_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `schedule_view` AS (select `schedule`.`flight_id` AS `flight_id`,`airlines`.`name` AS `airline`,`schedule`.`destination` AS `destination`,`schedule`.`fill` AS `availibility`,`schedule`.`base_fare` AS `fare` from (`schedule` join `airlines`) where (`airlines`.`airline_id` = `schedule`.`airline_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `staff_view`
--

/*!50001 DROP VIEW IF EXISTS `staff_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `staff_view` AS (select `groundStaff`.`name` AS `name`,`groundStaff`.`age` AS `age`,`airlines`.`name` AS `airline`,`groundStaff`.`work` AS `work` from (`groundStaff` join `airlines`) where (`groundStaff`.`airline_id` = `airlines`.`airline_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ticket_booking`
--

/*!50001 DROP VIEW IF EXISTS `ticket_booking`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ticket_booking` AS (select `schedule`.`flight_id` AS `flight_id`,`schedule`.`fill` AS `seats`,`airlines`.`name` AS `airline`,`schedule`.`destination` AS `destination`,`schedule`.`departure` AS `departure` from (`schedule` join `airlines`) where (`airlines`.`airline_id` = `schedule`.`airline_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-08 19:51:16
