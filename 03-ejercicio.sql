-- a) Crear un usuario llamado BRIANDA con contraseña CICLO
CREATE USER BRIANDA IDENTIFIED BY CICLO;

/*
Explicación:
CREATE USER BRIANDA IDENTIFIED BY CICLO;: Crea un nuevo usuario llamado BRIANDA con la contraseña CICLO.
*/

-- b) Dar permisos de administrador al usuario BRIANDA
GRANT DBA TO BRIANDA;

/*
Explicación:
GRANT DBA TO BRIANDA;: Otorga el rol DBA (Database Administrator) al usuario BRIANDA, dándole todos los privilegios administrativos.
*/

-- c) Dar permisos al usuario BRIANDA para poder insertar filas y poder modificar el contenido de la tabla DEPARTAMENTO
-- Permiso para insertar filas en la tabla DEPARTAMENTO
GRANT INSERT ON DEPARTAMENTO TO BRIANDA;

-- Permiso para modificar el contenido de la tabla DEPARTAMENTO
GRANT UPDATE ON DEPARTAMENTO TO BRIANDA;

/*
Explicación:
GRANT INSERT ON DEPARTAMENTO TO BRIANDA;: Permite al usuario BRIANDA insertar filas en la tabla DEPARTAMENTO.
GRANT UPDATE ON DEPARTAMENTO TO BRIANDA;: Permite al usuario BRIANDA modificar el contenido de la tabla DEPARTAMENTO.
*/

-- d) Quitar al usuario BRIANDA el permiso de modificar el contenido de la tabla DEPARTAMENTO
REVOKE UPDATE ON DEPARTAMENTO FROM BRIANDA;

/*
Explicación:
REVOKE UPDATE ON DEPARTAMENTO FROM BRIANDA;: Revoca el permiso de modificar el contenido de la tabla DEPARTAMENTO al usuario BRIANDA.
*/


/*Puntos Clave y Comentarios para el Estudio:
Creación de Usuarios:

CREATE USER: Se utiliza para crear un nuevo usuario en la base de datos. Especifica el nombre de usuario y su contraseña.
Asignación de Roles:

GRANT DBA TO BRIANDA: Asigna el rol DBA al usuario BRIANDA, otorgándole todos los privilegios administrativos. El rol DBA es un rol predeterminado que proporciona un conjunto completo de privilegios administrativos, incluido el control total sobre la base de datos.
Permisos Específicos:

GRANT INSERT: Otorga el permiso para insertar nuevas filas en una tabla específica.
GRANT UPDATE: Otorga el permiso para modificar los datos existentes en una tabla específica.
GRANT puede otorgar varios permisos en una sola instrucción, lo cual es útil para simplificar la gestión de permisos.
Revocación de Permisos:

REVOKE: Se utiliza para revocar permisos previamente otorgados. Es importante conocer cómo revocar permisos para mantener la seguridad y el control de acceso adecuado en la base de datos.
Roles y Privilegios:

Roles: Agrupaciones de permisos que pueden ser asignadas a usuarios para simplificar la gestión de privilegios. Por ejemplo, el rol DBA agrupa muchos permisos administrativos.
Privilegios: Permisos específicos como INSERT, UPDATE, DELETE, SELECT, etc., que se pueden otorgar a usuarios o roles para controlar el acceso a los recursos de la base de datos.
Buenas Prácticas:

Siempre que sea posible, utiliza roles para asignar permisos, ya que esto facilita la gestión y mantenimiento de permisos en la base de datos.
Revoca permisos que ya no sean necesarios para minimizar el riesgo de acceso no autorizado.*/
