-- Q1
SELECT CustomerName FROM Customers;

-- Q2
SELECT ProductName, Price FROM Products WHERE Price < 15;

-- Q3
SELECT FirstName, LastName FROM Employees;

-- Q4
SELECT * FROM Orders WHERE YEAR(OrderDate) = 1997;

-- Q5
-- No UnitsInStock column in this Products table. Query skipped.

-- Q6
SELECT c.CustomerName, e.FirstName, e.LastName
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Employees e ON o.EmployeeID = e.EmployeeID;

-- Q7
SELECT Country, COUNT(*) AS CustomerCount FROM Customers GROUP BY Country;

-- Q8
SELECT c.CategoryName, AVG(p.Price) AS AvgPrice
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName;

-- Q9
SELECT e.FirstName, e.LastName, COUNT(*) AS OrderCount
FROM Orders o
JOIN Employees e ON o.EmployeeID = e.EmployeeID
GROUP BY e.EmployeeID;

-- Q10
SELECT p.ProductName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierName = 'Exotic Liquid';

-- Q11
SELECT p.ProductName, SUM(od.Quantity) AS TotalOrdered
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY od.ProductID
ORDER BY TotalOrdered DESC
LIMIT 3;

-- Q12
SELECT c.CustomerName, SUM(od.Quantity * p.Price) AS TotalValue
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY c.CustomerID
HAVING TotalValue > 10000;

-- Q13
SELECT o.OrderID, SUM(od.Quantity * p.Price) AS OrderValue
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY o.OrderID
HAVING OrderValue > 2000;

-- Q14
SELECT c.CustomerName
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY o.OrderID
HAVING SUM(od.Quantity * p.Price) = (
    SELECT MAX(TotalValue)
    FROM (
        SELECT SUM(od2.Quantity * p2.Price) AS TotalValue
        FROM Orders o2
        JOIN OrderDetails od2 ON o2.OrderID = od2.OrderID
        JOIN Products p2 ON od2.ProductID = p2.ProductID
        GROUP BY o2.OrderID
    ) AS totals
);

-- Q15
SELECT ProductName FROM Products WHERE ProductID NOT IN (SELECT DISTINCT ProductID FROM OrderDetails);
