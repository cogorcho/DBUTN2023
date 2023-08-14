----------------------------------------------
-- Posibles orientaciones de una Institucion
-- Ejemplo:
--     Humanidades
--     Sociales
--     Tecnica
--     Informatica
--     Comercial
--     etc etc
----------------------------------------------
create table Orientacion (
    id integer identity(1,1) primary key,
    nombre varchar(512) not null
)
GO

-- Indice unico por nombre
create unique index uix_orientacion_nombre
on Orientacion(nombre)
GO
