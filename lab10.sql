--q1
DECLARE
    c number;
BEGIN
    c:=1;
WHILE c<=100 LOOP
    IF MOD(c,2) = 0 THEN DBMS_OUTPUT.PUT_LINE(' '||c);
    END IF;
  c:=c+1;
END LOOP;
END;

--q2 
DECLARE
    CURSOR c1 IS 
    SELECT p.FIRST_NAME, p.LAST_NAME, extract(YEAR FROM SYSDATE) - extract(YEAR FROM p.BDATE), p.GENDER, d.NAME
    FROM patient p, doctor d
    WHERE p.D_ID = d.ID;
my_fname patient.first_name%type;
my_lname patient.last_name%type;
my_age number;
my_gender patient.gender%type;

my_dr doctor.name%type;
BEGIN
    OPEN c1;
    LOOP
      FETCH c1 INTO my_fname, my_lname, my_age, my_gender, my_dr;
      EXIT WHEN c1%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(my_fname||', '||my_lname||', '||my_age||', '||my_gender||', '||my_dr);
    END LOOP;
    
EXCEPTION
    WHEN OTHERS THEN ROLLBACK;
END;

--q3
DECLARE
  CURSOR dcur IS
    SELECT d.d_name, d.amount
    FROM drug d;

  CURSOR acur IS
    SELECT a.status, a.lower_amount, a.upper_amount
    FROM drug_amountstatus a;

  old_amount drug.amount%TYPE;
  new_amount drug.amount%TYPE;
  my_dname drug.d_name%TYPE;

  my_status drug_amountstatus.status%TYPE;
  my_la drug_amountstatus.lower_amount%TYPE;
  my_ua drug_amountstatus.upper_amount%TYPE;



BEGIN
    OPEN dcur;
    OPEN acur;

 LOOP
    FETCH dcur INTO my_dname, old_amount;
    EXIT WHEN dcur%NOTFOUND;

    CLOSE acur;
    OPEN acur;

    LOOP
      FETCH acur INTO my_status, my_la, my_ua;
      EXIT WHEN acur%NOTFOUND;
      IF old_amount BETWEEN my_la AND my_ua THEN
         IF my_status = 'Not Available' THEN
          new_amount := old_amount + 40; --+40
         ELSIF my_status = 'Very Few' THEN
          new_amount := old_amount + 30; --+30
         ELSE
          new_amount := old_amount; 
         END IF;

        DBMS_OUTPUT.PUT_LINE('drug: ' ||my_dname||', old amount: '||old_amount||', new amount: '|| new_amount);

        UPDATE drug 
        SET amount = new_amount 
        WHERE d_name = my_dname;

        EXIT;
      END IF;
    END LOOP;
  END LOOP;
  CLOSE dcur;
  CLOSE acur;
  COMMIT;
END;
/
