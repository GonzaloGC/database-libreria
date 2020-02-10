--TRANSACCIONES--
--Las podemos definir como el mecanismo que nos permite agrupar n cantidad de sentencias sql en una sola, de modo que todas o ningunas de las sentencias tengan exito, propiedad llamada atomicidad.
--Utilizar transacciones nos permite poder afectar a la base de datos de una forma segura.
--En una transaccion podemos definir tres estados, un antes, durantes y despues de la transaccion.
--Las usaremos siempre que queramos que un grupo de sentencias se executen como una sola, y solo se modificara de forma permanente a la base de datos siempre y cuando todas las sentencias allan tenido exito.

--STAR TRANSACTION -->Con esto le indicamos al gestor de base de datos que todos los queries en este momento se executen como uno solo, si nosotros lo deseamos podemos deshacer todos los cambios.
--Utilizaremos "COMMIT;" si queremos persistir permanentamente con todos los cambios en la transaccion
START TRANSACTION;

SET @libro_id =20, @usuario_id =3; --Declaramos 2 variables--

UPDATE libros SET stock = stock - 1 WHERE libro_id = @libro_id;
SELECT stock FROM libros WHERE libro_id = @libro_id;

INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES(@libro_id, @usuario_id);
SELECT * FROM libros_usuarios;

COMMIT;

--HAREMOS QUE NUESTRA TRANSACTION FALLE
--En este caso la declaración de usuario id =100 no existe y al insertar la (linea 29) tendremos un error devido a la llave foranea.
--En el error anterior como una sentencia se executo de manera erronea en la transaction, podemos revertir los cambios con "ROLLBACK;"
--En los casos de "COMMIT;" y "ROLLBACK;" estaremos terminando nuestra transacción.
START TRANSACTION;

SET @libro_id =20, @usuario_id =100; --Declaramos 2 variables--

UPDATE libros SET stock = stock - 1 WHERE libro_id = @libro_id;
SELECT stock FROM libros WHERE libro_id = @libro_id;

INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES(@libro_id, @usuario_id);
SELECT * FROM libros_usuarios;

COMMIT;
ROLLBACK;

--TRANSACCIONES Y STORED PROCEDURES--
--Ocuparemos "DECLARE EXIT HANDLER FOR SQLEXCEPTION" cuando ocurra un error, con esto le estaremos indicando al gesor de base de datos que cuando ocurra un error dentro del procedure este finalize, no sin antes executar todo lo que se encuentre dentro del "BEGIN" y el "END", entre estos dos podemos utilizar cualquier tipo de sentencia, todo lo que queramos que se execute cuando ocurra un error lo pondremos dentro del "BEGIN" y el "END".
DELIMITER //

CREATE PROCEDURE prestamo(usuario_id INT, libro_id INT)
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK
    END;

    START TRANSACTION;

    INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES(libro_id, usuario_id);
    UPDATE libros SET stock = stock - 1 WHERE libros.libro_id = libro_id;

    COMMIT;

END //

DELIMITER ;