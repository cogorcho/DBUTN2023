# Creación de la tabla Provincia

Para comenzar hay que descargar el archivo de provincias que 
proveé el gobierno nacional desde [aquí](https://infra.datos.gob.ar/catalog/modernizacion/dataset/7/distribution/7.7/download/provincias.csv)

Una vez descargado el archivo, podemos continuar.

### Primero, conectarse a la base:

### sqlite3 Escuelas.db
```
sqlite>.mode csv
sqlite>.import (path a la carpeta descargas)\provincias.csv BaseProvincia
sqlite>.schema BaseProvincia
    CREATE TABLE BaseProvincia(
    "categoria" TEXT,
    "centroide_lat" TEXT,
    "centroide_lon" TEXT,
    "fuente" TEXT,
    "id" TEXT,
    "iso_id" TEXT,
    "iso_nombre" TEXT,
    "nombre" TEXT,
    "nombre_completo" TEXT
    );
```
Esta es la base para nuestra tabla de provincias. 

## Normalización

Viendo las columnas de la tabla BaseProvincia podemos inferir que hay cosas que se repiten. Por ejemplo categoria y fuente.
```
sqlite> select distinct categoria from BaseProvincia;
    Provincia
    "Ciudad Autónoma"
sqlite> select distinct fuente from BaseProvincia;
    IGN
```
Creamos las tablas Categoria y Fuente
```
sqlite> create table Categoria(
    id integer primary key autoincrement,
    nombre varchar(128) not null unique);

sqlite> create table Fuente(
    id integer primary key autoincrement,
    nombre varchar(128) not null unique);
```
Y las cargamos con los datos de BaseProvincia
```
sqlite> insert into Categoria(nombre) 
    select distinct categoria from BaseProvincia
    order by 1;

sqlite> insert into Fuente(nombre) 
    select distinct fuente from BaseProvincia
    order by 1;
```
Verificamos:
```
sqlite> select * from Categoria;
    1,"Ciudad Autónoma"
    2,Provincia

sqlite> select * from Fuente;
    1,IGN
```
## La tabla Provincia

Con los datos normalizados de Categoria y Fuente podemos
crear la tabla Provincia. Sería algo así:
```
sqlite> create table Provincia (
    id integer not null primary key,
    nombre varchar(256) not null unique,
    nombre_completo varchar(512) not null,
    latitud read,
    longitud real,
    iso_id varchar(32),
    iso_nombre varchar(512),
    categoriaid integer not null,
    fuenteid integer not null,
    foreign key(categoriaid) references Categoria(id),
    foreign key(fuenteid) references Fuente(id)
);
```
Y la inserción de datos sería algo así:
```
insert into Provincia(id, nombre, nombre_completo, latitud, longitud,
iso_id, iso_nombre, categoriaid, fuenteid)
select cast(b.id as integer), b.nombre, b.nombre_completo,
cast(b.centroide_lat as real), cast(b.centroide_lon as read),
b.iso_id, b.iso_nombre, c.id, f.id
from BaseProvincia b
inner join Categoria c
    on c.nombre = b.categoria
inner join Fuente f
    on f.nombre = b.fuente
order by b.nombre;
```