
-------------------------------- FUNCTIONS IN SQL SERVER --------------------------------------------

/*
							FUNCTIONS IN PROGRAMMING
	A function is a block of code that performs a specific task.
	Functions usually "Take in" data, process it, and "return" a result.
	Once a function is written, it can be used over and over again, it means functions can be reused.

							FUNCTIONS IN SQL SERVER
	SQL Server Functions are useful objects in SQL Server databases.
	A function is a set of SQL statements that perform a specific task. 
	A SQL Server function is a code snippet that can be executed on a SQL Server.
	Functions faster code reusability.
	If you have to repeatedly write large SQL scripts to perform the same task, you can create a function that
	performs that task.
	Next time instead of rewriting the SQL, you can simply call that function.
	A function accepts inputs in the form of parameters and returns a value.

	SQL Server comes with a set of built-in functions that perform a variety of tasks.
	In SQL Server, a function is a STORED PROGRAM that you can pass parameters into and return a value.
	Ofcourse, you could create a stored procedure to group a set of SQL statements and execute them, however,
	stored procedures cannot be called within SQL statements.
	Therefore, if you are using functions with large data sets, you can hit performance issues.

	In T-SQL, a function is considered an object. Here are some of the rules when creating functions in SQL Server.
	* A function must have a name and a function name can never start with a special character such as @, $, #, and so on.
	* Functions only work with SELECT Statement.
	* Functions can be used anywhere in SQL, like AVG, COUNT, SUM, MIN, DATE and so on with select statements.
	* Functions compile every time.
	* Functions must return a value or result.
	* Functions only work with input parameters.
	* TRY and CATCH statements are not used in functions.

								SQL SERVER FUNCTIONS TYPES
	SQL Server supports two types of functions - user defined and system.
	
	* USER DEFINED FUNCTION: User defined functions are created by a user.

	* SYSTEM DEFINED FUNCTION: System functions are built in database functions.

	There are three types of user-defined functions in SQL Server.
	1. Scalar Functions
	2. Inline Table Valued Functions
	3. Multi-Statement Table Valued Functions

								WHAT ARE SCALER FUNCTIONS	
	SQL Server scalar function takes one or more parameters and returns a single(scalar) value.
	The returned value can be of any data type, except text, ntext, image, cursor and timestamp.

*/

-- Steps To Do:
/* Create a function without Parameter */
CREATE Function ShowMessage()
Returns varchar(100)
AS
BEGIN
	return 'Welcome To Function'
END

Select dbo.ShowMessage();


/* Create a function with a single Parameter */
CREATE Function TakeANumber(@num as int)
Returns int
AS
BEGIN
	return (@num * @num)
END

Select dbo.TakeANumber(5);


/* Create a function with multiple Parameters */
CREATE Function Addition(@num1 as int, @num2 as int)
Returns int
AS
BEGIN
	return (@num1 + @num2)
END

SELECT dbo.Addition(6,5);
SELECT dbo.Addition(4,5);


/* Alter a function */
Alter Function TakeANumber(@num as int)
Returns int
AS
BEGIN
	return (@num * @num * @num)
END

Select dbo.TakeANumber(5);


/* Drop a function */
Drop Function TakeANumber;


/*
								SQL SERVER SCALAR FUNCTION
	The following are some key takeaway of the scalar functions:
	* Scalar functions can be used almost anywhere in T-SQL statements.
	* Scalar functions accept one or more parameters but return only one value, therefore, they must include
	  a RETURN statement.
	* Scalar functions can use logic such as IF blocks or WHILE loops.
	* Scalar functions cannot update data. They can access data but this is not a good practice.
	* Scalar function can call other functions.
*/

------- Scalar functions can use logic such as IF blocks or WHILE loops ----------
Create function CheckVotersAge(@age as int)
returns varchar(100)
AS
BEGIN
	Declare @str varchar(100)
	if @age >= 18
		BEGIN
			set @str = 'You are eligible to Vote'
		END
	else
		BEGIN
			set @str = 'You are not eligible to Vote'
		END
	return @str
END

Select dbo.CheckVotersAge(15)
drop function dbo.CheckVotersAge

--------- Scalar function can call other functions ---------------
Create function GetMyDate()
returns DateTime
AS
BEGIN
	return GetDate();
END

Select dbo.GetMyDate();


/*
					# CAST and CONVERT Function in MS SQL Server

	* Both CAST and CONVERT are functions used to  convert one data type to another data type.
	* Both are often used interchangeably.
	* Without using CAST or CONVERT functions, implicit conversions occur.

	SYNTAX:
		CAST
			CAST(exp AS datatype[(len)])
		CONVERT
			CONVERT (datatype[(len)], expression[, style])


					# Difference between CAST and CONVERT Function

				CAST								|					CONVERT
	* CAST is an ANSI standard.						| * Convert is a specific function in the SQL Server.
	* CAST is used to remove or reduce format while | * CONVERT function can be used for formatting purposes especially for
	  still converting.								|	date/time, data type, and money/data type.
	* CAST is also the more portable function of	| * CONVERT allows more flexibility and is the preferred function to
	  the two. It means that the CAST function can	|   use for data, time values, traditional numbers, and money signifiers.
	  be used by many databases.					|

					# Should I use CAST or CONVERT ?
	Unless you have some specific formatting requirements you're trying to address during the conversion. I would stick
	with using the CAST function. There are several reasons I can think of:
	* CAST  is ANSI-SQL compliant; therefore, more apt to be used in other database implementation.
	* There is no performance penalty using CAST.
	
ANSI:- American National Standards Institute
*/

SELECT * From employee_info;

SELECT EmployeeID, CAST(StartDate AS Varchar) as join_date, FirstName, LastName from employee_info;
SELECT EmployeeID, CONVERT(Varchar, StartDate) as join_date, FirstName, LastName from employee_info;

SELECT EmployeeID, CAST(StartDate AS Varchar(12)) as join_date, FirstName, LastName from employee_info;
SELECT EmployeeID, CONVERT(Varchar(12), StartDate) as join_date, FirstName, LastName from employee_info;

SELECT FirstName + '-' + CAST(EmployeeID AS Varchar), CAST(StartDate AS Varchar) as join_date from employee_info;
SELECT CAST(EmployeeID AS Varchar)+ '-' + FirstName as EmpNameWithId, StartDate from employee_info;
SELECT CONVERT(Varchar, EmployeeID)+ '-' + FirstName as EmpNameWithId, StartDate from employee_info;

SELECT COUNT(EmployeeID) 'Total Count', StartDate from employee_info GROUP BY StartDate;
SELECT COUNT(EmployeeID) 'Total Count', CAST(StartDate AS Date) as 'StartDate' from employee_info GROUP BY CAST(StartDate AS Date);
SELECT COUNT(EmployeeID) 'Total Count', CONVERT(Date, StartDate) as 'StartDate' from employee_info GROUP BY CONVERT(Date, StartDate);


--CONVERT (datatype[(len)], expression[, style])
/*
8	-- hh:mm:ss
101 -- mm/dd/yyyy
102 -- yyyy.mm.dd
103 -- dd/mm/yyyy
104 -- dd.mm.yyyy
*/

SELECT EmployeeID, CONVERT(Varchar, StartDate,8) as 'DateTime', FirstName, LastName from employee_info;
SELECT EmployeeID, CONVERT(Varchar, StartDate,101) as 'DateTime', FirstName, LastName from employee_info;
SELECT EmployeeID, CONVERT(Varchar, StartDate,102) as 'DateTime', FirstName, LastName from employee_info;
SELECT EmployeeID, CONVERT(Varchar, StartDate,103) as 'DateTime', FirstName, LastName from employee_info;
SELECT EmployeeID, CONVERT(Varchar, StartDate,104) as 'DateTime', FirstName, LastName from employee_info;


------------------------------------------------------------------------------------------------

/*
									INLINE TABLE VALUED FUNCTIONS
	Contains a single T-SQL statement and returns a Table set.

	SCALER FUNCTION: It returns a scalar value.

	INLINE TABLE VALUED FUNCTIONS: It returns a table.

	Steps to create Inline Table Valued Functions:-
	Step 1: We have to specify TABLE as the return type, instead of any scalar data type like int, varchar etc.
	Step 2: There is no BEGIN and END Blocks.
	Step 3: The table that gets returned, is determined by the SELECT command within the function.
*/

Create function fn_GetStudents()
returns table
as 
return (select * from Student_details);
 
select * from fn_GetStudents();

-------- With Parameter ----------------
Create function fn_GetStudentsWithRollNo(@rollNO INT) 
returns table
as 
return (select * from Student_details Where RollNO >= @rollNO);

--drop function fn_GetStudentsWithClass;
select * from fn_GetStudentsWithRollNo(5);

------------- Using Inline Table Valued Function in joins -----------------------------
Select * from fn_GetStudentsWithRollNo(5) as A
inner join employee_info as B
on A.RollNO = B.EmployeeID;


---------------------------------------------------------------------------------------------------

/*
						Multi-Statement Table Valued Functions
	* A multi-statement table valued function is a table-valued function that returns the result of multiple statements.
	* The multi-statement table-valued function is very useful because you can execute multiple queries within the 
	  function and aggregate results into the returned table.
	* To define a multi-statement table-valued function, you use a table variable as the return value. Inside the function,
	  you execute one or more queries and insert data into this table variable.


			Difference Between Inline Table Valued Function and Multi-statement Table Valued Functions

	INLINE TABLE-VALUED FUNCTIONS
	* In this, the returns clause cannot contain the structure of the table.
	* In this, there are no BEGIN and END Blocks.
	* Inline table-valued functions are better in performance as compared to multi-statement table-valued functions.
	* Internally, Inline table-valued function much like it would a view.

	MULTI-STATEMENT TABLE-VALUED FUNCTIONS
	* In this, we specify the structure of the table with returns clause.
	* In this, we have to use BEGIN and END blocks.
	* There is no performance advantage in multi-statement table-valued functions.
	* Internally, multi-statement table-valued function much like it would a stored procedure.


									SIMILARITIES
	* Inline statement table-valued functions and multi-statement table-valued functions both are table-valued functions.
	* Inline statement table-valued functions and multi-statement table-valued functions both are located in Table-Valued
	  functions folder in SSMS.
	* Both are the types of user-defined functions in SQL Server.
*/

--MULTI-STATEMENT TABLE-VALUED FUNCTIONS
Create function fn_GetEmployeesByGender(@gender varchar(1))
returns @myTable table (empID int, empName varchar(50), gender varchar(1))
as
BEGIN
	insert into @myTable
	select EmployeeID, FirstName, Gender from employee_info WHERE Gender = @gender

	return
END

select * from fn_GetEmployeesByGender('F');


--INLINE TABLE-VALUED FUNCTIONS
Create function fn_GetEmployeesByGender2(@gender varchar(1))
returns table 
as
return
	(select EmployeeID, FirstName, Gender from employee_info WHERE Gender = @gender)

select * from fn_GetEmployeesByGender2('M');


/*
Ques:- What is an Aggregate Function in SQL?
Ans:- An aggregate function in SQL returns one value after calculating multiple values of a column. 
	  We often use aggregate functions with the GROUP BY and HAVING clauses of the SELECT statement.
	  SQL provides many aggregate functions that include avg, count, sum, min, max, etc. 
	  An aggregate function ignores NULL values when it performs the calculation, except for the count function. 

	  When using aggregate functions in SQL, it is crucial to understand column references. 
	  A column reference is a name containing the data you want to aggregate. To use an aggregate function with a column reference, 
	  specify the column's name in the function's parentheses. 

For example, to find the average salary of employees in a table called "employees", 
you would use the AVG function with the column reference "salary" like this: 

SELECT AVG (salary)
FROM employees; 

There are 5 types of SQL aggregate functions:

Count()
Sum()
Avg()
Min()
Max()

*/