 -- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 13, 2024 at 10:51 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ecomdb`
--

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`order_item_id`, `order_id`, `variant_id`, `quantity`, `price`) VALUES
(40001, 30001, 501, 2, 1599.98),
(40002, 30001, 503, 1, 999.99),
(40003, 30002, 502, 3, 2099.97),
(40004, 30002, 601, 2, 39.98),
(40005, 30003, 701, 1, 49.99),
(40006, 30003, 702, 2, 1799.98),
(40007, 30004, 801, 2, 19.98),
(40008, 30004, 802, 1, 14.99),
(40009, 30005, 501, 1, 799.99),
(40010, 30005, 601, 3, 59.97),
(40011, 30005, 702, 1, 899.99);

-- --------------------------------------------------------

--
-- Table structure for table `cart_item`
--

CREATE TABLE `cart_item` (
  `user_id` int(11) NOT NULL,
  `variant_id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart_item`
--

INSERT INTO `cart_item` (`user_id`, `variant_id`, `quantity`) VALUES
(10001, 501, 2),
(10001, 503, 1),
(10002, 502, 3),
(10002, 568, 2),
(10003, 578, 1),
(10003, 579, 2),
(10004, 581, 1),
(10004, 582, 2),
(10005, 510, 1),
(10005, 558, 3),
(10005, 580, 1),
(10023, 507, 1),
(10023, 529, 1),
(10023, 530, 1),
(10023, 551, 1),
(10023, 552, 1);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(255) DEFAULT NULL,
  `parent_category_id` int(11) DEFAULT NULL,
  `category_image` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `category_name`, `parent_category_id`, `category_image`) VALUES
(1, 'Electronics', NULL, 'NULL	'),
(2, 'Toys', NULL, NULL),
(3, 'Smartphones', 1, 'subcategory-images/smartphones.png'),
(4, 'Laptops', 1, 'subcategory-images//laptops.png'),
(5, 'lego', 2, 'subcategory-images//legos.png'),
(6, 'Board Games', 2, 'subcategory-images//boardgames.png'),
(7, 'toy cars', 2, 'subcategory-images//cars.png'),
(8, 'Tablets', 1, 'subcategory-images//tablets.png'),
(9, 'Televisions', 1, 'subcategory-images//televisions.png'),
(10, 'Barbie', 2, 'subcategory-images//barbies.png'),
(11, 'Headphones', 1, 'subcategory-images/headphones.png'),
(12, 'Digital Cameras', 1, 'subcategory-images/cameras.png'),
(13, 'Remote Control Helicopter', 2, 'subcategory-images/helicopters.png'),
(14, 'Puzzle Sets', 2, 'subcategory-images/puzzles.png');

-- --------------------------------------------------------

--
-- Table structure for table `delivery_module`
--

CREATE TABLE `delivery_module` (
  `delivery_module_id` int(11) NOT NULL,
  `order_item_id` int(11) DEFAULT NULL,
  `destination_city` varchar(255) DEFAULT NULL,
  `estimated_days` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `delivery_module`
--

INSERT INTO `delivery_module` (`delivery_module_id`, `order_item_id`, `destination_city`, `estimated_days`) VALUES
(50001, 40001, 'City A', 2),
(50002, 40002, 'City B', 3),
(50003, 40003, 'City C', 2),
(50004, 40004, 'City D', 4),
(50005, 40005, 'City E', 1),
(50006, 40047, 'madurai', 7),
(50007, 40048, 'madurai', 7),
(50008, 40049, 'madurai', 7),
(50009, 40050, 'madurai', 7),
(50010, 40051, 'madurai', 7),
(50011, 40052, 'madurai', 7),
(50012, 40053, 'madurai', 7),
(50013, 40054, 'madurai', 7),
(50014, 40055, 'madurai', 7);

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `variant_id` int(11) DEFAULT NULL,
  `stock_count` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`variant_id`, `stock_count`) VALUES
(501, 48),
(502, 30),
(503, 19),
(504, 25),
(505, 50),
(506, 30),
(507, 19),
(508, 25),
(509, 50),
(510, 30),
(511, 20),
(512, 25),
(513, 50),
(514, 30),
(515, 20),
(516, 25),
(517, 45),
(518, 30),
(519, 20),
(520, 25),
(521, 50),
(522, 30),
(523, 20),
(524, 25),
(525, 50),
(526, 30),
(527, 20),
(528, 25),
(529, 50),
(530, 30),
(531, 20),
(532, 25),
(533, 50),
(534, 30),
(535, 20),
(536, 25),
(537, 50),
(538, 30),
(539, 20),
(540, 25),
(541, 49),
(542, 30),
(543, 20),
(544, 25),
(545, 50),
(546, 30),
(547, 19),
(548, 23),
(549, 50),
(550, 30),
(551, 20),
(552, 25),
(553, 50),
(554, 30),
(555, 20),
(556, 25),
(557, 50),
(558, 30),
(559, 20),
(560, 25),
(561, 50),
(562, 30),
(563, 20),
(564, 24),
(565, 50),
(566, 30),
(567, 20),
(568, 25),
(569, 50),
(570, 30),
(571, 20),
(572, 25),
(573, 49),
(574, 30),
(575, 20),
(576, 25),
(577, 50),
(578, 30),
(579, 20),
(580, 25),
(581, 50),
(582, 30);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `delivery_method` varchar(255) DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `date`, `delivery_method`, `payment_method`, `user_id`) VALUES
(30001, '2019-09-01', 'Express', 'Credit Card', 10001),
(30002, '2023-08-11', 'Standard', 'PayPal', 10002),
(30003, '2023-02-03', 'Express', 'Credit Card', 10003),
(30004, '2022-09-09', 'Standard', 'PayPal', 10004),
(30005, '2021-10-25', 'Express', 'Credit Card', 10005),
(30006, '2021-01-15', 'Express', 'PayPal', 10006),
(30007, '2019-04-20', 'Standard', 'Credit Card', 10007),
(30008, '2019-06-10', 'Express', 'PayPal', 10008),
(30009, '2020-08-25', 'Standard', 'Credit Card', 10009),
(30010, '2022-07-19', 'Express', 'PayPal', 10010),
(30011, '2022-11-08', 'Standard', 'Credit Card', 10011),
(30012, '2020-01-27', 'Express', 'PayPal', 10012),
(30013, '2021-05-24', 'Standard', 'Credit Card', 10013),
(30014, '2020-03-13', 'Express', 'PayPal', 10014),
(30015, '2023-07-12', 'Standard', 'Credit Card', 10015),
(30016, '2023-12-22', 'Express', 'PayPal', 10016),
(30017, '2021-10-04', 'Standard', 'Credit Card', 10017),
(30018, '2021-05-17', 'Express', 'PayPal', 10018),
(30019, '2019-12-29', 'Standard', 'Credit Card', 10019),
(30020, '2020-08-31', 'Express', 'PayPal', 10020),
(30021, '2021-03-12', 'Standard', 'Credit Card', 10021),
(30022, '2021-04-30', 'Express', 'PayPal', 10022),
(30023, '2024-02-03', 'Express', 'visa', 10023),
(30024, '2024-02-03', 'Express', 'visa', 10023),
(30025, '2024-02-13', 'Express', 'visa', 10023);

-- --------------------------------------------------------

--
-- Table structure for table `order_item`
--

CREATE TABLE `order_item` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_item`
--

INSERT INTO `order_item` (`order_item_id`, `order_id`, `variant_id`, `quantity`, `price`) VALUES
(40001, 30001, 501, 2, 1599.98),
(40002, 30001, 503, 1, 999.99),
(40003, 30002, 502, 3, 2099.97),
(40004, 30002, 510, 5, 39.98),
(40005, 30003, 513, 1, 49.99),
(40006, 30003, 521, 2, 1799.98),
(40007, 30004, 527, 2, 19.98),
(40008, 30004, 528, 1, 14.99),
(40009, 30005, 533, 1, 799.99),
(40010, 30005, 566, 3, 59.97),
(40011, 30005, 580, 1, 899.99),
(40012, 30001, 505, 2, 99.98),
(40013, 30001, 507, 1, 1099.99),
(40014, 30002, 511, 3, 89.97),
(40015, 30002, 513, 2, 24.98),
(40016, 30003, 517, 1, 999.99),
(40017, 30003, 519, 2, 49.98),
(40018, 30004, 521, 2, 1399.98),
(40019, 30004, 523, 1, 449.99),
(40020, 30005, 527, 1, 9.99),
(40021, 30005, 529, 3, 359.97),
(40022, 30006, 533, 2, 79.98),
(40023, 30006, 535, 1, 299.99),
(40024, 30007, 537, 2, 39.98),
(40025, 30007, 539, 1, 49.99),
(40026, 30008, 541, 1, 299.99),
(40027, 30008, 543, 2, 259.98),
(40028, 30009, 545, 3, 284.97),
(40029, 30009, 547, 1, 59.99),
(40030, 30010, 549, 1, 64.99),
(40031, 30010, 551, 2, 649.98),
(40032, 30011, 553, 2, 2799.98),
(40033, 30011, 555, 1, 349.99),
(40034, 30012, 557, 1, 29.99),
(40035, 30012, 559, 3, 899.97),
(40036, 30013, 561, 2, 519.98),
(40037, 30013, 563, 1, 1499.99),
(40038, 30014, 565, 1, 199.99),
(40039, 30014, 567, 2, 79.98),
(40040, 30015, 569, 2, 2199.98),
(40041, 30015, 571, 1, 499.99),
(40042, 30016, 573, 1, 39.99),
(40043, 30016, 575, 2, 459.98),
(40044, 30017, 577, 1, 999.99),
(40045, 30017, 579, 3, 899.97),
(40046, 30018, 581, 2, 799.98),
(40047, 30019, 507, 1, 1099.99),
(40048, 30020, 547, 1, 49.99),
(40049, 30020, 548, 2, 59.99),
(40050, 30021, 541, 1, 1099.99),
(40051, 30022, 501, 2, 1199.99),
(40052, 30023, 503, 1, 1099.99),
(40053, 30024, 517, 5, 999.99),
(40054, 30024, 564, 1, 199.99),
(40055, 30025, 573, 1, 79.99);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `product_id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `weight` decimal(10,2) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `product_image` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_id`, `title`, `description`, `weight`, `category_id`, `product_image`) VALUES
(101, 'LEGO Star Wars Millennium Falcon', 'Build the ultimate Millennium Falcon with LEGO Star Wars. This iconic spaceship is a must-have for fans of the series.', 1.50, 5, 'product-images/lego_falcon.png'),
(102, 'Dell XPS 13', 'The Dell XPS 13: A pinnacle of style and performance. It\'s a compact, powerful laptop designed for professionals, students, and business enthusiasts seeking top-tier computing excellence.', 2.70, 4, 'product-images/Dell_XPS_13.png'),
(103, 'MacBook Air m1', 'The Apple MacBook Air 13 combines style, innovation, and power. It\'s a lightweight, high-performance laptop that caters to professionals, students, and business users, delivering an unmatched computing experience.', 2.80, 4, 'product-images/macbook_air.png'),
(104, 'iPhone 12 Pro', 'The Apple iPhone 12 Pro is a flagship smartphone known for its exceptional camera capabilities and performance. With its A14 Bionic chip, Pro camera system, and ProRAW support, it\'s a top choice for photography enthusiasts and power users.', 0.40, 3, 'product-images/iphone_12.png'),
(105, 'Samsung Galaxy S21 Ultra', 'The Samsung Galaxy S21 Ultra is the pinnacle of Samsung\'s Galaxy S series, offering unmatched performance, a versatile camera system, and a stunning AMOLED display. It\'s a flagship smartphone that caters to users seeking the best of Samsung\'s technology.', 0.35, 3, 'product-images/galaxy_s21.png'),
(106, 'Monopoly Board Game', 'Classic Monopoly board game for hours of family fun. Buy, sell, and trade your way to success!', 1.20, 6, 'product-images/monopoly.png'),
(107, 'Hot Wheels Die-Cast Cars Set', 'A set of 10 die-cast Hot Wheels cars for kids who love fast and furious racing action.', 0.50, 7, 'product-images/hot_wheels.png'),
(108, 'iPad Air', 'The iPad Air offers a perfect blend of power, performance, and portability. It\'s great for work and play.', 1.00, 8, 'product-images/ipad_air.png'),
(109, 'Samsung 65-Inch 4K Smart TV', 'Experience stunning visuals and smart features with this 65-inch Samsung 4K Smart TV.', 30.00, 9, 'product-images/samsung_tv.png'),
(110, 'Barbie Dreamhouse', 'The Barbie Dreamhouse is a dream come true for Barbie enthusiasts. It features multiple rooms and accessories for endless play.', 4.50, 10, 'product-images/barbie_dreamhouse.png'),
(111, 'Bose Noise-Canceling Headphones', 'Immerse yourself in high-quality audio with these Bose noise-canceling headphones.', 0.30, 11, 'product-images/bose_headphones.png'),
(112, 'Canon EOS Rebel T7 DSLR Camera', 'Capture stunning photos and videos with the Canon EOS Rebel T7. Perfect for photography enthusiasts.', 2.20, 12, 'product-images/canon_camera.png'),
(113, 'Remote Control Helicopter', 'Enjoy hours of remote control flying fun with this helicopter. Great for both kids and adults!', 0.80, 13, 'product-images/helicopter.png'),
(114, '1000-Piece Jigsaw Puzzle Set', 'Challenge your puzzle-solving skills with this 1000-piece puzzle set. Various designs available.', 1.00, 14, 'product-images/puzzle_set.png'),
(115, 'Sony Xperia 1 III', 'The Sony Xperia 1 III is a high-end smartphone with a focus on photography and multimedia. It boasts a 4K display and a versatile camera system.', 0.38, 3, 'product-images/sony_xperia.png'),
(116, 'Acer Predator Helios 300', 'The Acer Predator Helios 300 is a gaming laptop with powerful hardware for an immersive gaming experience.', 2.90, 4, 'product-images/acer_predator.png'),
(117, 'LEGO Harry Potter Hogwarts Castle', 'Build the iconic Hogwarts Castle with LEGO Harry Potter. Perfect for fans of the wizarding world.', 2.30, 5, 'product-images/lego_hogwarts.png'),
(118, 'Scrabble Board Game', 'Scrabble is a classic word game that challenges your vocabulary and strategic skills.', 1.00, 6, 'product-images/scrabble.png'),
(119, 'Nerf N-Strike Elite Disruptor Blaster', 'The Nerf N-Strike Elite Disruptor Blaster is a high-performance foam dart blaster for exciting battles.', 0.90, 7, 'product-images/nerf_blaster.png'),
(120, 'Microsoft Surface Pro 7', 'The Microsoft Surface Pro 7 is a versatile 2-in-1 laptop that\'s perfect for productivity on the go.', 1.70, 8, 'product-images/surface_pro.png'),
(121, 'LG 55-Inch OLED 4K TV', 'Experience stunning visuals and vibrant colors with this LG 55-Inch OLED 4K TV.', 25.00, 9, 'product-images/lg_oled_tv.png'),
(122, 'American Girl Doll', 'The American Girl Doll is a beloved collectible doll that comes with various accessories and stories.', 2.00, 10, 'product-images/american_girl.png'),
(123, 'Sony WH-1000XM4 Wireless Headphones', 'Enjoy exceptional sound quality and noise-canceling features with these Sony wireless headphones.', 0.29, 11, 'product-images/sony_headphones.png'),
(124, 'Nikon D7500 DSLR Camera', 'Capture incredible photos and videos with the Nikon D7500 DSLR camera, perfect for photography enthusiasts.', 1.60, 12, 'product-images/nikon_camera.png'),
(125, 'R/C Off-Road Buggy', 'Experience off-road racing excitement with this remote control off-road buggy.', 1.10, 13, 'product-images/offroad_buggy.png'),
(126, '1000-Piece World Map Jigsaw Puzzle', 'Challenge yourself with this world map jigsaw puzzle, perfect for geography enthusiasts.', 1.00, 14, 'product-images/world_map_puzzle.png'),
(127, 'Google Pixel 7 / 7 Pro', 'Google pixel 7 Pro powered by google latest Tensor G2 Processor with a Tensor Processing unit.', 4.50, 3, 'product-images/pixel_7_pro.png'),
(128, 'HP Spectre x360', 'The HP Spectre x360 is a premium 2-in-1 laptop with a sleek design and powerful performance.', 2.60, 4, 'product-images/hp_spectre.png'),
(129, 'LEGO Technic Bugatti Chiron', 'Experience the thrill of building a detailed LEGO replica of the Bugatti Chiron sports car.', 3.00, 5, 'product-images/lego_bugatti.png'),
(130, 'Catan Board Game', 'Settle the island of Catan and trade your way to victory in this popular strategy board game.', 2.20, 6, 'product-images/catan.png'),
(131, 'Nintendo Switch', 'The Nintendo Switch is a versatile gaming console for gaming on the go or at home.', 0.88, 7, 'product-images/nintendo_switch.png'),
(132, 'Microsoft Surface Laptop 4', 'The Microsoft Surface Laptop 4 is a lightweight and powerful laptop for professionals and students.', 2.80, 8, 'product-images/surface_laptop.png'),
(133, 'Sony 75-Inch 4K Smart TV', 'Enjoy cinematic entertainment at home with this 75-inch Sony 4K Smart TV.', 46.00, 9, 'product-images/sony_4k_tv.png'),
(134, 'LEGO Creator Expert Roller Coaster', 'Build an impressive roller coaster with this LEGO Creator Expert set, complete with working features.', 4.20, 5, 'product-images/lego_roller_coaster.png'),
(135, 'Ticket to Ride Board Game', 'Embark on a cross-country adventure with the Ticket to Ride board game.', 1.50, 6, 'product-images/ticket_to_ride.png'),
(136, 'Nintendo Switch Lite', 'The Nintendo Switch Lite is a compact and portable gaming console for on-the-go gaming fun.', 0.61, 7, 'product-images/nintendo_switch_lite.png'),
(137, 'HP Envy 13 Laptop', 'The HP Envy 13 is a stylish and lightweight laptop designed for work and entertainment.', 2.30, 4, 'product-images/hp_envy.png'),
(138, 'Samsung 85-Inch 8K Smart TV', 'Experience the future of TV with this 85-inch Samsung 8K Smart TV, offering incredible clarity and detail.', 68.00, 9, 'product-images/samsung_8k_tv.png'),
(139, 'LEGO Ideas International Space Station', 'Recreate the International Space Station with this detailed LEGO Ideas set.', 1.50, 5, 'product-images/lego_iss.png'),
(140, 'Jenga Classic Game', 'Test your skills and balance with the classic Jenga game, a perfect party or family activity.', 0.70, 6, 'product-images/jenga.png'),
(141, 'Sony WF-1000XM4 Wireless Earbuds', 'Experience premium audio quality and noise-canceling with Sony WF-1000XM4 wireless earbuds.', 0.03, 11, 'product-images/sony_earbuds.png'),
(142, 'Canon EOS 90D DSLR Camera', 'Capture stunning photos and videos with the Canon EOS 90D DSLR camera, suitable for both enthusiasts and professionals.', 1.30, 12, 'product-images/canon_90d.png'),
(143, 'R/C Speed Boat', 'Enjoy high-speed water adventures with this remote control speed boat, perfect for outdoor fun.', 1.40, 13, 'product-images/speed_boat.png'),
(144, '1000-Piece National Parks Puzzle Set', 'Explore the beauty of national parks with this 1000-piece puzzle set featuring stunning scenery.', 1.00, 14, 'product-images/national_parks_puzzle.png');

-- --------------------------------------------------------

--
-- Table structure for table `registered_user`
--

CREATE TABLE `registered_user` (
  `user_id` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `registered_user`
--

INSERT INTO `registered_user` (`user_id`, `email`, `password`, `username`) VALUES
(10001, 'john@example.com', 'pbkdf2:sha256:260000$MVW0Ah82nvRSQ8lN$058e712cf4a7060046e93b33a521605932e08b56dad31b00672369b724c200f7', 'johndoe'),
(10002, 'jane@example.com', 'pbkdf2:sha256:260000$qbAzWAbYb0uwMePe$df1aa185c31886824d0b3f6a7b9fbf654fb345600182546083ca7c797f645b5f', 'janesmith'),
(10003, 'david@example.com', 'pbkdf2:sha256:260000$w6D7Ji5KXEXOa84y$9d1f8f81e9b2a42323b82957a6051cb5e39b876b773c455c54eaf325213cfbaf', 'davidj'),
(10004, 'emily@example.com', 'pbkdf2:sha256:260000$GmqNzZdodPtMBETG$407b8bb9f608dab94a1e0e8d0b3364c2e48862c5bc6f47a344a702c579cab4d4', 'emilyd'),
(10005, 'michael@example.com', 'pbkdf2:sha256:260000$qnvFWCklMr2Y4QWy$74f8c9aacbb0baa78df405b202204b3d8789e7dd7b17b33a21e2fa53f73ec6cc', 'michaelw'),
(10006, 'olivia@example.com', 'pbkdf2:sha256:260000$9Kiu2kEyFIpzUDlr$78dc70dd4951952daa6c3ec62800a0886c37ae5ccc9a996f7d51cd9dd8695c06', 'oliviar'),
(10007, 'william@example.com', 'pbkdf2:sha256:260000$I5WNXxzM6GoeaEFZ$ee84e4a10fe124add7d8e75b87795bea5ed6e57a0f826e3892ef0a2d3e5bacff', 'williamr'),
(10008, 'ava@example.com', 'pbkdf2:sha256:260000$WidpCZKQ8iJWKT4U$f97dae5d1c88e6d70211bc3d22761980e24a03ec4c773d2ffc0c0f18ac9db8f2', 'avaa'),
(10009, 'benjamin@example.com', 'pbkdf2:sha256:260000$S52jAtfmNVng8qyp$4d77c52b32e6475971526a19303f647a87d82e82028b2dee397641423bd46890', 'benjaminp'),
(10010, 'sofia@example.com', 'pbkdf2:sha256:260000$4BRaHqmahlTMB3V1$7bfc33d0fb4e0ed64bddc8a49cd29cf8a0eb65fd16f2a86d6850415844151eb8', 'sofiac'),
(10011, 'james@example.com', 'pbkdf2:sha256:260000$kjfjB98Y4zdoF8Es$ef7b8ecfe76bc185249a0fdbd3a4a1603fba85e7c39fc7170f509b88ce5f3fdd', 'jamesb'),
(10012, 'charlotte@example.com', 'pbkdf2:sha256:260000$vxC9bV6QKDSCT9Mt$e55de1aaec5e24f4ddd669304bb02ade37a70c68d18bf3ce5218e6c7b083d11d', 'charlottec'),
(10013, 'alexander@example.com', 'pbkdf2:sha256:260000$GD8TdPHhwQCbfUBp$9e434684cca3c31eb7038ce4a7e0ffddf8a1d4f2c7d2a28935e3cee75b127596', 'alexandera'),
(10014, 'emma@example.com', 'pbkdf2:sha256:260000$1e2l8N0qid925FTg$8cf5b8cfb5f35c57f6d39f6f782e401eccec22a9671b5b0a3f9b0978e6a46776', 'emmae'),
(10015, 'daniel@example.com', 'pbkdf2:sha256:260000$QZfefjU3p4aGJIZR$e40636ef21c9c21b2c37716ef6a8df65c3158ece073201955d3aaa23699fef66', 'danielg'),
(10016, 'amelia@example.com', 'pbkdf2:sha256:260000$kJ2uOJjgi7EGo8ZF$3986452b2007d986ddfa3bd3f54f893403405a3eddb788051fd1ac7756a7da23', 'ameliap'),
(10017, 'henry@example.com', 'pbkdf2:sha256:260000$nuq5mLDezxhIoG6h$b0a876c28fafe460fadb45ac68e153548b7d0e75c0e0a36c257f6c7ee1e8d154', 'henryh'),
(10018, 'oliver@example.com', 'pbkdf2:sha256:260000$2KTbRfab6StpbT2X$21bb97328c51bed26fc50a3e07d94a51dc057c632c83139e586070a5fd8b676b', 'olivero'),
(10019, 'ella@example.com', '123456789', 'ellae'),
(10020, 'liam@example.com', 'pbkdf2:sha256:260000$bEeofz88lI4LkCBn$175bff1260f23bf91694d3f78bd023f4074dccf33453c307a0e5f052e504c924', 'liaml'),
(10021, 'ava2@example.com', 'pbkdf2:sha256:260000$GyMi7SnZ6yaLxMVy$b54426e740e6041c0eb484f02f4cd1955a42ec4d48db4f06ece6c5fe73c02f3b', 'ava2a'),
(10022, 'noah@example.com', 'pbkdf2:sha256:260000$HolRdn7jaK2Fojki$42a0a8d1689dbc053a76d166db2f6bf2eda1d8bd600736eb3c6d2d01f0db18a6', 'noahn'),
(10023, 'jeevan@gmail.com', 'pbkdf2:sha256:260000$rktEfhAgqddOwszr$3f2ed01ee02d11908283cdf14cf6008121afa1820dfdf549ecad9d91e05ab39c', 'jeevan'),
(10024, 'jeevanmku@gmail.com', 'pbkdf2:sha256:260000$GKC9q7hcBfDdVi6D$8ef807752d887832a2eee6221c960521d7c3a64323b426878a3758de4fc407aa', 'jeevan8'),
(10025, 'jeevanmku@gmail.com', 'pbkdf2:sha256:260000$kyknBLlUMgNrl0SL$23561ba74aa3a8aaee1daea5992b3923a3d9b70ab8d17149781763c8efbd2974', 'jeevan80'),
(10026, 'hi@gmail.com', 'pbkdf2:sha256:260000$WnfltGKvo3EDxlx3$88f8651745cfd3bd7d005690799cf1ec7fdad486b708ec884811841b6c8e50db', 'jeevan800');

-- --------------------------------------------------------

--
-- Table structure for table `variant`
--

CREATE TABLE `variant` (
  `variant_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `custom_attrbutes` text DEFAULT NULL,
  `variant_image` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `variant`
--

INSERT INTO `variant` (`variant_id`, `product_id`, `name`, `price`, `custom_attrbutes`, `variant_image`) VALUES
(501, 103, 'MacBook Air 13 - Space Gray', 1199.99, '8GB RAM,Lightweight and powerful', 'product-images/macbook_air.png'),
(502, 103, 'MacBook Air 13 - Silver', 1249.99, '16GB RAM,Enhanced performance', 'product-images/macbook_air.png'),
(503, 102, 'Dell XPS 13 - Silver', 1099.99, '16GB RAM,Top-tier computing excellence', 'product-images/Dell_XPS_13.png'),
(504, 102, 'Dell XPS 13 - Black', 1149.99, '32GB RAM,Upgrade for more power', 'product-images/Dell_XPS_13.png'),
(505, 101, 'LEGO Star Wars Millennium Falcon - Standard', 49.99, 'Regular edition', 'product-images/lego_falcon.png'),
(506, 101, 'LEGO Star Wars Millennium Falcon - Deluxe', 69.99, 'Larger and more detailed version', 'product-images/lego_falcon.png'),
(507, 104, 'iPhone 12 Pro - Silver', 1099.99, '128GB Storage,Exceptional camera capabilities', 'product-images/iphone_12.png'),
(508, 104, 'iPhone 12 Pro - Gold', 1149.99, '256GB Storage,More storage for your photos', 'product-images/iphone_12.png'),
(509, 105, 'Samsung Galaxy S21 Ultra - Phantom Black', 1199.99, '256GB Storage,Unmatched performance and camera system', 'product-images/galaxy_s21.png'),
(510, 105, 'Samsung Galaxy S21 Ultra - Mystic Bronze', 1249.99, '512GB Storage,High-capacity storage', 'product-images/galaxy_s21.png'),
(511, 106, 'Monopoly Board Game - Classic Edition', 19.99, 'Traditional family fun', 'product-images/monopoly.png'),
(512, 106, 'Monopoly Board Game - Deluxe Edition', 29.99, 'Luxurious edition', 'product-images/monopoly.png'),
(513, 107, 'Hot Wheels Die-Cast Cars Set - Assorted Models', 12.99, 'Various cool die-cast cars', 'product-images/hot_wheels.png'),
(514, 107, 'Hot Wheels Die-Cast Cars Set - Limited Edition', 19.99, 'Limited collectible cars', 'product-images/hot_wheels.png'),
(515, 108, 'iPad Air - Space Gray', 499.99, '64GB Storage,Power and portability in one', 'product-images/ipad_air.png'),
(516, 108, 'iPad Air - Silver', 549.99, '128GB Storage,More storage for your apps', 'product-images/ipad_air.png'),
(517, 109, 'Samsung 65-Inch 4K Smart TV - Black', 999.99, '65-inch stunning visuals', 'product-images/samsung_tv.png'),
(518, 109, 'Samsung 65-Inch 4K Smart TV - Silver', 1049.99, '75-inch stunning visuals', 'product-images/samsung_tv.png'),
(519, 110, 'Barbie Dreamhouse - Pink', 199.99, 'Luxurious Barbie mansion', 'product-images/barbie_dreamhouse.png'),
(520, 110, 'Barbie Dreamhouse - Purple', 219.99, 'Enhanced play features', 'product-images/barbie_dreamhouse.png'),
(521, 111, 'Bose Noise-Canceling Headphones - Black', 299.99, 'Immerse in high-quality audio', 'product-images/bose_headphones.png'),
(522, 111, 'Bose Noise-Canceling Headphones - Silver', 319.99, 'Premium sound experience', 'product-images/bose_headphones.png'),
(523, 112, 'Canon EOS Rebel T7 DSLR Camera - Black', 449.99, '18-55mm Lens Kit,Stunning photos and videos', 'product-images/canon_camera.png'),
(524, 112, 'Canon EOS Rebel T7 DSLR Camera - Bundle', 549.99, 'Extra lenses and accessories', 'product-images/canon_camera.png'),
(525, 113, 'Remote Control Helicopter - Blue', 49.99, 'Blue-themed fun', 'product-images/helicopter.png'),
(526, 113, 'Remote Control Helicopter - Red', 49.99, 'Red-themed excitement', 'product-images/helicopter.png'),
(527, 114, '1000-Piece Jigsaw Puzzle Set - Scenic Landscapes', 29.99, 'Beautiful puzzle scenes', 'product-images/puzzle_set.png'),
(528, 114, '1000-Piece Jigsaw Puzzle Set - Wildlife', 29.99, 'Exciting wildlife scenes', 'product-images/puzzle_set.png'),
(529, 115, 'Sony Xperia 1 III - Black', 1099.99, '256GB Storage,High-end smartphone with 4K display', 'product-images/sony_xperia.png'),
(530, 115, 'Sony Xperia 1 III - Blue', 1149.99, '512GB Storage,Expanded storage options', 'product-images/sony_xperia.png'),
(531, 116, 'Acer Predator Helios 300 - Black', 1299.99, 'RTX 3060,Powerful gaming laptop', 'product-images/acer_predator.png'),
(532, 116, 'Acer Predator Helios 300 - Red', 1349.99, 'RTX 3080,Top-tier gaming performance', 'product-images/acer_predator.png'),
(533, 117, 'LEGO Harry Potter Hogwarts Castle - Deluxe', 129.99, 'Larger and more detailed version', 'product-images/lego_hogwarts.png'),
(534, 117, 'LEGO Harry Potter Hogwarts Castle - Limited Edition', 149.99, 'Collectible limited edition', 'product-images/lego_hogwarts.png'),
(535, 118, 'Scrabble Board Game - Deluxe Edition', 39.99, 'Luxurious word gaming', 'product-images/scrabble.png'),
(536, 118, 'Scrabble Board Game - Travel Edition', 24.99, 'Compact travel fun', 'product-images/scrabble.png'),
(537, 119, 'Nerf N-Strike Elite Disruptor Blaster - Red', 19.99, 'Red dart-blasting action', 'product-images/nerf_blaster.png'),
(538, 119, 'Nerf N-Strike Elite Disruptor Blaster - Blue', 19.99, 'Blue dart-blasting action', 'product-images/nerf_blaster.png'),
(539, 120, 'Microsoft Surface Pro 7 - Platinum', 899.99, 'Core i5,Productivity on the go', 'product-images/surface_pro.png'),
(540, 120, 'Microsoft Surface Pro 7 - Black', 949.99, 'Core i7,Enhanced performance', 'product-images/surface_pro.png'),
(541, 121, 'LG 55-Inch OLED 4K TV - Silver', 1099.99, '55-inch OLED display,Stunning visuals and colors', 'product-images/lg_oled_tv.png'),
(542, 121, 'LG 55-Inch OLED 4K TV - Black', 1149.99, '55-inch OLED display,In black color', 'product-images/lg_oled_tv.png'),
(543, 122, 'American Girl Doll - Samantha', 129.99, 'Comes with Samantha\'s accessories', 'product-images/american_girl.png'),
(544, 122, 'American Girl Doll - Rebecca', 129.99, 'Comes with Rebecca\'s accessories', 'product-images/american_girl.png'),
(545, 123, 'Black', 299.99, 'With 2 years Sony warranty!', 'product-images/sony_headphones.png'),
(546, 124, 'Silver', 949.99, 'With 2 years Nikon warranty!', 'product-images/nikon_camera.png'),
(547, 125, 'Green', 49.99, 'With 1 year R/C Buggy warranty!', 'product-images/offroad_buggy.png'),
(548, 125, 'Red', 59.99, 'With 1 year R/C Buggy warranty!', 'product-images/offroad_buggy.png'),
(549, 126, 'World Map', 24.99, 'High-quality puzzle!', 'product-images/world_map_puzzle.png'),
(550, 126, 'Historical Map', 29.99, 'High-quality puzzle!', 'product-images/world_map_puzzle.png'),
(551, 127, 'Standard', 499.99, 'With 2 years Sony warranty!', 'product-images/pixel_7_pro.png'),
(552, 127, 'Pro', 599.99, 'With 2 years Sony warranty!', 'product-images/pixel_7_pro.png'),
(553, 128, '8GB RAM', 1299.99, 'With 3 years HP warranty!', 'product-images/hp_spectre.png'),
(554, 128, '16GB RAM', 1499.99, 'With 3 years HP warranty!', 'product-images/hp_spectre.png'),
(555, 129, 'Lamborghini Sian', 349.99, 'Build the Lamborghini Sian!', 'product-images/lego_bugatti.png'),
(556, 130, 'Catan Board Game', 29.99, 'Strategic board game for all ages!', 'product-images/catan.png'),
(557, 130, 'Catan Expansion', 39.99, 'Expand your Catan experience!', 'product-images/catan.png'),
(558, 131, 'Neon Blue', 299.99, 'Includes two controllers!', 'product-images/nintendo_switch.png'),
(559, 131, 'Gray', 299.99, 'Includes two controllers!', 'product-images/nintendo_switch.png'),
(560, 132, 'Black', 999.99, 'Ultra-slim design', 'product-images/surface_laptop.png'),
(561, 132, 'Silver', 1099.99, 'High-resolution display', 'product-images/surface_laptop.png'),
(562, 133, '75-Inch', 1499.99, 'Smart TV with voice control', 'product-images/sony_4k_tv.png'),
(563, 133, '85-Inch', 1899.99, 'Large 4K screen for an immersive experience', 'product-images/sony_4k_tv.png'),
(564, 134, 'Roller Coaster Set', 199.99, 'Working roller coaster with minifigures', 'product-images/lego_roller_coaster.png'),
(565, 134, 'Ferris Wheel Set', 249.99, 'Build your own Ferris wheel attraction', 'product-images/lego_roller_coaster.png'),
(566, 135, 'Standard Edition', 29.99, 'Classic board game fun for the family', 'product-images/ticket_to_ride.png'),
(567, 135, 'Europe Edition', 39.99, 'Travel across Europe in this special edition', 'product-images/ticket_to_ride.png'),
(568, 136, 'Turquoise', 179.99, 'Stylish color option for gaming enthusiasts', 'product-images/nintendo_switch_lite.png'),
(569, 137, 'Intel Core i5', 999.99, 'Powerful performance for everyday tasks', 'product-images/hp_envy.png'),
(570, 137, 'Intel Core i7', 1199.99, 'High-performance laptop for multitasking', 'product-images/hp_envy.png'),
(571, 138, '85-Inch', 3999.99, '8K resolution for a cinematic viewing experience', 'product-images/samsung_8k_tv.png'),
(572, 138, '100-Inch', 4999.99, 'Immersive large-screen entertainment', 'product-images/samsung_8k_tv.png'),
(573, 139, 'International Space Station', 79.99, 'Recreate the ISS in intricate detail', 'product-images/lego_iss.png'),
(574, 140, 'Giant Edition', 49.99, 'Giant-sized Jenga for outdoor fun', 'product-images/jenga.png'),
(575, 141, 'Black', 199.99, 'High-quality sound with noise-canceling', 'product-images/sony_earbuds.png'),
(576, 141, 'Silver', 229.99, 'Premium wireless earbuds for music lovers', 'product-images/sony_earbuds.png'),
(577, 142, 'Body Only', 899.99, 'Capture stunning photos with the camera body only', 'product-images/canon_90d.png'),
(578, 142, 'Kit with 18-55mm Lens', 1099.99, 'Complete kit for photography enthusiasts', 'product-images/canon_90d.png'),
(579, 143, 'Blue', 39.99, 'Speedy remote control boat for water enthusiasts', 'product-images/speed_boat.png'),
(580, 143, 'Red', 39.99, 'Enjoy high-speed adventures on the water', 'product-images/speed_boat.png'),
(581, 144, 'National Parks Set 1', 24.99, 'Explore the beauty of US national parks', 'product-images/national_parks_puzzle.png'),
(582, 144, 'National Parks Set 2', 24.99, 'Discover more national parks with this puzzle set', 'product-images/national_parks_puzzle.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`order_item_id`);

--
-- Indexes for table `cart_item`
--
ALTER TABLE `cart_item`
  ADD PRIMARY KEY (`user_id`,`variant_id`),
  ADD KEY `fk_cart_item1` (`variant_id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`),
  ADD KEY `idx_category_id` (`category_id`),
  ADD KEY `fk_category` (`parent_category_id`);

--
-- Indexes for table `delivery_module`
--
ALTER TABLE `delivery_module`
  ADD PRIMARY KEY (`delivery_module_id`),
  ADD KEY `fk_delivery_module` (`order_item_id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD KEY `fk_inventory` (`variant_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `idx_order_id` (`order_id`),
  ADD KEY `fk_order` (`user_id`);

--
-- Indexes for table `order_item`
--
ALTER TABLE `order_item`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `idx_order_item_id` (`order_item_id`),
  ADD KEY `fk_order_item0` (`order_id`),
  ADD KEY `fk_order_item1` (`variant_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `idx_product_id` (`product_id`),
  ADD KEY `fk_product` (`category_id`);

--
-- Indexes for table `registered_user`
--
ALTER TABLE `registered_user`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- Indexes for table `variant`
--
ALTER TABLE `variant`
  ADD PRIMARY KEY (`variant_id`),
  ADD KEY `idx_variant_id` (`variant_id`),
  ADD KEY `fk_variant` (`product_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart_item`
--
ALTER TABLE `cart_item`
  ADD CONSTRAINT `fk_cart_item0` FOREIGN KEY (`user_id`) REFERENCES `registered_user` (`user_id`),
  ADD CONSTRAINT `fk_cart_item1` FOREIGN KEY (`variant_id`) REFERENCES `variant` (`variant_id`);

--
-- Constraints for table `category`
--
ALTER TABLE `category`
  ADD CONSTRAINT `fk_category` FOREIGN KEY (`parent_category_id`) REFERENCES `category` (`category_id`);

--
-- Constraints for table `delivery_module`
--
ALTER TABLE `delivery_module`
  ADD CONSTRAINT `fk_delivery_module` FOREIGN KEY (`order_item_id`) REFERENCES `order_item` (`order_item_id`);

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `fk_inventory` FOREIGN KEY (`variant_id`) REFERENCES `variant` (`variant_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_order` FOREIGN KEY (`user_id`) REFERENCES `registered_user` (`user_id`);

--
-- Constraints for table `order_item`
--
ALTER TABLE `order_item`
  ADD CONSTRAINT `fk_order_item0` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `fk_order_item1` FOREIGN KEY (`variant_id`) REFERENCES `variant` (`variant_id`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `fk_product` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`);

--
-- Constraints for table `variant`
--
ALTER TABLE `variant`
  ADD CONSTRAINT `fk_variant` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;



