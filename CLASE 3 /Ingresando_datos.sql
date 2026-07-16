USE StarbucksDB;
GO

-- =========================================================================
-- PASO 1: Insertar registros en la tabla Padre (Productos)
-- =========================================================================
-- Al insertar, omitimos la columna "ProductoID" porque es IDENTITY (se genera sola).
-- SQL asignará automáticamente: 'Cafe Latte' (ID 1), 'Expresso Solo' (ID 2) y 'Capuccino' (ID 3).
INSERT INTO Productos (Nombre, Precio) 
VALUES 
    ('Cafe Latte', 4500.00),
    ('Expresso Solo', 3800.00),
    ('Capuccino', 5200.00);
GO

-- Corregido: Agregamos el asterisco (*) para consultar toda la tabla.
SELECT * FROM Productos;
GO


-- =========================================================================
-- PASO 2: Insertar registros en la tabla Hija (Ventas)
-- =========================================================================
-- Aquí registramos que se vendieron:
-- 2 unidades del ProductoID 1 (Cafe Latte)
-- 1 unidad del ProductoID 2 (Expresso Solo)
INSERT INTO Ventas (ProductoID, Cantidad) 
VALUES 
    (1, 2),
    (2, 1);
GO

-- Corregido: Agregamos el asterisco (*) para consultar las ventas.
SELECT * FROM Ventas;
GO


-- =========================================================================
-- PASO 3: Probar la Llave Foránea (FK) - ESTO VA A FALLAR
-- =========================================================================
-- Intentamos registrar una venta del ProductoID 99.
-- ERROR ESPERADO: SQL Server no lo permitirá y lanzará un error de "CONFLICT con la restricción FOREIGN KEY".
-- ¿Por qué? Porque el producto 99 NO existe en nuestra tabla Productos. La base de datos protege la lógica del negocio.
INSERT INTO Ventas (ProductoID, Cantidad) 
VALUES (99, 1);
GO


-- =========================================================================
-- PASO 4: Protección de Borrado (Integridad Referencial) - ESTO VA A FALLAR
-- =========================================================================
-- Intentamos eliminar el producto 'Expresso Solo' (ID 2).
-- ERROR ESPERADO: SQL Server bloqueará el DELETE con un error de "CONFLICT con la restricción REFERENCE".
-- ¿Por qué? Porque en el Paso 2 registramos una venta para el ProductoID 2. 
-- Si SQL nos dejara borrar el producto, la tabla "Ventas" quedaría con un "registro huérfano" (una venta asociada a un producto que ya no existe).
DELETE FROM Productos 
WHERE ProductoID = 2;
GO
