-- --------------------------------------------------------
        -- Host:                         localhost
        -- Server version:               5.7.25-0ubuntu0.16.04.2 - (Ubuntu)
        -- Server OS:                    Linux
        -- HeidiSQL Version:             9.5.0.5196
        -- --------------------------------------------------------

        /*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
        /*!40101 SET NAMES utf8 */;
        /*!50503 SET NAMES utf8mb4 */;
        /*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
        /*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


        -- Dumping database structure for faketwitter
        CREATE DATABASE IF NOT EXISTS `faketwitter` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;
        USE `faketwitter`;

        -- Dumping structure for table faketwitter.tweets
        CREATE TABLE IF NOT EXISTS `tweets` (
          `id` int(11) NOT NULL AUTO_INCREMENT,
          `user_id` int(11) DEFAULT NULL,
          `contents` text COLLATE utf8_bin,
          `created_at` datetime DEFAULT NULL,
          PRIMARY KEY (`id`)
        ) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

        -- Dumping data for table faketwitter.tweets: ~0 rows (approximately)
        /*!40000 ALTER TABLE `tweets` DISABLE KEYS */;
        INSERT INTO `tweets` (`id`, `user_id`, `contents`, `created_at`) VALUES
        	(1, 1, 'My First Twteet', '2019-01-24 11:06:18');
        /*!40000 ALTER TABLE `tweets` ENABLE KEYS */;

        -- Dumping structure for table faketwitter.users
        CREATE TABLE IF NOT EXISTS `users` (
          `id` int(11) NOT NULL AUTO_INCREMENT,
          `email` varchar(255) COLLATE utf8_bin DEFAULT NULL,
          `username` varchar(255) COLLATE utf8_bin DEFAULT NULL,
          `password_hash` varchar(255) COLLATE utf8_bin DEFAULT NULL,
          `profile_pic_url` varchar(255) COLLATE utf8_bin DEFAULT NULL,
          PRIMARY KEY (`id`)
        ) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

        -- Dumping data for table faketwitter.users: ~0 rows (approximately)
        /*!40000 ALTER TABLE `users` DISABLE KEYS */;
        INSERT INTO `users` (`id`, `email`, `username`, `password_hash`, `profile_pic_url`) VALUES
        	(1, 'savage@calebcalebcaleb.com', 'caleb', NULL, NULL);
        /*!40000 ALTER TABLE `users` ENABLE KEYS */;

        /*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
        /*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
        /*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
