CREATE TABLE employee2 
    AS SELECT fname, lname, ssn, salary
    FROM employee 
    WHERE 1=2; 
ALTER TABLE employee2
ADD (
    salary2 NUMBER,
    dsc varchar2(50) );

SET SERVEROUTPUT ON;
select * from employee;
select * from works_on;
/
DECLARE
   CURSOR records IS SELECT e.fname, e.lname, e.ssn, e.salary, w.hours FROM employee e, works_on w WHERE e.ssn = w.essn;

   my_fname employee.fname%type;
   my_lname employee.lname%type;
   my_ssn employee.ssn%type;
   my_sal employee.salary%type;

   my_sal2 employee2.salary2%type;
   my_dsc employee2.dsc%type;
   my_h works_on.hours%type;

   max_sal employee2.salary2%type;
   max_fname employee.fname%type;
   max_lname employee.lname%type;

BEGIN
    OPEN records;

    LOOP
        FETCH records INTO my_fname, my_lname, my_ssn, my_sal, my_h;
        EXIT WHEN records%NOTFOUND;

        IF my_h > 40 THEN
          my_sal2 := my_sal*1.1;
          my_dsc := 'Good';
        ELSE 
          my_sal2 := my_sal;
          my_dsc := 'Bad';
        END IF;

        INSERT INTO employee2 (fname, lname, ssn, salary, salary2, dsc)
        VALUES (my_fname, my_lname, my_ssn, my_sal, my_sal2, my_dsc);
    END LOOP;
    CLOSE records;
    COMMIT;
 -- Find the employee with the highest salary and print his name and SSN:
        BEGIN
        SELECT fname, lname, salary
        INTO max_fname, max_lname, max_sal --i used it again bc i didnt want to use new vars
        FROM employee
        WHERE ssn = '111997788';

        DBMS_OUTPUT.PUT_LINE('Employee with SSN 111997788: ' || max_fname || ' ' || max_lname || ', sal: ' || max_sal);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN 
            DBMS_OUTPUT.PUT_LINE('Employee not found.');
    END;

EXCEPTION
    WHEN OTHERS THEN ROLLBACK;  
END;

/
select * from employee2;



