-- MySQL Script generated by MySQL Workbench
-- Sun May 26 11:58:44 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Study`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Study` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Study` (
  `idStudy` INT NOT NULL,
  PRIMARY KEY (`idStudy`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Experiment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Experiment` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Experiment` (
  `idExperiment` INT NOT NULL,
  `Study_idStudy` INT NOT NULL,
  PRIMARY KEY (`idExperiment`),
  INDEX `fk_Experiment_Study1_idx` (`Study_idStudy` ASC) VISIBLE,
  CONSTRAINT `fk_Experiment_Study1`
    FOREIGN KEY (`Study_idStudy`)
    REFERENCES `mydb`.`Study` (`idStudy`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Feature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Feature` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Feature` (
  `idFeature` INT NOT NULL,
  `featureName` VARCHAR(45) NULL,
  PRIMARY KEY (`idFeature`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Data`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Data` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Data` (
  `idData` INT NOT NULL,
  `startTimestamp` TIMESTAMP(50) NULL,
  `endTimestamp` TIMESTAMP(50) NULL,
  `targetFeature_idFeature` INT NOT NULL,
  PRIMARY KEY (`idData`),
  INDEX `fk_Data_Feature1_idx` (`targetFeature_idFeature` ASC) VISIBLE,
  CONSTRAINT `fk_Data_Feature1`
    FOREIGN KEY (`targetFeature_idFeature`)
    REFERENCES `mydb`.`Feature` (`idFeature`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TaskType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`TaskType` ;

CREATE TABLE IF NOT EXISTS `mydb`.`TaskType` (
  `idTaskType` INT NOT NULL,
  `taskType` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTaskType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Task`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Task` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Task` (
  `idTask` INT NOT NULL,
  `Data_idData` INT NOT NULL,
  `TaskType_idTaskType` INT NOT NULL,
  PRIMARY KEY (`idTask`),
  INDEX `fk_Task_Data1_idx` (`Data_idData` ASC) VISIBLE,
  INDEX `fk_Task_TaskType1_idx` (`TaskType_idTaskType` ASC) VISIBLE,
  CONSTRAINT `fk_Task_Data1`
    FOREIGN KEY (`Data_idData`)
    REFERENCES `mydb`.`Data` (`idData`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Task_TaskType1`
    FOREIGN KEY (`TaskType_idTaskType`)
    REFERENCES `mydb`.`TaskType` (`idTaskType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Flow`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Flow` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Flow` (
  `idFlow` INT NOT NULL,
  PRIMARY KEY (`idFlow`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Run`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Run` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Run` (
  `idRun` INT NOT NULL,
  `timestamp` DATETIME NULL,
  `Experiment_idExperiment` INT NOT NULL,
  `Task_idTask` INT NOT NULL,
  `Flow_idFlow` INT NOT NULL,
  PRIMARY KEY (`idRun`, `Flow_idFlow`),
  INDEX `fk_Run_Experiment_idx` (`Experiment_idExperiment` ASC) VISIBLE,
  INDEX `fk_Run_Task1_idx` (`Task_idTask` ASC) VISIBLE,
  INDEX `fk_Run_Flow1_idx` (`Flow_idFlow` ASC) VISIBLE,
  CONSTRAINT `fk_Run_Experiment`
    FOREIGN KEY (`Experiment_idExperiment`)
    REFERENCES `mydb`.`Experiment` (`idExperiment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Run_Task1`
    FOREIGN KEY (`Task_idTask`)
    REFERENCES `mydb`.`Task` (`idTask`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Run_Flow1`
    FOREIGN KEY (`Flow_idFlow`)
    REFERENCES `mydb`.`Flow` (`idFlow`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EvaluationMeasure`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`EvaluationMeasure` ;

CREATE TABLE IF NOT EXISTS `mydb`.`EvaluationMeasure` (
  `idEvaluationMeasure` INT NOT NULL,
  PRIMARY KEY (`idEvaluationMeasure`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ModelEvaluation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ModelEvaluation` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ModelEvaluation` (
  `idModelEvaluation` INT NOT NULL,
  `hasValue` BINARY(2) NULL,
  `Run_idRun` INT NOT NULL,
  `EvaluationMeasure_idEvaluationMeasure` INT NOT NULL,
  PRIMARY KEY (`idModelEvaluation`),
  INDEX `fk_ModelEvaluation_Run1_idx` (`Run_idRun` ASC) VISIBLE,
  INDEX `fk_ModelEvaluation_EvaluationMeasure1_idx` (`EvaluationMeasure_idEvaluationMeasure` ASC) VISIBLE,
  CONSTRAINT `fk_ModelEvaluation_Run1`
    FOREIGN KEY (`Run_idRun`)
    REFERENCES `mydb`.`Run` (`idRun`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ModelEvaluation_EvaluationMeasure1`
    FOREIGN KEY (`EvaluationMeasure_idEvaluationMeasure`)
    REFERENCES `mydb`.`EvaluationMeasure` (`idEvaluationMeasure`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Dataset`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Dataset` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Dataset` (
  `idDataset` INT NOT NULL,
  `Feature_idFeature` INT NOT NULL,
  `Data_idData` INT NOT NULL,
  PRIMARY KEY (`idDataset`),
  INDEX `fk_Dataset_Feature1_idx` (`Feature_idFeature` ASC) VISIBLE,
  INDEX `fk_Dataset_Data1_idx` (`Data_idData` ASC) VISIBLE,
  CONSTRAINT `fk_Dataset_Feature1`
    FOREIGN KEY (`Feature_idFeature`)
    REFERENCES `mydb`.`Feature` (`idFeature`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Dataset_Data1`
    FOREIGN KEY (`Data_idData`)
    REFERENCES `mydb`.`Data` (`idData`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EvaluationProcedure`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`EvaluationProcedure` ;

CREATE TABLE IF NOT EXISTS `mydb`.`EvaluationProcedure` (
  `idEvaluationProcedure` INT NOT NULL,
  PRIMARY KEY (`idEvaluationProcedure`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EvaluationSpecification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`EvaluationSpecification` ;

CREATE TABLE IF NOT EXISTS `mydb`.`EvaluationSpecification` (
  `idEvaluationSpecification` INT NOT NULL,
  `EvaluationProcedure_idEvaluationProcedure` INT NOT NULL,
  `Task_idTask` INT NOT NULL,
  `EvaluationMeasure_idEvaluationMeasure` INT NOT NULL,
  PRIMARY KEY (`idEvaluationSpecification`),
  INDEX `fk_EvaluationSpecification_EvaluationProcedure1_idx` (`EvaluationProcedure_idEvaluationProcedure` ASC) VISIBLE,
  INDEX `fk_EvaluationSpecification_Task1_idx` (`Task_idTask` ASC) VISIBLE,
  INDEX `fk_EvaluationSpecification_EvaluationMeasure1_idx` (`EvaluationMeasure_idEvaluationMeasure` ASC) VISIBLE,
  CONSTRAINT `fk_EvaluationSpecification_EvaluationProcedure1`
    FOREIGN KEY (`EvaluationProcedure_idEvaluationProcedure`)
    REFERENCES `mydb`.`EvaluationProcedure` (`idEvaluationProcedure`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EvaluationSpecification_Task1`
    FOREIGN KEY (`Task_idTask`)
    REFERENCES `mydb`.`Task` (`idTask`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EvaluationSpecification_EvaluationMeasure1`
    FOREIGN KEY (`EvaluationMeasure_idEvaluationMeasure`)
    REFERENCES `mydb`.`EvaluationMeasure` (`idEvaluationMeasure`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Parameter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Parameter` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Parameter` (
  `idParameter` INT NOT NULL,
  `Flow_idFlow` INT NOT NULL,
  `valueParameter` VARCHAR(45) NULL,
  PRIMARY KEY (`idParameter`),
  INDEX `fk_Parameter_Flow1_idx` (`Flow_idFlow` ASC) VISIBLE,
  CONSTRAINT `fk_Parameter_Flow1`
    FOREIGN KEY (`Flow_idFlow`)
    REFERENCES `mydb`.`Flow` (`idFlow`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
