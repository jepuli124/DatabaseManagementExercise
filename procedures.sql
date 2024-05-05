Create or replace procedure salaryBase() 
LANGUAGE plpgsql
AS $$
BEGIN

UPDATE employee SET salary = (SELECT base_salary from job_title where job_title.j_id = employee.j_id);

END;
$$;

Create or replace procedure temporaryIncrease() 
LANGUAGE plpgsql
AS $$
BEGIN

UPDATE employee SET contract_end = employee.contract_end + interval '3' month where employee.contract_type = 'Temporary';

END;
$$;


Create or replace procedure percentSalaryIncrease(percentValue numeric, maxiumValue numeric) 
LANGUAGE plpgsql
AS $$
BEGIN

IF (maxiumValue IS NULL or maxiumValue = 0) and percentValue IS NOT NULL THEN UPDATE employee SET salary = salary*(1+(percentValue/100));
ELSIF percentValue IS NOT NULL then UPDATE employee SET salary = salary*(1+(percentValue/100)) where employee.salary < maxiumValue;
END IF;

END;
$$;


Create or replace procedure correctSalary() 
LANGUAGE plpgsql
AS $$
BEGIN
CALL salaryBase();
UPDATE employee SET salary = salary + (SELECT SUM(salary_benefit_value) FROM skills where skills.s_id in (SELECT s_id from employee_skills where employee_skills.e_id = employee.e_id ));

END;
$$;



