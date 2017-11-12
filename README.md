# parkingDb
Programa que conecta processing con mariaDB

#Processing

Para que la base de datos funciones en processing es necesario instalar
en la carpeta library de  BesierSQLib .jar con la conexión a mariaDB

/sketchbook/libraries/mariadb-java-client-2.2.0.jar

query 

msql.query( "CALL prc_actualizar('desde Processing')");
msql.next();
