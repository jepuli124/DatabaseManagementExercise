ALTER TABLE customer
ALTER COLUMN email SET NOT NULL;

ALTER TABLE project
ALTER COLUMN p_start_date SET NOT NULL;

-- change all salaries from 0 to 1001 to not get errors
UPDATE employee
SET salary = 1001
WHERE salary = 0;

ALTER TABLE employee
ADD CONSTRAINT salary_check CHECK (salary > 1000);








