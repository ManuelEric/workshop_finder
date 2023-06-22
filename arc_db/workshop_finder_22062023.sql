-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 22, 2023 at 08:56 AM
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
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved` tinyint(3) UNSIGNED DEFAULT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved`, `reserved_at`, `available_at`, `created_at`) VALUES
(4, 'default', '{\"uuid\":\"ea9a9e63-ddc6-41df-9086-2fedc4cdba6f\",\"displayName\":\"App\\\\Jobs\\\\CancelBooking\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\CancelBooking\",\"command\":\"O:22:\\\"App\\\\Jobs\\\\CancelBooking\\\":1:{s:10:\\\"\\u0000*\\u0000booking\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Booking\\\";s:2:\\\"id\\\";s:10:\\\"S6G9LRG4VP\\\";s:9:\\\"relations\\\";a:2:{i:0;s:8:\\\"workshop\\\";i:1;s:17:\\\"workshop.services\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"}}', 0, NULL, NULL, 1687366344, 1687365144),
(5, 'default', '{\"uuid\":\"5bb2d3ef-8ff4-4a26-9fd6-b4b3f427cc79\",\"displayName\":\"App\\\\Jobs\\\\CancelBooking\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\CancelBooking\",\"command\":\"O:22:\\\"App\\\\Jobs\\\\CancelBooking\\\":1:{s:10:\\\"\\u0000*\\u0000booking\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Booking\\\";s:2:\\\"id\\\";s:10:\\\"RJ6GR6F5MM\\\";s:9:\\\"relations\\\";a:2:{i:0;s:8:\\\"workshop\\\";i:1;s:17:\\\"workshop.services\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"}}', 0, NULL, NULL, 1687366437, 1687365237),
(6, 'default', '{\"uuid\":\"a39f07fe-4965-4863-bd8e-bc90fbb09ca8\",\"displayName\":\"App\\\\Jobs\\\\CancelBooking\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\CancelBooking\",\"command\":\"O:22:\\\"App\\\\Jobs\\\\CancelBooking\\\":1:{s:10:\\\"\\u0000*\\u0000booking\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Booking\\\";s:2:\\\"id\\\";s:10:\\\"JSVKY8D8RJ\\\";s:9:\\\"relations\\\";a:2:{i:0;s:8:\\\"workshop\\\";i:1;s:17:\\\"workshop.services\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"}}', 0, NULL, NULL, 1687366552, 1687365352),
(7, 'default', '{\"uuid\":\"ffa783ee-d0e1-4fa1-a0fc-80f3c9e023ba\",\"displayName\":\"App\\\\Jobs\\\\CancelBooking\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\CancelBooking\",\"command\":\"O:22:\\\"App\\\\Jobs\\\\CancelBooking\\\":1:{s:10:\\\"\\u0000*\\u0000booking\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Booking\\\";s:2:\\\"id\\\";s:10:\\\"DCZA9K49VQ\\\";s:9:\\\"relations\\\";a:4:{i:0;s:8:\\\"workshop\\\";i:1;s:17:\\\"workshop.services\\\";i:2;s:4:\\\"user\\\";i:3;s:13:\\\"user.vehicles\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}\"}}', 0, NULL, NULL, 1687367523, 1687366323);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_jobs_table', 1);

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
  `status` int(11) NOT NULL DEFAULT 0 COMMENT '0: booking created / unpaid\r\n1: proof of payment uploaded\r\n2: payment confirmed\r\n3: finished\r\n4: canceled\r\n5: failed',
  `proof_of_payment` text DEFAULT NULL COMMENT 'path to public assets',
  `queue_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wf_bookings`
--

INSERT INTO `wf_bookings` (`booking_code`, `user_id`, `workshop_id`, `vehicle_id`, `workshop_service_id`, `booking_date`, `pickup_location`, `pickup_latitude`, `pickup_longitude`, `price_in_total`, `status`, `proof_of_payment`, `queue_id`, `created_at`, `updated_at`) VALUES
('CMZT49ALNC', 3, 2, 4, 2, '2023-06-13 00:00:00', 'bekasi', '-6.248864107858479', '106.96774923075252', '1500000', 5, NULL, 0, '2023-06-21 23:07:41', '2023-06-21 16:09:13'),
('DCZA9K49VQ', 3, 2, 4, 2, '2023-06-13 00:00:00', 'bekasi', '-6.248864107858479', '106.96774923075252', '1500000', 4, NULL, 7, '2023-06-21 23:52:03', '2023-06-21 23:53:33'),
('JSVKY8D8RJ', 3, 2, 4, 2, '2023-06-13 00:00:00', 'bekasi', '-6.248864107858479', '106.96774923075252', '1500000', 0, NULL, 6, '2023-06-21 23:35:52', '2023-06-21 23:35:52'),
('NAXEJ3VUTQ', 3, 2, 4, 2, '2023-06-13 00:00:00', 'bekasi', '-6.248864107858479', '106.96774923075252', '1500000', 0, NULL, 0, '2023-06-21 23:05:08', '2023-06-21 23:05:08'),
('RJ6GR6F5MM', 3, 2, 4, 2, '2023-06-13 00:00:00', 'bekasi', '-6.248864107858479', '106.96774923075252', '1500000', 0, NULL, NULL, '2023-06-21 23:33:57', '2023-06-21 23:33:57'),
('S6G9LRG4VP', 3, 2, 4, 2, '2023-06-13 00:00:00', 'bekasi', '-6.248864107858479', '106.96774923075252', '1500000', 0, NULL, NULL, '2023-06-21 23:32:24', '2023-06-21 23:32:24');

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
(3, 'DummyUpdated', 'Dummy@example.com', '1234567811', '$2y$10$3XB6NYe2hyNXjNcSFpnqiOEJUtnIPJewIXvUHX5eO8Ge912V9LKeq', '75693acf5b57e80e1c47b8aac1c9e540700bcf516734a1fad2d7e11ee0f110f882e2fc2d2f8b0ac7', '2023-06-10 06:29:59', '2023-06-21 12:30:53'),
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
  `service_type` enum('oil','towing','tire') NOT NULL COMMENT 'ex: tire, oil, towing',
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
(3, 3, 'tire', '349000', 'Jual ban motor lengkap', '2023-06-14 15:26:52', '2023-06-14 15:26:52'),
(4, 4, 'oil', '654500', 'Oli mobil', '2023-06-14 15:28:04', '2023-06-14 15:28:04'),
(5, 5, 'oil', '1000000', 'Oli full-syntethic', '2023-06-14 15:28:35', '2023-06-14 15:28:35'),
(6, 6, 'towing', '3000000', 'Towing', '2023-06-14 15:29:19', '2023-06-14 15:29:19');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_reserved_reserved_at_index` (`queue`,`reserved`,`reserved_at`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

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
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
