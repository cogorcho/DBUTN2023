# Creación de la tabla Municipio

Para comenzar hay que descargar el archivo de municipios que 
proveé el gobierno nacional desde [aquí](https://infra.datos.gob.ar/catalog/modernizacion/dataset/7/distribution/7.9/download/municipios.csv)

Una vez descargado el archivo, podemos continuar.

### Primero, conectarse a la base:

### sqlite3 Escuelas.db
```
sqlite>.mode csv
sqlite>.import (path a la carpeta descargas)\municipios.csv BaseMunicipio
sqlite>.schema BaseMunicipio
    CREATE TABLE BaseMunicipio(
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
## Normalización

Viendo (de nuevo...) las columnas de la tabla BaseMunicipio podemos inferir que hay cosas que se repiten. Por ejemplo categoria y fuente.
```
sqlite> select distinct categoria from BaseMunicipio;
    Municipio
    "Comisión Municipal"
    "Comisión de Fomento"
    Comuna
    "Delegación Municipal"
    "Comuna Rural"
    "Junta Vecinal"

sqlite> select distinct fuente from BaseMunicipio;
    "Direc. Grl. de Inmuebles"
    "ARBA - Gerencia de Servicios Catastrales"
    "Adm. Grl. de Catastro"
    IGN
    "Direc. de Geodesia y Catastro"
    "Direc. Pcial. de Catastro e Inf. Territorial"
    "Dirección de Estadística de la Prov. Tucumán"
    "Direc. Pcial. de Catastro y Cartografía"
    "Ministerio de Ecología"
    "Direc. Grl. Catastro (WMS)"
    "Dirección de Estadística y Censos"
    "Servicio de Catastro e Información Territorial"
    "Dirección de Geodesia y Catastro"
    "Dirección General de Estadística y Censos"
    "Direc. Grl. de Catastro"
    "A.R.T - Gerencia de Catastro"
    AREF
```

Vemos que para los municipios hay múltiples categorías y fuentes.
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

## La tabla Municipio

Con los datos normalizados de Categoria y Fuente podemos
crear la tabla Municipio. Sería algo así:
```
sqlite> create table Municipio (
    id integer primary key not null,
    nombre varchar(256) not null,
    nombre_completo varchar(512) not null,
    latitud real,
    longitud real,
    provinciaid integer not null,
    categoriaid integer not null,
    fuenteid integer not null,
    foreign key(provinciaid) references Provincia(id),
    foreign key(categoriaid) references Categoria(id),
    foreign key(fuenteid) references Fuente(id)
);
```
No debe repetirse la combinacion provinciaid-nombre pues una provincia
no puede tener mas de un municipio con el mismo nombre.
```
sqlite> create unique index uix_munic_pcia
on Municipio(provinciaid, nombre);
```
Y la inserción de datos sería algo así:
```
sqlite> insert into Municipio (id, nombre, nombre_completo,
    latitud, longitud, provinciaid, categoriaid, fuenteid)
    select cast(b.id as integer), b.nombre, b.nombre_completo,
    cast(b.centroide_lat as real), cast(b.centroide_lon as real),
    p.id, c.id, f.id
    from BaseMunicipio b
    inner join Provincia p
        on p.nombre = b.provincia_nombre
    inner join Categoria c
        on c.nombre = b.categoria
    inner join Fuente f
        on f.nombre = b.fuente;
```
Al ejecutar este último insert se produce un error.
Hay mas de un registro que tiene los mismos valores para
el para (provinciaid, nombre). En principio, parece data repetida.
Verificamos en la tabla Base Municipio.
```
sqlite> select provincia_nombre, nombre, count(*) 
    from BaseMunicipio
    group by provincia_nombre, nombre
    having count(*) > 1;

"Santa Fe","San Bernardo",2
"Santa Fe","San Mart",2
```
Hay 2 casos problemáticos.
```
sqlite> .headers on
sqlite> select * from BaseMunicipio 
    where provincia_nombre = "Santa Fe" 
    and nombre in ("San Bernardo", "San Mart")
    order by nombre;

categoria,centroide_lat,centroide_lon,fuente,id,nombre,nombre_completo,provincia_id,provincia_interseccion,provincia_nombre
Comuna,-30.8743272113348,-60.5572731688325,"Servicio de Catastro e Información Territorial",823946,"San Bernardo","Comuna San Bernardo",82,0.00075092801320638,"Santa Fe"
Comuna,-28.6804992323525,-61.2427589341908,"Servicio de Catastro e Información Territorial",823330,"San Bernardo","Comuna San Bernardo",82,0.0166189000451409,"Santa Fe"
Comuna,-30.2699724952564,-60.2447290871456,"Servicio de Catastro e Información Territorial",823953,"San Mart","Comuna San Mart",82,0.00242096732404212,"Santa Fe"
Comuna,-31.8394537015401,-61.6059946110053,"Servicio de Catastro e Información Territorial",824128,"San Mart","Comuna San Mart",82,0.00228655573740302,"Santa Fe"
```
Despues de investigar un poco en internet, hacemos las correcciones:
```
sqlite> update BaseMunicipio set
    nombre = 'San Bernardo (9 de Julio)',
    nombre_completo = 'Comuna San Bernardo (9 de Julio)'
    where id = '823330';

sqlite > update BaseMunicipio set
    nombre = 'San Martin Norte',
    nombre_completo = 'Comuna San Martin Norte'
    where id = '823953';

sqlite > update BaseMunicipio set
    nombre = 'San Martin de las escobas',
    nombre_completo = 'Comuna San Martin de las escobas'
    where id = '824128';
```
Verificamos:
```
sqlite> select provincia_nombre, nombre, count(*) 
    from BaseMunicipio
    group by provincia_nombre, nombre
    having count(*) > 1;
```
No debería devolver registros.
Insistimos con el insert:
```
sqlite> insert into Municipio (id, nombre, nombre_completo,
    latitud, longitud, provinciaid, categoriaid, fuenteid)
    select cast(b.id as integer), b.nombre, b.nombre_completo,
    cast(b.centroide_lat as real), cast(b.centroide_lon as real),
    p.id, c.id, f.id
    from BaseMunicipio b
    inner join Provincia p
        on p.nombre = b.provincia_nombre
    inner join Categoria c
        on c.nombre = b.categoria
    inner join Fuente f
        on f.nombre = b.fuente;
```
Verificamos:
```
sqlite> select count(*) from Municipio;
1814
sqlite> select count(*) from BaseMunicipio;
1814
```
Todo ok.

    
