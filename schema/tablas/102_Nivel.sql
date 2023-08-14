----------------------------------------------------
-- Tabla Nivel de Educacion
-- Nivel de Educacion
-- Ejemplo:
--     Jardin 
--     Maternal
--     Primario
--     Secundario
--     Terciario
----------------------------------------------------
use dbutn
GO

create table Nivel (
    id integer identity(1,1) primary key,
    nombre varchar(512) not null
)
GO

create unique index uix_nivel_nombre
on Nivel(nombre)
GO
