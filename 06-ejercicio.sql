/*
Pregunta
6.- Dadas las tablas:

ENTRENADOR (DNI, NOMBRE_ENT, AÑOS_EXPERIENCIA)
JUGADOR (DNI, NOMBRE_JUGADOR, NOMBRE_EQUIPO, SALARIO, POSICIÓN, ALTURA, FECHA_NAC)
EQUIPO (NOMBRE, DNI_ENTRENADOR, TÍTULOS, PRESUPUESTO)
Realizad en SQL las sentencias para:

a) Obtener nombre y fecha de nacimiento de los jugadores cuyo salario sea mayor que la media de salarios de su equipo.

b) Obtener en una sola consulta el nombre y DNI del jugador que más cobra y el que menos cobra.

c) Obtener nombre de equipo y la cantidad total que se gasta cada equipo en salarios de los jugadores.

d) Obtener los datos de los jugadores del equipo con menor presupuesto.

e) Modificar los títulos y presupuesto del equipo "Estudiantes", ha conseguido dos copas más y 50 millones de € de presupuesto más.

f) Borrar el entrenador del equipo "Baskonia".
*/

/*
Creación de las Tablas
*/
CREATE TABLE ENTRENADOR (
    DNI VARCHAR2(20) PRIMARY KEY,
    NOMBRE_ENT VARCHAR2(100),
    AÑOS_EXPERIENCIA NUMBER
);

CREATE TABLE JUGADOR (
    DNI VARCHAR2(20) PRIMARY KEY,
    NOMBRE_JUGADOR VARCHAR2(100),
    NOMBRE_EQUIPO VARCHAR2(100),
    SALARIO NUMBER,
    POSICIÓN VARCHAR2(50),
    ALTURA NUMBER,
    FECHA_NAC DATE
);

CREATE TABLE EQUIPO (
    NOMBRE VARCHAR2(100) PRIMARY KEY,
    DNI_ENTRENADOR VARCHAR2(20),
    TÍTULOS NUMBER,
    PRESUPUESTO NUMBER,
    CONSTRAINT fk_entrenador FOREIGN KEY (DNI_ENTRENADOR) REFERENCES ENTRENADOR(DNI)
);

/*
Inserción de Registros para Probar
*/
INSERT INTO ENTRENADOR (DNI, NOMBRE_ENT, AÑOS_EXPERIENCIA) VALUES ('12345678A', 'Juan Pérez', 10);
INSERT INTO ENTRENADOR (DNI, NOMBRE_ENT, AÑOS_EXPERIENCIA) VALUES ('23456789B', 'María López', 5);

INSERT INTO JUGADOR (DNI, NOMBRE_JUGADOR, NOMBRE_EQUIPO, SALARIO, POSICIÓN, ALTURA, FECHA_NAC) VALUES ('34567890C', 'Carlos Sánchez', 'Equipo A', 50000, 'Delantero', 180, TO_DATE('1990-05-15', 'YYYY-MM-DD'));
INSERT INTO JUGADOR (DNI, NOMBRE_JUGADOR, NOMBRE_EQUIPO, SALARIO, POSICIÓN, ALTURA, FECHA_NAC) VALUES ('45678901D', 'Ana Martínez', 'Equipo B', 60000, 'Portero', 175, TO_DATE('1992-08-20', 'YYYY-MM-DD'));
INSERT INTO JUGADOR (DNI, NOMBRE_JUGADOR, NOMBRE_EQUIPO, SALARIO, POSICIÓN, ALTURA, FECHA_NAC) VALUES ('56789012E', 'David García', 'Equipo A', 55000, 'Defensa', 185, TO_DATE('1991-03-10', 'YYYY-MM-DD'));

INSERT INTO EQUIPO (NOMBRE, DNI_ENTRENADOR, TÍTULOS, PRESUPUESTO) VALUES ('Equipo A', '12345678A', 3, 1000000);
INSERT INTO EQUIPO (NOMBRE, DNI_ENTRENADOR, TÍTULOS, PRESUPUESTO) VALUES ('Equipo B', '23456789B', 2, 800000);

-- Verificación de los datos insertados
SELECT * FROM ENTRENADOR;
SELECT * FROM JUGADOR;
SELECT * FROM EQUIPO;


/*
a) Obtener nombre y fecha de nacimiento de los jugadores cuyo salario sea mayor que la media de salarios de su equipo
*/
SELECT J.NOMBRE_JUGADOR, J.FECHA_NAC
FROM JUGADOR J
WHERE J.SALARIO > (
    SELECT AVG(J2.SALARIO)
    FROM JUGADOR J2
    WHERE J2.NOMBRE_EQUIPO = J.NOMBRE_EQUIPO
)
ORDER BY J.NOMBRE_JUGADOR;

/*
Explicación:
La subconsulta calcula la media de los salarios de los jugadores de cada equipo. La consulta externa compara el salario de cada jugador con la media de su equipo y selecciona aquellos cuyo salario es mayor.
*/


/*
b) Obtener en una sola consulta el nombre y DNI del jugador que más cobra y el que menos cobra
*/
WITH SalariosJugadores AS (
    SELECT
        DNI,
        NOMBRE_JUGADOR,
        SALARIO,
        ROW_NUMBER() OVER (ORDER BY SALARIO DESC) AS Ranking_Max,
        ROW_NUMBER() OVER (ORDER BY SALARIO ASC) AS Ranking_Min
    FROM JUGADOR
)
SELECT DNI, NOMBRE_JUGADOR
FROM SalariosJugadores
WHERE Ranking_Max = 1 OR Ranking_Min = 1;

/*
Explicación:
Usamos una CTE para asignar rangos a los jugadores basados en sus salarios. Luego, seleccionamos aquellos con los rangos más altos y más bajos para obtener el jugador que más cobra y el que menos cobra.
*/

/*
c) Obtener nombre de equipo y la cantidad total que se gasta cada equipo en salarios de los jugadores
*/
SELECT
    E.NOMBRE AS NOMBRE_EQUIPO,
    SUM(J.SALARIO) AS TOTAL_SALARIOS
FROM EQUIPO E
JOIN JUGADOR J ON E.NOMBRE = J.NOMBRE_EQUIPO
GROUP BY E.NOMBRE;

/*
Explicación:
La consulta une las tablas EQUIPO y JUGADOR por el nombre del equipo y agrupa los resultados por el nombre del equipo. Luego, suma los salarios de los jugadores para cada equipo.
*/


/*
d) Obtener los datos de los jugadores del equipo con menor presupuesto
*/
SELECT J.*
FROM JUGADOR J
JOIN (
    SELECT E.NOMBRE
    FROM EQUIPO E
    ORDER BY E.PRESUPUESTO ASC
    FETCH FIRST 1 ROWS ONLY -- Oracle 12c y versiones posteriores
) EQ ON J.NOMBRE_EQUIPO = EQ.NOMBRE;

/*
Explicación:
La subconsulta selecciona el equipo con el menor presupuesto. La consulta externa une esta subconsulta con la tabla JUGADOR para obtener los datos de los jugadores del equipo con el menor presupuesto.
*/


/*
e) Modificar los títulos y presupuesto del equipo "Estudiantes"
*/
UPDATE EQUIPO
SET TÍTULOS = TÍTULOS + 2,
    PRESUPUESTO = PRESUPUESTO + 50000000
WHERE NOMBRE = 'Estudiantes';

/*
Explicación:
La consulta actualiza el número de títulos y el presupuesto del equipo "Estudiantes", incrementándolos en 2 títulos y 50 millones de euros, respectivamente.
*/

/*
f) Borrar el entrenador del equipo "Baskonia"
*/
UPDATE EQUIPO
SET DNI_ENTRENADOR = NULL
WHERE NOMBRE = 'Baskonia';

/*
Explicación:
La consulta actualiza el campo DNI_ENTRENADOR del equipo "Baskonia", estableciéndolo a NULL para indicar que el equipo ya no tiene un entrenador asignado.
*/

/*
Puntos Clave y Comentarios para el Estudio:
Subconsultas y Agregación:

Subconsultas en WHERE: Muy útil para comparar valores dentro de una misma tabla.
Funciones de Agregación (AVG, SUM): Utilizadas para cálculos estadísticos y agregación de datos en grupos.
CTEs (Common Table Expressions):

WITH Clause: Facilita la organización y reutilización de subconsultas complejas, mejorando la legibilidad y el mantenimiento del código SQL.
Funciones Analíticas:

ROW_NUMBER(): Asigna un número secuencial a filas en un conjunto de resultados, útil para obtener el n-ésimo valor.
JOINs y Agrupación:

INNER JOIN: Comúnmente usado para combinar filas de dos tablas basadas en una condición de igualdad.
GROUP BY: Fundamental para agrupar filas que comparten un valor común, esencial para cálculos agregados.
Manipulación de Datos:

UPDATE: Usado para modificar datos existentes en la base de datos.
SET y WHERE: Cruciales para especificar qué datos modificar y bajo qué condiciones.
Seguridad y Buenas Prácticas:

Siempre validar los cambios masivos y las condiciones en las consultas de actualización y eliminación para evitar errores de datos no deseados.
Utilizar transacciones y puntos de guardado (SAVEPOINT) para cambios complejos que requieren múltiples pasos.
*/

