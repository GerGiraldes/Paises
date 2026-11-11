-- =====================================================
-- 03 - BD2 - Base de datos de paises y CRUD de paises
-- Para entrar:  sudo mysql
-- Para correr este archivo:  sudo mysql < paises_7A.sql
-- =====================================================

-- 2- Crear la base de datos Paises_7A
CREATE DATABASE IF NOT EXISTS Paises_7A;
USE Paises_7A;

-- 3- Crear las tablas
CREATE TABLE IF NOT EXISTS paises (
    pais_id          INTEGER     NOT NULL PRIMARY KEY,
    pais_descripcion VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS provincias (
    pro_id           INTEGER     NOT NULL PRIMARY KEY,
    pais_id          INTEGER     NOT NULL,
    pro_descripcion  VARCHAR(50) NOT NULL,
    FOREIGN KEY (pais_id) REFERENCES paises(pais_id)
);

-- 4- Cargar todos los paises de Latinoamerica (20 paises)
INSERT INTO paises (pais_id, pais_descripcion) VALUES
(1,  'Argentina'),
(2,  'Bolivia'),
(3,  'Brasil'),
(4,  'Chile'),
(5,  'Colombia'),
(6,  'Costa Rica'),
(7,  'Cuba'),
(8,  'Ecuador'),
(9,  'El Salvador'),
(10, 'Guatemala'),
(11, 'Haiti'),
(12, 'Honduras'),
(13, 'Mexico'),
(14, 'Nicaragua'),
(15, 'Panama'),
(16, 'Paraguay'),
(17, 'Peru'),
(18, 'Republica Dominicana'),
(19, 'Uruguay'),
(20, 'Venezuela');

-- 5- Cargar las provincias de Argentina (23 provincias + CABA)
INSERT INTO provincias (pro_id, pais_id, pro_descripcion) VALUES
(1,  1, 'Buenos Aires'),
(2,  1, 'Ciudad Autonoma de Buenos Aires'),
(3,  1, 'Catamarca'),
(4,  1, 'Chaco'),
(5,  1, 'Chubut'),
(6,  1, 'Cordoba'),
(7,  1, 'Corrientes'),
(8,  1, 'Entre Rios'),
(9,  1, 'Formosa'),
(10, 1, 'Jujuy'),
(11, 1, 'La Pampa'),
(12, 1, 'La Rioja'),
(13, 1, 'Mendoza'),
(14, 1, 'Misiones'),
(15, 1, 'Neuquen'),
(16, 1, 'Rio Negro'),
(17, 1, 'Salta'),
(18, 1, 'San Juan'),
(19, 1, 'San Luis'),
(20, 1, 'Santa Cruz'),
(21, 1, 'Santa Fe'),
(22, 1, 'Santiago del Estero'),
(23, 1, 'Tierra del Fuego'),
(24, 1, 'Tucuman');

-- Usuario para que la aplicacion se conecte (sudo mysql no sirve desde Node)
CREATE USER IF NOT EXISTS 'paises_app'@'localhost' IDENTIFIED BY 'paises123';
GRANT ALL PRIVILEGES ON Paises_7A.* TO 'paises_app'@'localhost';
FLUSH PRIVILEGES;
