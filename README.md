# Reto: Clasificación de Desempeño Académico mediante SQL

Este proyecto presenta la solución al reto técnico de clasificación de rendimiento académico estudiantil. Consiste en la implementación de una función definida por el usuario (UDF) que calcula de forma automática la categoría de un alumno según su promedio de calificaciones.

El código fuente correspondiente se encuentra en el archivo adjunto `script.sql`.

---

## 📋 Requisitos del Reto

El objetivo del reto es diseñar una solución modular en MySQL que cubra los siguientes componentes obligatorios:
1. **Función Principal:** Crear la función con el nombre exacto `ClasificarDesempeño`.
2. **Consulta de Aplicación:** Implementar un comando `SELECT` que utilice la función para listar a los estudiantes.
3. **Evidencia de Lógica:** Demostrar el correcto funcionamiento de las condiciones establecidas para cada rango de notas.
4. **Sustentación Teórica:** Justificar técnicamente el uso de la propiedad `DETERMINISTIC` o `NOT DETERMINISTIC`.

---

## 🛠️ Instrucciones de Ejecución

Para desplegar y probar la solución, sigue estos pasos en tu entorno de desarrollo (como MySQL Workbench):

1. **Abrir el Script:** Importa o abre el archivo independiente `script.sql` en tu editor de consultas.
2. **Ejecutar en Bloque:** Selecciona todo el contenido del script (`Ctrl + A`) y presiona el botón del **Rayo (Ejecutar)** o usa el atajo `Ctrl + Shift + Enter`.
3. **Validación Automática:** El script incluye la creación controlada de un esquema de pruebas (`tarea_camper`), una tabla de `notas` y la inserción de registros de prueba para que puedas visualizar los resultados inmediatamente en la cuadrícula inferior (*Result Grid*).

---

## 📊 Evidencia de Implementación y Reglas de Negocio

El sistema evalúa el promedio acumulado de la tabla `notas` y aplica de manera estricta la lógica condicional requerida en el reto, arrojando los siguientes resultados verificados:

| Criterio de Nota | Clasificación Esperada | ID Estudiante en Pruebas | Resultado en Consola |
| :--- | :---: | :---: | :---: |
| Promedio menor a 3.0 | **Bajo** | Estudiante 1 (Promedio: 2.50) | **Bajo** |
| Promedio entre 3.0 y 4.0 | **Aceptable** | Estudiante 2 (Promedio: 3.50) | **Aceptable** |
| Promedio mayor a 4.0 | **Sobresaliente** | Estudiante 3 (Promedio: 4.60) | **Sobresaliente** |

> **Nota de Control:** La ventana de salida de comandos (*Action Output*) confirma que tanto la creación de la función como la consulta final estructurada con `GROUP BY` se ejecutan con estado de éxito (marcador verde), garantizando la correcta gestión de tipos de datos `DECIMAL`.

---

## 🧠 Justificación Técnica: Por qué la función es DETERMINISTIC

La función `ClasificarDesempeño` fue definida explícitamente con la propiedad **`DETERMINISTIC`** (Determinista) debido a los siguientes fundamentos de bases de datos relacionales:

1. **Previsibilidad de Retorno:** Una función es determinista si, dado un estado fijo en las tablas de la base de datos, pasar el mismo parámetro de entrada (`estudiante_id`) siempre devolverá exactamente el mismo valor de salida de texto (`VARCHAR`). 
2. **Ausencia de Componentes Volátiles:** El algoritmo interno se basa exclusivamente en los registros almacenados y no depende de variables dinámicas globales del sistema que cambien segundo a segundo, tales como funciones de tiempo real (`NOW()`, `SYSDATE()`) o funciones de azares numéricos (`RAND()`).
3. **Eficiencia y Caché:** Declarar la función como determinista le permite al motor de MySQL optimizar los planes de ejecución. Esto significa que el servidor puede almacenar en caché el resultado de la clasificación para consultas masivas repetitivas, evitando procesar la fórmula matemática una y otra vez sobre el mismo ID de estudiante, mejorando drásticamente el rendimiento del CPU.

---
**Entregado por:** Camper  
**Tecnologías:** MySQL / SQL DDL & DML  
**Herramienta de Verificación:** MySQL Workbench