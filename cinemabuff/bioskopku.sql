-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 07, 2018 at 04:02 AM
-- Server version: 10.1.28-MariaDB
-- PHP Version: 7.1.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bioskopku`
--

-- --------------------------------------------------------

--
-- Table structure for table `bioskop`
--

CREATE TABLE `bioskop` (
  `idbioskop` int(11) NOT NULL,
  `namabioskop` varchar(45) DEFAULT NULL,
  `lokasi` varchar(45) DEFAULT NULL,
  `film_namafilm` varchar(45) NOT NULL,
  `idjadwal` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `idbooking` int(11) NOT NULL,
  `statusbooking` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `film`
--

CREATE TABLE `film` (
  `idfilm` int(11) NOT NULL,
  `namafilm` varchar(45) NOT NULL,
  `review` varchar(45) DEFAULT NULL,
  `idjadwal` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `jadwaltayang`
--

CREATE TABLE `jadwaltayang` (
  `idjadwal` int(11) NOT NULL,
  `jamtayang` datetime DEFAULT NULL,
  `tgltayang` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `nohp` int(11) NOT NULL,
  `password` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pemesan`
--

CREATE TABLE `pemesan` (
  `nohp` int(11) NOT NULL,
  `username` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  `gender` enum('Female','Male') NOT NULL,
  `birthdate` date DEFAULT NULL,
  `password` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `saldo`
--

CREATE TABLE `saldo` (
  `balance` varchar(45) NOT NULL,
  `pemesan_nohp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `theaters`
--

CREATE TABLE `theaters` (
  `idtheaters` int(11) NOT NULL,
  `namatheater` varchar(45) DEFAULT NULL,
  `lokasi` varchar(45) DEFAULT NULL,
  `idbioskop` int(11) NOT NULL,
  `namafilm` varchar(45) NOT NULL,
  `idjadwal` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `idtransaksi` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `cinema` varchar(45) DEFAULT NULL,
  `movie` varchar(45) DEFAULT NULL,
  `idbooking` int(11) NOT NULL,
  `nohp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bioskop`
--
ALTER TABLE `bioskop`
  ADD PRIMARY KEY (`idbioskop`,`film_namafilm`,`idjadwal`),
  ADD KEY `fk_bioskop_film1_idx` (`film_namafilm`,`idjadwal`);

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`idbooking`);

--
-- Indexes for table `film`
--
ALTER TABLE `film`
  ADD PRIMARY KEY (`namafilm`,`idjadwal`),
  ADD KEY `fk_film_jadwaltayang1_idx` (`idjadwal`);

--
-- Indexes for table `jadwaltayang`
--
ALTER TABLE `jadwaltayang`
  ADD PRIMARY KEY (`idjadwal`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`nohp`);

--
-- Indexes for table `pemesan`
--
ALTER TABLE `pemesan`
  ADD PRIMARY KEY (`nohp`);

--
-- Indexes for table `saldo`
--
ALTER TABLE `saldo`
  ADD PRIMARY KEY (`pemesan_nohp`);

--
-- Indexes for table `theaters`
--
ALTER TABLE `theaters`
  ADD PRIMARY KEY (`idtheaters`,`idbioskop`,`namafilm`,`idjadwal`),
  ADD KEY `fk_theaters_bioskop1_idx` (`idbioskop`,`namafilm`,`idjadwal`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`idtransaksi`,`idbooking`,`nohp`),
  ADD KEY `fk_transaksi_booking1_idx` (`idbooking`),
  ADD KEY `fk_transaksi_pemesan1_idx` (`nohp`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bioskop`
--
ALTER TABLE `bioskop`
  ADD CONSTRAINT `fk_bioskop_film1` FOREIGN KEY (`film_namafilm`,`idjadwal`) REFERENCES `film` (`namafilm`, `idjadwal`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `film`
--
ALTER TABLE `film`
  ADD CONSTRAINT `fk_film_jadwaltayang1` FOREIGN KEY (`idjadwal`) REFERENCES `jadwaltayang` (`idjadwal`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `login`
--
ALTER TABLE `login`
  ADD CONSTRAINT `fk_login_pemesan` FOREIGN KEY (`nohp`) REFERENCES `pemesan` (`nohp`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `saldo`
--
ALTER TABLE `saldo`
  ADD CONSTRAINT `fk_saldo_pemesan1` FOREIGN KEY (`pemesan_nohp`) REFERENCES `pemesan` (`nohp`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `theaters`
--
ALTER TABLE `theaters`
  ADD CONSTRAINT `fk_theaters_bioskop1` FOREIGN KEY (`idbioskop`,`namafilm`,`idjadwal`) REFERENCES `bioskop` (`idbioskop`, `film_namafilm`, `idjadwal`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `fk_transaksi_booking1` FOREIGN KEY (`idbooking`) REFERENCES `booking` (`idbooking`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_transaksi_pemesan1` FOREIGN KEY (`nohp`) REFERENCES `pemesan` (`nohp`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
