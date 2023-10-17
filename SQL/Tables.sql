SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Table state
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS state (
  state_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NOT NULL,
  abb VARCHAR(2) NOT NULL,
  PRIMARY KEY (state_id),
  UNIQUE INDEX abb_UNIQUE (abb ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table address
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS address (
  address_id INT NOT NULL AUTO_INCREMENT,
  street1 VARCHAR(45) NOT NULL,
  street2 VARCHAR(45) NULL,
  city VARCHAR(45) NOT NULL,
  zip VARCHAR(5) NOT NULL,
  state_id INT NOT NULL,
  PRIMARY KEY (address_id),
  INDEX FK_ADDRESS_STATE_IDX (state_id ASC),
  CONSTRAINT FK_ADDRESS_STATE
    FOREIGN KEY (state_id)
    REFERENCES state (state_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table person
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS person (
  person_id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  sex VARCHAR(1) NOT NULL,
  dob DATETIME,
  address_id INT,
  PRIMARY KEY (person_id),
  INDEX FK_PERSON_ADDRESS_IDX (address_id ASC),
  CONSTRAINT FK_PERSON_ADDRESS
    FOREIGN KEY (address_id)
    REFERENCES address (address_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table branch
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS branch (
  branch_no VARCHAR(5) NOT NULL,
  address_id INT NOT NULL,
  PRIMARY KEY (branch_no),
  INDEX FK_BRANCH_ADDRESS_IDX (address_id ASC)  COMMENT '	',
  UNIQUE INDEX ADDRESS_ID_UNIQUE (address_id ASC),
  CONSTRAINT FK_BRANCH_ADDRESS
    FOREIGN KEY (address_id)
    REFERENCES address (address_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table staff
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS staff (
  staff_no VARCHAR(5) NOT NULL,
  person_id INT NOT NULL,
  position VARCHAR(45) NULL,
  salary INT NULL,
  branch_no VARCHAR(5) NOT NULL,
  PRIMARY KEY (staff_no),
  INDEX FK_STAFF_PERSON_IDX (person_id ASC),
  UNIQUE INDEX PERSON_ID_UNIQUE (person_id ASC),
  INDEX fk_staff_branch1_idx (branch_no ASC),
  CONSTRAINT FK_STAFF_PERSON
    FOREIGN KEY (person_id)
    REFERENCES person (person_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_staff_branch1
    FOREIGN KEY (branch_no)
    REFERENCES branch (branch_no)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table client
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS client (
  client_no VARCHAR(5) NOT NULL,
  person_id INT NOT NULL,
  telephone VARCHAR(13) NULL,
  email VARCHAR(45) NULL,
  pref_type VARCHAR(16) NULL,
  max_rent INT NULL,
  PRIMARY KEY (client_no),
  INDEX FK_CLIENT_PERSON_IDX (person_id ASC),
  CONSTRAINT FK_CLIENT_PERSON
    FOREIGN KEY (person_id)
    REFERENCES person (person_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table property_for_rent
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS property_for_rent (
  property_no VARCHAR(5) NOT NULL,
  address_id INT NOT NULL,
  prop_type VARCHAR(45) NULL,
  rooms VARCHAR(45) NULL,
  rent INT NULL,
  staff_no VARCHAR(5) NULL,
  client_no VARCHAR(5) NULL,
  branch_no VARCHAR(5) NULL,
  PRIMARY KEY (property_no),
  INDEX FK_PROPERTY_FOR_RENT_ADDRESS_IDX (address_id ASC),
  INDEX FK_PROPERTY_FOR_RENT_STAFF_IDX (staff_no ASC),
  INDEX FK_PROPERTY_FOR_RENT_CLIENT_IDX (client_no ASC),
  CONSTRAINT FK_PROPERTY_FOR_RENT_ADDRESS
    FOREIGN KEY (address_id)
    REFERENCES address (address_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT FK_PROPERTY_FOR_RENT_STAFF
    FOREIGN KEY (staff_no)
    REFERENCES staff (staff_no)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT FK_PROPERTY_FOR_RENT_CLIENT
    FOREIGN KEY (client_no)
    REFERENCES client (client_no)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT FK_PROPERTY_FOR_RENT_BRANCH
    FOREIGN KEY (branch_no)
    REFERENCES branch (branch_no)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
