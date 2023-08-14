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

