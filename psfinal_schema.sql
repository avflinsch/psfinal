-- MySQL dump 10.13  Distrib 5.7.9, for osx10.9 (x86_64)
--
-- Host: localhost    Database: psfinal
-- ------------------------------------------------------
-- Server version	5.7.9

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
-- Table structure for table `business`
--

DROP TABLE IF EXISTS `business`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business` (
  `business_id` varchar(22) CHARACTER SET utf8 NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `review_count` int(11) DEFAULT NULL,
  `stars` decimal(4,2) DEFAULT NULL,
  `latitude` decimal(20,17) DEFAULT NULL,
  `longitude` decimal(20,17) DEFAULT NULL,
  `city` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `state` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `full_address` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_open` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`business_id`),
  UNIQUE KEY `business_id_UNIQUE` (`business_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `business_categories`
--

DROP TABLE IF EXISTS `business_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business_categories` (
  `business_id` varchar(22) CHARACTER SET utf8 DEFAULT NULL,
  `category` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `idx_buscat_business` (`business_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `checkins`
--

DROP TABLE IF EXISTS `checkins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `checkins` (
  `business_id` varchar(22) CHARACTER SET utf8 DEFAULT NULL,
  `checkin_id` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checkins` int(11) DEFAULT NULL,
  `day_of_week` int(11) DEFAULT NULL,
  `hour_of_day` int(11) DEFAULT NULL,
  KEY `idx_check_business` (`business_id`),
  KEY `idx_check_bus_chk` (`business_id`,`checkin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `compliments`
--

DROP TABLE IF EXISTS `compliments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compliments` (
  `user_id` varchar(22) CHARACTER SET utf8 DEFAULT NULL,
  `compliment_id` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `compliment_count` int(11) DEFAULT NULL,
  KEY `idx_compliment_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `friends`
--

DROP TABLE IF EXISTS `friends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friends` (
  `user_id` varchar(22) CHARACTER SET utf8 DEFAULT NULL,
  `friend_id` varchar(22) CHARACTER SET utf8 DEFAULT NULL,
  KEY `idx_friend_user` (`user_id`),
  KEY `idx_friend_friend` (`friend_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reviews` (
  `business_id` varchar(22) CHARACTER SET utf8 DEFAULT NULL,
  `user_id` varchar(22) CHARACTER SET utf8 DEFAULT NULL,
  `stars` decimal(5,2) DEFAULT NULL,
  `funny_count` int(11) DEFAULT NULL,
  `useful_count` int(11) DEFAULT NULL,
  `cool_count` int(11) DEFAULT NULL,
  `text` varchar(8000) CHARACTER SET utf8 DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  KEY `idx_review_Business` (`business_id`),
  KEY `idx_review_User` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tips`
--

DROP TABLE IF EXISTS `tips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tips` (
  `business_id` varchar(22) CHARACTER SET utf8 DEFAULT NULL,
  `user_id` varchar(22) CHARACTER SET utf8 DEFAULT NULL,
  `likes` int(11) DEFAULT NULL,
  `text` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  KEY `idx_tips_business` (`business_id`),
  KEY `idx_tips_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_elite`
--

DROP TABLE IF EXISTS `user_elite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_elite` (
  `user_id` varchar(22) CHARACTER SET utf8 DEFAULT NULL,
  `year_elite` int(11) DEFAULT NULL,
  KEY `idx_userelite_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` varchar(22) CHARACTER SET utf8 NOT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `review_count` int(11) DEFAULT NULL,
  `average_stars` decimal(5,2) DEFAULT NULL,
  `yelping_since` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `funny_count` int(11) DEFAULT NULL,
  `useful_count` int(11) DEFAULT NULL,
  `cool_count` int(11) DEFAULT NULL,
  `friend_count` int(11) DEFAULT NULL,
  `fan_count` int(11) DEFAULT NULL,
  `elite_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-05 17:12:21
