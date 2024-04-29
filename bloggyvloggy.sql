-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 26, 2024 at 06:06 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bloggyvloggy`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) UNSIGNED NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `title`, `description`) VALUES
(10, 'cat1', '1'),
(11, 'cat2', '1'),
(12, 'cat3', 'cat3');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(11) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `thumbnail` varchar(255) NOT NULL,
  `date_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `category_id` int(11) UNSIGNED DEFAULT NULL,
  `author_id` int(11) UNSIGNED NOT NULL,
  `is_featured` tinytext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `title`, `body`, `thumbnail`, `date_time`, `category_id`, `author_id`, `is_featured`) VALUES
(10, 'demo', 'asdfasdfasdf', '1714101437wp5561834-alabama-hills-landscape-wallpapers.jpg', '2024-04-26 03:17:17', 10, 17, '0'),
(11, '123', '123123', '1714103157wp5561834-alabama-hills-landscape-wallpapers.jpg', '2024-04-26 03:45:57', 10, 4, '1');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) UNSIGNED NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `avatar` varchar(255) NOT NULL,
  `is_admin` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `username`, `email`, `password`, `avatar`, `is_admin`) VALUES
(4, 'Bhumit', 'Boraniya', 'T341D16', 'bhumitboraniya11@gmail.com', '$2y$10$7XC552DCD35BQYiomdWZ5OdVCVGlaTl9eew.oTu0ZFSvn7GPTr1wm', 'Screenshot 2024-04-21 093829.png', 1),
(14, 'san', 'son', 'sonsan', 'sonson@gmail.com', '$2y$10$jxyQ.vOFyat8hMg2Q7Cp1On9Oonf.sTapgE74knK.BPrnENtz8WEe', '1714055321Screenshot 2024-04-20 171618.png', 1),
(15, 'bhumit', 'Boraniya', 'booomittt', 'bhumitboraniyxza@gmail.com', '$2y$10$iv5Xd7sJG4R14KCym09NwO0XwPBCRJZ5uXJLTxbvXhp2DVTETkRji', '1714062160Screenshot 2024-04-21 093625.png', 0),
(16, 'Bhumit', 'Boraniya', 'asads', '123123bhumitboraniya@gmail.com', '$2y$10$po7iOOkZXfqh8Pq1D.coneonw9JZKuhTP4ny.1w2yFiCF5sPSna7K', '1714088365Screenshot 2024-04-21 093816.png', 0),
(17, 'hetvi', 'kotak', 'hkotak', 'hetvikotak2312@gmail.com', '$2y$10$f1T3KJb.9Y/Keqq8VhUg1.eLbWKYeCuHTIVDJDp0iG8zWkEPsNrFO', 'WhatsApp Image 2024-04-22 at 01.21.45_e58e2af9.jpg', 1),
(18, 'bhumit', 'boraniya', 'bhumit', '123123123@gmail.com', '$2y$10$zpnpPkvD7dEZPDG3M89.2eLKVN.wktAc33z/OHncuq69lm3fAGYRG', '1714098884profile_picture.jpg', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_blog_category` (`category_id`),
  ADD KEY `FK_blog_author` (`author_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `FK_blog_author` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_blog_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
