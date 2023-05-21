-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 21, 2023 at 11:19 AM
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
-- Table structure for table `tbl_users`
--

CREATE TABLE `tbl_users` (
  `user_id` int(5) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `user_phone` varchar(50) NOT NULL,
  `user_password` varchar(50) NOT NULL,
  `user_otp` int(6) NOT NULL,
  `user_datereg` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`user_id`, `user_email`, `user_name`, `user_phone`, `user_password`, `user_otp`, `user_datereg`) VALUES
(14, 'natashaaqilah27@gmail.com', 'Natasha Aqilah', '0195742705', '601f1889667efaebb33b8c12572835da3f027f78', 32273, '2023-05-21 00:49:43.505949'),
(15, 'anisa@gmail.com', 'Anisa Aqilah', '0198362781', '3f43e9c586109cabc98741f463975cbb321430a0', 82593, '2023-05-21 16:35:47.839794'),
(16, 'dayanades@gmail.com', 'Dayana ', '0128302345', 'b7d1e1413cdc6f1a7f44b48f7b0c2dcf31f492c8', 41314, '2023-05-21 16:36:47.529909'),
(17, 'zara@gmail.com', 'Zaharah', '0195754686', '7c4a8d09ca3762af61e59520943dc26494f8941b', 41726, '2023-05-21 17:05:21.685531');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_phone` (`user_phone`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `user_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
