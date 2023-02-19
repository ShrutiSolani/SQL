-- Chapter 4 Subqueries

-- Exercies

USE TSQL2012;

-- 1. Write a query that returns all orders placed on the last day of activity that can be found in the Orders table.

-- Solution

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate = (SELECT MAX(orderdate) FROM Sales.Orders);

---------------------------------------------------------------------------------------------------------------------------------

-- 2. Write a query that returns all orders placed by the customer(s) who placed the highest number of orders.
--	  Note that more than one customer might have the same number of orders.

-- Solution

SELECT custid, orderid, orderdate, empid
FROM Sales.Orders
WHERE custid IN (
	SELECT TOP(1) WITH TIES custid
	FROM Sales.Orders
	GROUP BY custid
	ORDER BY COUNT(*) DESC
	
);

---------------------------------------------------------------------------------------------------------------------------------

-- 3. Write a query that returns employees who did not place orders on or after May 1, 2008.

-- Solution

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE empid NOT IN (
	SELECT empid
	FROM Sales.Orders
	WHERE orderdate >= '20080501'
);

---------------------------------------------------------------------------------------------------------------------------------

-- 4. Write a query that returns countries where there are customers but not employees.

-- Solution

SELECT DISTINCT country
FROM Sales.Customers
WHERE country NOT IN (
	SELECT country
	FROM HR.Employees
);

---------------------------------------------------------------------------------------------------------------------------------

-- 5. Write a query that returns for each customer all orders placed on the customer's last day of activity.

-- Solution

SELECT custid, orderid, orderdate, empid
FROM Sales.Orders AS O
WHERE orderdate = (
	SELECT MAX(orderdate)
	FROM Sales.Orders AS O1
	WHERE O.custid = O1.custid
)
ORDER BY custid;

---------------------------------------------------------------------------------------------------------------------------------

-- 6. Write a query that returns customers who placed orders in 2007 but not in 2008.

-- Solution

SELECT custid, companyname
FROM Sales.Customers AS C
WHERE EXISTS (
	SELECT custid
	FROM Sales.Orders AS O
	WHERE C.custid = O.custid AND
	YEAR(orderdate) = 2007
) AND NOT EXISTS (
	SELECT custid
	FROM Sales.Orders AS O
	WHERE C.custid = O.custid AND
	YEAR(orderdate) = 2008
);

---------------------------------------------------------------------------------------------------------------------------------

-- 7. Write a query that returns customers who ordered product 12.

-- Solution

SELECT custid, companyname
FROM Sales.Customers
WHERE custid IN (
	SELECT custid
	FROM Sales.Orders AS O
	WHERE orderid IN (
		SELECT orderid
		FROM Sales.OrderDetails
		WHERE productid = 12
	)
);

---------------------------------------------------------------------------------------------------------------------------------

-- 8. Write a query that calculates a running-total quantity for each customer and month.

-- Solution
GO

CREATE VIEW Sales.CustOrders
  WITH SCHEMABINDING
AS

SELECT
  O.custid, 
  DATEADD(month, DATEDIFF(month, 0, O.orderdate), 0) AS ordermonth,
  SUM(OD.qty) AS qty
FROM Sales.Orders AS O
  JOIN Sales.OrderDetails AS OD
    ON OD.orderid = O.orderid
GROUP BY custid, DATEADD(month, DATEDIFF(month, 0, O.orderdate), 0);
GO

SELECT custid, ordermonth, qty, (
	SELECT SUM(CO2.qty)
	FROM Sales.CustOrders AS CO2
	WHERE CO1.custid = CO2.custid AND
	CO2.ordermonth <= CO1.ordermonth
) AS runqty
FROM Sales.CustOrders AS CO1
ORDER BY custid, ordermonth;

---------------------------------------------------------------------------------------------------------------------------------
