-- MySQL dump 10.11
--
-- Host: localhost    Database: citizensmarket_production
-- ------------------------------------------------------
-- Server version	5.0.45-Debian_1ubuntu3.1-log

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
-- Table structure for table `issues`
--

DROP TABLE IF EXISTS `issues`;
CREATE TABLE `issues` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  `category` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `issues`
--

LOCK TABLES `issues` WRITE;
/*!40000 ALTER TABLE `issues` DISABLE KEYS */;
INSERT INTO `issues` VALUES (1,'Sustainability Research & Development  ','Renewable Energy, Sustainable Products & Services','Environment','2009-03-24 22:15:17','2009-03-24 22:15:17'),(2,'Conservation & Waste Management','Materials Used, Recycling, Energy, Water, Transport, Greenhouse Gases, Ozone Depletion, Waste Disposal, Spills','Environment','2009-03-24 22:34:12','2009-03-24 22:34:12'),(3,'Operations in Biodiverse Zones','Impact on Habitats and Protected Areas','Environment','2009-03-24 22:34:33','2009-03-24 22:34:33'),(4,'Reporting & Disclosure','Transparency, Quality of Sustainability Reports and Publicly Available Data','Society','2009-03-24 22:34:51','2009-03-24 22:34:51'),(5,'Lobbying & Corruption','Legal Influence: Lobbying, Political Contributions\r\n\r\nIllegal Influence: Incidences, Oversight, Training, Response','Society','2009-03-24 22:35:41','2009-03-24 22:35:41'),(6,'Operations in Conflict Zones','Operations in Conflict Zones, Complicity With Repressive Security Forces','Society','2009-03-24 22:36:00','2009-03-24 22:36:00'),(7,'Indigenous Rights','Land Appropriations, Health Hazards and Other Violations of Rights of Indigenous Peoples','Society','2009-03-24 22:36:18','2009-03-24 22:36:18'),(8,'Animal Testing','Humane, Inhumane, Use of Alternatives','Society','2009-03-24 22:36:40','2009-03-24 22:36:40'),(9,'Corporate Philanthropy','Corporate Donations','Society','2009-03-24 22:36:58','2009-03-24 22:36:58'),(10,'Financial Performance','Revenues Generated & Distributed, Coverage of Defined Benefit Obligations, Financial Assistance from Government\r\n','Economy','2009-03-24 22:37:19','2009-03-24 22:37:19'),(11,'Local Economic Impacts','Use of Local Suppliers & Local Hires, Infrastructure Development','Economy','2009-03-24 22:37:35','2009-03-24 22:37:35'),(12,'Anti-Competitive Behavior','Monopolies, Oligopolies, Cartels','Economy','2009-03-24 22:37:51','2009-03-24 22:37:51'),(13,'Investment & Procurement','Screening of Suppliers or Investments According to Sustainability Criteria (e.g. Fair Trade)','Economy','2009-03-24 22:38:09','2009-03-24 22:38:09'),(14,'Executive Compensation','Executive Pay & Benefits, Golden Parachutes','Labor','2009-03-24 22:38:32','2009-03-24 22:38:32'),(15,'Employee Wages & Benefits','Wages Compared to Local Minimum, Workforce Turnover, Family Benefits, Child Care, Retirement, Health Care, Professional Development','Labor','2009-03-24 22:38:57','2009-03-24 22:38:57'),(16,'Employee Safety','Injury & Fatality Rates, Prevention Measures','Labor','2009-03-24 22:39:19','2009-03-24 22:39:19'),(17,'Employee Diversity','For Minorities, Women, LGBT, People With Disabilities: Cultural Competence, Parity in Wages, Workforce/ Executive/ Board Representation','Labor','2009-03-24 22:39:38','2009-03-24 22:39:38'),(18,'Labor Relations','Unions, Freedom of Association and Collective Bargaining','Labor','2009-03-24 22:39:56','2009-03-24 22:39:56'),(19,'Forced Labor or Child Labor','Slavery, Human Trafficking, Child Labor','Labor','2009-03-24 22:40:15','2009-03-24 22:40:15'),(20,'Consumer Safety','Quality Assurance, Consumer Illnesses/Injuries/Fatalities','Consumers','2009-03-24 22:40:36','2009-03-24 22:40:36'),(21,'Consumer Privacy','Consumer Complaints, Loss of Consumer Data','Consumers','2009-03-24 22:40:53','2009-03-24 22:40:53'),(22,'Marketing','Socially Responsible Advertising, Consumer Information','Consumers','2009-03-24 22:41:09','2009-03-24 22:41:09'),(23,'Other Issues','Anything that doesn\'t fall under our other issue headings should go here.','Other','2009-03-24 22:41:45','2009-03-24 22:41:45');
/*!40000 ALTER TABLE `issues` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-03-24 22:45:34
