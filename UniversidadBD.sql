
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
--------------------------------------------------------
-- TABLA: Academico.Estudiante
--------------------------------------------------------

CREATE TABLE Academico.Estudiante(
    id INT IDENTITY(1,1),
    cif VARCHAR(8) NOT NULL,
    nombres NVARCHAR(60) NOT NULL,
    apellidos NVARCHAR(60) NOT NULL,
    fechaNac DATETIME NOT NULL,
    idCarrera INT NOT NULL,
    email NVARCHAR(120) NOT NULL,
    telefono NVARCHAR(60) NULL,

    -- Mejora: llave primaria con nombre personalizado.
    CONSTRAINT PK_Estudiante PRIMARY KEY (id),

    -- Mejora: evita CIF repetidos.
    CONSTRAINT UQ_Estudiante_CIF UNIQUE (cif),

    -- Mejora: evita correos repetidos.
    CONSTRAINT UQ_Estudiante_Email UNIQUE (email),

    -- Mejora: valida que el CIF tenga 8 caracteres.
    CONSTRAINT CK_Estudiante_CIF_Longitud CHECK (LEN(cif) = 8),

    -- Mejora: valida correo electrónico básico.
    CONSTRAINT CK_Estudiante_Email_Valido CHECK (
        email LIKE '%_@_%._%' 
        AND email NOT LIKE '% %'
    ),

    -- Mejora: valida fecha de nacimiento.
    CONSTRAINT CK_Estudiante_FechaNac_Valida CHECK (
        fechaNac BETWEEN '19000101' AND '20260528'
    ),

    -- Mejora: valida teléfono si se registra.
    CONSTRAINT CK_Estudiante_Telefono_Valido CHECK (
        telefono IS NULL OR LEN(telefono) >= 8
    ),

    -- Mejora: llave foránea personalizada entre Estudiante y Carrera.
    CONSTRAINT FK_Estudiante_Carrera FOREIGN KEY (idCarrera)
        REFERENCES Academico.Carrera(id)
);
GO

-----------------------------------------------------------
-- TABLA: Seguridad.Cargo
-----------------------------------------------------------

CREATE TABLE Seguridad.Cargo(
    idCargo INT IDENTITY(1,1),
    nombre NVARCHAR(60) NOT NULL,
    created_at DATETIME NOT NULL CONSTRAINT DF_Cargo_CreatedAt DEFAULT GETDATE(),
    updated_at DATETIME NULL,
    deleted_at DATETIME NULL,

    -- Mejora: llave primaria con nombre personalizado
    CONSTRAINT PK_Cargo PRIMARY KEY (idCargo),

    -- Mejora: evita cargos repetidos
    CONSTRAINT UQ_Cargo_Nombre UNIQUE (nombre),

    -- Mejora: valida fechas correctas
    CONSTRAINT CK_Cargo_Fechas_Validas CHECK (
        (updated_at IS NULL OR updated_at >= created_at)
        AND
        (deleted_at IS NULL OR deleted_at >= created_at)
    )
);
GO
-----------------------------------------------------
-- TABLA: Seguridad.Usuario
-----------------------------------------------------

CREATE TABLE Seguridad.Usuario(
    idUsuario INT IDENTITY(1,1),
    cif VARCHAR(16) NOT NULL,
    nombres NVARCHAR(60) NOT NULL,
    apellidos NVARCHAR(60) NOT NULL,
    fechaNac DATETIME NOT NULL,
    pw VARBINARY(60) NOT NULL,
    email NVARCHAR(120) NOT NULL,

    -- Mejora: se agrega idCargo para relacionar Usuario con Cargo
    idCargo INT NOT NULL,

    created_at DATETIME NOT NULL CONSTRAINT DF_Usuario_CreatedAt DEFAULT GETDATE(),
    updated_at DATETIME NULL,
    deleted_at DATETIME NULL,

    -- Mejora: llave primaria con nombre personalizado
    CONSTRAINT PK_Usuario PRIMARY KEY (idUsuario),

    -- Mejora: evita CIF repetidos
    CONSTRAINT UQ_Usuario_CIF UNIQUE (cif),

    -- Mejora: evita correos repetidos
    CONSTRAINT UQ_Usuario_Email UNIQUE (email),

    -- Mejora: valida longitud mínima del CIF
    CONSTRAINT CK_Usuario_CIF_Longitud CHECK (LEN(cif) >= 8),

    -- Mejora: valida correo electrónico básico
    CONSTRAINT CK_Usuario_Email_Valido CHECK (
        email LIKE '%_@_%._%' 
        AND email NOT LIKE '% %'
    ),

    -- Mejora: valida fecha de nacimiento
    CONSTRAINT CK_Usuario_FechaNac_Valida CHECK (
        fechaNac BETWEEN '19000101' AND '20260528'
    ),

    -- Mejora: como pw es VARBINARY, se usa DATALENGTH para validar mínimo 8 bytes
    CONSTRAINT CK_Usuario_PW_Longitud_Minima CHECK (DATALENGTH(pw) >= 8),

    -- Mejora: valida fechas correctas
    CONSTRAINT CK_Usuario_Fechas_Validas CHECK (
        (updated_at IS NULL OR updated_at >= created_at)
        AND
        (deleted_at IS NULL OR deleted_at >= created_at)
    ),

    -- Mejora solicitada: relación entre Usuario y Cargo
    CONSTRAINT FK_Usuario_Cargo FOREIGN KEY (idCargo)
        REFERENCES Seguridad.Cargo(idCargo)
);
GO