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

