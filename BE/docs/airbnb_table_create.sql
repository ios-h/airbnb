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
-- Table `accommodation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `accommodation`
(
    `accommodation_id`   BIGINT       NOT NULL AUTO_INCREMENT,
    `name`               VARCHAR(50) NOT NULL,
    `price`              INT          NOT NULL,
    `latitude`           DOUBLE       NOT NULL,
    `longitude`          DOUBLE       NOT NULL,
    `address`            VARCHAR(100) NOT NULL,
    `accommodation_type` VARCHAR(20) NOT NULL,
    `host_name`          VARCHAR(20) NOT NULL,
    `description`        VARCHAR(255) NOT NULL,
    `max_guest`          INT          NOT NULL,
    `number_of_room`     INT          NOT NULL,
    `number_of_bed`      INT          NULL DEFAULT 0,
    `number_of_bathroom` INT          NULL DEFAULT 0,
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
    `customer_id` BIGINT       NOT NULL AUTO_INCREMENT,
    `user_id`     VARCHAR(30)  NOT NULL,
    `created_date`  DATETIME(6) NULL,
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
    `reservation_id`   BIGINT      NOT NULL AUTO_INCREMENT,
    `check_in_date`    DATE        NOT NULL,
    `check_out_date`   DATE        NOT NULL,
    `number_of_guest`  INT         NOT NULL,
    `number_of_infant` INT         NOT NULL,
    `price_per_day`    INT         NOT NULL,
    `total`            INT         NOT NULL,
    `discount`         INT         NULL DEFAULT 0,
    `cleaning_fee`     INT         NULL DEFAULT 0,
    `service_fee`      INT         NULL DEFAULT 0,
    `vat`              INT         NULL DEFAULT 0,
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
    `review_id`        BIGINT       NOT NULL AUTO_INCREMENT,
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
-- Table `accommodation_image`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `accommodation_image`
(
    `accommodation_image_id` BIGINT       NOT NULL AUTO_INCREMENT,
    `url`                VARCHAR(255) NOT NULL,
    `image_seq`          INT NOT NULL,
    `accommodation_id`   BIGINT       NOT NULL,
    PRIMARY KEY (`accommodation_image_id`),
    INDEX `fk_accommodation_image_idx` (`accommodation_id` ASC) VISIBLE,
    CONSTRAINT `fk_accommodation_image_accommodation`
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
    `wish_id`          BIGINT      NOT NULL AUTO_INCREMENT,
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

ALTER TABLE wish ADD UNIQUE (customer_id, accommodation_id);
