--Select 'ResponsableLegalAlumno';
create table ResponsableLegalAlumno (
    id integer primary key autoincrement,
    ResponsableLegalid integer not null,
    alumnoid integer not null,
    foreign key (ResponsableLegalid)
    references ResponsableLegal(id),
    foreign key (alumnoid)
    references Alumno(id));

create unique index uix_resp_alumno
on ResponsableLegalAlumno(ResponsableLegalid, alumnoid);