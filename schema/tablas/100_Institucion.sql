---------------------------------------------
-- Tabla de Instituciones. Escuelas
---------------------------------------------
use dbutn
GO

create table Institucion (
    id integer identity(1,1) primary key,
    nombre varchar(512) not null,
    idnacional varchar(128)
)
GO

create unique index uix_institucion_nombre
on Institucion(nombre)
GO
