DROP SCHEMA IF EXISTS `fooddb`;
CREATE SCHEMA IF NOT EXISTS `fooddb` DEFAULT CHARACTER SET latin1;
USE `fooddb`;

-- -----------------------------------------------------
-- Table `fooddb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fooddb`.`user` (
  `email` VARCHAR(40) NOT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT '1',
  `first_name` VARCHAR(20) NOT NULL,
  `last_name` VARCHAR(20) NOT NULL,
  `password` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`email`)
);

-- -----------------------------------------------------
-- Table `fooddb`.`food_name`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fooddb`.`food_name` (
  `food_id` INT(8) NOT NULL,
  `food_code` INT(8) NOT NULL,
  `food_group_id` BIGINT(15) NOT NULL,
  `food_source_id` BIGINT(15) NOT NULL,
  `food_description` VARCHAR(255) NOT NULL,
  `food_description_f` VARCHAR(255) NOT NULL,
  `country_code` VARCHAR(20) NOT NULL,
  `food_date_of_entry` VARCHAR(10) NOT NULL,
  `food_date_of_publication` VARCHAR(10) NOT NULL,
  `scientific_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`food_id`)
);

-- -----------------------------------------------------
-- Table `fooddb`.`nutrient_name`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fooddb`.`nutrient_name` (
  `nutrient_id` INT(4) NOT NULL,
  `nutrient_code` INT(15) NOT NULL,
  `nutrient_symbol` VARCHAR(10) NOT NULL,
  `unit` VARCHAR(8) NOT NULL,
  `nutrient_name` VARCHAR(200) NOT NULL,
  `nutrient_name_f` VARCHAR(200) NOT NULL,
  `tagname` VARCHAR(20) NOT NULL,
  `nutrient_decimals` INT(15) NOT NULL,
  PRIMARY KEY (`nutrient_id`)
);

-- -----------------------------------------------------
-- Table `fooddb`.`nutrient_amount`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fooddb`.`nutrient_amount` (
  `food_id` INT(8) NOT NULL,
  `nutrient_id` INT(4) NOT NULL,
  `nutrient_value` DOUBLE(12, 5) NOT NULL,
  `standard_error` VARCHAR(8) NOT NULL,
  `number_of_observations` VARCHAR(6) NOT NULL,
  `nutrient_source_id` BIGINT(15) NOT NULL,
  `nutrient_date_of_entry` DATE NOT NULL,
  FOREIGN KEY (`food_id`) REFERENCES `fooddb`.`food_name`(`food_id`)
  -- FOREIGN KEY (`nutrient_id`) REFERENCES `fooddb`.`nutrient_name`(`nutrient_id`)
);

-- -----------------------------------------------------
-- Table `fooddb`.`user_food`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fooddb`.`user_food` (
  `email` VARCHAR(40) NOT NULL,
  `food_id` INT(8) NOT NULL,
  FOREIGN KEY (`email`) REFERENCES `fooddb`.`user`(`email`),
  FOREIGN KEY (`food_id`) REFERENCES `fooddb`.`food_name`(`food_id`)
);

INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`)
	VALUES ('a@gmail.com', true, 'Debora', 'Kwon', 'password');
INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`)
	VALUES ('b@gmail.com', true, 'Fernando', 'Valera', 'password');
INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`)
	VALUES ('c@gmail.com', true, 'Bong', 'Bong', 'password');

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/FOOD NAME.csv'
    INTO TABLE food_name
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES
    (food_id, food_code, food_group_id, food_source_id, food_description,
        food_description_f, food_date_of_entry, food_date_of_publication,
        country_code, scientific_name);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/NUTRIENT NAME.csv'
    INTO TABLE nutrient_name
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES
    (nutrient_id, nutrient_code, nutrient_symbol, unit, nutrient_name,
        nutrient_name_f, tagname, nutrient_decimals);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/NUTRIENT AMOUNT.csv'
    INTO TABLE nutrient_amount
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES
    (food_id, nutrient_id, nutrient_value, standard_error,
        number_of_observations, nutrient_source_id, nutrient_date_of_entry);
