-- CPRG 250 PROJECT 2 --
-- Phase three: SQL Queries and Reporting -- 
-- Report 2: Monthly Rental Counts --
-- Desc: Counts the number of rentals per month (with year) --
-- Concepts: EXTRACT, GROUP BY, COUNT, SUM --
-- Author: Hoang Phuong Uyen Nguyen --

SELECT 
    EXTRACT(YEAR FROM r.rental_date) AS rental_year,
    EXTRACT(MONTH FROM r.rental_date) AS rental_month,
    COUNT(r.rental_id) AS rental_count,
    SUM(r.price_paid) AS total_revenue
FROM rental r
GROUP BY rental_year, rental_month
ORDER BY rental_year, rental_month;