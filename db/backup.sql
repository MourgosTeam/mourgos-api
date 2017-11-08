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
	(1, 'Eri\'s Donuts', '/images/erisdonuts.png', 'Τα περίφημα πιο λαχταριστά donuts της Θεσσαλονίκης'),
	(2, 'Falafel House', '/images/donuts.png', 'Φαλάφελ, Σαλάτες, Φρέσκοι χυμοί'),
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- Dumping data for table mourgos.categories: ~10 rows (approximately)
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT IGNORE INTO `categories` (`id`, `Name`, `catalogue_id`) VALUES
	(1, 'Category 1', 1),
	(2, 'Wraps', 2),
	(3, 'Category 3', 1),
	(4, 'Category 4', 3),
	(5, 'Μερίδες', 2),
	(6, 'Category 6', 1),
	(8, 'Burgers', 2),
	(9, 'Γλυκά', 2),
	(10, 'Φρέσκοι Χυμοί', 2),
	(11, 'Ψυγείο', 2);
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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- Dumping data for table mourgos.products: ~39 rows (approximately)
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT IGNORE INTO `products` (`id`, `Name`, `Description`, `Image`, `Price`, `category_id`) VALUES
	(1, 'Product 1', 'The best donut. Σαλάτα με iceberg, κοτόπουλο, μπέικον, κρουτόν & σως Καίσαρα', '/images/big-donut.jpg', 10.55, 1),
	(2, 'Product 2', 'The normal donut', '/images/donuts.png', 9.55, 1),
	(3, 'Product 2', 'The cheap donut', '/images/donuts.png', 0.55, 1),
	(5, 'Product 2', 'The big coffee', '/images/big-coffee.jpg', 0.55, 4),
	(6, 'Product 3', 'The expensive coffee', '/images/expensive-coffee.jpg', 12.55, 1),
	(7, 'Product Coffee', 'The  coffee', '/images/coffee.jpg', 1.55, 3),
	(8, 'Product 1', 'The best donut. Σαλάτα με iceberg, κοτόπουλο, μπέικον, κρουτόν & σως Καίσαρα', '/images/big-donut.jpg', 10.55, 1),
	(9, 'Baba-Ganouj - Tabouleh Size M', 'Μελιτζάνα, ταχίνι, ντομάτα, μαϊντανός, φρέσκο κρεμμύδι, πλιγούρι', '', 2.80, 2),
	(10, 'Baba-Ganouj - Tabouleh Size L', 'Μελιτζάνα, ταχίνι, ντομάτα, μαϊντανός, φρέσκο κρεμμύδι, πλιγούρι', '', 3.00, 2),
	(11, 'Baba-Ganouj - Tabouleh Size XL', 'Μελιτζάνα, ταχίνι, ντομάτα, μαϊντανός, φρέσκο κρεμμύδι, πλιγούρι', '', 3.20, 2),
	(12, 'Baba-Ganouj - Fattoush Size M', 'Μελιτζάνα, ταχίνι, λάχανο, μαρούλι, αγγούρι, καρότο, πιπεριά ', '', 2.80, 2),
	(13, 'Baba-Ganouj - Fattoush Size L', 'Μελιτζάνα, ταχίνι, λάχανο, μαρούλι, αγγούρι, καρότο, πιπεριά ', '', 3.00, 2),
	(14, 'Baba-Ganouj - Fattoush Size XL', 'Μελιτζάνα, ταχίνι, λάχανο, μαρούλι, αγγούρι, καρότο, πιπεριά ', '', 3.20, 2),
	(15, 'Hummus - Tabbouleh Size M', 'Ρεβύθι, ταχίνι, ντομάτα, μαϊντανός, φρέσκο κρεμμύδι, πλιγούρι', '', 2.80, 2),
	(16, 'Hummus - Tabbouleh Size L', 'Ρεβύθι, ταχίνι, ντομάτα, μαϊντανός, φρέσκο κρεμμύδι, πλιγούρι', '', 3.00, 2),
	(17, 'Hummus - Tabbouleh Size XL', 'Ρεβύθι, ταχίνι, ντομάτα, μαϊντανός, φρέσκο κρεμμύδι, πλιγούρι', '', 3.20, 2),
	(18, 'Hummus - Fattoush Size M', 'Ρεβύθι, ταχίνι, λάχανο, μαρούλι, αγγούρι, καρότο, πιπεριά', '', 2.80, 2),
	(19, 'Hummus - Fattoush Size L', 'Ρεβύθι, ταχίνι, λάχανο, μαρούλι, αγγούρι, καρότο, πιπεριά', '', 3.00, 2),
	(20, 'Hummus - Fattoush Size XL', 'Ρεβύθι, ταχίνι, λάχανο, μαρούλι, αγγούρι, καρότο, πιπεριά', '', 3.20, 2),
	(21, 'Αλοιφή Small', '', '', 2.00, 5),
	(22, 'Αλοιφή Big', '', '', 4.00, 5),
	(23, 'Σαλάτα Small', '', '', 2.00, 5),
	(24, 'Σαλάτα Big', '', '', 4.00, 5),
	(25, 'Φαλάφελ Small', '6 τεμάχια', '', 2.00, 5),
	(26, 'Φαλάφελ Big', '12 τεμάχια', '', 4.00, 5),
	(27, 'Φαλάφελ Full', '6 τεμάχια φαλάφελ, πατάτες, σαλάτα, αλοιφή, 1 πίτα', '', 5.50, 5),
	(28, 'Φαλάφελ Full+', '12 τεμάχια φαλάφελ, πατάτες, σαλάτα, αλοιφή, 1 πίτα', '', 7.50, 5),
	(29, 'Φρέσκες Τηγανητές Πατάτες', '', '', 2.50, 5),
	(30, 'Vegan Mayo Falafel Burger', 'Μπιφτέκι φαλάφελ, 100% vegan μαγιονέζα, ντομάτα, κρεμμύδι, μαρούλι, πίκλες', '', 4.20, 8),
	(31, 'Guacamole Falafel Burger', 'Μπιφτέκι φαλάφελ, guacamole, ντομάτα, κρεμμύδι, μαρούλι, πίκλες', '', 4.20, 8),
	(32, 'Τηγανητή Μπανάνα', '', '', 2.50, 9),
	(33, 'Green Machine', 'Φύλλα σπανάκι, αγγούρι, καρότο, πράσινο μήλο', '', 3.70, 10),
	(34, 'The Usual', 'Κόκκινο μήλο, πορτοκάλι, καρότο', '', 3.70, 10),
	(35, 'Sweetheart', 'Κόκκινο μήλο, πατζάρι, καρότο', '', 3.70, 10),
	(36, 'Mediterranean', 'Ντομάτα, καρότο, αγγούρι, μαϊντανός, κόκκινη πιπεριά, αλάτι, πιπέρι', '', 3.70, 10),
	(37, 'Αναψυκτικά', 'Green Cola, Ble, Coca Cola', '', 1.20, 11),
	(38, 'Μπύρες', 'Kaiser, Stella, Βεργίνα, Buckler', '', 1.70, 11),
	(39, 'Χυμοί', 'Ρόδι', '', 2.50, 11),
	(40, 'Νερό', '500ml', '', 0.50, 11);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
