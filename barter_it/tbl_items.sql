-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 12, 2023 at 10:15 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `barter_it`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_items`
--

CREATE TABLE `tbl_items` (
  `item_id` int(50) NOT NULL,
  `user_id` varchar(10) NOT NULL,
  `item_name` text NOT NULL,
  `item_desc` varchar(50) NOT NULL,
  `item_price` varchar(50) NOT NULL,
  `item_qty` int(50) NOT NULL,
  `item_type` varchar(50) NOT NULL,
  `item_lat` varchar(50) NOT NULL,
  `item_long` varchar(50) NOT NULL,
  `item_state` varchar(50) NOT NULL,
  `item_locality` varchar(50) NOT NULL,
  `item_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_items`
--

INSERT INTO `tbl_items` (`item_id`, `user_id`, `item_name`, `item_desc`, `item_price`, `item_qty`, `item_type`, `item_lat`, `item_long`, `item_state`, `item_locality`, `item_date`) VALUES
(0, '14', 'They Both Die At The End Book', 'Brand New hardcover They Both Die At The End book,', '20', 2, 'Hobbies', '37.4219983', '-122.084', 'California', 'Mountain View', '0000-00-00 00:00:00.000000');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
