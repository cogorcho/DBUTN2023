    Parcial BD 2023

Parcial de Bases de Datos
=========================

* * *

Usando como base el archivo de escuelas de Argentina disponible [aqui](https://www.argentina.gob.ar/sites/default/files/2023.08.01_padron_oficial_establecimientos_educativos_die.xlsx) cargamos una base de datos [sqlite](https://www.sqlite.org/2023/sqlite-tools-win32-x86-3430100.zip).

Para eso, abrimos el excel descargado y creamos uno nuevo con el contenido de las celdas A hasta O inclusive.  
Se hace asi:

1.  Con el excel abierto, marcamos las columnas A hasta la O
2.  Las copiamos
3.  Abrimos un nuevo excel y pegamos lo copiado
4.  Despues, borramos las filas 1 a 6 (dejar los nombres de las columnas)
5.  Guardamos este nuevo excel con formato xls o xlsx y de nombre Base.xls (o xlsx)
6.  Sin salir de Excel, hacemos guardar como y seleccionamos csv con el nombre Base.csv
7.  Si todo salio bien, podemos arrancar con sqlite

Para el trabajo de SQL seguimos las proximas instrucciones.

1.  Abrimos la consola (cmd)
2.  Vamos al Escritorio: _cd Desktop_
3.  Creamos la carpeta ParcialDB: _mkdir ParcialDB_
4.  En nuestro nuevo directorio (carpeta), copiamos el archivo csv que generamos antes
5.  Dentro de esta carpeta, descomprimimos el .zip que bajamos de sqlite
6.  Haciendo DIR (o dir) deberiamos ver un archivo sqlite3.exe y el Base.csv

Si todo salio bien, estamos listos para cargar data.

1.  Dentro de la consola, ejecutamos: _sqlite3 Base.db_ y vemos el prompt sqlite
2.  Esto crea una base de datos de nombre Base.db
3.  Tipeamos: _.mode csv_ (Esto avisa a sqlite que trabajamos con csv)
4.  Tipeamos: _.import Base.csv Base_ (Esto carga el Base.csv a una tabla de nombre Base en la base de datos Base.db)
5.  Estuve de lo mas cretivo con los nombres, por cierto...
6.  Tipeamos: _.schema_, deberiamos ver algo asi:

        sqlite> .schema
        CREATE TABLE IF NOT EXISTS "Base"(
          "Jurisdicción" TEXT,
          "Sector" TEXT,
          "Ámbito" TEXT,
          "Departamento" TEXT,
          "Código de departamento" TEXT,
          "Localidad" TEXT,
          "Código localidad" TEXT,
          "Clave única de establecimiento (cue)" TEXT,
          "Clave única de establecimiento - anexo (cueanexo)" TEXT,
          "Nombre" TEXT,
          "Domicilio" TEXT,
          "Código Postal" TEXT,
          "Código de área telefónico" TEXT,
          "Número de teléfono" TEXT,
          "Correo elecontrónico" TEXT
        );
    

Algunos nombres de columna son muy largos y con espacios que despues complican la cosa.  
Sabemos que existe un _DDL_ llamado _ALTER_ que sirve para modificar (alterar) objetos de la base de datos _(tablas, indices, vistas, etc)_.  
Cambiamos algunos nombres: [La posta esta aqui](https://www.sqlitetutorial.net/sqlite-rename-column/)

        alter table Base rename column "Código de departamento" to CodDepartamento;
        alter table Base rename column "Código localidad" to CodLocalidad;
        alter table Base rename column "Clave única de establecimiento (cue)" to CUE;
        alter table Base rename column "Clave única de establecimiento - anexo (cueanexo)" to CUEANEXO;
        alter table Base rename column "Código Postal" to CodigoPostal;
        alter table Base rename column "Código de área telefónico" to CodigoArea;
        alter table Base rename column "Número de teléfono" to Telefono;
        alter table Base rename column "Correo elecontrónico" to Email;
    

En SQLServer la cosa es asi:

        EXEC sp\_rename 'dbo.Base."Código de departamento"','CodDepartamento','COLUMN';
        EXEC sp\_rename 'dbo.Base."Código localidad"','CodLocalidad','COLUMN';
        EXEC sp\_rename 'dbo.Base."Clave única de establecimiento (cue)"','CUE','COLUMN';
        EXEC sp\_rename 'dbo.Base."Clave única de establecimiento - anexo (cueanexo)"','CUEANEXO','COLUMN';
        EXEC sp\_rename 'dbo.Base."Código Postal"','CodigoPostal','COLUMN';
        EXEC sp\_rename 'dbo.Base."Código de área telefónico"','CodigoArea','COLUMN';
        EXEC sp\_rename 'dbo.Base."Número de teléfono"','Telefono','COLUMN';
        EXEC sp\_rename 'dbo.Base."Correo elecontrónico"','Email','COLUMN';
    

Y el import de data es distinto.  
Por consola seria algo asi: _bcp Tablename in ~/filename.txt -S localhost -U sa -P \-d Databasename -c -t ','_  
El SQL Server Studio debe tener un wizard para esto. Yo lo hice con el DBeaver en el SQL Server en linux y anduvo ok.

Algunas consultas...

        select count(\*) from Base;
        select distinct sector from base;
        select sector, count(\*) from Base group by sector;
        select Jurisdicción, count(\*) from Base group by Jurisdicción;
        Select nombre from Base where Jurisdicción = 'Buenos Aires'
        and localidad = 'SAN NICOLAS DE LOS ARROYOS' order by 1;
    

* * *

El parcial en si

1.  Crear las tablas _Jurisdiccion, Ambito y Sector con (id, nombre)_ con una clave primaria autoincremental y los valores distintos (en una columna _nombre_) en cada caso, ordenados alfabeticamente
2.  Crear las tablas _Departamento y Localidad_ siguendo la misma logica que el punto 1 pero agregando la clave foranea a _Jurisdiccion_ en Departamento y _Departamento_ en Localidad
3.  Crear una vista llamada _EscuelasPorLocalidad_ que tenga la cantidad de escuelas por _Jurisdicción, departamento, localidad_ ordenada por estos 3 campos.

Ejemplo de como generar las Instituciones de San Nicolas con lo que tenemos en la tabla _Base_ y Pais, Provincia, Localidad

        -- Instituciones
        insert into Institucion (nombre)
        Select distinct nombre from Base where Jurisdicción = 'Buenos Aires'
        and localidad = 'SAN NICOLAS DE LOS ARROYOS' 
        and Base.nombre not in (select nombre from Institucion)
        order by 1;

        -- Pais
        DECLARE @id integer
        EXEC I_PAIS @id=@id, @nombre='Argentina'

        --Provincias. EL ID de Pais es 1
        insert into Provincia(paisid, nombre)
        Select distinct 1,Jurisdicción from base order by 1
        
        -- Localidades
        Insert into Localidad(provinciaid, nombre)
        select Distinct Provincia.id, Base.Localidad 
        from Provincia
        inner join Base
        on Base.Jurisdicción = Provincia.nombre 
        order by 1,2

        -- Niveles
        insert into Nivel(nombre)
        select 'Inicial'
        union select 'Primario'
        union select'Secundario'
        union select 'Superior'

        -- Orientaciones
        insert into Orientacion(nombre)
        select 'Economia'
        union select 'Ciencias Naturales'
        union select 'Ciencias Sociales'
        union select 'Tecnica - Informatica'
        union select 'Tecnica - Electricidad'
        union select 'Tecnica - Electronica'
        union select 'Tecnica - Construcciones'
        union select 'Tecnica - Mecanica'

        -- InstitucionOrientacion. Random
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

        -- Cambios en Domicilio para SQL Server
        -- EL orden del parametro OUTPUT causaba un error.
        -- Lo puse ultimo y funciono OK.
        CREATE PROCEDURE I_Domicilio
                @localidadid INT
                ,@direccion VARCHAR(2048)
                ,@codpos VARCHAR(32)
                ,@id INT OUTPUT
            AS 
            BEGIN 
            BEGIN TRY
                INSERT INTO Domicilio
                (LOCALIDADID, DIRECCION, CODPOS)
                VALUES
                (@LOCALIDADID, @DIRECCION, @CODPOS)
            
                SET @ID = @@IDENTITY
            END TRY
            BEGIN CATCH
                EXECUTE GetErrorInfo_sp
            END CATCH 
            END

        -- Sedes
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
                        EXEC I\DOMICILIO  @localidadid=@locid, @direccion=@inombre, @codpos='2900',@Id=@domid OUTPUT
                        EXEC I_SEDE @id=@isede,@institucionid=@idins,@nombre='Campo de deportes',@domicilioid=@domid
                    END
                    fetch c1 into @idins,@inombre
                end
            close c1
        End
        Deallocate c1
