-- Chapter 2 - Single-Table Queries
-- Exercises

USE TSQL2012;

-- 1. Write a query against the Sales.Orders table that returns orders placed in June 2007.

-- SOLUTION 1
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE MONTH(orderdate) = 6;

-- SOLUTION 2
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate >= '20070601' AND orderdate <= '20070630';

---------------------------------------------------------------------------------------------------------------------------------

-- 2. Write a query against the Sales.Orders table that returns orders placed on the last day of the month.

-- SOLUTION
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate = EOMONTH(orderdate);

---------------------------------------------------------------------------------------------------------------------------------

-- 3. Write a query against the HR.Employees table that returns employees with last name containing the letter 'a' twice or more.

-- SOLUTION
SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname LIKE '%a%a%';

---------------------------------------------------------------------------------------------------------------------------------

-- 4. Write a query against the Sales.OrderDetails table that returns orders with total value (quantity * unitprice) 
--    greater than 10,000, sorted by total value.

-- SOLUTION
SELECT orderid, SUM(qty*unitprice) AS TOTALVALUE
FROM Sales.OrderDetails
GROUP BY orderid
HAVING SUM(qty*unitprice) >10000
ORDER BY TOTALVALUE;

---------------------------------------------------------------------------------------------------------------------------------

-- 5. Write a query against the Sales.Orders table that returns the three shipped-to countries
--    with the highest average freight in 2007.

-- SOLUTION
SELECT TOP(3) shipcountry, AVG(freight) AS AVGFREIGHT
FROM Sales.Orders
WHERE orderdate >= '20070101' AND orderdate <= '20071231'
GROUP BY shipcountry
ORDER BY AVGFREIGHT DESC;

---------------------------------------------------------------------------------------------------------------------------------

-- 6. Write a query against the Sales.Orders table that calculates row numbers for orders based on order date ordering
--    (using the order ID as the tiebreaker) for each customer separately.

-- SOLUTION
SELECT custid, orderdate, orderid, ROW_NUMBER() OVER(PARTITION BY custid ORDER BY orderdate, orderid) AS ROWNUM
FROM Sales.Orders
ORDER BY custid, ROWNUM;

---------------------------------------------------------------------------------------------------------------------------------

-- 7. Using the HR.Employees table, figure out the SELECT statement that returns for each employee the gender 
--    based on the title of courtesy. For 'Ms.' and 'Mrs.' return 'Female'; for 'Mr.' return 'Male'; 
--    and in all other cases (for example, 'Dr.') return 'Unknown'.

-- SOLUTION
SELECT empid, firstname, lastname, titleofcourtesy,
CASE titleofcourtesy
WHEN 'Ms.' THEN 'Female'
WHEN 'Mrs.' THEN 'Female'
WHEN 'Mr.' THEN 'Male'
ELSE 'Unknown'
END AS GENDER
FROM HR.Employees;

---------------------------------------------------------------------------------------------------------------------------------

-- 8. Write a query against the Sales.Customers table that returns for each customer the customer ID and region.
--    Sort the rows in the output by region, having NULL marks sort last (after non-NULL values).
--    Note that the default sort behavior for NULL marks in T-SQL is to sort first (before non-NULL values).

-- SOLUTION
SELECT custid, region
FROM Sales.Customers
ORDER BY CASE WHEN region IS NULL THEN 1 ELSE 0 END, region;

---------------------------------------------------------------------------------------------------------------------------------
