# Teams Power Users [Microsoft SQL Interview Question]

## Question
Write a query to find the top 2 power users who sent the most messages on Microsoft Teams in August 2022. Display the IDs of these 2 users along with the total number of messages they sent. Output the results in descending count of the messages.

## Assumption
No two users has sent the same number of messages in August 2022.

## Solution
```
SELECT sender_id, COUNT(message_id) AS message_count 
FROM messages
WHERE CAST(sent_date AS DATE) >= '08-01-2022' AND CAST(sent_date AS DATE) <= '08-31-2022'
GROUP BY sender_id
ORDER BY message_count DESC
LIMIT 2;
```
