SELECT
  m.name AS table_name, 
  p.cid AS col_id,
  p.name AS col_name,
  p.type AS col_type,
  p.pk AS col_is_pk,
  p.dflt_value AS col_default_val,
  p.[notnull] AS col_is_not_null
FROM sqlite_master m
LEFT OUTER JOIN pragma_table_info((m.name)) p
  ON m.name <> p.name
WHERE m.type = 'table'
ORDER BY table_name, col_id;

select name from sqlite_master where type = 'table';

SELECT 
m.name AS table_name, 
p.cid AS col_id,
p.name AS col_name, 
p.type AS col_type, 
p.pk AS col_is_pk, 
p.dflt_value AS col_default_val, 
p.[notnull] AS col_is_not_null 
FROM sqlite_master m 
LEFT OUTER JOIN pragma_table_info((m.name)) p 
ON m.name <> p.name 
WHERE m.type = 'table' 
AND m.table_name = 'Clase' 
ORDER BY table_name, col_id;

SELECT 
m.name AS table_name, 
p.cid AS col_id,
p.name AS col_name, 
p.type AS col_type, 
p.pk AS col_is_pk, 
p.dflt_value AS col_default_val, 
p.[notnull] AS col_is_not_null 
FROM sqlite_master m 
LEFT OUTER JOIN pragma_table_info((m.name)) p 
ON m.name <> p.name 
LEFT OUTER JOIN pragma_foreign_key_list((m.name)) k
ON p.name = k.from
WHERE m.type = 'table' 
and m.name = 'Alumno'
ORDER BY table_name, col_id;


qlite> select * from pragma_foreign_key_list('Sede');
id|seq|table|from|to|on_update|on_delete|match
0|0|Institucion|institucionid|id|NO ACTION|NO ACTION|NONE
