-- Q1: Find out how much is the amount spent by each customer on artists?
SELECT
	customer.first_name,
	customer.last_name,
	artist.name,
	SUM(invoice_line.unit_price * invoice_line.quantity) AS sales
FROM
	invoice
JOIN
	customer
	ON customer.customer_id = invoice.customer_id
JOIN
	invoice_line
	ON invoice.invoice_id = invoice_line.invoice_id
JOIN
	track
	ON invoice_line.track_id = track.track_id
JOIN
	album
	ON track.album_id = album.album_id
JOIN
	artist
	ON album.artist_id = artist.artist_id
GROUP BY
	1,2,3
ORDER BY
	sales DESC;

-- Q2: We want to find out the most popular music Genre for each country.
SELECT
	music_info.name AS genre_name,
	music_info.billing_country AS country,
	music_info.no_of_purchases
FROM
(
SELECT
	genre.name,
	invoice.billing_country,
	SUM(invoice_line.quantity) AS no_of_purchases,
	RANK() OVER(PARTITION BY invoice.billing_country ORDER BY 
	SUM(invoice_line.quantity) DESC) AS rnk
FROM
	invoice
JOIN
	invoice_line
	ON invoice.invoice_id = invoice_line.invoice_id
JOIN
	track
	ON track.track_id = invoice_line.track_id
JOIN
	genre
	ON track.genre_id = genre.genre_id
GROUP BY
	1,2
) AS music_info
WHERE
	rnk = 1
ORDER BY
	no_of_purchases DESC;

-- Q3: Write a query that determines the customer that has spent the most on music for each country.
SELECT 
	cust_info.billing_country AS country,
	cust_info.first_name,
	cust_info.last_name,
	cust_info.sales AS sales
FROM
(
	SELECT
		customer.customer_id,
		invoice.billing_country,
		customer.first_name,
		customer.last_name,
		SUM(invoice_line.unit_price * invoice_line.quantity) AS sales,
		RANK() OVER(PARTITION BY invoice.billing_country 
		ORDER BY SUM(invoice_line.unit_price * invoice_line.quantity) DESC ) AS rnk
	FROM
		customer
	JOIN
		invoice
		ON customer.customer_id = invoice.customer_id
	JOIN
		invoice_line
		ON invoice.invoice_id = invoice_line.invoice_id
	JOIN
		track
		ON track.track_id = invoice_line.track_id
	JOIN
		genre
		ON track.genre_id = genre.genre_id
	GROUP BY
		1,2
) AS cust_info
WHERE
	rnk = 1
ORDER BY
	country ASC;