# Carga de datos base

Para probar el modelo de datos desarrollado necesitamos
datos en las tablas.
Utilizando el mae actualizado provisto por el gobierno
podemos proceder a cargar nuestras tablas.

Limpiando un poco el archivo para nuestro proposito,
generamos el **Base.csv**.

A este archivo lo importamos a nuestra base de datos
y tendremos un tabla llamada Base con la siguiente
estructura:

- Jurisdiccion
- Sector
- Ambito
- Departamento
- Codigo de departamento
- Localidad
- Codigo de localidad
- Cueanexo
- Nombre
- Domicilio
- C.P.
- Telefono
- Mail

No estamos utilizando toda la informacion disponible en Base.
No cargaremos datos de sector ni ambito.
De ser necesario, se pueden agregar a futuro.

1. Carga del pais.
Al ser solo para Argentina en este caso, utilizamos a stored
procedure que tenemos, para ir probando:

    DECLARE @id integer
    EXEC I_PAIS @id=@id, @nombre='Argentina'
    select * from Pais
    
    Deberiamos ver el pais Argentina con un id=1.

2. Carga de provincias.
insert into Provincia(paisid, nombre)
Select distinct 1,Jurisdiccion from base order by 1

3. Carga de localidades.
select Distinct Provincia.id, Base.Localidad 
from Provincia
inner join Base
on Base.Jurisdiccion = Provincia.nombre 
order by 1,2

4. Carga de niveles de educacion.
insert into Nivel(nombre)
select 'Inicial'
union select 'Primario'
union select'Secundario'
union select 'Superior'

5. Carga de orientaciones.
insert into Orientacion(nombre)
select 'Economia'
union select 'Ciencias Naturales'
union select 'Ciencias Sociales'
union select 'Tecnica - Informatica'
union select 'Tecnica - Electricidad'
union select 'Tecnica - Electronica'
union select 'Tecnica - Construcciones'
union select 'Tecnica - Mecanica'

6. Carga de instituciones. (Solo San Nicolas para el ejemplo)
insert into Institucion (nombre)
Select distinct nombre from Base where Jurisdiccion = 'Buenos Aires'
and localidad = 'SAN NICOLAS DE LOS ARROYOS' 
and Base.nombre not in (select nombre from Institucion)
order by 1;

7. Carga de orientaciones de las Instituciones.
En este caso le insertamos de 1 a 3 orientaciones
a cada institucion generadas aleatoriamente.

    declare c1 cursor for select id from Institucion
    declare @idins integer
    Begin
        open c1
        fetch c1 into @idins
        while @@fetch_status = 0
            begin
                insert into InstitucionOrientacion
                (institucionid, orientacionid)
                select top 3 @idins, id from Orientacion 
                order by newid()
                fetch c1 into @idins
            end
        close c1
    End
    Deallocate c1 

8. Carga de sedes.
De nuevo, de forma aleatoria, creamos sedes para las instituciones
y en cada caso, un domicilio ficticio tambien creado aleatoriamente.

    declare c1 cursor for select id,nombre from Institucion
        declare @idins integer, @locid integer, @domid integer, 
            @inombre varchar(1024),@isede integer
    Begin
        select @locid=id from Localidad l 
        where l.nombre = 'SAN NICOLAS DE LOS ARROYOS'
        open c1
        fetch c1 into @idins,@inombre
        while @@fetch_status = 0
            begin
                IF charindex('PRIMARIA',@inombre) > 0 
                OR charindex('ADULTOS',@inombre) > 0 
                OR charindex('SECUNDARIA',@inombre) > 0 
                OR charindex('ENFERMERIA', @inombre) > 0
                OR charindex('ESPECIAL',@inombre) > 0 
                OR charindex('SUPERIOR',@inombre) > 0
                BEGIN
                    EXEC I_DOMICILIO  @localidadid=@locid, @direccion=@inombre, @codpos='2900',@Id=@domid OUTPUT
                    EXEC I_SEDE @id=@isede,@institucionid=@idins,@nombre='Principal - Unica',@domicilioid=@domid
                END
                ELSE IF charindex('INFANTES',@inombre) > 0
                BEGIN
                    EXEC I_DOMICILIO  @localidadid=@locid, @direccion=@inombre, @codpos='2900',@Id=@domid OUTPUT
                    EXEC I_SEDE @id=@isede,@institucionid=@idins,@nombre='Jardin de Infantes',@domicilioid=@domid
                END
                ELSE
                BEGIN
                    SET @inombre = 'Primaria - ' + @inombre				
                    EXEC I_DOMICILIO  @localidadid=@locid, @direccion=@inombre, @codpos='2900',@Id=@domid OUTPUT
                    EXEC I_SEDE @id=@isede,@institucionid=@idins,@nombre='Primaria',@domicilioid=@domid
                    SET @inombre = 'Secundaria - ' + @inombre		
                    EXEC I_DOMICILIO  @localidadid=@locid, @direccion=@inombre, @codpos='2900',@Id=@domid OUTPUT
                    EXEC I_SEDE @id=@isede,@institucionid=@idins,@nombre='Secundaria',@domicilioid=@domid
                    SET @inombre = 'Campo de deportes - ' + @inombre				
                    EXEC I_DOMICILIO  @localidadid=@locid, @direccion=@inombre, @codpos='2900',@Id=@domid OUTPUT
                    EXEC I_SEDE @id=@isede,@institucionid=@idins,@nombre='Campo de deportes',@domicilioid=@domid
                END
                fetch c1 into @idins,@inombre
            end
        close c1
    End
    Deallocate c1
    
---
Hasta aqui tenemos datos como para comenzar a interactuar con las instituciones
cargadas.
Lo que sigue, es un intento de generar datos de personas, padres, madres y alumnos
para oder comanzar a armar cursos y ver la funcionalidad pretendida en accion.


## Carga de Personas.


Tomamos como base 3 archivos que contienen apellidos y nombres tanto femeninos como masculinos y creamos un juego de tablas en en la base para cargar estos datos.

create table Apellidos (apellido varchar(256) not null unique);
insert into Apellidos(apellido) values 
('GARCIA'),
('RODRIGUEZ'),
('GONZALEZ'),
('FERNANDEZ'),
....
create table Nombres(genero varchar(16) not null, nombre varchar(64) not null);
insert into Nombres(genero, nombre) values
('Femenino','MARIA CARMEN'),
('Femenino','MARIA'),
('Femenino','CARMEN'),
('Femenino','ANA MARIA'),
('Femenino','LAURA'),
...
('Masculino','MARIO'),
('Masculino','VICTOR'),
('Masculino','JOAQUIN'),
('Masculino','EDUARDO')
....


### Carga de la tabla Persona:

insert into Persona(
    apellido,
    nombre,
    tipodocumentoid, 
    documento,
    fnacto,
    genero,
    domicilioid)
select 
    a.apellido, 
    n.nombre, 
    1, 
    ((ROW_NUMBER() OVER(ORDER BY Apellido)) + 22000000 ) AS DNI,
    DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 3640 ), '1980-01-01'),
    case n.genero
        when 'Femenino' then 'F'
        when 'Masculino' then 'M'
    end as genero,
    1
from Apellidos a , Nombres n;





