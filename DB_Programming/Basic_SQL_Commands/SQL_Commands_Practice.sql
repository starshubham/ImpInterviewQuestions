-----Welcome to DB Programming-----

-- Creating a database DB_Programming
create database DB_Programming;

exec sp_databases;   --Show all existing databases in shorts


-----------------------------------------------


---Ability to create a employee info table in the DB_Programming database
CREATE TABLE employee_info 
(
   EmployeeID int identity primary key,
   FirstName varchar(255) Not null,
   LastName varchar(255) Not null,
   Address varchar(255),
   City varchar(255),
   PhoneNumber varchar(50),
   Salary money default 1000,
   StartDate DateTime default GetDate()
);

select * from employee_info;

--drop table employee_info;  --- used to drop a table

-----------------------------------------------------


exec sp_help employee_info;   --- used to show datas of table in details

----- Insert values into database---------

INSERT INTO employee_info (FirstName,LastName,Address,City,PhoneNumber,Salary,StartDate) VALUES
('Shubham', 'Seth', 'Kopa Patrahi Jaunpur', 'Jaunpur', '8173070519', 400000.00, '2020-01-03'),
('Ravi', 'Seth', 'Kopa Patrahi Jaunpur', 'Jaunpur', '7860650519', 400000.00, '2020-01-03'),
('Ajay', 'Seth', 'Kopa Patrahi Jaunpur', 'Jaunpur', '9598650519', 500000.00, '2020-01-03'),
('Shani', 'Seth', 'Kopa Patrahi Jaunpur', 'Jaunpur', '7898650519', 500000.00, '2020-01-03'),
('Pawan', 'Verma', 'DLW', 'Varanasi', '9598650519', 400000.00, GETDATE()),
('Suraj', 'Verma', 'Balrampur', 'Jaunpur', '8798650519', 400000.00, GETDATE()),
('Ashok', 'Singh', 'Durgakund', 'Varanasi', '8798650519', 400000.00, '2020-01-03'),
('Akash', 'Patel', 'Lanka', 'Varanasi', '8898650519', 400000.00, GETDATE()),
('Praveen', 'Patil', 'Azamgarh', 'Azamgarh', '7898650525', 400000.00, GETDATE()),
('Anjali', 'Singh', 'Durgakund', 'Varanasi', '8798650519', 400000.00, GETDATE());


---------------------------------------------------------------------

---------Practice on select command------------

--retrieve all the employee_info data 
select * from employee_info;          --Retrieving Records from Table

select salary from employee_info where FirstName = 'Shubham'; 
select salary from employee_info where FirstName = 'Shani'; 
select * from employee_info
where startDate BETWEEN CAST('2021-01-01' as DATE) AND GETDATE();


--Use Alter Table Command to add Field gender 
Alter Table employee_info add Gender varchar(1);
Alter Table employee_info add State varchar(255);
select *  from employee_info      --Retrieving Records from Table

SELECT TOP 5 * FROM [INFORMATION_SCHEMA].[COLUMNS] WHERE TABLE_NAME='employee_info'; --- show table information


------------Update Command----------------

-- Use Update Query to set the gender using where condition with the employee name.
UPDATE employee_info set Gender = 'M' where FirstName = 'Shubham';   --updating Gender of employees
UPDATE employee_info set Gender = 'M' where LastName = 'Seth' or FirstName = 'Suraj' or FirstName = 'Pawan' or FirstName = 'Ashok';
UPDATE employee_info set Gender = 'F' where FirstName = 'Anjali';   --updating Gender of employees

UPDATE employee_info set salary = 300000.00 where FirstName = 'Praveen'
UPDATE employee_info set salary = 500000.00 where FirstName = 'Anjali'
UPDATE employee_info set salary = 450000.00 where FirstName = 'Pawan'   --updating salary of employees
select *  from employee_info      --Retrieving Records from Table

UPDATE employee_info set FirstName = 'Radha', City = 'Varanasi', Gender= 'F' Where EmployeeID = 7
UPDATE employee_info set FirstName = 'Krishna', Address='Cantt Station Varanasi', City = 'Varanasi', Gender= 'M' Where EmployeeID = 9

UPDATE employee_info set State = 'UP' Where City = 'Varanasi'
UPDATE employee_info set State = 'MP' Where City = 'Jaunpur'


----------------Delete Commmand---------------------

Delete from employee_info where FirstName='Akash';    --- Delete a particular row
Delete from employee_info where EmployeeID=10;        --- Delete a particular row
select *  from employee_info                          --- Retrieving Records from Table

---------------Group By, Having, Order By  Clause--------------

SELECT * FROM employee_info;
SELECT * FROM employee_info WHERE City='Varanasi';
SELECT City, COUNT (*) FROM employee_info WHERE State = 'UP' Group By City Order By City;
SELECT City, COUNT (*) FROM employee_info WHERE State = 'MP' Group By City Order By City;
SELECT City, COUNT (*) FROM employee_info WHERE State = 'UP' Group By City HAVING COUNT (*) > 2 Order By City;

---------------Order By Clause in Details--------------

--When you use the SELECT statement to query data from a table, the order of rows in the result set is not guaranteed. 
--It means that SQL Server can return a result set with an unspecified order of rows. 
--The only way for you to guarantee that the rows in the result set are sorted is to use the ORDER BY clause

--The ASC sorts the result from the lowest value to the highest value while the DESC sorts the result set from the highest value to the lowest one.
--If you don’t explicitly specify ASC or DESC, SQL Server uses ASC as the default sort order. Also, SQL Server treats NULL as the lowest value.
--When processing the SELECT statement that has an ORDER BY clause, the ORDER BY clause is the very last clause to be processed.

--A) Sort a result set by one column in ascending order
SELECT
    FirstName,
    LastName
FROM
    employee_info
ORDER BY
    FirstName;

--B) Sort a result set by one column in descending order
SELECT
    FirstName,
    LastName
FROM
    employee_info
ORDER BY
    FirstName DESC;

--C) Sort a result set by multiple columns
SELECT
    FirstName,
    LastName,
	City
FROM
    employee_info
ORDER BY
	City,
    FirstName;

--D) Sort a result set by multiple columns and different orders
SELECT
    FirstName,
    LastName,
	City
FROM
    employee_info
ORDER BY
	City DESC,
    FirstName ASC;

--E) Sort a result set by a column that is not in the select list
--It is possible to sort the result set by a column that does not appear on the select list. 
--For example, the following statement sorts the employee by the state even though the state column does not appear on the select list.
SELECT
    FirstName,
    LastName,
	City
FROM
    employee_info
ORDER BY
	State;

--F) Sort a result set by an expression
--The LEN() function returns the number of characters of a string. 
--The following statement uses the LEN() function in the ORDER BY clause to retrieve a employee list sorted by the length of the first name.
SELECT
    FirstName,
    LastName
FROM
    employee_info
ORDER BY
	LEN(FirstName) DESC;

--G) Sort by ordinal positions of columns
--SQL Server allows you to sort the result set based on the ordinal positions of columns that appear in the select list.
--The following statement sorts the employees by first name and last name. But instead of specifying the column names explicitly, 
--it uses the ordinal positions of the columns:
SELECT
    FirstName,
    LastName
FROM
    employee_info
ORDER BY
	1,
	2;

--In this example, 1 means the FirstName column and 2 means the LastName column.


----------------------------------------------------------------------------------------

INSERT INTO employee_info (FirstName,LastName,Address,City,PhoneNumber,Salary,StartDate,Gender,State) VALUES
('Sonali', 'Baranwal', 'Raj Nagar', 'Ghaziabad', '9873070519', 600000.00, '2019-01-03','F','UP'),
('Monika', 'Sharma', 'Vaishali', 'Ghaziabad', '7860650519', 700000.00, '2019-01-03','F','UP'),
('Rohit', 'Sharma', 'Wahnkhede', 'Mumbai', '9598650519', 800000.00, '2020-01-03','M','Maharashtra'),
('Subhash', 'Verma', 'Pune', 'Pune', '7898650519', 700000.00, '2020-01-03','M','Maharashtra');

select * from employee_info;
-------------------------SQL Server OFFSET FETCH----------------------

--The OFFSET and FETCH clauses are the options of the ORDER BY clause. They allow you to limit the number of rows to be returned by a query.

--The following illustrates the syntax of the OFFSET and FETCH clauses:

----ORDER BY column_list [ASC |DESC]
----OFFSET offset_row_count {ROW | ROWS}
----FETCH {FIRST | NEXT} fetch_row_count {ROW | ROWS} ONLY
----Code language: SQL (Structured Query Language) (sql)
----In this syntax:

--The OFFSET clause specifies the number of rows to skip before starting to return rows from the query. 
--The offset_row_count can be a constant, variable, or parameter that is greater or equal to zero.

--The FETCH clause specifies the number of rows to return after the OFFSET clause has been processed. 
--The fetch_row_count can a constant, variable or scalar that is greater or equal to one.

--The OFFSET clause is mandatory while the FETCH clause is optional. Also, the FIRST and NEXT are synonyms respectively 
--so you can use them interchangeably.
--Note that you must use the OFFSET and FETCH clauses with the ORDER BY clause. Otherwise, you will get an error.
--To include a serial number (S.No) as the first column in your SQL query, you can use the ROW_NUMBER() window function.
--The function 'ROW_NUMBER' must have an OVER clause.

SELECT
	ROW_NUMBER() OVER (Order By LastName) as SNO,
    FirstName,
    LastName
FROM
    employee_info
ORDER BY
	LastName,
    FirstName;

--To skip the first 5 Name and return the rest, you use the OFFSET clause as shown in the following statement:
SELECT
	ROW_NUMBER() OVER (Order By LastName) as SNO,
    FirstName,
    LastName
FROM
    employee_info
ORDER BY
	LastName,
    FirstName
OFFSET 5 ROWS;

--To skip the first 4 employees and select the next 3 employees, you use both OFFSET and FETCH clauses as follows:
SELECT
	ROW_NUMBER() OVER (Order By LastName) AS SNo,
    FirstName,
    LastName
FROM
    employee_info
ORDER BY
	LastName,
    FirstName
OFFSET 4 ROW
FETCH NEXT 3 ROWS ONLY;

--To get the top 7 highest paid employees we can use both OFFSET and FETCH clauses:
SELECT
	ROW_NUMBER() OVER (Order By Salary Desc) AS SNo,
    FirstName,
    LastName,
	Salary
FROM
    employee_info
ORDER BY
	Salary DESC,
	FirstName ASC
OFFSET 0 ROWS
FETCH NEXT 7 ROWS ONLY;

select * from employee_info;

--To count the total number of rows returned by your query, you can use a COUNT(*) function. One way to achieve this is by 
--using a common table expression (CTE) or a subquery. Here's an example using a CTE:
WITH EmployeeData AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY LastName) AS SNO,
        FirstName,
        LastName
    FROM
        employee_info
)
SELECT
    *,
    (SELECT COUNT(*) FROM EmployeeData) AS TotalCount
FROM
    EmployeeData
ORDER BY
    LastName,
    FirstName;


--Alternatively, if you prefer to use a subquery instead of a CTE, you can write:
SELECT
    *,
    (SELECT COUNT(*) FROM employee_info AS Subquery) AS TotalCount
FROM
    (
        SELECT
            ROW_NUMBER() OVER (ORDER BY LastName) AS SNO,
            FirstName,
            LastName
        FROM
            employee_info
    ) AS MainQuery
ORDER BY
    LastName,
    FirstName;


-----------Introduction to SQL Server SELECT TOP
--The SELECT TOP clause allows you to limit the number of rows or percentage of rows returned in a query result set.
--Because the order of rows stored in a table is unspecified, the SELECT TOP statement is always used in conjunction with the ORDER BY clause. 
--Therefore, the result set is limited to the first N number of ordered rows.

----WITH TIES
--The WITH TIES allows you to return more rows with values that match the last row in the limited result set. 
--Note that WITH TIES may cause more rows to be returned than you specify in the expression.

--For example, if you want to return the most expensive products, you can use the TOP 1. 
--However, if two or more products have the same prices as the most expensive product, then you miss the other most expensive products in the result set.

--To avoid this, you can use TOP 1 WITH TIES. It will include not only the first expensive product but also the second one, and so on.
--1) Using TOP with a constant value
SELECT TOP 5
	ROW_NUMBER() OVER (Order By Salary Desc) as SNo,
    FirstName,
    LastName,
	Salary
FROM
    employee_info
ORDER BY
	Salary DESC,
	FirstName ASC
select * from employee_info;

--2) Using TOP to return a percentage of rows
SELECT TOP 30 PERCENT
	ROW_NUMBER() OVER (Order By Salary Desc) as SNo,
    FirstName,
    LastName,
	Salary
FROM
    employee_info
ORDER BY
	Salary DESC,
	FirstName ASC
select * from employee_info;

--3) Using TOP WITH TIES to include rows that match the values in the last row
SELECT TOP 3 WITH TIES
	ROW_NUMBER() OVER (Order By Salary Desc) AS SNo,
    FirstName,
    LastName,
	Salary
FROM
    employee_info
ORDER BY
	Salary DESC
select * from employee_info;


---------------------------------------------------------------------------------------


----------SQL Server SELECT DISTINCT clause------------------
--Sometimes, you may want to get only distinct values in a specified column of a table. 
--To do this, you use the SELECT DISTINCT clause as follows:

--A) DISTINCT one column example
SELECT DISTINCT
    City
FROM
    employee_info
ORDER BY
    City;
--The query returns a distinct value for each group of duplicates. 
--In other words, it removed all duplicate cities from the result set.


--B) DISTINCT multiple columns example
--This statement returns distinct cities and states of all employees:
SELECT DISTINCT
    City,
	State
FROM
    employee_info


--C) DISTINCT with null values example
INSERT INTO employee_info (FirstName,LastName,Address,City,Salary,StartDate,Gender,State) VALUES
('Ankur', 'Yadav', 'Patna', 'Patna', 800000.00, '2020-01-03','M','Bihar'),
('Chadrawali', 'Yadav', 'Patna', 'Patna', 700000.00, '2020-01-03','F','Bihar');

--The following example finds the distinct phone numbers of the employees:
SELECT DISTINCT
    PhoneNumber
FROM
    employee_info
ORDER BY
    PhoneNumber;
select * from employee_info;
--In this example, the DISTINCT clause kept only one NULL in the phone column and removed the other NULLs.


------DISTINCT vs. GROUP BY------
--The following statement uses the GROUP BY clause to return distinct cities together 
--with state and zip code from the employee_info table:
SELECT 
	City, 
	State
FROM 
	employee_info
GROUP BY 
	City, State
ORDER BY
	City, State

--It is equivalent to the following query that uses the DISTINCT operator :
SELECT DISTINCT 
	City, 
	State
FROM 
	employee_info;

--Both DISTINCT and GROUP BY clause reduces the number of returned rows in the result set by removing the duplicates.
--However, you should use the GROUP BY clause when you want to apply an aggregate function on one or more columns.


------------------------SQL Server WHERE clause------------------------


--In the WHERE clause, you specify a search condition to filter rows returned by the FROM clause. 
--The WHERE clause only returns the rows that cause the search condition to evaluate to TRUE.
--The search condition is a logical expression or a combination of multiple logical expressions. 
--In SQL, a logical expression is often called a predicate.

--A) Finding rows by using a simple equality
SELECT
    FirstName,LastName,Salary,Gender,City,State
FROM
    employee_info
WHERE
    State='UP'
ORDER BY
    Salary;

--B) Finding rows that meet two conditions
SELECT
    FirstName,LastName,Salary,Gender,City,State
FROM
    employee_info
WHERE
    State='UP' AND Gender='M'
ORDER BY
    Salary;

--C) Finding rows by using a comparison operator
SELECT
    FirstName,LastName,Salary,Gender,City,State
FROM
    employee_info
WHERE
    State='UP' and Salary>400000
ORDER BY
    Salary DESC;

--D) Finding rows that meet any of two conditions
SELECT
    FirstName,LastName,Salary,Gender,City,State
FROM
    employee_info
WHERE
    State='UP' or Salary>500000
ORDER BY
    Salary DESC;

--E) Finding rows with the value between two values
SELECT
    FirstName,LastName,Salary,Gender,City,State
FROM
    employee_info
WHERE
    Salary BETWEEN 400000 and 600000
ORDER BY
    Salary DESC;

--F) Finding rows that have a value in a list of values
--The following example uses the IN operator to find employees whose Salary is 450000 or 600000 or 800000.
SELECT
    FirstName,LastName,Salary,Gender,City,State
FROM
    employee_info
WHERE
    Salary IN (450000, 600000, 800000)
ORDER BY
    Salary DESC;

--G) Finding rows whose values contain a string
SELECT
    FirstName,LastName,Salary,Gender,City,State
FROM
    employee_info
WHERE
    FirstName LIKE '%Sh%'
ORDER BY
    Salary DESC;


------------------SQL Server AND operator-----------------------

--The AND is a logical operator that allows you to combine two Boolean expressions. 
--It returns TRUE only when both expressions evaluate to TRUE.

--A) Using AND operator example
SELECT
    *
FROM
    employee_info
WHERE
    State='UP' and Salary>400000
ORDER BY
    Salary DESC;

--B) Using multiple AND operators example
SELECT
    *
FROM
    employee_info
WHERE
    State='UP' and Salary>400000 and Gender='F'
ORDER BY
    Salary DESC;

--C) Using the AND operator with other logical operators
SELECT
    *
FROM
    employee_info
WHERE
    State='UP' or Salary>400000 and Gender='F'
ORDER BY
    Salary DESC;

--In this example, we used both OR and AND operators in the condition. 
--As always, SQL Server evaluated the AND operator first.

SELECT
    *
FROM
    employee_info
WHERE
	(LastName='Seth' or LastName='Verma')
    and Salary>400000 
ORDER BY
    Salary DESC;


---------------------------SQL Server OR operator----------------------

--The SQL Server OR is a logical operator that allows you to combine two Boolean expressions. 
--It returns TRUE when either of the conditions evaluates to TRUE.

--Note:- When you use more than one logical operator in a statement, SQL Server evaluates the OR operators after the AND operator. 
--However, you can use the parentheses to change the order of the evaluation.

--A) Using OR operator example
SELECT
    FirstName,LastName,Salary
FROM
    employee_info
WHERE
	Salary<400000 or Salary>600000 
ORDER BY
    Salary DESC;

--B) Using multiple OR operators example
SELECT
    FirstName,LastName,Salary,Gender
FROM
    employee_info
WHERE
	Salary<400000 or Salary>600000 or Gender='F'
ORDER BY
    Salary DESC;

--You can replace multiple OR operators by using IN operator as shown in the following query:
SELECT
    FirstName,LastName,Salary,Gender
FROM
    employee_info
WHERE
	Salary IN (400000,500000,800000)
ORDER BY
    Salary DESC;

--C) Using OR operator with AND operator example
SELECT
    FirstName,LastName,Salary,Gender,State
FROM
    employee_info
WHERE
    State='UP' or Salary>400000 and Gender='F'
ORDER BY
    Salary DESC;

--We can use the parentheses as shown in the following query:
SELECT
    FirstName,LastName,Salary,Gender,State
FROM
    employee_info
WHERE
    (Salary<300000 or Salary>600000) and Gender='F'
ORDER BY
    Salary DESC;


----------------SQL Server IN operator---------------------

--The IN operator is a logical operator that allows you to test 
--whether a specified value matches any value in a list.

--The IN operator is equivalent to multiple OR operators, therefore, the following predicates are equivalent:

------    column IN (v1, v2, v3) |
------    column = v1 OR column = v2 OR column = v3

--To negate the IN operator, you use the NOT IN operator as follows:
------    column | expression NOT IN ( v1, v2, v3, ...)


--A) Using SQL Server IN with a list of values example
SELECT
    FirstName,LastName,Salary,Gender
FROM
    employee_info
WHERE
	Salary IN (400000,500000,800000)
ORDER BY
    Salary DESC;

--The query above is equivalent to the following query that uses the OR operator instead:
SELECT
    FirstName,LastName,Salary,Gender
FROM
    employee_info
WHERE
	Salary =400000 or Salary=500000 or Salary=800000
ORDER BY
    Salary DESC;

--To find the employees whose salaries are not one of the salaries above, 
--you use the NOT IN operator as shown in the following query:
SELECT
    FirstName,LastName,Salary,Gender
FROM
    employee_info
WHERE
	Salary NOT IN (400000,500000,800000)
ORDER BY
    Salary DESC;

--B) Using SQL Server IN operator with a subquery example
SELECT
    FirstName,LastName,Salary,Gender
FROM
    employee_info
WHERE
    EmployeeID IN (
        SELECT
            EmployeeID
        FROM
            employee_info
        WHERE
            Salary>600000
    )
ORDER BY
    FirstName;

select * from employee_info;


-------------------------SQL Server BETWEEN operator----------------------------

--The BETWEEN operator is a logical operator that allows you to specify a range to test.

--A) Using SQL Server BETWEEN with numbers example
SELECT
    FirstName,LastName,Salary,Gender
FROM
    employee_info
WHERE
	Salary BETWEEN 600000 and 800000
ORDER BY
    Salary DESC;

SELECT
    FirstName,LastName,Salary,Gender
FROM
    employee_info
WHERE
	Salary NOT BETWEEN 600000 and 800000
ORDER BY
    Salary DESC;

--B) Using SQL Server BETWEEN with dates example
SELECT
    FirstName,LastName,Salary,Gender,StartDate
FROM
    employee_info
WHERE
	StartDate BETWEEN CAST('2021-01-01' as DATE) AND GETDATE()
ORDER BY
    Salary DESC;


----------------------SQL Server LIKE operator-----------------------


--The SQL Server LIKE is a logical operator that determines if a character string matches a specified pattern. 
--A pattern may include regular characters and wildcard characters. 
--The LIKE operator is used in the WHERE clause of the SELECT, UPDATE, and DELETE statements to filter rows based on pattern matching.

------Pattern------
--The pattern is a sequence of characters to search for in the column or expression. 
--It can include the following valid wildcard characters:

--The percent wildcard (%): any string of zero or more characters.
--The underscore (_) wildcard: any single character.
--The [list of characters] wildcard: any single character within the specified set.
--The [character-character]: any single character within the specified range.
--The [^]: any single character not within a list or a range.


----The % (percent) wildcard examples
--The following example finds the employees whose last name starts with the letter s:
SELECT
    EmployeeID,FirstName,LastName,Salary,Gender
FROM
    employee_info
WHERE
	LastName Like 's%'
ORDER BY
    FirstName DESC;

--The following example returns the employees whose last name ends with the character Like a:
SELECT
    EmployeeID,FirstName,LastName,Salary,Gender
FROM
    employee_info
WHERE
	LastName Like '%a'
ORDER BY
    FirstName DESC;

--The following statement retrieves the employees whose last name starts with the letter v and ends with the letter a:
SELECT
    EmployeeID,FirstName,LastName,Salary,Gender
FROM
    employee_info
WHERE
	LastName Like 'v%a'
ORDER BY
    FirstName DESC;

/* The _ (underscore) wildcard example */
--The underscore represents a single character. For example, 
--the following statement returns the employees where the second character is the letter a:
SELECT
    EmployeeID,FirstName,LastName,Salary,Gender
FROM
    employee_info
WHERE
	FirstName Like '_a%'
ORDER BY
    FirstName DESC;

----The pattern _a%

--The first underscore character ( _) matches any single character.
--The second letter a matches the letter a exactly
--The third character % matches any sequence of characters

/* The [list of characters] wildcard example */

--The square brackets with a list of characters e.g., [ABC] represents a single character 
--that must be one of the characters specified in the list.
SELECT
    EmployeeID,FirstName,LastName,Salary,Gender
FROM
    employee_info
WHERE
	FirstName Like '[SRP]%'
ORDER BY
    FirstName DESC;

/* The [character-character] wildcard example */
--The square brackets with a character range e.g., [A-C] represent a single character 
--that must be within a specified range.
SELECT
    EmployeeID,FirstName,LastName,Salary,Gender
FROM
    employee_info
WHERE
	FirstName Like '[A-R]%'
ORDER BY
    FirstName DESC;


/* 
The [^Character List or Range] wildcard:
	any single character not within a list or a range.
*/
--The square brackets with a caret sign (^) followed by a range e.g., [^A-C] or character list e.g., 
--[ABC] represent a single character that is not in the specified range or character list.
SELECT
    EmployeeID,FirstName,LastName,Salary,Gender
FROM
    employee_info
WHERE
	FirstName Like '[^A-R]%'
ORDER BY
    FirstName DESC;

/* The NOT LIKE operator example */
--The following example uses the NOT LIKE operator to find employees 
--where the first character in the first name is not the letter S:
SELECT
    EmployeeID,FirstName,LastName,Salary,Gender
FROM
    employee_info
WHERE
	FirstName NOT Like 'S%'
ORDER BY
    FirstName DESC;


-----------------------------------------------------------------------------

----Creating a new Schema
create schema sales;

--First, create a new table for the demonstration:
CREATE TABLE sales.feedbacks (
   feedback_id INT IDENTITY(1, 1) PRIMARY KEY, 
    comment     VARCHAR(255) NOT NULL
);

--Second, insert some rows into the sales.feedbacks table:
INSERT INTO sales.feedbacks(comment)
VALUES('Can you give me 30% discount?'),
      ('May I get me 30USD off?'),
      ('Is this having 20% discount today?');

SELECT * FROM sales.feedbacks;

--If you want to search for 30% in the comment column, you may come up with a query like this:
SELECT 
   feedback_id,comment
FROM 
   sales.feedbacks
WHERE 
   comment LIKE '%30%';

--The query returns the comments that contain 30% and 30USD, which is not what we expected.

--To solve this issue, you need to use the ESCAPE clause:

SELECT 
   feedback_id, comment
FROM 
   sales.feedbacks
WHERE 
   comment LIKE '%30!%%' ESCAPE '!';

--In this query, the  ESCAPE clause specified that the character ! is the escape character. 
--It instructs the LIKE operator to treat the % character as a literal string instead of a wildcard. 
--Note that without the ESCAPE clause, the query would return an empty result set.


-----------------------------------------------------------------------

----SQL Alias----
--SQL Aliases can be used to create a temporary name for columns and tables.


------SQL Server column alias-----
--To assign a column or an expression a temporary name during the query execution, you use a column alias.

SELECT
    FirstName + ' ' + LastName AS 'Full Name'
FROM
    employee_info
ORDER BY
    FirstName;

--When you assign a column an alias, you can use either the column name or the column alias in the ORDER BY clause 
--as shown in the following example:
SELECT
    FirstName, Salary 'Employee Salary'
FROM
    employee_info
ORDER BY
    FirstName;  

----------------------------------------------
SELECT
    FirstName, Salary 'Employee Salary'
FROM
    employee_info
ORDER BY
    'Employee Salary';
	

SELECT 
	EmployeeID As Id, FirstName, LastName
From
	employee_info
---------------------------SQL Server table alias--------------------------------

----TABLE ALIASES: are used to shorten SQL query to make it easier to read or when there are more than one table is involved.

--A table can be given an alias which is known as correlation name or range variable.
--Similar to the column alias, table alias can be assigned either with or without the AS keyword:

Create table Employees
(
	Emp_ID int identity primary key,
	Name varchar(100) Not null,
	Age int not null,
	Address varchar(255) not null,
	Salary money default 1000,
	Dept_ID int
)

INSERT INTO Employees(Name,Age,Address,Salary,Dept_ID) Values
('Shubham',25,'Delhi',600000,3);

INSERT INTO Employees(Name,Age,Address,Salary) Values
('Rahul',22,'Mumbai',600000);

INSERT INTO Employees(Name,Age,Address,Salary,Dept_ID) Values
('Kamal',23,'Lucknow',500000,3),
('Kiran',24,'Varanasi',400000,1),
('Chirag',28,'Jaunpur',300000,1);

INSERT INTO Employees(Name,Age,Address,Salary) Values
('Harsh',19,'Patna',300000),
('Kajal',20,'Pune',600000);

INSERT INTO Employees(Name,Age,Address,Salary,Dept_ID) Values
('Mahi',26,'Pune',600000,2),
('Pavan',25,'Jaunpur',600000,2)

select * from Employees;

Create table Dept(
	Dept_ID int identity primary key,
	D_Name varchar(100) not null
)

INSERT INTO Dept(D_Name) Values
('Sales'),
('HR'),
('Finance'),
('Marketing')
select * from Dept;


-----------Table Alias Example--------------------------
SELECT 
	E.Emp_ID, E.Name, D.Dept_ID, D.D_Name
FROM 
	Employees AS E, Dept AS D
WHERE
	E.Dept_ID=D.Dept_ID;

--In this query, E is the alias for the Employees table and D is the alias for the Dept table.

select * from Employees;
select * from Dept;