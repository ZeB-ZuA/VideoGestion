create table Persona (
id_Persona int Primary key,
cedula int,
nombre VARCHAR(50),
apellido VARCHAR(50),
edad int,
ciudad VARCHAR(50)

);

Insert into Persona values (1, 1234, "pepito", "Perez ", 20, "Medellin" );

Insert into Persona (id_Persona, cedula, nombre, apellido, edad, ciudad) values (2, 4567, "juan", "ramos", 40, "Bogota"), (3, 89123, "Jose", "Gomez", 33, "Pereira"); 








CREATE TABLE mascota (
id_Mascota INT PRIMARY KEY,
id_Persona INT, 
nombre VARCHAR(50),
edad INT,
raza VARCHAR(50),
sexo VARCHAR(50),
esterilizado BOOLEAN,
FOREIGN KEY (id_Persona) REFERENCES Persona (id_Persona)  
);



insert into mascota (id_Mascota, id_Persona, nombre, edad, raza, sexo, esterilizado) values (1, 2, "sultan", 2, "perro", "m", true), (2, 2, "manchas", 3, "gato", "f", false),(3, 1, "firulais", 5, "perro", "m", true);

-- LISTAR NOMBRE COMPLETO, EDAD PERSONA, RAZA DE PERRO, EDAD PERRO, ESTERILIZADO, EDAD PERRO <4 

SELECT CONCAT (p.nombre, " ", p.apellido) as nombre_completo, p.edad, m.raza, m.edad, m.esterilizado

FROM persona p, mascota m

WHERE m.edad < 4 AND p.id_Persona = m.id_Persona;



