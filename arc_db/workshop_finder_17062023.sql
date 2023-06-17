-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 17, 2023 at 09:07 AM
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
  `vehicle_id` bigint(20) UNSIGNED NOT NULL,
  `workshop_service_id` bigint(20) UNSIGNED NOT NULL,
  `booking_date` datetime NOT NULL,
  `pickup_location` text DEFAULT NULL,
  `pickup_latitude` text DEFAULT NULL,
  `pickup_longitude` text DEFAULT NULL,
  `price_in_total` decimal(10,0) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0 COMMENT '0: booking created / unpaid\r\n1: proof of payment uploaded\r\n2: payment confirmed\r\n3: finished\r\n4: canceled',
  `proof_of_payment` text DEFAULT NULL COMMENT 'path to public assets',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wf_bookings`
--

INSERT INTO `wf_bookings` (`booking_code`, `user_id`, `workshop_id`, `vehicle_id`, `workshop_service_id`, `booking_date`, `pickup_location`, `pickup_latitude`, `pickup_longitude`, `price_in_total`, `status`, `proof_of_payment`, `created_at`, `updated_at`) VALUES
('7LEXL82M4W', 3, 2, 4, 2, '2023-06-13 00:00:00', 'bekasi', '-6.248864107858479', '106.96774923075252', '1500000', 4, '20230614_7LEXL82M4W_OC4svYZ2kI.jpg', '2023-06-13 16:19:43', '2023-06-14 15:42:05'),
('ERBYCDLEXW', 3, 3, 4, 3, '2023-06-13 00:00:00', NULL, NULL, NULL, '349000', 0, NULL, '2023-06-17 07:02:05', '2023-06-17 07:02:05');

-- --------------------------------------------------------

--
-- Table structure for table `wf_users`
--

CREATE TABLE `wf_users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(12) NOT NULL,
  `password` text NOT NULL,
  `token` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wf_users`
--

INSERT INTO `wf_users` (`id`, `full_name`, `email`, `phone_number`, `password`, `token`, `created_at`, `updated_at`) VALUES
(3, 'DummyUpdated', 'Dummy@example.com', '1234567811', '$2y$10$3XB6NYe2hyNXjNcSFpnqiOEJUtnIPJewIXvUHX5eO8Ge912V9LKeq', '297b1b03b47dba3bbb626035828112eec595efe2f3fe202e3362019397abda6f470e8b0a363eddc1', '2023-06-10 06:29:59', '2023-06-11 10:16:41'),
(4, 'Dummy2', 'Dummy2@example.com', '1234567891', '$2y$10$umn4xABSgcrCihgoYJhUJ.xJvMMWNYQC41jEVmwu7SA/zKWpbObr2', NULL, '2023-06-11 09:09:27', '2023-06-11 09:09:27');

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

--
-- Dumping data for table `wf_user_vehicles`
--

INSERT INTO `wf_user_vehicles` (`id`, `user_id`, `brand`, `type`, `number_plate`, `color`, `created_at`, `updated_at`) VALUES
(4, 3, 'Toyota', 'Fortuner', 'B1234AB', 'black', '2023-06-13 16:02:49', '2023-06-13 16:02:49');

-- --------------------------------------------------------

--
-- Table structure for table `wf_workshops`
--

CREATE TABLE `wf_workshops` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(12) NOT NULL,
  `address` text DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL COMMENT 'ex: Special Capital Region of Jakarta',
  `city_district` varchar(255) DEFAULT NULL COMMENT 'ex: West Jakarta',
  `neighbourhood` varchar(255) DEFAULT NULL COMMENT 'ex: Srengseng',
  `suburb` varchar(255) DEFAULT NULL COMMENT 'ex: Kembangan',
  `postcode` int(5) DEFAULT NULL COMMENT 'ex: 11630',
  `latitude` text DEFAULT NULL,
  `longitude` text DEFAULT NULL,
  `opening_hours` text DEFAULT NULL COMMENT 'ex: (monday-friday 08:00 - 17:00)',
  `password` text NOT NULL,
  `thumbnail` text DEFAULT NULL,
  `webiste` varchar(255) DEFAULT NULL,
  `gmaps` text DEFAULT NULL,
  `token` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wf_workshops`
--

INSERT INTO `wf_workshops` (`id`, `name`, `email`, `phone_number`, `address`, `city`, `city_district`, `neighbourhood`, `suburb`, `postcode`, `latitude`, `longitude`, `opening_hours`, `password`, `thumbnail`, `webiste`, `gmaps`, `token`, `created_at`, `updated_at`) VALUES
(2, 'ID shop', 'idshop@example.com', '1234567890', 'lorem ipsum address', 'DKI Jakarta', 'Jakarta Barat', 'Srengseng', 'Kembangan', 11630, '-6.209075332492135', '106.75643645294805', 'monday-sunday (08:00 - 17:00)', '$2y$10$sq2KO02/viWF0nfXwdE/B.aSS6E59qaqCL5LH6URWFEOIhj.6pRe2', NULL, NULL, NULL, '2a80e7c47b585f29d07d8f74f1a50c53fcb2211aae47c73c75f3581d0675d1fa9a33c35148bde468', '2023-06-11 10:47:08', '2023-06-12 12:29:16'),
(3, 'TEBET MOTOR', 'admin@tebetmotor.com', '081808856962', 'Jl. Dr. Saharjo No. 222a', 'Daerah Khusus Ibukota Jakarta', 'Jakarta Selatan', 'Tebet', 'Menteng Dalam', 12810, '-6.22301', '106.84723', 'Senin - Sabtu pkl 08:00 - 16:30', '$2y$10$3XB6NYe2hyNXjNcSFpnqiOEJUtnIPJewIXvUHX5eO8Ge912V9LKeq', NULL, 'https://tebetmotor.business.site/', NULL, NULL, '2023-06-14 13:55:18', '2023-06-14 13:55:18'),
(4, 'Bengkel Dinamo Laksana', 'admin@bengkeldinamolaksana.com', '081806288266', 'Jl. Raya Casablanca No.1A, RT.17/RW.5', 'Daerah Khusus Ibukota Jakarta', 'Jakarta Selatan', 'Tebet', 'Menteng Dalam', 12870, '-6.22369804078892', '106.8462105', 'Senin - Minggu', '$2y$10$3XB6NYe2hyNXjNcSFpnqiOEJUtnIPJewIXvUHX5eO8Ge912V9LKeq', NULL, 'http://boskimotorsport24jam.blogspot.com/', NULL, NULL, '2023-06-14 14:27:52', '2023-06-14 14:27:52'),
(5, 'Bengkel Mobil Elisa Jaya', 'admin@elisajaya.com', '087888135551', 'Jl. Raya Casablanca No.raya, RT.7/RW.11', 'Daerah Khusus Ibukota Jakarta', 'Jakarta Selatan', 'Tebet', 'Menteng Dalam', 12870, '-6.224817928435662', '106.84313121051798', 'Senin - Sabtu', '$2y$10$3XB6NYe2hyNXjNcSFpnqiOEJUtnIPJewIXvUHX5eO8Ge912V9LKeq', NULL, NULL, NULL, NULL, '2023-06-14 15:19:02', '2023-06-14 15:19:02'),
(6, 'Bengkel Mobil Boski 24 Jam', 'admin@boski.com', '081282589438', 'Jl. Palbatu VI No.25, RT.6/RW.11', 'Daerah Khusus Ibukota Jakarta', 'Jakarta Selatan', 'Tebet', 'Menteng Dalam', 12870, '-6.226436507216298', '106.8435017683306', 'monday-sunday (08:00 - 17:00)', '$2y$10$3XB6NYe2hyNXjNcSFpnqiOEJUtnIPJewIXvUHX5eO8Ge912V9LKeq', NULL, 'http://boskidinamo24jam.business.site/', NULL, NULL, '2023-06-14 15:20:46', '2023-06-14 15:20:46'),
(7, 'Achmad Service Motor', 'admin@ASM.com', '089561611012', NULL, 'Daerah Khusus Ibukota Jakarta', 'Jakarta Selatan', 'Tebet', 'Menteng Dalam', 12870, '-6.229832677090962', '106.84277721436409', 'monday-sunday (08:00 - 17:00)', '$2y$10$3XB6NYe2hyNXjNcSFpnqiOEJUtnIPJewIXvUHX5eO8Ge912V9LKeq', NULL, 'https://achmad-service-motor.business.site/', NULL, NULL, '2023-06-14 15:20:46', '2023-06-14 15:20:46');

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
-- Indexes for table `wf_bookings`
--
ALTER TABLE `wf_bookings`
  ADD PRIMARY KEY (`booking_code`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `workshop_id` (`workshop_id`),
  ADD KEY `vehicle_id` (`vehicle_id`),
  ADD KEY `workshop_service_id` (`workshop_service_id`);

--
-- Indexes for table `wf_users`
--
ALTER TABLE `wf_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone_number` (`phone_number`);

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
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone_number` (`phone_number`);

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
-- AUTO_INCREMENT for table `wf_users`
--
ALTER TABLE `wf_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `wf_user_vehicles`
--
ALTER TABLE `wf_user_vehicles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `wf_workshops`
--
ALTER TABLE `wf_workshops`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `wf_workshop_services`
--
ALTER TABLE `wf_workshop_services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `wf_bookings`
--
ALTER TABLE `wf_bookings`
  ADD CONSTRAINT `wf_bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `wf_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `wf_bookings_ibfk_2` FOREIGN KEY (`workshop_id`) REFERENCES `wf_workshops` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `wf_bookings_ibfk_3` FOREIGN KEY (`vehicle_id`) REFERENCES `wf_user_vehicles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `wf_bookings_ibfk_4` FOREIGN KEY (`workshop_service_id`) REFERENCES `wf_workshop_services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
