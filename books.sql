-- DROP DATABASE IF EXIST 

CREATE TABLE IF NOT EXISTS books (
    book_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    author_id INTEGER UNSIGNED ,
    title VARCHAR(100) NOT NULL,
    year INTEGER UNSIGNED NOT NULL DEFAULT 1900,
    language VARCHAR(2) NOT NULL DEFAULT 'es' COMMENT 'ISO 639-1 Language',
    cover_url VARCHAR(500),
    price DOUBLE(6,2) NOT NULL DEFAULT 10.0,
    sellable TINYINT(1) DEFAULT 1,
    copies INTEGER NOT NULL DEFAULT 1,
    description TEXT
);
-- en la base esta como author pero aca lo dejo asi porque es buena practica a los objectos ponerlos en plural
CREATE TABLE IF NOT EXISTS authors (
    author_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    nationality VARCHAR(3)
);
CREATE TABLE IF NOT EXISTS clients(
    client_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(40) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    birthdate DATETIME,
    gender ENUM('M', 'F', 'ND'),
    active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

);
CREATE TABLE IF NOT EXISTS operations(
    operation_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    book_id INTEGER UNSIGNED NOT NULL,
    client_id INTEGER UNSIGNED NOT NULL, 
    -- S para sold y R para rented y RN para Redturned
    operation_type ENUM('S', 'R', 'RN'),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    finished TINYINT(1) NOT NULL DEFAULT 1
);
-- INSERT INTO tabla(COLUMNAS*) VALUES(VALORES)
INSERT INTO authors(author_id, name, nationality) VALUES('0','Juan Rulfo','MEX');
INSERT INTO authors(name, nationality) VALUES('Gabriel Garcia Márquez', 'COL');
INSERT INTO authors() VALUES ('0', 'Juan Gabriel Vazquez', 'COL');

-- para varias inserciones en una sola sentencia / usualmente en chunks de 50
INSERT INTO authors(name, nationality) VALUES('Julio Cortazar', 'ARG'),
('Isabel Allende', 'CHI'),
('Octavio Paz','MEX'),
('Juan Carlos Onetti', 'URU');

INSERT INTO clients (client_id, name, email, birthdate, gender) VALUES 
(1, 'Maria Dolores Gomez', 'mariadolores.95983222J@random.names', '1971-06-06', 'F'), 
(2, 'Adrian Fernandez', 'Adrian.55818851J@random.names', '1970-04-09', 'M'),
(3, 'Maria Luisa Marin', 'MariaLuisa.83726282A@random.names', '1957-07-30', 'F'),
(4, 'Pedro Sanchez', 'Pedro.785220559J@random.names', '1992-01-31', 'M');

INSERT INTO clients (name, email, birthdate, gender, active) VALUES 
('Pedro Sanchez', 'Pedro.785220559J@random.names', '1992-01-31', 'M', 0)
ON DUPLICATE KEY UPDATE active = VALUES(active);

-- como insertar sin query anidado
INSERT INTO books(title, author_id) VALUES('El Laberinto de la Soledad', 6);

-- cono insertar con query anidado, no se recomiendan
INSERT INTO books(title, author_id, `year`)
VALUES('Vuelta al Laberinto de la Soledad',
(SELECT author_id FROM authors WHERE name = 'OCTAVIO PAZ'
LIMIT 1), '1960');

-- SELECT
SELECT name, email, gender FROM clients;
SELECT (year)birthdate FROM clients;
SELECT NOW();
-- para tener nombre y edad
SELECT name, YEAR(NOW()) - YEAR(birthdate) FROM clients;

SELECT * FROM clients WHERE name LIKE '%Saave%';

SELECT name, email, YEAR(NOW()) - YEAR(birthdate) AS edad, gender FROM clients WHERE gender = 'F' AND name LIKE '%Lop%';