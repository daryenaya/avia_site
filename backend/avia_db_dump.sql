-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: avia_db
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS `flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight` (
  `flightID` int NOT NULL AUTO_INCREMENT,
  `departureDate` date NOT NULL,
  `arrivalDate` date NOT NULL,
  `departureFrom` varchar(50) NOT NULL,
  `destinationTo` varchar(50) NOT NULL,
  `availableSeats` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `flightNumber` varchar(10) NOT NULL,
  `tariffID` int DEFAULT NULL,
  PRIMARY KEY (`flightID`),
  KEY `tariffID` (`tariffID`),
  CONSTRAINT `flight_ibfk_1` FOREIGN KEY (`tariffID`) REFERENCES `tariff` (`tariffID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight`
--

LOCK TABLES `flight` WRITE;
/*!40000 ALTER TABLE `flight` DISABLE KEYS */;
INSERT INTO `flight` VALUES (1,'2025-04-10','2025-04-10','╨г╨╗╤М╤П╨╜╨╛╨▓╤Б╨║','╨б╨░╨╜╨║╤В-╨Я╨╡╤В╨╡╤А╨▒╤Г╤А╨│',18,5000.00,'SU101',1),(2,'2025-05-05','2025-05-05','╨Ь╨╛╤Б╨║╨▓╨░','╨г╨╗╤М╤П╨╜╨╛╨▓╤Б╨║',15,8000.00,'SU202',2),(3,'2025-06-15','2025-06-15','╨г╨╗╤М╤П╨╜╨╛╨▓╤Б╨║','╨Ъ╤А╨░╤Б╨╜╨╛╨┤╨░╤А',10,15000.00,'SU303',3),(4,'2025-07-20','2025-07-20','╨б╨╛╤З╨╕','╨г╨╗╤М╤П╨╜╨╛╨▓╤Б╨║',9,25000.00,'SU404',4),(5,'2025-08-01','2025-08-01','╨г╨╗╤М╤П╨╜╨╛╨▓╤Б╨║','╨Ъ╨░╨╗╨╕╨╜╨╕╨╜╨│╤А╨░╨┤',6,12000.00,'SU505',5),(6,'2025-09-08','2025-09-08','╨б╨╕╨╝╤Д╨╡╤А╨╛╨┐╨╛╨╗╤М','╨г╨╗╤М╤П╨╜╨╛╨▓╤Б╨║',13,10000.00,'SU606',6),(7,'2025-10-12','2025-10-12','╨г╨╗╤М╤П╨╜╨╛╨▓╤Б╨║','╨Ь╨╛╤Б╨║╨▓╨░',20,4500.00,'SU707',7),(8,'2025-11-25','2025-11-25','╨г╨╗╤М╤П╨╜╨╛╨▓╤Б╨║','╨а╨╛╤Б╤В╨╛╨▓-╨╜╨░-╨Ф╨╛╨╜╤Г',17,4000.00,'SU808',8),(9,'2025-12-05','2025-12-05','╨г╨╗╤М╤П╨╜╨╛╨▓╤Б╨║','╨Т╨╗╨░╨┤╨╕╨▓╨╛╤Б╤В╨╛╨║',8,20000.00,'SU909',9),(10,'2025-12-20','2025-12-20','╨Ь╨╕╨╜╤Б╨║','╨г╨╗╤М╤П╨╜╨╛╨▓╤Б╨║',16,3000.00,'SU1010',10);
/*!40000 ALTER TABLE `flight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (2,'admin_aviator','╨╜╨╡ ╤А╨░╨▒╨╛╤В╨░╨╡╤В ╨║╨╜╨╛╨┐╨║╨░ ╨Ч╨░╨║╨░╨╖╨░╤В╤М ╨▒╨╕╨╗╨╡╤В╤Л ╨╜╨░ ╨│╨╗╨░╨▓╨╜╨╛╨╣ ╤Б╤В╤А╨░╨╜╨╕╤Ж╨╡','2025-03-12 20:43:06'),(3,'nikolay_rybkin','╨╜╨╡ ╤А╨░╨▒╨╛╤В╨░╨╡╤В ╨▓╨║╨╗╨░╨┤╨║╨░ ╤А╨╡╨╣╤Б╤Л, ╨╛╤В╨║╤А╤Л╨▓╨░╨╡╤В╤Б╤П ╤Б╤В╤А╨░╨╜╨╕╤Ж╨░ ╨╛╤И╨╕╨▒╨║╨╕','2025-03-13 15:48:43');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotions`
--

DROP TABLE IF EXISTS `promotions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promotions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  `promoImage` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotions`
--

LOCK TABLES `promotions` WRITE;
/*!40000 ALTER TABLE `promotions` DISABLE KEYS */;
INSERT INTO `promotions` VALUES (1,'╨б╨║╨╕╨┤╨║╨░ 20% ╨╜╨░ ╨░╤А╨╡╨╜╨┤╤Г ╨░╨▓╤В╨╛╨╝╨╛╨▒╨╕╨╗╤П','╨Я╤А╨╕ ╨░╤А╨╡╨╜╨┤╨╡ ╨░╨▓╤В╨╛╨╝╨╛╨▒╨╕╨╗╤П ╨╜╨░ ╨▒╨╛╨╗╨╡╨╡ ╤З╨╡╨╝ 3 ╨┤╨╜╤П ╨┐╤А╨╡╨┤╨╛╤Б╤В╨░╨▓╨╗╤П╨╡╤В╤Б╤П ╤Б╨║╨╕╨┤╨║╨░ 20%','2025-03-01','2025-06-01',1,'uploads/4-image.jpg'),(2,'╨С╨╡╤Б╨┐╨╗╨░╤В╨╜╨░╤П ╨┤╨╛╤Б╤В╨░╨▓╨║╨░ ╨▓╨░╤И╨╡╨│╨╛ ╨▒╨░╨│╨░╨╢╨░','╨Я╤А╨╕ ╨╖╨░╨║╨░╨╖╨╡ ╨▒╨╕╨╗╨╡╤В╨╛╨▓ ╨▓ VIP-╨╖╨░╨╗ ╨┤╨╛╤Б╤В╨░╨▓╨║╨░ ╨▒╨░╨│╨░╨╢╨░ ╨╛╤Б╤Г╤Й╨╡╤Б╤В╨▓╨╗╤П╨╡╤В╤Б╤П ╨▒╨╡╤Б╨┐╨╗╨░╤В╨╜╨╛','2025-05-01','2025-09-15',1,'uploads/5-image.jpg'),(3,'╨С╨╡╤Б╨┐╨╗╨░╤В╨╜╤Л╨╣ ╨┤╨╛╤Б╤В╤Г╨┐ ╨▓ VIP-╨╖╨░╨╗ ╤Б╨░╨╝╨╛╨╗╨╡╤В╨░','╨Я╤А╨╕ ╨╖╨░╨║╨░╨╖╨╡ ╤А╨╡╨╣╤Б╨░ SU303, SU404 ╨╕ SU909 ╨▓╤Л ╨┐╨╛╨╗╤Г╤З╨░╨╡╤В╨╡ ╨▒╨╡╤Б╨┐╨╗╨░╤В╨╜╤Л╨╣ ╨┤╨╛╤Б╤В╤Г╨┐ ╨▓ VIP-╨╖╨░╨╗','2025-06-01','2025-06-15',1,'uploads/6-image.jpg'),(4,'╨Я╨╛╨┤╨░╤А╨╛╤З╨╜╤Л╨╡ ╤Б╨╡╤А╤В╨╕╤Д╨╕╨║╨░╤В╤Л ╨╕ ╤Б╨║╨╕╨┤╨║╨╕','╨Ъ╤Г╨┐╨╕╤В╨╡ ╨┐╨╛╨┤╨░╤А╨╛╤З╨╜╤Л╨╣ ╤Б╨╡╤А╤В╨╕╤Д╨╕╨║╨░╤В ╨╜╨░ ╨╜╨░╤И╨╕ ╤Г╤Б╨╗╤Г╨│╨╕ ╨╕ ╨┐╨╛╨╗╤Г╤З╨╕╤В╨╡ ╨▒╨╛╨╜╤Г╤Б ╨▓ 10% ╨╜╨░ ╤Б╨╗╨╡╨┤╤Г╤О╤Й╤Г╤О ╨┐╨╛╨║╤Г╨┐╨║╤Г','2025-03-01','2025-04-15',1,'uploads/7-image.jpg'),(5,'╨б╨║╨╕╨┤╨║╨╕ ╨▓ 10% ╨╜╨░ ╤Г╤Б╨╗╤Г╨│╨╕ ╤В╨░╨║╤Б╨╕ ╨▓╤Б╨╡╤Е ╤В╨░╤А╨╕╤Д╨╛╨▓','╨Я╤А╨╕ ╨╖╨░╨║╨░╨╖╨╡ ╤В╨░╨║╤Б╨╕ ╤З╨╡╤А╨╡╨╖ ╨╜╨░╤И ╤Б╨╡╤А╨▓╨╕╤Б ╨▓╤Л ╨┐╨╛╨╗╤Г╤З╨░╨╡╤В╨╡ ╤Б╨║╨╕╨┤╨║╤Г 15% ╨╜╨░ ╨┐╨╛╨╡╨╖╨┤╨║╨╕ ╨┐╨╛ ╨│╨╛╤А╨╛╨┤╤Г','2025-06-01','2025-06-15',1,'uploads/8-image.jpg'),(6,'╨Ф╨░╤А╨╕╨╝ ╨┐╨╛╨┤╨░╤А╨║╨╕ ╨┐╤А╨╕ ╨▒╤А╨╛╨╜╨╕╤А╨╛╨▓╨░╨╜╨╕╨╕ ╤Г╤Б╨╗╤Г╨│','╨Я╤А╨╕ ╨▒╤А╨╛╨╜╨╕╤А╨╛╨▓╨░╨╜╨╕╨╕ ╤Г╤Б╨╗╤Г╨│╨╕ ╨╜╨░ ╤Б╤Г╨╝╨╝╤Г ╨▒╨╛╨╗╨╡╨╡ 10 000 ╤А╤Г╨▒╨╗╨╡╨╣ ╨▓╤Л ╨┐╨╛╨╗╤Г╤З╨░╨╡╤В╨╡ ╨┐╨╛╨┤╨░╤А╨╛╨║ тАФ ╨╜╨░╨▒╨╛╤А ╨║╨╛╤Б╨╝╨╡╤В╨╕╨║╨╕','2025-01-01','2025-09-01',1,'uploads/9-image.jpg'),(7,'╨б╨┐╨╡╤Ж╨╕╨░╨╗╤М╨╜╤Л╨╡ ╨┐╤А╨╡╨┤╨╗╨╛╨╢╨╡╨╜╨╕╤П ╨┤╨╗╤П ╤Б╨╡╨╝╨╡╨╣╨╜╤Л╤Е ╨┐╨░╤А','╨б╨╡╨╝╤М╨╕, ╨┐╤Г╤В╨╡╤И╨╡╤Б╤В╨▓╤Г╤О╤Й╨╕╨╡ ╤Б ╨┤╨╡╤В╤М╨╝╨╕, ╨┐╨╛╨╗╤Г╤З╨░╤О╤В ╨▒╨╡╤Б╨┐╨╗╨░╤В╨╜╨╛╨╡ ╤Г╨╗╤Г╤З╤И╨╡╨╜╨╕╨╡ ╤Г╤Б╨╗╨╛╨▓╨╕╨╣ ╨┐╤А╨╛╨╢╨╕╨▓╨░╨╜╨╕╤П ╨▓ ╨╛╤В╨╡╨╗╨╡','2025-01-01','2025-06-01',1,'uploads/10-image.jpg'),(8,'╨б╨║╨╕╨┤╨║╨░ 30% ╨╜╨░ ╨▒╤А╨╛╨╜╨╕╤А╨╛╨▓╨░╨╜╨╕╨╡ ╨╛╤В╨╡╨╗╨╡╨╣','╨Я╤А╨╕ ╨▒╤А╨╛╨╜╨╕╤А╨╛╨▓╨░╨╜╨╕╨╕ ╨╛╤В╨╡╨╗╤П ╨╜╨░ 5 ╨╜╨╛╤З╨╡╨╣ ╨╕ ╨▒╨╛╨╗╨╡╨╡ тАФ ╤Б╨║╨╕╨┤╨║╨░ 30% ╨╜╨░ ╨▓╨╡╤Б╤М ╨┐╨╡╤А╨╕╨╛╨┤ ╨┐╤А╨╛╨╢╨╕╨▓╨░╨╜╨╕╤П','2025-06-01','2025-12-31',1,'uploads/11-image.jpg'),(9,'╨Ф╨░╤А╨╕╨╝ ╨┐╨╛╨┤╨░╤А╨║╨╕ ╨┐╤А╨╕ ╨▒╤А╨╛╨╜╨╕╤А╨╛╨▓╨░╨╜╨╕╨╕ ╤В╤Г╤А╨░','╨Я╨╛╨╗╤Г╤З╨╕╤В╨╡ ╨┐╨╛╨┤╨░╤А╨╛╨║ ╨┐╤А╨╕ ╨▒╤А╨╛╨╜╨╕╤А╨╛╨▓╨░╨╜╨╕╨╕ ╤В╤Г╤А╨┐╨░╨║╨╡╤В╨░ ╨╜╨░ 10 ╨┤╨╜╨╡╨╣ ╨╕ ╨▒╨╛╨╗╨╡╨╡','2025-06-01','2025-06-10',1,'uploads/12-image.jpg'),(10,'╨б╨║╨╕╨┤╨║╨░ 25% ╨╜╨░ ╤В╤Г╤А╤Л ╨┤╨╗╤П ╨┤╨▓╨╛╨╕╤Е','╨б╨║╨╕╨┤╨║╨░ 25% ╨╜╨░ ╤В╤Г╤А╤Л ╨┤╨╗╤П ╨┤╨▓╨╛╨╕╤Е ╨┐╤А╨╕ ╨▒╤А╨╛╨╜╨╕╤А╨╛╨▓╨░╨╜╨╕╨╕ ╤З╨╡╤А╨╡╨╖ ╨╜╨░╤И ╤Б╨░╨╣╤В ╨▓ ╤В╨╡╤З╨╡╨╜╨╕╨╡ ╨╜╨╡╨┤╨╡╨╗╨╕','2025-06-02','2025-06-09',1,'uploads/13-image.jpg');
/*!40000 ALTER TABLE `promotions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `roleID` int NOT NULL AUTO_INCREMENT,
  `roleName` varchar(50) NOT NULL,
  `description` text,
  PRIMARY KEY (`roleID`),
  UNIQUE KEY `roleName` (`roleName`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'╨Я╨╛╨╗╤М╨╖╨╛╨▓╨░╤В╨╡╨╗╤М','╨Ю╨▒╤Л╤З╨╜╤Л╨╣ ╨┐╨╛╨╗╤М╨╖╨╛╨▓╨░╤В╨╡╨╗╤М ╤Б ╨▓╨╛╨╖╨╝╨╛╨╢╨╜╨╛╤Б╤В╤М╤О ╨▒╤А╨╛╨╜╨╕╤А╨╛╨▓╨░╨╜╨╕╤П ╨▒╨╕╨╗╨╡╤В╨╛╨▓'),(2,'╨Р╨┤╨╝╨╕╨╜╨╕╤Б╤В╤А╨░╤В╨╛╤А','╨Р╨┤╨╝╨╕╨╜╨╕╤Б╤В╤А╨░╤В╨╛╤А ╤Б╨╕╤Б╤В╨╡╨╝╤Л ╤Б ╨┐╨╛╨╗╨╜╤Л╨╝ ╨┤╨╛╤Б╤В╤Г╨┐╨╛╨╝'),(3,'╨Ю╨┐╨╡╤А╨░╤В╨╛╤А','╨Ю╨┐╨╡╤А╨░╤В╨╛╤А ╨┐╨╛ ╤А╨░╨▒╨╛╤В╨╡ ╤Б ╨║╨╗╨╕╨╡╨╜╤В╨░╨╝╨╕ ╨╕ ╨▒╤А╨╛╨╜╨╕╤А╨╛╨▓╨░╨╜╨╕╤П╨╝'),(4,'VIP-╨┐╨╛╨╗╤М╨╖╨╛╨▓╨░╤В╨╡╨╗╤М','╨Я╤А╨╕╨▓╨╕╨╗╨╡╨│╨╕╤А╨╛╨▓╨░╨╜╨╜╤Л╨╣ ╨┐╨╛╨╗╤М╨╖╨╛╨▓╨░╤В╨╡╨╗╤М ╤Б ╨┤╨╛╨┐╨╛╨╗╨╜╨╕╤В╨╡╨╗╤М╨╜╤Л╨╝╨╕ ╤Г╤Б╨╗╤Г╨│╨░╨╝╨╕');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tariff`
--

DROP TABLE IF EXISTS `tariff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tariff` (
  `tariffID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`tariffID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tariff`
--

LOCK TABLES `tariff` WRITE;
/*!40000 ALTER TABLE `tariff` DISABLE KEYS */;
INSERT INTO `tariff` VALUES (1,'╨н╨║╨╛╨╜╨╛╨╝',5000.00),(2,'╨Ъ╨╛╨╝╤Д╨╛╤А╤В',8000.00),(3,'╨С╨╕╨╖╨╜╨╡╤Б',15000.00),(4,'╨Я╤А╨╡╨╝╨╕╤Г╨╝',25000.00),(5,'╨б╨╡╨╝╨╡╨╣╨╜╤Л╨╣',12000.00),(6,'╨У╨╕╨▒╨║╨╕╨╣ ╤В╨░╤А╨╕╤Д',10000.00),(7,'╨б╤В╤Г╨┤╨╡╨╜╤З╨╡╤Б╨║╨╕╨╣',4500.00),(8,'╨Я╨╡╨╜╤Б╨╕╨╛╨╜╨╜╤Л╨╣',4000.00),(9,'╨Ъ╨╛╤А╨┐╨╛╤А╨░╤В╨╕╨▓╨╜╤Л╨╣',20000.00),(10,'╨Р╨║╤Ж╨╕╨╛╨╜╨╜╤Л╨╣',3000.00);
/*!40000 ALTER TABLE `tariff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `userID` int NOT NULL AUTO_INCREMENT,
  `login` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `roleID` int DEFAULT NULL,
  `personalName` varchar(100) NOT NULL,
  `balancePoints` int DEFAULT '0',
  `totalMiles` int DEFAULT '0',
  `profileImage` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `login` (`login`),
  KEY `fk_role` (`roleID`),
  CONSTRAINT `fk_role` FOREIGN KEY (`roleID`) REFERENCES `roles` (`roleID`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'ivan_petrov','Ivan2024!',1,'╨Ш╨▓╨░╨╜ ╨Я╨╡╤В╤А╨╛╨▓',300,1500,'uploads/1_profile.jpg'),(2,'elena_sidorova','Elena@123',1,'╨Х╨╗╨╡╨╜╨░ ╨б╨╕╨┤╨╛╤А╨╛╨▓╨░',1200,2000,'uploads/2_profile.jpg'),(3,'admin_aviator','Admin2024',2,'╨Р╨┤╨╝╨╕╨╜ ╨г╨╗╤М╤П╨╜╨╛╨▓╤Б╨║',0,0,'uploads/3_profile.jpg'),(4,'alexey_ivanov','Aleksei$98',1,'╨Р╨╗╨╡╨║╤Б╨╡╨╣ ╨Ш╨▓╨░╨╜╨╛╨▓',500,1200,'uploads/4_profile.jpg'),(5,'olga_kuznetsova','Olga#999',4,'╨Ю╨╗╤М╨│╨░ ╨Ъ╤Г╨╖╨╜╨╡╤Ж╨╛╨▓╨░',18000,25000,'uploads/5_profile.jpg'),(6,'dmitry_volkov','Dmitry789',4,'╨Ф╨╝╨╕╤В╤А╨╕╨╣ ╨Т╨╛╨╗╨║╨╛╨▓',12000,30000,'uploads/6_profile.jpg'),(7,'sergey_smirnov','SergeyPass',3,'╨б╨╡╤А╨│╨╡╨╣ ╨б╨╝╨╕╤А╨╜╨╛╨▓',0,0,'uploads/7_profile.jpg'),(8,'anastasia_fedorova','Anastasia20',1,'╨Р╨╜╨░╤Б╤В╨░╤Б╨╕╤П ╨д╨╡╨┤╨╛╤А╨╛╨▓╨░',600,1000,'uploads/8_profile.jpg'),(9,'nikita_rybkin','NikitaRyb12',4,'╨Э╨╕╨║╨╕╤В╨░ ╨а╤Л╨▒╨║╨╕╨╜',10000,10000,'uploads/9_profile.jpg'),(10,'tatiana_koroleva','Tatiana#45',3,'╨в╨░╤В╤М╤П╨╜╨░ ╨Ъ╨╛╤А╨╛╨╗╨╡╨▓╨░',0,0,'uploads/10_profile.jpg');
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

-- Dump completed on 2025-04-03 19:41:50
