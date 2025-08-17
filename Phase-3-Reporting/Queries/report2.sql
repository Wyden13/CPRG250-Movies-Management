-- CPRG 250 PROJECT 2 --
-- Phase three: SQL Queries and Reporting -- 
-- Report 1: Customer Rentals with Movie & Price --
-- Purpose: Show each rental with who rented it, what movie, and what they paid. --
-- Concepts: Joins, Sorting --
-- Author: Hoang Phuong Uyen Nguyen --

SELECT r.rental_id,
       c.customer_id,
       CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       m.movie_id,
       m.title,
       r.start_view_date,
       r.expiry_date,
       r.price_paid
FROM rental r
JOIN customer c ON c.customer_id = r.customer_id
JOIN movie    m ON m.movie_id    = r.movie_id
ORDER BY r.start_view_date DESC;