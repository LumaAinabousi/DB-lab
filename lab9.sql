“_ORACLE_SCRIPT”=true;
CREATE USER luma_20201090 IDENTIFIED BY my123;

ALTER USER luma_20201090 IDENTIFIED BY my123;

CREATE ROLE clerk;
GRANT CREATE SESSION TO clerk;
GRANT CREATE TABLE TO clerk;
GRANT INSERT ON patient TO clerk;
GRANT UNLIMITED TABLESPACE TO clerk;
GRANT UPDATE(name) ON doctor TO clerk;

GRANT clerk TO luma_20201090;

GRANT DELETE patient TO luma_20201090 WITH GRANT OPTION;

--q2
CREATE USER abc IDENTIFIED BY abc123;
GRANT CREATE SESSION TO abc;

conn abc/abc123
“_ORACLE_SCRIPT”=true;
SELECT * FROM system.doctors;
--I tried connecting to abc and applying a select statement on doctors(hypothetically because i don't have mysqlplus:) ) and it did not work, it showed me that i don't have the privileges.

conn system/manager
“_ORACLE_SCRIPT”=true;
GRANT SELECT ON doctors TO abc;

conn abc/abc123
“_ORACLE_SCRIPT”=true;
SELECT * FROM system.doctors;

conn system/manager
“_ORACLE_SCRIPT”=true;
CREATE PUBLIC SYNONYM docs FOR doctors;

conn abc/abc123
“_ORACLE_SCRIPT”=true;
SELECT * FROM docs;

conn system/manager
“_ORACLE_SCRIPT”=true;
DROP PUBLIC SYNONYM FOR docs;

--q3

DECLARE
ID varchar2(10) := '20201090';
S_NAME varchar2(10) := 'luma';
AGE number;
D_NAME doctor.name%TYPE;
P_NAME patient.first_name%TYPE;
BEGIN
--print name/id

 DBMS_OUTPUT.PUT_LINE('My name is '||S_NAME||' and my id is '|| ID);
  
--calc age
SELECT trunc(months_between(SYSDATE, bdate)/12)
INTO AGE
FROM PATIENT
WHERE FIRST_NAME='areej' AND PATIENT_ID=2;

--doc name
SELECT doctor.name
INTO D_NAME
FROM PATIENT,DOCTOR
WHERE patient.d_id = doctor.id 
AND patient.FIRST_NAME='areej' AND patient.PATIENT_ID=2;

--patient name
SELECT first_name
INTO P_NAME
FROM PATIENT
WHERE PATIENT_ID=2;
  

DBMS_OUTPUT.PUT_LINE(P_NAME||' is '||AGE||' years old and her doctors name is ' || UPPER(D_NAME));
  
END;