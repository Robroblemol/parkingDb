// base de datos parkingDb

DROP DATABASE IF EXISTS parking;
create database parking;

DROP TABLE IF EXISTS plazas;
create table plazas (id INT(11)NOT NULL AUTO_INCREMENT,
                      estado BOOLEAN NOT NULL,PRIMARY KEY(id));
INSERT INTO plazas (estado) VALUES (false);
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
DROP TABLE IF EXISTS vehiculos;
create table vehiculos (id INT (11) NOT NULL AUTO_INCREMENT,
                        idPlaza INT(11)NOT NULL,placa VARCHAR(15) NOT NULL,
                        fecha_ent DATETIME, PRIMARY KEY (id),
                        FOREIGN KEY(idPlaza) REFERENCES plazas(id));
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><
  ALTER TABLE vehiculos ADD UNIQUE (placa);
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><
DROP TABLE IF EXISTS nopresentes;
create table nopresentes (id INT (11) NOT NULL,
                        idPlaza INT(11)NOT NULL,placa VARCHAR(15) NOT NULL,
                        fecha_ent DATETIME, fecha_sal DATETIME, PRIMARY KEY (id));
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  ALTER TABLE vehiculos ADD tipo BOOLEAN;
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<
DROP TABLE IF EXISTS plazaMotos;
create table plazaMotos (id INT (11) NOT NULL AUTO_INCREMENT,
                        estado BOOLEAN, PRIMARY KEY (id));
INSERT INTO plazaMotos (estado) VALUES (false);
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

DROP TABLE IF EXISTS motos;
create table motos (id INT (11) NOT NULL AUTO_INCREMENT,
                        idPlaza INT(11)NOT NULL,placa VARCHAR(15) NOT NULL,
                        fecha_ent DATETIME, PRIMARY KEY (id),
                        FOREIGN KEY(idPlaza) REFERENCES plazaMotos(id));
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<
ALTER TABLE motos ADD UNIQUE (placa);
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
DROP PROCEDURE IF EXISTS prc_addMoto;
DELIMITER %%
CREATE PROCEDURE prc_addMoto (idPlaza int (11), placa VARCHAR (15),
                                  fecha_ent DATETIME)
BEGIN
  INSERT INTO  motos (idPlaza,placa,fecha_ent)
  VALUES (idPlaza,placa,fecha_ent);
END
%%

call prc_addMoto(1,'ab123c',(SELECT NOW()));

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><>>>
DROP PROCEDURE IF EXISTS prc_addVehicule;
DELIMITER %%
CREATE PROCEDURE prc_addVehicule (idPlaza int (11), placa VARCHAR (15),
                                  fecha_ent DATETIME, tipo BOOLEAN)
BEGIN
  INSERT INTO  vehiculos (idPlaza,placa,fecha_ent,tipo)
  VALUES (idPlaza,placa,fecha_ent,tipo);
END
%%

call prc_addVehicule(1,'abc123',(SELECT NOW()),false);

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><>>>>
DROP PROCEDURE IF EXISTS prc_getMoto;
DELIMITER %%
CREATE PROCEDURE prc_getMoto (IN placa VARCHAR(15))
BEGIN
  SELECT * FROM motos WHERE motos.placa = placa;
END
%%
call prc_getMoto ('ab123c');
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<>>
DROP PROCEDURE IF EXISTS prc_getVehicule;
DELIMITER %%
CREATE PROCEDURE prc_getVehicule (IN placa VARCHAR(15))
BEGIN
  SELECT * FROM vehiculos WHERE vehiculos.placa = placa;
END
%%
call prc_getVehicle ('abc123');
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><
DROP PROCEDURE IF EXISTS prc_rmMoto;
DELIMITER %%
CREATE PROCEDURE prc_rmMoto (IN placa VARCHAR(15))
BEGIN
  DELETE FROM motos WHERE motos.placa = placa;
END
%%
call prc_rmMoto('ab789c');
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<
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
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
DROP TRIGGER IF EXISTS trg_nopresenteMoto;
DELIMITER %%
  CREATE TRIGGER trg_nopresenteMoto -- nombre del trigger
  BEFORE DELETE --  Antes de borrar
  ON motos FOR EACH ROW
  BEGIN
      DECLARE fecha_actual DATETIME;
      SELECT NOW() INTO fecha_actual;
      INSERT INTO nopresentes(id,idPlaza,placa,fecha_ent,fecha_sal)
      VALUES (OLD.id,OLD.idPlaza,OLD.placa,OLD.fecha_ent,fecha_actual);
  END;
    %%

    call prc_rmMoto('ab123c');
  -- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><
    DROP PROCEDURE IF EXISTS prc_editVehicule;
    DELIMITER %%
    CREATE PROCEDURE prc_editVehicule (IN placa VARCHAR(15),idPlaza INT(11))
    BEGIN
      UPDATE vehiculos SET vehiculos.idPlaza=idPlaza WHERE vehiculos.placa = placa;
    END
    %%
    call prc_editVehicule('abc123',5);
    call prc_rmVehicule('abc123');
    -- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<
    DROP PROCEDURE IF EXISTS prc_editMoto;
    DELIMITER %%
    CREATE PROCEDURE prc_editMoto (IN placa VARCHAR(15),idPlaza INT(11))
    BEGIN
      UPDATE motos SET motos.idPlaza=idPlaza WHERE motos.placa = placa;
    END
    %%
      call prc_editMoto('ab123c',5);
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
    DROP PROCEDURE IF EXISTS prc_getPlazaEstadoMoto;
    DELIMITER %%
    CREATE PROCEDURE prc_getPlazaEstadoMoto (IN id INT(11))
    BEGIN
      SELECT estado FROM plazaMotos WHERE plazaMotos.id = id;
    END
    %%
    call prc_getPlazaEstadoMoto(1);
    -- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    DROP TRIGGER IF EXISTS trg_setPlaza;
    DELIMITER %%
      CREATE TRIGGER trg_setPlaza -- nombre del trigger
      AFTER INSERT --  Antes de borrar
      ON vehiculos FOR EACH ROW
      BEGIN
          UPDATE plazas SET estado = true WHERE id=NEW.idPlaza;
      END;
      %%
  -- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><>
  DROP TRIGGER IF EXISTS trg_setPlazaMoto;
  DELIMITER %%
    CREATE TRIGGER trg_setPlazaMoto -- nombre del trigger
    AFTER INSERT --  Antes de borrar
    ON motos FOR EACH ROW
    BEGIN
        UPDATE plazaMotos SET estado = true WHERE id=NEW.idPlaza;
    END;
    %%
  -- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  DROP PROCEDURE IF EXISTS prc_getNopresente;
  DELIMITER %%
  CREATE PROCEDURE prc_getNopresente(IN placa VARCHAR (15))
  BEGIN
    SELECT * FROM nopresentes WHERE nopresentes.placa = placa;
  END
  %%
  call prc_getNopresente('abc123');
  -- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><>>
