-- a) Cambiar la clave de la tabla EMPLEADO a NOMBRE+CIUDAD y cambiar el nombre de la tabla EMPLEADO a TRABAJADOR

-- 1. Eliminar la clave primaria actual
ALTER TABLE EMPLEADO DROP PRIMARY KEY;

-- 2. Añadir una nueva clave primaria compuesta por NOMBRE y CIUDAD
ALTER TABLE EMPLEADO ADD CONSTRAINT EMPLEADO_PK PRIMARY KEY (NOMBRE, CIUDAD);

-- 3. Cambiar el nombre de la tabla EMPLEADO a TRABAJADOR
ALTER TABLE EMPLEADO RENAME TO TRABAJADOR;

/*
Explicación:
1. ALTER TABLE EMPLEADO DROP PRIMARY KEY: Elimina la restricción de clave primaria actual.
2. ALTER TABLE EMPLEADO ADD CONSTRAINT EMPLEADO_PK PRIMARY KEY (NOMBRE, CIUDAD): Añade una nueva restricción de clave primaria compuesta por NOMBRE y CIUDAD.
3. ALTER TABLE EMPLEADO RENAME TO TRABAJADOR: Cambia el nombre de la tabla EMPLEADO a TRABAJADOR.
*/

-- b) Modificar la tabla DEPARTAMENTO añadiendo un nuevo atributo llamado NUMTRAB

ALTER TABLE DEPARTAMENTO ADD NUMTRAB NUMBER;

/*
Explicación:
ALTER TABLE DEPARTAMENTO ADD NUMTRAB NUMBER: Añade un nuevo atributo NUMTRAB a la tabla DEPARTAMENTO, que almacenará el número de trabajadores de cada departamento.
*/


/*
Puntos Clave y Comentarios para el Estudio:
ALTER TABLE para modificar tablas:

DROP PRIMARY KEY: Se utiliza para eliminar la clave primaria actual de una tabla.
ADD CONSTRAINT: Se usa para añadir nuevas restricciones a una tabla, como una nueva clave primaria compuesta.
RENAME TO: Se usa para cambiar el nombre de una tabla.
Claves Primarias Compuestas:

Una clave primaria compuesta está formada por dos o más columnas que juntas garantizan la unicidad de las filas en la tabla. En este caso, NOMBRE y CIUDAD juntos forman la nueva clave primaria.
Renombrar Tablas:

El comando RENAME TO se utiliza para cambiar el nombre de una tabla, lo que puede ser necesario por razones de claridad, estándar de nomenclatura o cambios en los requisitos del proyecto.
Añadir Nuevas Columnas:

El comando ADD en ALTER TABLE se utiliza para agregar nuevas columnas a una tabla existente. En este caso, se añade la columna NUMTRAB a la tabla DEPARTAMENTO para almacenar el número de trabajadores en cada departamento.
Uso de CONSTRAINT para definir restricciones:

ADD CONSTRAINT se usa para definir restricciones como claves primarias, claves foráneas, únicas, checks, etc. Es importante nombrar las restricciones para una mejor gestión y comprensión del esquema de la base de datos.
*/
