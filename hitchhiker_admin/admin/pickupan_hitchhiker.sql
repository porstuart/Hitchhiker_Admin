-- phpMyAdmin SQL Dump
-- version 4.9.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 14, 2020 at 06:48 PM
-- Server version: 10.3.23-MariaDB-cll-lve
-- PHP Version: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pickupan_hitchhiker`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`username`, `password`) VALUES
('admin', 'd033e22ae348aeb5660fc2140aec35850c4da997');

-- --------------------------------------------------------

--
-- Table structure for table `driver`
--

CREATE TABLE `driver` (
  `email` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `fName` varchar(50) NOT NULL,
  `lName` varchar(50) NOT NULL,
  `gender` varchar(7) NOT NULL,
  `matric` varchar(6) NOT NULL,
  `phoneNum` varchar(11) NOT NULL,
  `residentialHall` varchar(20) NOT NULL,
  `carBrand` varchar(50) NOT NULL,
  `carModel` varchar(50) NOT NULL,
  `carPlate` varchar(20) NOT NULL,
  `verify` int(11) NOT NULL,
  `status` varchar(20) NOT NULL,
  `blacklist` varchar(15) NOT NULL,
  `driverImage` varchar(60) NOT NULL,
  `tripCount` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `driver`
--

INSERT INTO `driver` (`email`, `password`, `fName`, `lName`, `gender`, `matric`, `phoneNum`, `residentialHall`, `carBrand`, `carModel`, `carPlate`, `verify`, `status`, `blacklist`, `driverImage`, `tripCount`) VALUES
('porstuart@gmail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'Stuart', 'Por', 'Male', '254420', '0184080433', 'SME BANK', 'TOYOTA', 'AVANZA', 'PHU2039', 1, 'Approved', 'blacklisted', '08062020104604-porstuart@gmail.com', 0),
('porstuart@outlook.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'Stuart', 'Por', 'Male', '254420', '0184080433', 'SME BANK', 'TOYOTA', 'VIOS', 'PJL2039', 1, 'Approved', 'whitelisted', '13062020023905-porstuart@outlook.com', 1);

-- --------------------------------------------------------

--
-- Table structure for table `passenger`
--

CREATE TABLE `passenger` (
  `email` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `fName` varchar(50) NOT NULL,
  `lName` varchar(50) NOT NULL,
  `gender` varchar(7) NOT NULL,
  `matric` varchar(6) NOT NULL,
  `phoneNum` varchar(11) NOT NULL,
  `emergeNum` varchar(11) NOT NULL,
  `residentialHall` varchar(20) NOT NULL,
  `verify` int(11) NOT NULL,
  `status` varchar(20) NOT NULL,
  `blacklist` varchar(15) NOT NULL,
  `passengerImage` varchar(60) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `passenger`
--

INSERT INTO `passenger` (`email`, `password`, `fName`, `lName`, `gender`, `matric`, `phoneNum`, `emergeNum`, `residentialHall`, `verify`, `status`, `blacklist`, `passengerImage`) VALUES
('porstuart@gmail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'Stuart', 'Por', 'Male', '254420', '0184080433', '0134897002', 'SME BANK', 1, 'Approved', 'blacklisted', '08062020100510-porstuart@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `trip`
--

CREATE TABLE `trip` (
  `tripID` int(11) NOT NULL,
  `origin` varchar(100) NOT NULL,
  `destination` varchar(100) NOT NULL,
  `pickupPoint` varchar(100) NOT NULL,
  `depatureDate` date NOT NULL,
  `depatureTime` varchar(20) NOT NULL,
  `arrivalTime` varchar(20) NOT NULL,
  `travellingPreferences` varchar(100) NOT NULL,
  `rewards` varchar(100) NOT NULL,
  `driverEmail` varchar(50) NOT NULL,
  `passenger_email` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `trip`
--

INSERT INTO `trip` (`tripID`, `origin`, `destination`, `pickupPoint`, `depatureDate`, `depatureTime`, `arrivalTime`, `travellingPreferences`, `rewards`, `driverEmail`, `passenger_email`) VALUES
(33, 'UUM', 'AMAN CENTRAL', 'SME BANK', '2020-06-01', '0100pm', '0200pm', 'NO SMOKING', 'PETROL FEE', 'porstuart@gmail.com', 'porstuart@gmail.com'),
(40, 'UUM', 'AMAN CENTRAL', 'SME BANK', '2020-07-01', '15 : 13', '15 : 13', 'NO SMOKING', 'PETROL FEE', 'porstuart@outlook.com', 'porstuart@gmail.com'),
(36, 'UUM', 'AMAN CENTRAL', 'SME BANK', '2020-06-15', '0100PM', '0200PM', 'NO SMOKING', 'PETROL FEE', 'porstuart@gmail.com', NULL),
(37, 'UUM', 'AMAN CENTRAL', 'SME BANK', '2020-06-13', 'TimeOfDay(12:25)', '0100PM', 'NO SMOKING', 'PETROL FEE', 'porstuart@gmail.com', NULL),
(38, 'AMAN CENTRAL', 'UUM', 'ALOR SETAR TOWER', '2020-06-25', '21 : 34', '2234', 'No smoking', 'PETROL fee', 'porstuart@gmail.com', NULL),
(39, 'ZOO NEGARA', 'UUM', 'KLCC', '2020-06-30', '20 : 30', '', 'NO SMOKING', 'PETROL FEE', 'porstuart@gmail.com', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `trip`
--
ALTER TABLE `trip`
  ADD PRIMARY KEY (`tripID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `trip`
--
ALTER TABLE `trip`
  MODIFY `tripID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
