/*
1. Crear el procedimiento LISTADOJUGADORES
El objetivo es crear un procedimiento que, dado el nombre de un equipo, liste todos los datos de los jugadores de ese equipo.
*/
CREATE OR REPLACE PROCEDURE LISTADOJUGADORES (
    p_nombre_equipo IN VARCHAR2
) AS
    CURSOR cur_jugadores IS
        SELECT DNI, NOMBRE_JUGADOR, NOMBRE_EQUIPO, SALARIO, POSICION, ALTURA, FECHA_NAC
        FROM JUGADOR
        WHERE NOMBRE_EQUIPO = p_nombre_equipo;
BEGIN
    FOR jugador IN cur_jugadores LOOP
        DBMS_OUTPUT.PUT_LINE('DNI: ' || jugador.DNI);
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || jugador.NOMBRE_JUGADOR);
        DBMS_OUTPUT.PUT_LINE('Equipo: ' || jugador.NOMBRE_EQUIPO);
        DBMS_OUTPUT.PUT_LINE('Salario: ' || jugador.SALARIO);
        DBMS_OUTPUT.PUT_LINE('Posición: ' || jugador.POSICION);
        DBMS_OUTPUT.PUT_LINE('Altura: ' || jugador.ALTURA);
        DBMS_OUTPUT.PUT_LINE('Fecha de Nacimiento: ' || TO_CHAR(jugador.FECHA_NAC, 'DD-MON-YYYY'));
        DBMS_OUTPUT.PUT_LINE('------------------------');
    END LOOP;
END;
/

/*
Explicación del procedimiento:
PROCEDURE LISTADOJUGADORES: Define el procedimiento LISTADOJUGADORES con un parámetro de entrada p_nombre_equipo de tipo VARCHAR2.
CURSOR cur_jugadores: Declara un cursor que selecciona todos los datos de los jugadores del equipo especificado.
BEGIN - END: Inicia el bloque del procedimiento.
FOR jugador IN cur_jugadores LOOP: Itera sobre los registros devueltos por el cursor cur_jugadores.
DBMS_OUTPUT.PUT_LINE: Imprime los detalles de cada jugador en la consola, formateando adecuadamente cada campo.
*/

/*
2. Probar el procedimiento desde un bloque anónimo
Para probar el procedimiento, utilizaremos un bloque anónimo en PL/SQL que llamará al procedimiento LISTADOJUGADORES.
*/
SET SERVEROUTPUT ON;

BEGIN
    LISTADOJUGADORES('Equipo A'); -- Cambia 'Equipo A' por el nombre del equipo que deseas consultar
END;
/
/*
Explicación del bloque anónimo:
SET SERVEROUTPUT ON: Habilita la salida en la consola para que DBMS_OUTPUT.PUT_LINE pueda mostrar mensajes.
BEGIN - END: Inicia el bloque anónimo que se ejecutará.
LISTADOJUGADORES('Equipo A'): Llama al procedimiento LISTADOJUGADORES con el nombre del equipo como parámetro de entrada. Cambia 'Equipo A' por el nombre del equipo que deseas consultar.
Comentarios adicionales
DBMS_OUTPUT.PUT_LINE: Es una función de Oracle PL/SQL que se utiliza para imprimir mensajes en la consola. Es útil para depuración y para mostrar resultados durante la ejecución de un procedimiento.
CURSOR: Un cursor es una estructura que permite recorrer filas de una consulta de manera controlada.
*/
