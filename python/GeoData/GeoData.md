# GeoData

## Carga de datos geograficos de Argentina

Con los archivos de datos provistos por el estado, podemos generar una base de datos
para acceder a estos, una vez normalizados, utilizando **sqlite**.

A continuacion, el proceso de carga detallado de los datos. Aconsejamos respetar el orden
segun la siguiente lista:

1. Provincias
2. Departamentos
3. Municipios
4. Localidades

Para cada caso, seguir las instrucciones en el \.md correspondiente.

En este repositorio se adjunta una version de la base de datos ya cargada **GeoData.db**.

Recomendamos renombrarla antes de comenzar el trabajo.

Una vez terminado este paso, el plan es armar una API utilizando python y flask
para acceder a esta base de datos y servir en formato json.