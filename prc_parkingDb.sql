// base de datos parkingDb

DROP DATABASE IF EXISTS parking;
create database parking;

DROP TABLE IF EXISTS plazas;

create table plazas (id INT(11)NOT NULL AUTO_INCREMENT,
                      estado BOOLEAN NOT NULL,PRIMARY KEY(id));
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
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
call prc_rmVehicule('abc123');

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<

DROP TRIGGER IF EXISTS trg_nopresente;
DELIMITER %%
  CREATE TRIGGER trg_nopresente -- nombre del trigger
  BEFORE DELETE --  Antes de borrar
  ON vehiculos FOR EACH ROW
  BEGIN
      DECLARE fecha_actual DATETIME;
      SELECT NOW() INTO fecha_actual;
      INSERT INTO nopresentes(id,idPlaza,placa,fecha_ent,fecha_sal)
      VALUES (OLD.id,OLD.idPlaza,OLD.placa,OLD.fecha_ent,fecha_actual);
  END;
    call prc_rmVehicule('abc123');
  -- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><
    DROP PROCEDURE IF EXISTS prc_editVehicule;
    DELIMITER %%
    CREATE PROCEDURE prc_editVehicule (IN placa VARCHAR(15),idPlaza INT(11))
    BEGIN
      UPDATE vehiculos SET vehiculos.idPlaza=idPlaza WHERE vehiculos.placa = placa;
    END
    %%
    call prc_editVehicule('abc123');
    call prc_rmVehicule('abc123');
  -- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><
    DROP PROCEDURE IF EXISTS prc_getPlazaEstado;
    DELIMITER %%
    CREATE PROCEDURE prc_getPlazaEstado (IN id INT(11))
    BEGIN
      SELECT estado FROM plazas WHERE plazas.id = id;
    END
    %%
    call prc_getPlazaEstado(1);
    -- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    DROP TRIGGER IF EXISTS trg_setPlaza;
    DELIMITER %%
      CREATE TRIGGER trg_setPlaza -- nombre del trigger
      AFTER INSERT --  Antes de borrar
      ON vehiculos FOR EACH ROW
      BEGIN
          UPDATE plazas SET estado = true WHERE id=NEW.idPlaza;
      END;
