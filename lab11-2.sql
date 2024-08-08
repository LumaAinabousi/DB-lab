SELECT * FROM employee;

DROP FUNCTION raise_sal;

CREATE FUNCTION raise_sal (e_ssn IN employee.ssn%type, e_dno IN employee.dno%type) RETURN employee.salary%type
IS
   new_sal employee.salary%type;
   max_sal employee.salary%type;
   exc EXCEPTION;
BEGIN 
   SELECT max(salary)
   INTO max_sal
   FROM employee;

   SELECT salary
   INTO new_sal
   FROM employee
   WHERE ssn = e_ssn;

   new_sal := new_sal + e_dno * 10;
   DBMS_OUTPUT.PUT_LINE('New Salary: ' || new_sal || ' ' || max_sal);

   IF new_sal > max_sal THEN
      RAISE exc;
   END IF;

   RETURN new_sal;
EXCEPTION
   WHEN exc THEN
      DBMS_OUTPUT.PUT_LINE('New salary exceeded the max salary.');
END;
/

DECLARE
   my_ssn employee.ssn%type;
   my_dno employee.dno%type;
BEGIN
   my_ssn := 666666600;

   SELECT dno
   INTO my_dno
   FROM employee
   WHERE ssn = my_ssn;

   DBMS_OUTPUT.PUT_LINE('New salary: ' || raise_sal(my_ssn, my_dno));
EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
END;
