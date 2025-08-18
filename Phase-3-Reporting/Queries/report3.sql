-- CPRG 250 PROJECT 2 --
-- Phase three: SQL Queries and Reporting -- 
-- Report 3: Popular New Releases --
-- Desc: List new-release & popular movies, sorted by HD price and title. --
-- Concepts: WHERE filter, ORDER BY sorting --
-- Author: Hoang Phuong Uyen Nguyen --

SELECT movie_id, title, rating, hd_price, is_new_release, is_most_popular
FROM movie
WHERE is_new_release = TRUE
  AND is_most_popular = TRUE
  AND hd_price IS NOT NULL
ORDER BY hd_price DESC, title ASC;