-- phpMyAdmin SQL Dump
-- version 4.9.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Jun 24, 2020 at 09:08 AM
-- Server version: 5.7.26
-- PHP Version: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `E-shop-2.0`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id_cart` int(11) NOT NULL,
  `id_user` int(11) DEFAULT '0',
  `id_good` int(11) NOT NULL,
  `amount` double NOT NULL,
  `is_in_order` int(4) NOT NULL,
  `id_order` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id_cart`, `id_user`, `id_good`, `amount`, `is_in_order`, `id_order`) VALUES
(22, 0, 2, 8, 0, NULL),
(23, 0, 3, 1, 0, NULL),
(24, 0, 4, 2, 0, NULL),
(25, 0, 5, 5, 0, NULL),
(26, 0, 6, 4, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id_category` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `name` varchar(222) NOT NULL,
  `parent_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id_category`, `status`, `name`, `parent_id`) VALUES
(1, 1, 'T-Shirt', 0),
(2, 1, 'Category 2', 1),
(3, 1, 'Category 3', 1),
(4, 1, 'Category 4', 0),
(5, 1, 'Category 5', 2),
(6, 1, 'Category 6', 5);

-- --------------------------------------------------------

--
-- Table structure for table `colors`
--

CREATE TABLE `colors` (
  `id_good_color` int(11) NOT NULL,
  `color_name` varchar(50) NOT NULL,
  `id_good` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `goods`
--

CREATE TABLE `goods` (
  `id_good` int(11) NOT NULL,
  `category` int(11) NOT NULL,
  `name` varchar(111) NOT NULL,
  `brand` varchar(50) NOT NULL,
  `price` double NOT NULL,
  `discount` varchar(11) NOT NULL,
  `description` text NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `goods`
--

INSERT INTO `goods` (`id_good`, `category`, `name`, `brand`, `price`, `discount`, `description`, `status`) VALUES
(1, 1, 'T-Shirt Summer Vibes', '', 119.99, '', 'White Summer Vibes T-shirt in the uiKit line with a colorful print.\r\nMade of jersey cotton. T-shirt fits perfectly with jeans, pants or shorts.', 1),
(2, 2, 'Loose Knit 3/4 Sleeve', '', 119.99, '', '', 1),
(3, 1, 'Basic Slim Fit T-Shirt', '', 79.99, '', '', 1),
(4, 1, 'Loose Textured T-Shirt', '', 119.99, '', '', 1),
(5, 3, 'Premium Dress Shirt', '', 119.99, '', '', 4),
(6, 4, 'T-Shirt', 'oodji', 8.16, '', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `id_good_image` int(11) NOT NULL,
  `id_good` int(11) NOT NULL,
  `src_1` text NOT NULL,
  `src_small_1` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`id_good_image`, `id_good`, `src_1`, `src_small_1`) VALUES
(1, 1, 'img/product-img/AdobeStock_236655481@2x.jpg', 'img/product-img/AdobeStock_236655481.jpg'),
(2, 2, 'img/product-img/Mask Group 27@2x.jpg', 'img/product-img/Mask Group 27.jpg'),
(3, 3, 'img/product-img/Mask Group 25@2x.jpg', 'img/product-img/Mask Group 25.jpg'),
(4, 4, 'img/product-img/AdobeStock_173519034@2x.jpg', 'img/product-img/AdobeStock_173519034.jpg'),
(5, 5, 'img/product-img/Mask Group 27222@2x.jpg', 'img/product-img/Mask Group 27222.jpg'),
(6, 6, 'img/product-img/MP002XM1ZJOT_10700005_1_v1.webp', 'img/product-img/MP002XM1ZJOT_10700005_1_v1.webp');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id_order` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `datetime_create` datetime NOT NULL,
  `id_order_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id_order`, `id_user`, `datetime_create`, `id_order_status`) VALUES
(1, 1, '2020-06-04 11:14:21', 1),
(2, 1, '2020-06-04 11:14:21', 2),
(3, 2, '2020-06-03 11:15:26', 2),
(4, 2, '2020-06-03 11:15:26', 1),
(5, 1, '2020-06-01 11:14:21', 2),
(6, 1, '2020-05-03 11:14:21', 2);

-- --------------------------------------------------------

--
-- Table structure for table `order_status`
--

CREATE TABLE `order_status` (
  `id_order_status` int(11) NOT NULL,
  `order_status_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` int(11) NOT NULL,
  `name` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `name`) VALUES
(1, 'Главная'),
(2, 'О Магазине'),
(3, 'Каталог');

-- --------------------------------------------------------

--
-- Table structure for table `sizes`
--

CREATE TABLE `sizes` (
  `id_good_size` int(11) NOT NULL,
  `size_name` varchar(50) NOT NULL,
  `id_good` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `user_name` varchar(50) DEFAULT NULL,
  `user_login` varchar(50) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_surname` varchar(50) DEFAULT NULL,
  `user_last_action` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `role` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id_user`, `user_name`, `user_login`, `user_password`, `user_surname`, `user_last_action`, `role`) VALUES
(9, 'Admin', 'admin', '5fe8d05ae65b7a04d999fb48b4d00972', NULL, '2020-06-24 09:02:55', 1),
(10, 'User', 'user', '5fe8d05ae65b7a04d999fb48b4d00972', NULL, '2020-06-24 07:40:48', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id_cart`),
  ADD UNIQUE KEY `id_cart` (`id_cart`),
  ADD UNIQUE KEY `id_good` (`id_good`),
  ADD KEY `cart_orders` (`id_order`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id_category`);

--
-- Indexes for table `colors`
--
ALTER TABLE `colors`
  ADD PRIMARY KEY (`id_good_color`);

--
-- Indexes for table `goods`
--
ALTER TABLE `goods`
  ADD PRIMARY KEY (`id_good`),
  ADD UNIQUE KEY `id_good` (`id_good`);

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id_good_image`),
  ADD UNIQUE KEY `id_good` (`id_good`),
  ADD UNIQUE KEY `id_good_image` (`id_good_image`,`id_good`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id_order`);

--
-- Indexes for table `order_status`
--
ALTER TABLE `order_status`
  ADD PRIMARY KEY (`id_order_status`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id_cart` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id_category` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `colors`
--
ALTER TABLE `colors`
  MODIFY `id_good_color` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `goods`
--
ALTER TABLE `goods`
  MODIFY `id_good` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `id_good_image` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id_order` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `order_status`
--
ALTER TABLE `order_status`
  MODIFY `id_order_status` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_orders` FOREIGN KEY (`id_order`) REFERENCES `orders` (`id_order`);

--
-- Constraints for table `goods`
--
ALTER TABLE `goods`
  ADD CONSTRAINT `goods_id_images` FOREIGN KEY (`id_good`) REFERENCES `images` (`id_good`);
