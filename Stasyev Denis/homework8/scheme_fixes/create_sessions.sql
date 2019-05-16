USE `technotrack_formula_1`;

CREATE TABLE `technotrack_formula_1`.`sessions` (
  `session_id` INT NOT NULL AUTO_INCREMENT,
  `client_id` INT NOT NULL,
  `started_at` DATETIME NOT NULL,
  `ended_at` DATETIME NOT NULL,
  PRIMARY KEY (`session_id`),
  INDEX `fk_sessions_1_idx` (`client_id` ASC) VISIBLE,
  CONSTRAINT `fk_sessions_1`
    FOREIGN KEY (`client_id`)
    REFERENCES `technotrack_formula_1`.`clients` (`client_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
