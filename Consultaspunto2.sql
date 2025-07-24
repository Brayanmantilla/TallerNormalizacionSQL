-- -----------------------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------- PUNTO 2 ----------------------------------------------------------------------------------------

DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;
CREATE TABLE fabricante (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL
);
CREATE TABLE producto (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
precio DOUBLE NOT NULL,
id_fabricante INT UNSIGNED NOT NULL,
FOREIGN KEY (id_fabricante) REFERENCES fabricante(id)
);
INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');
INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

-- 1. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.

SELECT F.nombre as 'Nombre Fabricante', P.nombre as 'Nombre Producto', P.precio 
FROM fabricante F
INNER JOIN producto P
ON F.id = P.id_fabricante;

-- 2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos
-- de la base de datos. Ordene el resultado por el nombre del fabricante, por orden alfabético.

SELECT F.nombre as 'Nombre Fabricante', P.nombre as 'Nombre Producto', P.precio 
FROM fabricante F
INNER JOIN producto P
ON F.id = P.id_fabricante 
ORDER BY F.nombre;

-- 3. Devuelve una lista con el identificador del producto, nombre del producto, identificador del
-- fabricante y nombre del fabricante, de todos los productos de la base de datos.

SELECT F.id, F.nombre, P.id, P.nombre 
FROM fabricante F
INNER JOIN producto P
ON F.id = P.id_fabricante;

-- 4.Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.

SELECT P.nombre AS 'Nombre Producto', P.precio, F.nombre as 'Nombre Fabricante' 
FROM fabricante F
INNER JOIN producto P
ON F.id = P.id_fabricante
ORDER BY P.precio ASC
LIMIT 1;


-- 5. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.

SELECT P.nombre AS 'Nombre Producto', P.precio, F.nombre as 'Nombre Fabricante' 
FROM fabricante F
INNER JOIN producto P
ON F.id = P.id_fabricante
ORDER BY P.precio DESC
LIMIT 1;

-- 6. Devuelve una lista de todos los productos del fabricante Lenovo.

SELECT P.nombre as 'Nombre producto', F.nombre as 'Nombre Fabricante'
FROM fabricante F
INNER JOIN producto P
ON F.id = P.id_fabricante
WHERE F.nombre = 'Lenovo';

-- 7. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.

SELECT P.nombre as 'Nombre producto', F.nombre as 'Nombre Fabricante', P.precio 
FROM fabricante F
INNER JOIN producto P
ON F.id = P.id_fabricante
WHERE F.nombre = 'Crucial' and P.precio > 200;

-- 8. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Sin
-- utilizar el operador IN.

SELECT P.nombre as 'Nombre producto', F.nombre as 'Nombre Fabricante'
FROM fabricante F
INNER JOIN producto P
ON F.id = P.id_fabricante
WHERE F.nombre = 'Crucial' or F.nombre = 'Hewlett-Packard' or F.nombre = 'Seagate';

-- 9. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate.
-- Utilizando el operador IN.

SELECT P.nombre as 'Nombre producto', F.nombre as 'Nombre Fabricante'
FROM fabricante F
INNER JOIN producto P
ON F.id = P.id_fabricante
WHERE F.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');

-- 10. Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre
-- termine por la vocal e.


SELECT P.nombre as 'Nombre producto', P.precio , F.nombre as 'Nombre Fabricante'
FROM fabricante F
INNER JOIN producto P
ON F.id = P.id_fabricante
WHERE F.nombre LIKE '%e';

-- 11.Devuelve un listado con los nombres de los fabricantes que tienen 2 o más productos.
 
SELECT F.nombre AS 'Nombre Fabricante', COUNT(P.id) AS 'Cantidad de productos'
FROM fabricante F
INNER JOIN producto P ON F.id = P.id_fabricante
GROUP BY F.id, F.nombre
HAVING COUNT(P.id) >= 2;

-- 12.Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada
-- uno con un precio superior o igual a 220 €. No es necesario mostrar el nombre de los fabricantes
-- que no tienen productos que cumplan la condición.

SELECT F.nombre AS 'Nombre Fabricante', COUNT(P.id) AS 'Cantidad de productos ≥ 220 €'
FROM fabricante F
INNER JOIN producto P ON F.id = P.id_fabricante
WHERE P.precio >= 220
GROUP BY F.id, F.nombre;

-- 13.Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada
-- uno con un precio superior o igual a 220 €. El listado debe mostrar el nombre de todos los
-- fabricantes, es decir, si hay algún fabricante que no tiene productos con un precio superior o igual
-- a 220€ deberá aparecer en el listado con un valor igual a 0 en el número de productos.

SELECT F.nombre AS 'Nombre Fabricante', COUNT(CASE WHEN P.precio >= 220 THEN 1 END) AS 'Cantidad de productos ≥ 220 €'
FROM fabricante F
LEFT JOIN producto P ON F.id = P.id_fabricante
GROUP BY F.id, F.nombre;

-- 14.Devuelve un listado con los nombres de los fabricantes donde la suma del precio de todos sus
-- productos es superior a 1000 €.

SELECT F.nombre AS 'Nombre Fabricante', SUM(P.precio) AS 'Suma total de precios'
FROM fabricante F
INNER JOIN producto P ON F.id = P.id_fabricante
GROUP BY F.id, F.nombre
HAVING SUM(P.precio) > 1000;

-- 15.Devuelve un listado con el nombre del producto más caro que tiene cada fabricante. El resultado
-- debe tener tres columnas: nombre del producto, precio y nombre del fabricante. El resultado tiene
-- que estar ordenado alfabéticamente de menor a mayor por el nombre del fabricante.

SELECT P.nombre AS 'Nombre del producto', P.precio AS 'Precio', F.nombre AS 'Fabricante'
FROM producto P
INNER JOIN fabricante F ON P.id_fabricante = F.id
INNER JOIN (
    SELECT 
        id_fabricante,
        MAX(precio) AS max_precio
    FROM producto
    GROUP BY id_fabricante
) AS Sub ON P.id_fabricante = Sub.id_fabricante AND P.precio = Sub.max_precio
ORDER BY F.nombre ASC;

-- 16.Devuelve el producto más caro que existe en la tabla producto sin hacer uso de MAX, ORDER
-- BY ni LIMIT. 

SELECT P.nombre AS 'Nombre del producto', P.precio AS 'Precio'
FROM producto P
WHERE NOT EXISTS (
    SELECT 1 
    FROM producto P2 
    WHERE P2.precio > P.precio
);

-- 17.Devuelve el producto más barato que existe en la tabla producto sin hacer uso de MIN, ORDER BY ni LIMIT.

SELECT P.nombre AS 'Nombre del producto', P.precio AS 'Precio'
FROM producto P
WHERE NOT EXISTS (
    SELECT 1 
    FROM producto P2 
    WHERE P2.precio < P.precio
);

-- 18.Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando ALL o ANY).

SELECT nombre
FROM fabricante
WHERE id = ANY (
    SELECT id_fabricante
    FROM producto
);

-- 19.Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando ALL o ANY).

SELECT nombre
FROM fabricante
WHERE id <> ALL (
    SELECT id_fabricante
    FROM producto
);

-- 20. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).

SELECT nombre
FROM fabricante
WHERE id IN (
    SELECT id_fabricante
    FROM producto
);



















