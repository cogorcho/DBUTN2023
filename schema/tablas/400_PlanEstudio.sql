----------------------------------------------
-- Tabla PlanEstudio
-- Plan de estudios Materias por orientacion, nivel
-- Ejemplo:
--     Historia
--     Matematica
--     etc etc
----------------------------------------------
use dbutn
GO

create table PlanEstudio (
    id integer identity(1,1) primary key,
    nombre varchar(512) not null,
    orientacionid integer not null,
    nivelid integer not null,
    materiaid integer not null,
    horas_semanales integer not null default 0,
    CONSTRAINT fk_plan_orientacion FOREIGN KEY(orientacionid)
    REFERENCES Orientacion(id),
    CONSTRAINT fk_plan_nivel FOREIGN KEY(nivelid)
    REFERENCES Nivel(id),
    CONSTRAINT fk_plan_materia FOREIGN KEY(materiaid)
    REFERENCES Materia(id)
)
GO

-- Indice unico por materias del plan
create unique index uix_plan_ori_niv_mat
on PlanEstudio(orientacionid,nivelid,materiaid)
GO

