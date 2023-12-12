-- ! LIMIT

SELECT * FROM Student LIMIT 3;

-- ! ORDER BY  => to sort in ascending(ASC) or descending(DESC) order
SELECT * FROM Student ORDER BY marks DESC;
SELECT * FROM Student ORDER BY marks DESC LIMIT 3;

-- ! Aggregate Functions

SELECT MAX(marks) FROM Student;  -- will return max value of marks column
SELECT MIN(marks) FROM Student; -- min value of column
SELECT AVG(marks) FROM Student; -- avg marks 
SELECT COUNT(marks) FROM Student; -- total records preset in marks column
SELECT SUM(marks) FROM Student; -- sum of all marks

-- ! SQL LIKE Operator
SELECT * FROM Student WHERE name LIKE "a%"; -- The percent sign % represents zero, one, or multiple characters
SELECT * FROM Student WHERE name LIKE "_r%"; --  The underscore sign _ represents one, single character

-- ! GROUP BY => 
-- ? The GROUP BY statement groups rows that have the same values into summary rows, like "find the number of customers in each country".
-- ? The GROUP BY statement is often used with aggregate functions (COUNT(), MAX(), MIN(), SUM(), AVG()) to group the result-set by one or more columns
SELECT city FROM Student GROUP BY city;
SELECT COUNT(marks), city FROM Student GROUP BY city;
SELECT city, COUNT(city), AVG(marks) FROM Student GROUP BY city;
SELECT city, name, COUNT(city) FROM Student GROUP BY city, name;

-- ! write query to find the avg marks in each city in ascending order
SELECT city, AVG(marks)
FROM Student
GROUP BY city
ORDER BY city;

SELECT name, AVG(marks)
FROM Student
GROUP BY name
ORDER BY AVG(marks) DESC;

-- ! update records
UPDATE Student
SET grade = "O"
WHERE grade = "A";

-- ! joins 
--  INNER JOIN , LEFT JOIN, RIGHT JOIN, FULL OUTER JOIN JOIN
--  ! INNER JOIN
-- will return exact matching records form the both table
SELECT Teacher.teacherId, teacherName, departmentId, departmentName
FROM Teacher
INNER JOIN Department
ON Teacher.teacherId = Department.teacherId;
-- using alias for table name
SELECT t.teacherId, t.teacherName, d.departmentId, d.departmentName
FROM Teacher as t
INNER JOIN Department as d
ON t.teacherId = d.teacherId;

-- ! LEFT JOIN
-- LEFT JOIN returns all records form the left table and matched records form the right table

SELECT t.teacherId, teacherName, departmentId, departmentName
FROM Teacher as t
LEFT JOIN Department as d
ON t.teacherId = d.teacherId;

-- ! RIGHT JOIN
-- Return all records form the right table, and matched records form the left join
SELECT t.teacherId, teacherName, departmentId, departmentName
FROM Teacher as t
RIGHT JOIN Department as d
ON t.teacherId = d.teacherId;

-- ! FULL JOIN / FULL OUTER JOIN
-- Return all records when there is match in either left or right table
-- MySQL does not support for full outer join but we can achieve it by using UNION of LEFT JOIN and RIGHT JOIN
SELECT t.teacherId, teacherName, departmentId, departmentName
FROM Teacher as t
LEFT JOIN Department as d
ON t.teacherId = d.teacherId
UNION
SELECT t.teacherId, teacherName, departmentId, departmentName
FROM Teacher as t
RIGHT JOIN Department as d
ON t.teacherId = d.teacherId;

-- ! Left exclusive join 
-- Return only those records from left table which does not match with right table
SELECT * FROM Teacher
LEFT JOIN Department
ON Teacher.teacherId = Department.teacherId
WHERE Department.departmentId IS NULL;

-- ! Right exclusive join
-- return only those records from the right table which does not match with the left table

SELECT * FROM Teacher as t
RIGHT JOIN Department as d
ON t.teacherId = d.teacherId
WHERE t.teacherId IS NULL;

-- ! Full exclusive join
-- Return non matched records form both the tables.

SELECT t.teacherId, teacherName, d.departmentId, departmentName
FROM Teacher as t
LEFT JOIN Department as d
ON t.teacherId = d.teacherId
WHERE d.teacherId IS NULL
UNION
SELECT t.teacherId, teacherName, d.departmentId, departmentName
FROM Teacher as t
RIGHT JOIN Department as d
ON t.teacherId = d.teacherId
WHERE t.teacherId IS NULL;

-- ! SQL sub queries
-- a SubQuery or Inner Query or a Nested Query is query within another query.
-- it involves two select statements.
-- ~ Q1) get Names of all students who scored more than class avg
-- ~ step 1. Find the avg of class
-- ~ Find the names of students with marks > avg

SELECT s.name, s.marks
FROM Student as s
WHERE s.marks > (SELECT AVG(marks) FROM Student);

-- ~ Q2) find the name of student who has 3rd highest marks
-- ? imp notes => in subQuery every derived table must have its own alias.
SELECT s.name, s.marks
FROM (
    SELECT name, marks
    FROM Student
    ORDER BY marks DESC
    LIMIT 3
) AS s
ORDER BY marks ASC
LIMIT 1;

-- ~ Q3) find the name of all students with even roll numbers
SELECT rollNo, name
FROM Student
WHERE (rollNo % 2) = 0;

-- ~ Q4) find the name of students who has marks in given list
SELECT name 
FROM Student
WHERE rollNo IN (102, 104, 106);

-- OR
SELECT name, rollNo
FROM Student
WHERE rollNo IN (
    SELECT rollNo
    FROM Student
    WHERE (rollNo %2) = 0
);

-- ~ Q4) find the max marks from student of given city

SELECT MAX(marks) AS max_marks
FROM Student
WHERE city = "Mumbai";

-- ! MySQL Views
-- ? A view is a virtual table based on the result-set of an SQL statement
-- ? A view always shows up-to-date data. The database engine recreates the view,
-- ? every time a user queries it.

CREATE VIEW teacherView as 
SELECT rollNo, name, marks FROM Student;

SELECT * FROM teacherView;

SELECT * FROM teacherView
WHERE marks>90;

-- ! DROP VIEW
DROP VIEW teacherView;

