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
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><
DROP TABLE IF EXISTS nopresentes;
create table nopresentes (id INT (11) NOT NULL,
                        idPlaza INT(11)NOT NULL,placa VARCHAR(15) NOT NULL,
                        fecha_ent DATETIME, fecha_sal DATETIME, PRIMARY KEY (id));
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

DROP PROCEDURE IF EXISTS prc_addVehicule;
DELIMITER %%
CREATE PROCEDURE prc_addVehicule (idPlaza int (11), placa VARCHAR (15), fecha_ent DATETIME)
BEGIN
  INSERT INTO  vehiculos (idPlaza,placa,fecha_ent) VALUES (idPlaza,placa,fecha_ent);
END
%%

call prc_addVehicule(1,'abc123',(SELECT NOW()));

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><>>>>

DROP PROCEDURE IF EXISTS prc_getVehicule;
DELIMITER %%
CREATE PROCEDURE prc_getVehicule (IN placa VARCHAR(15))
BEGIN
  SELECT * FROM vehiculos WHERE vehiculos.placa = placa;
END
%%
call prc_getVehicle ('abc123');
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><

DROP PROCEDURE IF EXISTS prc_rmVehicule;
DELIMITER %%
CREATE PROCEDURE prc_rmVehicule (IN placa VARCHAR(15))
BEGIN
  DELETE FROM vehiculos WHERE vehiculos.placa = placa;
END
%%
call prc_rmVehicle('abc123');
