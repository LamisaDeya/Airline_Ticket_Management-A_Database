-- create a trigger before delete on a table 

SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER trig1
BEFORE delete ON creadit_card_details
REFERENCING OLD AS o NEW AS n
FOR EACH ROW
BEGIN
delete from passenger where profile_id=:o.profile_id;

END;
/



-- create a trigger after update on a table 


SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER trig2
after update ON flight_details
REFERENCING OLD AS o NEW AS n
FOR EACH ROW
Enable
BEGIN
update flight set flight.SEATS=:n.price/100 where flight_id=:n.flight_id;
END;
/

-- create a trigger after insert into a table 


SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER trig3
after insert ON flight_details
REFERENCING OLD AS o NEW AS n
FOR EACH ROW
Enable
BEGIN
update flight set flight.SEATS=:n.price/100 where flight_id=:n.flight_id;
END;
/