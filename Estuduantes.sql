USE master
GO

DROP DATABASE Alumnos
GO

CREATE DATABASE Alumnos
GO

--Formato:
    --LLAVE PRIMARIA: PK_CampoAfectado  
    --LLAVE FORANEA: FK_TablaActual_CampoAfectado 
    --CHECK: CK_CampoAfectado
    --UNIQUE: U_CampoAfectado
    --DEFAULT: DF_CampoAfectado

USE Alumnos
GO

CREATE TABLE Permisos
(
	IdPermiso		INT IDENTITY(1,1)	NOT NULL,
	NombrePermiso	VARCHAR(20)			NOT NULL,

	CONSTRAINT PK_IdPermiso PRIMARY KEY (IdPermiso),
	CONSTRAINT U_NombrePermiso UNIQUE (NombrePermiso)
)
GO

INSERT INTO Permisos (NombrePermiso) VALUES
	('Editar Usuarios'),
	('Ver Usuarios'),
	('Crear Usuarios'),
	('Editar Alumnos'),
	('Ver Alumnos'),
	('Crear Alumnos'),
	('Borrar Alumnos')
GO

CREATE TABLE Usuarios
(
	IdUsuario		VARCHAR(20)			NOT NULL,
	Nombres			VARCHAR(25)			NOT NULL,
	Apellidos		VARCHAR(25)			NOT NULL,
	Contrasenia		VARBINARY(MAX)		NOT NULL,
	EstadoActivo	BIT					NOT NULL,

	CONSTRAINT PK_IdUsuario PRIMARY KEY (IdUsuario)
)
GO

CREATE TABLE PermisosUsuarios
(
	IdPermiso	INT			NOT NULL,
	IdUsuario	VARCHAR(20)	NOT NULL,
	
	CONSTRAINT PK_IdPermisosUsuarios PRIMARY KEY (IdPermiso,IdUsuario),

	CONSTRAINT FK_PermisosUsuarios_IdPermiso FOREIGN KEY (IdPermiso)
		REFERENCES Permisos(IdPermiso),
	CONSTRAINT FK_PermisosUsuarios_IdUsuario FOREIGN KEY (IdUsuario)
		REFERENCES Usuarios(IdUsuario)
)
GO

CREATE TABLE Materias
(
	IdMateria		TINYINT		NOT NULL	IDENTITY(1,1),
	NombreMateria	VARCHAR(30)	NOT NULL,
	
	CONSTRAINT PK_IdMaterias PRIMARY KEY (IdMateria),
	CONSTRAINT U_NombreMateria UNIQUE(NombreMateria) 
)
GO

INSERT INTO Materias(NombreMateria) VALUES
	( 'Lenguaje y Literatura' ),
	( 'Matemática' ),
	( 'Ciencias naturales' ),
	( 'Estudios sociales y  cívica' ),
	( 'Inglés' ),
	( 'Informática' ),
	( 'Orientación para la vida' ),
	( 'Seminarios' ),
	( 'Conducta' ),
	( 'Asistencia' )
GO


CREATE TABLE Grados
( 
	IdGrado		TINYINT		NOT NULL	IDENTITY(1,1),
	NombreGrado	VARCHAR(30)	NOT NULL,
	
	CONSTRAINT PK_IdGrado PRIMARY KEY (IdGrado),
	CONSTRAINT U_NombreGrado UNIQUE (NombreGrado)
)
GO

INSERT INTO Grados(NombreGrado) VALUES
	( 'Primer año de Bachillerato' ),
	( 'Segundo año de Bachillerato' ),
	( 'Tercer año de Bachillerato' )
GO

CREATE TABLE GradosMaterias
(
	IdGrado		TINYINT	NOT NULL,
	IdMateria	TINYINT	NOT NULL,
	
	CONSTRAINT PK_IdGradoMateria PRIMARY KEY (IdGrado,IdMateria),
	
	CONSTRAINT FK_GradosMaterias_IdGrado FOREIGN KEY (IdGrado)
		REFERENCES Grados(IdGrado),
	CONSTRAINT FK_GradosMaterias_IdMateria FOREIGN KEY (IdMateria)
		REFERENCES Materias(IdMateria)
)
   
CREATE TABLE Alumnos
(
	IdAlumno		CHAR(8)		NOT NULL,	--	1AP/2AP/2DA/C EXAMPLE: LT172547
	NombresAlumno	VARCHAR(25)	NOT NULL,
	PrimerApellido	VARCHAR(25)	NOT NULL,
	SegundoApellido	VARCHAR(25)	NOT NULL,
	FechaNacimiento	DATE		NULL,
	AnioIngreso		INT		NOT NULL,

	CONSTRAINT PK_IdAlumno PRIMARY KEY (IdAlumno)
)
GO
 
CREATE TABLE GradosAlumnos
(
	IdGradoAlumno	INT		NOT NULL	IDENTITY(1,1),
	IdAlumno		CHAR(8)	NOT NULL,
	IdGrado			TINYINT	NOT NULL,
	Seccion			CHAR(1)	NOT NULL,
	Anio			INT		NOT NULL,
	
	CONSTRAINT PK_IdGradoAlumno PRIMARY KEY (IdGradoAlumno),

	CONSTRAINT FK_GradosAlumnos_IdAlumno FOREIGN KEY (IdAlumno)
		REFERENCES Alumnos(IdAlumno),
	CONSTRAINT FK_GradosAlumnas_IdGrado FOREIGN KEY (IdGrado)
		REFERENCES Grados(IdGrado),

	CONSTRAINT CK_Seccion CHECK (Seccion = '[A-Z]'),
	CONSTRAINT U_GradoAlumna UNIQUE (IdAlumno, IdGrado, Anio)
)
GO

CREATE TABLE TiposNotas
(
	IdTipoNota	TINYINT		NOT NULL	IDENTITY(1,1),
	TipoNota	VARCHAR(15)	NOT NULL,
	IdMateria	TINYINT		NOT NULL,
	ponderacion	INT			NOT NULL,

	CONSTRAINT PK_IdTipoNota PRIMARY KEY (IdTipoNota),
	CONSTRAINT U_TipoNota UNIQUE (IdMateria,TipoNota),
	
	CONSTRAINT FK_TiposNotas_IdMateria FOREIGN KEY (IdMateria)
		REFERENCES Materias(IdMateria),

	CONSTRAINT CK_Ponderacion CHECK (ponderacion BETWEEN 1 and 100)
)
GO

CREATE TABLE Notas
(
	IdGradoAlumno	INT				NOT NULL,
	IdTipoNota		TINYINT			NOT NULL,
	Anio			INT				NOT NULL,
	Nota			NUMERIC(4,2)	NOT NULL,

	CONSTRAINT PK_IdNota PRIMARY KEY (IdGradoAlumno,IdTipoNota,Anio),

	CONSTRAINT FK_Notas_IdGradoAlumno FOREIGN KEY (IdGradoAlumno)
		REFERENCES GradosAlumnos(IdGradoAlumno),
	CONSTRAINT FK_Notas_IdTipoNota FOREIGN KEY (IdTipoNota)
		REFERENCES TiposNotas(IdTipoNota)
)
GO
--SP PermisosUsuarios
CREATE PROCEDURE SP_InsertarPermisosUsuarios
	@IdPermiso	INT,
	@IdUsuario	VARCHAR(20)
AS
BEGIN
	INSERT INTO PermisosUsuarios(IdPermiso,IdUsuario) VALUES
	(@IdPermiso,@IdUsuario)
END
GO
CREATE PROCEDURE SP_EliminarPermisosUsuarios
	@IdPermiso	INT,
	@IdUsuario	VARCHAR(20)
AS
BEGIN
	DELETE FROM PermisosUsuarios
	WHERE IdPermiso = @IdPermiso
	AND IdUsuario = @IdUsuario
END
GO
CREATE PROCEDURE SP_BuscarPermisosUsuarios
AS
BEGIN
	SELECT * FROM PermisosUsuarios
END
GO
--SP permisos
GO
CREATE PROCEDURE SP_BuscarPermisos
AS
BEGIN
	SELECT * FROM GradosAlumnos
END
GO

--SP GradosMaterias
CREATE PROCEDURE SP_InsertarGradosMaterias
	@IdGrado		TINYINT,
	@IdMateria		TINYINT
AS
BEGIN
	INSERT INTO GradosMaterias(IdGrado,IdMateria) VALUES
	(@IdGrado,@IdMateria)
END
GO
CREATE PROCEDURE SP_EliminarGradosMaterias
	@IdGrado		TINYINT,
	@IdMateria		TINYINT
AS
BEGIN
	DELETE FROM GradosMaterias
	WHERE IdGrado = @IdGrado
	AND IdMateria = @IdMateria
END
GO
CREATE PROCEDURE SP_BuscarGradosMaterias
AS
BEGIN
	SELECT * FROM GradosAlumnos
END
GO
-- SP GradosAlumnos
CREATE PROCEDURE SP_InsertarGradosAlumnos
	@IdAlumno		CHAR(8),
	@IdGrado		TINYINT,
	@Seccion		CHAR(1),
	@Anio			INT
AS
BEGIN
	INSERT INTO GradosAlumnos(IdAlumno,IdGrado,Seccion,Anio) VALUES
	(@IdAlumno,@IdGrado,@Seccion,@Anio)
END
GO
CREATE PROCEDURE SP_EliminarGradosAlumnos
	@IdGradoAlumno		INT
AS
BEGIN
	DELETE FROM GradosAlumnos
	WHERE IdGradoAlumno = @IdGradoAlumno
END
GO
CREATE PROCEDURE SP_BuscarGradosAlumnos
AS
BEGIN
--SELECT row_number() over(PARTITION by Anio,IdGrado,Seccion order by PrimerApellido) AS 'NoLista',* from Alumnos a INNER JOIN GradosAlumnos ga on a.IdAlumno = ga.IdAlumno 
	SELECT * FROM GradosAlumnos
END
GO
-- SP Notas
CREATE PROCEDURE SP_InsertarNotas
	@IdGradoAlumno		INT,
	@IdTipoNota			TINYINT,
	@Anio				INT,
	@Nota				NUMERIC(4,2)
AS
BEGIN
	INSERT INTO Notas(IdGradoAlumno,IdTipoNota,Anio,Nota) VALUES
	(@IdGradoAlumno,@IdTipoNota,@Anio,@Nota)
END
GO
CREATE PROC SP_EditarNotas
	@IdGradoAlumno		INT,
	@IdTipoNota			TINYINT,
	@Anio				INT,
	@Nota				NUMERIC(4,2)
AS
BEGIN
	UPDATE Notas SET
	Nota = @Nota
	WHERE IdGradoAlumno = @IdGradoAlumno
	AND IdTipoNota = @IdTipoNota
	AND Anio = @Anio
END
GO
CREATE PROCEDURE SP_EliminarNotas
	@IdGradoAlumno		INT,
	@IdTipoNota			TINYINT,
	@Anio				INT
AS
BEGIN
	DELETE FROM Notas
	WHERE IdGradoAlumno = @IdGradoAlumno
	AND IdTipoNota = @IdTipoNota
	AND Anio = @Anio
END
GO
CREATE PROCEDURE SP_BuscarNotas
AS
BEGIN
	SELECT * FROM Notas
END
GO
--SP GRADOS
CREATE PROC SP_ListarGrados
AS
	SELECT * FROM Grados
	ORDER BY NombreGrado ASC
GO
CREATE PROC SP_InsertarGrados
	@NombreGrado	VARCHAR(30)
AS
BEGIN
	INSERT INTO Grados(NombreGrado) VALUES
	(@NombreGrado)
END
GO
CREATE PROC SP_EditarGrados
	@IdGrado		INT,
	@NombreGrado	VARCHAR(30)
AS
BEGIN
	UPDATE Grados
	SET NombreGrado = @NombreGrado 
	WHERE IdGrado = @IdGrado
END
GO
CREATE PROC SP_EliminarGrados
	@IdGrado	INT
AS
BEGIN
	DELETE FROM Grados WHERE IdGrado = @IdGrado
END
GO

--SP MATERIAS
CREATE PROC SP_ListarMaterias
AS
	SELECT * FROM Materias
	ORDER BY NombreMateria ASC
GO

CREATE PROC SP_VerMateria
@IdMateria		TINYINT
AS
	SELECT * FROM Materias WHERE IdMateria = @IdMateria
GO

CREATE PROC SP_InsertarMaterias
@NombreMateria VARCHAR(30)
AS
BEGIN
	INSERT INTO Materias(NombreMateria) VALUES
	(@NombreMateria)
END
GO

CREATE PROC SP_EditarMaterias
@IdMateria		TINYINT,
@NombreMateria	VARCHAR(30)
AS
BEGIN
	UPDATE Materias SET
	NombreMateria = @NombreMateria
	WHERE IdMateria = @IdMateria
END
GO

CREATE PROC SP_EliminarMaterias
@IdMateria		TINYINT
AS
BEGIN
	DELETE FROM Materias
	WHERE IdMateria = @IdMateria
END
GO

--SP TIPOSNOTAS
CREATE PROC SP_ListarTiposNotas
AS
	SELECT * FROM TiposNotas
	ORDER BY TipoNota ASC
GO

CREATE PROC SP_InsertarTiposNotas
@IdMateria		TINYINT,
@TipoNota		VARCHAR(15),
@Ponderacion	INT
AS
BEGIN
	INSERT INTO TiposNotas(IdMateria,TipoNota,ponderacion) VALUES
	(@IdMateria,@TipoNota,@Ponderacion)
END
GO

CREATE PROC SP_EditarTiposNotas
@IdTipoNota		TINYINT,
@TipoNota		VARCHAR(15),
@Ponderacion	INT
AS
BEGIN
	UPDATE TiposNotas SET
	ponderacion = @Ponderacion,
	TipoNota = @TipoNota
	WHERE IdTipoNota = @IdTipoNota
END
GO

CREATE PROC SP_EliminarTiposNotas
@IdTipoNota		TINYINT
AS
BEGIN
	DELETE FROM TiposNotas
	WHERE IdTipoNota = @IdTipoNota
END
GO

--SP USUARIOS
CREATE PROCEDURE SP_BuscarUsuarios
    @condicion varchar(20)
AS
BEGIN
    SELECT Nombres, Apellidos, IdUsuario, EstadoActivo from Usuarios 
	WHERE IdUsuario LIKE @condicion+'%'
END
GO

CREATE PROCEDURE SP_BuscarUsuario
    @condicion varchar(20)
AS
BEGIN
    SELECT Nombres, Apellidos,IdUsuario, EstadoActivo from Usuarios 
	WHERE IdUsuario  = @condicion
END
GO

CREATE PROCEDURE SP_InsertarUsuario
	@NombresUsuario		VARCHAR(25), 
	@ApellidosUsuario	VARCHAR(25),
	@IdUsuario			VARCHAR(20), 
	@Contrasenia		NVARCHAR(25),
	@Estado				BIT
AS
BEGIN
    INSERT INTO  Usuarios(Nombres, Apellidos,IdUsuario, Contrasenia, EstadoActivo) VALUES
	(@NombresUsuario,@ApellidosUsuario,@IdUsuario,HASHBYTES('SHA2_256', HASHBYTES('SHA2_512', @Contrasenia)),@Estado)
END
GO
CREATE PROCEDURE SP_EliminarUsuario
    @NomUsuario varchar(20)
AS
BEGIN
    Delete from Usuarios
	WHERE IdUsuario = @NomUsuario
END
GO
CREATE PROCEDURE SP_ComprobarUsuario
    @NomUsuario varchar(20),
	@Contrasenia nvarchar(25)
AS
BEGIN
    SELECT * from Usuarios
	WHERE IdUsuario = @NomUsuario AND Contrasenia = HASHBYTES('SHA2_256', HASHBYTES('SHA2_512',@Contrasenia))
END
GO
CREATE PROCEDURE SP_EditarUsuario
	@NombresUsuario  varchar(25), 
	@ApellidosUsuario  varchar(25),
	@NomUsuario  varchar(20),
	@Estado bit,
	@Condicion varchar(20)
AS
BEGIN
UPDATE Usuarios SET
	Nombres			= @NombresUsuario,
	Apellidos		= @ApellidosUsuario, 
	IdUsuario	= @NomUsuario,
	EstadoActivo	= @Estado
WHERE IdUsuario	= @Condicion
END
GO
--SP Alumno
CREATE PROCEDURE SP_InsertarAlumno
	@NombreAlumno		varchar(25),
	@PrimerApellido		varchar(25),
	@SegundoApellido	varchar(25),
	@AnioIngreso		INT,
	@FechaNacimiento	date
AS
BEGIN
	DECLARE @year		CHAR(2) = RIGHT( CAST(@AnioIngreso AS CHAR(4)),2)
	DECLARE @count		CHAR(4) = FORMAT((SELECT COUNT(*)+1 FROM Alumnos WHERE IdAlumno LIKE '__'+ @year +'____'),'0000') 
	DECLARE @IdAlumno	CHAR(8) = LEFT(@PrimerApellido,1)+LEFT(@SegundoApellido,1)+ @year + @count

INSERT INTO Alumnos(IdAlumno,NombresAlumno,PrimerApellido,SegundoApellido,AnioIngreso,FechaNacimiento) VALUES
(
	@IdAlumno,
	@NombreAlumno,
	@PrimerApellido,
	@SegundoApellido,
	@AnioIngreso,
	@FechaNacimiento
)
END
GO

CREATE PROC SP_EditarAlumno
	@IdAlumno 			char(8),
	@NombreAlumno 		varchar(25),
	@PrimerApellido		varchar(25),
	@SegundoApellido	varchar(25),
	@FechaNacimiento	date
AS
BEGIN
	UPDATE Alumnos SET
	NombresAlumno	= @NombreAlumno,
	PrimerApellido	= @PrimerApellido,
	SegundoApellido	= @SegundoApellido,
	FechaNacimiento	= @FechaNacimiento
	WHERE IdAlumno		= @IdAlumno
END
GO

CREATE PROCEDURE SP_EliminarAlumno
    @IdAlumno char(8)
AS
BEGIN
	DELETE FROM Alumnos
	WHERE IdAlumno = @IdAlumno
END
GO

CREATE PROCEDURE SP_BuscarAlumno
    @IdAlumno char(8)
AS
BEGIN
	SELECT * FROM Alumnos
	WHERE IdAlumno = @IdAlumno
END
GO

CREATE PROCEDURE SP_BuscarAlumnos
    @IdAlumno VARCHAR(8)
AS
BEGIN
	SELECT * FROM Alumnos
	WHERE IdAlumno like @IdAlumno+'%'
END
GO
--Dummy data
EXEC SP_InsertarAlumno 'Morgan','Foster','Bradley',2013,'2021-10-06';
EXEC SP_InsertarAlumno 'Aline','Floyd','Weiss',2012,'2018-02-23' ;
EXEC SP_InsertarAlumno 'Axel','Mayer','Joyce',2012,'2018-01-24' ;
EXEC SP_InsertarAlumno 'Alden','Hogan','Weeks',2013,'2011-03-24' ;
EXEC SP_InsertarAlumno 'Glenna','Russell','Pruitt',2012,'2018-06-06' ;
EXEC SP_InsertarAlumno 'Jayme','Webster','Nielsen',2020,'2016-07-24' ;
EXEC SP_InsertarAlumno 'Zane','Morton','Bullock',2014,'2021-02-26' ;
EXEC SP_InsertarAlumno 'Beau','Moss','Mullins',2011,'2011-11-02' ;
EXEC SP_InsertarAlumno 'Eaton','Browning','Savage',2015,'2015-12-10' ;
EXEC SP_InsertarAlumno 'Venus','Reeves','Salinas',2014,'2016-01-17' ;
EXEC SP_InsertarAlumno 'Rose','Marsh','Mcbride',2010,'2018-03-03' ;
EXEC SP_InsertarAlumno 'Simon','Stephenson','Gonzalez',2012,'2018-05-08' ;
EXEC SP_InsertarAlumno 'Devin','Riggs','Washington',2015,'2018-09-11' ;
EXEC SP_InsertarAlumno 'MacKenzie','Ashley','Duffy',2011,'2017-08-06' ;
EXEC SP_InsertarAlumno 'Kaitlin','Fields','Pickett',2010,'2013-05-05' ;
EXEC SP_InsertarAlumno 'Basil','Dalton','Franks',2013,'2017-04-02' ;
EXEC SP_InsertarAlumno 'Jenna','Townsend','Velez',2013,'2019-02-15' ;
EXEC SP_InsertarAlumno 'Dominique','Rosario','Lawson',2012,'2015-08-29' ;
EXEC SP_InsertarAlumno 'Rooney','Blair','Mccormick',2011,'2021-04-15' ;
EXEC SP_InsertarAlumno 'Aurora','Hart','Tillman',2013,'2020-03-27' ;
EXEC SP_InsertarAlumno 'Keith','Stein','Brewer',2015,'2014-11-25' ;
EXEC SP_InsertarAlumno 'Raymond','Brewer','Myers',2019,'2012-10-05' ;
EXEC SP_InsertarAlumno 'Jasper','Compton','Kaufman',2019,'2012-12-23' ;
EXEC SP_InsertarAlumno 'Victor','Lindsay','Snow',2018,'2015-04-22' ;
EXEC SP_InsertarAlumno 'Ava','Kaufman','Horn',2019,'2018-12-15' ;
EXEC SP_InsertarAlumno 'Kuame','Fulton','Barton',2010,'2017-02-07' ;
EXEC SP_InsertarAlumno 'Quentin','Austin','Mosley',2014,'2021-10-06' ;
EXEC SP_InsertarAlumno 'Denise','Salas','Foley',2010,'2017-09-12' ;
EXEC SP_InsertarAlumno 'Buckminster','Parsons','Bridges',2014,'2013-02-13' ;
EXEC SP_InsertarAlumno 'Nehru','Dixon','Rose',2010,'2013-10-05' ;
EXEC SP_InsertarAlumno 'Olympia','Cortez','Estrada',2019,'2019-01-10' ;
EXEC SP_InsertarAlumno 'Fulton','Brown','Schwartz',2010,'2012-12-21' ;
EXEC SP_InsertarAlumno 'Xenos','Woodward','Whitney',2020,'2021-02-12' ;
EXEC SP_InsertarAlumno 'Jacob','Pearson','Burgess',2017,'2019-08-03' ;
EXEC SP_InsertarAlumno 'Damon','Head','Montgomery',2020,'2016-08-24' ;
EXEC SP_InsertarAlumno 'Aretha','Hebert','Doyle',2016,'2020-02-29' ;
EXEC SP_InsertarAlumno 'Brenda','Snider','Becker',2011,'2016-05-29' ;
EXEC SP_InsertarAlumno 'Eve','Hewitt','Barnett',2015,'2014-02-27' ;
EXEC SP_InsertarAlumno 'Warren','Summers','Gonzales',2020,'2016-02-14' ;
EXEC SP_InsertarAlumno 'Riley','Hughes','Sharp',2020,'2013-12-31' ;
EXEC SP_InsertarAlumno 'Conan','Estes','Clayton',2018,'2011-12-04' ;
EXEC SP_InsertarAlumno 'Guinevere','Rivers','Mccarty',2020,'2015-10-21' ;
EXEC SP_InsertarAlumno 'Linda','Gonzales','Knapp',2013,'2017-07-30' ;
EXEC SP_InsertarAlumno 'Dahlia','Mcmahon','Woods',2012,'2013-06-18' ;
EXEC SP_InsertarAlumno 'Colorado','Newman','Gay',2016,'2018-08-18' ;
EXEC SP_InsertarAlumno 'Britanney','Robbins','Baxter',2011,'2013-01-15' ;
EXEC SP_InsertarAlumno 'Maite','Richard','Lucas',2017,'2013-08-14' ;
EXEC SP_InsertarAlumno 'Flavia','Floyd','Clark',2010,'2021-05-05' ;
EXEC SP_InsertarAlumno 'Quon','Cantrell','Sutton',2016,'2019-09-13' ;
EXEC SP_InsertarAlumno 'Hilel','Mosley','Hoover',2013,'2019-08-28' ;
EXEC SP_InsertarAlumno 'Nigel','Gates','Vinson',2010,'2014-04-30' ;
EXEC SP_InsertarAlumno 'Yael','Cooley','Chen',2017,'2014-10-24' ;
EXEC SP_InsertarAlumno 'Judah','Huber','Bridges',2017,'2014-11-19' ;
EXEC SP_InsertarAlumno 'Daniel','Brewer','Sargent',2016,'2012-05-04' ;
EXEC SP_InsertarAlumno 'Tate','Bowman','Woods',2020,'2014-04-28' ;
EXEC SP_InsertarAlumno 'Jada','Santos','Moses',2020,'2013-01-23' ;
EXEC SP_InsertarAlumno 'Theodore','Waters','Pugh',2019,'2020-01-11' ;
EXEC SP_InsertarAlumno 'Iris','Spears','Dotson',2013,'2017-05-21' ;
EXEC SP_InsertarAlumno 'Chloe','Hodges','Vincent',2013,'2017-07-03' ;
EXEC SP_InsertarAlumno 'Abra','Mcconnell','Lester',2018,'2016-08-27' ;
EXEC SP_InsertarAlumno 'Tanek','Juarez','Puckett',2015,'2018-04-28' ;
EXEC SP_InsertarAlumno 'Wyatt','Mcdaniel','Carrillo',2016,'2015-10-10' ;
EXEC SP_InsertarAlumno 'Malik','Clay','Walls',2020,'2016-03-28' ;
EXEC SP_InsertarAlumno 'Lee','Burris','Wall',2018,'2012-10-20' ;
EXEC SP_InsertarAlumno 'Bryar','Roth','Pearson',2013,'2013-02-20' ;
EXEC SP_InsertarAlumno 'Dale','Tanner','Mendoza',2016,'2019-11-03' ;
EXEC SP_InsertarAlumno 'Keith','Barton','Velazquez',2016,'2015-11-03' ;
EXEC SP_InsertarAlumno 'Angela','Owen','Bell',2017,'2016-04-06' ;
EXEC SP_InsertarAlumno 'Henry','Burke','Mcdaniel',2016,'2017-12-19' ;
EXEC SP_InsertarAlumno 'Dawn','Strong','Davidson',2015,'2017-09-18' ;
EXEC SP_InsertarAlumno 'Kylan','Hines','Garrett',2016,'2016-12-12' ;
EXEC SP_InsertarAlumno 'Jaquelyn','Cabrera','Parker',2020,'2021-03-23' ;
EXEC SP_InsertarAlumno 'Basil','Benton','Durham',2018,'2015-10-09' ;
EXEC SP_InsertarAlumno 'Matthew','Morton','Crane',2011,'2012-07-09' ;
EXEC SP_InsertarAlumno 'Malik','Campbell','Jensen',2018,'2011-06-19' ;
EXEC SP_InsertarAlumno 'Macey','Atkins','Davidson',2020,'2019-01-23' ;
EXEC SP_InsertarAlumno 'Zephania','Aguilar','Sosa',2019,'2012-10-05' ;
EXEC SP_InsertarAlumno 'Shay','Combs','Barton',2018,'2014-07-10' ;
EXEC SP_InsertarAlumno 'Jelani','Stout','Love',2016,'2013-11-13' ;
EXEC SP_InsertarAlumno 'Hayfa','Rich','Herrera',2015,'2016-09-16' ;
EXEC SP_InsertarAlumno 'Idona','Romero','Carney',2014,'2017-10-27' ;
EXEC SP_InsertarAlumno 'Baker','Copeland','Haley',2014,'2019-03-21' ;
EXEC SP_InsertarAlumno 'Hedy','Prince','Schultz',2013,'2019-08-17' ;
EXEC SP_InsertarAlumno 'Armand','Whitley','Lott',2020,'2016-08-05' ;
EXEC SP_InsertarAlumno 'Xena','Mcguire','Wilson',2010,'2016-03-20' ;
EXEC SP_InsertarAlumno 'Tucker','Ochoa','Mcintyre',2011,'2019-08-18' ;
EXEC SP_InsertarAlumno 'Sade','Rodriguez','Marks',2017,'2019-02-03' ;
EXEC SP_InsertarAlumno 'Virginia','Jenkins','Meyers',2011,'2012-06-10' ;
EXEC SP_InsertarAlumno 'Anastasia','Wall','Pittman',2016,'2011-02-19' ;
EXEC SP_InsertarAlumno 'Dominique','Wade','Mccall',2010,'2012-10-07' ;
EXEC SP_InsertarAlumno 'Lester','Carrillo','Pugh',2018,'2018-12-27' ;
EXEC SP_InsertarAlumno 'Phillip','Fernandez','Palmer',2018,'2018-10-29' ;
EXEC SP_InsertarAlumno 'Guinevere','Callahan','Kidd',2013,'2015-03-15' ;
EXEC SP_InsertarAlumno 'Theodore','Barrera','Butler',2017,'2020-11-13' ;
EXEC SP_InsertarAlumno 'Ryan','Howe','Howard',2010,'2018-08-26' ;
EXEC SP_InsertarAlumno 'Rowan','Stark','Sherman',2018,'2010-11-14' ;
EXEC SP_InsertarAlumno 'Cassady','Wong','Stanton',2012,'2013-04-21' ;
EXEC SP_InsertarAlumno 'Shafira','French','Newton',2020,'2020-12-10' ;
EXEC SP_InsertarAlumno 'Veronica','Rojas','Munoz',2017,'2013-03-24' ;
EXEC SP_InsertarAlumno 'Madaline','Chan','Schwartz',2020,'2015-03-24' ; 
EXEC SP_InsertarAlumno 'Pearl','Lucas','Craft',2013,'2016-10-12' ;
EXEC SP_InsertarAlumno 'Devin','Morales','Hicks',2019,'2018-10-23' ;
EXEC SP_InsertarAlumno 'Tasha','Ortega','Olson',2020,'2011-09-07' ;
EXEC SP_InsertarAlumno 'Geraldine','Byrd','Orr',2010,'2017-12-10' ;
EXEC SP_InsertarAlumno 'Noble','Hester','Ross',2010,'2016-10-31' ;
EXEC SP_InsertarAlumno 'Mallory','Dominguez','Hurst',2015,'2017-12-17' ;
EXEC SP_InsertarAlumno 'Callie','Hartman','Edwards',2013,'2021-08-07' ;
EXEC SP_InsertarAlumno 'Illana','Hodges','Daugherty',2018,'2011-05-10' ;
EXEC SP_InsertarAlumno 'Yoshi','Jenkins','Kane',2020,'2015-08-27' ;
EXEC SP_InsertarAlumno 'Brenden','Hale','Finch',2012,'2014-03-12' ;
EXEC SP_InsertarAlumno 'Breanna','Sullivan','King',2012,'2015-06-11' ;
EXEC SP_InsertarAlumno 'Chase','Nolan','Winters',2019,'2021-01-05' ;
EXEC SP_InsertarAlumno 'Wallace','Randolph','Christensen',2020,'2015-05-06' ;
EXEC SP_InsertarAlumno 'Howard','Wilkinson','Fowler',2018,'2018-10-18' ;
EXEC SP_InsertarAlumno 'Leslie','Mills','Chang',2017,'2011-10-10' ;
EXEC SP_InsertarAlumno 'Jerry','Cunningham','Griffith',2019,'2019-11-26' ;
EXEC SP_InsertarAlumno 'Natalie','Mcfarland','Boone',2015,'2011-03-10' ;
EXEC SP_InsertarAlumno 'Dolan','Morgan','Donaldson',2011,'2019-10-26' ;
EXEC SP_InsertarAlumno 'Armando','Welch','Savage',2019,'2011-03-09' ;
EXEC SP_InsertarAlumno 'Jack','Jenkins','Sheppard',2019,'2011-02-09' ;
EXEC SP_InsertarAlumno 'Mallory','Stuart','Farmer',2019,'2017-11-12' ;
EXEC SP_InsertarAlumno 'Rose','Norris','Keller',2018,'2018-06-23' ;
EXEC SP_InsertarAlumno 'Orli','Mcdaniel','Chapman',2010,'2013-10-01' ;
EXEC SP_InsertarAlumno 'Kylan','Dillon','Reeves',2013,'2021-07-06' ;
EXEC SP_InsertarAlumno 'Derek','Barnett','Burks',2010,'2016-10-13' ;
EXEC SP_InsertarAlumno 'Irma','Gray','Acevedo',2018,'2020-11-15' ;
EXEC SP_InsertarAlumno 'Uta','Drake','Hooper',2011,'2017-06-15' ;
EXEC SP_InsertarAlumno 'Jared','Wiggins','Figueroa',2011,'2015-07-30' ;
EXEC SP_InsertarAlumno 'Dieter','Tate','Zimmerman',2020,'2013-05-08' ;
EXEC SP_InsertarAlumno 'Kaye','Sims','Stout',2015,'2014-12-30' ;
EXEC SP_InsertarAlumno 'Denton','Craig','Webb',2010,'2020-06-09' ;
EXEC SP_InsertarAlumno 'Kasper','Lee','Morrow',2016,'2010-10-05' ;
EXEC SP_InsertarAlumno 'Deacon','Marshall','Dixon',2016,'2012-11-21' ;
EXEC SP_InsertarAlumno 'Chiquita','Pope','Berg',2015,'2012-05-12' ;
EXEC SP_InsertarAlumno 'Omar','Hooper','Kirk',2016,'2017-02-20' ;
EXEC SP_InsertarAlumno 'Casey','Anderson','Carter',2018,'2014-03-01' ;
EXEC SP_InsertarAlumno 'Jenette','Chan','Peters',2016,'2012-08-09' ;
EXEC SP_InsertarAlumno 'Galena','Gilliam','England',2011,'2018-02-20' ;
EXEC SP_InsertarAlumno 'Mira','Smith','Parsons',2020,'2015-09-15' ;
EXEC SP_InsertarAlumno 'Orlando','Barron','Hays',2011,'2017-02-26' ;
EXEC SP_InsertarAlumno 'Winter','Ewing','Turner',2017,'2011-03-30' ;
EXEC SP_InsertarAlumno 'Lysandra','Ferguson','Potts',2019,'2011-12-27' ;
EXEC SP_InsertarAlumno 'Aurora','Wong','Morton',2011,'2012-05-30' ;
EXEC SP_InsertarAlumno 'Joelle','Carlson','Blackburn',2020,'2013-08-02' ;
EXEC SP_InsertarAlumno 'Cheryl','Dejesus','Barry',2017,'2014-03-24' ;
EXEC SP_InsertarAlumno 'Joelle','Pierce','Kinney',2018,'2018-08-04' ;
EXEC SP_InsertarAlumno 'Nissim','Black','Craig',2011,'2015-09-08' ;
EXEC SP_InsertarAlumno 'Drew','Ryan','Jarvis',2014,'2019-03-31' ;
EXEC SP_InsertarAlumno 'Jane','Bryant','Juarez',2020,'2017-04-22' ;
EXEC SP_InsertarAlumno 'Chadwick','Schroeder','Ward',2011,'2012-10-03' ;
EXEC SP_InsertarAlumno 'Yoshi','Buchanan','Wilkinson',2020,'2020-02-09' ;
EXEC SP_InsertarAlumno 'Aristotle','Flowers','Austin',2019,'2017-01-18' ;
EXEC SP_InsertarAlumno 'Alden','Oneil','Mccall',2016,'2014-04-04' ;
EXEC SP_InsertarAlumno 'Wynne','Stuart','Savage',2019,'2013-10-19' ;
EXEC SP_InsertarAlumno 'Lael','Barker','Valencia',2020,'2011-12-03' ;
EXEC SP_InsertarAlumno 'Belle','Anderson','Mathis',2010,'2016-05-27' ;
EXEC SP_InsertarAlumno 'Harding','Norris','Garza',2014,'2019-02-01' ;
EXEC SP_InsertarAlumno 'Charissa','Shelton','Bell',2019,'2011-06-06' ;
EXEC SP_InsertarAlumno 'Samson','Kidd','Emerson',2011,'2011-08-09' ;
EXEC SP_InsertarAlumno 'Brittany','Clay','Roberson',2017,'2011-07-22' ;
EXEC SP_InsertarAlumno 'Troy','Austin','Shaffer',2013,'2015-11-13' ;
EXEC SP_InsertarAlumno 'Alec','Frank','Snow',2010,'2018-11-23' ;
EXEC SP_InsertarAlumno 'Carla','Barrett','Moody',2011,'2019-01-18' ;
EXEC SP_InsertarAlumno 'Griffith','Parsons','Shannon',2015,'2020-10-21' ;
EXEC SP_InsertarAlumno 'Rajah','Blair','Henson',2017,'2020-11-01' ;
EXEC SP_InsertarAlumno 'Chelsea','Chambers','Dotson',2014,'2011-05-22' ;
EXEC SP_InsertarAlumno 'Aristotle','Sheppard','Avila',2010,'2015-01-11' ;
EXEC SP_InsertarAlumno 'Iliana','Brown','Anthony',2013,'2011-04-18' ;
EXEC SP_InsertarAlumno 'Forrest','Moreno','Lindsey',2018,'2019-09-19' ;
EXEC SP_InsertarAlumno 'Patience','Doyle','Poole',2011,'2013-08-29' ;
EXEC SP_InsertarAlumno 'Dieter','Hutchinson','Holt',2013,'2010-10-13' ;
EXEC SP_InsertarAlumno 'Brooke','Hamilton','Pope',2017,'2013-02-20' ;
EXEC SP_InsertarAlumno 'Candice','Reilly','Mullen',2019,'2020-09-20' ;
EXEC SP_InsertarAlumno 'Nathaniel','Morales','Haney',2013,'2011-03-26' ;
EXEC SP_InsertarAlumno 'Palmer','Merritt','Ortiz',2012,'2012-03-26' ;
EXEC SP_InsertarAlumno 'Nehru','Fitzgerald','Raymond',2012,'2019-02-05' ;
EXEC SP_InsertarAlumno 'Alvin','Wright','Morrow',2012,'2011-09-24' ;
EXEC SP_InsertarAlumno 'Marvin','Love','Soto',2014,'2019-10-15' ;
EXEC SP_InsertarAlumno 'Kennedy','Lawrence','Berger',2014,'2020-07-14' ;
EXEC SP_InsertarAlumno 'Marshall','Benton','Sellers',2015,'2011-11-06' ;
EXEC SP_InsertarAlumno 'Alexa','Schultz','Walton',2017,'2015-09-10' ;
EXEC SP_InsertarAlumno 'Rae','Chavez','Valencia',2018,'2019-02-15' ;
EXEC SP_InsertarAlumno 'Dean','Patel','Mcmahon',2014,'2017-05-17' ;
EXEC SP_InsertarAlumno 'Ruby','Guerra','Dean',2019,'2017-02-02' ;
EXEC SP_InsertarAlumno 'Sandra','Salinas','Sykes',2020,'2011-08-20' ;
EXEC SP_InsertarAlumno 'Audra','Larson','Avila',2012,'2016-11-03' ;
EXEC SP_InsertarAlumno 'Flynn','Holloway','Holman',2019,'2019-04-08' ;
EXEC SP_InsertarAlumno 'Gil','Sweeney','Velazquez',2016,'2013-02-11' ;
EXEC SP_InsertarAlumno 'Doris','Mcmillan','Velazquez',2010,'2011-09-30' ;
EXEC SP_InsertarAlumno 'Brenden','Cunningham','Callahan',2014,'2018-07-09' ;
EXEC SP_InsertarAlumno 'Nichole','Everett','Owens',2020,'2014-07-16' ;
EXEC SP_InsertarAlumno 'Hilda','Moore','Graham',2014,'2017-10-02' ;
EXEC SP_InsertarAlumno 'Daphne','Villarreal','Ayala',2013,'2012-06-20' ;
EXEC SP_InsertarAlumno 'Jermaine','Pace','Slater',2020,'2020-12-15' ;
EXEC SP_InsertarAlumno 'Grant','Clark','Lang',2014,'2019-01-17' ;
EXEC SP_InsertarAlumno 'Maile','Wooten','Case',2014,'2021-03-06' ;
EXEC SP_InsertarAlumno 'Vivien','Stephenson','Delacruz',2017,'2014-02-12' ;
EXEC SP_InsertarAlumno 'Laith','Bryan','Miller',2017,'2012-09-22' ;
EXEC SP_InsertarAlumno 'Jacqueline','Whitehead','Hurst',2017,'2014-12-17' ;
EXEC SP_InsertarAlumno 'September','Howard','Wiley',2012,'2016-12-08' ;


GO

SELECT * FROM Alumnos

SELECT row_number() over(order by PrimerApellido) AS 'NoLista',* from Alumnos

SELECT t.* FROM 
(
	SELECT row_number() over(order by PrimerApellido) AS 'NoLista',* from Alumnos
) t 
WHERE t.NoLista = 200