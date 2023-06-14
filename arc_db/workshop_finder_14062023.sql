-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 14, 2023 at 05:30 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `workshop_finder`
--

-- --------------------------------------------------------

--
-- Table structure for table `wf_workshop_services`
--

CREATE TABLE `wf_workshop_services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `workshop_id` bigint(20) UNSIGNED NOT NULL,
  `service_type` varchar(150) NOT NULL COMMENT 'ex: tire, oil, towing',
  `service_price` decimal(10,0) NOT NULL DEFAULT 0,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wf_workshop_services`
--

INSERT INTO `wf_workshop_services` (`id`, `workshop_id`, `service_type`, `service_price`, `description`, `created_at`, `updated_at`) VALUES
(2, 2, 'towing', '1500000', 'terima towing untuk mobil SUV', '2023-06-12 12:43:15', '2023-06-12 12:43:15'),
(3, 3, 'Tire', '349000', 'Jual ban motor lengkap', '2023-06-14 15:26:52', '2023-06-14 15:26:52'),
(4, 4, 'oli', '654500', 'Oli mobil', '2023-06-14 15:28:04', '2023-06-14 15:28:04'),
(5, 5, 'Body repair', '1000000', 'body repair', '2023-06-14 15:28:35', '2023-06-14 15:28:35'),
(6, 6, 'Towing', '3000000', 'Towing', '2023-06-14 15:29:19', '2023-06-14 15:29:19');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `wf_workshop_services`
--
ALTER TABLE `wf_workshop_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `workshop_id` (`workshop_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `wf_workshop_services`
--
ALTER TABLE `wf_workshop_services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `wf_workshop_services`
--
ALTER TABLE `wf_workshop_services`
  ADD CONSTRAINT `wf_workshop_services_ibfk_1` FOREIGN KEY (`workshop_id`) REFERENCES `wf_workshops` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
