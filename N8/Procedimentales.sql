/* Definicion de disparadores */

CREATE OR REPLACE TRIGGER TR_COSTUMERS_BI
BEFORE INSERT ON COSTUMERS
FOR EACH ROW
DECLARE
    temName VARCHAR(100);
BEGIN
    SELECT name INTO temName FROM USERS WHERE (id = :NEW.USERS_id  AND typeId = :NEW.USERS_typeId);
    IF (temName IS null) THEN
        raise_application_error(-20002,'The costumer is not an user');
    END IF;
END TR_COSTUMERS_BI;
/
----------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TR_HOSTERS_BI
BEFORE INSERT ON HOSTERS
FOR EACH ROW
DECLARE
    temName VARCHAR(100);
BEGIN
    SELECT name INTO temName FROM USERS WHERE (id = :NEW.USERS_id  AND typeId = :NEW.USERS_typeId);
    IF (temName IS null) THEN
        raise_application_error(-20002,'The hoster is not an user');
    END IF;
END TR_HOSTERS_BI;
/
----------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TR_BARS_BI
BEFORE INSERT ON BARS
FOR EACH ROW
DECLARE
    temId VARCHAR(100);
BEGIN
    SELECT USERS_id INTO temId FROM HOSTERS WHERE (USERS_id = :NEW.HOSTERS_USERS_id  AND USERS_typeId = :NEW.HOSTERS_USERS_typeId);
    IF (temId IS null) THEN
        raise_application_error(-20002,'The bar is not an hoster');
    END IF;
END TR_HOSTERS_BI;
/
----------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TR_DOCUMENTS_BI
BEFORE INSERT ON DOCUMENTS
FOR EACH ROW
DECLARE
    temNO INTEGER;
BEGIN
    SELECT MAX(DOCUMENT_NO) INTO temNO FROM DOCUMENTS WHERE (USERS_TYPEID = :NEW.USERS_TYPEID AND USERS_ID = :NEW.USERS_ID);
    IF temNO is not null THEN
        :NEW.DOCUMENT_NO := temNO + 1;
    ELSE
        :NEW.DOCUMENT_NO := 1;
    END IF;
END TR_DOCUMENTS_BI;
/
----------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TR_BARS_AI 
AFTER INSERT ON BARS
FOR EACH ROW
BEGIN
    INSERT INTO TIMETABLES VALUES (:NEW.nit,'Mon: 00:00pm-00:00pm');
END TR_BARS_AI;
/
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
-- the reference_code is generated
CREATE OR REPLACE TRIGGER TR_EVENTS_BI
BEFORE INSERT ON EVENTS
FOR EACH ROW
DECLARE 
    value INTEGER;
BEGIN
  SELECT MAX(reference_code) INTO value FROM EVENTS;
  IF value is not null THEN
    :NEW.reference_code :=  value + 1;
  ELSE
    :NEW.reference_code := 1;
  END IF;
END TR_EVENTS_BI;
/
--  the post_no is generated
CREATE OR REPLACE TRIGGER TR_POSTS_BI
BEFORE INSERT ON POSTS
FOR EACH ROW
DECLARE 
    value INTEGER;
BEGIN
  SELECT MAX(post_no) INTO value FROM POSTS;
  IF value is not null THEN
    :NEW.post_no :=  value + 1;
  ELSE
    :NEW.post_no := 1;
  END IF;
END TR_POSTS_BI;
/
-- the reference_number is generated
CREATE OR REPLACE TRIGGER TR_RESERVATIONS_BI
BEFORE INSERT ON RESERVATIONS
FOR EACH ROW
DECLARE 
    value INTEGER;
BEGIN
  SELECT MAX(reference_number) INTO value FROM RESERVATIONS;
  IF value is not null THEN
    :NEW.reference_number :=  value + 1;
  ELSE
    :NEW.reference_number := 1;
  END IF;
END TR_RESERVATIONS_BI;
/
-- the legalStandar_no is generated
CREATE OR REPLACE TRIGGER TR_LEGAL_STANDARS_BI
BEFORE INSERT ON LEGAL_STANDARS
FOR EACH ROW
DECLARE 
    value INTEGER;
BEGIN
  SELECT MAX(legalStandar_no) INTO value FROM LEGAL_STANDARS;
  IF value is not null THEN
    :NEW.legalStandar_no :=  value + 1;
  ELSE
    :NEW.legalStandar_no := 1;
  END IF;
END TR_LEGAL_STANDARS_BI;
/
-- the free priority plan must be well defined

CREATE OR REPLACE TRIGGER TR_POSTS_BI2
BEFORE INSERT ON POSTS
FOR EACH ROW 
BEGIN
IF :new.PRIORITIES_priorityPlan IS NULL THEN
:new.PRIORITIES_priorityPlan := 'Platinum';
END IF;
END TR_POSTS_BI2;
/
-- the None state must be well defined
CREATE OR REPLACE TRIGGER TR_RESERVATIONS_BI2
BEFORE INSERT ON RESERVATIONS
FOR EACH ROW 
BEGIN
IF :new.value IS NULL OR :new.value = 0 OR :new.state = 'None' OR :new.state IS NULL THEN
:new.state := 'None';
:new.value := 0;
END IF;
END TR_RESERVATIONS_BI2;
/
-- just description, restrictions, state, priorityPlan, eventState, prices, discounts and place could be updated.
CREATE OR REPLACE TRIGGER TR_EVENTS_BU
BEFORE UPDATE ON EVENTS
FOR EACH ROW
begin
  IF  (:new.reference_code <> :old.reference_code)  OR (:new.HOSTERS_USERS_typeId <> :old.HOSTERS_USERS_typeId) OR (:new.HOSTERS_USERS_id <> :old.HOSTERS_USERS_id) THEN
    raise_application_error(-20021,'cant modify that atribute');
  END IF;
END TR_EVENTS_BU;
/
CREATE OR REPLACE TRIGGER TR_POSTS_BU
BEFORE UPDATE ON POSTS
FOR EACH ROW
begin
  IF  (:new.post_no <> :old.post_no)  OR (:new.EVENTS_reference_code <> :old.EVENTS_reference_code) THEN
    raise_application_error(-20020,'cant modify that atribute');
  END IF;
END TR_POSTS_BU;
/
CREATE OR REPLACE TRIGGER TR_RESERVATIONS_BU
BEFORE UPDATE ON RESERVATIONS
FOR EACH ROW
begin
  IF  (:new.reference_number <> :old.reference_number)  OR (:new.POSTS_post_no <> :old.POSTS_post_no) THEN
    raise_application_error(-20019,'cant modify that atribute');
  END IF;
END TR_RESERVATIONS_BU;
/
CREATE OR REPLACE TRIGGER TR_PLACES_BU2
BEFORE UPDATE ON PLACES
FOR EACH ROW
begin
  IF  (:new.place_no <> :old.place_no)  OR (:new.EVENTS_reference_code <> :old.EVENTS_reference_code) THEN
    raise_application_error(-20019,'cant modify that atribute');
  END IF;
END TR_PLACES_BU2;
/
CREATE OR REPLACE TRIGGER TR_PRIORITIES_BU
BEFORE UPDATE ON PRIORITIES
FOR EACH ROW
begin
  IF  (:new.priorityPlan <> :old.priorityPlan)  THEN
    raise_application_error(-20018,'cant modify that atribute');
  END IF;
END TR_PRIORITIES_BU;
/
CREATE OR REPLACE TRIGGER TR_LEGAL_STANDARS_BU
BEFORE UPDATE ON LEGAL_STANDARS
FOR EACH ROW
begin
    raise_application_error(-20017,'cant modify that atribute');
END TR_LEGAL_STANDARS_BU;
/
CREATE OR REPLACE TRIGGER TR_CUSTOMERS_BY_POSTS_BU
BEFORE UPDATE ON CUSTOMERS_BY_POSTS
FOR EACH ROW
begin
    raise_application_error(-20015,'cant modify that atribute');
END TR_CUSTOMERS_BY_POSTS_BU;

-- description, restrictions, and place could be updated before the last two days before event date.
/
CREATE OR REPLACE TRIGGER TR_PLACES_BU
BEFORE UPDATE ON PLACES
FOR EACH ROW
DECLARE 
    dif NUMBER;
    actual DATE;
begin
  SELECT sysdate INTO actual FROM dual;
  dif := actual - :old.eventDate;
  IF  (dif >= -1) THEN
    raise_application_error(-20000,'cant update this record, minimum time not reached');
  END IF;
END TR_PLACES_BU;
/
CREATE OR REPLACE TRIGGER TR_EVENTS_BU2
BEFORE UPDATE ON EVENTS
FOR EACH ROW
DECLARE 
    dif NUMBER;
    actual DATE;
    event DATE;
begin
  SELECT sysdate INTO actual FROM dual;
  SELECT eventDate INTO event FROM PLACES WHERE  PLACES.EVENTS_reference_code = :old.reference_code;
  dif := actual - event;
  IF  (dif >= -2) THEN
    raise_application_error(-20013,'cant update this record, minimum time not reached');
  END IF;
END TR_EVENTS_BU2;
/
-- reservations can be carried until completed before the last day of the event date. After there is less than one day left for the event, the reservation becomes accepted.

CREATE OR REPLACE TRIGGER TR_RESERVATIONS_BU2
BEFORE UPDATE ON RESERVATIONS
FOR EACH ROW
DECLARE 
    dif NUMBER;
    actual DATE;
    event DATE;
    code INTEGER;
begin
  SELECT sysdate INTO actual FROM dual;
  SELECT EVENTS_reference_code INTO code FROM POSTS WHERE post_no = :old.POSTS_post_no;
  SELECT eventDate INTO event FROM PLACES WHERE EVENTS_reference_code = code;
  dif := actual - event;
  IF  (dif < -1) AND (:new.state = 'Accepted' OR :old.state = 'Accepted') THEN
    raise_application_error(-20012,'cant update this record right now');
  ELSIF (dif >= -1) AND (:new.state = 'Completed' OR :old.state = 'Completed') THEN
    :new.state := 'Accepted';
  END IF;
END TR_RESERVATIONS_BU2;
/
-- the eventState is Open by default.

CREATE OR REPLACE TRIGGER TR_PLACES_BI
BEFORE INSERT ON PLACES
FOR EACH ROW 
BEGIN
IF :new.eventState IS NULL THEN
:new.eventState := 'Open'; 
END IF;
END TR_PLACES_BI;
/
-- the place_no is generated

CREATE OR REPLACE TRIGGER TR_PLACES_BI2
BEFORE INSERT ON PLACES
FOR EACH ROW
DECLARE 
    value INTEGER;
BEGIN
  SELECT MAX(place_no) INTO value FROM PLACES;
  IF value is not null THEN
    :NEW.place_no :=  value + 1;
  ELSE
    :NEW.place_no := 1;
  END IF;
END TR_PLACES_BI2;
/
-- when registering accepted reservations, if the number of this event causes the venue to reach 100% capacity, the state changes to closed.

CREATE OR REPLACE TRIGGER TR_RESERVATIONS_BI3
BEFORE INSERT ON RESERVATIONS
FOR EACH ROW
DECLARE xstate VARCHAR(10);
xporce INTEGER;
xtemp NUMBER;
xevent INTEGER;
BEGIN
  SELECT COUNT(*) INTO xporce FROM RESERVATIONS WHERE POSTS_post_no= :new.POSTS_post_no AND state= 'Accepted';
  SELECT EVENTS_reference_code INTO xevent FROM POSTS WHERE post_no= :new.POSTS_post_no;
  SELECT capacity INTO xtemp FROM PLACES WHERE EVENTS_reference_code= xevent;
  SELECT eventState INTO xstate FROM PLACES WHERE EVENTS_reference_code= xevent;
  IF xporce >= xtemp OR xstate = 'Closed' THEN
    raise_application_error(-20011, 'maximum capacity reached');
  END IF;
END TR_RESERVATIONS_BI3;
/
-- reservations that exceed event capacity cannot be updated.
/*
CREATE OR REPLACE TRIGGER TR_RESERVATIONS_BU3
BEFORE UPDATE ON RESERVATIONS
FOR EACH ROW
DECLARE xstate VARCHAR(10);
xporce INTEGER;
xtemp NUMBER;
xevent INTEGER;
BEGIN
  SELECT COUNT(*) INTO xporce FROM RESERVATIONS WHERE ((POSTS_post_no= :new.POSTS_post_no) AND (RESERVATIONS.state= 'Accepted')) GROUP BY reference_number;
  SELECT POSTS.EVENTS_reference_code INTO xevent FROM POSTS WHERE POSTS.post_no= :old.POSTS_post_no;
  --SELECT PLACES.capacity INTO xtemp FROM PLACES WHERE PLACES.EVENTS_reference_code= xevent;
  --SELECT PLACES.eventState INTO xstate FROM PLACES WHERE PLACES.EVENTS_reference_code= xevent;
  --IF xporce >= xtemp OR xstate = 'Closed' THEN
  UPDATE PLACES SET eventState= 'Closed' WHERE EVENTS_reference_code= xevent;
  raise_application_error(-20010, 'maximum capacity reached');
  --END IF;
END TR_RESERVATIONS_BU3;
/
*/
-- once a reservation is accepted, it cannot be modified or deleted.

CREATE OR REPLACE TRIGGER TR_RESERVATIONS_BD
BEFORE DELETE ON RESERVATIONS
FOR EACH ROW
DECLARE xstate VARCHAR(10);
BEGIN 
  SELECT state INTO xstate FROM RESERVATIONS WHERE reference_number= :old.reference_number;
  IF xstate = 'Accepted' THEN
    RAISE_APPLICATION_ERROR(-20002,'Cant delete');
  END IF;
END;



/
CREATE OR REPLACE TRIGGER TR_RESERVATIONS_BU4
BEFORE UPDATE ON RESERVATIONS
FOR EACH ROW
DECLARE xstate VARCHAR(15);
BEGIN 
  --SELECT RESERVATIONS.state INTO xstate FROM RESERVATIONS WHERE reference_number= :old.reference_number;
  IF :old.state = 'Accepted' THEN
    RAISE_APPLICATION_ERROR(-20002,'Cant modify');
  END IF;
END TR_RESERVATIONS_BU4;
/
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--the payment_no is generated

CREATE OR REPLACE TRIGGER TR_PAYMENTS_BI
BEFORE INSERT ON PAYMENTS
FOR EACH ROW
DECLARE
    temNO INTEGER;
BEGIN
    SELECT MAX(payment_no) INTO temNO FROM PAYMENTS;
    IF temNO is not null THEN
        :NEW.payment_no := temNO + 1;
    ELSE
        :NEW.payment_no := 1;
    END IF;
END TR_PAYMENTS_BI;
/
-- the order_number  is generated

CREATE OR REPLACE TRIGGER TR_TICKETS_BI
BEFORE INSERT ON TICKETS
FOR EACH ROW
DECLARE
    temNO INTEGER;
BEGIN
    SELECT MAX(order_number) INTO temNO FROM TICKETS;
    IF temNO is not null THEN
        :NEW.order_number := temNO + 1;
    ELSE
        :NEW.order_number := 1;
    END IF;
END TR_TICKETS_BI;
/
--the payment can be for a reservation or a publication, but not both and neither (XOR)

CREATE OR REPLACE TRIGGER TR_PAYMENTS_BI2
BEFORE INSERT ON PAYMENTS
FOR EACH ROW
begin
  IF  ((:NEW.RESERVATIONS_reference_number IS NULL) AND (:NEW.POSTS_post_no IS NULL)) THEN
    raise_application_error(-20010,'A payment must have an item associated');
  END IF;
  IF  ((:NEW.RESERVATIONS_reference_number IS NOT NULL) AND (:NEW.POSTS_post_no IS NOT NULL)) THEN
    raise_application_error(-20010,'A payment must have at least one item associated');
  END IF;
END TR_PAYMENTS_BI2;
/

-- the dates are auto generated

CREATE OR REPLACE TRIGGER TR_PAYMENTS_BI3
BEFORE INSERT ON PAYMENTS
REFERENCING OLD AS OLD NEW AS NEW 
FOR EACH ROW
DECLARE
    actual DATE;
BEGIN
    SELECT TO_DATE(SYSDATE) INTO actual FROM DUAL;
    :NEW.payment_date := actual;
END TR_PAYMENTS_BI3 ;

/

CREATE OR REPLACE TRIGGER TR_TICKETS_BI2
BEFORE INSERT ON TICKETS
REFERENCING OLD AS OLD NEW AS NEW 
FOR EACH ROW
DECLARE
    actual DATE;
BEGIN
    SELECT TO_DATE(SYSDATE) INTO actual FROM DUAL;
    :NEW.ticketDate := actual;
END TR_TICKETS_BI2 ;
/
-- the None state must be well defined*

CREATE OR REPLACE TRIGGER TR_PAYMENTS_BI4
BEFORE INSERT ON PAYMENTS
FOR EACH ROW 
DECLARE
BEGIN
    :new.payment_state := 'None';
END TR_PAYMENTS_BI4;
/
--  only the status of the payment and its date can be updated

CREATE OR REPLACE TRIGGER TR_PAYMENTS_BU
BEFORE UPDATE ON PAYMENTS
FOR EACH ROW
begin
  IF  (:new.payment_no <> :old.payment_no)  OR (:new.bank <> :old.bank) OR (:new.id <> :old.id) OR (:new.RESERVATIONS_reference_number <> :old.RESERVATIONS_reference_number) OR (:new.POSTS_post_no <> :old.POSTS_post_no) THEN
    raise_application_error(-20010,'cant modify that atribute');
  END IF;
END TR_PAYMENTS_BU;

/
-- if the payment status is updated, its date is automatically updated

CREATE OR REPLACE TRIGGER TR_PAYMENTS_AU
BEFORE UPDATE ON PAYMENTS
FOR EACH ROW
DECLARE
    actual DATE;
begin
    SELECT TO_DATE(SYSDATE) INTO actual FROM DUAL;
    --UPDATE PAYMENTS SET :new.payment_date= actual WHERE payment_no= payment_no;
    :new.payment_date := actual;
END TR_PAYMENTS_AU;
/
-- if the payment status is complete, it can no longer be updated

CREATE OR REPLACE TRIGGER TR_PAYMENTS_BU2
BEFORE UPDATE ON PAYMENTS
FOR EACH ROW
DECLARE pstate VARCHAR(10);
BEGIN 
  --SELECT payment_state INTO pstate FROM PAYMENTS WHERE payment_no= :old.payment_no;
  IF :old.payment_state = 'Completed' THEN
    RAISE_APPLICATION_ERROR(-20010,'Cant delete');
  END IF;
END TR_PAYMENTS_BU2;
/
-- if the payment refers to a reservation, the status of the payment can be updated up to 1 day after the date of the event.

CREATE OR REPLACE TRIGGER TR_PAYMENTS_BU3
BEFORE UPDATE ON PAYMENTS
FOR EACH ROW
DECLARE 
    dif NUMBER;
    actual DATE;
    event DATE;
    pnum INTEGER;
    ecod INTEGER;
begin
  SELECT sysdate INTO actual FROM dual;
  SELECT POSTS_post_no INTO pnum FROM RESERVATIONS WHERE RESERVATIONS.reference_number = :old.RESERVATIONS_reference_number;
  SELECT EVENTS_reference_code INTO ecod FROM POSTS WHERE post_no = pnum;
  SELECT eventDate INTO event FROM PLACES WHERE ecod = PLACES.EVENTS_reference_code;
  dif := actual - event;
  IF  (dif > 2) THEN
    raise_application_error(-20010,'cant update this record, maximum time reached');
  END IF;
END TR_PAYMENTS_BU3;
/
-- a completed payment automatically generates a ticket*

CREATE OR REPLACE TRIGGER TR_PAYMENTS_AU2
AFTER UPDATE ON PAYMENTS
FOR EACH ROW
DECLARE
    actual DATE;
    temNO INTEGER;
    torder INTEGER;
    tcodeqr VARCHAR(200);
begin
    IF :new.payment_state = 'Completed' THEN
        SELECT sysdate INTO actual FROM dual;
        SELECT MAX(order_number) INTO temNO FROM TICKETS;
        IF temNO is not null THEN
            torder := temNO + 1;
        ELSE
            torder := 1;
        END IF;
        tcodeqr := TO_CHAR(:old.payment_no)||'.pdf';
        INSERT INTO TICKETS VALUES (torder, tcodeqr, actual, :old.payment_no);
    END IF;
END TR_PAYMENTS_AU2;

/


