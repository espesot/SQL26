-- 1 Crear DB
CREATE DATABASE retail_project;

-- 2 Creacion de tablas 
-- clientes
CREATE TABLE clientes(
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(100),
  email VARCHAR(100) NOT NULL UNIQUE,
  edad INT,
  activo BOOLEAN,
  fecha_baja DATE DEFAULT NULL,
  CONSTRAINT chk_edad CHECK (edad >= 18)
);
-- productos
CREATE TABLE productos(
  id SERIAL PRIMARY KEY,
  codigo VARCHAR(50) NOT NULL UNIQUE,
  nombre VARCHAR(100),
  precio DECIMAL(10,2) NOT NULL,
  stock INTEGER NOT NULL,
  categoria VARCHAR(20) NOT NULL,
  CONSTRAINT chk_precio CHECK (precio > 0),
  CONSTRAINT chk_stock CHECK (stock >= 0)
);
-- Ventas
CREATE TABLE ventas(
  id SERIAL PRIMARY KEY,
  cantidad INT NOT NULL,
  cliente_id INT,
  producto_id INT,
  CONSTRAINT chk_cantidad CHECK(cantidad>0),
  CONSTRAINT fk_ventas_clientes
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
  CONSTRAINT fk_ventas_productos
    FOREIGN KEY (producto_id) REFERENCES productos(id) 
);
-- 5
 
BEGIN; 
INSERT INTO clientes(nombre,email,edad ,activo) VALUES
('Pepe','pepe@cliente.com',20,true),
('Juan','Juan@cliente.com',30,true),
('Maria','Maria@cliente.com',40,true),
('Ana','Ana@cliente.com',20,true),
('Martin','Martin@cliente.com',20,true);
COMMIT;


INSERT INTO productos(codigo,nombre,precio,stock,categoria) VALUES
('ART20','Sillon',20000,5,'Hogar'),
('ART21','Mesa',30000,4,'Hogar'),
('ART22','Televisor',80000,5,'Electonico'),
('ART23','Notebook',200000,10,'Electronico'),
('ART24','Escritorio',50000,3,'Oficina');


BEGIN;
INSERT INTO ventas (cantidad,cliente_id,producto_id) VALUES
(2,1,3),
(4,1,2),
(1,1,4),
(2,2,1),
(1,3,3);
COMMIT;

-- 6
BEGIN;
UPDATE productos
SET precio = precio * 1.1 -- aumentamamos un 10%
WHERE categoria = 'Hogar'; 
COMMIT;

BEGIN;
DELETE FROM ventas
WHERE id = 1; 
COMMIT;