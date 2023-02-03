-- Chapter 3 : Joins

USE TSQL2012;

-- Exercises 1-1

-- 1.1. Write a query that generates five copies of each employee row.

-- Solution
SELECT EMP.empid, EMP.firstname, EMP.lastname, NUM.n
FROM HR.Employees AS EMP CROSS JOIN dbo.Nums AS NUM 
WHERE NUM.n <= 5;

---------------------------------------------------------------------------------------------------------------------------------

-- 1.2. Write a query that returns a row for each employee and day in the range June 12, 2009 through June 16, 2009.

-- Solution
SELECT EMP.empid, DATEADD(DAY, NUM.n - 1, '20090612') AS dt
FROM HR.Employees AS EMP CROSS JOIN dbo.Nums AS NUM
WHERE NUM.n <= DATEDIFF(DAY, '20090612', '20090616') + 1
ORDER BY EMP.empid, dt;

---------------------------------------------------------------------------------------------------------------------------------

-- 2. Return United States customers, and for each customer return the total number of orders and total quantities.

-- Solution
SELECT C.custid, COUNT(DISTINCT O.orderid) AS numorders, SUM(OD.qty) AS totalqty 
FROM Sales.Customers AS C INNER JOIN Sales.Orders AS O ON C.custid = O.custid
INNER JOIN Sales.OrderDetails AS OD ON O.orderid = OD.orderid
WHERE C.country LIKE 'USA' 
GROUP BY C.custid
ORDER BY C.custid;

---------------------------------------------------------------------------------------------------------------------------------

-- 3. Return customers and their orders, including customers who placed no orders.

-- Solution
SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C LEFT OUTER JOIN Sales.Orders AS O ON C.custid = O.custid;

---------------------------------------------------------------------------------------------------------------------------------

-- 4. Return customers who placed no orders.

-- Solution
SELECT C.custid, C.companyname
FROM Sales.Customers AS C LEFT OUTER JOIN Sales.Orders AS O ON C.custid = O.custid
WHERE O.orderid IS NULL;

---------------------------------------------------------------------------------------------------------------------------------

-- 5. Return customers with orders placed on February 12, 2007, along with their orders.

-- Solution
SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C INNER JOIN Sales.Orders AS O ON C.custid = O.custid
WHERE O.orderdate = '20070212';

---------------------------------------------------------------------------------------------------------------------------------

-- 6. Return customers with orders placed on February 12, 2007, along with their orders. 
--    Also return customers who didn't place orders on February 12, 2007.

-- Solution
SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C LEFT OUTER JOIN Sales.Orders AS O ON C.custid = O.custid AND O.orderdate = '20070212';

---------------------------------------------------------------------------------------------------------------------------------

-- 7. Return all customers, and for each return a Yes/No value 
--    depending on whether the customer placed an order on February 12, 2007.

-- Solution
SELECT C.custid, C.companyname, 
CASE 
WHEN O.orderid IS NULL THEN 'No'
WHEN O.orderid IS NOT NULL THEN 'Yes'
END AS HasOrderOn20070212
FROM Sales.Customers AS C LEFT OUTER JOIN Sales.Orders AS O ON C.custid = O.custid AND O.orderdate = '20070212'
ORDER BY C.custid;

---------------------------------------------------------------------------------------------------------------------------------

