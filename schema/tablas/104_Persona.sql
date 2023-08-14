----------------------------------------------
-- Datos de personas
----------------------------------------------
use dbutn
GO

create table Persona(
    id integer identity(1,1) primary key,
    nombre varchar(128) not null,
    apellido varchar(128) not null,
    dni varchar(32) not null,
    fnacto datetime not null check (fnacto < GetDate()),
    genero char(1) not null check (genero in ('F','M','O')),
    domicilio varchar(1024) not null default 'No disponible')
GO

create unique index uix_persona on Persona(dni)
GO

create index ix_persona_apynom on Persona(apellido, nombre)
GO

