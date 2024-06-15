/*
Paso A: Crear el Tipo de Objeto "ParticipanteLiga"
*/
CREATE OR REPLACE TYPE ParticipanteLiga AS OBJECT (
    dni CHAR(9),                 -- Atributo dni de tipo CHAR con longitud 9
    nombre VARCHAR2(50)         -- Atributo nombre de tipo VARCHAR2 con longitud máxima de 50 caracteres
) NOT FINAL;
/*
Explicación:

Este es el tipo base ParticipanteLiga que contendrá atributos comunes para otras entidades como Entrenador y Jugador.
*/

/*
Crear el Tipo de Objeto Entrenador que Hereda de ParticipanteLiga
Ahora, vamos a crear el tipo Entrenador que hereda de ParticipanteLiga y agrega el atributo años_experiencia.
*/
CREATE OR REPLACE TYPE Entrenador UNDER ParticipanteLiga (
    años_experiencia INTEGER    -- Atributo específico de Entrenador para almacenar los años de experiencia
);

/*
Explicación:

Entrenador es un tipo derivado de ParticipanteLiga que hereda dni y nombre, y añade años_experiencia.
*/

/*
Paso 2: Crear el Tipo Jugador
Vamos a crear el tipo Jugador heredando de ParticipanteLiga y agregando los atributos adicionales.
*/

-- Crear el tipo heredado Jugador
CREATE OR REPLACE TYPE Jugador UNDER ParticipanteLiga (
    posición VARCHAR2(10),      -- Posición del jugador en el equipo
    salario INTEGER,            -- Salario mensual del jugador
    altura INTEGER,             -- Altura del jugador en centímetros
    fecha_nac DATE,             -- Fecha de nacimiento del jugador
    CONSTRUCTOR FUNCTION Jugador(
        dni CHAR,
        nombre VARCHAR2,
        posición VARCHAR2
    ) RETURN SELF AS RESULT,
    MEMBER FUNCTION SalarioMensual RETURN NUMBER
);

/*
Explicación:

Jugador es un tipo derivado de ParticipanteLiga que hereda dni y nombre, y añade posición, salario, altura y fecha_nac.
También se define un constructor personalizado Jugador y un método SalarioMensual para calcular el salario mensual del jugador.
*/

/*
Paso 3: Definir el Cuerpo del Tipo Jugador
Ahora, vamos a definir la implementación del método constructor y el método SalarioMensual.
*/
-- Definir el cuerpo del tipo Jugador
CREATE OR REPLACE TYPE BODY Jugador AS
    CONSTRUCTOR FUNCTION Jugador(
        dni CHAR,
        nombre VARCHAR2,
        posición VARCHAR2
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.dni := dni;         -- Asignar el valor del parámetro dni al atributo dni del objeto
        SELF.nombre := nombre;   -- Asignar el valor del parámetro nombre al atributo nombre del objeto
        SELF.posición := posición; -- Asignar el valor del parámetro posición al atributo posición del objeto
        RETURN;                  -- Retornar el objeto creado
    END;

    MEMBER FUNCTION SalarioMensual RETURN NUMBER IS
    BEGIN
        RETURN SELF.salario / 12; -- Calcular y retornar el salario mensual dividiendo el salario anual entre 12
    END;
END;

/*
Explicación:

Se define la implementación del constructor Jugador para inicializar los atributos dni, nombre y posición del objeto.
También se implementa el método SalarioMensual que devuelve el salario mensual calculado.
*/

/*
Paso 1: Definir el Tipo de Objeto Equipo
Definiremos el tipo Equipo con los atributos nombre, refentrenador, presupuesto, fecha_fundación, y títulos.

*/

CREATE OR REPLACE TYPE Equipo AS OBJECT (
    nombre VARCHAR2(20),        -- Nombre del equipo
    refentrenador REF Entrenador, -- Referencia al entrenador del equipo
    presupuesto INTEGER,        -- Presupuesto del equipo
    fecha_fundación DATE,       -- Fecha de fundación del equipo
    títulos INTEGER             -- Número de títulos ganados por el equipo
);

/*
Explicación:

Equipo es un tipo de objeto que contiene información específica de un equipo, incluyendo una referencia al Entrenador.
*/

/*
Paso 1: Crear la Tabla Jugones
Primero, creamos la tabla Jugones que almacenará objetos del tipo Jugador.
*/
CREATE TABLE Jugones OF Jugador;

/*
Explicación:

Creamos una tabla llamada Jugones que almacenará instancias de objetos Jugador. Especificamos que es OF Jugador para indicar que es una tabla de objetos Jugador.
*/

-- Insertar un jugador usando el constructor por defecto
INSERT INTO Jugones VALUES (
    Jugador('123456789', 'Juan Perez', 'Delantero')
);

-- Insertar un jugador usando el constructor personalizado
-- Asumimos que este constructor ha sido correctamente definido para asignar valores por defecto
-- para los otros atributos
INSERT INTO Jugones VALUES (
    NEW Jugador('987654321', 'Maria Lopez', 'Defensa')
);

/*
Explicación:

Insertamos dos jugadores en la tabla Jugones. El primero utiliza el constructor por defecto (implícito), mientras que el segundo utiliza el constructor personalizado que hemos definido anteriormente.
*/

/*
Paso 1: Crear la Tabla Técnicos
Primero, creamos la tabla Técnicos que almacenará objetos del tipo Entrenador.
*/

CREATE TABLE Técnicos OF Entrenador;

/*
Explicación:

Creamos una tabla llamada Técnicos que almacenará instancias de objetos Entrenador. Especificamos que es OF Entrenador para indicar que es una tabla de objetos Entrenador.
*/

-- Insertar un entrenador con nombre "Pepito"
INSERT INTO Técnicos VALUES (
    Entrenador('111111111', 'Pepito', 15)
);

-- Insertar otro entrenador con un DNI específico
INSERT INTO Técnicos VALUES (
    Entrenador('11111111A', 'Nombre del Entrenador', 10)
);

/*
Explicación:

Insertamos dos entrenadores en la tabla Técnicos. El primero se llama "Pepito" y tiene 15 años de experiencia. El segundo tiene nombre "Nombre del Entrenador" y un DNI específico.
*/

/*
Paso 2: Crear el Tipo de Colección VARRAY Liga
Ahora, crearemos el tipo de colección VARRAY llamado Liga que podrá almacenar hasta 10 objetos del tipo Equipo.
*/
CREATE OR REPLACE TYPE Liga AS VARRAY(10) OF Equipo;

/*
Explicación:

Creamos un tipo de colección VARRAY llamado Liga que puede almacenar hasta 10 objetos del tipo Equipo.
*/

DECLARE
    -- Declaración de la instancia del VARRAY Liga
    Liga19_20 Liga := Liga();

    -- Variables para las referencias de los entrenadores
    ref_pepito REF Entrenador;
    ref_entrenador_111 REF Entrenador;
BEGIN
    -- Obtener la referencia del entrenador Pepito
    SELECT REF(e) INTO ref_pepito
    FROM Técnicos e
    WHERE e.nombre = 'Pepito';

    -- Obtener la referencia del entrenador con DNI 11111111A
    SELECT REF(e) INTO ref_entrenador_111
    FROM Técnicos e
    WHERE e.dni = '11111111A';

    -- Crear los equipos y añadirlos a la colección Liga19_20
    Liga19_20.EXTEND;  -- Extender la colección para añadir un nuevo elemento
    Liga19_20(1) := Equipo('Equipo A', ref_pepito, 1000000, DATE '2000-01-01', 3);  -- Añadir el primer equipo

    Liga19_20.EXTEND;  -- Extender la colección para añadir otro nuevo elemento
    Liga19_20(2) := Equipo('Equipo B', ref_entrenador_111, 800000, DATE '1995-06-15', 1);  -- Añadir el segundo equipo

    -- Mostrar información de los equipos agregados
    FOR i IN 1..Liga19_20.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Equipo ' || i || ': ' || Liga19_20(i).nombre);
    END LOOP;
END;
/
