USE tienda_online_unicorn;

-- ============================================================
-- 1. CARGA DE MARCAS Y CATEGORÍAS
-- ============================================================

INSERT INTO Marca (Nombre_Marca)
VALUES
    ('Adidas'),
    ('Nike'),
    ('Puma'),
    ('Under Armour'),
    ('Reebok');

INSERT INTO Categoria (Nombre_Categoria)
VALUES
    ('Calzado'),
    ('Indumentaria'),
    ('Accesorios'),
    ('Equipamiento Deportivo');


-- ============================================================
-- 2. GENERACIÓN DE 1.000 PRODUCTOS
-- ============================================================

INSERT INTO Producto (
    Nombre_Producto,
    Precio,
    Id_Marca,
    Id_Categoria,
    Precio_Compra
)

WITH RECURSIVE numeros AS (
    SELECT 1 AS n

    UNION ALL

    SELECT n + 1
    FROM numeros
    WHERE n < 1000
),

base AS (
    SELECT
        n,

        CASE
            WHEN MOD(n - 1, 20) BETWEEN 0 AND 7 THEN 2
            WHEN MOD(n - 1, 20) BETWEEN 8 AND 12 THEN 1
            WHEN MOD(n - 1, 20) BETWEEN 13 AND 16 THEN 3
            ELSE 4
        END AS Id_Categoria,

        MOD(n - 1, 5) + 1 AS Id_Marca

    FROM numeros
),

datos_producto AS (
    SELECT
        n,
        Id_Categoria,
        Id_Marca,

        CASE Id_Marca
            WHEN 1 THEN 'Adidas'
            WHEN 2 THEN 'Nike'
            WHEN 3 THEN 'Puma'
            WHEN 4 THEN 'Under Armour'
            WHEN 5 THEN 'Reebok'
        END AS Marca,

        CASE Id_Categoria
            WHEN 1 THEN
                CASE MOD(n - 1, 5)
                    WHEN 0 THEN 'Zapatillas Running'
                    WHEN 1 THEN 'Zapatillas Training'
                    WHEN 2 THEN 'Botines'
                    WHEN 3 THEN 'Zapatillas Urbanas'
                    WHEN 4 THEN 'Zapatillas Tenis'
                END

            WHEN 2 THEN
                CASE MOD(n - 1, 8)
                    WHEN 0 THEN 'Remera'
                    WHEN 1 THEN 'Musculosa'
                    WHEN 2 THEN 'Short'
                    WHEN 3 THEN 'Buzo'
                    WHEN 4 THEN 'Campera'
                    WHEN 5 THEN 'Pantalon'
                    WHEN 6 THEN 'Calza'
                    WHEN 7 THEN 'Top'
                END

            WHEN 3 THEN
                CASE MOD(n - 1, 5)
                    WHEN 0 THEN 'Mochila'
                    WHEN 1 THEN 'Gorra'
                    WHEN 2 THEN 'Rinonera'
                    WHEN 3 THEN 'Medias'
                    WHEN 4 THEN 'Botella'
                END

            WHEN 4 THEN
                CASE MOD(n - 1, 5)
                    WHEN 0 THEN 'Pelota'
                    WHEN 1 THEN 'Colchoneta'
                    WHEN 2 THEN 'Bandas Elasticas'
                    WHEN 3 THEN 'Soga'
                    WHEN 4 THEN 'Mancuernas'
                END
        END AS Tipo_Producto,

        CASE MOD(n - 1, 10)
            WHEN 0 THEN 'Essentials'
            WHEN 1 THEN 'Performance'
            WHEN 2 THEN 'Pro'
            WHEN 3 THEN 'Active'
            WHEN 4 THEN 'Training'
            WHEN 5 THEN 'Core'
            WHEN 6 THEN 'Motion'
            WHEN 7 THEN 'Flex'
            WHEN 8 THEN 'Elite'
            WHEN 9 THEN 'Tech'
        END AS Modelo,

        CASE
            WHEN Id_Categoria = 1
                THEN 79999 + MOD(n * 7000, 90000)

            WHEN Id_Categoria = 2
                THEN 39999 + MOD(n * 5000, 90000)

            WHEN Id_Categoria = 3
                THEN 19999 + MOD(n * 3500, 55000)

            WHEN Id_Categoria = 4
                THEN 24999 + MOD(n * 6000, 100000)
        END AS Precio

    FROM base
)

SELECT
    CONCAT(
        Tipo_Producto, ' ',
        Marca, ' ',
        Modelo, ' ',
        LPAD(n, 3, '0')
    ) AS Nombre_Producto,

    Precio,
    Id_Marca,
    Id_Categoria,

    ROUND(
        Precio * (0.55 + MOD(n, 8) * 0.015),
        2
    ) AS Precio_Compra

FROM datos_producto;


-- ============================================================
-- 3. GENERACIÓN DE 5.000 CLIENTES
-- ============================================================

INSERT INTO Cliente (
    Nombre_Cliente,
    Apellido_Cliente,
    Fecha_Nacimiento,
    Email,
    Direccion,
    Ciudad,
    Provincia,
    Codigo_Postal,
    Fecha_Alta
)

WITH digitos AS (
    SELECT 0 AS d UNION ALL
    SELECT 1 UNION ALL
    SELECT 2 UNION ALL
    SELECT 3 UNION ALL
    SELECT 4 UNION ALL
    SELECT 5 UNION ALL
    SELECT 6 UNION ALL
    SELECT 7 UNION ALL
    SELECT 8 UNION ALL
    SELECT 9
),

numeros AS (
    SELECT
        1
        + u.d
        + t.d * 10
        + h.d * 100
        + m.d * 1000 AS n

    FROM digitos u
    CROSS JOIN digitos t
    CROSS JOIN digitos h
    CROSS JOIN digitos m

    WHERE
        1
        + u.d
        + t.d * 10
        + h.d * 100
        + m.d * 1000 <= 5000
),

datos_cliente AS (
    SELECT
        n,

        CASE MOD(n - 1, 20)
            WHEN 0 THEN 'Sofia'
            WHEN 1 THEN 'Martin'
            WHEN 2 THEN 'Valentina'
            WHEN 3 THEN 'Nicolas'
            WHEN 4 THEN 'Camila'
            WHEN 5 THEN 'Lucas'
            WHEN 6 THEN 'Julieta'
            WHEN 7 THEN 'Mateo'
            WHEN 8 THEN 'Agustina'
            WHEN 9 THEN 'Franco'
            WHEN 10 THEN 'Martina'
            WHEN 11 THEN 'Tomas'
            WHEN 12 THEN 'Lucia'
            WHEN 13 THEN 'Joaquin'
            WHEN 14 THEN 'Carolina'
            WHEN 15 THEN 'Federico'
            WHEN 16 THEN 'Micaela'
            WHEN 17 THEN 'Santiago'
            WHEN 18 THEN 'Florencia'
            WHEN 19 THEN 'Gonzalo'
        END AS Nombre_Cliente,

        CASE MOD(FLOOR((n - 1) / 20), 20)
            WHEN 0 THEN 'Gonzalez'
            WHEN 1 THEN 'Rodriguez'
            WHEN 2 THEN 'Fernandez'
            WHEN 3 THEN 'Lopez'
            WHEN 4 THEN 'Martinez'
            WHEN 5 THEN 'Romero'
            WHEN 6 THEN 'Diaz'
            WHEN 7 THEN 'Alvarez'
            WHEN 8 THEN 'Sosa'
            WHEN 9 THEN 'Torres'
            WHEN 10 THEN 'Ruiz'
            WHEN 11 THEN 'Ramirez'
            WHEN 12 THEN 'Flores'
            WHEN 13 THEN 'Acosta'
            WHEN 14 THEN 'Benitez'
            WHEN 15 THEN 'Medina'
            WHEN 16 THEN 'Herrera'
            WHEN 17 THEN 'Suarez'
            WHEN 18 THEN 'Castro'
            WHEN 19 THEN 'Molina'
        END AS Apellido_Cliente,

        MOD(n * 7, 12) AS Ubicacion

    FROM numeros
)

SELECT
    Nombre_Cliente,
    Apellido_Cliente,

    DATE_ADD(
        '1960-01-01',
        INTERVAL MOD(n * 977, 16400) DAY
    ) AS Fecha_Nacimiento,

    CONCAT(
        LOWER(Nombre_Cliente),
        '.',
        LOWER(Apellido_Cliente),
        LPAD(n, 4, '0'),
        '@mail.com'
    ) AS Email,

    CONCAT(
        CASE MOD(n, 10)
            WHEN 0 THEN 'San Martin '
            WHEN 1 THEN 'Belgrano '
            WHEN 2 THEN 'Rivadavia '
            WHEN 3 THEN 'Sarmiento '
            WHEN 4 THEN 'Mitre '
            WHEN 5 THEN 'Lavalle '
            WHEN 6 THEN '25 de Mayo '
            WHEN 7 THEN 'Colon '
            WHEN 8 THEN 'Las Heras '
            WHEN 9 THEN 'Maipu '
        END,
        MOD(n * 37, 4500) + 100
    ) AS Direccion,

    CASE Ubicacion
        WHEN 0 THEN 'San Miguel de Tucuman'
        WHEN 1 THEN 'Yerba Buena'
        WHEN 2 THEN 'Cordoba'
        WHEN 3 THEN 'Rosario'
        WHEN 4 THEN 'Salta'
        WHEN 5 THEN 'Mendoza'
        WHEN 6 THEN 'CABA'
        WHEN 7 THEN 'Mar del Plata'
        WHEN 8 THEN 'San Salvador de Jujuy'
        WHEN 9 THEN 'Neuquen'
        WHEN 10 THEN 'Resistencia'
        WHEN 11 THEN 'Posadas'
    END AS Ciudad,

    CASE Ubicacion
        WHEN 0 THEN 'Tucuman'
        WHEN 1 THEN 'Tucuman'
        WHEN 2 THEN 'Cordoba'
        WHEN 3 THEN 'Santa Fe'
        WHEN 4 THEN 'Salta'
        WHEN 5 THEN 'Mendoza'
        WHEN 6 THEN 'Buenos Aires'
        WHEN 7 THEN 'Buenos Aires'
        WHEN 8 THEN 'Jujuy'
        WHEN 9 THEN 'Neuquen'
        WHEN 10 THEN 'Chaco'
        WHEN 11 THEN 'Misiones'
    END AS Provincia,

    CASE Ubicacion
        WHEN 0 THEN '4000'
        WHEN 1 THEN '4107'
        WHEN 2 THEN '5000'
        WHEN 3 THEN '2000'
        WHEN 4 THEN '4400'
        WHEN 5 THEN '5500'
        WHEN 6 THEN '1000'
        WHEN 7 THEN '7600'
        WHEN 8 THEN '4600'
        WHEN 9 THEN '8300'
        WHEN 10 THEN '3500'
        WHEN 11 THEN '3300'
    END AS Codigo_Postal,

    DATE_SUB(
        '2026-08-11',
        INTERVAL MOD(n * 53, 900) DAY
    ) AS Fecha_Alta

FROM datos_cliente;


-- ============================================================
-- 4. GENERACIÓN DE 25.000 VENTAS
-- ============================================================

START TRANSACTION;

INSERT INTO Venta (
    Id_Cliente,
    Fecha_Venta,
    Metodo_Pago,
    Canal_Venta,
    Estado_Venta
)

WITH
digitos AS (
    SELECT 0 AS d UNION ALL
    SELECT 1 UNION ALL
    SELECT 2 UNION ALL
    SELECT 3 UNION ALL
    SELECT 4 UNION ALL
    SELECT 5 UNION ALL
    SELECT 6 UNION ALL
    SELECT 7 UNION ALL
    SELECT 8 UNION ALL
    SELECT 9
),

numeros AS (
    SELECT
        1
        + u.d
        + t.d * 10
        + h.d * 100
        + m.d * 1000
        + dm.d * 10000 AS n

    FROM digitos u
    CROSS JOIN digitos t
    CROSS JOIN digitos h
    CROSS JOIN digitos m
    CROSS JOIN digitos dm

    WHERE
        1
        + u.d
        + t.d * 10
        + h.d * 100
        + m.d * 1000
        + dm.d * 10000 <= 25000
),

clientes_numerados AS (
    SELECT
        Id_Cliente,
        Fecha_Alta,
        ROW_NUMBER() OVER (ORDER BY Id_Cliente) AS rn

    FROM Cliente
),

total_clientes AS (
    SELECT COUNT(*) AS cantidad
    FROM Cliente
),

base AS (
    SELECT
        n,

        CASE
            WHEN MOD(n, 10) < 7
                THEN 1 + MOD(n * 173, 3000)
            ELSE
                3001 + MOD(n * 97, t.cantidad - 3000)
        END AS rn_cliente,

        CASE
            WHEN MOD(n * 37, 100) < 38 THEN 2024
            WHEN MOD(n * 37, 100) < 75 THEN 2025
            ELSE 2026
        END AS Anio,

        MOD(n * 13, 100) AS Selector_Mes

    FROM numeros
    CROSS JOIN total_clientes t
),

meses AS (
    SELECT
        *,

        CASE
            WHEN Anio = 2026 THEN
                1 + MOD(Selector_Mes, 8)

            WHEN Selector_Mes < 8 THEN 1
            WHEN Selector_Mes < 15 THEN 2
            WHEN Selector_Mes < 23 THEN 3
            WHEN Selector_Mes < 31 THEN 4
            WHEN Selector_Mes < 39 THEN 5
            WHEN Selector_Mes < 47 THEN 6
            WHEN Selector_Mes < 55 THEN 7
            WHEN Selector_Mes < 63 THEN 8
            WHEN Selector_Mes < 71 THEN 9
            WHEN Selector_Mes < 79 THEN 10
            WHEN Selector_Mes < 89 THEN 11
            ELSE 12
        END AS Mes

    FROM base
),

fechas AS (
    SELECT
        *,

        STR_TO_DATE(
            CONCAT(
                Anio, '-',
                LPAD(Mes, 2, '0'), '-',
                LPAD(
                    CASE
                        WHEN Anio = 2026 AND Mes = 8
                            THEN 1 + MOD(n * 17, 11)
                        ELSE
                            1 + MOD(n * 17, 28)
                    END,
                    2,
                    '0'
                )
            ),
            '%Y-%m-%d'
        ) AS Fecha_Candidata

    FROM meses
),

ventas_generadas AS (
    SELECT
        f.n,
        c.Id_Cliente,

        GREATEST(
            f.Fecha_Candidata,
            c.Fecha_Alta
        ) AS Fecha_Venta

    FROM fechas f
    JOIN clientes_numerados c
        ON c.rn = f.rn_cliente
)

SELECT
    Id_Cliente,
    Fecha_Venta,

    CASE
        WHEN MOD(n * 11, 100) < 40 THEN 'Tarjeta Credito'
        WHEN MOD(n * 11, 100) < 65 THEN 'Tarjeta Debito'
        WHEN MOD(n * 11, 100) < 85 THEN 'Transferencia'
        ELSE 'Efectivo'
    END AS Metodo_Pago,

    CASE
        WHEN YEAR(Fecha_Venta) = 2024 THEN
            CASE
                WHEN MOD(n * 17, 100) < 50 THEN 'Web'
                ELSE 'Sucursal'
            END

        WHEN YEAR(Fecha_Venta) = 2025 THEN
            CASE
                WHEN MOD(n * 17, 100) < 60 THEN 'Web'
                ELSE 'Sucursal'
            END

        ELSE
            CASE
                WHEN MOD(n * 17, 100) < 70 THEN 'Web'
                ELSE 'Sucursal'
            END
    END AS Canal_Venta,

    CASE
        WHEN MOD(n * 19, 100) < 90 THEN 'Entregada'
        WHEN MOD(n * 19, 100) < 96 THEN 'Cancelada'
        ELSE 'Pendiente'
    END AS Estado_Venta

FROM ventas_generadas;

COMMIT;


-- ============================================================
-- 5. GENERACIÓN DE DETALLES DE VENTA
-- ============================================================

START TRANSACTION;

INSERT INTO Detalle_Venta (
    Id_Venta,
    Id_Producto,
    Cantidad,
    Precio_Unitario,
    Descuento_Porcentaje
)

WITH

ventas_numeradas AS (
    SELECT
        v.Id_Venta,
        v.Fecha_Venta,
        ROW_NUMBER() OVER (ORDER BY v.Id_Venta) AS rn

    FROM Venta v
),

ventas_config AS (
    SELECT
        *,

        CASE
            WHEN MOD(rn * 29, 100) < 15 THEN 1
            WHEN MOD(rn * 29, 100) < 40 THEN 2
            WHEN MOD(rn * 29, 100) < 70 THEN 3
            WHEN MOD(rn * 29, 100) < 90 THEN 4
            ELSE 5
        END AS Cantidad_Lineas

    FROM ventas_numeradas
),

lineas AS (
    SELECT 1 AS linea
    UNION ALL SELECT 2
    UNION ALL SELECT 3
    UNION ALL SELECT 4
    UNION ALL SELECT 5
),

productos_numerados AS (
    SELECT
        Id_Producto,
        Precio,
        ROW_NUMBER() OVER (ORDER BY Id_Producto) AS rn_producto

    FROM Producto
),

total_productos AS (
    SELECT COUNT(*) AS cantidad
    FROM Producto
),

base AS (
    SELECT
        v.Id_Venta,
        v.Fecha_Venta,
        v.rn,
        l.linea,

        CASE
            WHEN MOD(v.rn * 19 + l.linea * 23, 100) < 60
                THEN
                    1 + MOD(
                        v.rn * 37 + l.linea * 113,
                        FLOOR(tp.cantidad * 0.30)
                    )

            ELSE
                FLOOR(tp.cantidad * 0.30) + 1
                + MOD(
                    v.rn * 41 + l.linea * 127,
                    tp.cantidad - FLOOR(tp.cantidad * 0.30)
                )
        END AS rn_producto,

        CASE
            WHEN MOD(v.rn * 31 + l.linea * 17, 100) < 70 THEN 1
            WHEN MOD(v.rn * 31 + l.linea * 17, 100) < 90 THEN 2
            WHEN MOD(v.rn * 31 + l.linea * 17, 100) < 98 THEN 3
            ELSE 4
        END AS Cantidad,

        CASE
            WHEN MONTH(v.Fecha_Venta) = 11
                 AND MOD(v.rn * 13 + l.linea * 7, 100) < 50
                THEN 20

            WHEN MONTH(v.Fecha_Venta) = 12
                 AND MOD(v.rn * 13 + l.linea * 7, 100) < 40
                THEN 15

            WHEN MOD(v.rn * 13 + l.linea * 7, 100) < 55
                THEN 0

            WHEN MOD(v.rn * 13 + l.linea * 7, 100) < 75
                THEN 10

            WHEN MOD(v.rn * 13 + l.linea * 7, 100) < 90
                THEN 15

            WHEN MOD(v.rn * 13 + l.linea * 7, 100) < 97
                THEN 20

            ELSE 25
        END AS Descuento_Porcentaje

    FROM ventas_config v
    CROSS JOIN lineas l
    CROSS JOIN total_productos tp

    WHERE l.linea <= v.Cantidad_Lineas
)

SELECT
    b.Id_Venta,
    p.Id_Producto,
    b.Cantidad,

    ROUND(
        p.Precio *
        CASE
            WHEN YEAR(b.Fecha_Venta) = 2024
                THEN 0.82 + MOD(b.rn + b.linea, 7) / 100

            WHEN YEAR(b.Fecha_Venta) = 2025
                THEN 0.90 + MOD(b.rn + b.linea, 7) / 100

            ELSE
                0.97 + MOD(b.rn + b.linea, 4) / 100
        END,
        2
    ) AS Precio_Unitario,

    b.Descuento_Porcentaje

FROM base b
JOIN productos_numerados p
    ON p.rn_producto = b.rn_producto;

COMMIT;