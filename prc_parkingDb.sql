// base de datos parkingDb

DROP DATABASE IF EXISTS parking;
create database parking;

DROP TABLE IF EXISTS plazas;

create table plazas (id INT(11)NOT NULL AUTO_INCREMENT,
                      estado BOOLEAN NOT NULL,PRIMARY KEY(id));
DROP TABLE IF EXISTS vehiculos;
create table vehiculos (id INT (11) NOT NULL AUTO_INCREMENT,
                        idPlaza INT(11)NOT NULL,placa VARCHAR(15) NOT NULL,
                        fecha_ent DATETIME, PRIMARY KEY (id), FOREIGN KEY(idPlaza) REFERENCES plazas(id));
INSERT INTO plazas (estado) VALUES (false);
