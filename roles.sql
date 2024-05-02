
CREATE ROLE admin SUPERUSER;
CREATE ROLE employee;
CREATE ROLE trainee;
CREATE ROLE views_only;


GRANT pg_read_all_data TO employee;
GRANT SELECT ON project, customer, geo_location, project_role TO trainee;

create or replace view traineeView 
as select e_id, emp_name, email from employee;

GRANT SELECT ON traineeView TO trainee;

GRANT SELECT ON employees_on_project, employees_in_department_in_hq, employees_by_skill, customers_by_location, employees_by_group, employees_by_title TO views_only;