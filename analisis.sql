USE tienda_online_unicorn;

-- ============================================================
-- 1. CONTROLES DE CALIDAD DE DATOS
-- ============================================================

-- Cantidad de registros por tabla
SELECT 'Marca' AS Tabla, COUNT(*) AS Registros FROM Marca
UNION ALL
SELECT 'Categoria', COUNT(*) FROM Categoria
UNION ALL
SELECT 'Producto', COUNT(*) FROM Producto
UNION ALL
SELECT 'Cliente', COUNT(*) FROM Cliente
UNION ALL
SELECT 'Venta', COUNT(*) FROM Venta
UNION ALL
SELECT 'Detalle_Venta', COUNT(*) FROM Detalle_Venta;

-- Verificar que no existan ventas anteriores al alta del cliente
SELECT COUNT(*) AS Ventas_Antes_Del_Alta
FROM Venta v
JOIN Cliente c
    ON v.Id_Cliente = c.Id_Cliente
WHERE v.Fecha_Venta < c.Fecha_Alta;

-- Verificar que todas las ventas tengan al menos un detalle
SELECT COUNT(*) AS Ventas_Sin_Detalle
FROM Venta v
LEFT JOIN Detalle_Venta d
    ON v.Id_Venta = d.Id_Venta
WHERE d.Id_Venta IS NULL;

-- Verificar productos repetidos dentro de una misma venta
SELECT COUNT(*) AS Productos_Repetidos_Misma_Venta
FROM (
    SELECT
        Id_Venta,
        Id_Producto
    FROM Detalle_Venta
    GROUP BY Id_Venta, Id_Producto
    HAVING COUNT(*) > 1
) x;

-- Distribución de ventas según estado
SELECT
    Estado_Venta,
    COUNT(*) AS Cantidad_Ventas
FROM Venta
GROUP BY Estado_Venta
ORDER BY Cantidad_Ventas DESC;

-- ============================================================
-- 2. FACTURACIÓN
-- ============================================================

-- ¿Cuánto facturó la tienda?
SELECT
    ROUND(
        SUM(
            d.Precio_Unitario *
            d.Cantidad *
            (1 - d.Descuento_Porcentaje / 100)
        ),
        2
    ) AS Facturacion_Total
FROM Detalle_Venta d
JOIN Venta v
    ON d.Id_Venta = v.Id_Venta
WHERE v.Estado_Venta = 'Entregada';

-- ¿Cómo evolucionó la facturación por mes?
select 
YEAR(v.Fecha_Venta) as anio_venta, 
MONTH(v.Fecha_Venta) as mes_numero,

case month(v.Fecha_Venta)
        when 1 then 'Enero'
        WHEN 2 THEN 'Febrero'
        WHEN 3 THEN 'Marzo'
        WHEN 4 THEN 'Abril'
        WHEN 5 THEN 'Mayo'
        WHEN 6 THEN 'Junio'
        WHEN 7 THEN 'Julio'
        WHEN 8 THEN 'Agosto'
        WHEN 9 THEN 'Septiembre'
        WHEN 10 THEN 'Octubre'
        WHEN 11 THEN 'Noviembre'
        WHEN 12 THEN 'Diciembre'
end as mes_venta,

SUM(d.precio_unitario * d.cantidad*(1- d.Descuento_Porcentaje/100)) as Facturacion

from venta v  
join detalle_venta d on v.Id_Venta= d.Id_Venta

where v.Estado_Venta='Entregada'

GROUP BY
    YEAR(v.Fecha_Venta),
    MONTH(v.Fecha_Venta)

ORDER BY
    YEAR(v.Fecha_Venta),
    MONTH(v.Fecha_Venta);
  
-- ============================================================
-- 3. PRODUCTOS
-- ============================================================
 #¿Cuáles son los 10 productos más vendidos por cantidad de unidades?
    Select 
    p.Id_Producto,
    p.Nombre_Producto,
    sum(d.cantidad) as cantidad_vendida
    from producto p 
    join detalle_venta d on p.Id_Producto = d.Id_Producto 
    join venta v on d.Id_Venta=v.Id_Venta
    where v.Estado_Venta='Entregada'
    GROUP BY p.Id_Producto, p.Nombre_Producto
    order by cantidad_vendida  desc 
    LIMIT 10;

#¿Los productos más vendidos son también los que más facturan?

    with resumen_productos as(
    select 
    p.nombre_producto,
    Sum(d.cantidad) as unidades_vendidas, 
    sum(d.precio_unitario * d.cantidad *(1-d.Descuento_porcentaje/100))as Facturacion
    from producto p
    join detalle_venta d on p.Id_Producto= d.Id_Producto
    join venta v on v.Id_Venta=d.Id_Venta
    where v.Estado_Venta ='Entregada'
    group by p.Id_Producto, p.Nombre_Producto
)
SELECT
    Nombre_Producto,
    Unidades_Vendidas,
    Facturacion,

    DENSE_RANK() OVER (
        ORDER BY Unidades_Vendidas DESC
    ) AS Ranking_Unidades,

    DENSE_RANK() OVER (
        ORDER BY Facturacion DESC
    ) AS Ranking_Facturacion

FROM resumen_productos

ORDER BY Ranking_Unidades;


-- ============================================================
-- 4. CLIENTES
-- ============================================================

#¿Cuáles son los 10 clientes que más facturación generaron?
select 
c.Id_Cliente,
concat(c.Nombre_Cliente,' ',c.Apellido_Cliente) as Nombre_cliente ,
Sum(d.precio_unitario * d.cantidad *(1-d.Descuento_Porcentaje/100)) as facturacion 
from venta v 
join detalle_venta d on d.Id_Venta=v.Id_Venta
join cliente c on c.Id_Cliente = v.Id_Cliente
where v.Estado_Venta='Entregada'
group by c.Id_Cliente, c.Nombre_Cliente
order by facturacion desc
limit  10;

-- ¿Cuáles son los 10 clientes que realizaron mayor cantidad de compras?
select 
c.Id_Cliente,
concat(c.Nombre_Cliente,' ',c.Apellido_Cliente) as Nombre_cliente ,
count(v.Id_Venta) as cantidad_compras
from venta v 
join cliente c on c.Id_Cliente = v.Id_Cliente
where v.Estado_Venta='Entregada'
group by c.Id_Cliente, c.Nombre_Cliente
order by cantidad_compras desc
limit 10;

-- ¿Cuáles son los 10 clientes con mayor ticket promedio?
select 
c.Id_Cliente,
concat(c.Nombre_Cliente,' ',c.Apellido_Cliente) as Nombre_cliente, 
sum(d.precio_unitario * d.cantidad *(1-d.Descuento_porcentaje/100)) / count(distinct v.Id_Venta)  as Ticket_promedio
from venta v 
join detalle_venta d on v.Id_Venta=d.Id_Venta
join cliente c on c.Id_Cliente=v.Id_Cliente
where v.Estado_Venta='Entregada' 
group by c.Id_Cliente
order by ticket_promedio desc
LIMIT 10;

-- ============================================================
-- 5. CANALES Y MÉTODOS DE PAGO
-- ============================================================
-- ¿Qué canal de venta genera mayor facturación: Web o Sucursal?
select
v.canal_venta, 
sum(d.precio_unitario * d.cantidad *(1-d.Descuento_Porcentaje/100))as Facturacion 
from detalle_venta d
join venta v on d.Id_Venta = v.Id_Venta 
where v.Estado_Venta='Entregada'
group by v.Canal_Venta
ORDER BY Facturacion desc; 

-- ¿Cómo evolucionó la facturación de Web y Sucursal a lo largo de los años?
Select
YEAR(v.Fecha_venta)as anio_Facturacion,
v.canal_venta, 
ROUND(
    SUM(
        d.Precio_Unitario * d.Cantidad *
        (1 - d.Descuento_Porcentaje / 100)
    ) / 1000000,
    2
) AS Facturacion_Millones
from detalle_venta d
join venta v on d.Id_Venta = v.Id_Venta 
where v.Estado_Venta='Entregada'
group by v.Canal_Venta , anio_Facturacion
ORDER BY anio_Facturacion desc; 

-- ¿Qué método de pago genera mayor facturación?
select 
v.Metodo_Pago, 
ROUND(
SUM(d.precio_unitario * d.cantidad *(1-d.Descuento_Porcentaje/100)
)/1000000,
2
)AS facturacion
from venta v 
join detalle_venta d on v.Id_Venta=d.Id_Venta
where v.Estado_Venta='Entregada' 
group by v.Metodo_Pago 
order by facturacion desc; 

-- ¿Cómo se distribuyen las compras según el método de pago?
SELECT
v.Metodo_Pago,
COUNT(*) AS Cantidad_Ventas
FROM Venta v
WHERE v.Estado_Venta = 'Entregada'
GROUP BY v.Metodo_Pago
ORDER BY Cantidad_Ventas DESC;

-- ============================================================
-- 6. RENTABILIDAD ESTIMADA
-- ============================================================
-- NOTA:
-- La ganancia es estimada porque Precio_Compra representa el costo actual del producto y no un costo histórico por venta.

-- ¿Cuáles son los 10 productos que generan mayor ganancia estimada?
SELECT
p.Id_Producto,
p.Nombre_Producto,
ROUND(
SUM(
		(
			d.Precio_Unitario *
			(1 - d.Descuento_Porcentaje / 100)
			- p.Precio_Compra
		) * d.Cantidad
	),2
    ) AS Ganancia_Estimada
FROM Producto p
JOIN Detalle_Venta d ON p.Id_Producto = d.Id_Producto
JOIN Venta v ON v.Id_Venta = d.Id_Venta
WHERE v.Estado_Venta = 'Entregada'
GROUP BY
    p.Id_Producto,
    p.Nombre_Producto
ORDER BY Ganancia_Estimada DESC
LIMIT 10;

-- ¿Qué marca genera mayor ganancia estimada?
SELECT
    m.Nombre_Marca,

    ROUND(
        SUM(
            (
                d.Precio_Unitario *
                (1 - d.Descuento_Porcentaje / 100)
                - p.Precio_Compra
            ) * d.Cantidad
        ) / 1000000,
        2
    ) AS Ganancia_Estimada_Millones

FROM Producto p
JOIN Detalle_Venta d
    ON p.Id_Producto = d.Id_Producto
JOIN Venta v
    ON v.Id_Venta = d.Id_Venta
JOIN Marca m
    ON m.Id_Marca = p.Id_Marca

WHERE v.Estado_Venta = 'Entregada'

GROUP BY
    m.Id_Marca,
    m.Nombre_Marca

ORDER BY Ganancia_Estimada_Millones DESC;


-- ¿Qué volumen de unidades vendidas tiene cada marca?
SELECT
    m.Nombre_Marca,
    SUM(d.Cantidad) AS Unidades_Vendidas

FROM Producto p
JOIN Detalle_Venta d
    ON p.Id_Producto = d.Id_Producto
JOIN Venta v
    ON v.Id_Venta = d.Id_Venta
JOIN Marca m
    ON m.Id_Marca = p.Id_Marca

WHERE v.Estado_Venta = 'Entregada'

GROUP BY
    m.Id_Marca,
    m.Nombre_Marca

ORDER BY Unidades_Vendidas DESC;


-- CONSULTA COMPLEMENTARIA:
-- ¿Qué margen estimado presenta cada marca?
-- Se incorpora para comparar ganancia absoluta con rentabilidad relativa.
WITH Rentabilidad_Marca AS (
    SELECT
        m.Id_Marca,
        m.Nombre_Marca,

        SUM(
            d.Precio_Unitario *
            d.Cantidad *
            (1 - d.Descuento_Porcentaje / 100)
        ) AS Facturacion,

        SUM(
            (
                d.Precio_Unitario *
                (1 - d.Descuento_Porcentaje / 100)
                - p.Precio_Compra
            ) * d.Cantidad
        ) AS Ganancia_Estimada

    FROM Producto p
    JOIN Detalle_Venta d
        ON p.Id_Producto = d.Id_Producto
    JOIN Venta v
        ON v.Id_Venta = d.Id_Venta
    JOIN Marca m
        ON m.Id_Marca = p.Id_Marca

    WHERE v.Estado_Venta = 'Entregada'

    GROUP BY
        m.Id_Marca,
        m.Nombre_Marca
)

SELECT
    Nombre_Marca,
    ROUND(Facturacion / 1000000, 2) AS Facturacion_Millones,
    ROUND(Ganancia_Estimada / 1000000, 2) AS Ganancia_Estimada_Millones,

    ROUND(
        Ganancia_Estimada / NULLIF(Facturacion, 0) * 100,
        2
    ) AS Margen_Estimado_Porcentaje

FROM Rentabilidad_Marca

ORDER BY Margen_Estimado_Porcentaje DESC;


-- ============================================================
-- 7. DESCUENTOS
-- ============================================================

-- ¿Existe relación entre el porcentaje de descuento
-- y la cantidad de unidades vendidas?
SELECT
    d.Descuento_Porcentaje,
    COUNT(*) AS Cantidad_Lineas,
    SUM(d.Cantidad) AS Unidades_Vendidas,
    ROUND(AVG(d.Cantidad), 2) AS Unidades_Promedio

FROM Venta v
JOIN Detalle_Venta d
    ON v.Id_Venta = d.Id_Venta

WHERE v.Estado_Venta = 'Entregada'

GROUP BY d.Descuento_Porcentaje

ORDER BY d.Descuento_Porcentaje;



