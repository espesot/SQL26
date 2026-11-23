## CODERHOUSE

### Practica N 4
### Alumno: Spesot Enzo

#### Consultas multicapas para analisis de negocio


#### 1 Rentablidad por categoria
>Para este informe que nos trae todas las categorias que existen y en cada categoria nos muestra la cantidad de productos que se vendieron y el monto que eso implica,
  - Traer el nombre de las categorias **c.nombre_categoria**
  - Sumas las cantidades vendidas
  - Sumas el resultado del precio del prodcuto **p.preci** por la cantidad vendida **v.cantidad**
  - Realizar **INNER JOIN**
    - ventas con productos **v.producto_id = p.producto_id**
    - productos con categoria **c.categoria_id = p.id_categoria**
  - Hacer un **group by** por nombre de categoria
  - hacer un filtro por la catidad de deseamos ver 
En este caso se usa un **HAVING** ya que es un filtro que se haces despues del calculo, y proponemos ver las categorias que vendieron mas de 5 prodcutos

```sql
SELECT c.nombre_categoria AS Categoria, SUM(v.cantidad) AS cantidad, SUM(p.precio * v.cantidad) as Total
FROM ventas AS v 
	INNER JOIN productos AS p ON (v.producto_id = p.producto_id)
	INNER JOIN categorias AS c ON (c.categoria_id = p.id_categoria)
GROUP BY c.nombre_categoria
HAVING SUM(v.cantidad) >5;
```

#### 2 Clientes sin compras
>Este informe nos trae todos los clientes que no realizaron ninguna compra hasta el momento de la consulta
- Seleccionamos el nombre y el id de la tabla **clientes** 
- Hacemos un **LEFT JOIN** con ventas
  - al hacer el **LEFT JOIN** nos trae todos los clientes de la tabla izquierda sin importar si tiene o no elemento de relacion con la tabla derecha
- hacemos un filtro en este caso **where** donde el clinte_id en ventas **IS NULL**

```sql
SELECT c.nombre as cliente, c.cliente_id AS id, COALESCE(v.cliente_id, 0) AS pedido 
FROM clientes AS c
LEFT JOIN ventas v ON (c.cliente_id = v.cliente_id)
WHERE v.cliente_id IS NULL
ORDER BY c.cliente_id;
```

#### 3 Top de compas por cliente
>Este informe nos indica cual fue el producto que mas compro cada cliente
Se hace un select de cliente y dentro se hace una subconsulta donde obtenemos el nombre del producto donde la cantidad comprada fue mayor y le colocamos un **LIMIT 1** para que nos traiga el primero
ademas hacemos un nuevo select para obtener la mayor fecha de la tabla ventas de cada cliente con esto obtemeos la ultima fecha de compra 

```sql
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
```



