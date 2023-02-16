# Cities With Completed Trades [Robinhood SQL Interview Question]

## Question
This is the same question as problem #2 in the SQL Chapter of Ace the Data Science Interview!

You are given the tables below containing information on Robinhood trades and users. Write a query to list the top three cities that have the most completed trade orders in descending order.

Output the city and number of orders.

## Solution
```
SELECT city, COUNT(*) AS total_orders
FROM users INNER JOIN trades
ON users.user_id = trades.user_id
WHERE status LIKE 'Completed'
GROUP BY city
ORDER BY total_orders DESC
LIMIT 3;
```
