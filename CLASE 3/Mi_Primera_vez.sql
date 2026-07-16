-- =========================================================================
-- PASO 1: Creación de la Base de Datos
-- =========================================================================
-- Usamos "CREATE DATABASE" para reservar un espacio en el disco para nuestro proyecto.
CREATE DATABASE StarbucksDB;
GO 
-- El comando "GO" no es SQL, es una instrucción para el entorno (SSMS).
-- Le dice a SQL Server: "Termina por completo de crear la base de datos antes de pasar a la siguiente línea".


-- =========================================================================
-- PASO 2: Selección de la Base de Datos
-- =========================================================================
-- Por defecto, SQL Server se abre en una base de datos del sistema llamada "master".
-- Con "USE" le indicamos que queremos trabajar específicamente dentro de "StarbucksDB".
USE StarbucksDB;
GO


-- =========================================================================
-- PASO 3: Creación de la Tabla Padre (Productos)
-- =========================================================================
-- Creamos primero "Productos" porque es la tabla principal (independiente).
-- No podemos registrar ventas de productos si los productos todavía no existen en nuestro catálogo.
CREATE TABLE Productos (
    -- IDENTITY(1,1): El sistema genera el ID automáticamente (1, 2, 3...) para que no tengamos que asignarlo manualmente.
    -- PRIMARY KEY: Define este campo como el identificador único del producto. No se puede repetir.
    ProductoID INT IDENTITY(1,1) PRIMARY KEY,
    
    -- VARCHAR(100): Guarda texto de hasta 100 caracteres (ideal para nombres).
    -- NOT NULL: Obliga a ingresar un valor. No se permiten productos "sin nombre".
    Nombre VARCHAR(100) NOT NULL,
    
    -- DECIMAL(10,2): El formato estándar para dinero. Guarda hasta 10 dígitos, usando exactamente 2 para los centavos (ej. 15.50).
    Precio DECIMAL(10,2) NOT NULL
);
GO


-- =========================================================================
-- PASO 4: Creación de la Tabla Hija (Ventas)
-- =========================================================================
-- Esta tabla registra transacciones y depende directamente de la tabla "Productos".
CREATE TABLE Ventas (
    VentaID INT IDENTITY(1,1) PRIMARY KEY,
    
    -- ProductoID: Almacena el código del producto vendido. Debe ser del mismo tipo de datos (INT) que en la tabla original.
    ProductoID INT NOT NULL,
    
    Cantidad INT NOT NULL,
    
    -- DEFAULT GETDATE(): Si al registrar la venta no escribimos la fecha, SQL Server tomará automáticamente el día y la hora exacta del sistema.
    FechaVenta DATETIME DEFAULT GETDATE(),
    
    -- CONSTRAINT (Restricción de llave foránea):
    -- Este es el "contrato de integridad". Evita errores lógicos graves, como intentar vender el producto "ID 99" si en tu tabla Productos solo tienes registrados del 1 al 10.
    CONSTRAINT FK_Ventas_Productos FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);
GO


-- =========================================================================
-- PASO 5: Consultas de Verificación
-- =========================================================================
-- El asterisco (*) es un comodín que significa "seleccionar todas las columnas".
-- Ejecutamos esto para verificar que ambas tablas se crearon correctamente con sus estructuras vacías.
SELECT * FROM Productos;
SELECT * FROM Ventas;
GO
