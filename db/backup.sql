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
  UNIQUE KEY `id` (`id`),
  KEY `fk_product_id` (`product_id`),
  CONSTRAINT `fk_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- Dumping data for table mourgos.attributes: ~4 rows (approximately)
/*!40000 ALTER TABLE `attributes` DISABLE KEYS */;
INSERT IGNORE INTO `attributes` (`id`, `Name`, `Options`, `Price`, `product_id`) VALUES
	(8, 'Γέμιση', '["Σοκολάτα","Φράουλα"]', 0.20, 82),
	(9, 'Επικάλυψη', '["Σοκολάτα","Λευκή Σοκολάτα"]', 0.40, 82),
	(10, 'Γέμιση', '["Σοκολάτα","Φράουλα"]', 0.20, 83),
	(11, 'TestAttribute', '["Με τεστ"]', 0.00, 82);
/*!40000 ALTER TABLE `attributes` ENABLE KEYS */;

-- Dumping structure for table mourgos.catalogues
CREATE TABLE IF NOT EXISTS `catalogues` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` text DEFAULT NULL,
  `Image` text DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `FriendlyURL` text DEFAULT NULL,
  `WorkingDates` text DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Dumping data for table mourgos.catalogues: ~4 rows (approximately)
/*!40000 ALTER TABLE `catalogues` DISABLE KEYS */;
INSERT IGNORE INTO `catalogues` (`id`, `Name`, `Image`, `Description`, `FriendlyURL`, `WorkingDates`) VALUES
	(1, 'Eri\'s Donuts', '/images/eris_donuts.png', 'Τα περίφημα πιο λαχταριστά donuts της Θεσσαλονίκης', 'ErisDonuts', NULL),
	(2, 'Falafel House', '/images/falafel_house.png', 'Φαλάφελ, Σαλάτες, Φρέσκοι χυμοί', 'FalafelHouse', NULL),
	(3, 'Greek Natural', '/images/greek_natural.png', 'Λαχταριστές σαλάτες, φρέσκοι χυμοί και δροσερά smoothies', 'GreekNatural', NULL),
	(4, 'Θάλασσα', '/images/thalassa.png', NULL, 'Thalassa', NULL);
/*!40000 ALTER TABLE `catalogues` ENABLE KEYS */;

-- Dumping structure for table mourgos.categories
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

-- Dumping structure for table mourgos.products
CREATE TABLE IF NOT EXISTS `products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` text NOT NULL,
  `Description` text NOT NULL DEFAULT '',
  `Image` text NOT NULL DEFAULT '',
  `Price` decimal(10,2) NOT NULL,
  `Days` text DEFAULT NULL,
  `category_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `fk_category_id` (`category_id`),
  CONSTRAINT `fk_category_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=utf8;

-- Dumping data for table mourgos.products: ~141 rows (approximately)
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT IGNORE INTO `products` (`id`, `Name`, `Description`, `Image`, `Price`, `Days`, `category_id`) VALUES
	(9, 'Baba-Ganouj - Tabouleh Size M', 'Μελιτζάνα, ταχίνι, ντομάτα, μαϊντανός, φρέσκο κρεμμύδι, πλιγούρι', '', 2.80, '[1,1,1,1,1,1,1]', 2),
	(10, 'Baba-Ganouj - Tabouleh Size L', 'Μελιτζάνα, ταχίνι, ντομάτα, μαϊντανός, φρέσκο κρεμμύδι, πλιγούρι', '', 3.00, '[1,1,1,1,1,1,1]', 2),
	(11, 'Baba-Ganouj - Tabouleh Size XL', 'Μελιτζάνα, ταχίνι, ντομάτα, μαϊντανός, φρέσκο κρεμμύδι, πλιγούρι', '', 3.20, '[1,1,1,1,1,1,1]', 2),
	(12, 'Baba-Ganouj - Fattoush Size M', 'Μελιτζάνα, ταχίνι, λάχανο, μαρούλι, αγγούρι, καρότο, πιπεριά ', '', 2.80, '[1,1,1,1,1,1,1]', 2),
	(13, 'Baba-Ganouj - Fattoush Size L', 'Μελιτζάνα, ταχίνι, λάχανο, μαρούλι, αγγούρι, καρότο, πιπεριά ', '', 3.00, '[1,1,1,1,1,1,1]', 2),
	(14, 'Baba-Ganouj - Fattoush Size XL', 'Μελιτζάνα, ταχίνι, λάχανο, μαρούλι, αγγούρι, καρότο, πιπεριά ', '', 3.20, '[1,1,1,1,1,1,1]', 2),
	(15, 'Hummus - Tabbouleh Size M', 'Ρεβύθι, ταχίνι, ντομάτα, μαϊντανός, φρέσκο κρεμμύδι, πλιγούρι', '', 2.80, '[1,1,1,1,1,1,1]', 2),
	(16, 'Hummus - Tabbouleh Size L', 'Ρεβύθι, ταχίνι, ντομάτα, μαϊντανός, φρέσκο κρεμμύδι, πλιγούρι', '', 3.00, '[1,1,1,1,1,1,1]', 2),
	(17, 'Hummus - Tabbouleh Size XL', 'Ρεβύθι, ταχίνι, ντομάτα, μαϊντανός, φρέσκο κρεμμύδι, πλιγούρι', '', 3.20, '[1,1,1,1,1,1,1]', 2),
	(18, 'Hummus - Fattoush Size M', 'Ρεβύθι, ταχίνι, λάχανο, μαρούλι, αγγούρι, καρότο, πιπεριά', '', 2.80, '[1,1,1,1,1,1,1]', 2),
	(19, 'Hummus - Fattoush Size L', 'Ρεβύθι, ταχίνι, λάχανο, μαρούλι, αγγούρι, καρότο, πιπεριά', '', 3.00, '[1,1,1,1,1,1,1]', 2),
	(20, 'Hummus - Fattoush Size XL', 'Ρεβύθι, ταχίνι, λάχανο, μαρούλι, αγγούρι, καρότο, πιπεριά', '', 3.20, '[1,1,1,1,1,1,1]', 2),
	(21, 'Αλοιφή Small', '', '', 2.00, '[1,1,1,1,1,1,1]', 5),
	(22, 'Αλοιφή Big', '', '', 4.00, '[1,1,1,1,1,1,1]', 5),
	(23, 'Σαλάτα Small', '', '', 2.00, '[1,1,1,1,1,1,1]', 5),
	(24, 'Σαλάτα Big', '', '', 4.00, '[1,1,1,1,1,1,1]', 5),
	(25, 'Φαλάφελ Small', '6 τεμάχια', '', 2.00, '[1,1,1,1,1,1,1]', 5),
	(26, 'Φαλάφελ Big', '12 τεμάχια', '', 4.00, '[1,1,1,1,1,1,1]', 5),
	(27, 'Φαλάφελ Full', '6 τεμάχια φαλάφελ, πατάτες, σαλάτα, αλοιφή, 1 πίτα', '', 5.50, '[1,1,1,1,1,1,1]', 5),
	(28, 'Φαλάφελ Full+', '12 τεμάχια φαλάφελ, πατάτες, σαλάτα, αλοιφή, 1 πίτα', '', 7.50, '[1,1,1,1,1,1,1]', 5),
	(29, 'Φρέσκες Τηγανητές Πατάτες', '', '', 2.50, '[1,1,1,1,1,1,1]', 5),
	(30, 'Vegan Mayo Falafel Burger', 'Μπιφτέκι φαλάφελ, 100% vegan μαγιονέζα, ντομάτα, κρεμμύδι, μαρούλι, πίκλες', '', 4.20, '[1,1,1,1,1,1,1]', 8),
	(31, 'Guacamole Falafel Burger', 'Μπιφτέκι φαλάφελ, guacamole, ντομάτα, κρεμμύδι, μαρούλι, πίκλες', '', 4.20, '[1,1,1,1,1,1,1]', 8),
	(32, 'Τηγανητή Μπανάνα', '', '', 2.50, '[1,1,1,1,1,1,1]', 9),
	(33, 'Green Machine', 'Φύλλα σπανάκι, αγγούρι, καρότο, πράσινο μήλο', '', 3.70, '[1,1,1,1,1,1,1]', 10),
	(34, 'The Usual', 'Κόκκινο μήλο, πορτοκάλι, καρότο', '', 3.70, '[1,1,1,1,1,1,1]', 10),
	(35, 'Sweetheart', 'Κόκκινο μήλο, πατζάρι, καρότο', '', 3.70, '[1,1,1,1,1,1,1]', 10),
	(36, 'Mediterranean', 'Ντομάτα, καρότο, αγγούρι, μαϊντανός, κόκκινη πιπεριά, αλάτι, πιπέρι', '', 3.70, '[1,1,1,1,1,1,1]', 10),
	(37, 'Αναψυκτικά', 'Green Cola, Ble, Coca Cola', '', 1.20, '[1,1,1,1,1,1,1]', 11),
	(38, 'Μπύρες', 'Kaiser, Stella, Βεργίνα, Buckler', '', 1.70, '[1,1,1,1,1,1,1]', 11),
	(39, 'Χυμοί', 'Ρόδι', '', 2.50, '[1,1,1,1,1,1,1]', 11),
	(40, 'Νερό', '500ml', '', 0.50, '[1,1,1,1,1,1,1]', 11),
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
	(84, 'Μεσαίο donut με γέμιση & επικάλυψη σπέσιαλ', 'Γέμιση και επικάλυψη της επιλογής σας.', '/images/products/epikalypsi_special.jpg', 1.70, '[1,1,1,1,1,1,1]', 18),
	(85, 'Μεγάλο donut με γέμιση', 'Γέμιση της επιλογής σας.', '/images/products/gemisi.jpg', 1.40, '[1,1,1,1,1,1,1]', 18),
	(86, 'Μεγάλο donut με γέμιση & επικάλυψη', 'Γέμιση και επικάλυψη της επιλογής σας.', '/images/products/epikalypsi_special.jpg', 1.90, '[1,1,1,1,1,1,1]', 18),
	(87, 'Μεγάλο donut με γέμιση & επικάλυψη', 'Γέμιση και επικάλυψη της επιλογής σας.', '/images/products/epikalypsi_special.jpg', 1.90, '[1,1,1,1,1,1,1]', 18),
	(88, 'Μικρά donuts με γέμιση & επικάλυψη (4άδα)', 'Γέμιση και επικάλυψη της επιλογής σας.', '/images/products/mikra_mazi.jpg', 3.80, '[1,1,1,1,1,1,1]', 18),
	(89, 'Eri\'s glaze donut', '', '/images/products/glaze.jpeg', 3.20, '[1,1,1,1,1,1,1]', 18),
	(90, 'Γάλα άσπρο', '', '/images/products/milk.jpg', 1.30, '[1,1,1,1,1,1,1]', 19),
	(91, 'Γάλα σοκολατούχο μικρό', '', '/images/products/choco_milk.jpg', 1.50, '[1,1,1,1,1,1,1]', 19),
	(92, 'Γάλα σοκολατούχο μεγάλο', '', '/images/products/choco_milk.jpg', 1.80, '[1,1,1,1,1,1,1]', 19),
	(93, 'Αριάνι', '', '/images/products/ariani.jpg', 1.40, '[1,1,1,1,1,1,1]', 19),
	(94, 'Νερό', '', '/images/products/nero.jpg', 0.50, '[1,1,1,1,1,1,1]', 19),
	(95, 'Χυμός (παιδικός)', '', '/images/products/juice.png', 0.80, '[1,1,1,1,1,1,1]', 19),
	(96, 'Γαριδομακαρονάδα', '', '/images/products/thalassa/shrimps.jpg', 6.50, '[1,1,1,1,1,1,1]', 20),
	(97, 'Ψαρόσπουπα', '', '/images/products/thalassa/soup.jpg', 5.50, '[1,1,1,1,1,1,1]', 20),
	(98, 'Τορτίγια Ψαριού', '', '/images/products/thalassa/tortilla.jpg', 4.00, '[1,1,1,1,1,1,1]', 20),
	(99, 'Μπακαλιάρος Σκορδαλιά', '', '/images/products/thalassa/baca.jpg', 7.00, '[0,1,0,0,0,0,0]', 20),
	(100, 'Burger Ψαριού', '', '/images/products/thalassa/burger.jpg', 4.50, '[0,0,0,0,0,0,1]', 20),
	(101, 'Μερίδα Σουβλάκι Τόνου με Πατάτες', '', '/images/products/thalassa/souvlaki.jpg', 6.50, '[1,1,1,1,1,1,1]', 20),
	(102, 'Τσιπούρα Ιχθ. Σχάρας', '', '', 6.50, '[1,1,1,1,1,1,1]', 20),
	(103, 'Λαυράκι Ιχθ. Σχάρας', '', '', 6.00, '[1,1,1,1,1,1,1]', 20),
	(104, 'Χιόνα Ιχθ. Σχάρας', '', '', 6.50, '[1,1,1,1,1,1,1]', 20),
	(105, 'Ψητά Λαχανικά', '', '', 3.80, '[1,1,1,1,1,1,1]', 20),
	(106, 'Μπακαλιάρος Σκορδαλιά', '', '/images/products/thalassa/baca.jpg', 7.00, '[0,1,0,0,0,0,0]', 20),
	(107, 'Πέρκα με Σωτέ Λαχανικά', '', '/images/products/thalassa/perka.jpg', 7.00, '[0,1,0,0,0,0,0]', 20),
	(108, 'Λαχανοντολμάδες με Τόνο και Θαλασσινά', '', '', 7.00, '[0,0,1,0,0,0,0]', 20),
	(109, 'Μυδοπίλαφο', '', '', 6.50, '[0,0,1,0,0,0,0]', 20),
	(110, 'Σουπιές με Σπανάκι', '', '', 7.50, '[0,0,0,1,0,0,0]', 20),
	(111, 'Χταπόδι με Κοφτό Μακαρόνι', '', '/images/products/thalassa/xtapodi.jpg', 6.50, '[0,0,0,1,0,0,0]', 20),
	(112, 'Σουβλάκι Τόνου με Πουρέ Σελινόριζας', '', '/images/products/thalassa/souvlaki2.jpg', 6.50, '[0,0,0,0,1,0,0]', 20),
	(113, 'Πένες με Σολομό και Σάλτσα Βενετσιάνα', '', '/images/products/thalassa/penes.jpg', 7.00, '[0,0,0,0,1,0,0]', 20),
	(114, 'Γεμιστά με Θαλασσινά', '', '', 5.50, '[0,0,0,0,0,1,0]', 20),
	(115, 'Θράψαλο Γεμιστό με Θαλασσινά', '', '', 7.00, '[0,0,0,0,0,1,0]', 20),
	(116, 'Σολομός με Σωτέ Λαχανικά', '', '', 7.50, '[0,0,0,0,0,0,1]', 20),
	(117, 'Burger Ψαριού', '', '/images/products/thalassa/burger.jpg', 4.50, '[0,0,0,0,0,0,1]', 20),
	(118, 'Κριθαρώτο Θαλασσινών', '', '/images/products/thalassa/kritharoto.jpg', 7.00, '[1,0,0,0,0,0,0]', 20),
	(119, 'Ψάρι αλά Σπατσιώτα', '', '', 6.50, '[1,0,0,0,0,0,0]', 20),
	(120, 'Χόρτα (Αντίδια ή Βλήτα)', '', '', 2.50, '[1,1,1,1,1,1,1]', 21),
	(121, 'Coca Cola Κουτί', '330ml', '/images/products/thalassa/cola_can.jpg', 1.20, '[1,1,1,1,1,1,1]', 22),
	(122, 'Coca Cola Zero Κουτί', '330ml', '/images/products/thalassa/cola_zero_can.jpg', 1.20, '[1,1,1,1,1,1,1]', 22),
	(123, 'Coca Cola Στέβια Κουτί', '330ml', '/images/products/thalassa/cola_stevia_can.jpg', 1.20, '[1,1,1,1,1,1,1]', 22),
	(124, 'Coca Cola Light Κουτί', '330ml', '/images/products/thalassa/cola_light_can.jpg', 1.20, '[1,1,1,1,1,1,1]', 22),
	(125, 'Fanta Πορτοκαλάδα', '330ml', '/images/products/thalassa/fanta_orange_can.jpg', 1.20, '[1,1,1,1,1,1,1]', 22),
	(126, 'Fanta Λεμονάδα', '330ml', '/images/products/thalassa/fanta_lemon_can.jpg', 1.20, '[1,1,1,1,1,1,1]', 22),
	(127, 'Sprite', '330ml', '/images/products/thalassa/sprite_can.jpg', 1.20, '[1,1,1,1,1,1,1]', 22),
	(128, 'Schweppes (Σόδα)', '330ml', '/images/products/thalassa/soda.png', 1.20, '[1,1,1,1,1,1,1]', 22),
	(129, 'Coca Cola Μπουκάλι', '500ml', '/images/products/thalassa/cola_bottle.jpg', 1.60, '[1,1,1,1,1,1,1]', 22),
	(130, 'Coca Cola Zero Μπουκάλι', '500ml', '/images/products/thalassa/cola_zero_bottle.jpg', 1.60, '[1,1,1,1,1,1,1]', 22),
	(131, 'Coca Cola Light Μπουκάλι', '500ml', '/images/products/thalassa/cola_light_bottle.jpg', 1.60, '[1,1,1,1,1,1,1]', 22),
	(132, 'Νερό', '330ml', '/images/products/thalassa/nero.jpg', 0.50, '[1,1,1,1,1,1,1]', 22),
	(133, 'Ούζο Πλωμάρι', '200ml', '/images/products/thalassa/plomari.jpg', 4.50, '[1,1,1,1,1,1,1]', 22),
	(134, 'Ούζο Παπρά', '100ml', '/images/products/thalassa/papra.jpg', 2.50, '[1,1,1,1,1,1,1]', 22),
	(135, 'Ούζο Μπαμπατζίμ', '200ml', '/images/products/thalassa/babatzim.png', 5.50, '[1,1,1,1,1,1,1]', 22),
	(136, 'Τσίπουρο Δεκαράκι', '200ml', '/images/products/thalassa/dekaraki.jpg', 4.50, '[1,1,1,1,1,1,1]', 22),
	(137, 'Τσίπουρο Μπαμπατζίμ (με Γλυκάνισο)', '200ml', '/images/products/thalassa/babatzim_tsipouro_me.png', 5.80, '[1,1,1,1,1,1,1]', 22),
	(138, 'Τσίπουρο Μπαμπατζίμ (χωρίς Γλυκάνισο)', '200ml', '/images/products/thalassa/babatzim_tsipouro.png', 5.80, '[1,1,1,1,1,1,1]', 22),
	(139, 'Τσίπουρο Παπρά (με Γλυκάνισο)', '700ml', '/images/products/thalassa/papra_tsipouro.jpg', 12.00, '[1,1,1,1,1,1,1]', 22),
	(140, 'Τσίπουρο Παπρά (χωρίς Γλυκάνισο)', '700ml', '/images/products/thalassa/papra_tsipouro.jpg', 12.00, '[1,1,1,1,1,1,1]', 22),
	(141, 'Τσίπουρο Παπρά (με Γλυκάνισο)', '700ml', '/images/products/thalassa/papra_tsipouro.jpg', 12.00, '[1,1,1,1,1,1,1]', 22),
	(142, 'Τσίπουρο Παπρά (χωρίς Γλυκάνισο)', '700ml', '/images/products/thalassa/papra_tsipouro.jpg', 12.00, '[1,1,1,1,1,1,1]', 22),
	(143, 'Μπύρα ΑΛΦΑ', '330ml', '/images/products/thalassa/alfa330.jpg', 1.60, '[1,1,1,1,1,1,1]', 22),
	(144, 'Μπύρα ΑΛΦΑ', '330ml', '/images/products/thalassa/alfa330.jpg', 1.60, '[1,1,1,1,1,1,1]', 22),
	(145, 'Amstel', '330ml', '/images/products/thalassa/amstel330.jpg', 1.60, '[1,1,1,1,1,1,1]', 22),
	(146, 'Amstel Free', '330ml', '/images/products/thalassa/amstel_free.jpg', 1.60, '[1,1,1,1,1,1,1]', 22),
	(147, 'Amstel Radler', '330ml', '/images/products/thalassa/asmtel_radler.jpg', 1.60, '[1,1,1,1,1,1,1]', 22),
	(148, 'Heineken', '330ml', '/images/products/thalassa/heineken.jpg', 1.60, '[1,1,1,1,1,1,1]', 22),
	(149, 'Ρετσίνα Κεχριμπάρι', '300ml', '/images/products/thalassa/kexrimpari.jpg', 4.00, '[1,1,1,1,1,1,1]', 22);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
