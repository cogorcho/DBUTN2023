--------------------------------------------------
-- Tabla Aula.
-- Aulas
--------------------------------------------------
use dbutn
GO

create table Aula (
    id integer identity(1,1) primary key,
    sedeid integer not null,
    nombre varchar(512) not null,
    capacidad integer not null default 0,
    CONSTRAINT fk_aula_sede FOREIGN KEY (sedeid)
    REFERENCES Sede(id)

)
GO

-- Indice unico sobre institucion y nombre
create unique index uix_aula_sede
on Aula(sedeid,nombre)
GO
