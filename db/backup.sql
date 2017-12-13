-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.2.10-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for mourgos
CREATE DATABASE IF NOT EXISTS `mourgos` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `mourgos`;

-- Dumping structure for table mourgos.attributes
CREATE TABLE IF NOT EXISTS `attributes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` text NOT NULL,
  `Options` text NOT NULL,
  `Price` decimal(10,2) unsigned NOT NULL DEFAULT 0.00,
  `product_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `fk_product_id` (`product_id`),
  CONSTRAINT `fk_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table mourgos.campaigns
CREATE TABLE IF NOT EXISTS `campaigns` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` text NOT NULL,
  `Formula` int(11) NOT NULL DEFAULT 0,
  `LiveFrom` datetime DEFAULT NULL,
  `LiveTill` datetime DEFAULT NULL,
  `Hashtag` text NOT NULL,
  `MaxUsages` int(11) NOT NULL DEFAULT 0,
  `CurrentUsages` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table mourgos.catalogues
CREATE TABLE IF NOT EXISTS `catalogues` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` text DEFAULT NULL,
  `Phone` text DEFAULT NULL,
  `Address` text DEFAULT NULL,
  `Image` text DEFAULT NULL,
  `HeroImage` text DEFAULT NULL,
  `Exclusive` int(1) unsigned NOT NULL DEFAULT 0,
  `Description` text DEFAULT NULL,
  `FriendlyURL` text DEFAULT NULL,
  `WorkingDates` text DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `Latitude` double NOT NULL,
  `Longitude` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_catalogues_users` (`user_id`),
  CONSTRAINT `FK_catalogues_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table mourgos.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` text DEFAULT NULL,
  `catalogue_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `fk_catalogue_id` (`catalogue_id`),
  CONSTRAINT `fk_catalogue_id` FOREIGN KEY (`catalogue_id`) REFERENCES `catalogues` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table mourgos.globals
CREATE TABLE IF NOT EXISTS `globals` (
  `Name` varchar(50) NOT NULL,
  `Value` text NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table mourgos.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `id` varchar(5) NOT NULL,
  `Status` tinyint(4) NOT NULL DEFAULT 0,
  `Name` text NOT NULL,
  `Address` text NOT NULL,
  `Orofos` text NOT NULL,
  `Phone` text NOT NULL,
  `Koudouni` text DEFAULT NULL,
  `Comments` text DEFAULT NULL,
  `Items` text NOT NULL,
  `Total` double(10,2) NOT NULL,
  `Extra` int(11) NOT NULL,
  `Latitude` double NOT NULL,
  `Longitude` double NOT NULL,
  `hasOpened` tinyint(1) NOT NULL DEFAULT 0,
  `delivery_id` int(10) unsigned DEFAULT NULL,
  `catalogue_id` int(10) unsigned NOT NULL,
  `postDate` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_orders_catalogues` (`catalogue_id`),
  KEY `FK_orders_users` (`delivery_id`),
  CONSTRAINT `FK_orders_catalogues` FOREIGN KEY (`catalogue_id`) REFERENCES `catalogues` (`id`),
  CONSTRAINT `FK_orders_users` FOREIGN KEY (`delivery_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table mourgos.products
CREATE TABLE IF NOT EXISTS `products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` text NOT NULL,
  `Description` text NOT NULL,
  `Image` text NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  `Days` text NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_category_id` (`category_id`),
  CONSTRAINT `fk_category_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=258 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table mourgos.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12349 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table mourgos.userlogs
CREATE TABLE IF NOT EXISTS `userlogs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Type` text NOT NULL,
  `Value` text NOT NULL,
  `EntityID` text DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL DEFAULT 0,
  `created_on` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_logs_users` (`user_id`),
  CONSTRAINT `FK_logs_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=189 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table mourgos.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` text NOT NULL,
  `salt` text NOT NULL,
  `token` text NOT NULL,
  `email` text DEFAULT NULL,
  `role` int(5) DEFAULT -1,
  `phone` text DEFAULT NULL,
  `name` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `FK_users_roles` (`role`),
  CONSTRAINT `FK_users_roles` FOREIGN KEY (`role`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
