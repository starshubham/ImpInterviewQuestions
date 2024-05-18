Select * from employee_info
Select Distinct city from employee_info
Select * from employee_info where City = 'Indore' and Salary >= 500000
Select * from employee_info 

Create table customer
(
 customer_id int identity(1,1) primary key,
 first_name varchar(50),
 last_name varchar(50),
 email varchar(150),
 address_id int
)

Select SubString(Firstname, 2,4) from employee_info
Select Concat(Firstname, ' ', LastName), FirstName, LastName from employee_info
Select Replace(Firstname, 'Shubham', 'Shivam'), FirstName, LastName from employee_info

Select ROUND(Avg(Salary), 2) from employee_info

-- Group By and Having
Select City, Sum(Salary) as total from employee_info Group by City order by total asc
Select City, Sum(Salary) as total from employee_info Group by City Having Sum(Salary) > 1000000 order by total asc


Select * from table_A inner join table_B on table_A.Id = table_B.Id
Select * from Employees
Select * from Dept

Select * from Employees as e inner join Dept as d on e.Dept_ID = d.Dept_ID
Select * from Employees as e left join Dept as d on e.Dept_ID = d.Dept_ID
Select * from Employees as e right join Dept as d on e.Dept_ID = d.Dept_ID
Select * from Employees as e full outer join Dept as d on e.Dept_ID = d.Dept_ID

Select * from Employees_Audit
Select * from hr.employees
Select * from sales.feedbacks
Select * from sales.staffs

Select CONCAT(T1.first_name, ' ', T1.last_name) as employee_name, CONCAT(T2.first_name, ' ', T2.last_name) as manager_name
from sales.staffs as T1
join sales.staffs as T2
on T2.staff_id = T1.manager_id

-- Sub Query
Select Avg(salary) from employee_info

Select * from employee_info where Salary > (Select AVG(salary) from employee_info) order by FirstName

-- Case Statement --
Select * from employee_info

Select FirstName, LastName, Salary,
Case
	When salary > 600000 Then 'High Paid Employee'
	When salary < 500000 Then 'Low Paid Employee'
	Else 'Avg Paid Employee'
END as 'Salary Status'
from employee_info


-- Case Expression --
Select FirstName, LastName, Salary,
Case Salary
	When 800000 Then 'High Paid Employee'
	When 400000 Then 'Low Paid Employee'
	Else 'Avg Paid Employee'
END as 'Salary Status'
from employee_info

Select * from employee_info
Select * from Employees
Select * from Dept
Select * from employeeTrans
Select * from RollupTest
Select * from Student_details
Select * from sales.staffs

Select YEAR(StartDate) as years, MONTH(StartDate) as months, SUM(Salary) as totalSalary
from employee_info
Group by YEAR(StartDate), MONTH(StartDate)
order by totalSalary desc

-- Check null value
Select * from Employees where Dept_ID is NUll
Select * from Employees where Dept_ID is not NUll


CREATE TABLE Products ( 
Order_date date, 
Sales int ); 

INSERT INTO Products(Order_date,Sales) 
VALUES
('2021-01-01',20), ('2021-01-02',32), ('2021-02-08',45), ('2021-02-04',31),
('2021-03-21',33), ('2021-03-06',19), ('2021-04-07',21), ('2021-04-22',10)

Select * from Products

SELECT YEAR(Order_date) AS Years, MONTH(Order_date) AS Months, SUM(Sales) AS TotalSales
FROM Products 
GROUP BY YEAR(Order_date),MONTH(Order_date)
ORDER BY TotalSales DESC;


CREATE TABLE Applications ( 
candidate_id int, 
skills varchar); 
-- Note: By default it will create skills column with length 1 if you do not pass any varchar length

Alter table Applications
drop column skills

Alter table Applications
Add skills varchar(50) null

INSERT INTO Applications(candidate_id, skills) 
VALUES
(101, 'Power BI'), (101, 'Python'), (101, 'SQL'), (102, 'Tableau'), (102, 'SQL'),
(108, 'Python'), (108, 'SQL'), (108, 'Power BI'), (104, 'Python'), (104, 'Excel');

Select * from Applications

Select candidate_id, count(skills) as skill_count
from Applications
where skills in ('Power BI', 'Python', 'SQL')
Group By candidate_id
Having COUNT(skills) = 3
Order By candidate_id

-- NOTE: Perform any operation (sum, subtract, div, multiply) with NULL value, output will be NULL

-- How to change a table name in SQL?
-- use sp_rename command
Exec sp_rename 'customer', 'customers'

-- Important: The sp_rename syntax for @objname should include the schema of the old table name, 
-- but @newname does not include the schema name when setting the new table name. 
-- It is neccessary to include schema name if you want to change table which is associated with other than default schema (dbo)

Exec sp_rename 'sales.feedbacks', 'feedback'
Exec sp_rename 'sales.feedback', 'feedbacks'

-- To rename a column:
-- Exec sp_rename 'table_name.old_column_name', 'new_column_name' , 'COLUMN';
Exec sp_rename 'sales.feedbacks.comment', 'comments', 'Column'


-- Key Differences between VARCHAR and NVARCHAR --
-- Varchar:
-- 1. VARCHAR uses a single-byte character set, meaning it can store characters from a single language or script.
-- 2. VARCHAR stores each character using a single byte,
-- 3. The maximum length of VARCHAR and NVARCHAR columns also differs. VARCHAR columns can store up to 8,000 characters.

-- NVARCHAR: 
-- 1. NVARCHAR uses Unicode, allowing it to store characters from multiple languages and scripts.
-- 2. NVARCHAR columns typically consume twice as much storage space as equivalent VARCHAR columns.
-- 3. NVARCHAR columns can store up to 4,000 characters.