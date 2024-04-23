CREATE TABLE new_customer (LIKE customer INCLUDING ALL)
	PARTiTION BY RANGE (c_id);

CREATE TABLE customer_1 PARTITION OF new_customer
	FOR VALUES FROM (1) TO (300);

CREATE TABLE customer_2 PARTITION OF new_customer
	FOR VALUES FROM (300) TO (600);

CREATE TABLE customer_3 PARTITION OF new_customer
	FOR VALUES FROM (600) TO (900);

CREATE TABLE customer_default PARTITION OF new_customer
	DEFAULT;
	
INSERT INTO new_customer SELECT * FROM customer;

BEGIN;
ALTER TABLE customer RENAME TO old_customer;
ALTER TABLE new_customer RENAME TO customer;
COMMIT;

CREATE TABLE new_project (LIKE project INCLUDING ALL)
	PARTiTION BY RANGE (p_id);

CREATE TABLE project_1 PARTITION OF new_project
	FOR VALUES FROM (1) TO (300);

CREATE TABLE project_2 PARTITION OF new_project
	FOR VALUES FROM (300) TO (600);

CREATE TABLE project_3 PARTITION OF new_project
	FOR VALUES FROM (600) TO (900);

CREATE TABLE project_default PARTITION OF new_project
	DEFAULT;
	
INSERT INTO new_project SELECT * FROM project;

BEGIN;
ALTER TABLE project RENAME TO old_project;
ALTER TABLE new_project RENAME TO project;
COMMIT;

