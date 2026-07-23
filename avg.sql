SELECT
    id_venta,
    cantidad * precio_unitario AS monto_total,
    CASE
        WHEN (cantidad * precio_unitario) >= (SELECT AVG(cantidad * precio_unitario) FROM ventas) 
            THEN 'Por encima del promedio'
        ELSE 'Por debajo del promedio'
    END AS tipo_ticket
FROM ventas
