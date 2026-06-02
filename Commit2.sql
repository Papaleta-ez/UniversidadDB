select * from academico.carrera;
go

insert into academico.carrera(nombre, precio) values(N'Ingenieria de sistemas',1500)

update academico.carrera set precio = 2000, updated_at = getdate()
where id = 1

insert into Seguridad.Usuario(cif, nombres, apellidos, pw) values
('401', 'Juan','Lopez', hashbytes('SHA2_256', 'Temp2026*'))

Select * from Seguridad.Usuario;

-- ============================================================
-- PRUEBAS DE INSERCIÓN CORRECTAS
-------------------------------------------------------

-- Prueba: carreras válidas.
INSERT INTO Academico.Carrera(nombre, precio)
VALUES 
('Ingeniería en Sistemas', 2500.00),
('Nutrición', 1800.00);
GO

-- Prueba: estudiantes válidos.
INSERT INTO Academico.Estudiante(cif, nombres, apellidos, fechaNac, idCarrera, email, telefono)
VALUES
('20260001', 'Carlos', 'Pérez', '20040510', 1, 'carlos@gmail.com', '87622006'),
('20260002', 'María', 'López', '20050315', 2, 'maria@gmail.com', '88889999');
GO

-- Prueba: cargos válidos.
INSERT INTO Seguridad.Cargo(nombre)
VALUES 
('Administrador'),
('Secretario');
GO

-- Prueba: usuarios válidos relacionados con Cargo.
INSERT INTO Seguridad.Usuario(cif, nombres, apellidos, fechaNac, pw, email, idCargo)
VALUES
('USR202600000001', 'Luis', 'Ramírez', '20000120', CONVERT(VARBINARY(60), 'Clave1234'), 'luis@gmail.com', 1),
('USR202600000002', 'Ana', 'Gómez', '20010812', CONVERT(VARBINARY(60), 'Password2026'), 'ana@gmail.com', 2);
GO

-- ============================================================
-- CONSULTAS PARA COMPROBAR RELACIONES
-- ============================================================

-- Prueba: relación Estudiante con Carrera.
SELECT 
    E.id,
    E.cif,
    E.nombres,
    E.apellidos,
    E.email,
    C.nombre AS Carrera
FROM Academico.Estudiante AS E
INNER JOIN Academico.Carrera AS C
    ON E.idCarrera = C.id;
GO

-- Prueba: relación Usuario con Cargo.
SELECT 
    U.idUsuario,
    U.cif,
    U.nombres,
    U.apellidos,
    U.email,
    C.nombre AS Cargo
FROM Seguridad.Usuario AS U
INNER JOIN Seguridad.Cargo AS C
    ON U.idCargo = C.idCargo;
GO
