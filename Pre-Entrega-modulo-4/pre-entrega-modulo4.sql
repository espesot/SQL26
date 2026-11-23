--1
-- La sentencia SELECT trae un informe por categoria de la cantidad de productos que se vendio en cada categoria y el monto total que es decir, 
-- es la sumatoria de la cantidad de productos por el precio agrupado por categoria
-- para eso de la tabla VENTAS obtenemos la suma de las cantidades de productos vendido, como no tenemos el precio debemos relacionar la tabla ventas con producto 
-- entonces el total sale de la suma del precio que esta en la tabla productos y la cantidad que esta en la tabla ventas
-- ademas tenemos que unir la tabla producto con la de categoria para traer el nobre de las categoria que tiene los productos,
-- los agrupamos por el nombre y hacemos un filtro despues del calculo por eso usamos HAVING para traer solo las categoria que vendieron mas de 5 productos

SELECT c.nombre_categoria AS Categoria, SUM(v.cantidad) AS cantidad, SUM(p.precio * v.cantidad) as Total
FROM ventas AS v 
	INNER JOIN productos AS p ON (v.producto_id = p.producto_id)
	INNER JOIN categorias AS c ON (c.categoria_id = p.id_categoria)
GROUP BY c.nombre_categoria
HAVING SUM(v.cantidad) >5;


--2
-- Este es un informe que trae todo los clientes que aun no realizaron ninguna compra 
-- para eso de la tabla cliente traemos le nombre y el id usamos un LEFT JOIN con la tabla ventas y traemos aquellos casos
-- donde el left join que trae todos los clinetes donde en el campo clinete_id de la tabla ventas es NULL 

SELECT c.nombre as cliente, c.cliente_id AS id, COALESCE(v.cliente_id, 0) AS pedido 
FROM clientes AS c
LEFT JOIN ventas v ON (c.cliente_id = v.cliente_id)
WHERE v.cliente_id IS NULL
ORDER BY c.cliente_id;


--3
-- Este informe trae todos los clientes con el producto que mas compraron y la ultima fecha,
-- para eso se debe hacer un select anidado, el primer select corresponde al nombre del cliente, el segundo que va dentro del primero trae el nombre del producto
-- cuyas cantidad es la mayor de la tabla ventas que el cliente compro. 
-- ademas se incluye otro select que selecciona la fecha mayor para obtener cuando fue la ultima vez que el clinete realizo una compra 

SELECT c.nombre AS cliente,
	(SELECT p.nombre AS producto
	FROM ventas AS v
	INNER JOIN productos p ON(v.producto_id = p.producto_id)
	WHERE v.cliente_id = c.cliente_id
	ORDER BY  v.cantidad DESC
	LIMIT 1) AS MAS_COMPRADO,
		(SELECT MAX(v2.fecha)AS ultima_compra
		FROM ventas AS v2
		WHERE v2.cliente_id = c.cliente_id)
FROM clientes c;
