
------------------------------SQL Stored Procedures--------------------------------------------
/*
	A Stored Procedure is a database object.
	A stored Procedure is  a series of declarative SQL statements.
	A stored procedure is a prepared SQL code that you can save, so the code can be reused over and over again.
	It is a pre-compiled code of SQL statement.
	A stored procedure can be stored in the DB and can be reused over & over again.
	Parameters can be passed to a stored procedure, so that the stored procedure can act based on the parameter value(s).
	SQL server creates an execution plan & stores it in the cache.
	When you call a stored procedure for the first time, SQL Server creates an execution plan and stores it in the cache. 
	In the subsequent executions of the stored procedure, SQL Server reuses the plan to execute the stored procedure very fast with reliable performance.
*/

------How to create stored procedure-------
Create Procedure spEmployeeDetails
AS
BEGIN
SELECT * from employee_info where City='Jaunpur';
END

/*	The AS keyword separates the heading and the body of the stored procedure.
	If the stored procedure has one statement, the BEGIN and END keywords surrounding the statement are optional. 
	However, it is a good practice to include them to make the code clear.	*/

----drop proc spEmployeeDetails

-------------How to execute/call stored procedure---------------------

spEmployeeDetails
Execute spEmployeeDetails
EXEC spEmployeeDetails

Create Procedure spEmployeeDetails2
AS
BEGIN
SELECT * from Employees where Dept_ID=1;
END

EXEC spEmployeeDetails2

------How To Modified Stored Procedure-------
ALTER Proc spEmployeeDetails2
AS
BEGIN
SELECT * from Employees where Dept_ID=1;
SELECT * from Employees where Dept_ID=2;
END

EXEC spEmployeeDetails2

DROP Proc spEmployeeDetails2  ------- to delete a Stored Procedure


-----------------Parameters in STORED PROCEDURE------------------
------ Two Types:- (1) Input Parameter & (2) Output Parameter

Create Procedure spEmployeeDetails2
AS
BEGIN
SELECT * from Employees where Dept_ID=1;
SELECT * from Employees where Name='Shubham';
END

EXEC spEmployeeDetails2

--------------------------------------------------------

ALTER Proc spEmployeeDetails2
@dept_ID	int,
@name	    Varchar(100)
AS
BEGIN
SELECT * from Employees where Dept_ID=@dept_ID;
SELECT * from Employees where Name=@name;
END

spEmployeeDetails2 1, 'Shubham'              ---- Order of parameters and value is very important in SP.

----Named Parameter value
spEmployeeDetails2  @name = 'Shubham', @dept_ID = 2         ----In this case order of parameter is not important


-----------------------------------------------------------------------
--Default Parameters (Parameters with Default Values)
ALTER Proc spEmployeeDetails2
@dept_ID	int=1,
@name	    Varchar(100)='Shubham'
AS
BEGIN
SELECT * from Employees where Dept_ID=@dept_ID;
SELECT * from Employees where Name=@name;
END

spEmployeeDetails2 3, 'Mahi'   


---------------------------------------------------------------------------
--OUTPUT PARAMETER
Create Proc spAddDigits
@num1 INT,
@num2 INT,
@result INT OUTPUT
AS
BEGIN
	SET @result = @num1 + @num2;
END

Declare @var money
EXEC spAddDigits 27, 23, @Var OUTPUT;
SELECT @var

--Stored Procedure security with encryption
sp_helptext spAddDigits   --- To display SP Texts

ALTER PROC spAddDigits
@num1 INT,
@num2 INT,
@result INT OUTPUT
WITH ENCRYPTION       ---- To encrypt the stored procedure text for object
AS
BEGIN
	SET @result = @num1 + @num2;
END

sp_helptext spAddDigits;  


-----------------------------------------------------------------------------------

----Stored Procedure Output Parameters----

CREATE PROCEDURE uspFindEmployeeByGender (
    @Gender VARCHAR(1),
    @employee_count INT OUTPUT
) 
AS
BEGIN
    SELECT 
        FirstName,
        Salary
    FROM
        employee_info
    WHERE
        Gender = @Gender;

    SELECT @employee_count = @@ROWCOUNT;
END;

----Note that the @@ROWCOUNT is a system variable that returns the number of rows read by the previous statement.

/*	Calling stored procedures with output parameters */

--First, declare the @count variable to hold the value of the output parameter of the stored procedure:
DECLARE @count INT;
--Then, execute the uspFindEmployeeByGender stored procedure and passing the parameters:
EXEC uspFindEmployeeByGender
    @Gender = 'M',
    @employee_count = @count OUTPUT;
--Finally, show the value of the @count variable:
SELECT @count AS 'Number of employees found';