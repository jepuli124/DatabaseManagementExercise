
CREATE USER admin SUPERUSER;
CREATE USER employee;
CREATE USER trainee;
CREATE USER views_only;


GRANT pg_read_all_data TO employee;
GRANT SELECT ON project, customer, geo_location, project_role TO trainee;

create or replace view traineeView 
as select e_id, emp_name, email from employee;

GRANT SELECT ON traineeView TO trainee;