CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);

-----------------1-------------

SELECT c.CustomerID, c.CustomerName
FROM Customers as c
LEFT JOIN Orders as o ON c.CustomerID=o.CustomerID;

-----------------2-------------

SELECT c.CustomerID, c.CustomerName
FROM Customers as c
LEFT JOIN Orders as o ON c.CustomerID=o.CustomerID
WHERE OrderID is NULL;

-----------------3-------------

SELECT o.OrderID, p.ProductID, od.Quantity
FROM Orders as o
JOIN OrderDetails as od ON o.OrderID = od.OrderID
JOIN Products as p ON od.ProductID=p.ProductID;

-----------------4-------------

SELECT c.CustomerID, c.CustomerName
FROM Customers as c
JOIN Orders as o ON c.CustomerID=o.CustomerID
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(o.OrderID)>1;

-----------------5-------------
SELECT od.OrderID, p.ProductName, MAX(od.Price) as MaxPrice
FROM OrderDetails od
Join Products as p ON od.ProductID=p.ProductID
GROUP BY od.OrderID, p.ProductName;
-----------------6-------------
SELECT c.CustomerID, c.CustomerName, o.OrderID, MAX(o.OrderID) as LatestOrderDate
FROM Customers as c
JOIN Orders as o ON c.CustomerID=o.CustomerID
GROUP BY c.CustomerID, c.CustomerName, o.OrderID;

-----------------7-------------
SELECT DISTINCT c.CustomerID, c.CustomerName
FROM Customers as c
JOIN Orders as o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON od.OrderID = od.OrderID
Join Products as p on od.ProductID = p.ProductID
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(DISTINCT case when p.Category != 'Electronics' THEN p.Category END) =0;

-----------------8-------------
SELECT DISTINCT c.CustomerID, c.CustomerName
FROM Customers as c
JOIN Orders as o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON od.OrderID = od.OrderID
Join Products as p on od.ProductID = p.ProductID
WHERE p.Category= 'Stationery';


-----------------9-------------
SELECT DISTINCT c.CustomerID, c.CustomerName, COALESCE(SUM(od.Quantity*od.Price), 0) as TotalSpent
FROM Customers as c
left join Orders as o on c.CustomerID=o.CustomerID
left join OrderDetails as od ON o.OrderID = od.OrderID
Group by c.CustomerID, c.CustomerName;

