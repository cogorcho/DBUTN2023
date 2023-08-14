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

