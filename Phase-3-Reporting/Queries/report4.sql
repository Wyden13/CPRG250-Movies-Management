-- CPRG 250 PROJECT 2 --
-- Phase three: SQL Queries and Reporting -- 
-- Report 4 — Top-Spending Customer in Each Category --
-- Desc: Finds the customer with the highest total rental spend within each movie category -- 
-- Concepts: UPPER(single-row), JOIN(joins), SUM/MAX(group), subqueries, ORDER BY(restrict/sort)--
-- Author: Hoang Phuong Uyen Nguyen --
SELECT
    c.category_id,
    c.category_name,
    SUM(r.price_paid)::numeric(12,2) AS total_spend,
    cu.customer_id,
    UPPER(cu.first_name || ' ' || cu.last_name)AS customer_name
FROM category c
JOIN movie_category mc ON mc.category_id = c.category_id
JOIN rental r ON r.movie_id = mc.movie_id
JOIN customer cu ON cu.customer_id = r.customer_id
GROUP BY
    c.category_id, c.category_name,
    cu.customer_id, cu.first_name, cu.last_name
HAVING
    SUM(r.price_paid) = (
        SELECT MAX(sum_spend)
        FROM (
            SELECT SUM(r2.price_paid) AS sum_spend
            FROM movie_category mc2
            JOIN rental r2 ON r2.movie_id = mc2.movie_id
            WHERE mc2.category_id = c.category_id
            GROUP BY r2.customer_id
        ) t
    )
ORDER BY
    c.category_id;  
