CREATE SCHEMA biblioteca;
USE biblioteca;

CREATE TABLE editorial(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(45) NOT NULL,
    contacto VARCHAR(50)
);

CREATE TABLE nacionalidad(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    nombre VARCHAR(40) NOT NULL
);

CREATE TABLE serie(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL
);

CREATE TABLE tematica(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL
);

CREATE TABLE ubicacion(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(40) NOT NULL
);

CREATE TABLE autor(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(25) NOT NULL,
    apellido VARCHAR (25) NOT NULL,
    id_nacionalidad INT NOT NULL,
    FOREIGN KEY (id_nacionalidad) REFERENCES nacionalidad (id),
    fecha_nacim DATE NOT NULL
);

CREATE TABLE NEW_AUTOR(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(25) NOT NULL,
    apellido VARCHAR (24) NOT NULL,
    id_nacionalidad INT NOT NULL,
    FOREIGN KEY (id_nacionalidad) REFERENCES nacionalidad (id),
    fecha_nacim DATE NOT NULL
);

CREATE TABLE NEW_AUTOR_MAYOR(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(25) NOT NULL,
    apellido VARCHAR (25) NOT NULL,
    id_nacionalidad INT NOT NULL,
    FOREIGN KEY (id_nacionalidad) REFERENCES nacionalidad (id)
);

CREATE TRIGGER alta_autor
AFTER INSERT ON autor
FOR EACH ROW
INSERT INTO NEW_AUTOR (id, nombre, id_nacionalidad, fecha_nacim) VALUES (NEW.id, NEW.nombre, NEW.id_nacionalidad, NEW.fecha_nacim);

DELIMITER //
CREATE TRIGGER verificar_edad_autor
BEFORE INSERT ON autor
FOR EACH ROW
BEGIN
if  (YEAR(new.fecha_nacim)< 2000) then
 INSERT INTO NEW_AUTOR_MAYOR (id, nombre, id_nacionalidad) VALUES (NEW.id, NEW.nombre, NEW.id_nacionalidad);
end if;
END //

CREATE TABLE ilustrador(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(25) NOT NULL,
    apellido VARCHAR (25) NOT NULL,
    id_nacionalidad INT NOT NULL,
    FOREIGN KEY (id_nacionalidad) REFERENCES nacionalidad (id),
    fecha_nacim DATE NOT NULL
);

select * from ilustrador;

CREATE TABLE lector(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    nombre VARCHAR(25) NOT NULL, 
    apellido VARCHAR(25)NOT NULL,
    contacto VARCHAR(50)
);

CREATE TABLE libro(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(40) NOT NULL,
    id_autor INT NOT NULL,
    FOREIGN KEY (id_autor) REFERENCES autor (id),
    id_ilustrador INT NOT NULL,
    FOREIGN KEY (id_ilustrador) REFERENCES ilustrador (id),
    id_editorial INT NOT NULL,
    FOREIGN KEY (id_editorial) REFERENCES editorial (id),
    id_tematica INT NOT NULL,
    FOREIGN KEY (id_tematica) REFERENCES tematica (id),
    id_serie INT NOT NULL,
    FOREIGN KEY (id_serie) REFERENCES serie (id),
    detalle VARCHAR(50),
    edad INT
);

select * from libro;

CREATE TABLE ejemplar (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_libro INT NOT NULL,
FOREIGN KEY (id_libro) REFERENCES libro (id),
id_ubicacion INT NOT NULL,
FOREIGN KEY (id_ubicacion) REFERENCES ubicacion (id),
estado VARCHAR(20) NOT NULL
);

CREATE TABLE prestamo (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_ejemplar INT NOT NULL,
FOREIGN KEY (id_ejemplar) REFERENCES ejemplar (id),
id_lector INT NOT NULL,
FOREIGN KEY (id_lector) REFERENCES lector (id),
f_pedido DATE,
f_devolucion DATE,
detalle VARCHAR(60)
);

select * FROM ubicacion;
select * FROM ejemplar;

INSERT INTO nacionalidad VALUES 
(NULL,"argentino"),
(NULL,"brasilero"),
(NULL,"peruano"),
(NULL,"mexicano");

INSERT INTO ubicacion VALUES 
(NULL,"zona verde"),
(NULL,"zona azul"),
(NULL,"zona amarilla"),
(NULL,"zona roja");


SELECT * FROM ubicacion;

INSERT INTO autor VALUES 
(NULL,"Juan", "Carlos", 2, '1987/12/13'),
(NULL,"Pedro", "Alfonso", 1, '1978/02/17'),
(NULL,"Raúl","Perez", 2, '1987/08/06'),
(NULL,"Roberto","Segura", 4, '1984/07/30'),
(NULL,"Romina","Moyano", 1, '1967/05/13'),
(NULL,"Teresa", "Perez", 3, '971/09/14'),
(NULL,"Tamara", "Martinez", 2, '1965/12/23'),
(NULL,"Carolina", "Colorado", 1, '1970/02/21'),
(NULL,"Tania", "Cabas", 2, '1975/08/08'),
(NULL,"Maria", "Recalde", 4, '1984/07/30'),
(NULL,"Camilo", "Gomez", 1, '1967/05/13'),
(NULL,"Nicolas","Milanes", 3, '971/09/14');

-- Accesos de usuarios
USE sys;
SELECT * FROM sys_config;

USE mysql;
SHOW tables;
SELECT * FROM user;

-- Acceso de solo lectura del usuario prueba@localhost
CREATE USER prueba@localhost;
GRANT SELECT ON biblioteca.* TO prueba@localhost;

-- Acceso de solo lectura del usuario prueba2@localhost
CREATE USER prueba2@localhost;
GRANT SELECT ON biblioteca.* TO prueba2@localhost;
GRANT INSERT ON biblioteca.* TO prueba2@localhost;
GRANT UPDATE ON biblioteca.* TO prueba2@localhost;


