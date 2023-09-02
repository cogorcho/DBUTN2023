
--RANDOM
SELECT TOP 1 nombre FROM Institucion
ORDER BY NEWID()

select upper(nombre) from Institucion
select upper(nombre), lower(nombre) from Institucion
