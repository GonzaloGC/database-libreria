--Utilizaremos la siguiente sentencia para crear el Trigger
--La sentencia "FOR EACH ROW" define qué se ejecutara cada vez que el tigger sea activado, lo cual acurre una vez por cada registro afectado.
--Por norma entre el "BEGIN" y el "END" agregaremos la sentencia que queremos que se ejecute.
--El "NEW" hace referencia al registro actual al registro que se ha insertado.
--"AFTER" ES EL TIEMPO, YA SEA ANTES O DESPUES.
--"INSERT" ES EL EVENTO.
--"ON libros" la tabla a asociar.
--Para "INSERT" vamos a utilizar "NEW." que hace referencia al registro.
DELIMITER //

CREATE TRIGGER after_insert_actualizacion_libros
AFTER INSERT ON libros
FOR EACH ROW
BEGIN

    UPDATE autores SET cantidad_libros = cantidad_libros + 1
    WHERE autor_id = NEW.autor_id;

END;
//

DELIMITER ;
--ejemplo:
INSERT INTO libros(autor_id, titulo, fecha_publicacion)
    -> VALUES (1, 'Area 81', '2011-07-01');

--TIGGERT - EVENTO DELETE -
--Para "DELETE" vamos a utilizar "OLD." que hace referencia al registro.
DELIMITER //

CREATE TRIGGER after_delete_actualizacion_libros
AFTER DELETE ON libros
FOR EACH ROW
BEGIN

    UPDATE autores SET cantidad_libros = cantidad_libros - 1
    WHERE autor_id = OLD.autor_id;

END;
//

DELIMITER ;

--TIGGERT - EVENTO UPDATE -
DELIMITER //

CREATE TRIGGER after_update_actualizacion_libros
AFTER UPDATE ON libros
FOR EACH ROW
BEGIN
    IF(NEW.autor_id != OLD.autor_id) THEN

        UPDATE autores SET cantidad_libros = cantidad_libros + 1
        WHERE autor_id = NEW.autor_id;
        UPDATE autores SET cantidad_libros = cantidad_libros - 1
        WHERE autor_id = OLD.autor_id;
    
    END IF;
END;
//
--entonces actualizamos
UPDATE libros SET autor_id = 2 WHERE libro_id = 62;

SELECT autor_id, nombre, cantidad_libros FROM autores;

--LISTADO Y ELIMINACION DE TIGGERS
--Para enlistar los TRIGGERS que tenemos
SHOW TRIGGERS\G;

--Para eliminar los TRIGGERS
--El "IF EXISTS" es opcional
DROP TRIGGER IF EXISTS libreria_cf.after_delete_actualizacion_libros;