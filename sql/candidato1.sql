 IF NOT EXISTS( 
 SELECT name
 FROM sys.databases
 WHERE name = 'candidato1'
 )
 BEGIN 
 CREATE DATABASE candidato1;
 END
 GO
 USE candidato1;
 GO
 IF OBJECT_ID('docentes','U') IS NULL
 BEGIN
 CREATE TABLE docentes(
 id INT IDENTITY (1,1) PRIMARY KEY,
 nombre_completo VARCHAR(255) NOT NULL,
 correo VARCHAR(255) NOT NULL,
 fecha_ingreso DATETIME NOT NULL
 )
 END
 GO

 IF OBJECT_ID('asignaturas','U') IS NULL
 BEGIN
 CREATE TABLE asignaturas (
  id INT IDENTITY (1,1) PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  codigo VARCHAR(20) NOT NULL UNIQUE
 )
 END
 GO

 IF OBJECT_ID('horarios','U') IS NULL
 BEGIN
 CREATE TABLE horarios (
 id INT IDENTITY(1,1) PRIMARY KEY,
 id_docente INT NOT NULL,
 id_asignatura INT NOT NULL,
 dia_semana VARCHAR(20) NOT NULL,
 hora_inicio TIME NOT NULL,
 hora_fin TIME NOT NULL,

 CONSTRAINT FK_horarios_docente FOREIGN KEY (id_docente) REFERENCES docentes(id),
 CONSTRAINT FK_horarios_asignaturas FOREIGN KEY (id_asignatura) REFERENCES asignaturas(id)
 )
 END 
 GO

CREATE PROCEDURE sp_asignar_horario
@correo_docente VARCHAR(255),
@codigo_asignatura VARCHAR(20),
@dia_semana VARCHAR(255),
@hora_inicio TIME,
@hora_fin TIME
AS
BEGIN
SET NOCOUNT ON;
Ex&
DECLARE @id_docente INT;
DECLARE @id_asignatura INT;

SELECT @id_docente = id FROM docentes WHERE correo = @correo_docente;
IF @id_docente IS NULL
BEGIN 
RAISERROR('Error. Docente con el correo proporcionado no existe actualmente', 16, 1);
RETURN;
END

SELECT @id_asignatura = id FROM asignaturas WHERE codigo = @codigo_asignatura;
IF @id_asignatura IS NULL
BEGIN 
RAISERROR('Error. Asignatura con el codigo proporciando no existe', 16, 1);
RETURN;
END

IF EXISTS (
SELECT 1
FROM horarios
WHERE id_docente = @id_docente AND dia_semana = @dia_semana AND @hora_inicio < hora_fin AND @hora_fin > hora_fin
)
BEGIN 
RAISERROR('Error. El docente ya tiene horario asignado y se cruza en este dia y en hora', 16, 1);
RETURN;
END
INSERT INTO horarios (id_docente, id_asignatura, dia_semana, hora_inicio, hora_fin) VALUES
(@id_docente, @id_asignatura, @dia_semana, @hora_inicio, @hora_fin);

END


SELECT*FROM sys.procedures WHERE name = 'sp_asignar_horario'


CREATE VIEW vw_horarios_docentes AS 
SELECT
d.nombre_completo AS Docente,
d.correo AS Correo_electronico,
a.nombre AS Asignatura,
h.dia_semana AS Dia,
h.hora_inicio AS Hora_inicio,
h.hora_fin AS Hora_fin
FROM horarios h
INNER JOIN docentes d ON h.id_docente = d.id
INNER JOIN asignaturas a ON h.id_asignatura = a.id;


INSERT INTO docentes (nombre_completo, correo, fecha_ingreso) VALUES 
('Levi Hazael Ramos Reyes', 'ramos@levi.com', '2025-05-08 14:35:29.123')

INSERT INTO asignaturas (nombre, codigo) VALUES (
'Matematicas avanzada', 'MAT-04'
)


