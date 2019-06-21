.open store_management.db

CREATE TABLE IF NOT EXISTS `work_orders` (
    `id` INTEGER,
    `name` VARCHAR CHECK(LENGTH(`name`) <= 50) NOT NULL DEFAULT 'Anonymous',
    `phone_number` VARCHAR CHECK(LENGTH(`phone_number`) <= 19) NOT NULL,
    `email` VARCHAR CHECK(LENGTH(`email`) <= 50) DEFAULT 'Nothing',
    `address` VARCHAR CHECK(LENGTH(`address`) <= 50) NOT NULL,
    `items_for_service` VARCHAR CHECK(LENGTH(`items_for_service`) <= 100) NOT NULL DEFAULT 'Laptop',
    `problem` VARCHAR CHECK(LENGTH(`problem`) <= 255) NOT NULL,
    `order_date` DATE CHECK(LENGTH(`order_date`) <= 10) NOT NULL,
    `order_time` TIME CHECK(LENGTH(`order_time`) <= 8) DEFAULT 'Nothing',
    `deadline_date` DATE CHECK(LENGTH(`deadline_date`) <= 10) DEFAULT 'Nothing',
    `deadline_time` TIME CHECK(LENGTH(`deadline_time`) <= 8) DEFAULT 'Nothing',
    `image_path` VARCHAR CHECK(LENGTH(`image_path`) <= 255) DEFAULT 'Nothing',
    PRIMARY KEY(`id`)
);

CREATE TABLE IF NOT EXISTS `bill` (
    `work_order_id` INTEGER NOT NULL UNIQUE,
    `cost` INT CHECK(`cost` <= 100000000),
    `fee` INT CHECK(`fee` <= 100000000),
    `charge` INT CHECK(`charge` <= 100000000),
    `transaction_date` DATE CHECK(LENGTH(`transaction_date`) <= 10) DEFAULT 'Nothing',
    `transaction_time` TIME CHECK(LENGTH(`transaction_time`) <= 8) DEFAULT 'Nothing',
    `status` VARCHAR CHECK(LENGTH(`status`) <= 18) NOT NULL DEFAULT 'Menunggu Perbaikan',
    FOREIGN KEY(`work_order_id`) REFERENCES `work_orders`(`id`) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `merchandise` (
    `id` INTEGER,
    `name` VARCHAR CHECK(LENGTH(`name`) <= 50) NOT NULL DEFAULT 'Unknown',
    `cost` INT CHECK(`cost` <= 100000000) NOT NULL,
    `fee` INT CHECK(`fee` <= 100000000),
    `charge` INT CHECK(`charge` <= 100000000),
    `transaction_date` DATE CHECK(LENGTH(`transaction_date`) <= 10) DEFAULT 'Nothing',
    `transaction_time` TIME CHECK(LENGTH(`transaction_time`) <= 8) DEFAULT 'Nothing',
    `status` VARCHAR CHECK(LENGTH(`status`) <= 13) NOT NULL DEFAULT 'Belum Terjual',
    `image_path` VARCHAR CHECK(LENGTH(`image_path`) <= 255) DEFAULT 'Nothing',
    PRIMARY KEY(`id`)
);

CREATE TABLE IF NOT EXISTS `retribution` (
    `id` INTEGER,
    `cost` INT CHECK(`cost` <= 1000000) NOT NULL DEFAULT 100000,
    `fee` INT CHECK(`fee` <= 1000000) NOT NULL DEFAULT 100000,
    `charge` INT CHECK(`charge` <= 1000000),
    `valid_for_days` INT CHECK(`valid_for_days` <= 7) NOT NULL DEFAULT 1,
    `transaction_date` DATE CHECK(LENGTH(`transaction_date`) <= 10) NOT NULL DEFAULT 'Nothing',
    `transaction_time` TIME CHECK(LENGTH(`transaction_time`) <= 8) DEFAULT 'Nothing',
    `image_path` VARCHAR CHECK(LENGTH(`image_path`) <= 255) DEFAULT 'Nothing',
    PRIMARY KEY(`id`)
);

CREATE TRIGGER IF NOT EXISTS `insert_new_bill` AFTER INSERT ON `work_orders` BEGIN
        INSERT INTO `bill` VALUES (NEW.`id`, 0, 0, 0, 'Nothing', 'Nothing', 'Menunggu Perbaikan');
    END;

CREATE TRIGGER IF NOT EXISTS `check_status_bill` BEFORE INSERT ON `bill` BEGIN
        SELECT CASE WHEN NEW.`status` NOT IN ('Menunggu Perbaikan', 'Sedang Diperbaiki', 'Sudah Diperbaiki') THEN
            RAISE(ABORT, 'Invalid status!!!')
        END;
    END;

CREATE TRIGGER IF NOT EXISTS `check_status_merchandise` BEFORE INSERT ON `merchandise` BEGIN
        SELECT CASE WHEN NEW.`status` NOT IN ('Belum Terjual', 'Sudah Terjual') THEN
            RAISE(ABORT, 'Invalid status!!!')
        END;
    END;

INSERT INTO `work_orders` VALUES
    (1, 'Ricky Yunus', '+62 812-1731-1231', 'ricky.yunus@hotmail.com', 'Jl. Menteng XXIV', 'Laptop', 'Monitor pecah', '2019-06-12', '16:00:00', '2019-07-12', '16:00:00', 'C:/home/1.png'),
    (2, 'Atallabela Yosua', '+62 812-7885-1450', 'anaivedreamer@gmail.com', 'Jl. Tampung Penyang I No. 03', 'Printer', 'Habis tinta', '2019-07-13', '12:00:00', '2019-08-14', '13:00:00', 'C:/home/2.jpg'),
    (3, 'Andy', '+62 825-1245-2345', 'andy@proton.com', 'Jl. Temanggung Tilung III', 'PC All in One', 'Monitor pecah', '2019-07-14', '14:00:00', '2019-08-12', '14:00:00', 'C:/home/3.png');

INSERT INTO `merchandise` VALUES
    (1, 'Printer', 500000, 0, 0, 'Nothing', 'Nothing', 'Belum Terjual', 'Nothing'),
    (2, 'Printer', 560000, 600000, 40000, '2019-07-13', '13:30:00', 'Sudah Terjual', 'Nothing'),
    (3, 'Notebook', 5450000, 6000000, 550000, '2019-07-14', '16:00:00', 'Sudah Terjual', 'Nothing');

INSERT INTO `retribution` VALUES
    (1, 200000, 200000, 0, 2, '2019-07-12', '13:00:00', 'Nothing'),
    (2, 200000, 200000, 0, 2, '2019-07-13', '13:00:00', 'Nothing'),
    (3, 600000, 600000, 0, 6, '2019-07-14', '16:00:00', 'Nothing');
