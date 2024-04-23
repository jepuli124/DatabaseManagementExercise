--CALL salaryBase();
--SELECT emp_name, e_id, salary, base_salary from employee inner join job_title on employee.j_id = job_title.j_id  order by salary


--call temporaryIncrease();
--SELECT emp_name, e_id, contract_end from employee where contract_type = 'Temporary' order by contract_end desc

--call percentSalaryIncrease(0.1111, null);
--SELECT emp_name, e_id, salary, base_salary from employee inner join job_title on employee.j_id = job_title.j_id  order by salary DESC
select * from getProjects((CURRENT_DATE - interval '2' year)::date);
--select * from customer;
--call correctSalary();
--select e_id, emp_name, salary from employee where salary > 3600 order by salary;

--select salary_benefit_value from skills where s_id in (select s_id from employee_skills where e_id = 4238);