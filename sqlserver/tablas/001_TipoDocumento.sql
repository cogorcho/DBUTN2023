Select 'TipoDocumento';
create table TipoDocumento (
	id integer primary key auto_increment,
	nombre varchar(1024) not null);

create unique index uix_tipodocumento_nombre
on TipoDocumento(nombre);
