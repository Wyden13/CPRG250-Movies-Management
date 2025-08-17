-- CPRG 250 PROJECT 2 --
-- Phase three: SQL Queries and Reporting -- 
-- Report 6: Revenue by Category with Grand Totals--
-- Purpose: Sum rental revenue by content category, with category totals and a grand total.
-- Concepts: OLAP(GROUPING SETS), GROUP BY, SUM, COUNT--
-- Author: Hoang Phuong Uyen Nguyen -- 

select
	c.category_id,
	COALESCE(c.category_name, 'Grand Total') AS category_name,
	COUNT(r.rental_id) AS "rental_count",
	SUM(r.price_paid)::numeric(12,2) AS "revenue"
from rental r
join movie m on r.movie_id = m.movie_id
join movie_category mc on m.movie_id = mc.movie_id
join category c on mc.category_id = c.category_id
GROUP BY GROUPING SETS ((c.category_id,c.category_name),())
ORDER BY c.category_id ASC;
