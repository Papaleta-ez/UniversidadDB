
/*Crear una base de datos llamada UniversidadDB la cual maneja dos modulos:
academico y seguridad

Modulo academico: Carrera y Estudiante.

Modelo Seguridad: Cargo y Usuario.
*/


Use master;
go

Drop database if exists UniversidadDB;
go

create database UniversidadDB
go

use UniversidadDB
go



CREATE SCHEMA Academico;
GO

CREATE SCHEMA Seguridad;
GO

---------------------------------------------------
--TABLA: Academico.Carrera
---------------------------------------------------

CREATE TABLE Academico.Carrera(
    id INT IDENTITY(1,1),
    nombre NVARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    created_at DATETIME NOT NULL CONSTRAINT DF_Carrera_CreatedAt DEFAULT GETDATE(),
    updated_at DATETIME NULL,
    deleted_at DATETIME NULL,

    -- Mejora: llave primaria con nombre personalizado
    CONSTRAINT PK_Carrera PRIMARY KEY (id),

    -- Mejora: evita nombres de carreras repetidos
    CONSTRAINT UQ_Carrera_Nombre UNIQUE (nombre),

    -- Mejora: valida que el precio sea mayor que cero
    CONSTRAINT CK_Carrera_Precio_Mayor_Cero CHECK (precio > 0),

    -- Mejora: valida fechas correctas
    CONSTRAINT CK_Carrera_Fechas_Validas CHECK (
        (updated_at IS NULL OR updated_at >= created_at)
        AND
        (deleted_at IS NULL OR deleted_at >= created_at)
    )
);
GO