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
ORDER BY table_name, col_id