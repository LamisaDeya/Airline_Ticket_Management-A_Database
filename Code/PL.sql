-- PL/SQL variable declaration and print value
SET serveroutput ON

DECLARE
  id flight_details.flight_id%type;
  dates flight_details.flight_departure_date%type;
  price flight_details.price%type;
BEGIN
  SELECT flight_id, flight_departure_date, price INTO id, dates, price
  FROM flight_details
  WHERE flight_id = 1 AND flight_departure_date = DATE '2023-04-12';
  
  dbms_output.put_line('id = ' || id || ', date = ' || dates || ', price = ' || price);
END;
/

-- Insert and set default value
SET serveroutput ON

DECLARE
  id flight_details.flight_id%type := 1;
  dates flight_details.flight_departure_date%type := DATE '2023-04-15';
  price flight_details.price%type := 6000;
BEGIN
  INSERT INTO flight_details VALUES (id, dates, price);
END;
/

-- %ROWTYPE
SET serveroutput ON

DECLARE
  flight flight_details%rowtype;
BEGIN
  SELECT flight_id, flight_departure_date, price INTO flight.flight_id, flight.flight_departure_date, flight.price
  FROM flight_details
  WHERE flight_id = 1 AND flight_departure_date = DATE '2023-04-12';
  
  dbms_output.put_line('id = ' || flight.flight_id || ', date = ' || flight.flight_departure_date || ', price = ' || flight.price);
END;
/

-- Insert and set default value using %ROWTYPE
SET serveroutput ON

DECLARE
  flight flight_details%rowtype;
BEGIN
  flight.flight_id := 2;
  flight.flight_departure_date := DATE '2023-04-15';
  flight.price := 5800;
  INSERT INTO flight_details VALUES flight;
END;
/

-- Creating a cursor
SET serveroutput ON

DECLARE
  CURSOR pass_cur IS
    SELECT profile_id, f_name, l_name FROM passenger;
  p_id passenger.profile_id%type;
  f_name passenger.f_name%type;
  l_name passenger.l_name%type;
BEGIN
  OPEN pass_cur;
  FETCH pass_cur INTO p_id, f_name, l_name;
  
  WHILE pass_cur%FOUND LOOP
    dbms_output.put_line(p_id || ' ' || f_name || ' ' || l_name);
    FETCH pass_cur INTO p_id, f_name, l_name;
  END LOOP;
  
  CLOSE pass_cur;
END;
/

-- %ISOPEN, %FOUND, %ROWCOUNT, %NOTFOUND
SET serveroutput ON

DECLARE
  CURSOR pass_cur IS
    SELECT profile_id, f_name, l_name FROM passenger;
  p_id passenger.profile_id%type;
  f_name passenger.f_name%type;
  l_name passenger.l_name%type;
BEGIN
  OPEN pass_cur;
  FETCH pass_cur INTO p_id, f_name, l_name;
  
  WHILE pass_cur%FOUND LOOP
    dbms_output.put_line(p_id || ' ' || f_name || ' ' || l_name);
    FETCH pass_cur INTO p_id, f_name, l_name;
  END LOOP;
  
  IF (pass_cur%NOTFOUND) THEN
    dbms_output.put_line('end');
  ELSE
    dbms_output.put_line('wrong');
  END IF;
  
  dbms_output.put_line('row ' || pass_cur%ROWCOUNT);
  CLOSE pass_cur;
  
  IF (pass_cur%ISOPEN) THEN
    dbms_output.put_line('Cursor is open');
  ELSE
    dbms_output.put_line('Cursor is closed');
  END IF;
END;
/

-- Procedure with parameter type IN
CREATE OR REPLACE PROCEDURE proc(id IN NUMBER) IS
  name passenger.f_name%TYPE;
BEGIN
  SELECT f_name INTO name FROM passenger WHERE passenger.profile_id = id;
  dbms_output.put_line(name);
END;
/

SET serveroutput ON

DECLARE 
  var1 passenger.profile_id%TYPE := 111;
BEGIN
  proc(var1);
END;
/

-- Procedure with parameter type OUT
CREATE OR REPLACE PROCEDURE proc(name OUT passenger.f_name%TYPE) IS
BEGIN
  SELECT f_name INTO name FROM passenger WHERE passenger.profile_id = 111;
END;
/

SET serveroutput ON

DECLARE 
  name passenger.f_name%TYPE;
BEGIN
  proc(name);
  dbms_output.put_line(name);
END;
/

-- Procedure with parameter type IN and OUT
CREATE OR REPLACE PROCEDURE proc(id IN NUMBER, name OUT passenger.f_name%TYPE) IS
BEGIN
  SELECT f_name INTO name FROM passenger WHERE passenger.profile_id = id;
END;
/

SET serveroutput ON

DECLARE 
  name passenger.f_name%TYPE;
  id passenger.profile_id%TYPE;
BEGIN
  id := 111;
  proc(id, name);
  dbms_output.put_line(name);
END;
/

-- Procedure with no parameters
CREATE OR REPLACE PROCEDURE proc IS
  name passenger.f_name%TYPE;
BEGIN
  SELECT f_name INTO name FROM passenger WHERE passenger.profile_id = 111;
  dbms_output.put_line(name);
END;
/

SET serveroutput ON

DECLARE 
BEGIN
  proc();
END;
/

-- Procedure with parameter type IN OUT
CREATE OR REPLACE PROCEDURE proc(name IN passenger.f_name%TYPE, id IN OUT NUMBER) IS
  aa NUMBER;
  b NUMBER;
BEGIN
  SELECT id INTO aa FROM passenger WHERE passenger.f_name = name;
  dbms_output.put_line(aa);
  b := aa + 10;
  dbms_output.put_line(b);
  UPDATE passenger SET profile_id = b WHERE profile_id = aa;
END;
/

SET serveroutput ON

DECLARE 
  name passenger.f_name%TYPE := 'lamisa';
  id passenger.profile_id%TYPE;
BEGIN
  proc(name, id);
END;
/

-- Error showing
SHOW ERRORS PROCEDURE proc;

-- Dropping a procedure
DROP PROCEDURE proc;

-- Function
CREATE OR REPLACE FUNCTION fun(idd IN NUMBER)
RETURN passenger.f_name%TYPE IS
  f_name passenger.f_name%TYPE;
BEGIN
  SELECT f_name INTO f_name FROM passenger WHERE passenger.profile_id = idd;
  RETURN f_name;
END;
/

SET serveroutput ON

DECLARE 
  id passenger.profile_id%TYPE := 111;
BEGIN
  dbms_output.put_line(fun(id));
END;
/

-- Error showing
SHOW ERRORS FUNCTION fun;

-- Dropping a function
DROP FUNCTION fun;

-- If/Else/Loop
SET serveroutput ON

DECLARE
  CURSOR c IS
    SELECT * FROM flight_details;
  avrg NUMBER;
  rec flight_details%ROWTYPE;
BEGIN
  OPEN c;
  FETCH c INTO rec;
  SELECT AVG(price) INTO avrg FROM flight_details;
  
  WHILE c%FOUND LOOP
    IF rec.price < avrg THEN
      dbms_output.put_line('Price is low');
    ELSE
      dbms_output.put_line('Price is high');
    END IF;
    
    FETCH c INTO rec;
  END LOOP;
  
  CLOSE c;
END;
/

