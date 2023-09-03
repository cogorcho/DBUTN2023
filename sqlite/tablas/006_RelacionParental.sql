create table RelacionParental (
	id integer primary key autoincrement,
	autoridadparentalid int not null,
	padreid integer not null check (padreid != hijoid),
	hijoid integer not null check(hijoid != padreid),
	foreign key (padreid)
	references Persona(id),
	foreign key (hijoid)
	references Persona(id),
	foreign key (autoridadparentalid)
	references AutoridadParental(id));

create unique index uix_RelacionParental
on RelacionParental(padreid,hijoid);

create index ix_RelacionParental
on RelacionParental(autoridadparentalid);
-- Cuando haga un join para buscar todos los
-- padres/madres/etc de un curso.
