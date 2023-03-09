# App Click-through Rate (CTR) [Facebook SQL Interview Question]

## Question
Assume you have an events table on app analytics. Write a query to get the app’s click-through rate (CTR %) in 2022. Output the results in percentages rounded to 2 decimal places.

## Notes
* Percentage of click-through rate = 100.0 * Number of clicks / Number of impressions
* To avoid integer division, you should multiply the click-through rate by 100.0, not 100.

## Solution
```
WITH temp_table AS (
SELECT app_id, 
SUM(
  CASE 
  WHEN event_type LIKE 'click' THEN 1
  ELSE 0
  END
) AS click_count,
SUM(
  CASE
  WHEN event_type LIKE 'impression' THEN 1
  ELSE 0
  END
) AS imp_count
FROM events
WHERE EXTRACT(YEAR FROM timestamp) = 2022
GROUP BY app_id
)
SELECT app_id, ROUND(100.0*click_count/imp_count, 2) AS ctr
FROM temp_table;
```
