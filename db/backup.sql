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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- Dumping data for table mourgos.attributes: ~3 rows (approximately)
/*!40000 ALTER TABLE `attributes` DISABLE KEYS */;
INSERT IGNORE INTO `attributes` (`id`, `Name`, `Options`, `Price`, `product_id`) VALUES
	(8, 'Γέμιση', '["Σοκολάτα","Φράουλα"]', 0.20, 82),
	(9, 'Επικάλυψη', '["Σοκολάτα","Λευκή Σοκολάτα"]', 0.40, 82),
	(10, 'Γέμιση', '["Σοκολάτα","Φράουλα"]', 0.20, 83);
/*!40000 ALTER TABLE `attributes` ENABLE KEYS */;

-- Dumping structure for table mourgos.catalogues
DROP TABLE IF EXISTS `catalogues`;
CREATE TABLE IF NOT EXISTS `catalogues` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` text DEFAULT NULL,
  `Image` text DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `FriendlyURL` text DEFAULT NULL,
  `WorkingDates` text DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Dumping data for table mourgos.catalogues: ~3 rows (approximately)
/*!40000 ALTER TABLE `catalogues` DISABLE KEYS */;
INSERT IGNORE INTO `catalogues` (`id`, `Name`, `Image`, `Description`, `FriendlyURL`, `WorkingDates`) VALUES
	(1, 'Eri\'s Donuts', '/images/erisdonuts.png', 'Τα περίφημα πιο λαχταριστά donuts της Θεσσαλονίκης', 'ErisDonuts', NULL),
	(2, 'Falafel House', '/images/donuts.png', 'Φαλάφελ, Σαλάτες, Φρέσκοι χυμοί', 'FalafelHouse', NULL),
	(3, 'Greek Natural', '/images/donuts.png', 'Λαχταριστές σαλάτες, φρέσκοι χυμοί και δροσερά smoothies', 'GreekNatural', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- Dumping data for table mourgos.categories: ~14 rows (approximately)
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
	(19, 'Ροφήματα', 1);
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
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8;

-- Dumping data for table mourgos.products: ~87 rows (approximately)
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT IGNORE INTO `products` (`id`, `Name`, `Description`, `Image`, `Price`, `category_id`) VALUES
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
	(40, 'Νερό', '500ml', '', 0.50, 11),
	(41, 'Caesar\'s', 'Τρυφερό φιλέτο κοτόπουλο, μαρούλι, iceberg, σουσάμι', '', 2.50, 12),
	(42, 'Τονοσαλάτα', 'Μαρούλι, καλαμπόκι, τόνος, καρύδι, σως μαγιονέζας', '', 2.50, 12),
	(43, 'Μποτσαρέλα', 'Μαρούλι, ρόκα, λιαστή ντομάτα, μποτσαρέλα, σουσάμι, σως παλαιωμένου βαλσαμικού, ανθόμελο', '', 2.50, 12),
	(44, 'Σαλάτα Φρούτων', 'Iceberg, μαρούλι, διάφορα φρούτα, mix nuts, σως παλαιωμένου βαλσαμικού, ανθόμελο', '', 2.50, 12),
	(45, 'Φακοσαλάτα', 'Φακές, ρύζι, τυρί, ντομάτα, πιπεριά, φρέσκο κρεμμυδάκι, μαϊντανός, άνηθος, ρίγανη', '', 2.50, 12),
	(46, 'Σαλάτα Ζυμαρικών', 'Ζυμαρικά, ντομάτα, ελιές, κάπαρη, τόνος', '', 2.50, 12),
	(47, 'Πάρτυ Φράουλας', 'Φράουλες, μπανάνα, γάλα, μέλι & παγωμένο γιαούρτι', '', 3.00, 13),
	(48, 'Δροσερή Μπανάνα', 'Μπανάνα, γάλα, μέλι, σιρόπι βανίλιας & παγωμένο γιαούρτι', '', 3.00, 13),
	(49, 'Σοκολατοπειρασμός', 'Μπανάνα, σοκολάτα, γάλα, σιρόπι βανίλιας & παγωμένο γιαούρτι', '', 3.00, 13),
	(50, 'Πρωινή Απόλαυση', 'Καφές, γάλα, σιρόπι βανίλιας, μπανάνα & παγωμένο γιαούρτι', '', 3.00, 13),
	(51, 'Γεύση Ροδάκινου', 'Μπανάνα, ροδάκινο, γάλα & παγωμένο γιαούρτι', '', 3.00, 13),
	(52, 'Πρωινή Δύναμη', 'Μπανάνα, αχλάδι, γάλα, μέλι, σιρόπι βανίλιας, δημητριακά & παγωμένο γιαούρτι', '', 3.00, 13),
	(53, 'Διάλλειμα για Καφέ', 'Καφές, γάλα & παγωμένο γιαούρτι', '', 3.00, 13),
	(54, 'Φραουλοκοκτέιλ', 'Φράουλες, μπανάνα, μήλο, ροδάκινο & παγωμένο γιαούρτι', '', 3.00, 14),
	(55, 'Πανδαισία Μούρων', 'Μούρα εποχής, μήλο & παγωμένο γιαούρτι', '', 3.00, 14),
	(56, 'Μανγκομαγεία', 'Μάνγκο, μπανάνα, ανανάς & παγωμένο γιαούρτι', '', 3.00, 14),
	(57, 'Ανανάς Εξωτικός', 'Ανανάς, ροδάκινο & παγωμένο γιαούρτι', '', 3.00, 14),
	(58, 'Χυμώδες Ροδάκινο', 'Ροδάκινο, μήλο, μέλι & παγωμένο γιαούρτι', '', 3.00, 14),
	(59, 'Μυθικό Πρωινό', 'Μπανάνα, φράουλες, ανανάς, δημητριακά, μέλι & παγωμένο γιαούρτι', '', 3.00, 14),
	(60, 'Ονειρεμένο Μάνγκο', 'Μάνγκο, πορτοκάλι, μέλι & παγωμένο γιαούρτι', '', 3.00, 14),
	(61, 'Έκρηξη Ροδάκινου', 'Ροδάκινο, μήλο & σορμπέ φράουλα', '', 3.00, 15),
	(62, 'Άγριο Καρπούζι', 'Καρπούζι, μούρα & σορμπέ φράουλα', '', 3.00, 15),
	(63, 'Καλή Γραμμή', 'Ανανάς, μούρα, μήλο & σορμπέ μούρου', '', 3.00, 15),
	(64, 'Γεύση Καρύδας', 'Ανανάς, μπανάνα, καρύδα & σορμπέ λεμονιού', '', 3.00, 15),
	(65, 'Φρουτοσαλάτα', 'Φρουτοσαλάτα & σορμπέ λεμονιού', '', 3.00, 15),
	(66, 'Μανγκομανία', 'Μάνγκο, μπανάνα, φράουλες, ανανάς & σορμπέ μάνγκο', '', 3.00, 15),
	(67, 'Άρωμα Φρεσκάδας', 'Μπανάνα, ροδάκινο, φράουλες, ανανάς & σορμπέ φράουλα', '', 3.00, 15),
	(68, 'Μπαχάμες', 'Μπανάνα, ανανάς, πορτοκάλι & μέλι', '', 2.50, 16),
	(69, 'Τροπικό Τανγκό', 'Ανανάς, ροδάκινο, πορτοκάλι & πεπόνι', '', 2.50, 16),
	(70, 'Επανενεργοποίηση', 'Μπανάνα, ανανάς, φράουλες & πορτοκάλι', '', 2.50, 16),
	(71, 'Δυνατό Ξεκίνημα', 'Ανανάς, πορτοκάλι, γκρέιπφρουτ & λεμόνι', '', 2.50, 16),
	(72, 'Καλοκαιρινή Πανδαισία', 'Φράουλες, μήλο, πεπόνι & καρπούζι', '', 2.50, 16),
	(73, 'Φρεσκάδα Δυόσμου', 'Ανανάς, μήλο & δυόσμος', '', 2.50, 16),
	(74, 'Βιταμινούχο Αδυνάτισμα', 'Ανανάς, πορτοκάλι, μήλο & ακτινίδιο', '', 2.50, 16),
	(75, 'Φυσικός Χυμός Πορτοκάλι', '', '', 1.50, 16),
	(76, 'Φυσικός Χυμός Πορτοκάλι - Ρόδι', '', '', 2.50, 16),
	(77, 'Φρουτοσαλάτα', 'Διάφορα φρούτα εποχής', '', 2.00, 17),
	(78, 'Φρουτοσαλάτα με Γιαούρτι, Μέλι και Δημητριακά', '', '', 2.50, 17),
	(79, 'Φρουτοσαλάτα με Πραλίνα Σοκολάτα ή Μέλι', '', '', 2.50, 17),
	(80, 'Φρουτοσαλάτα με Μούρα', '', '', 2.50, 17),
	(81, 'Φρουτοσαλάτα με Παγωμένο Γιαούρτι', '', '', 3.30, 17),
	(82, 'Μεσαίο donut με γέμιση', 'Γέμιση της επιλογής σας.', '', 1.20, 18),
	(83, 'Μεσαίο donut με γέμιση & επικάλυψη', 'Γέμιση και επικάλυψη της επιλογής σας.', '', 1.40, 18),
	(84, 'Μεσαίο donut με γέμιση & επικάλυψη σπέσιαλ', 'Γέμιση και επικάλυψη της επιλογής σας.', '', 1.70, 18),
	(85, 'Μεγάλο donut με γέμιση', 'Γέμιση της επιλογής σας.', '', 1.40, 18),
	(86, 'Μεγάλο donut με γέμιση & επικάλυψη', 'Γέμιση και επικάλυψη της επιλογής σας.', '', 1.60, 18),
	(87, 'Μεγάλο donut με γέμιση & επικάλυψη', 'Γέμιση και επικάλυψη της επιλογής σας.', '', 1.90, 18),
	(88, 'Μικρά donuts με γέμιση & επικάλυψη (4άδα)', 'Γέμιση και επικάλυψη της επιλογής σας.', '', 3.80, 18),
	(89, 'Eri\'s glaze donut', '', '', 3.20, 18),
	(90, 'Γάλα άσπρο', '', '', 1.30, 19),
	(91, 'Γάλα σοκολατούχο μικρό', '', '', 1.50, 19),
	(92, 'Γάλα σοκολατούχο μεγάλο', '', '', 1.80, 19),
	(93, 'Αριάνι', '', '', 1.40, 19),
	(94, 'Νερό', '', '', 0.50, 19),
	(95, 'Χυμός (παιδικός)', '', '', 0.80, 19);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
