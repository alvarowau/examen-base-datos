-- Creación de la tabla DEPARTAMENTO
CREATE TABLE DEPARTAMENTO (
    CODDPTO NUMBER PRIMARY KEY, -- Clave primaria para la tabla DEPARTAMENTO
    NOMBREDPTO VARCHAR2(100) UNIQUE NOT NULL, -- NOMBREDPTO debe ser único y no nulo
    PRESUPUESTO NUMBER -- Atributo PRESUPUESTO
);

/*
Explicación:
- CODDPTO NUMBER PRIMARY KEY: Define el código del departamento como clave primaria.
- NOMBREDPTO VARCHAR2(100) UNIQUE NOT NULL: Nombre del departamento único y obligatorio.
- PRESUPUESTO NUMBER: Presupuesto del departamento.
*/

-- Creación de la tabla EMPLEADO
CREATE TABLE EMPLEADO (
    DNI VARCHAR2(20) PRIMARY KEY, -- Clave primaria para la tabla EMPLEADO
    NOMBRE VARCHAR2(100), -- Nombre del empleado
    CIUDAD VARCHAR2(100), -- Ciudad del empleado
    CPOSTAL VARCHAR2(10), -- Código postal del empleado
    PAIS VARCHAR2(50) DEFAULT 'ESPAÑA', -- País del empleado con valor por defecto 'ESPAÑA'
    EDAD NUMBER CHECK (EDAD >= 0), -- Restricción para asegurar que la edad no puede ser negativa
    DPTO NUMBER, -- Clave foránea que referencia al código del departamento
    CONSTRAINT fk_dpto FOREIGN KEY (DPTO) REFERENCES DEPARTAMENTO(CODDPTO) -- Definición de la clave foránea
);

/*
Explicación:
- DNI VARCHAR2(20) PRIMARY KEY: Define el DNI como clave primaria.
- PAIS VARCHAR2(50) DEFAULT 'ESPAÑA': Define el país con un valor por defecto 'ESPAÑA'.
- EDAD NUMBER CHECK (EDAD >= 0): Restricción para asegurar que la edad no puede ser negativa.
- DPTO NUMBER: Clave foránea que hace referencia al código del departamento en la tabla DEPARTAMENTO.
- CONSTRAINT fk_dpto FOREIGN KEY (DPTO) REFERENCES DEPARTAMENTO(CODDPTO): Define la relación de clave foránea entre EMPLEADO y DEPARTAMENTO.
*/


/*
Puntos Clave y Comentarios para el Estudio:
Claves Primarias y Foráneas:

Clave Primaria (Primary Key): Es un identificador único para cada fila de la tabla. En EMPLEADO, el DNI es la clave primaria, y en DEPARTAMENTO, el CODDPTO.
Clave Foránea (Foreign Key): Es un campo que crea una relación entre dos tablas. En la tabla EMPLEADO, el campo DPTO es una clave foránea que referencia al campo CODDPTO de la tabla DEPARTAMENTO.
Restricciones de Integridad:

NOT NULL: Asegura que un campo no pueda tener un valor nulo. Ejemplo: NOMBREDPTO en la tabla DEPARTAMENTO.
UNIQUE: Asegura que todos los valores en una columna sean únicos. Ejemplo: NOMBREDPTO en la tabla DEPARTAMENTO.
CHECK: Permite definir una condición que los valores en una columna deben cumplir. Ejemplo: EDAD en la tabla EMPLEADO no puede ser negativa.
Valores por Defecto:

DEFAULT: Especifica un valor por defecto que se asigna a una columna si no se proporciona uno explícitamente. Ejemplo: PAIS en la tabla EMPLEADO tiene un valor por defecto de 'ESPAÑA'.
Comentarios en el Código SQL:

Utiliza comentarios (-- para una línea o (/* *) para múltiples líneas) para explicar el propósito de cada parte del código. Esto no solo te ayuda a recordar por qué se escribió de una manera específica, sino que también es útil para otros que lean tu código.
Buen uso de los Tipos de Datos:

VARCHAR2: Se usa para almacenar cadenas de caracteres de longitud variable. Es adecuado para campos como NOMBRE, CIUDAD y CPOSTAL.
NUMBER: Se usa para almacenar números. Es adecuado para campos como EDAD, DPTO y PRESUPUESTO.
*/
