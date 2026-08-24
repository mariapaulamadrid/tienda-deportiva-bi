-- =====================================================
-- PROYECTO: Business Intelligence para Tienda Deportiva
-- =====================================================

CREATE DATABASE IF NOT EXISTS tienda_online_unicorn;
USE tienda_online_unicorn;

-- =====================================================
-- TABLA: Marca
-- =====================================================
CREATE TABLE Marca (
    Id_Marca INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Marca VARCHAR(60) NOT NULL
);

-- =====================================================
-- TABLA: Categoria
-- =====================================================
CREATE TABLE Categoria (
    Id_Categoria INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Categoria VARCHAR(30) NOT NULL
);

-- =====================================================
-- TABLA: Cliente
-- =====================================================
CREATE TABLE Cliente (
    Id_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Cliente VARCHAR(50) NOT NULL,
    Apellido_Cliente VARCHAR(50) NOT NULL,
    Fecha_Nacimiento DATE NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Direccion VARCHAR(100),
    Ciudad VARCHAR(50),
    Provincia VARCHAR(50),
    Codigo_Postal VARCHAR(10),
    Fecha_Alta DATE NOT NULL
);

-- =====================================================
-- TABLA: Producto
-- =====================================================
CREATE TABLE Producto (
    Id_Producto INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Producto VARCHAR(60) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    Id_Marca INT NOT NULL,
    Id_Categoria INT NOT NULL,
    Precio_Compra DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_producto_marca
        FOREIGN KEY (Id_Marca)
        REFERENCES Marca(Id_Marca),

    CONSTRAINT fk_producto_categoria
        FOREIGN KEY (Id_Categoria)
        REFERENCES Categoria(Id_Categoria)
);

-- =====================================================
-- TABLA: Venta
-- =====================================================
CREATE TABLE Venta (
    Id_Venta INT AUTO_INCREMENT PRIMARY KEY,
    Id_Cliente INT NOT NULL,
    Fecha_Venta DATE NOT NULL,
    Metodo_Pago VARCHAR(30) NOT NULL,
    Canal_Venta VARCHAR(30) NOT NULL,
    Estado_Venta VARCHAR(30) NOT NULL,

    CONSTRAINT fk_venta_cliente
        FOREIGN KEY (Id_Cliente)
        REFERENCES Cliente(Id_Cliente)
);

-- =====================================================
-- TABLA: Detalle_Venta
-- =====================================================
CREATE TABLE Detalle_Venta (
    Id_Detalle_Venta INT AUTO_INCREMENT PRIMARY KEY,
    Id_Venta INT NOT NULL,
    Id_Producto INT NOT NULL,
    Cantidad INT NOT NULL,
    Precio_Unitario DECIMAL(10,2) NOT NULL,
    Descuento_Porcentaje DECIMAL(5,2) NOT NULL DEFAULT 0,

    CONSTRAINT fk_detalle_venta
        FOREIGN KEY (Id_Venta)
        REFERENCES Venta(Id_Venta),

    CONSTRAINT fk_detalle_producto
        FOREIGN KEY (Id_Producto)
        REFERENCES Producto(Id_Producto)
);