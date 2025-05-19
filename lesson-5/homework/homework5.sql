Drop table if exists Employees;
Create table Employees ( 
			EmployeeID INT Identity(1, 1) primary key,
			Name VARCHAR(50) NOT NULL,
			Department VARCHAR(50) NOT NULL,
			Salary DECIMAL(10,2) NOT NULL,
			HireDate DATE NOT NULL
			);	

INSERT INTO Employees (Name, Department, Salary, HireDate) 
	Values 
	('Alice', 'HR', 50000, '2020-06-15'),
    ('Bob', 'HR', 60000, '2018-09-10'),
    ('Charlie', 'IT', 70000, '2019-03-05'),
    ('David', 'IT', 80000, '2021-07-22'),
    ('Eve', 'Finance', 90000, '2017-11-30'),
    ('Frank', 'Finance', 75000, '2019-12-25'),
    ('Grace', 'Marketing', 65000, '2016-05-14'),
    ('Hank', 'Marketing', 72000, '2019-10-08'),
    ('Ivy', 'IT', 67000, '2022-01-12'),
    ('Jack', 'HR', 52000, '2021-03-29');


----------------------1-----------------------------

SELECT
		EmployeeID, Name, Salary,
		DENSE_RANK() over (ORDER BY Salary Desc) as [Salary Rank]
From Employees AS [Ranked Employees];

----------------------2-----------------------------
With RankedEmployees as (
	SELECT
		EmployeeID, Name, Salary,
		DENSE_RANK() over (ORDER BY Salary Desc) as [Salary Rank]
	From Employees)

Select 
	[Salary Rank],
	Salary
FROM RankedEmployees
GROUP BY [Salary Rank], Salary
Having COUNT(*) >1;

----------------------3-----------------------------
WITH RankedSalaries as ( 
		SELECT 
			EmployeeID,
			Name,
			Department,
			Salary,
			Rank() over (partition by Department Order by Salary Desc) as SalaryRank
			From Employees)
Select 
	Department,
	Name,
	SalaryRank
From RankedSalaries
WHERE SalaryRank <=2
Order by Department, Salary Desc;


----------------------4-----------------------------
WITH RankedSalaries as ( 
		SELECT 
			EmployeeID,
			Name,
			Department,
			Salary,
			Rank() over (partition by Department Order by Salary ASC) as SalaryRank
			From Employees)
Select 
	Department,
	Name,
	Salary
From RankedSalaries
WHERE SalaryRank = 1
Order by Department;



----------------------5-----------------------------

Select EmployeeID, Name, Department, Salary,
		Sum(Salary) over (Partition by Department order by EmployeeID) as Total
From Employees
Order by Department, EmployeeID;

----------------------6-----------------------------

SELECT DISTINCT Department,
	Sum(Salary) over (Partition by Department) as TotalSalary
from Employees
Order by Department;

----------------------7-----------------------------
Select Distinct Department,
	Avg(Salary) over (Partition by Department) as [Average Salary]
From Employees
Order by department;

----------------------8-----------------------------

SELECT EmployeeID, Name, Salary,
	Avg(Salary) over (
		order by EmployeeID
		Rows Between 1 preceding and 1 FOLLOWING )
		as [Moving Average Salary]

From Employees
Order by EmployeeID;


----------------------9-----------------------------

Select 
	Sum(Salary) as [Total Salary of last 3 hired]
FROM (SELECT Salary 
		FROM Employees
		order by HireDate desc
		offset 0 rows fetch next 3 rows only) 
		as Last_3

----------------------10-----------------------------




----------------------11-----------------------------

SELECT EmployeeID, Name, Salary, 
		Avg(Salary) over (
			order by EmployeeID
			Rows between UNBOUNDED PRECEDING AND CURRENT ROW) AS [Running Avg salary]
FROM Employees
order by EmployeeID;

----------------------12-----------------------------

SELECT EmployeeID, Name, Salary,
		max(Salary) over (order by EmployeeID rows between 2 preceding and 2 following) as [max Salary in Window]
from Employees
order by EmployeeID

----------------------13-----------------------------

SELECT EmployeeID, Name, Department, Salary, 
			(Salary * 100 / sum(Salary) over (partition by Department)) as [Percent Contribution]
from Employees
order by Department, EmployeeID;