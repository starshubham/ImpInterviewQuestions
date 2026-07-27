
------------------------------------ SQL TRANSACTION --------------------------------------------

/* 
	A Transaction is a sequence of operations performed(using one or more SQL Statements) on a database as a
	single logical unit of work. Either everything will be successful or everything will be rollbacks.
	Transactions may consist of a single read, write, delete or update operations or a combination of these.

*/
Create Table employeeTrans (
	emp_id int primary key,
	dept int,
	Age int,
	salary int
);

SELECT * FROM employeeTrans;
INSERT INTO employeeTrans (emp_id, dept, Age, salary) Values
	(101,1,21,20000),
	(102,2,25,30000),
	(103,3,27,40000),
	(104,3,24,50000);

--truncate table employeeTrans
/*
	Autocommit Transaction(By Default):
		Autocommit Transaction mode is the default transaction for the SQL Server. The successful statements are committed
		and the failed statements are rolled back immediately.
*/
SELECT * FROM employeeTrans;

INSERT INTO employeeTrans(emp_id,dept,Age,salary) Values(105,3,55,60000)
UPDATE employeeTrans SET Salary=40000 Where emp_id=101;
DELETE FROM employeeTrans Where emp_id=104
Select @@TRANCOUNT


/*
	IMPLICIT Transaction:
	1. In order to define an implicit transaction, we need to enable the IMPLICIT_TRANSACTIONS option.
	2. SQL Server automatically starts a transaction with any following statements:
	   ALTER TABLE, CREATE, DELETE, DROP, FETCH, GRANT, INSERT, OPEN, REVOKE, SELECT, TRUNCATE TABLE, and UPDATE.
	3. Use COMMIT(Permanent Save) or ROLLBACK(Cancel Trans) always.
*/
--Select * from employeeTrans;

SET IMPLICIT_TRANSACTIONS ON
--Insert
INSERT INTO employeeTrans(emp_id,dept,Age,salary) Values(105,2,45,30000)
--Update
UPDATE employeeTrans SET Salary=50000 Where emp_id=101;
--Delete
DELETE FROM employeeTrans Where emp_id=106

Select @@TRANCOUNT AS OpenTransactions
COMMIT

Select @@TRANCOUNT AS OpenTransactions

----------------------------------------

SET IMPLICIT_TRANSACTIONS ON
--Insert
INSERT INTO employeeTrans(emp_id,dept,Age,salary) Values(107,2,35,30000);
--Update
UPDATE employeeTrans SET Salary=30000 Where emp_id=101;
--Delete
DELETE FROM employeeTrans Where emp_id=106;

Select @@TRANCOUNT AS OpenTransactions
ROLLBACK

Select @@TRANCOUNT AS OpenTransactions

----------------------------------------
--Select * from employeeTrans;

SET IMPLICIT_TRANSACTIONS ON
--Insert
INSERT INTO employeeTrans(emp_id,dept,Age,salary) Values(109,2,35,30000);
--Update
UPDATE employeeTrans SET Salary=40000 Where emp_id=101;
--Delete
DELETE FROM employeeTrans Where emp_id=105;

Declare @choice int
Set @choice=1;
IF @choice=1
BEGIN
	Commit
End
Else
BEGIN
	Rollback
End

--Select * from employeeTrans;
/*
	EXPLICIT Transaction:
	1. We start to use the BEGIN TRANSACTION command because this statement identifies the starting point of 
	   the explicit transaction.
	2. Use COMMIT(Permanent Save) or ROLLBACK(Cancel Trans) always.
*/
--Select * from employeeTrans;

BEGIN TRANSACTION
--Insert
INSERT INTO employeeTrans(emp_id,dept,Age,salary) Values(111,3,33,50000);
--Update
UPDATE employeeTrans SET Salary=30000 Where emp_id=101;
--Delete
DELETE FROM employeeTrans Where emp_id=109;

Declare @ch int
Set @ch=1;
IF @ch=1
BEGIN
	Commit
End
Else
BEGIN
	Rollback
End


/*
	SAVEPOINT Command:
	1. SAVEPOINT is a point in a transaction when you can roll the transaction back to a certain point without rollback
	   the entire transaction.
	Syntax
	SAVE TRANSACTION SAVEPOINT_NAME

	The ROLLBACK command is used to undo a group of transactions.
	Syntax
	ROLLBACK TRANSACTION SAVEPOINT_NAME
*/
--Select * from employeeTrans;

BEGIN TRANSACTION
	INSERT Into employeeTrans(emp_id,dept,Age,salary) Values (112,2,60,60000)
		SAVE TRANSACTION DeletePoint
		Delete employeeTrans WHERE emp_id = 102;
		Delete employeeTrans WHERE emp_id = 103;
		Delete employeeTrans WHERE emp_id = 108;
		ROLLBACK TRANSACTION DeletePoint
	COMMIT