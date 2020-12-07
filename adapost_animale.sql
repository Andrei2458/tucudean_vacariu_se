-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Gazdă: 127.0.0.1
-- Timp de generare: dec. 07, 2020 la 06:39 PM
-- Versiune server: 10.4.14-MariaDB
-- Versiune PHP: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Bază de date: `adapost_animale`
--

-- --------------------------------------------------------

--
-- Structură tabel pentru tabel `adaposturi`
--

CREATE TABLE `adaposturi` (
  `idAdapost` int(11) NOT NULL,
  `tipAdapost` enum('canin','felin') NOT NULL,
  `locuriDisponibile` int(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Eliminarea datelor din tabel `adaposturi`
--

INSERT INTO `adaposturi` (`idAdapost`, `tipAdapost`, `locuriDisponibile`) VALUES
(1, 'canin', 1),
(2, 'felin', 3),
(3, 'canin', 3);

-- --------------------------------------------------------

--
-- Structură tabel pentru tabel `adoptii`
--

CREATE TABLE `adoptii` (
  `idAdoptie` int(11) NOT NULL,
  `idAnimal` int(11) NOT NULL,
  `idClient` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Eliminarea datelor din tabel `adoptii`
--

INSERT INTO `adoptii` (`idAdoptie`, `idAnimal`, `idClient`) VALUES
(1, 1, 1),
(2, 2, 1);

--
-- Declanșatori `adoptii`
--
DELIMITER $$
CREATE TRIGGER `trig_adpotii` AFTER INSERT ON `adoptii` FOR EACH ROW BEGIN
    UPDATE animal_adapost
    SET dataAdoptie = CURRENT_TIMESTAMP
    -- idAdapost am incercat sa referim idAdapost din adaposturi
    -- cu NEW.idAdapost referim idAdapost din animal_adapost
    WHERE idAnimal = NEW.idAnimal;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structură tabel pentru tabel `animale`
--

CREATE TABLE `animale` (
  `idAnimal` int(11) NOT NULL,
  `tip_animal` enum('caine','pisica') NOT NULL,
  `rasa` varchar(64) NOT NULL,
  `culoare` varchar(64) NOT NULL,
  `varsta` int(11) NOT NULL,
  `sex` enum('mascul','femela','necunoscut') NOT NULL,
  `nume` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Eliminarea datelor din tabel `animale`
--

INSERT INTO `animale` (`idAnimal`, `tip_animal`, `rasa`, `culoare`, `varsta`, `sex`, `nume`) VALUES
(1, 'caine', 'Metis', 'negru', 4, 'mascul', 'Rexi'),
(2, 'pisica', 'Birmaneza', 'maro, crem', 1, 'femela', NULL),
(3, 'caine', 'pug', 'gri', 2, 'femela', 'Mati'),
(4, 'pisica', 'europeana', 'gri cu alb', 1, 'femela', 'Titi');

-- --------------------------------------------------------

--
-- Structură tabel pentru tabel `animal_adapost`
--

CREATE TABLE `animal_adapost` (
  `idAnimalAdapost` int(11) NOT NULL,
  `idAnimal` int(11) NOT NULL,
  `idAdapost` int(11) NOT NULL,
  `dataIntrare` timestamp NOT NULL DEFAULT current_timestamp(),
  `dataAdoptie` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Eliminarea datelor din tabel `animal_adapost`
--

INSERT INTO `animal_adapost` (`idAnimalAdapost`, `idAnimal`, `idAdapost`, `dataIntrare`, `dataAdoptie`) VALUES
(1, 1, 1, '2020-11-28 16:08:04', '2020-11-28 16:39:37'),
(2, 2, 2, '2020-11-28 16:09:39', '2020-11-28 16:45:59');

--
-- Declanșatori `animal_adapost`
--
DELIMITER $$
CREATE TRIGGER `trig_eliberareLoc` AFTER UPDATE ON `animal_adapost` FOR EACH ROW BEGIN
    UPDATE adaposturi
    SET locuriDisponibile = locuriDisponibile + 1
    -- idAdapost am incercat sa referim idAdapost din adaposturi
    -- cu NEW.idAdapost referim idAdapost din animal_adapost
    WHERE idAdapost = NEW.idAdapost;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trig_intrare` AFTER INSERT ON `animal_adapost` FOR EACH ROW BEGIN
    UPDATE adaposturi
    SET locuriDisponibile = locuriDisponibile - 1
    -- idAdapost am incercat sa referim idAdapost din adaposturi
    -- cu NEW.idAdapost referim idAdapost din animal_adapost
    WHERE idAdapost = NEW.idAdapost;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structură tabel pentru tabel `clienti`
--

CREATE TABLE `clienti` (
  `idClient` int(11) NOT NULL,
  `nume` varchar(255) NOT NULL,
  `numarTelefon` varchar(64) NOT NULL,
  `email` varchar(64) NOT NULL,
  `adresa` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Eliminarea datelor din tabel `clienti`
--

INSERT INTO `clienti` (`idClient`, `nume`, `numarTelefon`, `email`, `adresa`) VALUES
(1, 'Mircea Constantin', '0747123456', 'mircea.constantin@yahoo.com', 'Strada Panselutelor, numar 123, Timisoara, Timis');

--
-- Indexuri pentru tabele eliminate
--

--
-- Indexuri pentru tabele `adaposturi`
--
ALTER TABLE `adaposturi`
  ADD PRIMARY KEY (`idAdapost`);

--
-- Indexuri pentru tabele `adoptii`
--
ALTER TABLE `adoptii`
  ADD PRIMARY KEY (`idAdoptie`),
  ADD KEY `idAnimal` (`idAnimal`),
  ADD KEY `idClient` (`idClient`);

--
-- Indexuri pentru tabele `animale`
--
ALTER TABLE `animale`
  ADD PRIMARY KEY (`idAnimal`);

--
-- Indexuri pentru tabele `animal_adapost`
--
ALTER TABLE `animal_adapost`
  ADD PRIMARY KEY (`idAnimalAdapost`),
  ADD KEY `idAnimal` (`idAnimal`),
  ADD KEY `idAdapost` (`idAdapost`);

--
-- Indexuri pentru tabele `clienti`
--
ALTER TABLE `clienti`
  ADD PRIMARY KEY (`idClient`);

--
-- AUTO_INCREMENT pentru tabele eliminate
--

--
-- AUTO_INCREMENT pentru tabele `adaposturi`
--
ALTER TABLE `adaposturi`
  MODIFY `idAdapost` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pentru tabele `adoptii`
--
ALTER TABLE `adoptii`
  MODIFY `idAdoptie` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pentru tabele `animale`
--
ALTER TABLE `animale`
  MODIFY `idAnimal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pentru tabele `animal_adapost`
--
ALTER TABLE `animal_adapost`
  MODIFY `idAnimalAdapost` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pentru tabele `clienti`
--
ALTER TABLE `clienti`
  MODIFY `idClient` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constrângeri pentru tabele eliminate
--

--
-- Constrângeri pentru tabele `adoptii`
--
ALTER TABLE `adoptii`
  ADD CONSTRAINT `adoptii_ibfk_1` FOREIGN KEY (`idClient`) REFERENCES `clienti` (`idClient`),
  ADD CONSTRAINT `adoptii_ibfk_2` FOREIGN KEY (`idAnimal`) REFERENCES `animale` (`idAnimal`);

--
-- Constrângeri pentru tabele `animal_adapost`
--
ALTER TABLE `animal_adapost`
  ADD CONSTRAINT `animal_adapost_ibfk_1` FOREIGN KEY (`idAnimal`) REFERENCES `animale` (`idAnimal`),
  ADD CONSTRAINT `animal_adapost_ibfk_2` FOREIGN KEY (`idAdapost`) REFERENCES `adaposturi` (`idAdapost`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
