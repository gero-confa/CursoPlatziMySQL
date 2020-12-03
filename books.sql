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
INSERT INTO authors(author_id, name, nationality) VALUES('','Juan Rulfo','MEX');
INSERT INTO authors(name, nationality) VALUES('Gabriel Garcia Márquez', 'COL');
INSERT INTO authors() VALUES ('', 'Juan Gabriel Vazquez', 'COL');