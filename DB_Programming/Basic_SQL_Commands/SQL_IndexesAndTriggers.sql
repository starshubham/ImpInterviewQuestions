
-----------------------------------INDEXES---------------------------------------------

/*
Indexes are special data structures associated with tables or views that help speed up the query. Indexes increases the search performance.
Search becomes faster because of Balance tree structure. Internally it creates Node and Leaf Nodes to reach to the data quickly.

WHAT IS INDEX?
* An index is a pointer to  data in a table.
* An index in a database is very similiar to an index in the back of a book.
* An index helps to speed up SELECT queries and WHERE clauses.
* Indexes can be created or dropped with no effect on the data.

						TYPES OF INDEXES
1) CLUSTERED INDEX:-
	* Each table has only one clustered index because data rows can be only sorted in one order.
	* A clustered index is a special index which physically orders the data according to the indexed columns.
	* The leaf nodes of the index store the data for the rest of the columns in the table.

2) NON-CLUSTERED INDEX:-
	* A table may have one or more non clusterd.
	* A non-clustered index is just like the index of a book.
	* It points back to the actual page that contains the data. (In other words, it points back to the clustered index)
*/

Create Table EmployeesIndex
(
	Id int primary key identity,
	[Name] nvarchar(50),
	Email nvarchar(50),
	Department nvarchar(50)
)

SET NOCOUNT ON
Declare @counter int = 1

While(@counter <= 10000)
Begin
	Declare @Name nvarchar(50) = 'ABC ' + RTRIM(@counter)
	Declare @Email nvarchar(50) = 'abc' + RTRIM(@counter) + '@startech.com'
	Declare @Dept nvarchar(10) = 'Dept ' + RTRIM(@counter)

	Insert into EmployeesIndex values (@Name, @Email, @Dept)

	Set @counter = @counter +1

	If(@Counter%1000 = 0)
		Print RTRIM(@Counter) + ' rows inserted'
End

----In SQL Server Management Studio click on Include Actual Execution Plan icon and then execute the following query
Select * from EmployeesIndex where Id = 9320

/*
Notice, the operation is Clustered Index Seek, meaning the database engine is using the clustered index on the employee Id 
column to find the employee row with Id = 9320

Number of rows read = 1
Actual number of rows for all executions = 1
Number of rows read, is the number of rows SQL server has to read to produce the query result. 
In our case Employee Id is unique, so we expect 1 row and that is represented by Actual number of rows for all executions.

With the help of the index, SQL server is able to directly read that 1 specific employee row we want. 
Hence, both, Number of rows read and Actual number of rows for all executions is 1.

So the point is, if there are thousands or even millions of records, SQL server can easily and quickly find the data 
we are looking for, provided there is an index that can help the query find data.

----------Clustered Index Scan----------
In this example, there is a clustered index on EmployeeId column, so when we search by employee id, 
SQL Server can easily and quickly find the data we are looking for. What if we serach by Employee name? 
At the moment, there is no index on the Name column, so there is no easy way for sql server to find the data 
we are looking for. SQL server has to read every record in the table which is extremely inefficient 
from performace standpoint. 
Execute the following query with Include Actual Execution Plan turned ON
*/

Select * from EmployeesIndex Where Name = 'ABC 9320'

/*
Notice, the operation is Clustered Index Scan. Since there is no proper index to help this query, 
the database engine has no other choice than to read every record in the table. This is exactly the reason 
why Number of rows read is 1 million, i.e every row in the table

Number of rows read = 1000000
Actual number of rows for all executions = 1

How many rows are we expecting in the result? Well, only one row because there is only one employee whose 
Name = 'ABC 932000'. So, to produce this 1 row as the result, SQL server has to read all the 1 million rows 
from the table because there is no index to help this query. This is called Index Scan and in general, 
Index Scans are bad for performance.
*/

/*	
---------Non-Clustered Index in SQL Server-----------

This is when we create a non-clustered index on the Name column.

In an non-clusterd index we do not have table data. We have key values and row locators.

We created a non-clustered index on the Name column, so the key values, in this case Employee names are sorted 
and stored in alphabetical order.

The row locators at the bottom of the tree contain Employee Names and cluster key of the row. In our example, 
Employee Id is the cluster key.
*/
USE [DB_Programming]
GO
CREATE NONCLUSTERED INDEX IX_EmployeesIndex_Name
ON [dbo].[EmployeesIndex] ([Name])
GO

----Execute the following query again with Include Actual Execution Plan turned ON
Select * from EmployeesIndex Where Name = 'ABC 9320'

/*
						NON CLUSTERED INDEX
* A non-clustered index doesn't sort the physical data inside the table.
* In fact, a non-clustered index is stored at one place and table data is stored in another place.
* This is similar to a textbook where the book content is located in one place and the index is located in another.
* This allows for more than one non-clustered index per table.

						SQL SERVER UNIQUE INDEX
* A unique index ensures the index key columns do not contain any duplicate values.
* A unique index may consist of one or many columns.
* A unique index can be clustered or non-clustered.

						WHERE TO APPLY INDEX
* Indexes are meant to speed up the performance of a database, so use indexing whenever it significantly improves the 
performance of your database.
* Check query and find reason for slow performance.
* Find column in query which is used frequently for searching.

						DISADVANTAGES OF INDEXING
* In case of update(change in indexed column) and delete a record, the database might need to move the entire row into
row into a new position to keep the rows in sorted order.

*/



------------------------------------- TRIGGERS -------------------------------------

/*
								/* What is Trigger */
* Trigger is an Event-driven T-SQL Programming block. It runs automatically when a particular event occurs.
* SQL Server triggers are special stored procedures that are executed automatically in response to the database object, 
  database, and server events. SQL Server provides three type of triggers:

1) Data manipulation language (DML) triggers which are invoked automatically in response to INSERT, UPDATE, and DELETE events against tables.
2) Data definition language (DDL) triggers which fire in response to CREATE, ALTER, and DROP statements. DDL triggers also 
   fire in response to some system stored procedures that perform DDL-like operations.
3) Logon triggers which fire in response to LOGON events

INSERT, UPDATE, DELETE --> DML Command --> DML TRIGGER
CREATE, ALTER,  DROP   --> DDL Command --> DDL TRIGGER

				/* Introduction to SQL Server CREATE TRIGGER statement */
The CREATE TRIGGER statement allows you to create a new trigger that is fired automatically whenever an event 
such as INSERT, DELETE, or UPDATE occurs against a table.

The following illustrates the syntax of the CREATE TRIGGER statement:

CREATE TRIGGER [schema_name.]trigger_name
ON table_name
AFTER  {[INSERT],[UPDATE],[DELETE]}
[NOT FOR REPLICATION]
AS
{sql_statements}

The event is listed in the AFTER clause. The event could be INSERT, UPDATE, or DELETE. A single trigger can fire in response 
to one or more actions against the table.
The NOT FOR REPLICATION option instructs SQL Server not to fire the trigger when data modification is made as part of a 
replication process.
The sql_statements is one or more Transact-SQL used to carry out actions once an event occurs.

						/* “Virtual” tables for triggers: INSERTED and DELETED */
SQL Server provides two virtual tables that are available specifically for triggers called INSERTED and DELETED tables. 
SQL Server uses these tables to capture the data of the modified row before and after the event occurs.

The following table shows the content of the INSERTED and DELETED tables before and after each event:

DML event	|	INSERTED table holds			|	DELETED table holds
INSERT		|	rows to be inserted				|	empty
UPDATE		|	new rows modified by the update	|	existing rows modified by the update
DELETE		|	empty							|	rows to be deleted

*/

select * from Employees;

/************ Audit Table ****************/
CREATE TABLE Employees_Audit (
Emp_ID INT,
Inserted_By Varchar(100)
)
Go

/************ Creating TRIGGER For INSERT EVENT ****************/
CREATE TRIGGER TRG_Insert_Audit
On Employees
FOR INSERT
AS
BEGIN
	Declare @emp_ID int

	Select @emp_ID = Emp_ID from inserted
	insert into Employees_Audit(Emp_ID, Inserted_By)
	Values (@emp_ID, ORIGINAL_LOGIN())

	PRINT 'Insert Trigger Executed Successfully'
END
GO

--------------- Insert a new data in Employees Table ------------------------
INSERT INTO Employees(Name,Age,Address,Salary,Dept_ID) Values
	('Arjun',24,'Jammu',400000,3)

Select * from Employees;
Select * from Employees_Audit;


CREATE TRIGGER TRG_Delete_Rule
ON Employees
FOR DELETE
AS
BEGIN
	RollBack
	PRINT '*****************************************************'
	PRINT 'You can not delete records from this table'
	PRINT '*****************************************************'
END
GO

Delete from Employees Where Emp_ID = 14;

SELECT * From Employees;


/************ DDL TRIGGER ****************/
CREATE TRIGGER Trg_SampleDB
ON DATABASE
FOR CREATE_TABLE
AS
BEGIN
	ROLLBACK
	PRINT 'You are not allowed to create tables'
END

Create Table Tbl1 (ID INT)

-- DROP TRIGGER Trg_SampleDB ON DATABASE;
/************ List All Triggers ****************/
Select * from sys.triggers


/************ Find the discription of Triggers ****************/
Select * from sys.sql_modules
WHERE OBJECT_ID = object_id('TRG_Delete_Rule')
Go


/************ DISABLE / ENABLE Trigger ****************/

DISABLE TRIGGER TRG_Delete_Rule On Employees
GO

ENABLE TRIGGER TRG_Delete_Rule On Employees
GO


/************ REMOVE TRIGGER ****************/
DROP TRIGGER TRG_Delete_Rule
GO

DROP TRIGGER TRG_Insert_Rule
GO