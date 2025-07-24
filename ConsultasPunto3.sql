DROP DATABASE IF EXISTS ventas;
CREATE DATABASE ventas CHARACTER SET utf8mb4;
USE ventas;
CREATE TABLE cliente (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
apellido1 VARCHAR(100) NOT NULL,
apellido2 VARCHAR(100),
ciudad VARCHAR(100),
categoría INT UNSIGNED
);
CREATE TABLE comercial (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
apellido1 VARCHAR(100) NOT NULL,
apellido2 VARCHAR(100),
comisión FLOAT
);
CREATE TABLE pedido (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
total DOUBLE NOT NULL,
fecha DATE,
id_cliente INT UNSIGNED NOT NULL,
id_comercial INT UNSIGNED NOT NULL,
FOREIGN KEY (id_cliente) REFERENCES cliente(id),
FOREIGN KEY (id_comercial) REFERENCES comercial(id)
);
INSERT INTO cliente VALUES(1, 'Aarón', 'Rivero', 'Gómez', 'Almería', 100);
INSERT INTO cliente VALUES(2, 'Adela', 'Salas', 'Díaz', 'Granada', 200);
INSERT INTO cliente VALUES(3, 'Adolfo', 'Rubio', 'Flores', 'Sevilla', NULL);
INSERT INTO cliente VALUES(4, 'Adrián', 'Suárez', NULL, 'Jaén', 300);
INSERT INTO cliente VALUES(5, 'Marcos', 'Loyola', 'Méndez', 'Almería', 200);
INSERT INTO cliente VALUES(6, 'María', 'Santana', 'Moreno', 'Cádiz', 100);
INSERT INTO cliente VALUES(7, 'Pilar', 'Ruiz', NULL, 'Sevilla', 300);
INSERT INTO cliente VALUES(8, 'Pepe', 'Ruiz', 'Santana', 'Huelva', 200);
INSERT INTO cliente VALUES(9, 'Guillermo', 'López', 'Gómez', 'Granada', 225);
INSERT INTO cliente VALUES(10, 'Daniel', 'Santana', 'Loyola', 'Sevilla', 125);

INSERT INTO comercial VALUES(1, 'Daniel', 'Sáez', 'Vega', 0.15);
INSERT INTO comercial VALUES(2, 'Juan', 'Gómez', 'López', 0.13);
INSERT INTO comercial VALUES(3, 'Diego','Flores', 'Salas', 0.11);
INSERT INTO comercial VALUES(4, 'Marta','Herrera', 'Gil', 0.14);
INSERT INTO comercial VALUES(5, 'Antonio','Carretero', 'Ortega', 0.12);
INSERT INTO comercial VALUES(6, 'Manuel','Domínguez', 'Hernández', 0.13);
INSERT INTO comercial VALUES(7, 'Antonio','Vega', 'Hernández', 0.11);
INSERT INTO comercial VALUES(8, 'Alfredo','Ruiz', 'Flores', 0.05);
INSERT INTO pedido VALUES(1, 150.5, '2017-10-05', 5, 2);
INSERT INTO pedido VALUES(2, 270.65, '2016-09-10', 1, 5);
INSERT INTO pedido VALUES(3, 65.26, '2017-10-05', 2, 1);
INSERT INTO pedido VALUES(4, 110.5, '2016-08-17', 8, 3);
INSERT INTO pedido VALUES(5, 948.5, '2017-09-10', 5, 2);
INSERT INTO pedido VALUES(6, 2400.6, '2016-07-27', 7, 1);
INSERT INTO pedido VALUES(7, 5760, '2015-09-10', 2, 1);
INSERT INTO pedido VALUES(8, 1983.43, '2017-10-10', 4, 6);
INSERT INTO pedido VALUES(9, 2480.4, '2016-10-10', 8, 3);
INSERT INTO pedido VALUES(10, 250.45, '2015-06-27', 8, 2);
INSERT INTO pedido VALUES(11, 75.29, '2016-08-17', 3, 7);
INSERT INTO pedido VALUES(12, 3045.6, '2017-04-25', 2, 1);
INSERT INTO pedido VALUES(13, 545.75, '2019-01-25', 6, 1);
INSERT INTO pedido VALUES(14, 145.82, '2017-02-02', 6, 1);
INSERT INTO pedido VALUES(15, 370.85, '2019-03-11', 1, 5);
INSERT INTO pedido VALUES(16, 2389.23, '2019-03-11', 1, 5);

-- 1. Devuelve un listado que solamente muestre los clientes que no han realizado ningún pedido.

SELECT C.id, C.nombre, C.apellido1, C.apellido2
FROM cliente C
LEFT JOIN pedido P ON C.id = P.id_cliente
WHERE P.id IS NULL;

-- 2. Devuelve un listado que solamente muestre los comerciales que no han realizado ningún pedido.

SELECT 
    C.id, 
    C.nombre, 
    C.apellido1, 
    C.apellido2
FROM comercial C
LEFT JOIN pedido P ON C.id = P.id_comercial
WHERE P.id IS NULL;

-- 3. Devuelve un listado con los clientes que no han realizado ningún pedido y de los comerciales que
-- no han participado en ningún pedido. Ordene el listado alfabéticamente por los apellidos y el
-- nombre. En en listado deberá diferenciar de algún modo los clientes y los comerciales.

-- Clientes sin pedidos
SELECT 
    C.nombre, 
    C.apellido1, 
    C.apellido2, 
    'Cliente' AS tipo
FROM cliente C
LEFT JOIN pedido P ON C.id = P.id_cliente
WHERE P.id IS NULL

UNION

-- Comerciales sin pedidos
SELECT 
    C.nombre, 
    C.apellido1, 
    C.apellido2, 
    'Comercial' AS tipo
FROM comercial C
LEFT JOIN pedido P ON C.id = P.id_comercial
WHERE P.id IS NULL

ORDER BY apellido1, apellido2, nombre;

-- 4. ¿Se podrían realizar las consultas anteriores con NATURAL LEFT JOIN o NATURAL RIGHT JOIN? Justifique
-- su respuesta.

-- No se deben usar NATURAL LEFT JOIN ni NATURAL RIGHT JOIN en estos casos.
-- Justificación:
-- Porque las columnas que deben usarse para unir las tablas (id_cliente, id_comercial)
-- no tienen el mismo nombre que las claves primarias en cliente y comercial, y 
-- NATURAL JOIN solo une por columnas con el mismo nombre en ambas tablas.

-- 5. Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de
-- los clientes. Es decir, el mismo cliente puede haber realizado varios pedidos de diferentes
-- cantidades el mismo día. Se pide que se calcule cuál es el pedido de máximo valor para cada uno
-- de los días en los que un cliente ha realizado un pedido. Muestra el identificador del cliente,
-- nombre, apellidos, la fecha y el valor de la cantidad.


SELECT C.id AS 'ID Cliente', C.nombre AS 'Nombre', C.apellido1 AS 'Apellido 1', C.apellido2 AS 'Apellido 2', P.fecha AS 'Fecha del pedido', MAX(P.total) AS 'Valor máximo del día'
FROM cliente C
INNER JOIN pedido P ON C.id = P.id_cliente
GROUP BY C.id, C.nombre, C.apellido1, C.apellido2, P.fecha
ORDER BY C.id, P.fecha;

-- 6. Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de
-- los clientes, teniendo en cuenta que sólo queremos mostrar aquellos pedidos que superen la
-- cantidad de 2000 €.

SELECT 
    C.id AS 'ID Cliente',
    C.nombre AS 'Nombre',
    C.apellido1 AS 'Apellido 1',
    C.apellido2 AS 'Apellido 2',
    P.fecha AS 'Fecha del pedido',
    MAX(P.total) AS 'Valor máximo del día'
FROM cliente C
INNER JOIN pedido P ON C.id = P.id_cliente
GROUP BY C.id, C.nombre, C.apellido1, C.apellido2, P.fecha
HAVING MAX(P.total) > 2000
ORDER BY C.id, P.fecha;

-- 7. Calcula el máximo valor de los pedidos realizados para cada uno de los comerciales durante la
-- fecha 2016-08-17. Muestra el identificador del comercial, nombre, apellidos y total.

SELECT 
    C.id AS 'ID Comercial',
    C.nombre AS 'Nombre',
    C.apellido1 AS 'Apellido 1',
    C.apellido2 AS 'Apellido 2',
    MAX(P.total) AS 'Valor máximo del pedido'
FROM comercial C
INNER JOIN pedido P ON C.id = P.id_comercial
WHERE P.fecha = '2016-08-17'
GROUP BY C.id, C.nombre, C.apellido1, C.apellido2
ORDER BY C.id;

-- 8. Devuelve un listado con el identificador de cliente, nombre y apellidos y el número total de
-- pedidos que ha realizado cada uno de clientes. Tenga en cuenta que pueden existir clientes que
-- no han realizado ningún pedido. Estos clientes también deben aparecer en el listado indicando
-- que el número de pedidos realizados es 0.

SELECT 
  C.id AS 'ID Cliente',
  C.nombre AS 'Nombre',
  C.apellido1 AS 'Apellido 1',
  C.apellido2 AS 'Apellido 2',
  COUNT(P.id) AS 'Número de pedidos'
FROM cliente C
LEFT JOIN pedido P ON C.id = P.id_cliente
GROUP BY 
  C.id, C.nombre, C.apellido1, C.apellido2
ORDER BY C.id;

-- 9. Devuelve un listado con el identificador de cliente, nombre y apellidos y el número total de
-- pedidos que ha realizado cada uno de clientes durante el año 2017.

SELECT 
  C.id AS 'ID Cliente',
  C.nombre AS 'Nombre',
  C.apellido1 AS 'Apellido 1',
  C.apellido2 AS 'Apellido 2',
  COUNT(P.id) AS 'Pedidos en 2017'
FROM cliente C
LEFT JOIN pedido P 
  ON C.id = P.id_cliente 
  AND YEAR(P.fecha) = 2017
GROUP BY 
  C.id, C.nombre, C.apellido1, C.apellido2
ORDER BY C.id;

-- 10.Devuelve un listado que muestre el identificador de cliente, nombre, primer apellido y el valor de
-- la máxima cantidad del pedido realizado por cada uno de los clientes. El resultado debe mostrar
-- aquellos clientes que no han realizado ningún pedido indicando que la máxima cantidad de sus
-- pedidos realizados es 0. Puede hacer uso de la función IFNULL.

SELECT 
  C.id AS 'ID Cliente',
  C.nombre AS 'Nombre',
  C.apellido1 AS 'Apellido 1',
  IFNULL(MAX(P.cantidad), 0) AS 'Máxima Cantidad Pedido'
FROM cliente C
LEFT JOIN pedido P 
  ON C.id = P.id_cliente
GROUP BY 
  C.id, C.nombre, C.apellido1
ORDER BY C.id;

-- 11. 11.Devuelve cuál ha sido el pedido de máximo valor que se ha realizado cada año.

SELECT 
  YEAR(fecha) AS 'Año',
  id AS 'ID Pedido',
  cantidad AS 'Cantidad'
FROM pedido P
WHERE cantidad = (
  SELECT MAX(cantidad)
  FROM pedido
  WHERE YEAR(fecha) = YEAR(P.fecha)
)
GROUP BY YEAR(fecha);

-- 12.Devuelve el número total de pedidos que se han realizado cada año.

SELECT 
  YEAR(fecha) AS 'Año',
  COUNT(*) AS 'Total Pedidos'
FROM pedido
GROUP BY YEAR(fecha)
ORDER BY Año;

-- 13.Devuelve los datos del cliente que realizó el pedido más caro en el año 2019. (Sin utilizar INNER
-- JOIN)

SELECT *
FROM cliente
WHERE id = (
    SELECT id_cliente
    FROM pedido
    WHERE YEAR(fecha) = 2019
    ORDER BY total DESC
    LIMIT 1
);

-- 14.Devuelve la fecha y la cantidad del pedido de menor valor realizado por el cliente Pepe Ruiz
-- Santana.

SELECT fecha, total
FROM pedido
WHERE id_cliente = (
    SELECT id FROM cliente 
    WHERE nombre = 'Pepe' AND apellido1 = 'Ruiz' AND apellido2 = 'Santana'
)
ORDER BY total ASC
LIMIT 1;

-- 15.Devuelve un listado con los datos de los clientes y los pedidos, de todos los clientes que han
-- realizado un pedido durante el año 2017 con un valor mayor o igual al valor medio de los pedidos
-- realizados durante ese mismo año.

SELECT c.*, p.*
FROM cliente c
JOIN pedido p ON c.id = p.id_cliente
WHERE YEAR(p.fecha) = 2017
  AND p.total >= (
    SELECT AVG(total)
    FROM pedido
    WHERE YEAR(fecha) = 2017
);


-- 16.Devuelve el pedido más caro que existe en la tabla pedido si hacer uso de MAX, ORDER BY ni LIMIT.

SELECT *
FROM pedido p1
WHERE NOT EXISTS (
    SELECT * FROM pedido p2
    WHERE p2.total > p1.total
);


-- 17.Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando ANY o ALL).

SELECT *
FROM cliente
WHERE id <> ALL (SELECT id_cliente FROM pedido);


-- 18.Devuelve un listado de los comerciales que no han realizado ningún pedido. (Utilizando ANY o ALL).

SELECT *
FROM comercial
WHERE id <> ALL (SELECT id_comercial FROM pedido);


-- 19.Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando IN o NOT IN).

SELECT *
FROM cliente
WHERE id NOT IN (SELECT id_cliente FROM pedido);


-- 20.Devuelve un listado de los comerciales que no han realizado ningún pedido. (Utilizando IN o NOT
-- IN).

SELECT *
FROM comercial
WHERE id NOT IN (SELECT id_comercial FROM pedido);


-- 21.Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando EXISTS o NOT
-- EXISTS).

SELECT *
FROM cliente c
WHERE NOT EXISTS (
    SELECT 1
    FROM pedido p
    WHERE p.id_cliente = c.id
);
























