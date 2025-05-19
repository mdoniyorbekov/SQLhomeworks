drop table if exists Departments;
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10, 2),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50),
    EmployeeID INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Insert sample data
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(101, 'IT'),
(102, 'HR'),
(103, 'Finance'),
(104, 'Marketing');

INSERT INTO Employees (EmployeeID, Name, DepartmentID, Salary) VALUES
(1, 'Alice', 101, 60000),
(2, 'Bob', 102, 70000),
(3, 'Charlie', 101, 65000),
(4, 'David', 103, 72000),
(5, 'Eva', NULL, 68000);

INSERT INTO Projects (ProjectID, ProjectName, EmployeeID) VALUES
(1, 'Alpha', 1),
(2, 'Beta', 2),
(3, 'Gamma', 1),
(4, 'Delta', 4),
(5, 'Omega', NULL);


-----------1-------------------

SELECT Employees.EmployeeID, Employees.Name, Departments.DepartmentName
FROM Employees
INNER JOIN Departments on Employees.DepartmentID=Departments.DepartmentID;

-----------2-------------------

SELECT Employees.EmployeeID, Employees.Name, Departments.DepartmentName
FROM Employees
LEFT JOIN Departments on Employees.DepartmentID=Departments.DepartmentID;

-----------3-------------------
SELECT Employees.EmployeeID, Employees.Name, Departments.DepartmentName
FROM Employees
RIGHT JOIN Departments on Employees.DepartmentID=Departments.DepartmentID;


-----------4-------------------

SELECT Employees.EmployeeID, Employees.Name, Departments.DepartmentName
FROM Employees
FULL OUTER JOIN Departments on Employees.DepartmentID=Departments.DepartmentID;

-----------5-------------------

SELECT d.DepartmentName, COALESCE(SUM(e.Salary), 0) AS Total_Salary
FROM Departments d
LEFT JOIN Employees e ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName;

-----------6-------------------
select Departments.DepartmentName, Projects.ProjectName
From Departments
cross join Projects;

-----------7-------------------

Select Employees.EmployeeID, Employees.Name, Departments.DepartmentName, Projects.ProjectName
FROM Employees
Left join Departments on Employees.EmployeeID = Departments.DepartmentID
Left join Projects on Employees.EmployeeID = Projects.EmployeeID;