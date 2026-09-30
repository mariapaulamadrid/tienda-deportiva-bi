# 🏪 Tienda Deportiva | Business Intelligence

Proyecto de **Business Intelligence** orientado al análisis comercial de una tienda deportiva con ventas presenciales y digitales.

La solución integra **MySQL, SQL y Power BI**, abarcando desde el diseño y generación de la base de datos hasta el análisis de la información y la construcción de un dashboard interactivo para apoyar la toma de decisiones comerciales.

## 🎯 Objetivo

Transformar los datos de ventas en información útil para comprender el desempeño del negocio, analizar productos y clientes, evaluar la rentabilidad e identificar patrones y oportunidades comerciales.

## 🛠️ Tecnologías

**MySQL · SQL · Power BI · Power Query · DAX**

## 🔄 Proceso del proyecto

**Base de datos MySQL → Análisis con SQL → Modelado y métricas → Dashboard en Power BI**

El proyecto incluyó:

* Diseño de un modelo relacional.
* Generación de datos ficticios para simular operaciones comerciales.
* Validación y análisis exploratorio mediante SQL.
* Preparación y modelado de datos en Power BI.
* Creación de medidas e indicadores con DAX.
* Desarrollo de visualizaciones orientadas al análisis del negocio.

## 📊 Proyecto en números

* **6** tablas relacionadas
* **1.000** productos
* **5.000** clientes
* **25.000** ventas
* **71.251** registros de detalle
* **3** páginas de análisis en Power BI

## 📈 Dashboard

El dashboard fue organizado en tres áreas principales:

### Resumen Ejecutivo

Visión general de facturación, ventas, ticket promedio, margen, canales, marcas y categorías.

### Productos y Rentabilidad

Análisis de productos por unidades vendidas, facturación, ganancia estimada y margen.

### Clientes y Distribución Geográfica

Análisis de clientes, provincias, facturación geográfica, canales y métodos de pago.

## 💡 Principales insights

Resultados de una tienda deportiva ficticia, con datos simulados de 2024 a 2026 y considerando únicamente ventas entregadas.

* **El canal Web aumentó su participación en la facturación:** pasó del **54,10% en 2024 al 71,96% en 2026**, una diferencia de **17,86 puntos porcentuales**.
* **Indumentaria y Calzado lideraron los ingresos**, con aproximadamente **$2.654 millones y $2.546 millones**, respectivamente.
* **La facturación está distribuida entre las cinco marcas:** ninguna superó el **21% del total**. Cuatro marcas acumularon el **81,20%**, sin una dependencia marcada de una sola.
* **Volumen, facturación y margen muestran distintos líderes:** Under Armour presentó el mayor margen estimado (**31,42%**), mientras que Puma generó la mayor ganancia estimada total (**$425,27 millones**).
* **Los descuentos del 20% y 25% registraron márgenes estimados del 19,42% y 13,37%.** Las reglas de generación de los datos condicionan las cantidades vendidas, por lo que esta comparación no demuestra cómo responderían clientes reales ante un cambio de descuento.

## 📌 Recomendaciones

Las propuestas vinculan los resultados con acciones que requieren validación:

* **Evaluar la operación y rentabilidad del canal Web antes de ampliar inversiones.** Analizar ventas entregadas, ticket promedio y ganancia estimada; incorporar costos de publicidad, comisiones y envíos, además de tiempos de entrega y devoluciones.
* **Probar una mayor visibilidad de productos seleccionados de Under Armour**, manteniendo precios y descuentos. Medir unidades, ganancia adicional, costo de la acción y posibles desplazamientos de ventas de otras marcas. Su ventaja de margen frente a Puma es de **0,58 puntos porcentuales**, por lo que se propone una prueba limitada.
* **Comparar descuentos del 20% y 25% en productos equivalentes durante el mismo período.** Evaluar si las ventas adicionales compensan el menor margen, considerando disponibilidad, exposición y costos de la promoción.
* **Registrar el costo histórico de cada producto vendido** para calcular un margen bruto más preciso. Incorporar gastos operativos, comisiones, logística y devoluciones para evaluar la rentabilidad neta.

> **Alcance:** los resultados describen un escenario simulado. La ganancia y el margen son estimaciones basadas en el costo del catálogo y no representan rentabilidad neta. Los datos de 2024 comienzan en marzo, por lo que las comparaciones anuales deben considerar esa cobertura parcial.

## 📄 Documentación

- 📊 [Ver presentación del proyecto](Presentacion_Tienda_Deportiva_GitHub.pdf)
- 📘 [Ver informe detallado](Informe_Detallado_Tienda_Deportiva.pdf)

## 📁 Archivos del repositorio

- [`ddl.sql`](ddl.sql) — creación de tablas, claves y relaciones de la base de datos.
- [`generacion_datos.sql`](generacion_datos.sql) — generación de datos ficticios para el análisis.
- [`analisis.sql`](analisis.sql) — consultas SQL utilizadas para explorar y analizar la información.
- [`dashboard.pbix`](dashboard.pbix) — modelo, medidas DAX y dashboard interactivo desarrollado en Power BI.
---

**María Paula Madrid**
Ingeniera en Sistemas de Información | Data Analytics & Business Intelligence


