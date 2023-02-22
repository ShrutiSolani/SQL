# Tweets' Rolling Averages [Twitter SQL Interview Question]

## Question
This is the same question as problem #10 in the SQL Chapter of Ace the Data Science Interview!

The table below contains information about tweets over a given period of time. Calculate the 3-day rolling average of tweets published by each user for each date that a tweet was posted. Output the user id, tweet date, and rolling averages rounded to 2 decimal places.

## Important Assumptions:

* Rows in this table are consecutive and ordered by date.
* Each row represents a different day
* A day that does not correspond to a row in this table is not counted. The most recent day is the next row above the current row.

## Note
Rolling average is a metric that helps us analyze data points by creating a series of averages based on different subsets of a dataset. It is also known as a moving average, running average, moving mean, or rolling mean.

## Solution
```
-- I was trying this but didn't work, had to use hint later
-- SELECT user_id, tweet_date, 
-- RANK() OVER(PARTITION BY user_id ORDER BY tweet_date) Rank  
-- FROM tweets;


WITH tweet_count AS 
(
  SELECT user_id, tweet_date, COUNT(tweet_id) AS tweet_count
  FROM tweets
  GROUP BY user_id, tweet_date
)
SELECT user_id, tweet_date, 
ROUND(AVG(tweet_count) OVER(
  PARTITION BY user_id ORDER BY tweet_date
  ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
  ), 2) AS rolling_avg_3d
FROM tweet_count;
```
