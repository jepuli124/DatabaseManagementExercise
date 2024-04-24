CREATE VIEW employees_on_project AS
SELECT p.project_name AS project_name, e.emp_name AS employee_name,
p.p_id AS p_id, e.e_id AS e_id
FROM project p, project_role r, employee e
WHERE r.e_id = e.e_id AND r.p_id = p.p_id
ORDER BY p.p_id, employee_name;

CREATE VIEW employees_in_department_in_hq AS
SELECT h.hq_name, d.dep_name, e.emp_name, j.title, e.salary, h.h_id AS h_id, d.d_id AS d_id, e.e_id AS e_id
FROM headquarters h, department d, employee e, job_title j
WHERE e.d_id = d.d_id AND d.hid = h.h_id AND e.j_id = j.j_id
ORDER BY h.hq_name, d.dep_name, e.emp_name, j.title;

CREATE VIEW employees_by_skill AS
SELECT e.emp_name, s.skill, j.title, e.e_id AS e_id, s.s_id AS s_id
FROM employee AS e, employee_skills AS es, skills AS s, job_title AS j
WHERE e.e_id = es.e_id AND s.s_id = es.s_id AND e.j_id = j.j_id
ORDER BY e.emp_name, s.skill;

CREATE VIEW customers_by_location AS
SELECT c.c_name AS customer, g.country AS country, g.city AS city, g.street AS street, c.c_id AS c_id, g.l_id AS l_id
FROM geo_location AS g, customer AS c
WHERE c.l_id = g.l_id
ORDER BY c.c_name, g.country, g.city, g.street;

CREATE VIEW employees_by_group AS
SELECT e.emp_name AS employee, g.group_title AS group, g.group_rights AS rights, e.e_id AS e_id, g.u_id AS u_id 
FROM employee AS e, employee_user_group AS eg, user_group AS g
WHERE e.e_id = eg.e_id AND g.u_id = eg.u_id
ORDER BY e.emp_name, g.group_title, g.group_rights;

CREATE VIEW employees_by_title AS
SELECT e.emp_name AS employee, j.title AS title, e.contract_type AS contract_type, e.salary AS salary,
e.e_id AS e_id, j.j_id AS j_id
FROM employee e, job_title j
WHERE e.j_id = j.j_id
ORDER BY j.j_id, e.j_id;

