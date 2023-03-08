# Average Post Hiatus (Part 1) [Facebook SQL Interview Question]

## Question
Given a table of Facebook posts, for each user who posted at least twice in 2021, write a query to find the number of days between each user’s first post of the year and last post of the year in the year 2021. Output the user and number of the days between each user's first and last post.

## Solution
```
SELECT user_id, EXTRACT(days FROM MAX(post_date) - MIN(post_date)) AS days_between
FROM posts
WHERE EXTRACT(YEAR FROM post_date) = 2021 AND user_id IN (
  SELECT user_id
  FROM posts
  WHERE EXTRACT(YEAR FROM post_date) = 2021
  GROUP BY user_id
  HAVING COUNT(*) > 1
)
GROUP BY user_id;
```

## Simplified Solution
```
SELECT user_id, EXTRACT(days FROM MAX(post_date) - MIN(post_date)) AS days_between
FROM posts
WHERE EXTRACT(YEAR FROM post_date) = 2021 
GROUP BY user_id
HAVING COUNT(*) > 1;
```
