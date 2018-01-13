-- JOIN = INNER JOIN
-- LEFT JOIN = LEFT OUTER JOIN
-- RIGHT JOIN = RIGHT OUTER JOIN


-- при переключении master->slave необходимо обновить hash индексы
SELECT
  i.relname                AS indname,
  i.relowner               AS indowner,
  idx.indrelid::REGCLASS,
  am.amname                AS indam,
  idx.indkey,
  ARRAY(
    SELECT pg_get_indexdef(idx.indexrelid, k + 1, TRUE)
    FROM generate_subscripts(idx.indkey, 1) AS k
    ORDER BY k
  )                        AS indkey_names,
  idx.indexprs IS NOT NULL AS indexprs,
  idx.indpred IS NOT NULL  AS indpred
FROM pg_index AS idx
  JOIN pg_class AS i
    ON i.oid = idx.indexrelid
  JOIN pg_am AS am
    ON i.relam = am.oid
WHERE am.amname = 'hash';


WITH myconstants AS (
  SELECT 5::TEXT
  FROM test
  LIMIT 1)
SELECT *
FROM test
WHERE record_id = (SELECT record_id FROM myconstants);


-- return columns comment/desc
SELECT
  objsubid,
  description
FROM pg_description
  JOIN pg_class ON pg_description.objoid = pg_class.oid
WHERE relname = 'table_name';


-- return columns comment/desc
SELECT
  c.table_schema,
  c.table_name,
  c.column_name,
  pgd.description
FROM pg_catalog.pg_statio_all_tables AS st
  INNER JOIN pg_catalog.pg_description pgd ON (pgd.objoid = st.relid)
  INNER JOIN information_schema.columns c ON (
    pgd.objsubid = c.ordinal_position
    AND c.table_schema = st.schemaname
    AND c.table_name = st.relname
    AND c.table_name = 'table_name'
  );


SELECT
  tc.*,
  ccu.table_name  AS main_table,
  tc.table_name   AS slave_table,
  ccu.column_name,
  con.confupdtype AS "UPDATE ACTION",
  con.confdeltype AS "DELETE ACTION"
FROM information_schema.table_constraints tc
  RIGHT JOIN information_schema.constraint_column_usage ccu
    ON tc.constraint_catalog = ccu.constraint_catalog
  INNER JOIN pg_constraint con
    ON tc.constraint_name = con.conname
       AND tc.constraint_schema = ccu.constraint_schema
       AND tc.constraint_name = ccu.constraint_name
       AND ccu.table_name IN ('table_name')
WHERE tc.constraint_type IS NOT NULL;
--WHERE lower(tc.constraint_type) in ('foreign key');


-- имя таблицы по oid
SELECT
  oid,
  relname
FROM pg_class
WHERE oid = 631552;


-- статистика по автовакууму
SELECT
  relname,
  last_vacuum,
  last_analyze,
  last_autovacuum,
  last_autoanalyze,
  vacuum_count,
  autovacuum_count,
  analyze_count,
  autoanalyze_count
FROM pg_stat_all_tables
WHERE schemaname = 'public';




-- Advisory locks
SELECT * FROM pg_stat_activity; -- sessions, pid session id
SELECT * FROM pg_locks; -- locks
SELECT pg_advisory_unlock_all();
SELECT pg_advisory_unlock(id);
SELECT pg_backend_pid();


SELECT pg_advisory_lock(id) FROM foo; -- That will obtain a lock for every row in that table
SELECT pg_advisory_lock(id) FROM foo WHERE id = 12345; -- ok
SELECT pg_advisory_lock(id) FROM foo WHERE id > 12345 LIMIT 100; -- danger!
SELECT pg_advisory_lock(q.id) FROM
  (
    SELECT id FROM foo WHERE id > 12345 LIMIT 100
  ) q; -- ok


-- найти блокировку pg_advisory_lock, узнать её pid
select * from pg_locks;
select * from pg_lock where objid = '3737085198';
-- грохнуть сессию по pid
select pg_terminate_backend(pid);


-- показывает блокировки
SELECT locktype,
  relation::regclass,
  mode,
  transactionid AS tid,
  virtualtransaction AS vtid,
  pid,
  granted
FROM pg_catalog.pg_locks l
  LEFT JOIN pg_catalog.pg_database db
    ON db.oid = l.database
WHERE (db.datname = 'sandbox' OR db.datname IS NULL)
      AND NOT pid = pg_backend_pid();


-- show slow queries
SELECT
  date_trunc('seconds', NOW()-query_start) AS duration,
  pid,
  waiting,
  substring(query from 1 for 150) query,
  state
FROM pg_stat_activity
WHERE state != 'idle'
      AND NOW()-query_start >= interval '1 minutes'
ORDER BY 1 DESC;


SELECT pg_terminate_backend(31051);


-- представление показывает кто кого заблокировал
CREATE VIEW lock_monitor AS(
  SELECT
    COALESCE(blockingl.relation::regclass::text,blockingl.locktype) AS locked_item,
    now() - blockeda.query_start AS waiting_duration, blockeda.pid AS blocked_pid,
    blockeda.query AS blocked_query, blockedl.mode AS blocked_mode,
    blockinga.pid AS blocking_pid, blockinga.query AS blocking_query,
    blockingl.mode AS blocking_mode
  FROM pg_catalog.pg_locks blockedl
    JOIN pg_stat_activity blockeda ON blockedl.pid = blockeda.pid
    JOIN pg_catalog.pg_locks blockingl ON(
      ( (blockingl.transactionid=blockedl.transactionid) OR
        (blockingl.relation=blockedl.relation AND blockingl.locktype=blockedl.locktype)
      ) AND blockedl.pid != blockingl.pid)
    JOIN pg_stat_activity blockinga ON blockingl.pid = blockinga.pid
      AND blockinga.datid = blockeda.datid
  WHERE NOT blockedl.granted
    AND blockinga.datname = current_database()
);




/*
  Создание индекса без блокировок
  When this option is used, PostgreSQL will build the index without taking any locks that prevent concurrent inserts, updates, or deletes on the table;
  CREATE INDEX CONCURRENTLY
  при построении индекса используется память, по умолчанию выделяется 64 мегабайта, что может быть мало для таблицы. Это значение (maintenance_work_mem) можно увеличить в конкретной сессии.
*/


-- чем больше строк в таблице попадает под условие, тем больше шансов у Seq Scan оказаться дешевле, чем у прохода по индексу


VACUUM (VERBOSE, ANALYZE) tablename;


SELECT *
FROM pg_stat_all_tables
WHERE schemaname = 'public'
AND relname = 'my_table';


-- индекс в сортировке не используется если при джойне есть пустые значения
--EXPLAIN
SELECT p.id, l.date_end
FROM "procedures" AS p
  RIGHT JOIN "lots" AS l ON l.procedure_id = p.id
ORDER BY l.date_end
LIMIT 2;


-- посмотреть размер бд и таблиц
SELECT t1.datname AS db_name,
  pg_size_pretty(pg_database_size(t1.datname)) AS db_size
FROM pg_database t1
ORDER BY pg_database_size(t1.datname) DESC;


-- проверка уникальности двух полей
SELECT a_id, b_id, count(*) FROM "my_table"
GROUP BY a_id, b_id
HAVING count(*) > 1
LIMIT 10;


-- запрос на права по таблице
SELECT grantee, string_agg(privilege_type, ', ') AS privileges
FROM information_schema.role_table_grants
WHERE table_name = 'my_table'
GROUP BY grantee;


-- show path to config
SHOW hba_file;


-- upsert
INSERT INTO dictionary (code, name, parent_code)
VALUES ('A', 'Петя1', ''),
  ('01', 'Петя2', ''),
  ('01.1', 'Петя3', '')
ON CONFLICT (code)
  DO UPDATE SET
    name = EXCLUDED.name,
    parent_code = EXCLUDED.parent_code;


CREATE INDEX CONCURRENTLY mail_log_fts_idx ON mail_log USING gin(
  (setweight( coalesce( to_tsvector('russian', subject),''),'A') || ' ' ||
   setweight( coalesce( to_tsvector('russian', email),''),'B') || ' ' ||
   setweight( coalesce( to_tsvector('russian', body),''),'C')));


-- генерация данных select для update
SELECT * FROM (
  VALUES
    (1, 10, 101),
    (2, 10, 102),
    (3, 20, 201),
    (4, 20, 202),
    (5, 20, 203)
) as tab (oid, identifier, value);
