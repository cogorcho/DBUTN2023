# Creación de la tabla Escuelas

Para comenzar hay que descargar el archivo de escuelas que 
proveé el gobierno nacional desde [aquí](https://www.argentina.gob.ar/sites/default/files/2023.09.04_padron_oficial_establecimientos_educativos_die.xlsx)

Una vez descargado el archivo, podemos continuar.

### Tratamiento del excel descargado.

El archivo de escuelas contiene información detallada que no vamos
a utiliar en su totalidad en esta instancia y se descarga en la
carpeta "Downloads" del usuario.

- Abrir el excel y copiar en una nueva planilla de las columnas A a la M inclusive.
- Guardar la nueva planilla como Text CSV (.csv) en la carpeta creada al principio con el nombre **Escuelas.csv** (antes de guardar, a la fila con los nombres de columna hay que sacarle los acentos para evitar posibles problemas)
- De la nueva y recién creada planilla hay que borrar todas las filas anteriores
a los nombres de columna.
- Abrir una consola CMD y moverse a la carpeta de descargas. Con el comando DIR deberiamos ver el archivo Escuelas.csv

Una vez creado el nuevo archivo **Escuelas.csv**, podemos continuar.

### Primero, conectarse a la base:

### sqlite3 Escuelas.db
```
sqlite>.mode csv
sqlite>.import (path a la carpeta descargas)\Escuelas.csv BaseEscuela
sqlite>.schema BaseEscuela
```
- Debería versa esto:
```
sqlite> .schema BaseEscuela
CREATE TABLE Base(
  "Jurisdiccion" TEXT,
  "Sector" TEXT,
  "Ambito" TEXT,
  "Departamento" TEXT,
  "Codigo de departamento" TEXT,
  "Localidad" TEXT,
  "Codigo de localidad" TEXT,
  "Cueanexo" TEXT,
  "Nombre" TEXT,
  "Domicilio" TEXT,
  "C.P." TEXT,
  "Telefono" TEXT,
  "Mail" TEXT
);
```
Esta es la base para nuestra tabla de escuelas. 

Controles básicos:
```
sqlite> select count(*) from BaseEscuela;
64497
```
## Normalización

Viendo las columnas de la tabla BaseEscuelas podemos inferir que hay cosas que se repiten. Por ejemplo Sector y Ambito.
Jurisdiccion es la provincia y así como los datos de departamento y localidad
serán validados contra las tablas correspondientes.

```
sqlite> select distinct Sector from Base;
    Privado
    Estatal
    Social/cooperativa

sqlite> select distinct Ambito from Base;
    Urbano
    Rural
    ""
    "Sin información"
```
En este caso, para evitar casos sin datos actualizamos la tabla:
```
sqlite> select count(*) from BaseEscuela where Ambito = "";
6
sqlite> update BaseEscuela set Ambito = "Sin información"
    where Ambito = "";
sqlite> select count(*) from BaseEscuela where Ambito = "";
0
```
Creamos las tablas Sector, Ambito, Provincia, Departamento y Localidad
```
sqlite> create table Sector(
    id integer primary key autoincrement,
    nombre varchar(128) not null unique);

sqlite> create table Ambito(
    id integer primary key autoincrement,
    nombre varchar(128) not null unique);

sqlite> create table Provincia(
    id integer primary key autoincrement,
    nombre varchar(128) not null unique);

sqlite> create table Departamento(
    id integer primary key autoincrement,
    provinciaid integer not null,
    nombre varchar(512) not null,
    foreign key (provinciaid) references Provincia(id));

    create unique index uix_depto_pcia
    on Departamento (provinciaid, nombre);

sqlite> create table Localidad (
    id integer primary key autoincrement,
    departamentoid integer not null,
    nombre varchar(512) not null,
    foreign key (departamentoid) references Departamento(id));

    create unique index uix_local_depto
    on Localidad(departamentoid, nombre);
```
** Y las cargamos con los datos de BaseEscuela **
```
sqlite> insert into Sector(nombre) 
    select distinct sector from BaseEscuela
    order by 1;

sqlite> insert into Ambito(nombre) 
    select distinct ambito from BaseEscuela
    order by 1;

sqlite> insert into Provincia(nombre)
    select distinct Jurisdiccion from BaseEscuela
    order by 1;

sqlite> insert into Departamento(provinciaid, nombre)
    select distinct p.id, b.departamento
    from BaseEscuela b
    inner join Provincia p 
        on p.nombre = b.Jurisdiccion;

sqlite> insert into Localidad(departamentoid, nombre)
    select distinct d.id, b.localidad
    from BaseEscuela b
    inner join Provincia p
        on p.nombre = b.Jurisdiccion
    inner join Departamento d
        on d.provinciaid = p.id
        and d.nombre = b.departamento;
```
Verificamos:
```
sqlite> select * from Sector;
    1,Estatal
    2,Privado
    3,Social/cooperativa
sqlite> select * from Ambito;
    1,Rural
    2,"Sin información"
    3,Urbano
sqlite> select * from Provincia;

sqlite> select p.nombre, count(*) 
    from Departamento d
    inner join Provincia p
        on p.id = d.provinciaid
    group by p.nombre order by 1;

sqlite> select p.nombre, d.nombre, count(*) 
    from Localidad l
    inner join Departamento d
        on d.id = l.departamentoid
    inner join Provincia p
        on p.id = d.provinciaid
    group by p.nombre, d.nombre order by 1,2;
```
## La tabla Escuela

Con los datos normalizados de Ambito y Sector podemos
crear la tabla Escuela. Sería algo así:
```
sqlite> create table Escuela (
    id integer not null primary key autoincrement,
    nombre varchar(512) not null,
    cueanexo varchar(32) not null,
    domicilio varchar(2048) not null,
    codpos varchar(15),
    telefono varchar(64),
    email varchar(1024),
    sectorid integer not null,
    ambitoid integer not null,
    provinciaid integer not null,
    departamentoid integer not null,
    localidadid integer not null,
    foreign key(sectorid) references Sector(id),
    foreign key(ambitoid) references Ambito(id),
    foreign key(provinciaid) references Provincia(id),
    foreign key(departamentoid) references Departamento(id),
    foreign key(localidadid) references Localidad(id));

    create unique index uix_escuela
    on Escuela(nombre, cueanexo, sectorid, ambitoid,
    provinciaid, departamentoid, localidadid);
```    

Y la inserción de datos sería algo así:

En este caso. utilizamos una view para facilitar la 
visulaización del insert:
``` 
sqlite> create view vEscuela as
    select distinct b.nombre as nombre, b.cueanexo as cueanexo, 
    b.domicilio as domicilio, b.codpos as codpos, 
    b.telefono as telefono, b.mail as email,
    s.id as sectorid, a.id as ambitoid, 
    p.id as provinciaid, d.id as departamentoid, 
    l.id as localidadid
    from BaseEscuela b
    inner join Sector s
        on s.nombre = b.sector
    inner join Ambito a
        on a.nombre = b.ambito
    inner join Provincia p
        on p.nombre = b.Jurisdiccion
    inner join Departamento d
        on d.provinciaid = p.id
        and upper(d.nombre) = upper(b.departamento)
    inner join Localidad l
        on l.departamentoid = d.id
        and upper(l.nombre) = upper(b.Localidad);
```
** Y finalmente la insercion de datos en la tabla Escuela **
```
sqlite> insert into Escuela (
    nombre, cueanexo, domicilio, codpos, telefono, email,
    sectorid, ambitoid, provinciaid, departamentoid,
    localidadid)
select nombre, cueanexo, domicilio, codpos, telefono, email,
    sectorid, ambitoid, provinciaid, departamentoid,
    localidadid
from vEscuela;
```

Hay un error: 64497 vs  64550, pero ya podemos empezar a hacer la
API con flask.

