
						/* SQL-Views */
/* 
	In SQL, a view is a virtual table based on the result-set of an SQL statement.
	View does not contain any data.
	The fields in a view are fields from one or more real tables in the database.
	You can add SQL functions, WHERE, and JOIN statements to a view and present the data as if the data 
	were coming from one single table
*/

----- View from single table ------------
select * from employee_info;

CREATE VIEW vwEmployeeInfo
AS
SELECT * from employee_info;

select * from vwEmployeeInfo;

--drop view vwEmployeeInfo

sp_helptext 'vwEmployeeInfo'


----- View from two table ------------

select * from employee_info;
select * from Employees;

CREATE VIEW vwEmployeeMultiTable
AS
Select emi.EmployeeID,emi.FirstName,emi.LastName,emi.City,em.Age,em.Dept_ID
From employee_info emi
JOIN Employees em
on emi.EmployeeID=em.Emp_ID;

select * from vwEmployeeMultiTable;


/*	How to UPDATE the Metadata of a SQL VIEW	*/

select * from employee_info;

CREATE VIEW vwEmployeeInfo
AS
SELECT * from employee_info;

select * from vwEmployeeInfo;

ALTER Table employee_info Add Country Varchar(100)

EXEC sp_refreshview vwEmployeeInfo


/*	How to create Schema Binding SQL VIEW	*/
CREATE VIEW vwEmployeeList
AS
SELECT * from employee_info;

select * from vwEmployeeList;
ALTER Table employee_info Drop Column Country

CREATE VIEW vwEmployeeListWithSchemaBinding
WITH SCHEMABINDING
AS
Select EmployeeID,FirstName,LastName,Address,City,PhoneNumber,Salary,StartDate,Gender,State,JOB_ROLE
from dbo.employee_info	------ Now, No-one can alter our table

ALTER Table employee_info Drop Column JOB_ROLE
ALTER Table employee_info Alter Column City Varchar(100)   ---- Throw an error message


----------------------------------------------------------------------------------------

/*
	WHY TO USE VIEW?
	HIDE THE COMPLEXITY OF QUERY
	ROW LEVEL SECURITY
	COLUMN LEVEL SECURITY
*/
Create View vwRowLevel
AS
SELECT * FROM employee_info Where EmployeeID > 7;

select * from vwRowLevel;

-------- COLUMN LEVEL SECURITY ----------
Create View vwColumnLevel
AS
SELECT FirstName,LastName,Gender,City,Salary FROM employee_info;

select * from vwColumnLevel;

------------------------------------------------------------------------

/*
	UPDATING VIEWS
		* WE CAN USE DML OPERATION ON A SINGLE TABLE ONLY
		* VIEW SHOULD NOT CONTAIN GROUP BY, HAVING, DISTINCT CLAUSES
		* WE CANNOT USE A SUBQUERY IN A VIEW  IN SQL SERVER
		* WE CANNOT USE SET OPERATORS IN A SQL VIEW
	DELETE FROM VIEW
	INSERT INTO VIEW
NOTE:- Data is changed in original table then it shows in View table.
*/

Create View vwDemo
AS 
Select * from employee_info;

Select * from vwDemo

INSERT INTO vwDemo(FirstName,LastName,Address,City,PhoneNumber,Salary,StartDate,Gender,State,JOB_ROLE) Values
	('Sumit','Rawat','Civil Line','Gorakhpur','7845128956',700000,GETDATE(),'M','UP','Snr Developer')

DELETE FROM vwDemo Where EmployeeID=22
UPDATE vwDemo Set LastName='Singh' Where EmployeeID=23;


----------------------------------------------------------------------------------

/*
WITH CHECK OPTION
	It is applicable to a updatable view.
	If the view is not updatable, then there is no meaning of this.
	The WITH CHECK OPTION clause is used to prevent the insertion of rows in the view where the condition in the 
	WHERE Clause in create view statement is not satisfied.
*/

Create View vwCheckOptionDemo
AS
Select * from employee_info where City='Gorakhpur'
WITH CHECK OPTION

Select * from vwCheckOptionDemo

INSERT INTO vwCheckOptionDemo (FirstName,LastName,Address,City,PhoneNumber,Salary,StartDate,Gender,State,JOB_ROLE) Values
	('Deepika','Verma','Civil Line','Gorakhpur','9845128956',400000,GETDATE(),'F','UP','Jnr Developer')


--------------------------------------------------------------------------------------------------------------

				/*	SQL Server CURSOR	*/

/*
What is a database cursor?
A database cursor is an object that enables traversal over the rows of a result set. 
It allows you to process individual row returned by a query.
*/

CREATE TABLE [dbo].[Student_details](
[RollNO] [int] Primary Key ,
[Student_Name] [varchar](100) NOT NULL,
[class] [varchar](10) NULL,
[Marks_Science] [int] NOT NULL,
[Marks_Math] [int] NOT NULL,
[Marks_Eng] [int] NOT NULL
) 
Insert Into Student_details Values(1,'Shubham','5th',35,78,54);
Insert Into Student_details Values(2,'Sunil','7th',78,43,87);
Insert Into Student_details Values(3,'Ajay','5th',45,32,78);
Insert Into Student_details Values(4,'Vijay','4th',36,78,32);
Insert Into Student_details Values(5,'Manoj','5th',12,22,67);
Insert Into Student_details Values(6,'Geeta','8th',21,65,43);
Insert Into Student_details Values(7,'Sita','4th',34,78,54);
Insert Into Student_details Values(8,'Reeta','9th',89,78,54);
Insert Into Student_details Values(9,'Arvind','12th',76,78,54);
Insert Into Student_details Values(10, 'Pankaj','11th',22,56,54);
Insert Into Student_details Values(11,'Anil','10th',34,78,54);
Select * from Student_details;

--------------------------------------Cursors--------------------------------------
/*
A cursor in SQL is a temporary work area created in system memory.
It allows you to process individual row returned by a query.
• A SQL cursor is a set of rows together with a pointer that identifies a current row.
A cursor can hold more than one row, but can process only one row at a time.
The set of rows the cursor holds is called the active set.
*/

/*
Cursors
1. Cursors pointer pick up the single row from the result.
2. Process the row.
3. After process pointer moves on next row.
4. It goes on until of last row of result.
*/

/*
Types of Cursors in SQL
There are the following two types of cursors in SQL:
* Implicit Cursor
* Explicit Cursor
1) Implicit Cursor:-
These types of cursors are generated and used by the system during the manipulation of a DML
query (INSERT, UPDATE and DELETE).
• An implicit cursor is also generated by the system when a single row is selected by a SELECT command.

2) Explicit Cursor:-
This type of cursor is generated by the user using a SELECT command.
# Main components of Cursors
Each cursor contains the followings 5 parts,
1. Declare Cursor: In this part we declare variables and return a set of values.
Example:
DECLARE EMP_CURSOR CURSOR For Select RolINo, Student_Name, Marks_eng, Marks_Math, Marks_Science From Student_details.
Above statement creates a cursor with name 'Emp_Cursor' and hold the resultset generated from select statement.
2. Open: This is the entering part of the cursor. At this stage pointer points no row.
3. Fetch: Used to retrieve the data row by row from a cursor.
4. Close: This is an exit part of the cursor and used to close a cursor.
5. Deallocate: In this part we delete the cursor definition and release all the system resources
associated with the cursor.
*/


/*
Types of cursors
Microsoft SQL Server supports the following 4 types of cursors.
# STATIC CURSOR : A static cursor populates the result set during cursor creation and the query result
  is cached for the lifetime of the cursor. A static cursor can move forward and backward.
# FAST FORWARD: This is the default type of cursor. It is identical to the static except that you can only scroll forward.
# DYNAMIC: In a dynamic cursor, additions and deletions are visible for others in the data source while the cursor is open.
# KEYSET : This is similar to a dynamic cursor except we can't see records others add. If another user
  deletes a record, it is inaccessible from our record set.
*/

/*
----------------Fetch Data from cursor----------------
There are total 6 methods to access data from cursor. They are as follows :
1. FIRST is used to fetch only the first row from cursor table.
2. LAST is used to fetch only last row from cursor table.
3. NEXT is used to fetch data in forward direction from cursor table.
4. PRIOR is used to fetch data in backward direction from cursor table.
5. ABSOLUTE n is used to fetch the exact nth row from cursor table.
6. RELATIVE N is used to fetch the data in incremental way as well as decremental way.
Syntax :
FETCH NEXT FROM cursor_name
FIRST FROM cursor_name
Fetch LAST FROM cursor_name
Fetch PRIOR FROM cursor_name
Fetch ABSOLUTE n FROM cursor_name
Fetch RELATIVE n FROM cursor_name
*/
------------------------------------------------------------------------------------
-- Select * from Student_details;


Declare @RollNO INT,
@Student_Name Varchar(100),
@Marks_Science INT,
@Marks_Eng INT,
@Marks_Math INT
Declare
@Marks_Total INT,
@Percentage INT

Declare student_cursor Cursor For Select RollNO, Student_Name, Marks_Science, Marks_Eng, Marks_Math
From Student_details;

Open student_cursor;

FETCH NEXT FROM student_cursor INTO @RollNO, @Student_Name, @Marks_Science, @Marks_Eng, @Marks_Math

While @@FETCH_STATUS=0
Begin
	Print Concat('Name: ',@Student_Name);
	Print Concat('Roll No:', @RollNO);
	Print Concat('Science:' ,@Marks_Science);
	Print Concat('Math :', @Marks_Math);
	Print Concat('English : ',@Marks_Eng);

	SET @Marks_Total = @Marks_Science+@Marks_Math+@Marks_Eng;
	Print Concat('Total : ',@Marks_Total);

	SET @Percentage = @Marks_Total/3;
	Print Concat('Percentage : ',@Percentage, '%');

	IF @Percentage > 80
	BEGIN
		Print 'Grade: A';
	END
	ELSE IF @Percentage > 60 AND @Percentage < 80
	BEGIN
		Print 'Grade: B';
	END
	ELSE
	BEGIN
		Print 'Grade: C';
	END
	Print '=======';

	FETCH NEXT FROM student_cursor INTO
	@ROllNO, @Student_Name, @Marks_Science, @Marks_Eng, @Marks_Math;
End
Close student_cursor;
Deallocate student_cursor;