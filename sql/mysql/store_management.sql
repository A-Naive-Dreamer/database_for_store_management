CREATE DATABASE IF NOT EXISTS `store_management`;

USE `store_management`;

CREATE TABLE IF NOT EXISTS `work_orders` (
    `id` INT(11) UNSIGNED NOT NULL,
    `name` VARCHAR(50) NOT NULL DEFAULT 'Anonymous',
    `phone_number` VARCHAR(19) NOT NULL,
    `email` VARCHAR(50) DEFAULT 'Nothing',
    `address` VARCHAR(50) NOT NULL,
    `items_for_service` VARCHAR(100) NOT NULL DEFAULT 'Laptop',
    `problem` VARCHAR(255) NOT NULL,
    `order_date` DATE NOT NULL,
    `order_time` TIME,
    `deadline_date` DATE,
    `deadline_time` TIME,
    `image_path` VARCHAR(255) DEFAULT 'Nothing',
    PRIMARY KEY(`id`)
);

CREATE TABLE IF NOT EXISTS `bill` (
    `work_order_id` INT(11) UNSIGNED NOT NULL UNIQUE,
    `cost` INT(9) UNSIGNED,
    `fee` INT(9) UNSIGNED,
    `charge` INT(9) UNSIGNED,
    `transaction_date` DATE,
    `transaction_time` TIME,
    `status` ENUM('Menunggu Perbaikan', 'Sedang Diperbaiki', 'Sudah Diperbaiki'),
    FOREIGN KEY (`work_order_id`) REFERENCES `work_orders`(`id`)
);

CREATE TABLE IF NOT EXISTS `merchandise` (
    `id` INT(11) UNSIGNED NOT NULL,
    `name` VARCHAR(50) NOT NULL DEFAULT 'Unknown',
    `cost` INT(9) UNSIGNED NOT NULL,
    `fee` INT(9) UNSIGNED,
    `charge` INT(9) UNSIGNED,
    `transaction_date` DATE,
    `transaction_time` TIME,
    `status` ENUM('Belum Terjual', 'Sudah Terjual'),
    `image_path` VARCHAR(255) DEFAULT 'Nothing',
    PRIMARY KEY(`id`)
);

CREATE TABLE IF NOT EXISTS `retribution` (
    `id` INT(11) UNSIGNED NOT NULL,
    `cost` INT(7) UNSIGNED,
    `fee` INT(7) UNSIGNED,
    `charge` INT(7) UNSIGNED,
    `valid_for_days` INT(1) UNSIGNED NOT NULL DEFAULT 1,
    `transaction_date` DATE,
    `transaction_time` TIME,
    `image_path` VARCHAR(255) DEFAULT 'Nothing',
    PRIMARY KEY(`id`)
);

INSERT INTO `work_orders` VALUES
    (1, 'Ricky Yunus', '+62 812-1731-1231', 'ricky.yunus@hotmail.com', 'Jl. Menteng XXIV', 'Laptop', 'Monitor pecah', '2019-06-12', '16:00:00', '2019-07-12', '16:00:00', 'C:/home/1.png'),
    (2, 'Atallabela Yosua', '+62 812-7885-1450', 'anaivedreamer@gmail.com', 'Jl. Tampung Penyang I No. 03', 'Printer', 'Habis tinta', '2019-07-13', '12:00:00', '2019-08-14', '13:00:00', 'C:/home/2.jpg'),
    (3, 'Andy', '+62 825-1245-2345', 'andy@proton.com', 'Jl. Temanggung Tilung III', 'PC All in One', 'Monitor pecah', '2019-07-14', '14:00:00', '2019-08-12', '14:00:00', 'C:/home/3.png');

INSERT INTO `bill` VALUES
    (1, 0, 0, 0, NULL, NULL, 'Menunggu Perbaikan'),
    (2, 0, 0, 0, NULL, NULL, 'Menunggu Perbaikan'),
    (3, 0, 0, 0, NULL, NULL, 'Menunggu Perbaikan');

INSERT INTO `merchandise` VALUES
    (1, 'Printer', 500000, 0, 0, NULL, NULL, 'Belum Terjual', 'Nothing'),
    (2, 'Printer', 560000, 600000, 40000, '2019-07-13', '13:30:00', 'Sudah Terjual', 'Nothing'),
    (3, 'Notebook', 5450000, 6000000, 550000, '2019-07-14', '16:00:00', 'Sudah Terjual', 'Nothing');

INSERT INTO `retribution` VALUES
    (1, 200000, 200000, 0, 2, '2019-07-12', '13:00:00', 'Nothing'),
    (2, 200000, 200000, 0, 2, '2019-07-13', '13:00:00', 'Nothing'),
    (3, 600000, 600000, 0, 6, '2019-07-14', '16:00:00', 'Nothing');
