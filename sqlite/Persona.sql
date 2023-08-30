create table Persona (
    id integer identity(1,1) primary key,
    nombre varchar(128) not null,
    apellido varchar(128) not null,
    tipodocumentoid integer not null,
    documento varchar(32) not null,
    fnacto datetime not null check (fnacto < Date()),
    genero char(1) not null check (genero in ('F','M','O')),
    domicilioid integer,
    foreign key (tipodocumentoid)
    references TipoDocumento(id),
    foreign key (domicilioid)
    references Domicilio(id));

create unique index ix_persona_apellido_nombre
on Persona(apellido,nombre);
