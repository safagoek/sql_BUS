-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1:3306
-- Üretim Zamanı: 05 May 2023, 08:14:41
-- Sunucu sürümü: 8.0.31
-- PHP Sürümü: 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `b`
--

DELIMITER $$
--
-- Yordamlar
--
DROP PROCEDURE IF EXISTS `3.1`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `3.1` (IN `Sofor_id` VARCHAR(11), IN `Ad` VARCHAR(255), IN `Soyad` VARCHAR(255), IN `Plaka` VARCHAR(9))   INSERT INTO `sofor` (`Sofor_id`, `Plaka`, `Ad`, `Soyad`) 
VALUES (sofor_id, Plaka, Ad, Soyad)$$

DROP PROCEDURE IF EXISTS `3.10`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `3.10` ()   SELECT ROUND(AVG(otobus.Kapasite)) AS otobus_bası_ortalama_kapasite
FROM otobus$$

DROP PROCEDURE IF EXISTS `3.10_1`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `3.10_1` ()   SELECT otobus.Marka,otobus.Kapasite,otobus.Plaka
FROM bilet,otobus
WHERE bilet.Plaka=otobus.Plaka AND otobus.Kapasite>40$$

DROP PROCEDURE IF EXISTS `3.2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `3.2` (IN `sofor_id` VARCHAR(11))   DELETE FROM sofor 
WHERE sofor.Sofor_id=sofor_id$$

DROP PROCEDURE IF EXISTS `3.3`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `3.3` (IN `kapsite` INT)   UPDATE otobus
SET otobus.Kapasite='150'
WHERE otobus.Kapasite=kapasite AND otobus.Kapasite=(55)$$

DROP PROCEDURE IF EXISTS `3.4`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `3.4` ()   SELECT SUM(otobus.Kapasite)
FROM otobus
WHERE otobus.Kapasite$$

DROP PROCEDURE IF EXISTS `3.5`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `3.5` (IN `sayi` INT(11))   SELECT sefer.Varıs,sefer.Sefer_id, COUNT(yolcu.Yolcu_id) AS yolcu_sayisi
FROM sefer,bilet,yolcu
WHERE sefer.Sefer_id=bilet.Sefer_id AND bilet.Yolcu_id=yolcu.Yolcu_id
GROUP BY sefer.Sefer_id
HAVING yolcu_sayisi<sayi$$

DROP PROCEDURE IF EXISTS `3.6`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `3.6` ()  CREATE VIEW view_bilet AS
SELECT concat(yolcu.Ad, " ",yolcu.Soyad) AS musteri,
concat(sefer.Kalkıs, " ", sefer.Varıs) as rota
FROM yolcu, sefer, bilet
WHERE yolcu.Yolcu_id=bilet.Yolcu_id AND sefer.Sefer_id=bilet.Sefer_id$$

DROP PROCEDURE IF EXISTS `3.7`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `3.7` (IN `kapasite` VARCHAR(255))   SELECT otobus.Plaka,otobus.Kapasite,otobus.Marka,sefer.Varıs,sefer.Kalkıs
FROM otobus,bilet,sefer
WHERE otobus.Plaka=bilet.Plaka AND bilet.Sefer_id=sefer.Sefer_id LIKE CONCAT ('%',kapasite,'%') AND otobus.Kapasite>ANY(SELECT otobus.Kapasite FROM bilet,otobus WHERE bilet.Plaka=otobus.Plaka AND otobus.Kapasite='50')$$

DROP PROCEDURE IF EXISTS `3.8`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `3.8` (IN `sayı1` INT, IN `sayı2` INT)   SELECT otobus.Kapasite, otobus.Plaka, otobus.Marka
FROM otobus
WHERE otobus.Kapasite=otobus.Plaka 
AND otobus.Kapasite BETWEEN sayı1 AND sayı2$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `bilet`
--

DROP TABLE IF EXISTS `bilet`;
CREATE TABLE IF NOT EXISTS `bilet` (
  `Plaka` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `Sefer_id` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `Sofor_id` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `Yolcu_id` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  UNIQUE KEY `Plaka` (`Plaka`,`Sefer_id`,`Sofor_id`,`Yolcu_id`),
  KEY `Sofor_id` (`Sofor_id`),
  KEY `Yolcu_id` (`Yolcu_id`),
  KEY `Sefer_id` (`Sefer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `bilet`
--

INSERT INTO `bilet` (`Plaka`, `Sefer_id`, `Sofor_id`, `Yolcu_id`) VALUES
('35acb112', 'i35i34', '2', '11111111112'),
('35acb112', 'i35i34', '2', '11111111114'),
('35abc111', 'm49i34', '1', '11111111111'),
('35abc111', 'm49i34', '1', '11111111113');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `cinsiyet`
--

DROP TABLE IF EXISTS `cinsiyet`;
CREATE TABLE IF NOT EXISTS `cinsiyet` (
  `Cinsiyet_id` int NOT NULL COMMENT '1)Erkek\r\n2)Kadın',
  `yolcu_id` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  UNIQUE KEY `yolcu_id` (`yolcu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `cinsiyet`
--

INSERT INTO `cinsiyet` (`Cinsiyet_id`, `yolcu_id`) VALUES
(1, '11111111111'),
(1, '11111111112'),
(2, '11111111113'),
(2, '11111111114');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `otobus`
--

DROP TABLE IF EXISTS `otobus`;
CREATE TABLE IF NOT EXISTS `otobus` (
  `Plaka` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `Kapasite` int NOT NULL,
  `Marka` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  PRIMARY KEY (`Plaka`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `otobus`
--

INSERT INTO `otobus` (`Plaka`, `Kapasite`, `Marka`) VALUES
('35abc111', 150, 'Mercedes-Benz'),
('35abc113', 35, 'SETRA'),
('35abc114', 30, 'Isuzu'),
('35acb112', 50, 'MAN'),
('35acb115', 74, 'Volvo'),
('35acb116', 54, 'Neopan');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `sefer`
--

DROP TABLE IF EXISTS `sefer`;
CREATE TABLE IF NOT EXISTS `sefer` (
  `Sefer_id` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `Kalkıs` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `Varıs` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  PRIMARY KEY (`Sefer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `sefer`
--

INSERT INTO `sefer` (`Sefer_id`, `Kalkıs`, `Varıs`) VALUES
('i35i34', 'İzmir', 'İstanbul'),
('m49i34', 'Muş', 'İstanbul');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `sofor`
--

DROP TABLE IF EXISTS `sofor`;
CREATE TABLE IF NOT EXISTS `sofor` (
  `Sofor_id` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `Plaka` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `Ad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `Soyad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  PRIMARY KEY (`Sofor_id`),
  UNIQUE KEY `Plaka` (`Plaka`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `sofor`
--

INSERT INTO `sofor` (`Sofor_id`, `Plaka`, `Ad`, `Soyad`) VALUES
('1', '35abc111', 'Ekrem', 'İMAMSON'),
('2', '35abc112', 'Mansur', 'LAVAŞ'),
('8', '35abc125', 'Freddie ', 'MERCURY');

-- --------------------------------------------------------

--
-- Görünüm yapısı durumu `view_bilet`
-- (Asıl görünüm için aşağıya bakın)
--
DROP VIEW IF EXISTS `view_bilet`;
CREATE TABLE IF NOT EXISTS `view_bilet` (
`musteri` varchar(511)
,`rota` varchar(511)
);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `yolcu`
--

DROP TABLE IF EXISTS `yolcu`;
CREATE TABLE IF NOT EXISTS `yolcu` (
  `Yolcu_id` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `Ad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  `Soyad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci NOT NULL,
  PRIMARY KEY (`Yolcu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

--
-- Tablo döküm verisi `yolcu`
--

INSERT INTO `yolcu` (`Yolcu_id`, `Ad`, `Soyad`) VALUES
('11111111111', 'Safa', 'GÖK'),
('11111111112', 'Ata', 'AVCI'),
('11111111113', 'Irmak', 'EREN'),
('11111111114', 'Selda', 'BAĞCAN');

-- --------------------------------------------------------

--
-- Görünüm yapısı `view_bilet`
--
DROP TABLE IF EXISTS `view_bilet`;

DROP VIEW IF EXISTS `view_bilet`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_bilet`  AS SELECT concat(`yolcu`.`Ad`,' ',`yolcu`.`Soyad`) AS `musteri`, concat(`sefer`.`Kalkıs`,' ',`sefer`.`Varıs`) AS `rota` FROM ((`yolcu` join `sefer`) join `bilet`) WHERE ((`yolcu`.`Yolcu_id` = `bilet`.`Yolcu_id`) AND (`sefer`.`Sefer_id` = `bilet`.`Sefer_id`))  ;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `bilet`
--
ALTER TABLE `bilet`
  ADD CONSTRAINT `bilet_ibfk_1` FOREIGN KEY (`Plaka`) REFERENCES `otobus` (`Plaka`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bilet_ibfk_2` FOREIGN KEY (`Sofor_id`) REFERENCES `sofor` (`Sofor_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bilet_ibfk_3` FOREIGN KEY (`Yolcu_id`) REFERENCES `yolcu` (`Yolcu_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bilet_ibfk_4` FOREIGN KEY (`Sefer_id`) REFERENCES `sefer` (`Sefer_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `yolcu`
--
ALTER TABLE `yolcu`
  ADD CONSTRAINT `yolcu_ibfk_1` FOREIGN KEY (`Yolcu_id`) REFERENCES `cinsiyet` (`yolcu_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
