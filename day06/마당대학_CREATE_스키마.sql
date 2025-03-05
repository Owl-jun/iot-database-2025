-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema madangUniv
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema madangUniv
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `madangUniv` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `madangUniv` ;

-- -----------------------------------------------------
-- Table `madangUniv`.`Dept`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madangUniv`.`Dept` (
  `dno` INT NOT NULL,
  `dname` VARCHAR(45) NOT NULL,
  `office` VARCHAR(45) NULL,
  PRIMARY KEY (`dno`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `madangUniv`.`Professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madangUniv`.`Professor` (
  `ssn` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `age` INT NULL,
  `rank` VARCHAR(20) NOT NULL,
  `speciality` VARCHAR(40) NULL,
  `Dept_dno` INT NOT NULL,
  PRIMARY KEY (`ssn`),
  INDEX `fk_Professor_Dept_idx` (`Dept_dno` ASC) VISIBLE,
  CONSTRAINT `fk_Professor_Dept`
    FOREIGN KEY (`Dept_dno`)
    REFERENCES `madangUniv`.`Dept` (`dno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `madangUniv`.`Graduate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madangUniv`.`Graduate` (
  `ssn` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `age` INT NULL,
  `deg_prog` VARCHAR(45) NULL,
  `Dept_dno` INT NOT NULL,
  `Graduate_ssn` INT NOT NULL,
  `Graduate_ssn1` INT NOT NULL,
  `Graduate_Graduate_ssn` INT NOT NULL,
  PRIMARY KEY (`ssn`, `Graduate_ssn`),
  INDEX `fk_Graduate_Dept1_idx` (`Dept_dno` ASC) VISIBLE,
  INDEX `fk_Graduate_Graduate1_idx` (`Graduate_ssn1` ASC, `Graduate_Graduate_ssn` ASC) VISIBLE,
  CONSTRAINT `fk_Graduate_Dept1`
    FOREIGN KEY (`Dept_dno`)
    REFERENCES `madangUniv`.`Dept` (`dno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Graduate_Graduate1`
    FOREIGN KEY (`Graduate_ssn1` , `Graduate_Graduate_ssn`)
    REFERENCES `madangUniv`.`Graduate` (`ssn` , `Graduate_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `madangUniv`.`Project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madangUniv`.`Project` (
  `pid` INT NOT NULL,
  `pname` VARCHAR(50) NOT NULL,
  `sponsor` VARCHAR(45) NULL,
  `start_date` DATE NULL,
  `end_date` DATE NULL,
  `budget` INT NULL,
  `Professor_ssn` INT NOT NULL,
  PRIMARY KEY (`pid`),
  INDEX `fk_Project_Professor1_idx` (`Professor_ssn` ASC) VISIBLE,
  CONSTRAINT `fk_Project_Professor1`
    FOREIGN KEY (`Professor_ssn`)
    REFERENCES `madangUniv`.`Professor` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `madangUniv`.`work_dept`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madangUniv`.`work_dept` (
  `Professorssn` INT NOT NULL,
  `dno` INT NOT NULL,
  `pct_time` INT NOT NULL,
  INDEX `fk_work_dept_Professor1_idx` (`Professorssn` ASC) VISIBLE,
  INDEX `fk_work_dept_Dept1_idx` (`dno` ASC) VISIBLE,
  PRIMARY KEY (`Professorssn`, `dno`),
  CONSTRAINT `fk_work_dept_Professor1`
    FOREIGN KEY (`Professorssn`)
    REFERENCES `madangUniv`.`Professor` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_work_dept_Dept1`
    FOREIGN KEY (`dno`)
    REFERENCES `madangUniv`.`Dept` (`dno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `madangUniv`.`work_in`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madangUniv`.`work_in` (
  `ssn` INT NOT NULL,
  `pid` INT NOT NULL,
  PRIMARY KEY (`ssn`, `pid`),
  INDEX `fk_work_in_Project1_idx` (`pid` ASC) VISIBLE,
  CONSTRAINT `fk_work_in_Professor1`
    FOREIGN KEY (`ssn`)
    REFERENCES `madangUniv`.`Professor` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_work_in_Project1`
    FOREIGN KEY (`pid`)
    REFERENCES `madangUniv`.`Project` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `madangUniv`.`work_prog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madangUniv`.`work_prog` (
  `Project_pid` INT NOT NULL,
  `Graduate_ssn` INT NOT NULL,
  PRIMARY KEY (`Project_pid`, `Graduate_ssn`),
  INDEX `fk_work_prog_Graduate1_idx` (`Graduate_ssn` ASC) VISIBLE,
  CONSTRAINT `fk_work_prog_Project1`
    FOREIGN KEY (`Project_pid`)
    REFERENCES `madangUniv`.`Project` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_work_prog_Graduate1`
    FOREIGN KEY (`Graduate_ssn`)
    REFERENCES `madangUniv`.`Graduate` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
