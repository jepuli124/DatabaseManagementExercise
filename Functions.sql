--drop function getProjects;
Create or replace function getProjects(givenDate date) returns table(project_id int, name varchar, budget numeric, commission_percentage numeric, start_date date, end_date date, c_id int, customer_id int, c_name varchar, c_type varchar, phone varchar, email varchar, l_id int)
LANGUAGE plpgsql
AS $$
BEGIN

return query (SELECT * from project inner join customer on project.c_id = customer.c_id where p_end_date > givenDate);

END;
$$;