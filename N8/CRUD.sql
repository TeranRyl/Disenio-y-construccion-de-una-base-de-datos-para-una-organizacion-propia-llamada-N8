/* CRUDE
   Especificación de los paquetes de componentes
*/

-- Declaraciones de funciones y procedimientos

--QUALIFICATIONS
CREATE OR REPLACE PACKAGE PC_QUALIFICATIONS AS
    FUNCTION ad_qualification(nTipeIdG VARCHAR, nIdG VARCHAR, nTipeIdR VARCHAR, nIdR VARCHAR, nScore NUMBER) RETURN VARCHAR;
    
    PROCEDURE up_qualification(nTipeIdG VARCHAR, nIdG VARCHAR, nTipeIdR VARCHAR, nIdR VARCHAR, nScore NUMBER);
   
    FUNCTION co_qualification(nTipeIdG VARCHAR, nIdG VARCHAR, nTipeIdR VARCHAR, nIdR VARCHAR) RETURN SYS_REFCURSOR;
   
    PROCEDURE del_qualification(nTipeIdG VARCHAR, nIdG VARCHAR, nTipeIdR VARCHAR, nIdR VARCHAR);
    PROCEDURE del_qualificationsU(nTipeId VARCHAR, nId VARCHAR);
END PC_QUALIFICATIONS;
/
-- USERS
CREATE OR REPLACE PACKAGE PC_USERS AS
    FUNCTION ad_costumer(nTipeId VARCHAR, nId VARCHAR, nName VARCHAR, nEmal VARCHAR, nPassword VARCHAR, nAddresse VARCHAR, nPhone INTEGER) RETURN VARCHAR;
    FUNCTION ad_hoster(nTipeId VARCHAR, nId VARCHAR, nName VARCHAR, nEmal VARCHAR, nPassword VARCHAR, nAddresse VARCHAR, nPhone INTEGER) RETURN VARCHAR;
    FUNCTION ad_bar(nTipeId VARCHAR, nId VARCHAR, nName VARCHAR, nEmal VARCHAR, nPassword VARCHAR, nAddresse VARCHAR, nPhone INTEGER, nNit INTEGER, nDetail VARCHAR, nTimeTable VARCHAR) RETURN INTEGER;
    FUNCTION ad_document(nTipeId VARCHAR, nId VARCHAR, nDocument VARCHAR) RETURN VARCHAR;

    PROCEDURE up_costumer(nTipeId VARCHAR, nId VARCHAR, nName VARCHAR, nEmal VARCHAR, nPassword VARCHAR, nAddresse VARCHAR, nPhone INTEGER);
    PROCEDURE up_hoster(nTipeId VARCHAR, nId VARCHAR, nName VARCHAR, nEmal VARCHAR, nPassword VARCHAR, nAddresse VARCHAR, nPhone INTEGER);
    PROCEDURE up_bar(nNit INTEGER ,nName VARCHAR, nEmal VARCHAR, nPassword VARCHAR, nAddresse VARCHAR, nPhone INTEGER, nDetail VARCHAR);
    PROCEDURE up_timeTable(nNit INTEGER, nTimeTable VARCHAR);
    
    FUNCTION co_costumer(nTipeId VARCHAR, nId VARCHAR) RETURN SYS_REFCURSOR;
    FUNCTION co_hoster(nTipeId VARCHAR, nId VARCHAR) RETURN SYS_REFCURSOR;
    FUNCTION co_bar(nNit INTEGER) RETURN SYS_REFCURSOR;
    FUNCTION co_document(nTipeId VARCHAR, nId VARCHAR) RETURN SYS_REFCURSOR;
    FUNCTION co_timeTable(nNit INTEGER) RETURN SYS_REFCURSOR;
    
    PROCEDURE del_user(nTipeId VARCHAR, nId VARCHAR);
    PROCEDURE del_costumer(nTipeId VARCHAR, nId VARCHAR);
    PROCEDURE del_hoster(nTipeId VARCHAR, nId VARCHAR);
    PROCEDURE del_bar(nNit INTEGER);
END PC_USERS;

/
-- EVENTS
CREATE OR REPLACE PACKAGE PC_EVENTS AS
    FUNCTION ad_events(nHOSTERS_USERS_typeId VARCHAR, nHOSTERS_USERS_id VARCHAR, nrestriction VARCHAR, ndescription VARCHAR) RETURN INTEGER;
    FUNCTION ad_posts(nEVENTS_reference_code INTEGER, nPRIORITIES_priorityPlan VARCHAR) RETURN INTEGER;
    FUNCTION ad_reservations(nstate VARCHAR, nvalue NUMBER, ndiscount INTEGER, nPOSTS_post_no INTEGER) RETURN INTEGER;
    FUNCTION ad_legal_standars(nEVENTS_reference_code INTEGER, nlegalStandar VARCHAR) RETURN INTEGER;
    FUNCTION ad_places(naddress VARCHAR, ncapacity INTEGER, neventDate DATE, nlineUp VARCHAR, ngender VARCHAR, neventState VARCHAR, nEVENTS_reference_code INTEGER) RETURN INTEGER;
    
    PROCEDURE up_restrictions(nreference_code INTEGER, nrestriction VARCHAR);
    PROCEDURE up_description(nreference_code INTEGER, ndescription VARCHAR);
    PROCEDURE up_address(nplace_no INTEGER, naddress VARCHAR);
    PROCEDURE up_capacity(nplace_no INTEGER, ncapacity INTEGER);
    PROCEDURE up_eventDate(nplace_no INTEGER, neventDate DATE);
    PROCEDURE up_lineUp(nplace_no INTEGER, nlineUp VARCHAR);
    PROCEDURE up_gender(nplace_no INTEGER, ngender VARCHAR);
    PROCEDURE up_eventState(nplace_no INTEGER, neventState VARCHAR);
    PROCEDURE up_state(nreference_number INTEGER, nstate VARCHAR, nvalue NUMBER, ndiscount INTEGER, nPOSTS_post_no INTEGER);
    PROCEDURE up_priorityPlan(npost_no INTEGER, nPRIORITIES_priorityPlan VARCHAR);
    
    PROCEDURE del_events(nreference_code INTEGER);
    PROCEDURE del_posts(npost_no INTEGER);
    PROCEDURE del_reservations(nreference_number INTEGER);
    
    FUNCTION co_events RETURN SYS_REFCURSOR;
    FUNCTION co_post RETURN SYS_REFCURSOR;
    FUNCTION co_priority RETURN SYS_REFCURSOR;
    FUNCTION co_reservation RETURN SYS_REFCURSOR;
    FUNCTION co_place RETURN SYS_REFCURSOR;
    FUNCTION co_legalStandar RETURN SYS_REFCURSOR;
    --FUNCTION co_reservations RETURN SYS_REFCURSOR;
    --FUNCTION co_posts RETURN SYS_REFCURSOR;
    --FUNCTION co_event(nHOSTERS_USERS_id VARCHAR) RETURN SYS_REFCURSOR;
    --FUNCTION co RETURN SYS_REFCURSOR;

END PC_EVENTS;
/

-- PAYMENTS
CREATE OR REPLACE PACKAGE PC_PAYMENTS AS

    FUNCTION ad_payments(nbank VARCHAR, nid INTEGER, nRESERVATIONS_reference_number INTEGER, nPOSTS_post_no INTEGER) RETURN INTEGER;
    
    PROCEDURE up_payments(npayment_no INTEGER, npayment_state VARCHAR);
    
    FUNCTION co_payments(npayment_no INTEGER) RETURN SYS_REFCURSOR;
    FUNCTION co_tickets(norder_number INTEGER) RETURN SYS_REFCURSOR;
    
END PC_PAYMENTS;
/

/* CRUDI
   Implementación de los paquetes
*/

-- QUALIFICATIONS
CREATE OR REPLACE PACKAGE BODY PC_QUALIFICATIONS AS
    FUNCTION ad_qualification(nTipeIdG VARCHAR, nIdG VARCHAR, nTipeIdR VARCHAR, nIdR VARCHAR, nScore NUMBER)
    RETURN VARCHAR AS
        BEGIN
            INSERT INTO QUALIFICATIONS VALUES (nTipeIdG, nIdG, nTipeIdR, nIdR, nScore);
            RETURN nTipeIdG||'-'||nIdG||' TO '||nTipeIdR||'-'||nIdR;
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE up_qualification(nTipeIdG VARCHAR, nIdG VARCHAR, nTipeIdR VARCHAR, nIdR VARCHAR, nScore NUMBER) AS
    BEGIN
        UPDATE QUALIFICATIONS SET score = nScore WHERE ( USERS_typeIdG = nTipeIdG and USERS_IdG = nIdG and USERS_typeIdR = nTipeIdR and USERS_IdR = nIdR);
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION co_qualification(nTipeIdG VARCHAR, nIdG VARCHAR, nTipeIdR VARCHAR, nIdR VARCHAR)
    RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
    BEGIN
        OPEN s_cursor FOR
            SELECT *
            FROM QUALIFICATIONS
            WHERE USERS_typeIdG = nTipeIdG and USERS_IdG = nIdG and USERS_typeIdR = nTipeIdR and USERS_IdR = nIdR;
        RETURN s_cursor;
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE del_qualification(nTipeIdG VARCHAR, nIdG VARCHAR, nTipeIdR VARCHAR, nIdR VARCHAR) AS
    BEGIN
        DELETE FROM QUALIFICATIONS WHERE USERS_typeIdG = nTipeIdG and USERS_IdG = nIdG and USERS_typeIdR = nTipeIdR and USERS_IdR = nIdR;
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE del_qualificationsU(nTipeId VARCHAR, nId VARCHAR) AS
    BEGIN
        DELETE FROM QUALIFICATIONS WHERE (USERS_typeIdG = nTipeId and USERS_IdG = nId) or (USERS_typeIdR = nTipeId and USERS_IdR = nId);
    END;
END PC_QUALIFICATIONS;
/
-- USERS
CREATE OR REPLACE PACKAGE BODY PC_USERS AS
    FUNCTION ad_costumer(nTipeId VARCHAR, nId VARCHAR, nName VARCHAR, nEmal VARCHAR, nPassword VARCHAR, nAddresse VARCHAR, nPhone INTEGER)
    RETURN VARCHAR AS
        BEGIN
            INSERT INTO USERS VALUES(nTipeId, nId, nName, nEmal, nPassword, nAddresse, nPhone);
            INSERT INTO COSTUMERS VALUES (nTipeId, nId);
            RETURN nTipeId||'-'||nId;
    EXCEPTION
        WHEN dup_val_on_index THEN
            INSERT INTO COSTUMERS VALUES (nTipeId, nId);
            RETURN nTipeId||'-'||nId;
        END;
    -------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION ad_hoster(nTipeId VARCHAR, nId VARCHAR, nName VARCHAR, nEmal VARCHAR, nPassword VARCHAR, nAddresse VARCHAR, nPhone INTEGER)
    RETURN VARCHAR AS
        BEGIN
            INSERT INTO USERS VALUES(nTipeId, nId, nName, nEmal, nPassword, nAddresse, nPhone);
            INSERT INTO HOSTERS VALUES (nTipeId, nId);
            RETURN nTipeId||'-'||nId;
    EXCEPTION
        WHEN dup_val_on_index THEN
            INSERT INTO HOSTERS VALUES (nTipeId, nId);
            RETURN nTipeId||'-'||nId;
        END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION ad_bar(nTipeId VARCHAR, nId VARCHAR, nName VARCHAR, nEmal VARCHAR, nPassword VARCHAR, nAddresse VARCHAR, nPhone INTEGER, nNit INTEGER, nDetail VARCHAR, nTimeTable VARCHAR)
    RETURN INTEGER AS val VARCHAR(100);
        BEGIN
            val := PC_USERS.ad_hoster(nTipeId, nId, nName, nEmal, nPassword, nAddresse, nPhone);
            INSERT INTO BARS VALUES (nTipeId, nId, nNit, nDetail);
            IF (nTimeTable is not null) THEN
                UPDATE TIMETABLES SET timetable = nTimeTable WHERE bars_nit = nNit;
            END IF;
            RETURN nNit;
    EXCEPTION
        WHEN dup_val_on_index THEN
            INSERT INTO BARS VALUES (nTipeId, nId, nNit, nDetail);
            IF (nTimeTable is not null) THEN
                UPDATE TIMETABLES SET timetable = nTimeTable WHERE bars_nit = nNit;
            END IF;
            RETURN nNit;
        END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION ad_document(nTipeId VARCHAR, nId VARCHAR, nDocument VARCHAR)
    RETURN VARCHAR AS valueR NUMBER;
        BEGIN
            INSERT INTO DOCUMENTS(USERS_TYPEID, USERS_ID, DOCUMENT) VALUES (nTipeId,nId,nDocument);
            SELECT MAX(DOCUMENT_NO) INTO valueR FROM DOCUMENTS WHERE( USERS_TypeId = nTipeId AND USERS_Id = nId);
            RETURN nTipeId||'-'||nId||'-'||TO_CHAR(valueR);
        END;
    --------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE up_costumer(nTipeId VARCHAR, nId VARCHAR, nName VARCHAR, nEmal VARCHAR, nPassword VARCHAR, nAddresse VARCHAR, nPhone INTEGER) AS
    nnTipeId VARCHAR(3);
    nnid VARCHAR(100);
    BEGIN
        SELECT USERS_id INTO nnid FROM costumers WHERE users_id = nId and users_typeid = nTipeId;
        IF (nnid is null) THEN
            raise_application_error(-20002,'Costumer not found');
        END IF;
        IF (nName is not null) THEN
            UPDATE users SET name = nName WHERE (id = nid and typeid = nTipeId);
        END IF;
        IF (nEmal is not null) THEN
            UPDATE users SET email = nEmal WHERE (id = nid and typeid = nTipeId);
        END IF;
        IF (nPassword is not null) THEN
            UPDATE users SET password = nPassword WHERE (id = nid and typeid = nTipeId);
        END IF;
        IF (nAddresse is not null) THEN
            UPDATE users SET Address = nAddresse WHERE (id = nid and typeid = nTipeId);
        END IF;
        IF (nPhone is not null) THEN
            UPDATE users SET Phone = nPhone WHERE (id = nid and typeid = nTipeId);
        END IF;
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE up_hoster(nTipeId VARCHAR, nId VARCHAR, nName VARCHAR, nEmal VARCHAR, nPassword VARCHAR, nAddresse VARCHAR, nPhone INTEGER) AS
    nnTipeId VARCHAR(3);
    nnid VARCHAR(100);
    BEGIN
        SELECT USERS_id INTO nnid FROM HOSTERS WHERE users_id = nId and users_typeid = nTipeId;
        IF (nnid is null) THEN
            raise_application_error(-20002,'Hoster not found');
        END IF;
        IF (nName is not null) THEN
            UPDATE users SET name = nName WHERE (id = nid and typeid = nTipeId);
        END IF;
        IF (nEmal is not null) THEN
            UPDATE users SET email = nEmal WHERE (id = nid and typeid = nTipeId);
        END IF;
        IF (nPassword is not null) THEN
            UPDATE users SET password = nPassword WHERE (id = nid and typeid = nTipeId);
        END IF;
        IF (nAddresse is not null) THEN
            UPDATE users SET Address = nAddresse WHERE (id = nid and typeid = nTipeId);
        END IF;
        IF (nPhone is not null) THEN
            UPDATE users SET Phone = nPhone WHERE (id = nid and typeid = nTipeId);
        END IF;
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE up_bar(nNit INTEGER ,nName VARCHAR, nEmal VARCHAR, nPassword VARCHAR, nAddresse VARCHAR, nPhone INTEGER, nDetail VARCHAR) AS
    nTipeId VARCHAR(3);
    nid VARCHAR(100);
    BEGIN
        SELECT HOSTERS_USERS_id,hosters_users_typeid INTO nid,nTipeId FROM BARS WHERE nit = nNit;
        IF (nid is null) THEN
            raise_application_error(-20002,'Bar not found');
        END IF;
        IF (nName is not null) THEN
            UPDATE users SET name = nName WHERE (id = nid and typeid = nTipeId);
        END IF;
        IF (nEmal is not null) THEN
            UPDATE users SET email = nEmal WHERE (id = nid and typeid = nTipeId);
        END IF;
        IF (nPassword is not null) THEN
            UPDATE users SET password = nPassword WHERE (id = nid and typeid = nTipeId);
        END IF;
        IF (nAddresse is not null) THEN
            UPDATE users SET Address = nAddresse WHERE (id = nid and typeid = nTipeId);
        END IF;
        IF (nPhone is not null) THEN
            UPDATE users SET Phone = nPhone WHERE (id = nid and typeid = nTipeId);
        END IF;
        IF (nDetail is not null) THEN
            UPDATE bars SET detail = ndetail WHERE (nit=nnit);
        END IF;
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE up_timeTable(nNit INTEGER, nTimeTable VARCHAR) AS
    BEGIN
        IF (nTimeTable is not null) THEN
            UPDATE timeTables SET TimeTable = nTimeTable WHERE (bars_nit = nNit);
        END IF;
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION co_costumer(nTipeId VARCHAR, nId VARCHAR)
    RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
    BEGIN
        OPEN s_cursor FOR
            SELECT *
            FROM users JOIN costumers ON (costumers.users_id = users.id and costumers.users_typeid = users.typeid)
            WHERE costumers.users_id = nId and costumers.users_typeid =nTipeId;
        RETURN s_cursor;
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION co_hoster(nTipeId VARCHAR, nId VARCHAR)
    RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
    BEGIN
        OPEN s_cursor FOR
            SELECT *
            FROM users JOIN hosters ON (hosters.users_id = users.id and hosters.users_typeid = users.typeid)
            WHERE hosters.users_id = nId and hosters.users_typeid = nTipeId;
        RETURN s_cursor;
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION co_bar(nNit INTEGER)
    RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
    BEGIN
        OPEN s_cursor FOR
            SELECT *
            FROM users JOIN hosters ON (hosters.users_id = users.id and hosters.users_typeid = users.typeid)
                       JOIN bars ON (bars.hosters_users_id = hosters.users_id and bars.hosters_users_typeid = hosters.users_typeid)
            WHERE bars.nit = nNit;
        RETURN s_cursor;
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION co_document(nTipeId VARCHAR, nId VARCHAR)
    RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
    BEGIN
        OPEN s_cursor FOR
            SELECT *
            FROM documents
            WHERE documents.users_id = nId and documents.users_typeid = nTipeId;
        RETURN s_cursor;
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION co_timeTable(nNit INTEGER)
    RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
    BEGIN
        OPEN s_cursor FOR
            SELECT *
            FROM timetables
            WHERE timetables.bars_nit = nNit;
        RETURN s_cursor;
    END;
    ----------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE del_bar(nNit INTEGER) AS
    BEGIN
        DELETE FROM timetables WHERE timetables.bars_nit = nNit;
    END;
    ----------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE del_hoster(nTipeId VARCHAR, nId VARCHAR) AS
    temNit INTEGER;
    BEGIN
        SELECT nit INTO temNit FROM BARS WHERE hosters_users_id = nId and hosters_users_typeid = nTipeId;
        pc_users.del_bar(temNit);
        DELETE FROM HOSTERS WHERE users_id = nId and users_typeid = nTipeId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('');
    END;
    ----------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE del_costumer(nTipeId VARCHAR, nId VARCHAR) AS
    BEGIN
        DELETE FROM COSTUMERS WHERE users_id = nTipeId and users_typeid = nId;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('');
    END;
    ----------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE del_user(nTipeId VARCHAR, nId VARCHAR) AS
    BEGIN
        DELETE FROM DOCUMENTS WHERE users_id = nId and users_typeid = nTipeId;
        pc_users.del_costumer(nTipeId, nId);
        pc_users.del_hoster(nTipeId, nId);
        DELETE FROM users WHERE id = nId and typeid = nTipeId;
        PC_QUALIFICATIONS.del_qualificationsU(nTipeId, nId);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('');
    END;
END PC_USERS;
/
-- EVENTS
CREATE OR REPLACE PACKAGE BODY PC_EVENTS AS
    FUNCTION ad_events(nHOSTERS_USERS_typeId VARCHAR, nHOSTERS_USERS_id VARCHAR, nrestriction VARCHAR, ndescription VARCHAR)
    RETURN INTEGER  IS temp INTEGER;
        BEGIN
            INSERT INTO EVENTS (HOSTERS_USERS_typeId ,HOSTERS_USERS_id ,restriction ,description) VALUES (nHOSTERS_USERS_typeId ,nHOSTERS_USERS_id ,nrestriction ,ndescription);
            SELECT MAX(reference_code) INTO temp FROM EVENTS;
            RETURN temp;
        END;
    -------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION ad_posts(nEVENTS_reference_code INTEGER, nPRIORITIES_priorityPlan VARCHAR)
    RETURN INTEGER IS temp INTEGER;
        BEGIN
            INSERT INTO POSTS (EVENTS_reference_code,PRIORITIES_priorityPlan) VALUES(nEVENTS_reference_code, nPRIORITIES_priorityPlan);
            SELECT MAX(post_no) INTO temp FROM POSTS;
            RETURN temp;
        END;
    -------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ad_reservations(nstate VARCHAR, nvalue NUMBER, ndiscount INTEGER, nPOSTS_post_no INTEGER)
   RETURN INTEGER IS temp INTEGER;
        BEGIN
            INSERT INTO RESERVATIONS (state ,value ,discount ,POSTS_post_no) VALUES (nstate ,nvalue ,ndiscount ,nPOSTS_post_no);
            SELECT MAX(reference_number) INTO temp FROM RESERVATIONS;
            RETURN temp;
        END;    
    -------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ad_legal_standars(nEVENTS_reference_code INTEGER, nlegalStandar VARCHAR)
   RETURN INTEGER IS temp INTEGER;
        BEGIN
            INSERT INTO LEGAL_STANDARS (EVENTS_reference_code, legalStandar) VALUES (nEVENTS_reference_code ,nlegalStandar);
            SELECT MAX(legalStandar_no) INTO temp FROM LEGAL_STANDARS;
            RETURN temp;
        END;    
    -------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ad_places(naddress VARCHAR, ncapacity INTEGER, neventDate DATE, nlineUp VARCHAR, ngender VARCHAR, neventState VARCHAR, nEVENTS_reference_code INTEGER)
   RETURN INTEGER IS temp INTEGER;
        BEGIN
            INSERT INTO PLACES (address ,capacity ,eventDate ,lineUp, gender, eventState, EVENTS_reference_code) VALUES (naddress ,ncapacity ,neventDate ,nlineUp, ngender, neventState, nEVENTS_reference_code);
            SELECT MAX(place_no) INTO temp FROM PLACES;
            RETURN temp;
        END;
    -------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE up_restrictions(nreference_code INTEGER, nrestriction VARCHAR) AS 
	   BEGIN 
		  UPDATE EVENTS  SET restriction  =  nrestriction  WHERE   reference_code = nreference_code;
	   COMMIT; 
	   EXCEPTION
		  WHEN OTHERS THEN 
		   ROLLBACK;
		   RAISE_APPLICATION_ERROR(-20005,'Cant update');
	END;
    -------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE up_description(nreference_code INTEGER, ndescription VARCHAR) AS 
	   BEGIN 
		  UPDATE EVENTS  SET description  =  ndescription  WHERE   reference_code = nreference_code;
	   COMMIT; 
	   EXCEPTION
		  WHEN OTHERS THEN 
		   ROLLBACK;
		   RAISE_APPLICATION_ERROR(-20004,'Cant update');
	END;
    -------------------------------------------------------------------------------------------------------------------------------------
 	PROCEDURE up_address(nplace_no INTEGER, naddress VARCHAR) AS 
	   BEGIN 
		  UPDATE PLACES  SET address  =  naddress  WHERE   place_no = nplace_no;
	   COMMIT; 
	   EXCEPTION
		  WHEN OTHERS THEN 
		   ROLLBACK;
		   RAISE_APPLICATION_ERROR(-20003,'Cant update');
	END;
    -------------------------------------------------------------------------------------------------------------------------------------
 	PROCEDURE up_capacity(nplace_no INTEGER, ncapacity INTEGER) AS 
	   BEGIN 
		  UPDATE PLACES  SET capacity  =  ncapacity  WHERE   place_no = nplace_no;
	   COMMIT; 
	   EXCEPTION
		  WHEN OTHERS THEN 
		   ROLLBACK;
		   RAISE_APPLICATION_ERROR(-20002,'Cant update');
	END;
    -------------------------------------------------------------------------------------------------------------------------------------
 	PROCEDURE up_eventDate(nplace_no INTEGER, neventDate DATE) AS 
	   BEGIN 
		  UPDATE PLACES  SET eventDate  =  neventDate  WHERE   place_no = nplace_no;
	   COMMIT; 
	   EXCEPTION
		  WHEN OTHERS THEN 
		   ROLLBACK;
		   RAISE_APPLICATION_ERROR(-20001,'Cant update');
	END;
    -------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE up_lineUp(nplace_no INTEGER, nlineUp VARCHAR) AS 
	   BEGIN 
		  UPDATE PLACES  SET lineUp  =  nlineUp  WHERE   place_no = nplace_no;
	   COMMIT; 
	   EXCEPTION
		  WHEN OTHERS THEN 
		   ROLLBACK;
		   RAISE_APPLICATION_ERROR(-20000,'Cant update');
	END;
    -------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE up_gender(nplace_no INTEGER, ngender VARCHAR) AS 
	   BEGIN 
		  UPDATE PLACES  SET gender  =  ngender  WHERE   place_no = nplace_no;
	   COMMIT; 
	   EXCEPTION
		  WHEN OTHERS THEN 
		   ROLLBACK;
		   RAISE_APPLICATION_ERROR(-20002,'Cant update');
	END;
   -------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE up_eventState(nplace_no INTEGER, neventState VARCHAR) AS 
	   BEGIN 
		  UPDATE PLACES  SET eventState  =  neventState  WHERE   place_no = nplace_no;
	   COMMIT; 
	   EXCEPTION
		  WHEN OTHERS THEN 
		   ROLLBACK;
		   RAISE_APPLICATION_ERROR(-20002,'Cant update');
	END;
    -------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE up_state(nreference_number INTEGER, nstate VARCHAR, nvalue NUMBER, ndiscount INTEGER, nPOSTS_post_no INTEGER) AS 
	   BEGIN 
		  UPDATE RESERVATIONS  SET state  =  nstate, value = nvalue, discount = ndiscount, POSTS_post_no = nPOSTS_post_no WHERE reference_number = nreference_number;
	   COMMIT; 
	   EXCEPTION
		  WHEN OTHERS THEN 
		   ROLLBACK;
		   RAISE_APPLICATION_ERROR(-20002,'Cant update');
	END;
    -------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE up_priorityPlan(npost_no INTEGER, nPRIORITIES_priorityPlan VARCHAR) AS 
	   BEGIN 
		  UPDATE POSTS  SET PRIORITIES_priorityPlan  =  nPRIORITIES_priorityPlan  WHERE   post_no = npost_no;
	   COMMIT; 
	   EXCEPTION
		  WHEN OTHERS THEN 
		   ROLLBACK;
		   RAISE_APPLICATION_ERROR(-20002,'Cant update');
	END;
    -------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE del_events(nreference_code INTEGER) AS 
    BEGIN
      DELETE FROM  EVENTS WHERE nreference_code = reference_code;
      DELETE FROM  POSTS WHERE nreference_code = EVENTS_reference_code;
      DELETE FROM  PLACES WHERE nreference_code = EVENTS_reference_code;
      DELETE FROM  LEGAL_STANDARS WHERE nreference_code = EVENTS_reference_code;
      COMMIT;
      EXCEPTION 
      WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20002, 'Cant delete');
    END;
    -------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE del_posts(npost_no INTEGER) AS 
    BEGIN
      DELETE FROM  POSTS WHERE npost_no = post_no;
      DELETE FROM  RESERVATIONS WHERE npost_no = POSTS_post_no;
      DELETE FROM  CUSTOMERS_BY_POSTS WHERE npost_no = POSTS_post_no;
      COMMIT;
      EXCEPTION 
      WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20002, 'Cant delete');
    END;
    -------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE del_reservations(nreference_number INTEGER) AS
    BEGIN
      DELETE FROM  RESERVATIONS WHERE nreference_number = Nreference_number;
      COMMIT;
      EXCEPTION 
      WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20002, 'Cant delete');
    END;
    -------------------------------------------------------------------------------------------------------------------------------------
    	FUNCTION co_events RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
	BEGIN
	OPEN s_cursor  FOR
		SELECT * FROM EVENTS;
	RETURN s_cursor;
	END;
    -------------------------------------------------------------------------------------------------------------------------------------
        FUNCTION co_post RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
	BEGIN
	OPEN s_cursor  FOR
		SELECT * FROM POSTS;
	RETURN s_cursor;
	END;
    -------------------------------------------------------------------------------------------------------------------------------------
        FUNCTION co_reservation RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
	BEGIN
	OPEN s_cursor  FOR
		SELECT * FROM RESERVATIONS;
	RETURN s_cursor;
	END;
    -------------------------------------------------------------------------------------------------------------------------------------
        FUNCTION co_priority RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
	BEGIN
	OPEN s_cursor  FOR
		SELECT * FROM PRIORITIES;
	RETURN s_cursor;
	END;
    -------------------------------------------------------------------------------------------------------------------------------------
        FUNCTION co_place RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
	BEGIN
	OPEN s_cursor  FOR
		SELECT * FROM PLACES;
	RETURN s_cursor;
	END;
    -------------------------------------------------------------------------------------------------------------------------------------
        FUNCTION co_legalStandar RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
	BEGIN
	OPEN s_cursor  FOR
		SELECT * FROM LEGAL_STANDARS;
	RETURN s_cursor;
	END;
    -------------------------------------------------------------------------------------------------------------------------------------
    /*
    	FUNCTION co_reservations RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
	BEGIN
	OPEN s_cursor  FOR
		SELECT * FROM RESERVATIONS;
	RETURN s_cursor;
	END;
    -------------------------------------------------------------------------------------------------------------------------------------
        FUNCTION co_posts RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
	BEGIN
	OPEN s_cursor  FOR
		SELECT * FROM POSTS;
	RETURN s_cursor;
	END;
    -------------------------------------------------------------------------------------------------------------------------------------
        FUNCTION co_event(nHOSTERS_USERS_id VARCHAR) RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
    BEGIN
    OPEN s_cursor  FOR
		SELECT * FROM EVENTS
        WHERE HOSTERS_USERS_id = nHOSTERS_USERS_id;
	RETURN s_cursor;
	END;
    -------------------------------------------------------------------------------------------------------------------------------------
        FUNCTION co RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
	BEGIN
	OPEN s_cursor  FOR
		SELECT post_no, EVENTS_reference_code, COUNT(*) A FROM POSTS JOIN RESERVATIONS ON (POSTS_post_no = post_no)
        WHERE state = 'Accepted'
        GROUP BY post_no, EVENTS_reference_code
        ORDER BY A DESC;
	RETURN s_cursor;
	END;
    */
END PC_EVENTS;
/
-- PAYMENTS
CREATE OR REPLACE PACKAGE BODY PC_PAYMENTS AS
    FUNCTION ad_payments(nbank VARCHAR, nid INTEGER, nRESERVATIONS_reference_number INTEGER, nPOSTS_post_no INTEGER)
    RETURN INTEGER  IS temp INTEGER;
        BEGIN
            INSERT INTO PAYMENTS (bank ,id ,RESERVATIONS_reference_number ,POSTS_post_no) VALUES (nbank ,nid ,nRESERVATIONS_reference_number ,nPOSTS_post_no);
            SELECT MAX(payment_no) INTO temp FROM PAYMENTS;
            RETURN temp;
        END;
   -------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE up_payments(npayment_no INTEGER, npayment_state VARCHAR) AS 
	   BEGIN 
		  UPDATE PAYMENTS  SET payment_state  =  npayment_state  WHERE   payment_no = npayment_no;
	   COMMIT; 
	   EXCEPTION
		  WHEN OTHERS THEN 
		   ROLLBACK;
		   RAISE_APPLICATION_ERROR(-20002,'Cant update');
	END;
    -------------------------------------------------------------------------------------------------------------------------------------
        FUNCTION co_payments(npayment_no INTEGER) RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
	BEGIN
	OPEN s_cursor  FOR
		SELECT * FROM PAYMENTS WHERE payment_no = npayment_no;
	RETURN s_cursor;
	END;
    -------------------------------------------------------------------------------------------------------------------------------------
        FUNCTION co_tickets(norder_number INTEGER) RETURN SYS_REFCURSOr IS s_cursor SYS_REFCURSOR;
	BEGIN
	OPEN s_cursor  FOR
		SELECT * FROM TICKETS WHERE order_number = norder_number;
	RETURN s_cursor;
	END;
    
END PC_PAYMENTS;
/
-------------------------------------------------------------------------------------------------
--XCRUD
/*
DROP PACKAGE BODY PC_QUALIFICATIONS;
DROP PACKAGE PC_QUALIFICATIONS;

DROP PACKAGE BODY PC_USERS;
DROP PACKAGE PC_USERS;

DROP PACKAGE BODY PC_EVENTS;
DROP PACKAGE PC_EVENTS;
*/