-- ESTA SENTENCIA ENTREGARA LOS AUTORES QUE VENDIERON SOBRE EL PROMEDIO DE VENTAS--

SELECT AVG(ventas) FROM books; -- 294.1091

--SET @promedio = (SELECT AVG(ventas) FROM books);

SELECT CONCAT(first_name, " ", last_name) AS nombre
FROM autores
WHERE autor_id IN(
SELECT autor_id 
FROM books 
GROUP BY autor_id 
HAVING SUM(ventas) > (SELECT AVG(ventas) FROM books)); 

--VALIDAR REGISTROS

Disponible
No Disponible
El Hobbit

SELECT IF(
    EXISTS(SELECT libro_id /*llave primaria*/ FROM books WHERE titulo = "El Hobbit"),
    "Disponible",
    "No Disponible"
) AS mensaje;
