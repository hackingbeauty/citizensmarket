-- MySQL dump 10.11
--
-- Host: localhost    Database: citizensmarket_development
-- ------------------------------------------------------
-- Server version	5.0.67

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
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `brands` (
  `id` int(11) NOT NULL auto_increment,
  `name` text,
  `description` varchar(255) default NULL,
  `company_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `brands`
--

LOCK TABLES `brands` WRITE;
/*!40000 ALTER TABLE `brands` DISABLE KEYS */;
/*!40000 ALTER TABLE `brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `companies`
--

DROP TABLE IF EXISTS `companies`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `companies` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `stock_symbol` varchar(255) default NULL,
  `description` text,
  `info` text,
  `logo_url` varchar(255) default NULL,
  `website_url` varchar(255) default NULL,
  `google_cid` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `companies`
--

LOCK TABLES `companies` WRITE;
/*!40000 ALTER TABLE `companies` DISABLE KEYS */;
INSERT INTO `companies` VALUES (1,'Apple Inc.','','hey now, look at this company',NULL,NULL,'',NULL,'2008-12-17 20:09:32','2008-12-17 20:09:32'),(2,'Exxon Mobil Corporation','','A petroleum company',NULL,NULL,'',NULL,'2009-01-04 02:30:05','2009-01-04 02:30:05');
/*!40000 ALTER TABLE `companies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issues`
--

DROP TABLE IF EXISTS `issues`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `issues` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  `category` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `issues`
--

LOCK TABLES `issues` WRITE;
/*!40000 ALTER TABLE `issues` DISABLE KEYS */;
INSERT INTO `issues` VALUES (1,'Research & Development','(Renewable Energy, Sustainable Products & Services)','Environment','2008-12-17 20:05:17','2008-12-17 20:05:17'),(2,'Other','other issues not represented elsewhere',NULL,'2008-12-17 20:05:17','2008-12-17 20:05:17'),(3,'Conservation','(Materials Used, Recycling, Energy, Water, Transport)','Environment','2008-12-17 20:05:17','2008-12-17 20:05:17'),(4,'Emissions, Effluent & Waste Management','(Greenhouse Gas Emissions, Ozone Depletion, Solid Waste and Wastewater Disposal, Spills)','Environment','2008-12-17 20:05:17','2008-12-17 20:05:17'),(5,'Biodiversity','(Impact on Habitats and Protected Areas)','Environment','2008-12-17 20:05:17','2008-12-17 20:05:17'),(6,'Corruption & Bribery','(Illegal Influence: Incidences, Oversight, Training, Response)','Civil Society','2008-12-17 20:05:17','2008-12-17 20:05:17'),(7,'Public Policy','(Legal Influence: Lobbying, Political Contributions)','Civil Society','2008-12-17 20:05:17','2008-12-17 20:05:17'),(8,'Anti-Competitive Behavior','(Anti-Trust, Monopoly Practices)','Civil Society','2008-12-17 20:05:18','2008-12-17 20:05:18'),(9,'Executive Compensation','(Executive Pay & Benefits, Golden Parachutes)','Civil Society','2008-12-17 20:05:18','2008-12-17 20:05:18'),(10,'Investment & Procurement Practices','(Sustainability Screening for Suppliers and Investment Agreements, Employee Training) ','Civil Society','2008-12-17 20:05:18','2008-12-17 20:05:18'),(11,'Security Practices','(Operations in Conflict Zones, Complicity With Repressive Governments or Paramilitary Groups)','Civil Society','2008-12-17 20:05:18','2008-12-17 20:05:18'),(12,'Indigenous Rights','(Land Appropriations and Other Violations of Rights of Indigenous Peoples)','Civil Society','2008-12-17 20:05:18','2008-12-17 20:05:18'),(13,'Reporting & Disclosure','(Transparency, Quality of Corporate Citizenship Reports and Publicly Available Data)','Civil Society','2008-12-17 20:05:19','2008-12-17 20:05:19'),(14,'Economic Performance','(Money Generated & Distributed, Financial Assistance from Government)','Economic Development','2008-12-17 20:05:19','2008-12-17 20:05:19'),(15,'Market Presence','(Wages Compared to Local Minimum Wage, Use of Local Suppliers & Local Hires)','Economic Development','2008-12-17 20:05:19','2008-12-17 20:05:19'),(16,'Indirect Economic Impacts','(Infrastructure Development, Other Indirect Impacts)','Economic Development','2008-12-17 20:05:19','2008-12-17 20:05:19'),(17,'Employment Stability & Benefits','(Workforce Turnover, Family Benefits, Child Care, Retirement, Health Care, Profit Sharing)','Labor Practices','2008-12-17 20:05:20','2008-12-17 20:05:20'),(18,'Labor/Management Relations','(Unions, Freedom of Association and Collective Bargaining)','Labor Practices','2008-12-17 20:05:20','2008-12-17 20:05:20'),(19,'Occupational Health & Safety','(Injury & Fatality Rates, Prevention Measures)','Labor Practices','2008-12-17 20:05:20','2008-12-17 20:05:20'),(20,'Training & Education','(Performance Reviews, Professional Development, Managing Career Endings)','Labor Practices','2008-12-17 20:05:20','2008-12-17 20:05:20'),(21,'Diversity & Equal Opportunity','(Parity in Wages and Executive/Board Representation, Cultural Competence, for Minorities, Women, LGBT, People With Disabilities)','Labor Practices','2008-12-17 20:05:20','2008-12-17 20:05:20'),(22,'Forced, Compulsory or Child Labor','(Slavery, Human Trafficking, Child Labor)','Labor Practices','2008-12-17 20:05:20','2008-12-17 20:05:20'),(23,'Customer Health & Safety','(Quality Assurance, Consumer Illnesses/Injuries/Fatalities)','Product Responsibility','2008-12-17 20:05:20','2008-12-17 20:05:20'),(24,'Labeling & Marketing Communications','(Responsible Advertising, Consumer Information)','Product Responsibility','2008-12-17 20:05:21','2008-12-17 20:05:21'),(25,'Consumer Privacy','(Consumer Complaints, Loss of Consumer Data)','Product Responsibility','2008-12-17 20:05:21','2008-12-17 20:05:21'),(26,'Animal Testing','(Humane, Inhumane, Use of Alternatives)','Product Responsibility','2008-12-17 20:05:21','2008-12-17 20:05:21');
/*!40000 ALTER TABLE `issues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `peer_ratings`
--

DROP TABLE IF EXISTS `peer_ratings`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `peer_ratings` (
  `id` int(11) NOT NULL auto_increment,
  `review_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  `score` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `peer_ratings`
--

LOCK TABLES `peer_ratings` WRITE;
/*!40000 ALTER TABLE `peer_ratings` DISABLE KEYS */;
INSERT INTO `peer_ratings` VALUES (4,3,2,1,'2009-01-03 23:15:53','2009-01-03 23:15:53'),(5,1,2,-1,'2009-01-03 23:16:34','2009-01-03 23:16:34'),(6,1,3,1,'2009-01-03 23:50:04','2009-01-03 23:50:04'),(7,7,3,1,'2009-01-04 02:47:29','2009-01-04 02:47:29'),(8,9,3,1,'2009-01-04 05:53:09','2009-01-04 05:53:09'),(9,1,1,1,'2009-01-07 22:24:32','2009-01-07 22:24:32'),(10,2,1,1,'2009-01-07 22:48:16','2009-01-07 22:48:16'),(11,3,1,-1,'2009-01-07 22:48:19','2009-01-07 22:48:19'),(12,4,1,1,'2009-01-07 22:48:24','2009-01-07 22:48:24'),(13,5,1,1,'2009-01-07 22:48:30','2009-01-07 22:48:30'),(14,6,1,1,'2009-01-07 22:48:52','2009-01-07 22:48:52');
/*!40000 ALTER TABLE `peer_ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_issues`
--

DROP TABLE IF EXISTS `review_issues`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `review_issues` (
  `id` int(11) NOT NULL auto_increment,
  `review_id` int(11) default NULL,
  `issue_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `review_issues`
--

LOCK TABLES `review_issues` WRITE;
/*!40000 ALTER TABLE `review_issues` DISABLE KEYS */;
INSERT INTO `review_issues` VALUES (1,1,1,'2008-12-17 20:10:26','2008-12-17 20:10:26'),(2,2,7,'2008-12-17 20:17:47','2008-12-17 20:17:47'),(3,2,3,'2008-12-17 20:17:47','2008-12-17 20:17:47'),(4,3,7,'2009-01-02 03:44:01','2009-01-02 03:44:01'),(5,3,1,'2009-01-02 03:44:01','2009-01-02 03:44:01'),(6,4,4,'2009-01-03 19:51:00','2009-01-03 19:51:00'),(7,4,3,'2009-01-03 19:51:00','2009-01-03 19:51:00'),(8,5,15,'2009-01-03 22:54:57','2009-01-03 22:54:57'),(9,6,1,'2009-01-04 02:44:14','2009-01-04 02:44:14'),(10,7,1,'2009-01-04 02:46:25','2009-01-04 02:46:25'),(11,8,1,'2009-01-04 02:49:16','2009-01-04 02:49:16'),(12,9,1,'2009-01-04 02:51:37','2009-01-04 02:51:37'),(13,10,7,'2009-01-04 05:51:43','2009-01-04 05:51:43'),(14,11,7,'2009-02-20 14:43:35','2009-02-20 14:43:35'),(15,11,3,'2009-02-20 14:43:35','2009-02-20 14:43:35'),(16,12,3,'2009-02-20 14:51:14','2009-02-20 14:51:14'),(17,12,7,'2009-02-20 14:51:14','2009-02-20 14:51:14');
/*!40000 ALTER TABLE `review_issues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `reviews` (
  `id` int(11) NOT NULL auto_increment,
  `body` text,
  `rating` int(11) NOT NULL,
  `status` varchar(255) NOT NULL,
  `company_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `user_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,'this is my half-assed review\r\n',5,'preview',1,'2008-12-17 20:10:26','2008-12-17 20:10:26',1),(2,'Apple has repeatedly corrupted government officials in order to reduce environmental protections.',2,'preview',1,'2008-12-17 20:17:47','2008-12-17 20:17:47',1),(3,'Apple has scorned the merit of meritous acts and scorned the scorn or scornful acts.  Bah!',7,'preview',1,'2009-01-02 03:44:01','2009-01-02 03:44:01',1),(4,'terrible company, just terrible',2,'preview',1,'2009-01-03 19:50:59','2009-01-03 19:50:59',2),(5,'Apple\'s market presence is just great!  What does that mean anyway?  Gosh!',10,'preview',1,'2009-01-03 22:54:57','2009-01-03 22:54:57',2),(6,'this is my review of exxon mobil',2,'preview',1,'2009-01-04 02:44:14','2009-01-04 02:44:14',3),(7,'this really should be about Exxon Mobil',2,'preview',2,'2009-01-04 02:46:24','2009-01-04 02:46:24',3),(8,'should also be about Exxon Mobil',10,'preview',2,'2009-01-04 02:49:16','2009-01-04 02:49:16',3),(9,'this truly is about exxon mobil',10,'preview',2,'2009-01-04 02:51:36','2009-01-04 02:51:36',3),(10,'Public policy thing that is a really long review.   This is an example of how it could work here, man.  Think of what the box will look like while you\'re actually digesting some of the content, in the process users will be in as they\'re getting into the site.  Right now, this very sentence, they\'re either getting useful information on the company at hand, or not.  When you finished reading this, do you feel inclined to leave feedback?  How often do you feel so-inclined?\r\n\r\nThe main point is that reviews can be long.  And they can have visual impact with their length.  Perhaps we should only show a preview, perhaps show the whole thing.',5,'preview',2,'2009-01-04 05:51:42','2009-01-04 05:51:42',3),(11,'Chevron’s subsidiary Texaco intentionally dumped 19 billion gallons of toxic wastewater and accidentally spilled 16 million gallons of crude oil into Ecuador’s Amazonian rainforest between 1972 and 1991, in what may be the worst oil-related environmental disaster in history. (By comparison, the Exxon Valdez spilled 10.8 million gallons of crude in Alaska.) Chevron is now the subject of an ongoing Ecuadoran class action lawsuit involving 30,000 plaintiffs, allegations of fraud brought by the Ecuadoran government, and investigation by the U.S. Securities and Exchange Commission for failure to disclose related liabilities to shareholders.\r\n\r\nTexaco is not exclusively responsible for the disaster; Ecuador’s national oil company – PetroEcuador – owned a majority stake in the project, though Texaco maintained full control of the oil consortium’s operations. PetroEcuador and the Ecuadoran government have failed to hold themselves and Texaco accountable, but this does not excuse Texaco. Chevron did not own Texaco at the time of the dumping and spills; the two companies merged in 2001 to become ChevronTexaco and in 2005 streamlined the company name to Chevron. As Texaco’s current owner, Chevron is fully accountable for Texaco’s liabilities.',5,'preview',1,'2009-02-20 14:43:35','2009-02-20 14:43:35',1),(12,'Chevron’s subsidiary Texaco intentionally dumped 19 billion gallons of toxic wastewater and accidentally spilled 16 million gallons of crude oil into Ecuador’s Amazonian rainforest between 1972 and 1991, in what may be the worst oil-related environmental disaster in history. (By comparison, the Exxon Valdez spilled 10.8 million gallons of crude in Alaska.) Chevron is now the subject of an ongoing Ecuadoran class action lawsuit involving 30,000 plaintiffs, allegations of fraud brought by the Ecuadoran government, and investigation by the U.S. Securities and Exchange Commission for failure to disclose related liabilities to shareholders.\r\n\r\nTexaco is not exclusively responsible for the disaster; Ecuador’s national oil company – PetroEcuador – owned a majority stake in the project, though Texaco maintained full control of the oil consortium’s operations. PetroEcuador and the Ecuadoran government have failed to hold themselves and Texaco accountable, but this does not excuse Texaco. Chevron did not own Texaco at the time of the dumping and spills; the two companies merged in 2001 to become ChevronTexaco and in 2005 streamlined the company name to Chevron. As Texaco’s current owner, Chevron is fully accountable for Texaco’s liabilities.',4,'preview',1,'2009-02-20 14:51:14','2009-02-20 14:51:14',1);
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20080913153355'),('20080920211753'),('20080921005620'),('20080922204438'),('20080926171738'),('20081004203137'),('20081009223832'),('20081009224757'),('20081009234713');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_issues`
--

DROP TABLE IF EXISTS `user_issues`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `user_issues` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `issue_id` int(11) default NULL,
  `weight` float default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=183 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `user_issues`
--

LOCK TABLES `user_issues` WRITE;
/*!40000 ALTER TABLE `user_issues` DISABLE KEYS */;
INSERT INTO `user_issues` VALUES (1,1,1,1,'2008-12-17 20:09:55','2008-12-17 20:09:55'),(2,1,2,1,'2008-12-17 20:09:55','2008-12-17 20:09:55'),(3,1,3,1,'2008-12-17 20:09:55','2008-12-17 20:09:55'),(4,1,4,1,'2008-12-17 20:09:55','2008-12-17 20:09:55'),(5,1,5,1,'2008-12-17 20:09:55','2008-12-17 20:09:55'),(6,1,6,1,'2008-12-17 20:09:55','2008-12-17 20:09:55'),(7,1,7,1,'2008-12-17 20:09:55','2008-12-17 20:09:55'),(8,1,8,1,'2008-12-17 20:09:55','2008-12-17 20:09:55'),(9,1,9,1,'2008-12-17 20:09:55','2008-12-17 20:09:55'),(10,1,10,1,'2008-12-17 20:09:55','2008-12-17 20:09:55'),(11,1,11,1,'2008-12-17 20:09:55','2008-12-17 20:09:55'),(12,1,12,1,'2008-12-17 20:09:55','2008-12-17 20:09:55'),(13,1,13,1,'2008-12-17 20:09:55','2008-12-17 20:09:55'),(14,1,14,1,'2008-12-17 20:09:55','2008-12-17 20:09:55'),(15,1,15,1,'2008-12-17 20:09:55','2008-12-17 20:09:55'),(16,1,16,1,'2008-12-17 20:09:55','2008-12-17 20:09:55'),(17,1,17,1,'2008-12-17 20:09:55','2008-12-17 20:09:55'),(18,1,18,1,'2008-12-17 20:09:55','2008-12-17 20:09:55'),(19,1,19,1,'2008-12-17 20:09:55','2008-12-17 20:09:55'),(20,1,20,1,'2008-12-17 20:09:55','2008-12-17 20:09:55'),(21,1,21,1,'2008-12-17 20:09:55','2008-12-17 20:09:55'),(22,1,22,1,'2008-12-17 20:09:55','2008-12-17 20:09:55'),(23,1,23,1,'2008-12-17 20:09:55','2008-12-17 20:09:55'),(24,1,24,1,'2008-12-17 20:09:55','2008-12-17 20:09:55'),(25,1,25,1,'2008-12-17 20:09:55','2008-12-17 20:09:55'),(26,1,26,1,'2008-12-17 20:09:55','2008-12-17 20:09:55'),(27,2,1,50,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(28,2,2,50,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(29,2,3,50,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(30,2,4,50,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(31,2,5,50,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(32,2,6,50,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(33,2,7,50,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(34,2,8,50,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(35,2,9,50,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(36,2,10,50,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(37,2,11,50,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(38,2,12,50,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(39,2,13,50,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(40,2,14,50,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(41,2,15,50,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(42,2,16,50,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(43,2,17,50,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(44,2,18,50,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(45,2,19,50,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(46,2,20,50,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(47,2,21,50,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(48,2,22,50,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(49,2,23,50,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(50,2,24,50,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(51,2,25,50,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(52,2,26,50,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(53,2,1,1,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(54,2,2,1,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(55,2,3,1,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(56,2,4,1,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(57,2,5,1,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(58,2,6,1,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(59,2,7,1,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(60,2,8,1,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(61,2,9,1,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(62,2,10,1,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(63,2,11,1,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(64,2,12,1,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(65,2,13,1,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(66,2,14,1,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(67,2,15,1,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(68,2,16,1,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(69,2,17,1,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(70,2,18,1,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(71,2,19,1,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(72,2,20,1,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(73,2,21,1,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(74,2,22,1,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(75,2,23,1,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(76,2,24,1,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(77,2,25,1,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(78,2,26,1,'2009-01-03 19:47:34','2009-01-03 19:47:34'),(79,3,1,50,'2009-01-03 19:47:59','2009-01-03 19:47:59'),(80,3,2,50,'2009-01-03 19:47:59','2009-01-03 19:47:59'),(81,3,3,50,'2009-01-03 19:47:59','2009-01-03 19:47:59'),(82,3,4,50,'2009-01-03 19:47:59','2009-01-03 19:47:59'),(83,3,5,50,'2009-01-03 19:47:59','2009-01-03 19:47:59'),(84,3,6,50,'2009-01-03 19:47:59','2009-01-03 19:47:59'),(85,3,7,50,'2009-01-03 19:47:59','2009-01-03 19:47:59'),(86,3,8,50,'2009-01-03 19:47:59','2009-01-03 19:47:59'),(87,3,9,50,'2009-01-03 19:47:59','2009-01-03 19:47:59'),(88,3,10,50,'2009-01-03 19:47:59','2009-01-03 19:47:59'),(89,3,11,50,'2009-01-03 19:47:59','2009-01-03 19:47:59'),(90,3,12,50,'2009-01-03 19:47:59','2009-01-03 19:47:59'),(91,3,13,50,'2009-01-03 19:47:59','2009-01-03 19:47:59'),(92,3,14,50,'2009-01-03 19:47:59','2009-01-03 19:47:59'),(93,3,15,50,'2009-01-03 19:47:59','2009-01-03 19:47:59'),(94,3,16,50,'2009-01-03 19:47:59','2009-01-03 19:47:59'),(95,3,17,50,'2009-01-03 19:47:59','2009-01-03 19:47:59'),(96,3,18,50,'2009-01-03 19:47:59','2009-01-03 19:47:59'),(97,3,19,50,'2009-01-03 19:47:59','2009-01-03 19:47:59'),(98,3,20,50,'2009-01-03 19:47:59','2009-01-03 19:47:59'),(99,3,21,50,'2009-01-03 19:47:59','2009-01-03 19:47:59'),(100,3,22,50,'2009-01-03 19:47:59','2009-01-03 19:47:59'),(101,3,23,50,'2009-01-03 19:47:59','2009-01-03 19:47:59'),(102,3,24,50,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(103,3,25,50,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(104,3,26,50,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(105,3,1,1,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(106,3,2,1,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(107,3,3,1,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(108,3,4,1,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(109,3,5,1,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(110,3,6,1,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(111,3,7,1,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(112,3,8,1,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(113,3,9,1,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(114,3,10,1,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(115,3,11,1,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(116,3,12,1,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(117,3,13,1,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(118,3,14,1,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(119,3,15,1,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(120,3,16,1,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(121,3,17,1,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(122,3,18,1,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(123,3,19,1,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(124,3,20,1,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(125,3,21,1,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(126,3,22,1,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(127,3,23,1,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(128,3,24,1,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(129,3,25,1,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(130,3,26,1,'2009-01-03 19:48:00','2009-01-03 19:48:00'),(131,4,1,50,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(132,4,2,50,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(133,4,3,50,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(134,4,4,50,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(135,4,5,50,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(136,4,6,50,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(137,4,7,50,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(138,4,8,50,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(139,4,9,50,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(140,4,10,50,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(141,4,11,50,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(142,4,12,50,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(143,4,13,50,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(144,4,14,50,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(145,4,15,50,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(146,4,16,50,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(147,4,17,50,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(148,4,18,50,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(149,4,19,50,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(150,4,20,50,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(151,4,21,50,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(152,4,22,50,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(153,4,23,50,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(154,4,24,50,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(155,4,25,50,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(156,4,26,50,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(157,4,1,1,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(158,4,2,1,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(159,4,3,1,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(160,4,4,1,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(161,4,5,1,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(162,4,6,1,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(163,4,7,1,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(164,4,8,1,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(165,4,9,1,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(166,4,10,1,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(167,4,11,1,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(168,4,12,1,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(169,4,13,1,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(170,4,14,1,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(171,4,15,1,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(172,4,16,1,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(173,4,17,1,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(174,4,18,1,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(175,4,19,1,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(176,4,20,1,'2009-01-03 19:48:25','2009-01-03 19:48:25'),(177,4,21,1,'2009-01-03 19:48:26','2009-01-03 19:48:26'),(178,4,22,1,'2009-01-03 19:48:26','2009-01-03 19:48:26'),(179,4,23,1,'2009-01-03 19:48:26','2009-01-03 19:48:26'),(180,4,24,1,'2009-01-03 19:48:26','2009-01-03 19:48:26'),(181,4,25,1,'2009-01-03 19:48:26','2009-01-03 19:48:26'),(182,4,26,1,'2009-01-03 19:48:26','2009-01-03 19:48:26');
/*!40000 ALTER TABLE `user_issues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `login` varchar(40) default NULL,
  `name` varchar(100) default '',
  `email` varchar(100) default NULL,
  `crypted_password` varchar(40) default NULL,
  `salt` varchar(40) default NULL,
  `remember_token` varchar(40) default NULL,
  `remember_token_expires_at` datetime default NULL,
  `activation_code` varchar(40) default NULL,
  `activated_at` datetime default NULL,
  `state` varchar(255) default 'passive',
  `profile` text,
  `deleted_at` datetime default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_users_on_login` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'wlgriffiths@gmail.com','','wlgriffiths@gmail.com','79bae1e11d741c2608ab04621005b10ffff617a9','d8f280d1acc07844f18a3129dfca4cf247c0492c',NULL,NULL,'729e3355f6198d030bc4aa2219659aadd1e22c96','2008-12-17 20:09:55','active',NULL,NULL,'2008-12-17 20:09:55','2008-12-17 20:09:55'),(2,'a@gmail.com','','a@gmail.com','f2193da60bbf47e05b5a413035bcde5bd0ec3cd1','adf7547561cb67c43a2471997e9466bfdca201f6',NULL,NULL,'7a19cc80afc7eef4ff6b5316d721842a011228e5','2009-01-03 19:47:34','active',NULL,NULL,'2009-01-03 19:47:33','2009-01-03 19:47:34'),(3,'b@gmail.com','','b@gmail.com','2e8e67ed68ea2cd707b168fcdcca16959f06d78f','91bd5cd5eefaead057e78cb161f6b87b8e1abdb7',NULL,NULL,'206b261623a5841a30ccae38390ec8c924f44a2d','2009-01-03 19:48:00','active',NULL,NULL,'2009-01-03 19:47:59','2009-01-03 19:48:00'),(4,'c@gmail.com','','c@gmail.com','cb7d9657bd4f85f609fc9beaa8978571448392c6','a0e147f31eefd109bc22e70d68f052ec0eeb4b0d',NULL,NULL,'57c62c93ff719ade5cda676183118c371c89380d','2009-01-03 19:48:26','active',NULL,NULL,'2009-01-03 19:48:25','2009-01-03 19:48:26');
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

-- Dump completed on 2009-02-25 23:42:21
