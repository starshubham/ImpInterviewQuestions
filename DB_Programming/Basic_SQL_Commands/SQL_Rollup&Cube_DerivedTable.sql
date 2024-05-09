Use DB_Programming
GO

--------------------------------------- SQL-Rollup & Cube --------------------------------------------------

Create Table RollupTest (
	id		INT PRIMARY KEY,
	name	VARCHAR(100),
	gender	VARCHAR(50),
	salary	INT,
	department	VARCHAR(50)
)

INSERT INTO RollupTest(id, name, gender, salary, department) Values
	(1, 'Moly', 'Male', 5000, 'Sales'),
	(2, 'Jimmy', 'Female', 6000, 'HR'),
	(3, 'Katal', 'Female', 7500, 'IT'),
	(4, 'Lenda', 'Male', 6500, 'Marketing'),
	(5, 'Shnana', 'Female', 5500, 'Finance'),
	(6, 'Mike', 'Male', 8000, 'Sales'),
	(7, 'Tony', 'Male', 7200, 'HR'),
	(8, 'Lorry', 'Female', 6600, 'IT'),
	(9, 'Kene', 'Female', 5400, 'Marketing'),
	(10, 'Hary', 'Female', 6300, 'Finance'),
	(11, 'Potter', 'Male', 5700, 'Sales'),
	(12, 'Zim Kerry', 'Male', 7000, 'HR'),
	(13, 'Mikel', 'Female', 7100, 'IT'),
	(14, 'Jakson', 'Female', 6800, 'Marketing'),
	(15, 'Warden', 'Male', 5000, 'Finance');

/*
ROLLUP:
	ROLLUP operators let you extend the functionality of GROUP BY Clauses by calculating sub-totals
	and grand totals for a set of columns.
*/
Select * from RollupTest;
Select department, Sum(salary) from RollupTest Group By department;
Select department, Sum(salary) from RollupTest Group By ROLLUP(Department);
Select COALESCE(department,'Total'), Sum(salary) from RollupTest Group By ROLLUP(Department);

Select COALESCE(department,'Total'),gender, Sum(salary) from RollupTest Group By ROLLUP(Department,gender);


/*
SQL CUBE:
	The CUBE operator is similar in functionality to the ROLLUP operator; however, the CUBE operator can calculate sub-totals
	and grand totals for all permutations of the columns specified in it.
*/
Select COALESCE(department,'Total'),gender, Sum(salary) from RollupTest Group By CUBE(Department,gender);