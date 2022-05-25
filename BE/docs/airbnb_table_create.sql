-- -----------------------------------------------------
-- Schema airbnb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `airbnb`;

-- -----------------------------------------------------
-- Schema airbnb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `airbnb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `airbnb`;


-- -----------------------------------------------------
-- Table `hibernate_sequence`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hibernate_sequence`
(
    `next_val` BIGINT NULL DEFAULT NULL
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `accommodation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `accommodation`
(
    `accommodation_id`   BIGINT       NOT NULL,
    `name`               VARCHAR(255) NOT NULL,
    `price`              INT          NOT NULL,
    `latitude`           DOUBLE       NOT NULL,
    `longitude`          DOUBLE       NOT NULL,
    `city`               VARCHAR(255) NOT NULL,
    `country`            VARCHAR(255) NOT NULL,
    `gu`                 VARCHAR(255) NOT NULL,
    `accommodation_type` VARCHAR(255) NOT NULL,
    `host_name`          VARCHAR(255) NOT NULL,
    `description`        VARCHAR(255) NOT NULL,
    `primary_image_url`  VARCHAR(255) NOT NULL,
    `max_guest`          INT          NOT NULL,
    `number_of_room`     INT          NOT NULL,
    `number_of_bed`      INT          NOT NULL,
    `number_of_bathroom` INT          NOT NULL,
    `created_date`       DATETIME(6)  NULL DEFAULT (CURRENT_TIME),
    PRIMARY KEY (`accommodation_id`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `customer`
(
    `customer_id` BIGINT       NOT NULL,
    `user_id`     VARCHAR(255) NOT NULL,
    PRIMARY KEY (`customer_id`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reservation`
(
    `reservation_id`   BIGINT      NOT NULL,
    `check_in_date`    DATE        NOT NULL,
    `check_out_date`   DATE        NOT NULL,
    `number_of_guest`  INT         NOT NULL,
    `number_of_infant` INT         NOT NULL,
    `price_per_day`    INT         NOT NULL,
    `total`            INT         NOT NULL,
    `discount`         INT         NULL DEFAULT 0,
    `cleaning_fee`     INT         NULL DEFAULT 0,
    `service_fee`      INT         NULL DEFAULT 0,
    `vat`              INT         NOT NULL,
    `accommodation_id` BIGINT      NOT NULL,
    `customer_id`      BIGINT      NOT NULL,
    `created_date`     DATETIME(6) NULL DEFAULT (CURRENT_TIME),
    PRIMARY KEY (`reservation_id`),
    INDEX `fk_reservation_accommodation_idx` (`accommodation_id` ASC) VISIBLE,
    INDEX `fk_reservation_customer_idx` (`customer_id` ASC) VISIBLE,
    CONSTRAINT `fk_reservation_customer`
        FOREIGN KEY (`customer_id`)
            REFERENCES `customer` (`customer_id`),
    CONSTRAINT `fk_reservation_accommodation`
        FOREIGN KEY (`accommodation_id`)
            REFERENCES `accommodation` (`accommodation_id`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `review`
(
    `review_id`        BIGINT       NOT NULL,
    `score`            INT          NULL DEFAULT NULL,
    `comment`          VARCHAR(255) NULL DEFAULT NULL,
    `accommodation_id` BIGINT       NOT NULL,
    `created_date`     DATETIME(6)  NULL DEFAULT (CURRENT_TIME),
    PRIMARY KEY (`review_id`),
    INDEX `fk_review_accommodation_idx` (`accommodation_id` ASC) VISIBLE,
    CONSTRAINT `fk_review_accommodation`
        FOREIGN KEY (`accommodation_id`)
            REFERENCES `accommodation` (`accommodation_id`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `secondary_image`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `secondary_image`
(
    `secondary_image_id` BIGINT       NOT NULL,
    `url`                VARCHAR(255) NOT NULL,
    `accommodation_id`   BIGINT       NOT NULL,
    PRIMARY KEY (`secondary_image_id`),
    INDEX `fk_secondary_image_accommodation_idx` (`accommodation_id` ASC) VISIBLE,
    CONSTRAINT `fk_secondary_image_accommodation`
        FOREIGN KEY (`accommodation_id`)
            REFERENCES `accommodation` (`accommodation_id`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `wish`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wish`
(
    `wish_id`          BIGINT      NOT NULL,
    `accommodation_id` BIGINT      NOT NULL,
    `customer_id`      BIGINT      NOT NULL,
    `created_date`     DATETIME(6) NULL DEFAULT (CURRENT_TIME),
    PRIMARY KEY (`wish_id`),
    INDEX `fk_wish_accommodation_idx` (`accommodation_id` ASC) VISIBLE,
    INDEX `fk_wish_customer_idx` (`customer_id` ASC) VISIBLE,
    CONSTRAINT `fk_wish_accommodation`
        FOREIGN KEY (`accommodation_id`)
            REFERENCES `accommodation` (`accommodation_id`),
    CONSTRAINT `fk_wish_customer`
        FOREIGN KEY (`customer_id`)
            REFERENCES `customer` (`customer_id`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;
