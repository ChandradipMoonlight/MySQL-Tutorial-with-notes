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



