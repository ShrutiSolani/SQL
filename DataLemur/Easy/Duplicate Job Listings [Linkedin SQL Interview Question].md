# Duplicate Job Listings [Linkedin SQL Interview Question]

## Question
This is the same question as problem #8 in the SQL Chapter of Ace the Data Science Interview!

Assume you are given the table below that shows job postings for all companies on the LinkedIn platform. Write a query to get the number of companies that have posted duplicate job listings.

Clarification:
Duplicate job listings refer to two jobs at the same company with the same title and description.

## Solution
```
SELECT COUNT(*) AS co_w_duplicate_jobs
FROM (
  SELECT COUNT(*) AS num_duplicates
  FROM job_listings AS A
  GROUP BY company_id, title
  HAVING COUNT(*) > 1
) AS T1;
```
