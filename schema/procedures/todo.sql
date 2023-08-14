Institucion_sp.sql
use dbutn
GO

drop procedure if exists S_Institucion
GO

create procedure S_Institucion
@Nombre varchar(512) = NULL
as
BEGIN
	select id, nombre, idnacional 
    from Institucion
    where nombre = @nombre or @Nombre is null
END
GO
-------------------------------------------------
-- Test:
--  EXEC S_Institucion
--  EXEC S_Institucion @Nombre="AIRE LIBRE"
-------------------------------------------------
drop procedure if exists I_Institucion
GO

create procedure I_Institucion 
@Nombre varchar(512),
@IdNacional varchar(128) = 'N/D'
AS 
BEGIN
	insert into Institucion (nombre, idnacional)
	values (@Nombre, @IdNacional)
END
GO
-------------------------------------------------
-- Test:
-- EXECUTE I_Institucion @Nombre= "Tecnica 3"
-- EXECUTE I_Institucion @Nombre= "Tecnica 6"
-- EXECUTE I_Institucion @Nombre= "Aire Libre", @IdNacional="AIRELIBRE3076"
-------------------------------------------------

drop procedure if exists D_Institucion
GO

create procedure D_Institucion 
@Id integer
AS 
BEGIN 
	delete Institucion where id = @Id
END
GO
-------------------------------------------------
-- Test:
-- EXEC D_Institucion @Id=3 
-------------------------------------------------

drop procedure if exists U_Institucion
GOa

create procedure U_Institucion 
@Id integer,a
@Nombre varchar(512),
@IdNacional varchar(128)
AS
BEGIN
    update Institucion set
    nombre = @Nombre,
    idnacional = @IdNacional
    where id = @Id
END
GO

Materia_sp.sql
use dbutn
GO

drop procedure if exists S_Materia
GO

create procedure S_Materia
@Nombre varchar(512) = NULL
as
BEGIN
	select id, nombre 
    from Materia
    where nombre = @nombre or @Nombre is null
END
GO
-------------------------------------------------
-- Test:
--  EXEC S_Materia
--  EXEC S_Materia @Nombre="Geografia"
-------------------------
drop procedure if exists I_Materia
GO

create procedure I_Materia 
@Nombre varchar(512)
AS 
BEGIN
	insert into Materia (nombre)
	values (@Nombre)
END
GO
-------------------------------------------------
-- Test:
-- EXECUTE I_Materia @Nombre= "Historia"
-- EXECUTE I_Materia @Nombre= "Matematica"
-- EXECUTE I_Materia @Nombre= "Filosofia"
-- EXECUTE I_Materia @Nombre= "Fisica"
-------------------------------------------------

drop procedure if exists D_Materia
GO

create procedure D_Materia 
@Id integer
AS 
BEGIN 
	delete Materia where id = @Id
END
GO
-------------------------------------------------
-- Test:
-- EXEC D_Materia @Id=3 
-------------------------------------------------

drop procedure if exists U_Materia
GO

create procedure U_Materia 
@Id integer,
@Nombre varchar(512)
AS
BEGIN
    update Materia set
    nombre = @Nombre
    where id = @Id
END
GO
-------------------------------------------------
-- Test:
-- EXEC U_Materia @Id=3, @Nombre="Logica"
-- EXEC S_Materia
-------------------------------------------------

Nivel_sp.sql
use dbutn
GO

drop procedure if exists S_Nivel
GO

create procedure S_Nivel
@Nombre varchar(512) = NULL
as
BEGIN
	select id, nombre 
    from Nivel
    where nombre = @nombre or @Nombre is null
END
GO
-------------------------------------------------
-- Test:
--  EXEC S_Nivel
--  EXEC S_Nivel @Nombre="Primario"
-------------------------
drop procedure if exists I_Nivel
GO

create procedure I_Nivel 
@Nombre varchar(512)
AS 
BEGIN
	insert into Nivel (nombre)
	values (@Nombre)
END
GO
-------------------------------------------------
-- Test:
-- EXECUTE I_Nivel @Nombre= "Maternal"
-- EXECUTE I_Nivel @Nombre= "Jardin"
-- EXECUTE I_Nivel @Nombre= "Primario"
-- EXECUTE I_Nivel @Nombre= "Secundario"
-------------------------------------------------

drop procedure if exists D_Nivel
GO

create procedure D_Nivel 
@Id integer
AS 
BEGIN 
	delete Nivel where id = @Id
END
GO
-------------------------------------------------
-- Test:
-- EXEC D_Nivel @Id=3 
-------------------------------------------------

drop procedure if exists U_Nivel
GO

create procedure U_Nivel 
@Id integer,
@Nombre varchar(512)
AS
BEGIN
    update Nivel set
    nombre = @Nombre
    where id = @Id
END
GO
-------------------------------------------------
-- Test:
-- EXEC U_Nivel @Id=3, @Nombre="Guarderia"
-- EXEC S_Nivel
-------------------------------------------------

Orientacion_sp.sql
use dbutn
GO

drop procedure if exists S_Orientacion
GO

create procedure S_Orientacion
@Nombre varchar(512) = NULL
as
BEGIN
	select id, nombre 
    from Orientacion
    where nombre = @nombre or @Nombre is null
END
GO
-------------------------------------------------
-- Test:
--  EXEC S_Orientacion
--  EXEC S_Orientacion @Nombre="Humanidades"
-------------------------------------------------
drop procedure if exists I_Orientacion
GO

create procedure I_Orientacion 
@Nombre varchar(512)
AS 
BEGIN
	insert into Orientacion (nombre)
	values (@Nombre)
END
GO
-------------------------------------------------
-- Test:
-- EXECUTE I_Orientacion @Nombre= "Humanidades"
-- EXECUTE I_Orientacion @Nombre= "Informatica"
-- EXECUTE I_Orientacion @Nombre= "Economia"
-- EXECUTE I_Orientacion @Nombre= "Naturales"
-------------------------------------------------

drop procedure if exists D_Orientacion
GO

create procedure D_Orientacion 
@Id integer
AS 
BEGIN 
	delete Orientacion where id = @Id
END
GO
-------------------------------------------------
-- Test:
-- EXEC D_Orientacion @Id=3 
-------------------------------------------------

drop procedure if exists U_Orientacion
GO

create procedure U_Orientacion 
@Id integer,
@Nombre varchar(512)
AS
BEGIN
    update Orientacion set
    nombre = @Nombre
    where id = @Id
END
GO
-------------------------------------------------
-- Test:
-- EXEC U_Orientacion @Id=3, @Nombre="Datos Duros"
-- EXEC S_Orientacion
-------------------------------------------------


