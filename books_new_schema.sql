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

-- casos de negocio
SELECT DISTINCT nationality FROM authors;
-- keyword DISTINCT es para valores distintos dentro de una clumna

SELECT nationality, count(author_id) AS c_authors
FROM authors
WHERE nationality IS NOT NULL
AND nationality NOT IN('RUS', 'AUS')
GROUP BY nationality 
order by c_authors DESC, nationality ASC;
-- el count() u otras funcioens requieren agruparse
-- ORDER BY puede ser por varias columnas en orden que se escriben
-- NOT IN('string') para quitar el string seleccionado aunque <> tambien funcionaria como 'desigual a'

-- promedio de precios y desv estandar
SELECT nationality, AVG(price) prom, STDDEV(price) AS std
FROM books AS b
INNER JOIN authors as a
ON a.author_id = b.author_id
GROUP BY nationality
ORDER BY prom DESC
;

-- maximos y minimos
SELECT a.nationality, MAX(price), MIN(price)
FROM books as b
INNER JOIN authors as a
ON a.author_id = b.author_id
GROUP BY nationality
;

-- reporte final "que operacion, cuando y quien"
-- CONCAT me va a generar una nueva columna con lo que tengo
SELECT c.name , t.type, b.title, CONCAT(a.name, "(", a.nationality, ")") AS autor
FROM transactions as t 
LEFT JOIN clients as c 
 ON c.client_id = t.client_id
LEFT JOIN books as b 
 ON b.book_id = t.book_id
LEFT JOIN authors as a 
 ON b.author_id = a.author_id
;

-- funcion nueva TO_DAYS() da dias entre 1ro de enero del año 0 hasta el dia de hoy
SELECT TO_DAYS(NOW())
-- ejeemplo mas basico
SELECT TO_DAYS('0000-01-01')) este daria 1 porque es 1 el dia que paso desde TO_DAYS() hasta el dia '0000-01-01'

-- DELETE, ocmo truquito le pongo LIMIT 1 o la cantidad que se que tengo que borrar para no pasarme y cagarla
DELETE from authors WHERE author_id = 161 LIMIT 1

-- UPDATE
UPDATE tabla
SET [columna = valor]
WHERE conditions;

-- UPDATE APLICADO
UPDATE clients 
SET active = 0
WHERE client_id = 80
LIMIT 1;

-- TRUNCATE borra el contenido pero deja la estructura de la tabla
TRUNCATE tabla

-- quitar columna
ALTER TABLE tabla DROP COLUMN nombre_de_columna
-- agregar columnas 
ALTER TABLE tabla DROP ADD COLUMN nombre_de_columna

-- mysqldump es en consola puede traer toda la base con los datos o la schema sin datos y la exporta en un .txt
en lugar de mysql para entrar a la consola, uso "mysql -u root -p database" es un respaldo local

para VERSIONAR, con mysqldump "mysql -u root -p  -d database" el "-d" vacia la schema
"mysql -u root -p  -d database > esquema.sql" lo deja exportado en local