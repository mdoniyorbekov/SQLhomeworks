use lesson3;

drop table if exists Employees;
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

drop table if exists Orders;
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);

drop table if exists Products;
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);


Select * 
	from (
		select department, Avg(Salary) as [Average Salary],
			case 
				when Avg(Salary) > 80000 Then 'High'
				when Avg(Salary) Between 50000 and 80000 Then 'Medium'
				else 'Low'
			End as [Salary Category],
			rank() over (order by avg(Salary) desc
			) as [Department Rank]
			
	from (select top 10 percent * from Employees order by Salary Desc) as [Top Employees]
		group by Department) as [Department Summmary]

	where [Department Rank]>2 and [Department Rank]<=7
	order by [Average Salary] desc;


Select 
	case 
		when Status IN ('Shipped', 'Delivered') Then 'Completed'
		when Status = 'Pending' then 'Pending'
		when Status = 'Cancelled' then 'Cancelled'
	End as [Order Status],
	COUNT(*) as [Total orders],
	sum(TotalAmount) as [Total Revenue]
from orders
where OrderDate between '2023-01-01' and '2023-12-31'
group by 
	case 
		when Status IN ('Shipped', 'Delivered') Then 'Completed'
		when Status = 'Pending' then 'Pending'
		when Status = 'Cancelled' then 'Cancelled'
	End
Having sum(TotalAmount)>50000
order by [Total Revenue] desc;

select distinct Category from Products;
select Top 1 * from Products
order by Price Desc;

Select ProductID, ProductName, Category, Stock, IIF(Stock = 0, 'Out of Stock', IIF(Stock Between 1 and 10, 'Low Stock', 'In Stock')) 
as [Inventory Status]
from Products
Order by Price desc
offset 5 rows;