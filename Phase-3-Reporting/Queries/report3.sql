-- CPRG 250 PROJECT 2 --
-- Phase three: SQL Queries and Reporting -- 
-- Report 3: Normalized Customer Contacts --
-- Purpose: Standardize name/email/phone for export or mail-merge. --
-- Concepts: Single-row functions (INITCAP, LOWER, REGEXP_REPLACE, TO_CHAR) --
-- Author: --

SELECT c.customer_id,
       INITCAP(c.first_name) AS first_name,
       INITCAP(c.last_name)  AS last_name,
       LOWER(c.email)        AS email,
       REGEXP_REPLACE(c.phone_number, '[^0-9]', '', 'g') AS phone_digits_only,
       TO_CHAR(CURRENT_DATE, 'YYYY-MM-DD') AS export_date
FROM customer c
ORDER BY last_name, first_name;