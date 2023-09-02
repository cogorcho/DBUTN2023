Select 'Persona';
create table Persona (
    id integer primary key auto_increment,
    nombre varchar(128) not null,
    apellido varchar(128) not null,
    tipodocumentoid integer not null,
    documento varchar(32) not null,
    fnacto datetime not null,
    genero char(1) not null check (genero in ('F','M','O')),
    domicilioid integer,
    foreign key (tipodocumentoid)
    references TipoDocumento(id),
    foreign key (domicilioid)
    references Domicilio(id));

create index ix_persona_apellido_nombre
on Persona(apellido,nombre);

DELIMITER //
CREATE TRIGGER check_insert_fnacto
BEFORE INSERT ON Persona FOR EACH ROW
BEGIN
    IF (NEW.fnacto > CURDATE()) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'la fecha de nacimiento es invalida';
    END IF;
END;


CREATE TRIGGER check_udate_fnacto
BEFORE UPDATE ON Persona FOR EACH ROW
BEGIN
    IF (NEW.fnacto > CURDATE()) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'la fecha de nacimiento es invalida';
    END IF;
END;
//

DELIMITER ;

