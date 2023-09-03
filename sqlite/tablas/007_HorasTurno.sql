create table HorasTurno (
	id integer primary key autoincrement,
	turnoid integer not null,
	horainicio datetime check(strftime('%H:%M', horainicio) < strftime('%H:%M', horafin)),
	horafin datetime check(strftime('%H:%M', horafin) > strftime('%H:%M', horainicio)));

create unique index uix_horas_turno 
on HorasTurno(turnoid, strftime('%H:%M', horainicio), strftime('%H:%M', horafin));
