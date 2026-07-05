-- =========================================================================
-- 1. SOLUCIÓN AL ERROR: CREAR Y SELECCIONAR LA BASE DE DATOS
-- =========================================================================
CREATE DATABASE IF NOT EXISTS tarea_camper;
USE tarea_camper;

-- =========================================================================
-- 2. CREACIÓN DE TABLAS DE PRUEBA Y DATOS DE EJEMPLO
-- =========================================================================
CREATE TABLE IF NOT EXISTS notas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_estudiante INT,
    asignatura VARCHAR(50),
    nota_final DECIMAL(3,2)
);

-- Limpiamos datos previos para evitar duplicados
TRUNCATE TABLE notas;

-- Insertamos datos de prueba para verificar los 3 casos (Bajo, Aceptable, Sobresaliente)
INSERT INTO notas (id_estudiante, asignatura, nota_final) VALUES
-- Estudiante 1 (Promedio: 2.50 -> Bajo)
(1, 'Matemáticas', 2.00),
(1, 'Historia', 3.00),

-- Estudiante 2 (Promedio: 3.50 -> Aceptable)
(2, 'Matemáticas', 3.20),
(2, 'Historia', 3.80),

-- Estudiante 3 (Promedio: 4.60 -> Sobresaliente)
(3, 'Matemáticas', 4.50),
(3, 'Historia', 4.70);


-- =========================================================================
-- 3. CREACIÓN DE LA FUNCIÓN SOLICITADA
-- =========================================================================
DELIMITER //

DROP FUNCTION IF EXISTS ClasificarDesempeño //

CREATE FUNCTION ClasificarDesempeño(estudiante_id INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(3,2);
    DECLARE clasificacion VARCHAR(20);

    -- Consultar la tabla y calcular el promedio del estudiante
    SELECT AVG(nota_final) INTO promedio
    FROM notas 
    WHERE id_estudiante = estudiante_id;

    -- Lógica condicional para asignar la etiqueta según los criterios establecidos
    IF promedio IS NULL THEN
        SET clasificacion = 'Sin notas';
    ELSEIF promedio < 3.0 THEN
        SET clasificacion = 'Bajo';
    ELSEIF promedio >= 3.0 AND promedio <= 4.0 THEN
        SET clasificacion = 'Aceptable';
    ELSE
        SET clasificacion = 'Sobresaliente';
    END IF;

    -- Retornar el resultado final
    RETURN clasificacion;
END //

DELIMITER ;


-- =========================================================================
-- 4. CONSULTA SELECT PARA VER EL RESULTADO ESPERADO
-- =========================================================================
SELECT 
    id_estudiante AS 'ID Estudiante', 
    ROUND(AVG(nota_final), 2) AS 'Promedio Real',
    ClasificarDesempeño(id_estudiante) AS 'Clasificación'
FROM notas
GROUP BY id_estudiante;

