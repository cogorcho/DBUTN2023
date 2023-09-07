---------------------------------------
-- TABLA: SEDE   ----------------
---------------------------------------
IF OBJECT_ID('S_SEDE','P') IS NOT NULL
    DROP PROCEDURE S_SEDE
GO
CREATE PROCEDURE S_SEDE
@INSTITUCIONID INTEGER
AS
Select Id, Nombre
from Sede
where InstitucionId = @INSTITUCIONID
order by nombre
END
GO