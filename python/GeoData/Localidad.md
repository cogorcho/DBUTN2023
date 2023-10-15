# Creación de la tabla Localidad

Para comenzar hay que descargar el archivo de localidades que 
proveé el gobierno nacional desde [aquí](https://infra.datos.gob.ar/catalog/modernizacion/dataset/7/distribution/7.10/download/localidades.csv)

Una vez descargado el archivo, podemos continuar.

### Primero, conectarse a la base:

### sqlite3 Escuelas.db
```
sqlite>.mode csv
sqlite>.import (path a la carpeta descargas)\localidades.csv BaseLocalidad
sqlite>.schema BaseLocalidad
    CREATE TABLE BaseLocalidad(
    "categoria" TEXT,
    "centroide_lat" TEXT,
    "centroide_lon" TEXT,
    "departamento_id" TEXT,
    "departamento_nombre" TEXT,
    "fuente" TEXT,
    "id" TEXT,
    "localidad_censal_id" TEXT,
    "localidad_censal_nombre" TEXT,
    "municipio_id" TEXT,
    "municipio_nombre" TEXT,
    "nombre" TEXT,
    "provincia_id" TEXT,
    "provincia_nombre" TEXT
    );
```
## Normalización

Viendo (de nuevo...) las columnas de la tabla BaseLocalidad podemos inferir que hay cosas que se repiten. Por ejemplo categoria y fuente.
```
sqlite> select distinct categoria from BaseLocalidad;
    "Localidad simple"
    "Componente de localidad compuesta"
    Entidad
    "Localidad simple con entidad"
    "Componente de localidad compuesta con entidad"

sqlite> select distinct fuente from BaseLocalidad;
    INDEC
```
Vemos que para las localidades hay múltiples categorías y fuentes.
Las cargamos con los datos de BaseMunicipio
```
sqlite> insert into Categoria(nombre) 
    select distinct b.categoria from BaseMunicipio b
    where not exists (select c.nombre from Categoria c
    where c.nombre = b.categoria)
    order by 1;

sqlite> insert into Fuente(nombre) 
    select distinct b.fuente from BaseMunicipio b
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
    6,"Componente de localidad compuesta"
    7,"Componente de localidad compuesta con entidad"
    8,Entidad
    9,"Localidad simple"
    10,"Localidad simple con entidad"
    11,"Comisión Municipal"
    12,"Comisión de Fomento"
    13,"Comuna Rural"
    14,"Delegación Municipal"
    15,"Junta Vecinal"
    16,Municipio

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
    16,INDEC
    17,AREF
    18,"Direc. Grl. Catastro (WMS)"
    19,"Dirección General de Estadística y Censos"
    20,"Dirección de Estadística de la Prov. Tucumán"
    21,"Dirección de Estadística y Censos"
    22,"Dirección de Geodesia y Catastro"
```
## La tabla Localidad

Con los datos normalizados de Categoria y Fuente podemos
crear la tabla Localidad. Sería algo así:
```
sqlite> create table Localidad (
    id integer primary key not null,
    nombre varchar(256) not null,
    latitud real,
    longitud real,
    municipioid integer,
    departamentoid integer,
    provinciaid integer not null,
    categoriaid integer not null,
    fuenteid integer not null,
    foreign key(municipioid) references Municipio(id),
    foreign key(departamentoid) references Departamento(id),
    foreign key(provinciaid) references Provincia(id),
    foreign key(categoriaid) references Categoria(id),
    foreign key(fuenteid) references Fuente(id)
);
```
No debe repetirse la combinacion 
    - provinciaid
    - departamentoid
    - municipioid
    - nombre 
pues una municipio no puede tener mas de una localidad con el mismo nombre.
```
sqlite> create unique index uix_localidad_munic
on Localidad(provinciaid, departamentoid, municipioid, nombre);
```
Y la inserción de datos sería algo así:
```
sqlite> insert into Localidad(id, nombre, 
    latitud, longitud, provinciaid, departamentoid,
    municipioid, categoriaid, fuenteid)
    select cast(b.id as integer), b.nombre,
    cast(b.centroide_lat as real), cast(b.centroide_lon as read),
    p.id, d.id, m.id, c.id, f.id
    from BaseLocalidad b
    inner join Provincia p
        on p.nombre = b.provincia_nombre
    left join Departamento d
        on d.provinciaid = p.id
        and d.id = cast(b.departamento_id as integer)
    left join Municipio m
        on m.provinciaid = p.id
        and m.id = cast(b.municipio_id as integer)
    inner join Categoria c
        on c.nombre = b.categoria
    inner join Fuente f
        on f.nombre = b.fuente
    order by p.id,b.nombre;
```
Verificamos:
```
sqlite> select count(*) from BaseLocalidad;
    4142
sqlite> select count(*) from Localidad;
    4142
```
