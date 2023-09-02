Select 'Domicilio';
create table Domicilio (
	id integer primary key auto_increment,
	localidadid integer not null,
	direccion varchar(2048) not null,
	codpos varchar(32),
	foreign key (localidadid)
	references Localidad(id));
