# Sending vs. Opening Snaps [Snapchat SQL Interview Question]

## Question
This is the same question as problem #25 in the SQL Chapter of Ace the Data Science Interview!

Assume you are given the tables below containing information on Snapchat users, their ages, and their time spent sending and opening snaps. Write a query to obtain a breakdown of the time spent sending vs. opening snaps (as a percentage of total time spent on these activities) for each age group.

Output the age bucket and percentage of sending and opening snaps. Round the percentage to 2 decimal places.

## Notes

* You should calculate these percentages:
  * time sending / (time sending + time opening)
  * time opening / (time sending + time opening)
* To avoid integer division in percentages, multiply by 100.0 and not 100.

## Solution
```
WITH time_calc 
AS (
  SELECT ab.age_bucket,
  SUM(
    CASE
    WHEN ac.activity_type LIKE 'send' THEN ac.time_spent
    ELSE 0
    END
  ) AS total_send_time,
  SUM(
    CASE
    WHEN ac.activity_type LIKE 'open' THEN ac.time_spent
    ELSE 0
    END
  ) AS total_open_time,
  SUM(
    ac.time_spent
  ) AS total_time
  FROM activities AS ac INNER JOIN 
  age_breakdown as ab 
  ON ac.user_id = ab.user_id
  WHERE ac.activity_type IN ('send', 'open')
  GROUP BY ab.age_bucket
)
SELECT age_bucket,
ROUND((total_send_time/total_time)*100.0, 2) AS send_perc,
ROUND((total_open_time/total_time)*100.0, 2) AS open_perc
FROM time_calc;
```
