SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM works_on;
SELECT * FROM DEPENDENT;
drop procedure print_emp;
/
CREATE OR REPLACE PROCEDURE print_emp
IS
    CURSOR cur IS 
    SELECT e.fname, e.lname, extract(YEAR FROM SYSDATE) - extract(YEAR FROM e.bdate) as age, d.dname, count(distinct w.pno) as nump, count(distinct dep.dependent_name) as numd
    FROM employee e, department d, works_on w, dependent dep
    WHERE e.dno=d.dnumber AND e.ssn=w.essn AND e.ssn=dep.essn
    GROUP BY e.fname, e.lname, e.bdate, d.dname;


   my_fname employee.fname%type;
   my_lname employee.lname%type;
   my_age number;
   my_dname department.dname%type;
   my_nump number;
   my_numd number;
BEGIN
    OPEN cur;
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('FNAME     LNAME     AGE    DEPT NAME     NUM OF PROJ.    NUM OF DEPEN.');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');

    LOOP
        FETCH cur INTO my_fname, my_lname, my_age, my_dname, my_nump, my_numd;
        EXIT WHEN cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(RPAD(my_fname, 8) || '  ' ||RPAD(my_lname, 8) || '  ' ||RPAD(my_age, 5) || '  ' ||RPAD(my_dname, 13) || '  ' ||RPAD(my_nump, 13) || '  ' ||my_numd);
        END LOOP;
    CLOSE cur;
END;
/
execute print_emp;