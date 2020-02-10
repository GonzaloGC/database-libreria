--INNER JOIN CON SUB CLAUSULA ON (NOS PERMITE CONDICIONAR LA UNION DE MAS COLUMNAS)
SELECT 
    bo.titulo,
    CONCAT (au.first_name, " ", au.last_name) AS nombre_autor,
    bo.fecha_creación
FROM books AS bo
INNER JOIN autores AS au ON bo.autor_id = au.autor_id;

--INNER JOIN CON SUB CLAUSULA USING

SELECT 
    bo.titulo,
    CONCAT (au.first_name, " ", au.last_name) AS nombre_autor,
    bo.fecha_creación
FROM books AS bo
INNER JOIN autores AS au USING(autor_id);

-- OTRO EJEMPLO DE INNER JOIN CON SUB CLAUSULA ON
SELECT 
    bo.titulo,
    CONCAT (au.first_name, " ", au.last_name) AS nombre_autor,
    bo.fecha_creación
FROM books AS bo
INNER JOIN autores AS au ON bo.autor_id = au.autor_id 
    AND au.seudonimo IS NOT NULL;

--LEFT JOIN Y LEFT OUTER JOIN (SON EXACTAMENTE LO MISMO)

/*Entonces la relación de usuarios a libros sera de MUCHOS A MUCHOS!
Cuando tenemos la relacion de muchos a muchos crearemos por obligacion una nueva tabla llamada "libros_usuarios"

usuarios = A
libros_usuarios = B
*/
SELECT
    CONCAT(nombre, " ", apellido),
    libros_usuarios.libro_id
FROM usuarios
LEFT JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
WHERE libros_usuarios.libro_id IS NOT NULL;

/* RIGHT JOIN

libros_usuarios = A
usuarios = B
*/

SELECT
    CONCAT(nombre, " ", apellido),
    libros_usuarios.libro_id
FROM libros_usuarios
RIGHT JOIN usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
WHERE libros_usuarios.libro_id IS NULL;

--MULTIPLES JOINS

Ocuparemos las siguientes tablas
usuarios
libros_usuarios
libros
autores

SELECT DISTINCT
    CONCAT (usuarios.nombre, " ", usuarios.apellido) AS nombre_usuario
    FROM usuarios
    INNER JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
               AND DATE(libros_usuarios.fecha_creacion) = CURDATE()
    INNER JOIN libros ON libros_usuarios.libro_id = libros.libro_id
    INNER JOIN autores ON libros.autor_id = autores.autor_id AND autores.seudonimo IS NOT NULL;

-- PRODUCTOS CARTESIANOS
-- CROSS JOIN

SELECT usuarios.username, libros.titulo FROM usuarios CROSS JOIN libros ORDER BY username DESC;

INSERT INTO libros_usuarios (libro_id, usuario_id) SELECT libro_id, usuario_id FROM usuarios CROSS JOIN libros;