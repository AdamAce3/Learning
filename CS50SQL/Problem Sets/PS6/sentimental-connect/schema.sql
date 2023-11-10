-- CREATE DATABASE `linkedin`;
-- USE `linkedin`;

CREATE TABLE IF NOT EXISTS `users` (
    `id` INT UNSIGNED AUTO_INCREMENT,
    `first_name` VARCHAR(32) NOT NULL,
    `last_name` VARCHAR(32) NOT NULL,
    `username` VARCHAR(16) NOT NULL UNIQUE,
    `password` VARCHAR(128) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `schools_universities` (
    `id` INT UNSIGNED AUTO_INCREMENT,
    `name` VARCHAR(32) NOT NULL UNIQUE,
    `type` ENUM('Primary','Secondary','Higher Education') NOT NULL,
    `location` VARCHAR(50) NOT NULL,
    `founded` YEAR NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `companies` (
    `id` INT UNSIGNED AUTO_INCREMENT,
    `name` VARCHAR(32) NOT NULL UNIQUE,
    `industry` ENUM('Technology','Education','Business') NOT NULL,
    `location` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `connections_users` (
    `user_id1` INT UNSIGNED,
    `user_id2` INT UNSIGNED,
    PRIMARY KEY (`user_id1`, `user_id2`),
    FOREIGN KEY (`user_id1`) REFERENCES `users`(`id`),
    FOREIGN KEY (`user_id2`) REFERENCES `users`(`id`)
);

CREATE TABLE IF NOT EXISTS `connections_schools` (
    `user_id` INT UNSIGNED,
    `school_id` INT UNSIGNED,
    `start_date` DATE NOT NULL,
    `end_date` DATE,
    `degree` VARCHAR(5) NOT NULL,
    PRIMARY KEY (`user_id`, `school_id`),
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY (`school_id`) REFERENCES `schools_universities`(`id`)
);

CREATE TABLE IF NOT EXISTS `connections_companies` (
    `user_id` INT UNSIGNED,
    `company_id` INT UNSIGNED,
    `start_date` DATE NOT NULL,
    `end_date` DATE,
    PRIMARY KEY (`user_id`, `company_id`),
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY (`company_id`) REFERENCES `companies`(`id`)
);