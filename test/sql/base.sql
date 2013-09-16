BEGIN;

CREATE EXTENSION quantile;

-- int
SELECT quantile(x, 0.5) FROM generate_series(1,1000) s(x);
SELECT quantile(x, 0.1) FROM generate_series(1,1000) s(x);
SELECT quantile(x, 0) FROM generate_series(1,1000) s(x);
SELECT quantile(x, 1) FROM generate_series(1,1000) s(x);

SELECT quantile(x, ARRAY[0.5]) FROM generate_series(1,1000) s(x);
SELECT quantile(x, ARRAY[0.1]) FROM generate_series(1,1000) s(x);
SELECT quantile(x, ARRAY[0]) FROM generate_series(1,1000) s(x);
SELECT quantile(x, ARRAY[1]) FROM generate_series(1,1000) s(x);

SELECT quantile(x, ARRAY[0, 0.1, 0.5, 0.75, 1]) FROM generate_series(1,1000) s(x);

-- bigint
SELECT quantile(x::bigint, 0.5) FROM generate_series(1,1000) s(x);
SELECT quantile(x::bigint, 0.1) FROM generate_series(1,1000) s(x);
SELECT quantile(x::bigint, 0) FROM generate_series(1,1000) s(x);
SELECT quantile(x::bigint, 1) FROM generate_series(1,1000) s(x);

SELECT quantile(x::bigint, ARRAY[0.5]) FROM generate_series(1,1000) s(x);
SELECT quantile(x::bigint, ARRAY[0.1]) FROM generate_series(1,1000) s(x);
SELECT quantile(x::bigint, ARRAY[0]) FROM generate_series(1,1000) s(x);
SELECT quantile(x::bigint, ARRAY[1]) FROM generate_series(1,1000) s(x);

SELECT quantile(x::bigint, ARRAY[0, 0.1, 0.5, 0.75, 1]) FROM generate_series(1,1000) s(x);

-- double precision
SELECT quantile(x::double precision, 0.5) FROM generate_series(1,1000) s(x);
SELECT quantile(x::double precision, 0.1) FROM generate_series(1,1000) s(x);
SELECT quantile(x::double precision, 0) FROM generate_series(1,1000) s(x);
SELECT quantile(x::double precision, 1) FROM generate_series(1,1000) s(x);

SELECT quantile(x::double precision, ARRAY[0.5]) FROM generate_series(1,1000) s(x);
SELECT quantile(x::double precision, ARRAY[0.1]) FROM generate_series(1,1000) s(x);
SELECT quantile(x::double precision, ARRAY[0]) FROM generate_series(1,1000) s(x);
SELECT quantile(x::double precision, ARRAY[1]) FROM generate_series(1,1000) s(x);

SELECT quantile(x::double precision, ARRAY[0, 0.1, 0.5, 0.75, 1]) FROM generate_series(1,1000) s(x);

-- numeric
SELECT quantile(x::numeric, 0.5) FROM generate_series(1,1000) s(x);
SELECT quantile(x::numeric, 0.1) FROM generate_series(1,1000) s(x);
SELECT quantile(x::numeric, 0) FROM generate_series(1,1000) s(x);
SELECT quantile(x::numeric, 1) FROM generate_series(1,1000) s(x);

SELECT quantile(x::numeric, ARRAY[0.5]) FROM generate_series(1,1000) s(x);
SELECT quantile(x::numeric, ARRAY[0.1]) FROM generate_series(1,1000) s(x);
SELECT quantile(x::numeric, ARRAY[0]) FROM generate_series(1,1000) s(x);
SELECT quantile(x::numeric, ARRAY[1]) FROM generate_series(1,1000) s(x);

SELECT quantile(x::numeric, ARRAY[0, 0.1, 0.5, 0.75, 1]) FROM generate_series(1,1000) s(x);

CREATE TABLE parent_table (id int);
CREATE TABLE child_table  (id int, val int);

INSERT INTO parent_table SELECT i FROM generate_series(1,10) s(i);
INSERT INTO child_table  SELECT 2, i FROM generate_series(1,100) s(i);
INSERT INTO child_table  SELECT 4, i FROM generate_series(1,100) s(i);
INSERT INTO child_table  SELECT 6, i FROM generate_series(1,100) s(i);
INSERT INTO child_table  SELECT 8, i FROM generate_series(1,100) s(i);
INSERT INTO child_table  SELECT 10, i FROM generate_series(1,100) s(i);

SELECT parent_table.id, quantile(child_table.val, array[0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]) FROM parent_table LEFT JOIN child_table USING (id) GROUP BY id ORDER BY id;

SELECT parent_table.id, quantile(child_table.val, 0.5) FROM parent_table LEFT JOIN child_table USING (id) GROUP BY id ORDER BY id;

ROLLBACK;