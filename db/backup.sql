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
DROP TABLE IF EXISTS `attributes`;
CREATE TABLE IF NOT EXISTS `attributes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` text NOT NULL,
  `Options` text NOT NULL,
  `Price` decimal(10,2) unsigned NOT NULL DEFAULT 0.00,
  `product_id` int(10) unsigned NOT NULL DEFAULT 0,
  UNIQUE KEY `id` (`id`),
  KEY `fk_product_id` (`product_id`),
  CONSTRAINT `fk_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- Dumping data for table mourgos.attributes: ~7 rows (approximately)
/*!40000 ALTER TABLE `attributes` DISABLE KEYS */;
INSERT IGNORE INTO `attributes` (`id`, `Name`, `Options`, `Price`, `product_id`) VALUES
	(1, 'Zaxari', '["sketos","metrios","glukos"]', 0.00, 7),
	(2, 'Zaxari', '["sketos","metrios","glukos"]', 0.00, 6),
	(3, 'Zaxari', '["sketos","metrios","glukos"]', 0.00, 5),
	(4, 'Γέμιση', '["σοκολάτα","φράουλα","βερίκοκο"]', 1.32, 1),
	(5, 'Γέμιση', '["σοκολάτα","φράουλα","βερίκοκο"]', 1.55, 2),
	(6, 'Γέμιση', '["σοκολάτα"]', 100.50, 2),
	(7, 'Γέμιση', '["σοκολάτα"]', 1.67, 3);
/*!40000 ALTER TABLE `attributes` ENABLE KEYS */;

-- Dumping structure for table mourgos.catalogues
DROP TABLE IF EXISTS `catalogues`;
CREATE TABLE IF NOT EXISTS `catalogues` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` text DEFAULT NULL,
  `Image` text DEFAULT NULL,
  `Description` text DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Dumping data for table mourgos.catalogues: ~3 rows (approximately)
/*!40000 ALTER TABLE `catalogues` DISABLE KEYS */;
INSERT IGNORE INTO `catalogues` (`id`, `Name`, `Image`, `Description`) VALUES
	(1, 'Erin\'s Donuts', '/images/donuts.png', 'Παιδάκια, burgers και donuts'),
	(2, 'Falafel House', '/images/donuts.png', 'Σουβλάκια, Τυρόπιτες'),
	(3, 'Greek Natural', '/images/donuts.png', 'Donuts, καφέ, χυμούς');
/*!40000 ALTER TABLE `catalogues` ENABLE KEYS */;

-- Dumping structure for table mourgos.categories
DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` text DEFAULT NULL,
  `catalogue_id` int(10) unsigned NOT NULL DEFAULT 0,
  UNIQUE KEY `id` (`id`),
  KEY `fk_catalogue_id` (`catalogue_id`),
  CONSTRAINT `fk_catalogue_id` FOREIGN KEY (`catalogue_id`) REFERENCES `catalogues` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- Dumping data for table mourgos.categories: ~6 rows (approximately)
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT IGNORE INTO `categories` (`id`, `Name`, `catalogue_id`) VALUES
	(1, 'Category 1', 1),
	(2, 'Category 2', 2),
	(3, 'Category 3', 1),
	(4, 'Category 4', 3),
	(5, 'Category 5', 2),
	(6, 'Category 6', 1);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;

-- Dumping structure for table mourgos.products
DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` text NOT NULL,
  `Description` text NOT NULL DEFAULT '',
  `Image` text NOT NULL DEFAULT '',
  `Price` decimal(10,2) NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `fk_category_id` (`category_id`),
  CONSTRAINT `fk_category_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- Dumping data for table mourgos.products: ~8 rows (approximately)
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT IGNORE INTO `products` (`id`, `Name`, `Description`, `Image`, `Price`, `category_id`) VALUES
	(1, 'Product 1', 'The best donut. Σαλάτα με iceberg, κοτόπουλο, μπέικον, κρουτόν & σως Καίσαρα', '/images/big-donut.jpg', 10.55, 1),
	(2, 'Product 2', 'The normal donut', '/images/donuts.png', 9.55, 1),
	(3, 'Product 2', 'The cheap donut', '/images/donuts.png', 0.55, 1),
	(4, 'Product 1', 'The cheap coffee', '/images/coffee.jpg', 0.55, 2),
	(5, 'Product 2', 'The big coffee', '/images/big-coffee.jpg', 0.55, 4),
	(6, 'Product 3', 'The expensive coffee', '/images/expensive-coffee.jpg', 12.55, 2),
	(7, 'Product Coffee', 'The  coffee', '/images/coffee.jpg', 1.55, 3),
	(8, 'Product 1', 'The best donut. Σαλάτα με iceberg, κοτόπουλο, μπέικον, κρουτόν & σως Καίσαρα', '/images/big-donut.jpg', 10.55, 1);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
