--------------------------------------------------
-- Tabla Sede.
-- Distintas sedes (locaciones) de una institucion
--------------------------------------------------
use dbutn
GO

create table Sede (
    id integer identity(1,1) primary key,
    institucionid integer not null,
    nombre varchar(512) not null,
    domicilio varchar(1024) not null,
    CONSTRAINT fk_sede_institucion FOREIGN KEY (institucionid)
    REFERENCES Institucion(id)

)
GO

-- Indice unico sobre institucion y nombre
create unique index uix_sede_institucion
on Sede(institucionid,nombre)
GO
