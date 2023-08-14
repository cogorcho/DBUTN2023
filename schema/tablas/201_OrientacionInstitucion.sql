---------------------------------------------
-- Tabla: OrientacionInstitucion
-- Posibles Orientaciones por Institucion
---------------------------------------------
use dbutn
GO

create table OrientacionInstitucion (
    id integer identity(1,1) primary key,
    institucionid integer not null,
    orientacionid integer not null,
    CONSTRAINT fk_OI_institucion FOREIGN KEY (institucionid)
    REFERENCES Institucion(id),
    CONSTRAINT fk_OI_orientacion FOREIGN KEY (orientacionid)
    REFERENCES Orientacion(id))
GO

-- Indice unico sobre institucion y orientacion
create unique index uix_orientacion_institucion
on OrientacionInstitucion(institucionid,orientacionid)
GO
