DELIMITER //

DROP PROCEDURE IF EXISTS genupdate;

CREATE PROCEDURE genupdate(IN tab VARCHAR(128))
BEGIN
	DECLARE colname VARCHAR(512);
	DECLARE datatype VARCHAR(512);
	DECLARE ispk INTEGER;
	DECLARE pkname VARCHAR(64);
	DECLARE finished INTEGER DEFAULT 0;
	DECLARE cnt INTEGER DEFAULT 0;
	DECLARE COLS VARCHAR(2048);
	DECLARE VALS VARCHAR(2048);
	DECLARE c_col CURSOR FOR
	SELECT 
		COLUMN_NAME,
		CASE
			WHEN UPPER(DATA_TYPE) = 'VARCHAR' THEN CONCAT('VARCHAR(',CHARACTER_MAXIMUM_LENGTH,')')
			WHEN UPPER(DATA_TYPE) = 'CHAR' THEN CONCAT('CHAR(',CHARACTER_MAXIMUM_LENGTH,')')
			ELSE UPPER(DATA_TYPE)
		END as datatype,
		CASE WHEN COLUMN_KEY = 'PRI' THEN 1 ELSE 0 END as ispk
	FROM information_schema.columns
	WHERE table_name = tab
	ORDER BY ORDINAL_POSITION asc;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
	
	CREATE TEMPORARY TABLE IF NOT EXISTS TTAB(fila VARCHAR(2048));
	TRUNCATE TABLE TTAB;
	
	INSERT INTO TTAB(fila) VALUES ('DELIMITER //');
	INSERT INTO TTAB(fila) VALUES (CONCAT('DROP PROCEDURE IF EXISTS U_',UPPER(tab),';'));
	INSERT INTO TTAB(fila) VALUES (CONCAT('CREATE PROCEDURE U_',UPPER(tab),'('));
	
	OPEN c_col;
	getcol: LOOP
		FETCH c_col INTO colname, datatype, ispk;

		IF finished = 1 THEN
			LEAVE getcol;
		END IF;

		IF cnt = 0 THEN
			IF ispk = 1 THEN
				SET pkname = colname;
			END IF;
			INSERT INTO TTAB(fila) VALUES (CONCAT(' IN P_', colname, ' ', datatype));
			SET cnt := 1;
		ELSE
			IF ispk != 1 THEN
				INSERT INTO TTAB(fila) VALUES (CONCAT(',IN P_', colname, ' ', datatype));
			END IF;
		END IF;
	END LOOP getcol;
	INSERT INTO TTAB(fila) VALUES (')');
	CLOSE c_col;


	INSERT INTO TTAB(fila) VALUES ('BEGIN');
	INSERT INTO TTAB(fila) VALUES (CONCAT('    UPDATE ', tab, ' SET '));

	SET cnt := 0;
	SET finished := 0;
	OPEN c_col;
	getcol2: LOOP
		FETCH c_col INTO colname, datatype, ispk;
		

		IF finished = 1 THEN
			LEAVE getcol2;
		END IF;

		IF ispk = 1 THEN
				SET pkname = colname;
		ELSE
			IF ispk != 1 THEN
				IF cnt = 0 THEN
					INSERT INTO TTAB(fila) VALUES (CONCAT('    ', colname, ' = IFNULL(P_', colname, ' ,', colname,')'));
					SET cnt := 1;
				ELSE
					INSERT INTO TTAB(fila) VALUES (CONCAT('   ,', colname, ' = IFNULL(P_', colname, ' ,', colname,')'));
				END IF;
			END IF;
		END IF;
	END LOOP getcol2;
	CLOSE c_col;

	INSERT INTO TTAB(fila) VALUES (CONCAT('    WHERE ',  pkname, ' = P_', pkname, ';'));
	INSERT INTO TTAB(fila) VALUES ('END;');
	INSERT INTO TTAB(fila) VALUES ('//');
	INSERT INTO TTAB(fila) VALUES ('DELIMITER ;');

	SELECT fila FROM TTAB;

END;
//
DELIMITER ;
 
