create table Docente (
	id integer primary key autoincrement,
	personaid integer not null,
	fingreso date not null,
	fegreso date,
	foreign key (personaid)
	references Persona(id));


