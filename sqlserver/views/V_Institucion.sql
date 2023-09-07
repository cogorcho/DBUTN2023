create view V_Institucion AS
select i.id as Id, i.nombre as Nombre, i.dieregep as Diegrep, count(*) as Sedes
from Institucion i
inner Join Sede s
    on s.InstitucionId = i.id
group by i.id, i.nombre, i.dieregep;
