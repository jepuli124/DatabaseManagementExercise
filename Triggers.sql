Create or replace function skillChecking() returns trigger
LANGUAGE plpgsql
AS $$
BEGIN

IF (SELECT count(*) FROM skills where skills.skill = new.skill) > 0 THEN RAISE EXCEPTION 'This skill already exists';
END IF;

RETURN NEW;
END;
$$;

Create or replace trigger skillCheck 
before insert on skills
FOR EACH ROW
EXECUTE function skillChecking();

/*
IF (SELECT count(*) FROM Ancestry where Ancestry.eid = new.eid) >= 3 THEN RAISE EXCEPTION 'Offspring already has two parents';
ELSIF (SELECT count(eid) from ancestry where ancestry.eid = new.eid) > 1 AND
(SELECT gender FROM specimen where specimen.eid = (SELECT parent from ancestry where ancestry.eid = new.eid ORDER by ancestry.parent ASC LIMIT 1) LIMIT 1) =
(SELECT gender FROM specimen where specimen.eid = (SELECT parent from ancestry where ancestry.eid = new.eid ORDER by ancestry.parent desc LIMIT 1) LIMIT 1) 
THEN RAISE EXCEPTION 'Offspring already has this gender parent, fix ancestries first.';
--ELSIF 1 = 1 THEN RAISE WARNING 'Offspring already has this gender parent, fix ancestries first';
END IF; */

Create or replace function assignEmployees() returns trigger
LANGUAGE plpgsql
AS $$

DECLARE 

	employee1 integer := (select e_id from employee where employee.e_id in
						  (select d_id from department where department.hid in 
						   (select h_id from headquarters where headquarters.l_id in 
							(select l_id from geo_location where geo_location.l_id > 999 and geo_location.country
							 in (select country from geo_location where geo_location.l_id = (select l_id from customer where customer.c_id = 5))))) limit 1 offset 0);
	employee2 integer := (select e_id from employee where employee.e_id in
						  (select d_id from department where department.hid in 
						   (select h_id from headquarters where headquarters.l_id in 
							(select l_id from geo_location where geo_location.l_id > 999 and geo_location.country
							 in (select country from geo_location where geo_location.l_id = (select l_id from customer where customer.c_id = 5))))) limit 1 offset 1);
	employee3 integer := (select e_id from employee where employee.e_id in
						  (select d_id from department where department.hid in 
						   (select h_id from headquarters where headquarters.l_id in 
							(select l_id from geo_location where geo_location.l_id > 999 and geo_location.country
							 in (select country from geo_location where geo_location.l_id = (select l_id from customer where customer.c_id = 5))))) limit 1 offset 2);
	
BEGIN
/*
RAISE NOTICE '%', (select e_id from employee where employee.e_id in
						  (select d_id from department where department.hid in 
						   (select h_id from headquarters where headquarters.l_id in 
							(select l_id from geo_location where geo_location.l_id > 999 and geo_location.country
							 in (select country from geo_location where geo_location.l_id = (select l_id from customer where customer.c_id = 5)))))); */
	
INSERT INTO project_role (e_id, p_id, prole_start_date) VALUES(employee1, new.p_id, (SELECT CURRENT_DATE));
INSERT INTO project_role (e_id, p_id, prole_start_date) VALUES(employee2, new.p_id, (SELECT CURRENT_DATE));
INSERT INTO project_role (e_id, p_id, prole_start_date) VALUES(employee3, new.p_id, (SELECT CURRENT_DATE));
--RAISE NOTICE ':D';
RETURN NEW;
END;
$$;

Create or replace trigger assignTrigger 
after insert on project
FOR EACH ROW
EXECUTE function assignEmployees();


Create or replace function contractCheck() returns trigger
LANGUAGE plpgsql
AS $$
BEGIN
IF ((SELECT CURRENT_DATE) != new.contract_start) THEN RAISE EXCEPTION 'Contract is invalid, Start date is not today';
ELSIF new.contract_type = 'Temporary' and ((SELECT CURRENT_DATE) + interval '2' year != new.contract_end or new.contract_end IS NULL) THEN RAISE EXCEPTION 'Contract is invalid, Contract should end 2 years from now';
ELSIF new.contract_type != 'Temporary' and new.contract_end IS NOT NULL THEN RAISE EXCEPTION 'Contract is invalid, Contract should not have end';
END IF;
RETURN NEW;
END;
$$;

Create or replace trigger contractTrigger 
before update of contract_type on employee
FOR EACH ROW
EXECUTE function contractCheck();



Create or replace function groupCheck() returns trigger
LANGUAGE plpgsql
AS $$
BEGIN
IF 'HR secretary' = (SELECT title from job_title where job_title.j_id = new.j_id) THEN INSERT INTO employee_user_group(e_id, u_id, eug_join_date) values(new.e_id, 6, (SELECT CURRENT_DATE)); -- u_id 6 = HR group
ELSIF (SELECT title from job_title where job_title.j_id = new.j_id) like '%admin%' THEN INSERT INTO employee_user_group(e_id, u_id, eug_join_date) values(new.e_id, 3, (SELECT CURRENT_DATE)); -- u_id 3 = admin group
ELSE INSERT INTO employee_user_group(e_id, u_id, eug_join_date) values(new.e_id, 9, (SELECT CURRENT_DATE)); -- u_id 9 = employee group
END IF;
RETURN NEW;
END;
$$;

Create or replace trigger groupTrigger 
after insert on employee
FOR EACH ROW
EXECUTE function groupCheck();