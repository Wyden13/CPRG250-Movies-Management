-- CPRG 250 PROJECT 2 --
-- Phase three: SQL Queries and Reporting -- 
-- Report 6: Customers Above Average Rentals --
-- Desc: Identify customers whose rental activity is above the overall average. --
-- Concepts: GROUP BY, Subquery with aggregate, Comparison --
-- Author: Hoang Phuong Uyen Nguyen --

SELECT c.customer_id,
       c.first_name || ' ' || c.last_name AS customer_name,
       x.cnt AS rentals_count
FROM customer c
JOIN (
  SELECT r.customer_id, COUNT(*)::int AS cnt
  FROM rental r
  GROUP BY r.customer_id
) x ON x.customer_id = c.customer_id
WHERE x.cnt > (
  SELECT AVG(cnt) FROM (
    SELECT customer_id, COUNT(*)::int AS cnt
    FROM rental
    GROUP BY customer_id
  )
)
ORDER BY x.cnt DESC, customer_name;