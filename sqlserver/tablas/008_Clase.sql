Select 'Clase';
create table Clase (
    id integer primary key auto_increment,
    comisionid integer not null,
    docenteid integer not null,
    materiaid integer not null,
    aulaid integer not null,
    foreign key (aulaid)
    references Aula(id),
    foreign key (comisionid)
    references Comision(id),
    foreign key (docenteid)
    references Docente(id),
    foreign key (materiaid)
    references Materia(id));

create unique index uix_clase
on Clase(comisionid, aulaid, docenteid, materiaid);
