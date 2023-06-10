-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 10, 2023 at 04:58 PM
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
-- Table structure for table `wf_bookings`
--

CREATE TABLE `wf_bookings` (
  `booking_code` char(15) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `workshop_id` bigint(20) UNSIGNED NOT NULL,
  `booking_date` datetime NOT NULL,
  `pickup_location` text DEFAULT NULL,
  `pickup_latitude` text DEFAULT NULL,
  `pickup_longitude` text DEFAULT NULL,
  `price_in_total` decimal(10,0) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0 COMMENT '0: booking created / unpaid\r\n1: proof of payment uploaded\r\n2: payment confirmed\r\n3: finished',
  `proof_of_payment` text DEFAULT NULL COMMENT 'path to public assets',
  `created` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wf_booking_details`
--

CREATE TABLE `wf_booking_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `booking_code` char(15) NOT NULL,
  `vehicle_id` bigint(20) UNSIGNED NOT NULL,
  `workshop_service_id` bigint(20) UNSIGNED NOT NULL,
  `subtotal` decimal(10,0) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wf_users`
--

CREATE TABLE `wf_users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` int(12) NOT NULL,
  `password` text NOT NULL,
  `token` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wf_users`
--

INSERT INTO `wf_users` (`id`, `full_name`, `email`, `phone_number`, `password`, `token`, `created_at`, `updated_at`) VALUES
(3, 'Dummy', 'Dummy@example.com', 1234567890, '$2y$10$3XB6NYe2hyNXjNcSFpnqiOEJUtnIPJewIXvUHX5eO8Ge912V9LKeq', 'efc6056df1f77210d8e2b2f5a3874a25632180cad876cf4247487b0930bfcee69db671726d1253d1', '2023-06-10 06:29:59', '2023-06-10 07:24:50');

-- --------------------------------------------------------

--
-- Table structure for table `wf_user_vehicles`
--

CREATE TABLE `wf_user_vehicles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `brand` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `number_plate` varchar(9) NOT NULL,
  `color` varchar(30) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wf_workshops`
--

CREATE TABLE `wf_workshops` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `address` text NOT NULL,
  `opening_days` text NOT NULL,
  `opening_hours` time NOT NULL,
  `latitude` text DEFAULT NULL,
  `longitude` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wf_workshop_services`
--

CREATE TABLE `wf_workshop_services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `workshop_id` bigint(20) UNSIGNED NOT NULL,
  `service_type` varchar(150) NOT NULL,
  `service_price_range_1` decimal(10,0) NOT NULL DEFAULT 0,
  `service_price_range_2` decimal(10,0) NOT NULL DEFAULT 0,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `wf_bookings`
--
ALTER TABLE `wf_bookings`
  ADD PRIMARY KEY (`booking_code`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `workshop_id` (`workshop_id`);

--
-- Indexes for table `wf_booking_details`
--
ALTER TABLE `wf_booking_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `booking_code` (`booking_code`),
  ADD KEY `vehicle_id` (`vehicle_id`),
  ADD KEY `workshop_service_id` (`workshop_service_id`);

--
-- Indexes for table `wf_users`
--
ALTER TABLE `wf_users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wf_user_vehicles`
--
ALTER TABLE `wf_user_vehicles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `wf_workshops`
--
ALTER TABLE `wf_workshops`
  ADD PRIMARY KEY (`id`);

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
-- AUTO_INCREMENT for table `wf_booking_details`
--
ALTER TABLE `wf_booking_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wf_users`
--
ALTER TABLE `wf_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `wf_user_vehicles`
--
ALTER TABLE `wf_user_vehicles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wf_workshops`
--
ALTER TABLE `wf_workshops`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wf_workshop_services`
--
ALTER TABLE `wf_workshop_services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `wf_bookings`
--
ALTER TABLE `wf_bookings`
  ADD CONSTRAINT `wf_bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `wf_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `wf_bookings_ibfk_2` FOREIGN KEY (`workshop_id`) REFERENCES `wf_workshops` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `wf_booking_details`
--
ALTER TABLE `wf_booking_details`
  ADD CONSTRAINT `wf_booking_details_ibfk_1` FOREIGN KEY (`booking_code`) REFERENCES `wf_bookings` (`booking_code`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `wf_booking_details_ibfk_2` FOREIGN KEY (`vehicle_id`) REFERENCES `wf_user_vehicles` (`id`),
  ADD CONSTRAINT `wf_booking_details_ibfk_3` FOREIGN KEY (`workshop_service_id`) REFERENCES `wf_workshop_services` (`id`);

--
-- Constraints for table `wf_user_vehicles`
--
ALTER TABLE `wf_user_vehicles`
  ADD CONSTRAINT `wf_user_vehicles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `wf_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `wf_workshop_services`
--
ALTER TABLE `wf_workshop_services`
  ADD CONSTRAINT `wf_workshop_services_ibfk_1` FOREIGN KEY (`workshop_id`) REFERENCES `wf_workshops` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
