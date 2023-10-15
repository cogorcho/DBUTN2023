insert into Persona(apellido,nombre,tipodocumentoid, documento,fnacto,genero,domicilioid)
select a.apellido, n.nombre, 1, ((ROW_NUMBER() OVER(ORDER BY Apellido)) + 22000000 ) AS DNI,
DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 3640 ), '1980-01-01'),
case n.genero
when 'Femenino' then 'F'
when 'Masculino' then 'M'
end as genero,
1
from Apellidos a , Nombres n;
