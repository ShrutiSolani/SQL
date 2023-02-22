# Odd and Even Measurements [Google SQL Interview Question]

## Question
This is the same question as problem #28 in the SQL Chapter of Ace the Data Science Interview!

Assume you are given the table containing measurement values obtained from a Google sensor over several days. Measurements are taken several times within a given day.

Write a query to obtain the sum of the odd-numbered and even-numbered measurements on a particular day, in two different columns. Refer to the Example Output below for the output format.

## Definition:

1st, 3rd, and 5th measurements taken within a day are considered odd-numbered measurements and the 2nd, 4th, and 6th measurements are even-numbered measurements.

## Solution
```
WITH given_ranks AS 
(
  SELECT  DATE(measurement_time) AS measurement_day, 
          measurement_value,
          RANK() OVER(
                PARTITION BY DATE(measurement_time) 
                ORDER BY measurement_time
              ) AS ranks
  FROM measurements
)
SELECT measurement_day,
SUM(
CASE
WHEN ranks % 2 != 0 THEN measurement_value
ELSE 0
END
) AS odd_sum,
SUM(
CASE
WHEN ranks % 2 = 0 THEN measurement_value
ELSE 0
END
) AS even_sum
FROM given_ranks
GROUP BY measurement_day
ORDER BY measurement_day;
```
