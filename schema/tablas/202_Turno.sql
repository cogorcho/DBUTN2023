--------------------------------------------------
-- Tabla InstitucionTurno.
-- Distintas turnos de dictado de clase
-- oara cada institucion.
-- Nota: cada institucion define sus turnos
--------------------------------------------------
use dbutn
GO

create table Turno (
    id integer identity(1,1) primary key,
    institucionid integer not null,
    nombre varchar(512) not null,
    inicio datetime not null,
    fin datetime not null,
    CONSTRAINT fk_turno_institucion FOREIGN KEY (institucionid)
    REFERENCES Institucion(id)
)
GO

-- Indice unico sobre nombre del turno
create unique index uix_turno_institucion
on Turno(institucionid,nombre)
GO
