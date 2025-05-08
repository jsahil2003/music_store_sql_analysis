# SQL Analytics Project

## Easy Queries

```sql
-- Q1: Who is the senior most employee based on job title?
SELECT
	CONCAT(first_name,last_name) AS emp_name
FROM
	employee
ORDER BY
	levels DESC
LIMIT 
	1;

-- Q2: Which countries have the most Invoices?
SELECT 
	COUNT(*) AS num_of_invoices,
	billing_country
FROM 
	invoice
GROUP BY
	billing_country
ORDER BY
	num_of_invoices DESC
LIMIT
	1;

-- Q3: What are top 3 values of total invoice and which country do they belong to?
SELECT 
	billing_country,
	total
FROM 
	invoice
ORDER BY
	total DESC
LIMIT 
	3;

-- Q4: Which city has the best customers?
SELECT 
	SUM(total) AS total_by_city,
	billing_city
FROM 
	invoice
GROUP BY
	billing_city
ORDER BY
	total_by_city DESC
LIMIT 
	1;

-- Q5: Who is the best customer?
SELECT 
	SUM(invoice.total) AS total_money_spent,
	customer.first_name,
	customer.last_name
FROM 
	invoice
INNER JOIN
	customer
	ON invoice.customer_id = customer.customer_id
GROUP BY
	invoice.customer_id,
	customer.first_name,
	customer.last_name
ORDER BY
	total_money_spent DESC
LIMIT 
	1;
