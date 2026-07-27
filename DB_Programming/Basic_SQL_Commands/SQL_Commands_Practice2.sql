
------------------------------SQL Server Joins---------------------------------------------------

--In a relational database, data is distributed in multiple logical tables. 
--To get a complete meaningful set of data, you need to query data from these tables using joins. 
--SQL Server supports many kinds of joins, including inner join, left join, right join, full outer join, and cross join.
--Each join type specifies how SQL Server uses data from one table to select rows in another table.

--First, create a new schema named hr:
CREATE SCHEMA hr;
GO

--Second, create two new tables named candidates and employees in the hr schema:
CREATE TABLE hr.candidates(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);

CREATE TABLE hr.employees(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);

--Third, insert some rows into the candidates and employees tables:
INSERT INTO 
    hr.candidates(fullname)
VALUES
    ('John Doe'),
    ('Lily Singh'),
    ('Peter Parker'),
    ('Jane Doe');


INSERT INTO 
    hr.employees(fullname)
VALUES
    ('John Doe'),
    ('Jane Doe'),
    ('Michael Scott'),
    ('Jack Sparrow');

--Let’s call the candidates table the left table and the employees table the right table.


----------------SQL Server Inner Join(Like a intersection in Math)--------------------
-- Inner join selects matching records from both tables.
--Inner join produces a data set that includes rows from the left table, matching rows from the right table.
SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    INNER JOIN hr.employees e 
        ON e.fullname = c.fullname;

Select * from hr.candidates
Select * from hr.employees


------------------------SQL Server Left Join----------------------------------

--Left join selects data starting from the left table and matching rows in the right table. 
--The left join returns all rows from the left table and the matching rows from the right table. 
--If a row in the left table does not have a matching row in the right table, 
--the columns of the right table will have nulls.

--The left join is also known as the left outer join. The outer keyword is optional.
SELECT  
	c.id candidate_id,
	c.fullname candidate_name,
	e.id employee_id,
	e.fullname employee_name
FROM 
	hr.candidates c
	LEFT JOIN hr.employees e 
		ON e.fullname = c.fullname;

--To get the rows that are available only in the left table but not in the right table, 
--you add a WHERE clause to the above query:
SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    LEFT JOIN hr.employees e 
        ON e.fullname = c.fullname
WHERE 
    e.id IS NULL;

-- Below script act like a inner join
SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    LEFT JOIN hr.employees e 
        ON e.fullname = c.fullname
WHERE 
    e.id IS Not NULL;


--------------------------SQL Server Right Join----------------------------

--The right join or right outer join selects data starting from the right table. It is a reversed version of the left join.

--The right join returns a result set that contains all rows from the right table and the matching rows in the left table. 
--If a row in the right table does not have a matching row in the left table, all columns in the left table will contain nulls.
SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    RIGHT JOIN hr.employees e 
        ON e.fullname = c.fullname;
--Notice that all rows from the right table (employees) are included in the result set.

SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    RIGHT JOIN hr.employees e 
        ON e.fullname = c.fullname
WHERE
    c.id IS NULL;


--------------------------------SQL Server full join----------------------------------------

--The full outer join or full join returns a result set that contains all rows from both left and right tables, 
--with the matching rows from both sides where available. In case there is no match, the missing side will have NULL values.

SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    FULL JOIN hr.employees e 
        ON e.fullname = c.fullname;

--To select rows that exist either left or right table, you exclude rows that are common to both tables 
--by adding a WHERE clause as shown in the following query:
SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    FULL JOIN hr.employees e 
        ON e.fullname = c.fullname
WHERE
    c.id IS NULL OR
    e.id IS NULL;


--------------------------------SQL Server Cross Join--------------------------------

--The CROSS JOIN joined every row from the first table (T1) with every row from the second table (T2). 
--In other words, the cross join returns a Cartesian product of rows from both tables.

--Unlike the INNER JOIN or LEFT JOIN, the cross join does not establish a relationship between the joined tables.

--The CROSS JOIN gets a row from the first table (T1) and then creates a new row for every row in the second table (T2). 
--It then does the same for the next row for in the first table (T1) and so on.

--if the first table has n rows and the second table has m rows, the cross join will result in n x m rows.

CREATE SCHEMA crosses;
GO

--Note that GO command instructs the SQL Server Management Studio to send the SQL statements 
--up to the GO statement to the server to be executed.

CREATE TABLE crosses.employee (
   EmpId INT IDENTITY(1, 1) PRIMARY KEY, 
   Name Varchar(50) not null,
   City Varchar(50)
);

INSERT INTO crosses.employee (Name, City) Values
	('Rahul','Delhi'),
	('Shubham','Varanasi'),
	('Prakhar','Mumbai');

CREATE TABLE crosses.department (
   DeptId INT PRIMARY KEY, 
   DeptName Varchar(50) not null
);

INSERT INTO crosses.department (DeptId, DeptName)
	Values (101, 'IT'),
	(102, 'HR'),
	(103, 'Admin');

SELECT 
	Name, DeptName 
From 
	crosses.employee CROSS JOIN crosses.department;

SELECT 
	Name, DeptName 
From 
	crosses.department CROSS JOIN crosses.employee;

SELECT * FROM crosses.department, crosses.employee;

-------------------------------SQL Server self join-------------------------------------

--A self join allows you to join a table to itself. It helps query hierarchical data or compare rows within the same table.

--A self join uses the inner join or left join clause. Because the query that uses the self join references the same table, 
--the table alias is used to assign different names to the same table within the query.

--1) Using self join to query hierarchical data
CREATE TABLE sales.staffs(
    staff_id INT PRIMARY KEY IDENTITY,
    first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) NOT NULL,
	email VARCHAR(100),
	phone VARCHAR(50),
	active int,
	store_id bigint NOT NULL,
	manager_id bigint
);
--drop table sales.staffs;

INSERT INTO sales.staffs (first_name,last_name,email,phone,active,store_id,manager_id) VALUES
('Shubham', 'Seth', 'shubham@gmail.com','8173070519',1, 1,1),
('Ravi', 'Verma', 'ravi@gmail.com','7873070519',1, 1,1),
('Akhil', 'Chandrahari', 'akhil@gmail.com','9873070519',1, 1,2),
('Sunil', 'Sharma', 'sunil@gmail.com','8173070585',1, 1,2),
('Ajay', 'Aggrawal', 'ajay@gmail.com','8173540552',1, 2,1),
('Praveen', 'Gupta', 'praveen@gmail.com','8173070521',1, 2,5),
('Sonia', 'Gandhi', 'sonia@gmail.com','9973070500',1, 2,5),
('Rahul', 'Gandhi', 'rahul@gmail.com','8573070519',1, 3,1),
('Narendra', 'Modi', 'narendra@gmail.com','7173070519',1, 1,7);

INSERT INTO sales.staffs (first_name,last_name,email,phone,active,store_id) VALUES
('Pratap', 'Singh', 'pratap@gmail.com','8173070519',1, 1),
('Azad', 'Verma', 'azad@gmail.com','7873070519',1, 4);

Update sales.staffs set manager_id=10 where staff_id=1;

select * from sales.staffs;

--To get who reports to whom, you use the self join as shown in the following query:
SELECT
    e.first_name + ' ' + e.last_name employee,
    m.first_name + ' ' + m.last_name manager
FROM
    sales.staffs e INNER JOIN sales.staffs m ON m.staff_id = e.manager_id
ORDER BY
    manager;

select * from sales.staffs;

--In this example, we referenced to the  staffs table twice: one as e for the employees and 
--the other as m for the managers. The join predicate matches employee and manager relationship 
--using the values in the e.manager_id and m.staff_id columns.

SELECT
    e.first_name + ' ' + e.last_name employee,
    m.first_name + ' ' + m.last_name manager
FROM
    sales.staffs e
LEFT JOIN sales.staffs m ON m.staff_id = e.manager_id
ORDER BY
    manager;

--2) Using self join to compare rows within a table
SELECT
    e1.City,
    e1.FirstName + ' ' + e1.LastName employee_1,
    e2.FirstName + ' ' + e2.LastName employee_2
FROM
    employee_info e1
	INNER JOIN employee_info e2 ON e1.EmployeeID > e2.EmployeeID
	AND e1.City = e2.City
ORDER BY
    City,
    employee_1,
    employee_2;

SELECT * FROM employee_info;

---------------------------------------------------------------
--Note that if you change the greater than ( > ) operator by the not equal to (<>) operator, you will get more rows:
SELECT
    e1.City,
    e1.FirstName + ' ' + e1.LastName employee_1,
    e2.FirstName + ' ' + e2.LastName employee_2
FROM
    employee_info e1
INNER JOIN employee_info e2 ON e1.EmployeeID <> e2.EmployeeID
AND e1.City = e2.City
ORDER BY
    City,
    employee_1,
    employee_2;

SELECT * FROM employee_info;

SELECT
    e1.City,
    e1.FirstName + ' ' + e1.LastName employee_1,
    e2.FirstName + ' ' + e2.LastName employee_2
FROM
    employee_info e1
INNER JOIN employee_info e2 ON e1.EmployeeID > e2.EmployeeID
AND e1.City = e2.City
WHERE e1.City = 'Varanasi'
ORDER BY
    City,
    employee_1,
    employee_2;