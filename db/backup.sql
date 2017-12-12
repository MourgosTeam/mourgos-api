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
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

-- Dumping data for table mourgos.attributes: ~16 rows (approximately)
/*!40000 ALTER TABLE `attributes` DISABLE KEYS */;
INSERT IGNORE INTO `attributes` (`id`, `Name`, `Options`, `Price`, `product_id`) VALUES
	(84, 'Γέμιση', '["σοκολάτα"," βανίλια"," μπουένο"," fererro"," toffee"," φυστικοβούτυρο"," ταχίνι"," καρύδα"," μόκα"," λευκή σοκολάτα"," bitter"," μπανάνα"," καραμέλα"," μπισκότο"," λεμόνι"," πορτοκάλι"," τσιζ κέικ"," σαμπάνια"," φράουλα"," κεράσι"," βερίκοκο"," μήλο"," ρόδι"," blueberry"]', 0.00, 82),
	(85, 'Γέμιση', '["σοκολάτα"," βανίλια"," μπουένο"," fererro"," toffee"," φυστικοβούτυρο"," ταχίνι"," καρύδα"," μόκα"," λευκή σοκολάτα"," bitter"," μπανάνα"," καραμέλα"," μπισκότο"," λεμόνι"," πορτοκάλι"," τσιζ κέικ"," σαμπάνια"," φράουλα"," κεράσι"," βερίκοκο"," μήλο"," ρόδι"," blueberry"]', 0.00, 83),
	(86, 'Γέμιση', '["σοκολάτα"," βανίλια"," μπουένο"," fererro"," toffee"," φυστικοβούτυρο"," ταχίνι"," καρύδα"," μόκα"," λευκή σοκολάτα"," bitter"," μπανάνα"," καραμέλα"," μπισκότο"," λεμόνι"," πορτοκάλι"," τσιζ κέικ"," σαμπάνια"," φράουλα"," κεράσι"," βερίκοκο"," μήλο"," ρόδι"," blueberry"]', 0.00, 84),
	(87, 'Γέμιση', '["σοκολάτα"," βανίλια"," μπουένο"," fererro"," toffee"," φυστικοβούτυρο"," ταχίνι"," καρύδα"," μόκα"," λευκή σοκολάτα"," bitter"," μπανάνα"," καραμέλα"," μπισκότο"," λεμόνι"," πορτοκάλι"," τσιζ κέικ"," σαμπάνια"," φράουλα"," κεράσι"," βερίκοκο"," μήλο"," ρόδι"," blueberry"]', 0.00, 85),
	(88, 'Γέμιση', '["σοκολάτα"," βανίλια"," μπουένο"," fererro"," toffee"," φυστικοβούτυρο"," ταχίνι"," καρύδα"," μόκα"," λευκή σοκολάτα"," bitter"," μπανάνα"," καραμέλα"," μπισκότο"," λεμόνι"," πορτοκάλι"," τσιζ κέικ"," σαμπάνια"," φράουλα"," κεράσι"," βερίκοκο"," μήλο"," ρόδι"," blueberry"]', 0.00, 86),
	(89, 'Γέμιση', '["σοκολάτα"," βανίλια"," μπουένο"," fererro"," toffee"," φυστικοβούτυρο"," ταχίνι"," καρύδα"," μόκα"," λευκή σοκολάτα"," bitter"," μπανάνα"," καραμέλα"," μπισκότο"," λεμόνι"," πορτοκάλι"," τσιζ κέικ"," σαμπάνια"," φράουλα"," κεράσι"," βερίκοκο"," μήλο"," ρόδι"," blueberry"]', 0.00, 87),
	(90, 'Γέμιση', '["σοκολάτα"," βανίλια"," μπουένο"," fererro"," toffee"," φυστικοβούτυρο"," ταχίνι"," καρύδα"," μόκα"," λευκή σοκολάτα"," bitter"," μπανάνα"," καραμέλα"," μπισκότο"," λεμόνι"," πορτοκάλι"," τσιζ κέικ"," σαμπάνια"," φράουλα"," κεράσι"," βερίκοκο"," μήλο"," ρόδι"," blueberry"]', 0.00, 88),
	(91, 'Επικάλυψη', '["σοκολάτα"," λευκή σοκολάτα"," bitter"," white waffles"," choco oreo"," φράουλα"," μπανάνα"," πορτοκάλι"," καραμέλα"," chocofreta"]', 0.00, 83),
	(92, 'Επικάλυψη', '["σοκολάτα"," λευκή σοκολάτα"," bitter"," white waffles"," choco oreo"," φράουλα"," μπανάνα"," πορτοκάλι"," καραμέλα"," chocofreta"]', 0.00, 84),
	(93, 'Επικάλυψη', '["σοκολάτα"," λευκή σοκολάτα"," bitter"," white waffles"," choco oreo"," φράουλα"," μπανάνα"," πορτοκάλι"," καραμέλα"," chocofreta"]', 0.00, 86),
	(94, 'Επικάλυψη', '["σοκολάτα"," λευκή σοκολάτα"," bitter"," white waffles"," choco oreo"," φράουλα"," μπανάνα"," πορτοκάλι"," καραμέλα"," chocofreta"]', 0.00, 87),
	(95, 'Επικάλυψη', '["σοκολάτα"," λευκή σοκολάτα"," bitter"," white waffles"," choco oreo"," φράουλα"," μπανάνα"," πορτοκάλι"," καραμέλα"," chocofreta"]', 0.00, 88),
	(96, 'Topping Απλό', '["τρούφες"," μπισκότο"," ινδοκάρυδο"," καραμελωμένο φυστίκι"," oreo"," άχνη ζάχαρη"]', 0.00, 83),
	(97, 'Topping Απλό', '["τρούφες"," μπισκότο"," ινδοκάρυδο"," καραμελωμένο φυστίκι"," oreo"," άχνη ζάχαρη"]', 0.00, 86),
	(98, 'Topping Σπέσιαλ', '["ολόκληρα μπισκότα"," γεμιστά πουράκια"," σοκολατορυζομπαλίτσες"," φιλέ αμυγδάλου"," δάκρυα φυστικοβούτυρου"]', 0.00, 84),
	(99, 'Topping Σπέσιαλ', '["ολόκληρα μπισκότα"," γεμιστά πουράκια"," σοκολατορυζομπαλίτσες"," φιλέ αμυγδάλου"," δάκρυα φυστικοβούτυρου"]', 0.00, 87);
/*!40000 ALTER TABLE `attributes` ENABLE KEYS */;

-- Dumping structure for table mourgos.campaigns
DROP TABLE IF EXISTS `campaigns`;
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

-- Dumping data for table mourgos.campaigns: ~1 rows (approximately)
/*!40000 ALTER TABLE `campaigns` DISABLE KEYS */;
INSERT IGNORE INTO `campaigns` (`id`, `Name`, `Formula`, `LiveFrom`, `LiveTill`, `Hashtag`, `MaxUsages`, `CurrentUsages`) VALUES
	(1, 'MeliCampaign', 5, '2017-12-11 14:55:17', '2017-12-11 16:52:55', 'mourgosalpha', 5, 0);
/*!40000 ALTER TABLE `campaigns` ENABLE KEYS */;

-- Dumping structure for table mourgos.catalogues
DROP TABLE IF EXISTS `catalogues`;
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
  UNIQUE KEY `id` (`id`),
  KEY `FK_catalogues_users` (`user_id`),
  CONSTRAINT `FK_catalogues_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Dumping data for table mourgos.catalogues: ~4 rows (approximately)
/*!40000 ALTER TABLE `catalogues` DISABLE KEYS */;
INSERT IGNORE INTO `catalogues` (`id`, `Name`, `Phone`, `Address`, `Image`, `HeroImage`, `Exclusive`, `Description`, `FriendlyURL`, `WorkingDates`, `user_id`, `Latitude`, `Longitude`) VALUES
	(1, 'Eri\'s Donuts', '231 550 7270', 'Τσιμισκή 124, Θεσσαλονίκη 546 21', '/images/eris_donuts.png', '/images/hero/eris_hero.jpg', 1, 'Τα περίφημα πιο λαχταριστά donuts της Θεσσαλονίκης', 'ErisDonuts', '[1,1,1,1,1,1,1]', 1, 40.628575, 22.949541100000033),
	(2, 'Falafel House', '231 023 8091', 'Αλεξάνδρου Σβώλου 54, Θεσσαλονίκη 546 21', '/images/falafel_house.png', '/images/hero/falafel_hero.jpg', 0, 'Φαλάφελ, Σαλάτες, Φρέσκοι χυμοί', 'FalafelHouse', '[0,0,0,0,0,0,0]', 2, 40.6294776, 22.952889599999935),
	(3, 'Greek Natural', '231 024 0250', 'Δημητρίου Γούναρη 48, Θεσσαλονίκη 546 21', '/images/greek_natural.png', '/images/hero/greek_natural_hero.jpg', 0, 'Λαχταριστές σαλάτες, φρέσκοι χυμοί και δροσερά smoothies', 'GreekNatural', '[0,0,0,0,0,0,0]', 2, 40.6317409, 22.951557099999945),
	(4, 'Θάλασσα', '2310262443', NULL, '/images/thalassa.png', '/images/hero/thalassa_hero.jpg', 0, NULL, 'Thalassa', '[0,0,0,0,0,0,0]', 2, 0, 0);
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- Dumping data for table mourgos.categories: ~17 rows (approximately)
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT IGNORE INTO `categories` (`id`, `Name`, `catalogue_id`) VALUES
	(2, 'Wraps', 2),
	(5, 'Μερίδες', 2),
	(8, 'Burgers', 2),
	(9, 'Γλυκά', 2),
	(10, 'Φρέσκοι Χυμοί', 2),
	(11, 'Ψυγείο', 2),
	(12, 'Φρέσκες Σαλάτες', 3),
	(13, 'Χυμοί Φρούτων Smoothies με Γάλα & Γιαούρτι', 3),
	(14, 'Χυμοί Φρούτων Smoothies με Γιαούρτι', 3),
	(15, 'Χυμοί Φρούτων Smoothies με Σορμπέ', 3),
	(16, 'Φυσικοί Χυμοί', 3),
	(17, 'Φρουτοσαλάτες', 3),
	(18, 'Donuts', 1),
	(19, 'Ροφήματα', 1),
	(20, 'Θαλασσινά', 4),
	(21, 'Σαλατικά - Συνοδευτικά', 4),
	(22, 'Ποτά - Αναψυκτικά', 4);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;

-- Dumping structure for table mourgos.globals
DROP TABLE IF EXISTS `globals`;
CREATE TABLE IF NOT EXISTS `globals` (
  `Name` varchar(50) NOT NULL,
  `Value` text NOT NULL,
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mourgos.globals: ~2 rows (approximately)
/*!40000 ALTER TABLE `globals` DISABLE KEYS */;
INSERT IGNORE INTO `globals` (`Name`, `Value`) VALUES
	('MinimumOrder', '5'),
	('MourgosIsLive', '1');
/*!40000 ALTER TABLE `globals` ENABLE KEYS */;

-- Dumping structure for table mourgos.orders
DROP TABLE IF EXISTS `orders`;
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
  UNIQUE KEY `id` (`id`),
  KEY `FK_orders_catalogues` (`catalogue_id`),
  KEY `FK_orders_users` (`delivery_id`),
  CONSTRAINT `FK_orders_catalogues` FOREIGN KEY (`catalogue_id`) REFERENCES `catalogues` (`id`),
  CONSTRAINT `FK_orders_users` FOREIGN KEY (`delivery_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mourgos.orders: ~11 rows (approximately)
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT IGNORE INTO `orders` (`id`, `Status`, `Name`, `Address`, `Orofos`, `Phone`, `Koudouni`, `Comments`, `Items`, `Total`, `Extra`, `Latitude`, `Longitude`, `hasOpened`, `delivery_id`, `catalogue_id`, `postDate`) VALUES
	('1t74w', 10, 'Δημητρα', 'Λεωνίδα Ιασωνίδου 19, Θεσσαλονίκη 546 35, Ελλάδα', 'Κουιμτζιδου', '6943851676', '', '', '[{"id":83,"quantity":1,"comments":"","TotalPrice":1.4,"attributes":{"85":2,"96":2}},{"id":86,"quantity":1,"comments":"","TotalPrice":1.6,"attributes":{"88":2,"93":4}},{"id":87,"quantity":1,"comments":"","TotalPrice":1.9,"attributes":{"89":1,"94":9}},{"id":83,"quantity":1,"comments":"","TotalPrice":1.4,"attributes":{"85":5,"91":9}},{"id":88,"quantity":1,"comments":"","TotalPrice":3.8,"attributes":{"90":13,"95":4}},{"id":83,"quantity":1,"comments":"","TotalPrice":1.4,"attributes":{"91":5}},{"id":83,"quantity":1,"comments":"","TotalPrice":1.4,"attributes":{"85":7}},{"id":83,"quantity":1,"comments":"","TotalPrice":1.4,"attributes":{"85":2,"96":4}}]', 14.30, 0, 40.6354741, 22.949929699999984, 0, 4, 1, '2017-12-11 15:40:29'),
	('c9m6r', 99, 'Test', 'Τσιμισκή 25, Θεσσαλονίκη 546 24, Ελλάδα', '4', '2100000000', 'Test koudouni', 'ασδ', '[{"id":84,"quantity":1,"comments":"","TotalPrice":1.7,"attributes":{}}]', 1.70, 1, 40.6342349, 22.940777199999957, 0, NULL, 1, '2017-12-11 15:18:39'),
	('c9n64', 99, 'Test', 'Τσιμισκή 25, Θεσσαλονίκη 546 24, Ελλάδα', '4', '2100000000', 'Test koudouni', 'ασδ', '[{"id":84,"quantity":1,"comments":"","TotalPrice":1.7,"attributes":{"98":1}}]', 1.70, 1, 40.6342349, 22.940777199999957, 0, NULL, 1, '2017-12-11 15:28:16'),
	('ctr6g', 10, 'Ελενη Τόπλη', 'Aristotelous 33, Thessaloniki 546 31, Greece', '3', '6977468515', '', '', '[{"id":84,"quantity":1,"comments":"","TotalPrice":1.7,"attributes":{"86":13}},{"id":86,"quantity":1,"comments":"","TotalPrice":1.6,"attributes":{"88":3,"93":4,"97":4}},{"id":88,"quantity":1,"comments":"","TotalPrice":3.8,"attributes":{"90":5,"95":1}}]', 7.10, 0, 40.63869820000001, 22.946345000000065, 0, 4, 1, '2017-12-11 16:02:44'),
	('dhk6c', 99, 'Test', 'Al. Svolou 12, Thessaloniki 546 22, Greece', '5', 'Sdvff', '', 'Vbdd', '[{"id":86,"quantity":5,"comments":"","TotalPrice":8,"attributes":{"88":7,"93":5}}]', 8.00, 0, 40.6319776, 22.948213799999962, 0, NULL, 1, '2017-12-11 15:28:29'),
	('e1j74', 10, 'Νικήτας Χατζηπαζαρλής', 'Μουδανιών 31, Αγ. Παύλος 546 36, Ελλάδα', 'Ισόγειο', '6940719404', '', 'Δεν έχει κουδούνι απο έξω, οπότε ή πατήστε κόρνα ή πάρτε τηλέφωνο όταν φτάσεται.', '[{"id":83,"quantity":1,"comments":"","TotalPrice":1.4,"attributes":{"85":23,"91":1,"96":4}},{"id":84,"quantity":1,"comments":"","TotalPrice":1.7,"attributes":{"92":3,"98":2}},{"id":88,"quantity":1,"comments":"","TotalPrice":3.8,"attributes":{"90":16,"95":5}},{"id":85,"quantity":1,"comments":"","TotalPrice":1.4,"attributes":{"87":3}},{"id":89,"quantity":1,"comments":"","TotalPrice":3.2,"attributes":{}},{"id":88,"quantity":1,"comments":"","TotalPrice":3.8,"attributes":{"90":23,"95":1}}]', 15.30, 0, 40.63592749999999, 22.96034140000006, 0, 4, 1, '2017-12-11 16:35:54'),
	('kac9j', 99, 'Test', 'Al. Svolou 12, Thessaloniki 546 22, Greece', '5', 'Sdvff', '', 'Vbdd', '[{"id":84,"quantity":4,"comments":"","TotalPrice":6.8,"attributes":{"86":13,"92":7}}]', 6.80, 0, 40.6319776, 22.948213799999962, 0, NULL, 1, '2017-12-11 15:22:16'),
	('t3ge1', 2, 'Dimitrios Iakovakis', 'Εγνατία 4555, Θεσσαλονίκη 546 36, Ελλάδα', '6ος', '6982791753', '', 'Κτήριο Δ, Αν δεν βρει το κτήριο ας με πάρει τηλέφωνο να κατέβω στην είσοδο της Πολυτεχνικής.', '[{"id":88,"quantity":1,"comments":"","TotalPrice":3.8,"attributes":{"90":2,"95":2}},{"id":88,"quantity":1,"comments":"","TotalPrice":3.8,"attributes":{"90":5,"95":2}}]', 7.60, 0, 40.6267365, 22.959750699999972, 0, 4, 1, '2017-12-11 15:48:38'),
	('tj6mt', 10, 'Μιχάλης Δαφνομήλης', 'Agiou Nikolaou 10, Thessaloniki 546 33, Greece', '2ος', '6983393575', '', '', '[{"id":83,"quantity":1,"comments":"","TotalPrice":1.4,"attributes":{"85":7,"91":9,"96":1}},{"id":83,"quantity":1,"comments":"","TotalPrice":1.4,"attributes":{"85":11,"91":2,"96":1}},{"id":83,"quantity":1,"comments":"","TotalPrice":1.4,"attributes":{"85":16,"91":4}},{"id":84,"quantity":1,"comments":"","TotalPrice":1.7,"attributes":{"86":17,"92":2,"98":1}},{"id":82,"quantity":1,"comments":"","TotalPrice":1.2,"attributes":{"84":12}},{"id":82,"quantity":1,"comments":"","TotalPrice":1.2,"attributes":{"84":14}}]', 8.30, 0, 40.638984, 22.948679900000002, 0, 4, 1, '2017-12-11 15:53:05'),
	('tj6ru', 2, 'Αμπατζης Βασίλης', 'Αμαλίας 8, Θεσσαλονίκη 546 40, Ελλάδα', '4ος', '6981455009', '', '', '[{"id":86,"quantity":2,"comments":"","TotalPrice":3.2,"attributes":{"88":2,"93":3}},{"id":85,"quantity":1,"comments":"","TotalPrice":1.4,"attributes":{"87":9}},{"id":82,"quantity":1,"comments":"","TotalPrice":1.2,"attributes":{}},{"id":82,"quantity":2,"comments":"","TotalPrice":2.4,"attributes":{"84":9}}]', 8.20, 0, 40.6206487, 22.95650580000006, 0, 4, 1, '2017-12-11 15:44:53'),
	('tkadh', 99, 'Test', 'Al. Svolou 12, Thessaloniki 546 22, Greece', '5', 'Sdvff', '', 'Vbdd', '[{"id":88,"quantity":2,"comments":"","TotalPrice":7.6,"attributes":{"90":14,"95":2}}]', 7.60, 0, 40.6319776, 22.948213799999962, 0, NULL, 1, '2017-12-11 15:30:36');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;

-- Dumping structure for table mourgos.products
DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` text NOT NULL,
  `Description` text NOT NULL,
  `Image` text NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  `Days` text NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `fk_category_id` (`category_id`),
  CONSTRAINT `fk_category_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=258 DEFAULT CHARSET=utf8;

-- Dumping data for table mourgos.products: ~141 rows (approximately)
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT IGNORE INTO `products` (`id`, `Name`, `Description`, `Image`, `Price`, `Days`, `category_id`) VALUES
	(9, 'Baba-Ganouj - Tabouleh Size M', 'Μελιτζάνα, ταχίνι, ντομάτα, μαϊντανός, φρέσκο κρεμμύδι, πλιγούρι', '/images/products/FalafelHouse/baba_tab.png', 2.80, '[1,1,1,1,1,1,1]', 2),
	(10, 'Baba-Ganouj - Tabouleh Size L', 'Μελιτζάνα, ταχίνι, ντομάτα, μαϊντανός, φρέσκο κρεμμύδι, πλιγούρι', '/images/products/FalafelHouse/baba_tab.png', 3.00, '[1,1,1,1,1,1,1]', 2),
	(11, 'Baba-Ganouj - Tabouleh Size XL', 'Μελιτζάνα, ταχίνι, ντομάτα, μαϊντανός, φρέσκο κρεμμύδι, πλιγούρι', '/images/products/FalafelHouse/baba_tab.png', 3.20, '[1,1,1,1,1,1,1]', 2),
	(12, 'Baba-Ganouj - Fattoush Size M', 'Μελιτζάνα, ταχίνι, λάχανο, μαρούλι, αγγούρι, καρότο, πιπεριά ', '/images/products/FalafelHouse/baba_fat.png', 2.80, '[1,1,1,1,1,1,1]', 2),
	(13, 'Baba-Ganouj - Fattoush Size L', 'Μελιτζάνα, ταχίνι, λάχανο, μαρούλι, αγγούρι, καρότο, πιπεριά ', '/images/products/FalafelHouse/baba_fat.png', 3.00, '[1,1,1,1,1,1,1]', 2),
	(14, 'Baba-Ganouj - Fattoush Size XL', 'Μελιτζάνα, ταχίνι, λάχανο, μαρούλι, αγγούρι, καρότο, πιπεριά ', '/images/products/FalafelHouse/baba_fat.png', 3.20, '[1,1,1,1,1,1,1]', 2),
	(15, 'Hummus - Tabbouleh Size M', 'Ρεβύθι, ταχίνι, ντομάτα, μαϊντανός, φρέσκο κρεμμύδι, πλιγούρι', '/images/products/FalafelHouse/hum_tab.jpg', 2.80, '[1,1,1,1,1,1,1]', 2),
	(16, 'Hummus - Tabbouleh Size L', 'Ρεβύθι, ταχίνι, ντομάτα, μαϊντανός, φρέσκο κρεμμύδι, πλιγούρι', '/images/products/FalafelHouse/hum_tab.jpg', 3.00, '[1,1,1,1,1,1,1]', 2),
	(17, 'Hummus - Tabbouleh Size XL', 'Ρεβύθι, ταχίνι, ντομάτα, μαϊντανός, φρέσκο κρεμμύδι, πλιγούρι', '/images/products/FalafelHouse/hum_tab.jpg', 3.20, '[1,1,1,1,1,1,1]', 2),
	(18, 'Hummus - Fattoush Size M', 'Ρεβύθι, ταχίνι, λάχανο, μαρούλι, αγγούρι, καρότο, πιπεριά', '/images/products/FalafelHouse/hum_fat.png', 2.80, '[1,1,1,1,1,1,1]', 2),
	(19, 'Hummus - Fattoush Size L', 'Ρεβύθι, ταχίνι, λάχανο, μαρούλι, αγγούρι, καρότο, πιπεριά', '/images/products/FalafelHouse/hum_fat.png', 3.00, '[1,1,1,1,1,1,1]', 2),
	(20, 'Hummus - Fattoush Size XL', 'Ρεβύθι, ταχίνι, λάχανο, μαρούλι, αγγούρι, καρότο, πιπεριά', '/images/products/FalafelHouse/hum_fat.png', 3.20, '[1,1,1,1,1,1,1]', 2),
	(21, 'Αλοιφή Small', '', '/images/products/FalafelHouse/dips.jpg', 2.00, '[1,1,1,1,1,1,1]', 5),
	(22, 'Αλοιφή Big', '', '/images/products/FalafelHouse/dips.jpg', 4.00, '[1,1,1,1,1,1,1]', 5),
	(23, 'Σαλάτα Small', '', '/images/products/FalafelHouse/salad1.jpg', 2.00, '[1,1,1,1,1,1,1]', 5),
	(24, 'Σαλάτα Big', '', '/images/products/FalafelHouse/salad2.jpg', 4.00, '[1,1,1,1,1,1,1]', 5),
	(25, 'Φαλάφελ Small', '6 τεμάχια', '/images/products/FalafelHouse/falafel.jpg', 2.00, '[1,1,1,1,1,1,1]', 5),
	(26, 'Φαλάφελ Big', '12 τεμάχια', '/images/products/FalafelHouse/falafel.jpg', 4.00, '[1,1,1,1,1,1,1]', 5),
	(27, 'Φαλάφελ Full', '6 τεμάχια φαλάφελ, πατάτες, σαλάτα, αλοιφή, 1 πίτα', '/images/products/FalafelHouse/merida2.jpg', 5.50, '[1,1,1,1,1,1,1]', 5),
	(28, 'Φαλάφελ Full+', '12 τεμάχια φαλάφελ, πατάτες, σαλάτα, αλοιφή, 1 πίτα', '/images/products/FalafelHouse/merida.jpg', 7.50, '[1,1,1,1,1,1,1]', 5),
	(29, 'Φρέσκες Τηγανητές Πατάτες', '', '/images/products/FalafelHouse/fries.jpg', 2.50, '[1,1,1,1,1,1,1]', 5),
	(30, 'Vegan Mayo Falafel Burger', 'Μπιφτέκι φαλάφελ, 100% vegan μαγιονέζα, ντομάτα, κρεμμύδι, μαρούλι, πίκλες', '/images/products/FalafelHouse/burger2.jpg', 4.20, '[1,1,1,1,1,1,1]', 8),
	(31, 'Guacamole Falafel Burger', 'Μπιφτέκι φαλάφελ, guacamole, ντομάτα, κρεμμύδι, μαρούλι, πίκλες', '/images/products/FalafelHouse/burger.jpg', 4.20, '[1,1,1,1,1,1,1]', 8),
	(32, 'Τηγανητή Μπανάνα', '', '/images/products/FalafelHouse/fried_banana.jpg', 2.50, '[1,1,1,1,1,1,1]', 9),
	(33, 'Green Machine', 'Φύλλα σπανάκι, αγγούρι, καρότο, πράσινο μήλο', '/images/products/FalafelHouse/green.jpg', 3.70, '[1,1,1,1,1,1,1]', 10),
	(34, 'The Usual', 'Κόκκινο μήλο, πορτοκάλι, καρότο', '/images/products/FalafelHouse/usual.jpg', 3.70, '[1,1,1,1,1,1,1]', 10),
	(35, 'Sweetheart', 'Κόκκινο μήλο, πατζάρι, καρότο', '/images/products/FalafelHouse/sweetheart.jpg', 3.70, '[1,1,1,1,1,1,1]', 10),
	(36, 'Mediterranean', 'Ντομάτα, καρότο, αγγούρι, μαϊντανός, κόκκινη πιπεριά, αλάτι, πιπέρι', '/images/products/FalafelHouse/mediterranean.jpg', 3.70, '[1,1,1,1,1,1,1]', 10),
	(37, 'Αναψυκτικά', 'Green Cola, Ble, Coca Cola', '/images/products/FalafelHouse/cola_can.jpg', 1.20, '[1,1,1,1,1,1,1]', 11),
	(38, 'Μπύρες', 'Kaiser, Stella, Βεργίνα, Buckler', '/images/products/FalafelHouse/kaiser.jpg', 1.20, '[1,1,1,1,1,1,1]', 11),
	(39, 'Χυμοί', 'Ρόδι', '/images/products/FalafelHouse/pomegranate.jpg', 2.50, '[1,1,1,1,1,1,1]', 11),
	(40, 'Νερό', '500ml', '/images/products/FalafelHouse/nero.jpg', 0.50, '[1,1,1,1,1,1,1]', 11),
	(41, 'Caesar\'s', 'Τρυφερό φιλέτο κοτόπουλο, μαρούλι, iceberg, σουσάμι', '/images/products/caesars.jpg', 2.50, '[1,1,1,1,1,1,1]', 12),
	(42, 'Τονοσαλάτα', 'Μαρούλι, καλαμπόκι, τόνος, καρύδι, σως μαγιονέζας', '/images/products/tuna.jpg', 2.50, '[1,1,1,1,1,1,1]', 12),
	(43, 'Μποτσαρέλα', 'Μαρούλι, ρόκα, λιαστή ντομάτα, μποτσαρέλα, σουσάμι, σως παλαιωμένου βαλσαμικού, ανθόμελο', '/images/products/mozzarella.jpg', 2.50, '[1,1,1,1,1,1,1]', 12),
	(44, 'Σαλάτα Φρούτων', 'Iceberg, μαρούλι, διάφορα φρούτα, mix nuts, σως παλαιωμένου βαλσαμικού, ανθόμελο', '/images/products/withfruits.jpg', 2.50, '[1,1,1,1,1,1,1]', 12),
	(45, 'Φακοσαλάτα', 'Φακές, ρύζι, τυρί, ντομάτα, πιπεριά, φρέσκο κρεμμυδάκι, μαϊντανός, άνηθος, ρίγανη', '/images/products/lentils.jpg', 2.50, '[1,1,1,1,1,1,1]', 12),
	(46, 'Σαλάτα Ζυμαρικών', 'Ζυμαρικά, ντομάτα, ελιές, κάπαρη, τόνος', '/images/products/pastasalad.jpg', 2.50, '[1,1,1,1,1,1,1]', 12),
	(47, 'Πάρτυ Φράουλας', 'Φράουλες, μπανάνα, γάλα, μέλι & παγωμένο γιαούρτι', '/images/products/strawberry_smoothie.jpg', 3.00, '[1,1,1,1,1,1,1]', 13),
	(48, 'Δροσερή Μπανάνα', 'Μπανάνα, γάλα, μέλι, σιρόπι βανίλιας & παγωμένο γιαούρτι', '/images/products/banana_smoothie.jpg', 3.00, '[1,1,1,1,1,1,1]', 13),
	(49, 'Σοκολατοπειρασμός', 'Μπανάνα, σοκολάτα, γάλα, σιρόπι βανίλιας & παγωμένο γιαούρτι', '/images/products/choco_smoothie.jpg', 3.00, '[1,1,1,1,1,1,1]', 13),
	(50, 'Πρωινή Απόλαυση', 'Καφές, γάλα, σιρόπι βανίλιας, μπανάνα & παγωμένο γιαούρτι', '/images/products/coffee_banana_smoothie.jpg', 3.00, '[1,1,1,1,1,1,1]', 13),
	(51, 'Γεύση Ροδάκινου', 'Μπανάνα, ροδάκινο, γάλα & παγωμένο γιαούρτι', '/images/products/peach_smoothie.jpg', 3.00, '[1,1,1,1,1,1,1]', 13),
	(52, 'Πρωινή Δύναμη', 'Μπανάνα, αχλάδι, γάλα, μέλι, σιρόπι βανίλιας, δημητριακά & παγωμένο γιαούρτι', '/images/products/banana_cereal_smoothie.jpg', 3.00, '[1,1,1,1,1,1,1]', 13),
	(53, 'Διάλλειμα για Καφέ', 'Καφές, γάλα & παγωμένο γιαούρτι', '/images/products/coffee_smoothie.jpg', 3.00, '[1,1,1,1,1,1,1]', 13),
	(54, 'Φραουλοκοκτέιλ', 'Φράουλες, μπανάνα, μήλο, ροδάκινο & παγωμένο γιαούρτι', '/images/products/strawberry_smoothie.jpg', 3.00, '[1,1,1,1,1,1,1]', 14),
	(55, 'Πανδαισία Μούρων', 'Μούρα εποχής, μήλο & παγωμένο γιαούρτι', '/images/products/berries_smoothie.jpg', 3.00, '[1,1,1,1,1,1,1]', 14),
	(56, 'Μανγκομαγεία', 'Μάνγκο, μπανάνα, ανανάς & παγωμένο γιαούρτι', '/images/products/mango_smoothie.jpg', 3.00, '[1,1,1,1,1,1,1]', 14),
	(57, 'Ανανάς Εξωτικός', 'Ανανάς, ροδάκινο & παγωμένο γιαούρτι', '/images/products/pineapple_smoothie.jpg', 3.00, '[1,1,1,1,1,1,1]', 14),
	(58, 'Χυμώδες Ροδάκινο', 'Ροδάκινο, μήλο, μέλι & παγωμένο γιαούρτι', '/images/products/peach_smoothie.jpg', 3.00, '[1,1,1,1,1,1,1]', 14),
	(59, 'Μυθικό Πρωινό', 'Μπανάνα, φράουλες, ανανάς, δημητριακά, μέλι & παγωμένο γιαούρτι', '/images/products/banana_cereal_smoothie.jpg', 3.00, '[1,1,1,1,1,1,1]', 14),
	(60, 'Ονειρεμένο Μάνγκο', 'Μάνγκο, πορτοκάλι, μέλι & παγωμένο γιαούρτι', '/images/products/mango_smoothie.jpg', 3.00, '[1,1,1,1,1,1,1]', 14),
	(61, 'Έκρηξη Ροδάκινου', 'Ροδάκινο, μήλο & σορμπέ φράουλα', '/images/products/peach_smoothie.jpg', 3.00, '[1,1,1,1,1,1,1]', 15),
	(62, 'Άγριο Καρπούζι', 'Καρπούζι, μούρα & σορμπέ φράουλα', '/images/products/watermelon_smoothie.jpg', 3.00, '[1,1,1,1,1,1,1]', 15),
	(63, 'Καλή Γραμμή', 'Ανανάς, μούρα, μήλο & σορμπέ μούρου', '/images/products/pineapple_berries_smoothie.jpg', 3.00, '[1,1,1,1,1,1,1]', 15),
	(64, 'Γεύση Καρύδας', 'Ανανάς, μπανάνα, καρύδα & σορμπέ λεμονιού', '/images/products/coconut_smoothie.jpg', 3.00, '[1,1,1,1,1,1,1]', 15),
	(65, 'Φρουτοσαλάτα', 'Φρουτοσαλάτα & σορμπέ λεμονιού', '/images/products/fruitsalad_smoothie.jpg', 3.00, '[1,1,1,1,1,1,1]', 15),
	(66, 'Μανγκομανία', 'Μάνγκο, μπανάνα, φράουλες, ανανάς & σορμπέ μάνγκο', '/images/products/mango_smoothie.jpg', 3.00, '[1,1,1,1,1,1,1]', 15),
	(67, 'Άρωμα Φρεσκάδας', 'Μπανάνα, ροδάκινο, φράουλες, ανανάς & σορμπέ φράουλα', '/images/products/peach_smoothie.jpg', 3.00, '[1,1,1,1,1,1,1]', 15),
	(68, 'Μπαχάμες', 'Μπανάνα, ανανάς, πορτοκάλι & μέλι', '/images/products/banana_juice.jpg', 2.50, '[1,1,1,1,1,1,1]', 16),
	(69, 'Τροπικό Τανγκό', 'Ανανάς, ροδάκινο, πορτοκάλι & πεπόνι', '/images/products/pineapple_juice.jpg', 2.50, '[1,1,1,1,1,1,1]', 16),
	(70, 'Επανενεργοποίηση', 'Μπανάνα, ανανάς, φράουλες & πορτοκάλι', '/images/products/pineapple_banana_juice.jpg', 2.50, '[1,1,1,1,1,1,1]', 16),
	(71, 'Δυνατό Ξεκίνημα', 'Ανανάς, πορτοκάλι, γκρέιπφρουτ & λεμόνι', '/images/products/pineapple_orange_juice.gif', 2.50, '[1,1,1,1,1,1,1]', 16),
	(72, 'Καλοκαιρινή Πανδαισία', 'Φράουλες, μήλο, πεπόνι & καρπούζι', '/images/products/watermelon_juice.jpg', 2.50, '[1,1,1,1,1,1,1]', 16),
	(73, 'Φρεσκάδα Δυόσμου', 'Ανανάς, μήλο & δυόσμος', '/images/products/spearmint_juice.jpg', 2.50, '[1,1,1,1,1,1,1]', 16),
	(74, 'Βιταμινούχο Αδυνάτισμα', 'Ανανάς, πορτοκάλι, μήλο & ακτινίδιο', '/images/products/pineapple_kiwi_juice.jpg', 2.50, '[1,1,1,1,1,1,1]', 16),
	(75, 'Φυσικός Χυμός Πορτοκάλι', '', '/images/products/orange_juice.jpg', 1.50, '[1,1,1,1,1,1,1]', 16),
	(76, 'Φυσικός Χυμός Πορτοκάλι - Ρόδι', '', '/images/products/orange_rodi_juice.jpg', 2.50, '[1,1,1,1,1,1,1]', 16),
	(77, 'Φρουτοσαλάτα', 'Διάφορα φρούτα εποχής', '/images/products/fruitsalad.jpg', 2.00, '[1,1,1,1,1,1,1]', 17),
	(78, 'Φρουτοσαλάτα με Γιαούρτι, Μέλι και Δημητριακά', '', '/images/products/fruitsalad_cereal.jpg', 2.50, '[1,1,1,1,1,1,1]', 17),
	(79, 'Φρουτοσαλάτα με Πραλίνα Σοκολάτα ή Μέλι', '', '/images/products/fruitsalad_choco.jpg', 2.50, '[1,1,1,1,1,1,1]', 17),
	(80, 'Φρουτοσαλάτα με Μούρα', '', '/images/products/fruitsalad_berries.jpg', 2.50, '[1,1,1,1,1,1,1]', 17),
	(81, 'Φρουτοσαλάτα με Παγωμένο Γιαούρτι', '', '/images/products/fruitsalad_froyo.jpg', 3.30, '[1,1,1,1,1,1,1]', 17),
	(82, 'Μεσαίο donut με γέμιση', 'Γέμιση της επιλογής σας.', '/images/products/gemisi.jpg', 1.20, '[1,1,1,1,1,1,1]', 18),
	(83, 'Μεσαίο donut με γέμιση & επικάλυψη', 'Γέμιση και επικάλυψη της επιλογής σας.', '/images/products/epikalypsi.jpg', 1.40, '[1,1,1,1,1,1,1]', 18),
	(84, 'Μεσαίο donut με γέμιση & επικάλυψη σπέσιαλ', 'Γέμιση, επικάλυψη και topping της επιλογής σας.', '/images/products/epikalypsi_special.jpg', 1.70, '[1,1,1,1,1,1,1]', 18),
	(85, 'Μεγάλο donut με γέμιση', 'Γέμιση της επιλογής σας.', '/images/products/gemisi.jpg', 1.40, '[1,1,1,1,1,1,1]', 18),
	(86, 'Μεγάλο donut με γέμιση & επικάλυψη', 'Γέμιση και επικάλυψη της επιλογής σας.', '/images/products/epikalypsi.jpg', 1.60, '[1,1,1,1,1,1,1]', 18),
	(87, 'Μεγάλο donut με γέμιση & επικάλυψη σπέσιαλ', 'Γέμιση, επικάλυψη και topping της επιλογής σας.', '/images/products/epikalypsi_special.jpg', 1.90, '[1,1,1,1,1,1,1]', 18),
	(88, 'Μικρά donuts με γέμιση & επικάλυψη (4άδα)', 'Γέμιση και επικάλυψη της επιλογής σας.', '/images/products/mikra_mazi.jpg', 3.80, '[1,1,1,1,1,1,1]', 18),
	(89, 'Eri\'s glaze donut', '', '/images/products/glaze.jpeg', 3.20, '[1,1,1,1,1,1,1]', 18),
	(90, 'Γάλα άσπρο', '', '/images/products/milk.jpg', 1.30, '[1,1,1,1,1,1,1]', 19),
	(91, 'Γάλα σοκολατούχο μικρό', '', '/images/products/choco_milk.jpg', 1.50, '[1,1,1,1,1,1,1]', 19),
	(92, 'Γάλα σοκολατούχο μεγάλο', '', '/images/products/choco_milk.jpg', 1.80, '[1,1,1,1,1,1,1]', 19),
	(93, 'Αριάνι', '', '/images/products/ariani.jpg', 1.40, '[1,1,1,1,1,1,1]', 19),
	(94, 'Νερό', '', '/images/products/nero.jpg', 0.50, '[1,1,1,1,1,1,1]', 19),
	(95, 'Χυμός (παιδικός)', '', '/images/products/juice.png', 0.80, '[1,1,1,1,1,1,1]', 19),
	(204, 'Γαριδομακαρονάδα', '', '/images/products/thalassa/shrimps.jpg', 6.50, '[1,1,1,1,1,1,1]', 20),
	(205, 'Ψαρόσπουπα', '', '/images/products/thalassa/soup.jpg', 5.50, '[1,1,1,1,1,1,1]', 20),
	(206, 'Τορτίγια Ψαριού', '', '/images/products/thalassa/tortilla.jpg', 4.00, '[1,1,1,1,1,1,1]', 20),
	(207, 'Μπακαλιάρος Σκορδαλιά', '', '/images/products/thalassa/baca.jpg', 7.00, '[1,1,1,1,1,1,1]', 20),
	(208, 'Burger Ψαριού', '', '/images/products/thalassa/burger.jpg', 4.50, '[1,1,1,1,1,1,1]', 20),
	(209, 'Μερίδα Σουβλάκι Τόνου με Πατάτες', '', '/images/products/thalassa/souvlaki.jpg', 6.50, '[1,1,1,1,1,1,1]', 20),
	(210, 'Τσιπούρα Ιχθ. Σχάρας', '', '', 6.50, '[1,1,1,1,1,1,1]', 20),
	(211, 'Λαυράκι Ιχθ. Σχάρας', '', '', 6.00, '[1,1,1,1,1,1,1]', 20),
	(212, 'Χιόνα Ιχθ. Σχάρας', '', '', 6.50, '[1,1,1,1,1,1,1]', 20),
	(213, 'Ψητά Λαχανικά', '', '', 3.80, '[1,1,1,1,1,1,1]', 20),
	(214, 'Μπακαλιάρος Σκορδαλιά', '', '/images/products/thalassa/baca.jpg', 7.00, '[0,1,0,0,0,0,0]', 20),
	(215, 'Πέρκα με Σωτέ Λαχανικά', '', '/images/products/thalassa/perka.jpg', 7.00, '[0,1,0,0,0,0,0]', 20),
	(216, 'Λαχανοντολμάδες με Τόνο και Θαλασσινά', '', '', 7.00, '[0,0,1,0,0,0,0]', 20),
	(217, 'Μυδοπίλαφο', '', '', 6.50, '[0,0,1,0,0,0,0]', 20),
	(218, 'Σουπιές με Σπανάκι', '', '', 7.50, '[0,0,0,1,0,0,0]', 20),
	(219, 'Χταπόδι με Κοφτό Μακαρόνι', '', '/images/products/thalassa/xtapodi.jpg', 6.50, '[0,0,0,1,0,0,0]', 20),
	(220, 'Σουβλάκι Τόνου με Πουρέ Σελινόριζας', '', '/images/products/thalassa/souvlaki2.jpg', 6.50, '[0,0,0,0,1,0,0]', 20),
	(221, 'Πένες με Σολομό και Σάλτσα Βενετσιάνα', '', '/images/products/thalassa/penes.jpg', 7.00, '[0,0,0,0,1,0,0]', 20),
	(222, 'Γεμιστά με Θαλασσινά', '', '', 5.50, '[0,0,0,0,0,1,0]', 20),
	(223, 'Θράψαλο Γεμιστό με Θαλασσινά', '', '', 7.00, '[0,0,0,0,0,1,0]', 20),
	(224, 'Σολομός με Σωτέ Λαχανικά', '', '', 7.50, '[0,0,0,0,0,0,1]', 20),
	(225, 'Burger Ψαριού', '', '/images/products/thalassa/burger.jpg', 4.50, '[0,0,0,0,0,0,1]', 20),
	(226, 'Κριθαρώτο Θαλασσινών', '', '/images/products/thalassa/kritharoto.jpg', 7.00, '[1,0,0,0,0,0,0]', 20),
	(227, 'Ψάρι αλά Σπατσιώτα', '', '', 6.50, '[1,0,0,0,0,0,0]', 20),
	(228, 'Χόρτα (Αντίδια ή Βλήτα)', '', '', 2.50, '[1,1,1,1,1,1,1]', 21),
	(229, 'Coca Cola Κουτί', '330ml', '/images/products/thalassa/cola_can.jpg', 1.20, '[1,1,1,1,1,1,1]', 22),
	(230, 'Coca Cola Zero Κουτί', '330ml', '/images/products/thalassa/cola_zero_can.jpg', 1.20, '[1,1,1,1,1,1,1]', 22),
	(231, 'Coca Cola Στέβια Κουτί', '330ml', '/images/products/thalassa/cola_stevia_can.jpg', 1.20, '[1,1,1,1,1,1,1]', 22),
	(232, 'Coca Cola Light Κουτί', '330ml', '/images/products/thalassa/cola_light_can.jpg', 1.20, '[1,1,1,1,1,1,1]', 22),
	(233, 'Fanta Πορτοκαλάδα', '330ml', '/images/products/thalassa/fanta_orange_can.jpg', 1.20, '[1,1,1,1,1,1,1]', 22),
	(234, 'Fanta Λεμονάδα', '330ml', '/images/products/thalassa/fanta_lemon_can.jpg', 1.20, '[1,1,1,1,1,1,1]', 22),
	(235, 'Sprite', '330ml', '/images/products/thalassa/sprite_can.jpg', 1.20, '[1,1,1,1,1,1,1]', 22),
	(236, 'Schweppes (Σόδα)', '330ml', '/images/products/thalassa/soda.png', 1.20, '[1,1,1,1,1,1,1]', 22),
	(237, 'Coca Cola Μπουκάλι', '500ml', '/images/products/thalassa/cola_bottle.jpg', 1.60, '[1,1,1,1,1,1,1]', 22),
	(238, 'Coca Cola Zero Μπουκάλι', '500ml', '/images/products/thalassa/cola_zero_bottle.jpg', 1.60, '[1,1,1,1,1,1,1]', 22),
	(239, 'Coca Cola Light Μπουκάλι', '500ml', '/images/products/thalassa/cola_light_bottle.jpg', 1.60, '[1,1,1,1,1,1,1]', 22),
	(240, 'Νερό', '330ml', '/images/products/thalassa/nero.jpg', 0.50, '[1,1,1,1,1,1,1]', 22),
	(241, 'Ούζο Πλωμάρι', '200ml', '/images/products/thalassa/plomari.jpg', 4.50, '[1,1,1,1,1,1,1]', 22),
	(242, 'Ούζο Παπρά', '100ml', '/images/products/thalassa/papra.jpg', 2.50, '[1,1,1,1,1,1,1]', 22),
	(243, 'Ούζο Μπαμπατζίμ', '200ml', '/images/products/thalassa/babatzim.png', 5.50, '[1,1,1,1,1,1,1]', 22),
	(244, 'Τσίπουρο Δεκαράκι', '200ml', '/images/products/thalassa/dekaraki.jpg', 4.50, '[1,1,1,1,1,1,1]', 22),
	(245, 'Τσίπουρο Μπαμπατζίμ (με Γλυκάνισο)', '200ml', '/images/products/thalassa/babatzim_tsipouro_me.png', 5.80, '[1,1,1,1,1,1,1]', 22),
	(246, 'Τσίπουρο Μπαμπατζίμ (χωρίς Γλυκάνισο)', '200ml', '/images/products/thalassa/babatzim_tsipouro.png', 5.80, '[1,1,1,1,1,1,1]', 22),
	(247, 'Τσίπουρο Παπρά (με Γλυκάνισο)', '100ml', '/images/products/thalassa/papra_tsipouro.jpg', 2.50, '[1,1,1,1,1,1,1]', 22),
	(248, 'Τσίπουρο Παπρά (χωρίς Γλυκάνισο)', '100ml', '/images/products/thalassa/papra_tsipouro.jpg', 2.50, '[1,1,1,1,1,1,1]', 22),
	(249, 'Τσίπουρο Παπρά (με Γλυκάνισο)', '700ml', '/images/products/thalassa/papra_tsipouro.jpg', 12.00, '[1,1,1,1,1,1,1]', 22),
	(250, 'Τσίπουρο Παπρά (χωρίς Γλυκάνισο)', '700ml', '/images/products/thalassa/papra_tsipouro.jpg', 12.00, '[1,1,1,1,1,1,1]', 22),
	(251, 'Μπύρα ΑΛΦΑ', '500ml', '/images/products/thalassa/alfa500.png', 2.00, '[1,1,1,1,1,1,1]', 22),
	(252, 'Μπύρα ΑΛΦΑ', '330ml', '/images/products/thalassa/alfa330.jpg', 1.60, '[1,1,1,1,1,1,1]', 22),
	(253, 'Amstel', '330ml', '/images/products/thalassa/amstel330.jpg', 1.60, '[1,1,1,1,1,1,1]', 22),
	(254, 'Amstel Free', '330ml', '/images/products/thalassa/amstel_free.jpg', 1.60, '[1,1,1,1,1,1,1]', 22),
	(255, 'Amstel Radler', '330ml', '/images/products/thalassa/asmtel_radler.jpg', 1.60, '[1,1,1,1,1,1,1]', 22),
	(256, 'Heineken', '330ml', '/images/products/thalassa/heineken.jpg', 1.60, '[1,1,1,1,1,1,1]', 22),
	(257, 'Ρετσίνα Κεχριμπάρι', '300ml', '/images/products/thalassa/kexrimpari.jpg', 4.00, '[1,1,1,1,1,1,1]', 22);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;

-- Dumping structure for table mourgos.roles
DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12349 DEFAULT CHARSET=utf8;

-- Dumping data for table mourgos.roles: ~4 rows (approximately)
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT IGNORE INTO `roles` (`id`, `Name`) VALUES
	(-1, 'No role'),
	(0, 'Admin'),
	(1, 'Shop'),
	(2, 'Delivery');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Dumping structure for table mourgos.userlogs
DROP TABLE IF EXISTS `userlogs`;
CREATE TABLE IF NOT EXISTS `userlogs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Type` text NOT NULL,
  `Value` text NOT NULL,
  `EntityID` text DEFAULT NULL,
  `Location` text DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL DEFAULT 0,
  `created_on` datetime NOT NULL DEFAULT current_timestamp(),
  UNIQUE KEY `id` (`id`),
  KEY `FK_logs_users` (`user_id`),
  CONSTRAINT `FK_logs_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=174 DEFAULT CHARSET=utf8;

-- Dumping data for table mourgos.userlogs: ~24 rows (approximately)
/*!40000 ALTER TABLE `userlogs` DISABLE KEYS */;
INSERT IGNORE INTO `userlogs` (`id`, `Type`, `Value`, `EntityID`, `Location`, `user_id`, `created_on`) VALUES
	(150, 'Orders', 'Seen - Getting ready', 'tj6ru', NULL, 1, '2017-12-11 15:56:29'),
	(151, 'Orders', 'Seen', 'tj6ru', NULL, 1, '2017-12-11 15:56:29'),
	(152, 'Orders', 'Seen - Getting ready', 't3ge1', NULL, 1, '2017-12-11 16:04:57'),
	(153, 'Orders', 'Seen', 't3ge1', NULL, 1, '2017-12-11 16:04:57'),
	(154, 'Orders', 'Seen - Getting ready', 'tj6mt', NULL, 1, '2017-12-11 16:10:47'),
	(155, 'Orders', 'Seen', 'tj6mt', NULL, 1, '2017-12-11 16:10:47'),
	(156, 'Orders', 'Assigned', 'tj6ru', NULL, 4, '2017-12-11 16:18:33'),
	(157, 'Orders', 'Assigned', 't3ge1', NULL, 4, '2017-12-11 16:18:49'),
	(158, 'Orders', 'Delivered', '1t74w', NULL, 4, '2017-12-11 16:19:01'),
	(159, 'Orders', 'Seen - Getting ready', 'ctr6g', NULL, 1, '2017-12-11 16:20:27'),
	(160, 'Orders', 'Seen', 'ctr6g', NULL, 1, '2017-12-11 16:20:27'),
	(161, 'Orders', 'Assigned', 'tj6mt', NULL, 4, '2017-12-11 16:21:12'),
	(162, 'Orders', 'StatusChange : 2', 'ctr6g', NULL, 1, '2017-12-11 16:25:23'),
	(163, 'Orders', 'Seen - Getting ready', 'e1j74', NULL, 1, '2017-12-11 16:51:14'),
	(164, 'Orders', 'Seen', 'e1j74', NULL, 1, '2017-12-11 16:51:14'),
	(165, 'Orders', 'StatusChange : 2', 'e1j74', NULL, 1, '2017-12-11 16:56:46'),
	(166, 'Orders', 'Seen', 'e1j74', NULL, 4, '2017-12-11 18:10:00'),
	(167, 'Orders', 'Assigned', 'e1j74', NULL, 4, '2017-12-11 18:10:02'),
	(168, 'Orders', 'Seen', 'tkadh', NULL, 4, '2017-12-11 18:10:04'),
	(169, 'Orders', 'Seen', 'ctr6g', NULL, 4, '2017-12-11 18:10:07'),
	(170, 'Orders', 'Assigned', 'ctr6g', NULL, 4, '2017-12-11 18:10:08'),
	(171, 'Orders', 'Delivered', 'e1j74', NULL, 4, '2017-12-11 18:10:14'),
	(172, 'Orders', 'Delivered', 'ctr6g', NULL, 4, '2017-12-11 18:10:17'),
	(173, 'Orders', 'Delivered', 'tj6mt', NULL, 4, '2017-12-11 18:10:21');
/*!40000 ALTER TABLE `userlogs` ENABLE KEYS */;

-- Dumping structure for table mourgos.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `salt` text NOT NULL,
  `token` text NOT NULL,
  `email` text DEFAULT NULL,
  `role` int(5) DEFAULT -1,
  `phone` text DEFAULT NULL,
  `name` text DEFAULT NULL,
  KEY `id` (`id`),
  KEY `FK_users_roles` (`role`),
  CONSTRAINT `FK_users_roles` FOREIGN KEY (`role`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- Dumping data for table mourgos.users: ~4 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT IGNORE INTO `users` (`id`, `username`, `password`, `salt`, `token`, `email`, `role`, `phone`, `name`) VALUES
	(1, 'erisdonuts', 'b6430e53e6e0320b429e94f0ff01f1d959691efb56b0f530c321fd1ca654a62e', 'd1c8a767550ea8006902ca09cbde09e1', '0317c3dfe2396ededc3560fe9a5d058a8bd80f5bfdd355f27bf96ecd9367ea151', '0', 1, '21023568', 'Eris'),
	(2, 'falafelhouse', '883fd3e8dea6a2e6b7029759ccda95399e7b4a23c8895e7c9bf5499d2d2589f7', 'bc1ec782c20a521c91b3bf6dc78bbeaf', '8b029c2c486f093d55e5b96494fd3212f1dec997e786a6d2aafb2b31ef0ac3140', '', 1, '2102565856', 'Falafel'),
	(4, 'mourgos', '2dd66779e9d9bd2e5cd438cfda6591e18ae23a78b5b75c94bb03f88d5c386a89', 'aa37680232bba75852392e52ad61e031', 'ca49696492e153e590f6fea21d139fdacb899e7599f75607118820a4ae74ee171', '', 2, '6983659568', 'Takis'),
	(5, 'admin', '6675754a69d1b94b6730ef8958007dbac8406c7b93c133db60571f121e7d88e9', 'cd98ebd996f0ef0dc1939e336b6cba2c', 'd545fa562f2b046c75f97e570a946881b0efabf129483f0524ef0b9caad9a7431', '', 0, '69999999', 'Admin');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
