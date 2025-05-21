--------------------1-----------------
drop table if exists Groupings;
CREATE TABLE Groupings (
					Step_number INT NOT NULL,
					Status varchar(10) NOT NULL);


insert into Groupings (Step_number, Status)
Values 
		(1, 'Passed'),
		(2, 'Passed'),
		(3, 'Passed'),
		(4, 'Passed'),
		(5, 'Failed'),
		(6, 'Failed'),
		(7, 'Failed'),
		(8, 'Failed'),
		(9, 'Failed'),
		(10, 'Passed'),
		(11, 'Passed'),
		(12, 'Passed');


SELECT 
    MIN(Step_Number) AS Min_Step_Number,
    MAX(Step_Number) AS Max_Step_Number,
    Status,
    COUNT(*) AS Consecutive_Count
FROM (
    SELECT 
        Step_Number,
        Status,
        SUM(CASE 
            WHEN COALESCE((
                SELECT Status 
                FROM Groupings g2 
                WHERE g2.Step_Number = g1.Step_Number - 1
            ), '') <> g1.Status 
            THEN 1 
            ELSE 0 
        END) OVER (ORDER BY Step_Number) AS GroupID
    FROM Groupings g1
) AS Grouped
GROUP BY Status, GroupID
ORDER BY Min_Step_Number;





--------------------2-----------------
DROP TABLE IF EXISTS [dbo].[EMPLOYEES_N];
CREATE TABLE [dbo].[EMPLOYEES_N]
(
    [EMPLOYEE_ID] [int] NOT NULL,
    [FIRST_NAME] [varchar](20) NULL,
    [HIRE_DATE] [date] NOT NULL
);

INSERT INTO [dbo].[EMPLOYEES_N] (EMPLOYEE_ID, FIRST_NAME, HIRE_DATE)
VALUES
    (1, 'John', '1975-06-15'),
    (2, 'Jane', '1976-03-22'),
    (3, 'Alice', '1977-09-10'),
    (4, 'Bob', '1979-11-30'),
    (5, 'Carol', '1980-07-14'),
    (6, 'David', '1982-04-25'),
    (7, 'Eve', '1983-01-12'),
    (8, 'Frank', '1984-08-19'),
    (9, 'Grace', '1985-05-05'),
    (10, 'Hank', '1990-10-20'),
    (11, 'Ivy', '1997-12-01');

WITH AllYears AS (
    SELECT 1975 AS yr
    UNION ALL
    SELECT yr + 1
    FROM AllYears
    WHERE yr < 2025
),
HireYears AS (
    SELECT DISTINCT YEAR(HIRE_DATE) AS hire_year
    FROM EMPLOYEES_N
),
NonHireYears AS (
    SELECT yr
    FROM AllYears
    LEFT JOIN HireYears ON AllYears.yr = HireYears.hire_year
    WHERE HireYears.hire_year IS NULL
),
GroupedYears AS (
    SELECT yr,
           yr - ROW_NUMBER() OVER (ORDER BY yr) AS grp
    FROM NonHireYears
),
YearRanges AS (
    SELECT MIN(yr) AS start_year,
           MAX(yr) AS end_year
    FROM GroupedYears
    GROUP BY grp
)
SELECT CAST(start_year AS VARCHAR) + ' - ' + CAST(end_year AS VARCHAR) AS Years
FROM YearRanges
ORDER BY start_year;
