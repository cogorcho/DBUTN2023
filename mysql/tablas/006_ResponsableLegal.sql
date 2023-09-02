Select 'ResponsableLegal';
create table ResponsableLegal  (
	id integer primary key auto_increment,
	personaid integer not null,
	fingreso date not null,
	fegreso date,
	foreign key (personaid)
	references Persona(id));
