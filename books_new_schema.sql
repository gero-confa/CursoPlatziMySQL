-- JOIN (INNER JOIN ES POR DEFECTO)
SELECT b.book_id, a.name, b.title, a.author_id
 FROM books as b JOIN authors as a 
 ON a.author_id = b.author_id
 WHERE a.author_id BETWEEN 1 AND 5;

SELECT c.name, b.title, t.type, a.name FROM transactions AS t
JOIN books as b ON t.book_id = b.book_id
JOIN clients as c ON t.client_id = c.client_id
JOIN authors as a ON b.author_id = a.author_id
WHERE c.gender = 'F' AND t.type = 'sell'
;

-- mismo query que el anterior pero con palabra clave IN
SELECT c.name, b.title, t.type, a.name FROM transactions AS t
JOIN books as b ON t.book_id = b.book_id
JOIN clients as c ON t.client_id = c.client_id
JOIN authors as a ON b.author_id = a.author_id
WHERE c.gender = 'F' AND t.type IN ('sell', 'lend')
;

-- LEFT JOIN
SELECT a.author_id, a.name, a.nationality, COUNT(b.book_id) AS cantidad_de_libros
FROM authors AS a
JOIN books as b 
ON b.author_id = a.author_id
WHERE a.author_id BETWEEN 1 AND 5
GROUP BY a.author_id
ORDER BY a.author_id ASC 
;

-- ORDER BY es key word para asignar orden lo puedo poner de cualquier columna y asc(endente) o desc(endente)
-- GROUP BY escoge cual es el dato (en este caso el id de libro) y agrupa en base a lo que elegi, en este caso toma todos los libros de x autor y los junta dentro de este autor dandome la totalidad que escribio