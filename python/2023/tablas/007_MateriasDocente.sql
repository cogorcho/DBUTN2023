--Select 'MateriasDocente';
create table MateriasDocente (
	id integer primary key not null,
	docenteid integer not null,
	materiaid integer not null,
	foreign key (docenteid)
	references Docente(id),
	foreign key (materiaid)
	references Materia(id));

create unique index uix_materia_docente
on MateriasDocente(docenteid,materiaid);
