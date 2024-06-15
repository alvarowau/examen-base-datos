/*
1. Crear la tabla ACTUALIZACIONES
Primero, necesitamos crear la tabla ACTUALIZACIONES que almacenará la fecha de la acción, el nombre del equipo y el tipo de acción (alta, baja o modificación).
*/
CREATE TABLE ACTUALIZACIONES (
    FECHA_ACCION TIMESTAMP,
    NOMBRE_EQUIPO VARCHAR2(100),
    ACCION VARCHAR2(100)
);

/*
FECHA_ACCION: Almacena la fecha y hora de la acción.
NOMBRE_EQUIPO: Almacena el nombre del equipo afectado.
ACCION: Almacena el tipo de acción (alta, baja, modificación).
*/


/*2. Crear el disparador
El siguiente paso es crear un disparador que se active después de insertar, borrar o actualizar el atributo PRESUPUESTO de la tabla EQUIPO.
*/
CREATE OR REPLACE TRIGGER equipo_actualizacion_trigger
AFTER INSERT OR DELETE OR UPDATE OF PRESUPUESTO ON EQUIPO
FOR EACH ROW
DECLARE
    accion VARCHAR2(100);
BEGIN
    IF INSERTING THEN
        INSERT INTO ACTUALIZACIONES (FECHA_ACCION, NOMBRE_EQUIPO, ACCION)
        VALUES (SYSTIMESTAMP, :NEW.NOMBRE, 'alta');
        accion := 'dado de alta';
    ELSIF DELETING THEN
        INSERT INTO ACTUALIZACIONES (FECHA_ACCION, NOMBRE_EQUIPO, ACCION)
        VALUES (SYSTIMESTAMP, :OLD.NOMBRE, 'baja');
        accion := 'dado de baja';
    ELSIF UPDATING THEN
        INSERT INTO ACTUALIZACIONES (FECHA_ACCION, NOMBRE_EQUIPO, ACCION)
        VALUES (SYSTIMESTAMP, :NEW.NOMBRE, 'modificación');
        accion := 'modificado';
    END IF;

    DBMS_OUTPUT.PUT_LINE('El equipo ' || :NEW.NOMBRE || ' se ha ' || accion);
END;
/

/*
Explicación del disparador:
AFTER INSERT OR DELETE OR UPDATE OF PRESUPUESTO ON EQUIPO: El disparador se activa después de que se inserte, borre o actualice el atributo PRESUPUESTO en la tabla EQUIPO.

DECLARE: Declara una variable accion para almacenar el tipo de acción realizada.

BEGIN: Inicio del bloque de código del disparador.

IF INSERTING THEN: Si se está insertando una fila en la tabla EQUIPO:

Inserta una nueva fila en ACTUALIZACIONES con la fecha actual (SYSTIMESTAMP), el nombre del equipo nuevo (:NEW.NOMBRE) y la acción "alta".
Establece el mensaje de acción como "dado de alta".
ELSIF DELETING THEN: Si se está borrando una fila en la tabla EQUIPO:

Inserta una nueva fila en ACTUALIZACIONES con la fecha actual (SYSTIMESTAMP), el nombre del equipo a borrar (:OLD.NOMBRE) y la acción "baja".
Establece el mensaje de acción como "dado de baja".
ELSIF UPDATING THEN: Si se está actualizando una fila en la tabla EQUIPO:

Inserta una nueva fila en ACTUALIZACIONES con la fecha actual (SYSTIMESTAMP), el nombre del equipo modificado (:NEW.NOMBRE) y la acción "modificación".
Establece el mensaje de acción como "modificado".
DBMS_OUTPUT.PUT_LINE: Muestra un mensaje en la consola de Oracle SQL*Plus indicando la acción realizada sobre el equipo.
*/

/*
3. Ejemplos de uso
A continuación, algunos ejemplos para verificar el funcionamiento del disparador:

Insertar un nuevo equipo:
*/
/*
INSERT INTO EQUIPO (NOMBRE, DNI_ENTRENADOR, TITULOS, PRESUPUESTO)
VALUES ('Equipo C', '34567890C', 1, 500000);
Actualizar el presupuesto de un equipo existente:
*/
/*
UPDATE EQUIPO SET PRESUPUESTO = 1200000 WHERE NOMBRE = 'Equipo C';
Eliminar un equipo:
*/
DELETE FROM EQUIPO WHERE NOMBRE = 'Equipo C';
/*
Consultar las actualizaciones registradas:
*/
SELECT * FROM ACTUALIZACIONES;
/*
Comentarios adicionales
SYSTIMESTAMP: Proporciona la fecha y hora actual con precisión de fracción de segundo.
y
: Referencias a los valores nuevos y antiguos de la fila afectada por la operación.
DBMS_OUTPUT.PUT_LINE: Es útil para depurar y verificar las acciones realizadas por el disparador.
*/
