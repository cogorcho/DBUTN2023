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

