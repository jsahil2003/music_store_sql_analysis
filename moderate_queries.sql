-- Q1: Write query to return the email, first name, last name, & Genre of all Rock Music listeners.
SELECT
	DISTINCT customer.email,
	customer.first_name,
	customer.last_name,
	genre.name
FROM
	customer
LEFT JOIN
	invoice
	ON customer.customer_id = invoice.customer_id
INNER JOIN
	invoice_line
	ON invoice.invoice_id = invoice_line.invoice_id
INNER JOIN
	track
	ON track.track_id = invoice_line.track_id
INNER JOIN
	genre
	ON track.genre_id = genre.genre_id
WHERE
	genre.name = 'Rock'
ORDER BY
	customer.email ASC;

-- Q2: Let's invite the artists who have written the most rock music in our dataset.
SELECT
	artist.name,
	COUNT(track.track_id) AS num_of_songs
FROM
	artist
INNER JOIN
	album
	ON artist.artist_id = album.artist_id
INNER JOIN
	track
	ON album.album_id = track.album_id
INNER JOIN
	genre
	ON track.genre_id = genre.genre_id
WHERE
	genre.name = 'Rock'
GROUP BY
	artist.name
ORDER BY
	num_of_songs DESC
LIMIT 
	10;

-- Q3: Return all the track names that have a song length longer than the average song length.
SELECT
	track.name,
	track.milliseconds
FROM
	track
WHERE
	track.milliseconds >
		(
	SELECT
		AVG(track.milliseconds)
	FROM
		track
	)
ORDER BY
	track.milliseconds DESC;