Select 'sproc -> I_Alumno';
DELIMITER //
DROP PROCEDURE IF EXISTS I_ALUMNO;
CREATE PROCEDURE I_ALUMNO(
 OUT p_id INT
,IN p_institucionid INT
,IN p_personaid INT
,IN p_fingreso DATE
,IN p_fegreso DATE
)
BEGIN
    INSERT INTO Alumno (id ,institucionid ,personaid ,fingreso ,fegreso)
    VALUES
    (p_id ,p_institucionid ,p_personaid ,p_fingreso ,p_fegreso);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_Alumno';
DELIMITER //
DROP PROCEDURE IF EXISTS U_ALUMNO;
CREATE PROCEDURE U_ALUMNO(
 IN P_id INT
,IN P_institucionid INT
,IN P_personaid INT
,IN P_fingreso DATE
,IN P_fegreso DATE
)
BEGIN
    UPDATE Alumno SET 
    institucionid = IFNULL(P_institucionid ,institucionid)
   ,personaid = IFNULL(P_personaid ,personaid)
   ,fingreso = IFNULL(P_fingreso ,fingreso)
   ,fegreso = IFNULL(P_fegreso ,fegreso)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_Alumno';
DELIMITER //
DROP PROCEDURE IF EXISTS D_ALUMNO;
CREATE PROCEDURE D_ALUMNO(
IN id INT
)
BEGIN
    DELETE FROM Alumno WHERE id = id;
END;
//
DELIMITER ;
Select 'sproc -> I_AlumnosComision';
DELIMITER //
DROP PROCEDURE IF EXISTS I_ALUMNOSCOMISION;
CREATE PROCEDURE I_ALUMNOSCOMISION(
 OUT p_id INT
,IN p_comisionid INT
,IN p_alumnoid INT
)
BEGIN
    INSERT INTO AlumnosComision (id ,comisionid ,alumnoid)
    VALUES
    (p_id ,p_comisionid ,p_alumnoid);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_AlumnosComision';
DELIMITER //
DROP PROCEDURE IF EXISTS U_ALUMNOSCOMISION;
CREATE PROCEDURE U_ALUMNOSCOMISION(
 IN P_id INT
,IN P_comisionid INT
,IN P_alumnoid INT
)
BEGIN
    UPDATE AlumnosComision SET 
    comisionid = IFNULL(P_comisionid ,comisionid)
   ,alumnoid = IFNULL(P_alumnoid ,alumnoid)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_AlumnosComision';
DELIMITER //
DROP PROCEDURE IF EXISTS D_ALUMNOSCOMISION;
CREATE PROCEDURE D_ALUMNOSCOMISION(
IN id INT
)
BEGIN
    DELETE FROM AlumnosComision WHERE id = id;
END;
//
DELIMITER ;
Select 'sproc -> I_Aula';
DELIMITER //
DROP PROCEDURE IF EXISTS I_AULA;
CREATE PROCEDURE I_AULA(
 OUT p_id INT
,IN p_sedeid INT
,IN p_nombre VARCHAR(512)
,IN p_capacidad INT
)
BEGIN
    INSERT INTO Aula (id ,sedeid ,nombre ,capacidad)
    VALUES
    (p_id ,p_sedeid ,p_nombre ,p_capacidad);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_Aula';
DELIMITER //
DROP PROCEDURE IF EXISTS U_AULA;
CREATE PROCEDURE U_AULA(
 IN P_id INT
,IN P_sedeid INT
,IN P_nombre VARCHAR(512)
,IN P_capacidad INT
)
BEGIN
    UPDATE Aula SET 
    sedeid = IFNULL(P_sedeid ,sedeid)
   ,nombre = IFNULL(P_nombre ,nombre)
   ,capacidad = IFNULL(P_capacidad ,capacidad)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_Aula';
DELIMITER //
DROP PROCEDURE IF EXISTS D_AULA;
CREATE PROCEDURE D_AULA(
IN id INT
)
BEGIN
    DELETE FROM Aula WHERE id = id;
END;
//
DELIMITER ;
Select 'sproc -> I_AutoridadParental';
DELIMITER //
DROP PROCEDURE IF EXISTS I_AUTORIDADPARENTAL;
CREATE PROCEDURE I_AUTORIDADPARENTAL(
 OUT p_id INT
,IN p_nombre VARCHAR(1024)
)
BEGIN
    INSERT INTO AutoridadParental (id ,nombre)
    VALUES
    (p_id ,p_nombre);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_AutoridadParental';
DELIMITER //
DROP PROCEDURE IF EXISTS U_AUTORIDADPARENTAL;
CREATE PROCEDURE U_AUTORIDADPARENTAL(
 IN P_id INT
,IN P_nombre VARCHAR(1024)
)
BEGIN
    UPDATE AutoridadParental SET 
    nombre = IFNULL(P_nombre ,nombre)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_AutoridadParental';
DELIMITER //
DROP PROCEDURE IF EXISTS D_AUTORIDADPARENTAL;
CREATE PROCEDURE D_AUTORIDADPARENTAL(
IN id INT
)
BEGIN
    DELETE FROM AutoridadParental WHERE id = id;
END;
//
DELIMITER ;
Select 'sproc -> I_Clase';
DELIMITER //
DROP PROCEDURE IF EXISTS I_CLASE;
CREATE PROCEDURE I_CLASE(
 OUT p_id INT
,IN p_comisionid INT
,IN p_docenteid INT
,IN p_materiaid INT
,IN p_aulaid INT
)
BEGIN
    INSERT INTO Clase (id ,comisionid ,docenteid ,materiaid ,aulaid)
    VALUES
    (p_id ,p_comisionid ,p_docenteid ,p_materiaid ,p_aulaid);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_Clase';
DELIMITER //
DROP PROCEDURE IF EXISTS U_CLASE;
CREATE PROCEDURE U_CLASE(
 IN P_id INT
,IN P_comisionid INT
,IN P_docenteid INT
,IN P_materiaid INT
,IN P_aulaid INT
)
BEGIN
    UPDATE Clase SET 
    comisionid = IFNULL(P_comisionid ,comisionid)
   ,docenteid = IFNULL(P_docenteid ,docenteid)
   ,materiaid = IFNULL(P_materiaid ,materiaid)
   ,aulaid = IFNULL(P_aulaid ,aulaid)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_Clase';
DELIMITER //
DROP PROCEDURE IF EXISTS D_CLASE;
CREATE PROCEDURE D_CLASE(
IN id INT
)
BEGIN
    DELETE FROM Clase WHERE id = id;
END;
//
DELIMITER ;
Select 'sproc -> I_Comision';
DELIMITER //
DROP PROCEDURE IF EXISTS I_COMISION;
CREATE PROCEDURE I_COMISION(
 OUT p_id INT
,IN p_cursoid INT
,IN p_nombre VARCHAR(1024)
,IN p_periodoanual INT
)
BEGIN
    INSERT INTO Comision (id ,cursoid ,nombre ,periodoanual)
    VALUES
    (p_id ,p_cursoid ,p_nombre ,p_periodoanual);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_Comision';
DELIMITER //
DROP PROCEDURE IF EXISTS U_COMISION;
CREATE PROCEDURE U_COMISION(
 IN P_id INT
,IN P_cursoid INT
,IN P_nombre VARCHAR(1024)
,IN P_periodoanual INT
)
BEGIN
    UPDATE Comision SET 
    cursoid = IFNULL(P_cursoid ,cursoid)
   ,nombre = IFNULL(P_nombre ,nombre)
   ,periodoanual = IFNULL(P_periodoanual ,periodoanual)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_Comision';
DELIMITER //
DROP PROCEDURE IF EXISTS D_COMISION;
CREATE PROCEDURE D_COMISION(
IN id INT
)
BEGIN
    DELETE FROM Comision WHERE id = id;
END;
//
DELIMITER ;
Select 'sproc -> I_Curso';
DELIMITER //
DROP PROCEDURE IF EXISTS I_CURSO;
CREATE PROCEDURE I_CURSO(
 OUT p_id INT
,IN p_planestudioid INT
,IN p_nivelid INT
,IN p_nombre VARCHAR(1024)
)
BEGIN
    INSERT INTO Curso (id ,planestudioid ,nivelid ,nombre)
    VALUES
    (p_id ,p_planestudioid ,p_nivelid ,p_nombre);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_Curso';
DELIMITER //
DROP PROCEDURE IF EXISTS U_CURSO;
CREATE PROCEDURE U_CURSO(
 IN P_id INT
,IN P_planestudioid INT
,IN P_nivelid INT
,IN P_nombre VARCHAR(1024)
)
BEGIN
    UPDATE Curso SET 
    planestudioid = IFNULL(P_planestudioid ,planestudioid)
   ,nivelid = IFNULL(P_nivelid ,nivelid)
   ,nombre = IFNULL(P_nombre ,nombre)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_Curso';
DELIMITER //
DROP PROCEDURE IF EXISTS D_CURSO;
CREATE PROCEDURE D_CURSO(
IN id INT
)
BEGIN
    DELETE FROM Curso WHERE id = id;
END;
//
DELIMITER ;
Select 'sproc -> I_Docente';
DELIMITER //
DROP PROCEDURE IF EXISTS I_DOCENTE;
CREATE PROCEDURE I_DOCENTE(
 OUT p_id INT
,IN p_personaid INT
,IN p_institucionid INT
,IN p_fingreso DATE
,IN p_fegreso DATE
)
BEGIN
    INSERT INTO Docente (id ,personaid ,institucionid ,fingreso ,fegreso)
    VALUES
    (p_id ,p_personaid ,p_institucionid ,p_fingreso ,p_fegreso);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_Docente';
DELIMITER //
DROP PROCEDURE IF EXISTS U_DOCENTE;
CREATE PROCEDURE U_DOCENTE(
 IN P_id INT
,IN P_personaid INT
,IN P_institucionid INT
,IN P_fingreso DATE
,IN P_fegreso DATE
)
BEGIN
    UPDATE Docente SET 
    personaid = IFNULL(P_personaid ,personaid)
   ,institucionid = IFNULL(P_institucionid ,institucionid)
   ,fingreso = IFNULL(P_fingreso ,fingreso)
   ,fegreso = IFNULL(P_fegreso ,fegreso)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_Docente';
DELIMITER //
DROP PROCEDURE IF EXISTS D_DOCENTE;
CREATE PROCEDURE D_DOCENTE(
IN id INT
)
BEGIN
    DELETE FROM Docente WHERE id = id;
END;
//
DELIMITER ;
Select 'sproc -> I_Domicilio';
DELIMITER //
DROP PROCEDURE IF EXISTS I_DOMICILIO;
CREATE PROCEDURE I_DOMICILIO(
 OUT p_id INT
,IN p_localidadid INT
,IN p_direccion VARCHAR(2048)
,IN p_codpos VARCHAR(32)
)
BEGIN
    INSERT INTO Domicilio (id ,localidadid ,direccion ,codpos)
    VALUES
    (p_id ,p_localidadid ,p_direccion ,p_codpos);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_Domicilio';
DELIMITER //
DROP PROCEDURE IF EXISTS U_DOMICILIO;
CREATE PROCEDURE U_DOMICILIO(
 IN P_id INT
,IN P_localidadid INT
,IN P_direccion VARCHAR(2048)
,IN P_codpos VARCHAR(32)
)
BEGIN
    UPDATE Domicilio SET 
    localidadid = IFNULL(P_localidadid ,localidadid)
   ,direccion = IFNULL(P_direccion ,direccion)
   ,codpos = IFNULL(P_codpos ,codpos)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_Domicilio';
DELIMITER //
DROP PROCEDURE IF EXISTS D_DOMICILIO;
CREATE PROCEDURE D_DOMICILIO(
IN id INT
)
BEGIN
    DELETE FROM Domicilio WHERE id = id;
END;
//
DELIMITER ;
Select 'sproc -> I_HorasTurno';
DELIMITER //
DROP PROCEDURE IF EXISTS I_HORASTURNO;
CREATE PROCEDURE I_HORASTURNO(
 OUT p_id INT
,IN p_turnoid INT
,IN p_horainicio TIME
,IN p_horafin TIME
)
BEGIN
    INSERT INTO HorasTurno (id ,turnoid ,horainicio ,horafin)
    VALUES
    (p_id ,p_turnoid ,p_horainicio ,p_horafin);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_HorasTurno';
DELIMITER //
DROP PROCEDURE IF EXISTS U_HORASTURNO;
CREATE PROCEDURE U_HORASTURNO(
 IN P_id INT
,IN P_turnoid INT
,IN P_horainicio TIME
,IN P_horafin TIME
)
BEGIN
    UPDATE HorasTurno SET 
    turnoid = IFNULL(P_turnoid ,turnoid)
   ,horainicio = IFNULL(P_horainicio ,horainicio)
   ,horafin = IFNULL(P_horafin ,horafin)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_HorasTurno';
DELIMITER //
DROP PROCEDURE IF EXISTS D_HORASTURNO;
CREATE PROCEDURE D_HORASTURNO(
IN id INT
)
BEGIN
    DELETE FROM HorasTurno WHERE id = id;
END;
//
DELIMITER ;
Select 'sproc -> I_Institucion';
DELIMITER //
DROP PROCEDURE IF EXISTS I_INSTITUCION;
CREATE PROCEDURE I_INSTITUCION(
 OUT p_id INT
,IN p_nombre VARCHAR(1024)
,IN p_diegrep VARCHAR(512)
)
BEGIN
    INSERT INTO Institucion (id ,nombre ,diegrep)
    VALUES
    (p_id ,p_nombre ,p_diegrep);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_Institucion';
DELIMITER //
DROP PROCEDURE IF EXISTS U_INSTITUCION;
CREATE PROCEDURE U_INSTITUCION(
 IN P_id INT
,IN P_nombre VARCHAR(1024)
,IN P_diegrep VARCHAR(512)
)
BEGIN
    UPDATE Institucion SET 
    nombre = IFNULL(P_nombre ,nombre)
   ,diegrep = IFNULL(P_diegrep ,diegrep)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_Institucion';
DELIMITER //
DROP PROCEDURE IF EXISTS D_INSTITUCION;
CREATE PROCEDURE D_INSTITUCION(
IN id INT
)
BEGIN
    DELETE FROM Institucion WHERE id = id;
END;
//
DELIMITER ;
Select 'sproc -> I_InstitucionOrientacion';
DELIMITER //
DROP PROCEDURE IF EXISTS I_INSTITUCIONORIENTACION;
CREATE PROCEDURE I_INSTITUCIONORIENTACION(
 OUT p_id INT
,IN p_institucionid INT
,IN p_orientacionid INT
)
BEGIN
    INSERT INTO InstitucionOrientacion (id ,institucionid ,orientacionid)
    VALUES
    (p_id ,p_institucionid ,p_orientacionid);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_InstitucionOrientacion';
DELIMITER //
DROP PROCEDURE IF EXISTS U_INSTITUCIONORIENTACION;
CREATE PROCEDURE U_INSTITUCIONORIENTACION(
 IN P_id INT
,IN P_institucionid INT
,IN P_orientacionid INT
)
BEGIN
    UPDATE InstitucionOrientacion SET 
    institucionid = IFNULL(P_institucionid ,institucionid)
   ,orientacionid = IFNULL(P_orientacionid ,orientacionid)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_InstitucionOrientacion';
DELIMITER //
DROP PROCEDURE IF EXISTS D_INSTITUCIONORIENTACION;
CREATE PROCEDURE D_INSTITUCIONORIENTACION(
IN id INT
)
BEGIN
    DELETE FROM InstitucionOrientacion WHERE id = id;
END;
//
DELIMITER ;
Select 'sproc -> I_Localidad';
DELIMITER //
DROP PROCEDURE IF EXISTS I_LOCALIDAD;
CREATE PROCEDURE I_LOCALIDAD(
 OUT p_id INT
,IN p_provinciaid INT
,IN p_nombre VARCHAR(1024)
)
BEGIN
    INSERT INTO Localidad (id ,provinciaid ,nombre)
    VALUES
    (p_id ,p_provinciaid ,p_nombre);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_Localidad';
DELIMITER //
DROP PROCEDURE IF EXISTS U_LOCALIDAD;
CREATE PROCEDURE U_LOCALIDAD(
 IN P_id INT
,IN P_provinciaid INT
,IN P_nombre VARCHAR(1024)
)
BEGIN
    UPDATE Localidad SET 
    provinciaid = IFNULL(P_provinciaid ,provinciaid)
   ,nombre = IFNULL(P_nombre ,nombre)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_Localidad';
DELIMITER //
DROP PROCEDURE IF EXISTS D_LOCALIDAD;
CREATE PROCEDURE D_LOCALIDAD(
IN id INT
)
BEGIN
    DELETE FROM Localidad WHERE id = id;
END;
//
DELIMITER ;
Select 'sproc -> I_Materia';
DELIMITER //
DROP PROCEDURE IF EXISTS I_MATERIA;
CREATE PROCEDURE I_MATERIA(
 OUT p_id INT
,IN p_nombre VARCHAR(1024)
)
BEGIN
    INSERT INTO Materia (id ,nombre)
    VALUES
    (p_id ,p_nombre);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_Materia';
DELIMITER //
DROP PROCEDURE IF EXISTS U_MATERIA;
CREATE PROCEDURE U_MATERIA(
 IN P_id INT
,IN P_nombre VARCHAR(1024)
)
BEGIN
    UPDATE Materia SET 
    nombre = IFNULL(P_nombre ,nombre)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_Materia';
DELIMITER //
DROP PROCEDURE IF EXISTS D_MATERIA;
CREATE PROCEDURE D_MATERIA(
IN id INT
)
BEGIN
    DELETE FROM Materia WHERE id = id;
END;
//
DELIMITER ;
Select 'sproc -> I_MateriasDocente';
DELIMITER //
DROP PROCEDURE IF EXISTS I_MATERIASDOCENTE;
CREATE PROCEDURE I_MATERIASDOCENTE(
 OUT p_id INT
,IN p_docenteid INT
,IN p_materiaid INT
)
BEGIN
    INSERT INTO MateriasDocente (id ,docenteid ,materiaid)
    VALUES
    (p_id ,p_docenteid ,p_materiaid);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_MateriasDocente';
DELIMITER //
DROP PROCEDURE IF EXISTS U_MATERIASDOCENTE;
CREATE PROCEDURE U_MATERIASDOCENTE(
 IN P_id INT
,IN P_docenteid INT
,IN P_materiaid INT
)
BEGIN
    UPDATE MateriasDocente SET 
    docenteid = IFNULL(P_docenteid ,docenteid)
   ,materiaid = IFNULL(P_materiaid ,materiaid)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_MateriasDocente';
DELIMITER //
DROP PROCEDURE IF EXISTS D_MATERIASDOCENTE;
CREATE PROCEDURE D_MATERIASDOCENTE(
IN id INT
)
BEGIN
    DELETE FROM MateriasDocente WHERE id = id;
END;
//
DELIMITER ;
Select 'sproc -> I_MateriasPlan';
DELIMITER //
DROP PROCEDURE IF EXISTS I_MATERIASPLAN;
CREATE PROCEDURE I_MATERIASPLAN(
 OUT p_id INT
,IN p_planestudiosid INT
,IN p_materiaid INT
,IN p_horassemanales INT
)
BEGIN
    INSERT INTO MateriasPlan (id ,planestudiosid ,materiaid ,horassemanales)
    VALUES
    (p_id ,p_planestudiosid ,p_materiaid ,p_horassemanales);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_MateriasPlan';
DELIMITER //
DROP PROCEDURE IF EXISTS U_MATERIASPLAN;
CREATE PROCEDURE U_MATERIASPLAN(
 IN P_id INT
,IN P_planestudiosid INT
,IN P_materiaid INT
,IN P_horassemanales INT
)
BEGIN
    UPDATE MateriasPlan SET 
    planestudiosid = IFNULL(P_planestudiosid ,planestudiosid)
   ,materiaid = IFNULL(P_materiaid ,materiaid)
   ,horassemanales = IFNULL(P_horassemanales ,horassemanales)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_MateriasPlan';
DELIMITER //
DROP PROCEDURE IF EXISTS D_MATERIASPLAN;
CREATE PROCEDURE D_MATERIASPLAN(
IN id INT
)
BEGIN
    DELETE FROM MateriasPlan WHERE id = id;
END;
//
DELIMITER ;
Select 'sproc -> I_Nivel';
DELIMITER //
DROP PROCEDURE IF EXISTS I_NIVEL;
CREATE PROCEDURE I_NIVEL(
 OUT p_id INT
,OUT p_id INT
,IN p_nombre VARCHAR(1024)
,IN p_nombre VARCHAR(512)
)
BEGIN
    INSERT INTO Nivel (id ,id ,nombre ,nombre)
    VALUES
    (p_id ,p_id ,p_nombre ,p_nombre);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_Nivel';
DELIMITER //
DROP PROCEDURE IF EXISTS U_NIVEL;
CREATE PROCEDURE U_NIVEL(
 IN P_id INT
,IN P_nombre VARCHAR(1024)
,IN P_nombre VARCHAR(512)
)
BEGIN
    UPDATE Nivel SET 
    nombre = IFNULL(P_nombre ,nombre)
   ,nombre = IFNULL(P_nombre ,nombre)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_Nivel';
DELIMITER //
DROP PROCEDURE IF EXISTS D_NIVEL;
CREATE PROCEDURE D_NIVEL(
IN id INT
IN id INT
)
BEGIN
    DELETE FROM Nivel WHERE id = id;
END;
//
DELIMITER ;
Select 'sproc -> I_Orientacion';
DELIMITER //
DROP PROCEDURE IF EXISTS I_ORIENTACION;
CREATE PROCEDURE I_ORIENTACION(
 OUT p_id INT
,IN p_nombre VARCHAR(1024)
)
BEGIN
    INSERT INTO Orientacion (id ,nombre)
    VALUES
    (p_id ,p_nombre);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_Orientacion';
DELIMITER //
DROP PROCEDURE IF EXISTS U_ORIENTACION;
CREATE PROCEDURE U_ORIENTACION(
 IN P_id INT
,IN P_nombre VARCHAR(1024)
)
BEGIN
    UPDATE Orientacion SET 
    nombre = IFNULL(P_nombre ,nombre)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_Orientacion';
DELIMITER //
DROP PROCEDURE IF EXISTS D_ORIENTACION;
CREATE PROCEDURE D_ORIENTACION(
IN id INT
)
BEGIN
    DELETE FROM Orientacion WHERE id = id;
END;
//
DELIMITER ;
Select 'sproc -> I_Pais';
DELIMITER //
DROP PROCEDURE IF EXISTS I_PAIS;
CREATE PROCEDURE I_PAIS(
 OUT p_id INT
,IN p_nombre VARCHAR(1024)
)
BEGIN
    INSERT INTO Pais (id ,nombre)
    VALUES
    (p_id ,p_nombre);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_Pais';
DELIMITER //
DROP PROCEDURE IF EXISTS U_PAIS;
CREATE PROCEDURE U_PAIS(
 IN P_id INT
,IN P_nombre VARCHAR(1024)
)
BEGIN
    UPDATE Pais SET 
    nombre = IFNULL(P_nombre ,nombre)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_Pais';
DELIMITER //
DROP PROCEDURE IF EXISTS D_PAIS;
CREATE PROCEDURE D_PAIS(
IN id INT
)
BEGIN
    DELETE FROM Pais WHERE id = id;
END;
//
DELIMITER ;
Select 'sproc -> I_Persona';
DELIMITER //
DROP PROCEDURE IF EXISTS I_PERSONA;
CREATE PROCEDURE I_PERSONA(
 OUT p_id INT
,IN p_nombre VARCHAR(128)
,IN p_apellido VARCHAR(128)
,IN p_tipodocumentoid INT
,IN p_documento VARCHAR(32)
,IN p_fnacto DATETIME
,IN p_genero CHAR(1)
,IN p_domicilioid INT
)
BEGIN
    INSERT INTO Persona (id ,nombre ,apellido ,tipodocumentoid ,documento ,fnacto ,genero ,domicilioid)
    VALUES
    (p_id ,p_nombre ,p_apellido ,p_tipodocumentoid ,p_documento ,p_fnacto ,p_genero ,p_domicilioid);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_Persona';
DELIMITER //
DROP PROCEDURE IF EXISTS U_PERSONA;
CREATE PROCEDURE U_PERSONA(
 IN P_id INT
,IN P_nombre VARCHAR(128)
,IN P_apellido VARCHAR(128)
,IN P_tipodocumentoid INT
,IN P_documento VARCHAR(32)
,IN P_fnacto DATETIME
,IN P_genero CHAR(1)
,IN P_domicilioid INT
)
BEGIN
    UPDATE Persona SET 
    nombre = IFNULL(P_nombre ,nombre)
   ,apellido = IFNULL(P_apellido ,apellido)
   ,tipodocumentoid = IFNULL(P_tipodocumentoid ,tipodocumentoid)
   ,documento = IFNULL(P_documento ,documento)
   ,fnacto = IFNULL(P_fnacto ,fnacto)
   ,genero = IFNULL(P_genero ,genero)
   ,domicilioid = IFNULL(P_domicilioid ,domicilioid)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_Persona';
DELIMITER //
DROP PROCEDURE IF EXISTS D_PERSONA;
CREATE PROCEDURE D_PERSONA(
IN id INT
)
BEGIN
    DELETE FROM Persona WHERE id = id;
END;
//
DELIMITER ;
Select 'sproc -> I_PlanEstudios';
DELIMITER //
DROP PROCEDURE IF EXISTS I_PLANESTUDIOS;
CREATE PROCEDURE I_PLANESTUDIOS(
 OUT p_id INT
,IN p_InstitucionOrientacionId INT
,IN p_nombre VARCHAR(1024)
,IN p_fechainicio DATE
,IN p_fechafin DATE
)
BEGIN
    INSERT INTO PlanEstudios (id ,InstitucionOrientacionId ,nombre ,fechainicio ,fechafin)
    VALUES
    (p_id ,p_InstitucionOrientacionId ,p_nombre ,p_fechainicio ,p_fechafin);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_PlanEstudios';
DELIMITER //
DROP PROCEDURE IF EXISTS U_PLANESTUDIOS;
CREATE PROCEDURE U_PLANESTUDIOS(
 IN P_id INT
,IN P_InstitucionOrientacionId INT
,IN P_nombre VARCHAR(1024)
,IN P_fechainicio DATE
,IN P_fechafin DATE
)
BEGIN
    UPDATE PlanEstudios SET 
    InstitucionOrientacionId = IFNULL(P_InstitucionOrientacionId ,InstitucionOrientacionId)
   ,nombre = IFNULL(P_nombre ,nombre)
   ,fechainicio = IFNULL(P_fechainicio ,fechainicio)
   ,fechafin = IFNULL(P_fechafin ,fechafin)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_PlanEstudios';
DELIMITER //
DROP PROCEDURE IF EXISTS D_PLANESTUDIOS;
CREATE PROCEDURE D_PLANESTUDIOS(
IN id INT
)
BEGIN
    DELETE FROM PlanEstudios WHERE id = id;
END;
//
DELIMITER ;
Select 'sproc -> I_Provincia';
DELIMITER //
DROP PROCEDURE IF EXISTS I_PROVINCIA;
CREATE PROCEDURE I_PROVINCIA(
 OUT p_id INT
,IN p_paisid INT
,IN p_nombre VARCHAR(1024)
)
BEGIN
    INSERT INTO Provincia (id ,paisid ,nombre)
    VALUES
    (p_id ,p_paisid ,p_nombre);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_Provincia';
DELIMITER //
DROP PROCEDURE IF EXISTS U_PROVINCIA;
CREATE PROCEDURE U_PROVINCIA(
 IN P_id INT
,IN P_paisid INT
,IN P_nombre VARCHAR(1024)
)
BEGIN
    UPDATE Provincia SET 
    paisid = IFNULL(P_paisid ,paisid)
   ,nombre = IFNULL(P_nombre ,nombre)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_Provincia';
DELIMITER //
DROP PROCEDURE IF EXISTS D_PROVINCIA;
CREATE PROCEDURE D_PROVINCIA(
IN id INT
)
BEGIN
    DELETE FROM Provincia WHERE id = id;
END;
//
DELIMITER ;
Select 'sproc -> I_RelacionParental';
DELIMITER //
DROP PROCEDURE IF EXISTS I_RELACIONPARENTAL;
CREATE PROCEDURE I_RELACIONPARENTAL(
 OUT p_id INT
,IN p_autoridadparentalid INT
,IN p_padreid INT
,IN p_hijoid INT
)
BEGIN
    INSERT INTO RelacionParental (id ,autoridadparentalid ,padreid ,hijoid)
    VALUES
    (p_id ,p_autoridadparentalid ,p_padreid ,p_hijoid);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_RelacionParental';
DELIMITER //
DROP PROCEDURE IF EXISTS U_RELACIONPARENTAL;
CREATE PROCEDURE U_RELACIONPARENTAL(
 IN P_id INT
,IN P_autoridadparentalid INT
,IN P_padreid INT
,IN P_hijoid INT
)
BEGIN
    UPDATE RelacionParental SET 
    autoridadparentalid = IFNULL(P_autoridadparentalid ,autoridadparentalid)
   ,padreid = IFNULL(P_padreid ,padreid)
   ,hijoid = IFNULL(P_hijoid ,hijoid)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_RelacionParental';
DELIMITER //
DROP PROCEDURE IF EXISTS D_RELACIONPARENTAL;
CREATE PROCEDURE D_RELACIONPARENTAL(
IN id INT
)
BEGIN
    DELETE FROM RelacionParental WHERE id = id;
END;
//
DELIMITER ;
Select 'sproc -> I_ResponsableLegal';
DELIMITER //
DROP PROCEDURE IF EXISTS I_RESPONSABLELEGAL;
CREATE PROCEDURE I_RESPONSABLELEGAL(
 OUT p_id INT
,IN p_personaid INT
,IN p_fingreso DATE
,IN p_fegreso DATE
)
BEGIN
    INSERT INTO ResponsableLegal (id ,personaid ,fingreso ,fegreso)
    VALUES
    (p_id ,p_personaid ,p_fingreso ,p_fegreso);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_ResponsableLegal';
DELIMITER //
DROP PROCEDURE IF EXISTS U_RESPONSABLELEGAL;
CREATE PROCEDURE U_RESPONSABLELEGAL(
 IN P_id INT
,IN P_personaid INT
,IN P_fingreso DATE
,IN P_fegreso DATE
)
BEGIN
    UPDATE ResponsableLegal SET 
    personaid = IFNULL(P_personaid ,personaid)
   ,fingreso = IFNULL(P_fingreso ,fingreso)
   ,fegreso = IFNULL(P_fegreso ,fegreso)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_ResponsableLegal';
DELIMITER //
DROP PROCEDURE IF EXISTS D_RESPONSABLELEGAL;
CREATE PROCEDURE D_RESPONSABLELEGAL(
IN id INT
)
BEGIN
    DELETE FROM ResponsableLegal WHERE id = id;
END;
//
DELIMITER ;
Select 'sproc -> I_ResponsableLegalAlumno';
DELIMITER //
DROP PROCEDURE IF EXISTS I_RESPONSABLELEGALALUMNO;
CREATE PROCEDURE I_RESPONSABLELEGALALUMNO(
 OUT p_id INT
,IN p_ResponsableLegalid INT
,IN p_alumnoid INT
)
BEGIN
    INSERT INTO ResponsableLegalAlumno (id ,ResponsableLegalid ,alumnoid)
    VALUES
    (p_id ,p_ResponsableLegalid ,p_alumnoid);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_ResponsableLegalAlumno';
DELIMITER //
DROP PROCEDURE IF EXISTS U_RESPONSABLELEGALALUMNO;
CREATE PROCEDURE U_RESPONSABLELEGALALUMNO(
 IN P_id INT
,IN P_ResponsableLegalid INT
,IN P_alumnoid INT
)
BEGIN
    UPDATE ResponsableLegalAlumno SET 
    ResponsableLegalid = IFNULL(P_ResponsableLegalid ,ResponsableLegalid)
   ,alumnoid = IFNULL(P_alumnoid ,alumnoid)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_ResponsableLegalAlumno';
DELIMITER //
DROP PROCEDURE IF EXISTS D_RESPONSABLELEGALALUMNO;
CREATE PROCEDURE D_RESPONSABLELEGALALUMNO(
IN id INT
)
BEGIN
    DELETE FROM ResponsableLegalAlumno WHERE id = id;
END;
//
DELIMITER ;
Select 'sproc -> I_Sede';
DELIMITER //
DROP PROCEDURE IF EXISTS I_SEDE;
CREATE PROCEDURE I_SEDE(
 OUT p_id INT
,IN p_institucionid INT
,IN p_nombre VARCHAR(1024)
,IN p_domicilioid INT
)
BEGIN
    INSERT INTO Sede (id ,institucionid ,nombre ,domicilioid)
    VALUES
    (p_id ,p_institucionid ,p_nombre ,p_domicilioid);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_Sede';
DELIMITER //
DROP PROCEDURE IF EXISTS U_SEDE;
CREATE PROCEDURE U_SEDE(
 IN P_id INT
,IN P_institucionid INT
,IN P_nombre VARCHAR(1024)
,IN P_domicilioid INT
)
BEGIN
    UPDATE Sede SET 
    institucionid = IFNULL(P_institucionid ,institucionid)
   ,nombre = IFNULL(P_nombre ,nombre)
   ,domicilioid = IFNULL(P_domicilioid ,domicilioid)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_Sede';
DELIMITER //
DROP PROCEDURE IF EXISTS D_SEDE;
CREATE PROCEDURE D_SEDE(
IN id INT
)
BEGIN
    DELETE FROM Sede WHERE id = id;
END;
//
DELIMITER ;
Select 'sproc -> I_TipoDocumento';
DELIMITER //
DROP PROCEDURE IF EXISTS I_TIPODOCUMENTO;
CREATE PROCEDURE I_TIPODOCUMENTO(
 OUT p_id INT
,IN p_nombre VARCHAR(1024)
)
BEGIN
    INSERT INTO TipoDocumento (id ,nombre)
    VALUES
    (p_id ,p_nombre);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_TipoDocumento';
DELIMITER //
DROP PROCEDURE IF EXISTS U_TIPODOCUMENTO;
CREATE PROCEDURE U_TIPODOCUMENTO(
 IN P_id INT
,IN P_nombre VARCHAR(1024)
)
BEGIN
    UPDATE TipoDocumento SET 
    nombre = IFNULL(P_nombre ,nombre)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_TipoDocumento';
DELIMITER //
DROP PROCEDURE IF EXISTS D_TIPODOCUMENTO;
CREATE PROCEDURE D_TIPODOCUMENTO(
IN id INT
)
BEGIN
    DELETE FROM TipoDocumento WHERE id = id;
END;
//
DELIMITER ;
Select 'sproc -> I_Turno';
DELIMITER //
DROP PROCEDURE IF EXISTS I_TURNO;
CREATE PROCEDURE I_TURNO(
 OUT p_id INT
,IN p_institucionorientacionid INT
,IN p_sedeid INT
,IN p_nombre VARCHAR(512)
,IN p_horaentrada TIME
,IN p_horasalida TIME
)
BEGIN
    INSERT INTO Turno (id ,institucionorientacionid ,sedeid ,nombre ,horaentrada ,horasalida)
    VALUES
    (p_id ,p_institucionorientacionid ,p_sedeid ,p_nombre ,p_horaentrada ,p_horasalida);
    SET p_id := last_insert_id();
END;
//
DELIMITER ;
Select 'sproc -> U_Turno';
DELIMITER //
DROP PROCEDURE IF EXISTS U_TURNO;
CREATE PROCEDURE U_TURNO(
 IN P_id INT
,IN P_institucionorientacionid INT
,IN P_sedeid INT
,IN P_nombre VARCHAR(512)
,IN P_horaentrada TIME
,IN P_horasalida TIME
)
BEGIN
    UPDATE Turno SET 
    institucionorientacionid = IFNULL(P_institucionorientacionid ,institucionorientacionid)
   ,sedeid = IFNULL(P_sedeid ,sedeid)
   ,nombre = IFNULL(P_nombre ,nombre)
   ,horaentrada = IFNULL(P_horaentrada ,horaentrada)
   ,horasalida = IFNULL(P_horasalida ,horasalida)
    WHERE id = P_id;
END;
//
DELIMITER ;
Select 'sproc -> D_Turno';
DELIMITER //
DROP PROCEDURE IF EXISTS D_TURNO;
CREATE PROCEDURE D_TURNO(
IN id INT
)
BEGIN
    DELETE FROM Turno WHERE id = id;
END;
//
DELIMITER ;
