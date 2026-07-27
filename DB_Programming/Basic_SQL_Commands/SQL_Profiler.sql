
------------------------------------- SQL PROFILER ---------------------------------------------------------

/* 
What is SQL profiler? 
--An SQL server profiler is a tool for tracing ,Recreating and troubleshooting problems in mssql server 
--It is like a dashboard that shows the health of an instance of mssql server.
--It is used to trace activities and operations executed on a specific SQL Server database engine or analysis service to be analyzed later.

SQL SERVER IS RESPONSIBLE FOR TWO MAIN OPERATIONS:-
--TRACING: It can monitor all operations executed over an instance
--REPLAY: It can rerun all operations logged in a trace later

When you use sql profiler?
 - To monitor  the activity in your  SQL Server Instance. 
 - To check the overall health/performance of your database. 
 - SQL profiler gives you the ability to monitor anything from regular user activity /transactions to locks/ deadlocks and system errors. 
 - To check poor performance of query
 - To perform auditing on your SQL Server instance. You have the ability to define loggin/logout.
 
 -------------------- Points To Remember -------------------------------------------------
 * Capture only required event not all: Capturing All events will make table really large and more importantly make the display in SQL 
   profiler almost unreadable. 
 * Use filters: To limit the amount of data always use filters. Possible filters can be based on the user name, server name,application name,etc.
 * Run SQL profiler on a remote system: SQL profiler can use a lot of memory. It's always best to run on a remote system.
 * Save Trace events to a rollover file: Saving trace data to a file is a little bit faster and easier to manage than writing it to a database table.
 * Create Templates for Quick access: Microsoft provides some templates, but it's always a good idea to have a few of your own defined as well.
 */

SELECT * FROM employee_info
 -- CHECK MY TRACE TABLE ITS CREATED OR NOT
 -- IF YOU WANT CREATE TEMPLATE GO SQL PROFILER AFTER CHECK EVENTS WHICH EVENT YOU WANT
 -- YOU CAN USE FILTER ALSO HEAR USE LIKE KEY WORD ,IF U WANT SINGL DATA BASE MONITORING YOU CAN USE FILTER FOR FILTER ENABLE USE TUNING TEMPLATE
 -- THEN TXT DATA THEN LIKE OPTION ISTHERE USE IT FOR FILTER TO TABLE OR DATABASE OR KEYWORD
 -- FILTER Table
SELECT * FROM employee_info
SELECT * FROM Employees_Audit;  
Select * from Dept;		-------------ITS NOT SHOWING ON SQL PROFIL BECAUSE HERE WE USE FILTER

Select * from Student_details; 

/*
								EVENTS SELECTION
	An event is an activity that occured on your SQL Server database.

	EVENT					| DESCRIPTION
	RPC:Completed			| Indicates that a remote procedure call has completed
	SQL:BatchCompleted		| Indicates that a Transact-SQL batch has completed.
	Deadlock graph			| Provides and XML description of each deadlock event, Lock:Deadlock.
	Audit Login				| Indicates that a user has successfully logged in to the SQL Server instance either as a brand new connection
							| or one that was reused from a connection pool.
	Audit Logout			| Indicates that a user has successfully logged out of the SQL Server instance  either as a brand new connection
							| or one that was reused from a connection pool.


								SQL SERVER PROFILER DATA COLUMNS
	A data column is a piece of data that describes some part of an event.

	EVENT					| DESCRIPTION
	TextData				| Text of the batch of statements entered. i.e. a T-SQL command.
	LoginName				| Name of the user who that executed the statement, either a SQL or Windows Login.
	CPU						| Amout of CPU in milliseconds used by the statement.
	Reads					| Number of Pages read I/O caused by the statement.
	Writes					| Number of Pages Write I/O caused by the statement.
	Duration				| Amount of time taken in miliseconds for the statement to complete.
	SPID					| ID of the session on which the event occured.
	StartTime				| Start time of the event.
	EndTime					| End time of the event.
	DatabaseName			| Name of the database in which the statement is running.
	DBID					| Database identifier in which the statement is running.
	HostName				| Name of the computer on which the client who is executing the statement is running.
	ServerName				| Name of the SQL instance being traced.
*/