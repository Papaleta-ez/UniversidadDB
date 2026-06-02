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
