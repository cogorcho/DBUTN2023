----------------------------------------------
-- Materias pot orientaciones
-- Ejemplo:
--     Historia
--     Matematica
--     etc etc
----------------------------------------------
use dbutn
GO

create table Materia (
    id integer identity(1,1) primary key,
    nombre varchar(512) not null
)
GO

-- Indice unico por nombre
create unique index uix_materia
on Materia(nombre)
GO
