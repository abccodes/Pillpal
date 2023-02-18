DROP DATABASE IF EXISTS PillPal;
CREATE DATABASE IF NOT EXISTS PillPal;
USE PillPal;

-- -----------------------------------------------------
-- PillPal Units Table
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PillPal`.`Units`;
CREATE TABLE IF NOT EXISTS `PillPal`.`Units` (
  `UnitID` INT NOT NULL AUTO_INCREMENT,
  `UnitIP` VARCHAR(45) NOT NULL,
  `UnitOwnerUID` VARCHAR(45) NOT NULL, -- From Firebase Auth
  `UnitNickname` VARCHAR(45) NOT NULL,
  `UnitType` ENUM('PDMMaster', 'PDM120S') NOT NULL,
  `UnitStatus` ENUM('Active', 'AwaitingUpdate', 'Disconnected') NOT NULL,
  `UnitLastUpdate` DATETIME NOT NULL,
  PRIMARY KEY (`UnitID`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- PillPal Sensors Table
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PillPal`.`Sensors`;
CREATE TABLE IF NOT EXISTS `PillPal`.`Sensors` (
  `SensorID` INT NOT NULL AUTO_INCREMENT,
  `SensorNickname` VARCHAR(45) NOT NULL,
  `SensorType` ENUM('Amperage') NOT NULL,
  `SensorStatus` ENUM('Active', 'AwaitingUpdate', 'Disconnected') NOT NULL,
  `SensorLastUpdate` DATETIME NOT NULL,
  `SensorUnitID` INT NOT NULL,
  PRIMARY KEY (`SensorID`),
  INDEX `fk_Sensors_Units1_idx` (`SensorUnitID` ASC),
  CONSTRAINT `fk_Sensors_Units1`
    FOREIGN KEY (`SensorUnitID`)
    REFERENCES `PillPal`.`Units` (`UnitID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- PillPal SensorData Table
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PillPal`.`SensorData`;
CREATE TABLE IF NOT EXISTS `PillPal`.`SensorData` (
  `SensorDataID` INT NOT NULL AUTO_INCREMENT,
  `SensorDataTimestamp` DATETIME NOT NULL,
  `SensorDataValue` INT NOT NULL,
  `SensorDataUnitID` INT NOT NULL,
  PRIMARY KEY (`SensorDataID`),
  INDEX `fk_SensorData_Units1_idx` (`SensorDataUnitID` ASC),
  CONSTRAINT `fk_SensorData_Units1`
    FOREIGN KEY (`SensorDataUnitID`)
    REFERENCES `PillPal`.`Units` (`UnitID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- To add into the table, use the following:
-- INSERT INTO `PillPal`.`Units` (`UnitID`, `UnitIP`, `UnitOwnerUID`, `UnitNickname`, `UnitType`, `UnitStatus`, `UnitLastUpdate`) VALUES (1, '199.116.23.124',
-- '1234567890', 'Unit 1', 'PDM120S', 'Active', '2018-01-01 00:00:00');
