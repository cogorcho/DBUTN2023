# Carga de la tabla Departamento

Para comenzar hay que descargar el archivo de departamentos que 
proveé el gobierno nacional desde [aquí](https://infra.datos.gob.ar/catalog/modernizacion/dataset/7/distribution/7.8/download/departamentos.csv)

Una vez descargado el archivo, podemos continuar.

### Primero, conectarse a la base:

### sqlite3 Escuelas.db
```
sqlite>.mode csv
sqlite>.import (path a la carpeta descargas)\departamentos.csv BaseDepartamento
sqlite>.schema BaseDepartamento
    CREATE TABLE BaseDepartamento(
    "categoria" TEXT,
    "centroide_lat" TEXT,
    "centroide_lon" TEXT,
    "fuente" TEXT,
    "id" TEXT,
    "nombre" TEXT,
    "nombre_completo" TEXT,
    "provincia_id" TEXT,
    "provincia_interseccion" TEXT,
    "provincia_nombre" TEXT
    );
```
Esta es la base para nuestra tabla de departementos

## Normalización

Viendo (de nuevo...) las columnas de la tabla BaseDepartamento podemos inferir que hay cosas que se repiten. Por ejemplo categoria y fuente.
```
sqlite> select distinct categoria from BaseDepartamento;
    Partido
    Departamento
    Comuna
sqlite> select distinct fuente from BaseDepartamento;
    "ARBA - Gerencia de Servicios Catastrales"
    "Direc. Pcial. de Catastro y Cartografía"
    "Direc. Grl. de Catastro"
    IGN
    "Adm. Grl. de Catastro"
    "A.R.T - Gerencia de Catastro"
    "Direc. de Geodesia y Catastro"
    "Direc. Grl. de Inmuebles"
    "Ministerio de Ecología"
    "Direc. Pcial. de Catastro e Inf. Territorial"
    "Direc. de Catastro"
    "Servicio de Catastro e Información Territorial"
    "ATER - Direc. de Catastro"
    "Gerencia de Catastro Pcial."
    SCAR
```
Vemos que para los departamentos hay múltiples categorías y fuentes.
Las cargamos con los datos de BaseDepartamento
```
sqlite> insert into Categoria(nombre) 
    select distinct b.categoria from BaseDepartamento b
    where not exists (select c.nombre from Categoria c
    where c.nombre = b.categoria)
    order by 1;

sqlite> insert into Fuente(nombre) 
    select distinct b.fuente from BaseDepartamento b
    where not exists (select f.nombre from Fuente f
    where f.nombre = b.fuente)
    order by 1;
```
Verificamos:
```
sqlite> select * from Categoria;
    1,"Ciudad Autónoma"
    2,Provincia
    3,Comuna
    4,Departamento
    5,Partido

sqlite> select * from Fuente;
    1,IGN
    2,"A.R.T - Gerencia de Catastro"
    3,"ARBA - Gerencia de Servicios Catastrales"
    4,"ATER - Direc. de Catastro"
    5,"Adm. Grl. de Catastro"
    6,"Direc. Grl. de Catastro"
    7,"Direc. Grl. de Inmuebles"
    8,"Direc. Pcial. de Catastro e Inf. Territorial"
    9,"Direc. Pcial. de Catastro y Cartografía"
    10,"Direc. de Catastro"
    11,"Direc. de Geodesia y Catastro"
    12,"Gerencia de Catastro Pcial."
    13,"Ministerio de Ecología"
    14,SCAR
    15,"Servicio de Catastro e Información Territorial"
```
## La tabla Departamento

Con los datos normalizados y agregados de Categoria, Fuente y Provincia podemos
crear la tabla Departamento. Sería algo así:
```
sqlite> create table Departamento (
    id integer not null primary key,
    nombre varchar(256) not null,
    nombre_completo varchar(512) not null,
    latitud read,
    longitud real,
    provinciaid integer not null,
    categoriaid integer not null,
    fuenteid integer not null,
    foreign key(provinciaid) references Provincia(id),
    foreign key(categoriaid) references Categoria(id),
    foreign key(fuenteid) references Fuente(id));
```
No debe repetirse la combinacion provinciaid-nombre pues una provincia
no puede tener mas de un departamento con el mismo nombre.

sqlite> create unique index uix_depto_pcia
on Departamento(provinciaid, nombre);

Y la inserción de datos sería algo así:
```
sqlite> insert into Departamento(id, nombre, nombre_completo, 
    latitud, longitud, provinciaid, categoriaid, fuenteid)
    select cast(b.id as integer), b.nombre, b.nombre_completo,
    cast(b.centroide_lat as real), cast(b.centroide_lon as read),
    p.id, c.id, f.id
    from BaseDepartamento b
    inner join Provincia p
        on p.nombre = b.provincia_nombre
    inner join Categoria c
        on c.nombre = b.categoria
    inner join Fuente f
        on f.nombre = b.fuente
    order by p.id,b.nombre;
```