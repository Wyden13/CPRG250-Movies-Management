-- CPRG 250 PROJECT 2 --
-- Phase three: SQL Queries and Reporting -- 
-- Report 4: Revenue by Category --
-- Purpose: Aggregate rental revenue per movie category to identify top genres. --
-- Concepts: Joins, GROUP BY, SUM, COUNT aggregates --
-- Author: --

SELECT cat.category_id,
       cat.name AS category_name,
       SUM(r.price_paid)              AS total_revenue,
       COUNT(DISTINCT r.rental_id)    AS rentals_count,
       COUNT(DISTINCT r.customer_id)  AS unique_customers
FROM rental r
JOIN moviecategory mc ON mc.movie_id = r.movie_id
JOIN category cat     ON cat.category_id = mc.category_id
GROUP BY cat.category_id, cat.name
ORDER BY total_revenue DESC;