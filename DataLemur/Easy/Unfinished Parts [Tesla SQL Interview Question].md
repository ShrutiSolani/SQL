# Unfinished Parts [Tesla SQL Interview Question]

## Question
Tesla is investigating bottlenecks in their production, and they need your help to extract the relevant data. Write a query that determines which parts have begun the assembly process but are not yet finished.

## Assumptions
Table parts_assembly contains all parts in production.
A part with no finish_date is an unfinished part.

## Solution
```
SELECT DISTINCT part 
FROM parts_assembly 
WHERE finish_date IS NULL;
```
