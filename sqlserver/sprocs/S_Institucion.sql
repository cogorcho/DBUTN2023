---------------------------------------
-- TABLA: INSTITUCION   ----------------
---------------------------------------
IF OBJECT_ID('S_INSTITUCION','P') IS NOT NULL
    DROP PROCEDURE S_INSTITUCION
GO
CREATE PROCEDURE S_INSTITUCION
@ID INTEGER,
@NOMBRE VARCHAR(512)
AS
Select Id, Nombre, Dieregep, Sedes
from V_Institucion
where Id = isnull(@Id, Id)
  and Nombre = isnull(@Nombre, nombre)
END
GO