-- ! create database 
CREATE DATABASE IF NOT EXISTS college;

-- ! delete database
DROP DATABASE IF EXISTS college;

-- ! show database
SHOW DATABASES;

-- ! use database
USE college;

-- ! show tables
SHOW TABLES;

-- ! create table
CREATE TABLE Student(
    rollNo INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE `fintrip_credit_cards` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint NOT NULL DEFAULT '0',
  `attrs` text,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `employee_id` bigint NOT NULL DEFAULT '0',
  `card_number` varchar(20) NOT NULL,
  `card_reference` varchar(50) NOT NULL,
  `card_type` varchar(70) NOT NULL,
  `issue_date` datetime(6) NOT NULL,
  `cycle_period` bigint DEFAULT NULL,
  `statement_date` datetime(6) DEFAULT NULL,
  `due_date` datetime(6) DEFAULT NULL,
  `card_status` varchar(20) NOT NULL,
  `initial_limit` double(15,2) DEFAULT '0.00',
  `actual_limit` double(15,2) DEFAULT '0.00',
  `available_limit` double(15,2) DEFAULT '0.00',
  `data` text,
  PRIMARY KEY (`id`,`company_id`),
  KEY `Search1` (`company_id`,`card_number`,`card_reference`),
  KEY `Search2` (`company_id`,`issue_date`,`employee_id`)
)

CREATE TABLE fintrip.fintrip_credit_cards_types (
  id bigint NOT NULL AUTO_INCREMENT,
  company_id bigint DEFAULT NULL,
  title varchar(255) DEFAULT NULL,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  deleted tinyint(1) NOT NULL DEFAULT 0,
  attrs text,
  PRIMARY KEY (id)
);

CREATE TABLE fintrip.fintrip_credit_cards (
  id bigint NOT NULL AUTO_INCREMENT,
  company_id bigint DEFAULT NULL,
  title varchar(255) DEFAULT NULL,
  created_at datetime(6) NOT NULL,
  updated_at datetime(6) NOT NULL,
  deleted tinyint(1) NOT NULL DEFAULT 0,
  attrs text,
  PRIMARY KEY (id)
);

-- ! select and view all columns
 SELECT * FROM Student;

 -- ! insert values into the tables
-- INSET INTO tableName
-- (colName1, colName2)
-- VALUES
-- (col1_V1, col2_v1),
-- (col1_v2, col2_v2);

INSERT INTO Student 
(rollNo, name)
VALUES
(101, "chandradip"),
(102, "Dipak");

-- ! create database xyz_company
CREATE DATABASE xyz_company;

-- ! create table Employee inside xyz_company
CREATE TABLE Employee(
    employeeId INT PRIMARY KEY,
    employeeName VARCHAR(255),
    employeeSalary INT UNSIGNED
);

-- ! insert following data into the Employee table

    -- ? 1, "adam", 25000
    -- ? 2, "bob", 30000
    -- ? 3, "casey", 40000

INSERT INTO Employee
    (employeeId, employeeName, employeeSalary)
    VALUES
    (4, "adam", 25000),
    (5, "bob", 30000),
    (6, "casey", 40000);

-- ! Select and view all your table data
SELECT * FROM Employee;

-- keys
-- -----------
-- PRIMARY KEY
--     it is column or set of columns in table that uniquely identifies each row.
--     There is only one PK.
--     it should not be null.

-- FOREIGN KEY
--     A foreign key is a column or set of column in table that refers to the primary key in another table uniquely
--     There can be multiple FKs.
--     FKs can have duplicate & null values.

-- ? constraints

CREATE TABLE a1(
    a1Id INT,
    name VARCHAR(80),
    PRIMARY KEY (a1Id)
);

ALTER TABLE a1 DROP COLUMN name;
ALTER TABLE a1 ADD COLUMN a1Name VARCHAR(255);

CREATE TABLE b1(
    b1id INT PRIMARY KEY,
    b1Name VARCHAR(89),
    a1Id INT,
    FOREIGN KEY (a1Id) REFERENCES a1(a1Id)
);

CREATE DATABASE college;

USE college;

CREATE TABLE Student(
    rollNo INT PRIMARY KEY,
    name VARCHAR(100),
    marks INT NOT NULL,
    grade VARCHAR(1),
    city VARCHAR(20)
);

INSERT INTO Student
(rollNo, name, marks, grade, city)
VALUES
(101, "anil", 78, "C", "Pune"),
(102, "Bhumika", 93, "A", "Mumbai"),
(103, "Chetan", 85, "B", "Mumbai"),
(104, "Krishan", 79, "A", "Banglor"),
(105, "Arajun", 76, "F", "Delhi"),
(106, "Vasudev", 89, "E", "Mathura");

CREATE TABLE IF NOT EXISTS Teacher(
    teacherId INT PRIMARY KEY,
    teacherName VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Department(
    departmentId INT PRIMARY KEY,
    departmentName VARCHAR(100),
    teacherId INT,
    FOREIGN KEY (teacherId) REFERENCES Teacher(teacherId)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

INSERT INTO Teacher
(teacherId, teacherName)
VALUES
(101, "Arjun"),
(102, "Krishana");

INSERT INTO Department
(departmentId, departmentName, teacherId)
VALUES
(201, "IT", 101),
(202, "ENGLISH", 102);

UPDATE Teacher
SET teacherId = 103 -- ?  this teacherId will change in both the table because of cascade
WHERE teacherId = 101;

-- ! TABLE related queries 
--  ALTER  to change the schema

-- ! ADD column
--  ALTER TABLE tableName
--  ADD COLUMN columnName dataType

ALTER TABLE fintrip.fintrip_credit_cards
ADD COLUMN card_currency VARCHAR(150);

ALTER TABLE fintrip.fintrip_credit_cards
ADD COLUMN 'type' bigint DEFAULT '0',

-- ! DROP Column
-- ALTER TABLE tableName
-- DROP COLUMN columnName

-- ! RENAME Table
-- ALTER TABLE tableName
-- RENAME TO new_table_name

-- ! MODIFY COLUMN
-- ALTER TABLE tableName
-- MODIFY COLUMN columnName new_dataType new_constraint

-- ! CHANGE COLUMN
-- ALTER TABLE tableName
-- CHANGE COLUMN old_columnName new_columnName new_dataType new_constraint;

-- ! TRUNCATE
-- ? delete all the data from the table
-- TRUNCATE TABLE tableName;


-- crate table schema for one to one mapping of customer and address

CREATE TABLE customer (
	id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	age INT,
	created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted BOOLEAN
);

CREATE TABLE address (
    id INT AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(255),
    state VARCHAR(255),
    pin_code INT,
    customer_id INT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted BOOLEAN,
    FOREIGN KEY (customer_id) REFERENCES customer(id)
);

CREATE TABLE fintrip_holidays (
    id bigint NOT NULL AUTO_INCREMENT,
    company_id bigint NOT NULL DEFAULT '0',
    title varchar(255) NOT NULL,
    date varchar(50) NOT NULL,
    created_at datetime(6) NOT NULL,
    updated_at datetime(6) NOT NULL,
    deleted tinyint(1) NOT NULL DEFAULT '0',
    attrs text,
    PRIMARY KEY (id, company_id)
);

CREATE TABLE `fintrip_employee_attendance` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `company_id` bigint NOT NULL DEFAULT '0',
  `attrs` text,
  `employee_id` bigint NOT NULL,
  `date` varchar(50) NOT NULL,
  `check_in` datetime(6) DEFAULT NULL,
  `check_out` datetime(6) DEFAULT NULL,
  `available` tinyint(1) DEFAULT NULL,
  `status` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`,`company_id`)
);


CREATE TABLE `vc_vendor_invoices` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `amount` double(16,3) NOT NULL,
  `service` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `vendor_id` bigint DEFAULT '0',
  `token_secret` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `attrs` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `owner_type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `owner_id` bigint NOT NULL DEFAULT '0',
  `stage` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `company_id` bigint NOT NULL DEFAULT '0',
  `status` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'PENDING',
  `tax_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `type` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `office_id` bigint DEFAULT '0',
  `owner` text CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  `transaction_id` bigint DEFAULT NULL,
  `invoice_id` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `views` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `tag` varchar(245) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `duplicates` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `fraud` tinyint(1) DEFAULT '0',
  `due_date` datetime(6) DEFAULT NULL,
  `category_id` bigint DEFAULT '0',
  `config` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `filter_tag` varchar(245) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `payment_ticket_id` bigint DEFAULT NULL,
  `po_id` bigint DEFAULT '0',
  `delivery_address_id` bigint DEFAULT '0',
  `vendor_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'default',
  `scanner_id` bigint DEFAULT '0',
  `recon_status` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'SKIPPED',
  `currency` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'INR',
  `currency_amount` double(16,3) DEFAULT NULL,
  `super_category_id` bigint DEFAULT '0',
  `grn` tinyint(1) DEFAULT '0',
  `project_id` bigint DEFAULT '0',
  `contract_id` bigint DEFAULT NULL,
  `asn_id` bigint DEFAULT NULL,
  `violations` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `bill_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `approved_at` datetime(6) DEFAULT NULL,
  `finance_approved_at` datetime(6) DEFAULT NULL,
  `settled_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`,`company_id`),
  KEY `Search` (`company_id`,`status`,`office_id`),
  KEY `Search3` (`company_id`,`owner_type`,`owner_id`,`status`),
  KEY `Search2` (`company_id`,`type`,`status`,`office_id`),
  KEY `Search4` (`company_id`,`tag`),
  KEY `Search5` (`company_id`,`office_id`,`filter_tag`,`status`),
  KEY `Search6` (`company_id`,`date`,`office_id`),
  KEY `Search7` (`company_id`,`created_at`,`office_id`),
  KEY `Search8` (`company_id`,`updated_at`),
  KEY `Search9` (`company_id`,`created_at`),
  KEY `index10` (`company_id`,`invoice_id`),
  KEY `index11` (`company_id`,`po_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1116592 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin
/*!50100 PARTITION BY HASH (`company_id`)
PARTITIONS 40 */

ALTER TABLE fintrip.vc_vendor_invoices
ADD COLUMN integration_failed tinyint(1);


ALTER TABLE fintrip.vc_purchase_order
ADD COLUMN integration_failed tinyint(1);






