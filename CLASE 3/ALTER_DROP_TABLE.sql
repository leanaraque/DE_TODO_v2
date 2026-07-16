USE StarbucksDB;
GO

-- =========================================================================
-- PASO 1: AÑADIR una nueva columna (ADD)
-- =========================================================================
-- El negocio creció y ahora necesitamos saber a qué categoría pertenece cada producto 
-- (Ej: 'Bebidas Calientes', 'Comida', 'Merchandising').
-- Vamos a agregar la columna "Categoria" a la tabla Productos.

ALTER TABLE Productos 
ADD Categoria VARCHAR(50);
GO

-- Vemos el cambio:
-- IMPORTANTE PARA EL ALUMNO: Noten que para los productos que ya existían 
-- (Cafe Latte, Expresso, etc.), esta nueva columna aparecerá con el valor "NULL" (vacío), 
-- porque al momento de crearlos esa información no existía.
SELECT * FROM Productos;
GO


-- =========================================================================
-- PASO 2: EDITAR / MODIFICAR una columna existente (ALTER COLUMN)
-- =========================================================================
-- Nos dimos cuenta de que 100 caracteres es muy poco espacio para el Nombre 
-- de algunos productos nuevos (ej. "Frappuccino de Vainilla con Chispas de Chocolate").
-- Vamos a ampliar el tamaño de la columna de VARCHAR(100) a VARCHAR(150).

ALTER TABLE Productos 
ALTER COLUMN Nombre VARCHAR(150) NOT NULL;
GO
-- Nota pedagógica: Al hacer un ALTER COLUMN debemos volver a especificar si 
-- la columna acepta nulos o no (en este caso, sigue siendo NOT NULL).


-- =========================================================================
-- PASO 3: ELIMINAR una columna (DROP COLUMN)
-- =========================================================================
-- Para este ejemplo, primero vamos a inventar una columna en la tabla Ventas 
-- llamada "NotasCliente".
ALTER TABLE Ventas 
ADD NotasCliente VARCHAR(200);
GO

-- Ahora imaginemos que nos arrepentimos o que el cliente decidió que 
-- por privacidad no quiere guardar notas. Vamos a borrar esa columna.
-- CUIDADO: Borrar una columna elimina TODOS los datos que estén guardados en ella.

ALTER TABLE Ventas 
DROP COLUMN NotasCliente;
GO

-- Vemos la tabla Ventas para confirmar que la columna "NotasCliente" ya no existe:
SELECT * FROM Ventas;
GO
