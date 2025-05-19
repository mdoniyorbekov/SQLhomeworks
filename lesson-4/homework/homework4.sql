-----Task 1

drop table if exists [dbo].[TestMultipleZero];
CREATE TABLE [dbo].[TestMultipleZero]
(
    [A] [int] NULL,
    [B] [int] NULL,
    [C] [int] NULL,
    [D] [int] NULL
);
GO

INSERT INTO [dbo].[TestMultipleZero](A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);

select A, B, C, D
from [dbo].[TestMultipleZero]
where not (A=0 and B=0 and C=0 and D=0);


-----Task 2
DROP TABLE IF EXISTS TestMAx;
CREATE TABLE TestMax
(
    Year1 INT
    ,Max1 INT
    ,Max2 INT
    ,Max3 INT
);
GO
 
INSERT INTO TestMax 
VALUES
    (2001,10,101,87)
    ,(2002,103,19,88)
    ,(2003,21,23,89)
    ,(2004,27,28,91);

SELECT Year1,
	CASE
		WHEN Max1 >= Max2 and Max1>=Max3 THEN Max1
		WHEN Max2 >= Max1 and Max2>=Max3 THEN Max2
		ELSE Max3
	END as [Max Value]
FROM TestMax;



-----Task 3

DROP TABLE IF EXISTS EmpBirth;
CREATE TABLE EmpBirth
(
    EmpId INT  IDENTITY(1,1) 
    ,EmpName VARCHAR(50) 
    ,BirthDate DATETIME 
);
 
INSERT INTO EmpBirth(EmpName,BirthDate)
SELECT 'Pawan' , '12/04/1983'
UNION ALL
SELECT 'Zuzu' , '11/28/1986'
UNION ALL
SELECT 'Parveen', '05/07/1977'
UNION ALL
SELECT 'Mahesh', '01/13/1983'
UNION ALL
SELECT'Ramesh', '05/09/1983';

Select EmpID, EmpName, BirthDate
FROM EmpBirth
WHERE MONTH(BirthDate)=5 and (DAY(BirthDate) BETWEEN 7 and 15);


-----Task 4

drop table if exists letters;
create table letters
(letter char(1));

insert into letters
values ('a'), ('a'), ('a'), 
  ('b'), ('c'), ('d'), ('e'), ('f');

SELECT letter From letters
order by
	case 
		when letter = 'b' then 0
		else 1
	end, letter;
