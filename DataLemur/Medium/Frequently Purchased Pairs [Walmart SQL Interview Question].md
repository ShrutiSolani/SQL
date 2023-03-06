# Frequently Purchased Pairs [Walmart SQL Interview Question]

## Question
This is the same question as problem #30 in the SQL Chapter of Ace the Data Science Interview!

Assume you are given the following tables on Walmart transactions and products. Find the number of unique product combinations that are purchased in the same transaction.

For example, if there are 2 transactions where apples and bananas are bought, and another transaction where bananas and soy milk are bought, my output would be 2 to represent the 2 unique combinations.

## Assumptions:
* For each transaction, a maximum of 2 products is purchased.
* You may or may not need to use the products table.

## Solution
DataLemur official solution 
```
SELECT COUNT(DISTINCT CONCAT(t1.product_id, t2.product_id))
FROM transactions AS t1
INNER JOIN transactions AS t2
ON t1.transaction_id = t2.transaction_id
AND t1.product_id > t2.product_id;
```
