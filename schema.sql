-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: 2023mocopolicedatabase
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `agency`
--

DROP TABLE IF EXISTS `agency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agency` (
  `agency_id` int unsigned NOT NULL AUTO_INCREMENT,
  `agency_name` varchar(10) NOT NULL,
  PRIMARY KEY (`agency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `district`
--

DROP TABLE IF EXISTS `district`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `district` (
  `district_id` int unsigned NOT NULL AUTO_INCREMENT,
  `district_name` varchar(45) DEFAULT NULL,
  `district_number` varchar(45) DEFAULT NULL,
  `sector` varchar(45) DEFAULT NULL,
  `beat` varchar(45) DEFAULT NULL,
  `PRA` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`district_id`)
) ENGINE=InnoDB AUTO_INCREMENT=998 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incident`
--

DROP TABLE IF EXISTS `incident`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incident` (
  `incident_id` int unsigned NOT NULL AUTO_INCREMENT,
  `location_id` int unsigned NOT NULL,
  `agency_id` int unsigned NOT NULL,
  `place_id` int unsigned NOT NULL,
  `cr_number` varchar(45) NOT NULL,
  `victims` int unsigned NOT NULL DEFAULT '0',
  `Start_Date_Time` datetime DEFAULT NULL,
  `End_Date_Time` datetime DEFAULT NULL,
  PRIMARY KEY (`incident_id`),
  UNIQUE KEY `cr_number_UNIQUE` (`cr_number`),
  KEY `fk_Incident_Location1_idx` (`location_id`),
  KEY `fk_Incident_Agency1_idx` (`agency_id`),
  KEY `fk_Incident_Place1_idx` (`place_id`),
  CONSTRAINT `fk_Incident_Agency1` FOREIGN KEY (`agency_id`) REFERENCES `agency` (`agency_id`),
  CONSTRAINT `fk_Incident_Location1` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `fk_Incident_Place1` FOREIGN KEY (`place_id`) REFERENCES `place` (`place_id`)
) ENGINE=InnoDB AUTO_INCREMENT=201408355 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incidentoffense`
--

DROP TABLE IF EXISTS `incidentoffense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incidentoffense` (
  `offense_id` int unsigned NOT NULL,
  `incident_id` int unsigned NOT NULL,
  PRIMARY KEY (`offense_id`,`incident_id`),
  KEY `fk_Offense_has_Incident_Incident1_idx` (`incident_id`),
  KEY `fk_Offense_has_Incident_Offense_idx` (`offense_id`),
  CONSTRAINT `fk_Offense_has_Incident_Incident1` FOREIGN KEY (`incident_id`) REFERENCES `incident` (`incident_id`),
  CONSTRAINT `fk_Offense_has_Incident_Offense` FOREIGN KEY (`offense_id`) REFERENCES `offense` (`offense_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location` (
  `location_id` int unsigned NOT NULL AUTO_INCREMENT,
  `district_id` int unsigned NOT NULL,
  `block_address` varchar(200) NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(45) NOT NULL,
  `zip_code` varchar(20) DEFAULT NULL,
  `street_number` varchar(45) DEFAULT NULL,
  `street_prefix` varchar(45) DEFAULT NULL,
  `street_name` varchar(100) NOT NULL,
  `street_suffix` varchar(20) NOT NULL,
  `street_type` varchar(45) DEFAULT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  PRIMARY KEY (`location_id`),
  KEY `fk_Location_District1_idx` (`district_id`),
  CONSTRAINT `fk_Location_District1` FOREIGN KEY (`district_id`) REFERENCES `district` (`district_id`)
) ENGINE=InnoDB AUTO_INCREMENT=65885 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `offense`
--

DROP TABLE IF EXISTS `offense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offense` (
  `offense_id` int unsigned NOT NULL AUTO_INCREMENT,
  `offense_code` varchar(20) NOT NULL,
  `NIBRS_code` varchar(20) NOT NULL,
  `crime_against` varchar(100) NOT NULL,
  `crime_name` varchar(100) NOT NULL,
  `crime_category` varchar(100) NOT NULL,
  PRIMARY KEY (`offense_id`),
  UNIQUE KEY `Offense_code_UNIQUE` (`offense_code`)
) ENGINE=InnoDB AUTO_INCREMENT=344 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `place`
--

DROP TABLE IF EXISTS `place`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `place` (
  `place_id` int unsigned NOT NULL AUTO_INCREMENT,
  `place_name` varchar(45) NOT NULL,
  `place_category` varchar(45) DEFAULT NULL,
  `place_description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`place_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-28 12:17:19
