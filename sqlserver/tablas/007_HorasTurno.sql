Select 'HorasTurno';
create table HorasTurno (
	id integer primary key auto_increment,
	turnoid integer not null,
	horainicio time not null,
	horafin time not null,
	constraint chk_horainicio check(horainicio < horafin),
	constraint chk_horafin check(horafin > horainicio));

create unique index uix_horas_turno 
on HorasTurno(turnoid, horainicio, horafin);
