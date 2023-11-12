-- Especificación de los paquetes de actores
CREATE OR REPLACE PACKAGE PC_USER IS
    FUNCTION ad_costumer(nTipeId VARCHAR, nId VARCHAR, nName VARCHAR, nEmal VARCHAR, nPassword VARCHAR, nAddresse VARCHAR, nPhone INTEGER) RETURN VARCHAR;
    FUNCTION ad_hoster(nTipeId VARCHAR, nId VARCHAR, nName VARCHAR, nEmal VARCHAR, nPassword VARCHAR, nAddresse VARCHAR, nPhone INTEGER) RETURN VARCHAR;
    FUNCTION ad_bar(nTipeId VARCHAR, nId VARCHAR, nName VARCHAR, nEmal VARCHAR, nPassword VARCHAR, nAddresse VARCHAR, nPhone INTEGER, nNit INTEGER, nDetail VARCHAR, nTimeTable VARCHAR) RETURN INTEGER;
    FUNCTION ad_document(nTipeId VARCHAR, nId VARCHAR, nDocument VARCHAR) RETURN VARCHAR;
    FUNCTION ad_qualification(nTipeIdG VARCHAR, nIdG VARCHAR, nTipeIdR VARCHAR, nIdR VARCHAR, nScore NUMBER) RETURN VARCHAR;
    
    FUNCTION ad_events(nHOSTERS_USERS_typeId VARCHAR, nHOSTERS_USERS_id VARCHAR, nrestriction VARCHAR, ndescription VARCHAR) RETURN INTEGER;
    FUNCTION ad_posts(nEVENTS_reference_code INTEGER, nPRIORITIES_priorityPlan VARCHAR) RETURN INTEGER;
    FUNCTION ad_reservations(nstate VARCHAR, nvalue NUMBER, ndiscount INTEGER, nPOSTS_post_no INTEGER) RETURN INTEGER;
    FUNCTION ad_legal_standars(nEVENTS_reference_code INTEGER, nlegalStandar VARCHAR) RETURN INTEGER;
    FUNCTION ad_places(naddress VARCHAR, ncapacity INTEGER, neventDate DATE, nlineUp VARCHAR, ngender VARCHAR, neventState VARCHAR, nEVENTS_reference_code INTEGER) RETURN INTEGER;
    
    FUNCTION ad_payment(nbank VARCHAR, nid INTEGER, NRESERVATIONS_reference_number INTEGER, nPOSTS_post_no INTEGER) RETURN INTEGER;
    
    PROCEDURE up_costumer(nTipeId VARCHAR, nId VARCHAR, nName VARCHAR, nEmal VARCHAR, nPassword VARCHAR, nAddresse VARCHAR, nPhone INTEGER);
    PROCEDURE up_hoster(nTipeId VARCHAR, nId VARCHAR, nName VARCHAR, nEmal VARCHAR, nPassword VARCHAR, nAddresse VARCHAR, nPhone INTEGER);
    PROCEDURE up_bar(nNit INTEGER ,nName VARCHAR, nEmal VARCHAR, nPassword VARCHAR, nAddresse VARCHAR, nPhone INTEGER, nDetail VARCHAR);
    PROCEDURE up_timeTable(nNit INTEGER, nTimeTable VARCHAR);
    PROCEDURE up_qualification(nTipeIdG VARCHAR, nIdG VARCHAR, nTipeIdR VARCHAR, nIdR VARCHAR, nScore NUMBER);
    
    PROCEDURE up_restriction(nreference_code INTEGER, nrestriction VARCHAR);
    PROCEDURE up_descriptions(nreference_code INTEGER, ndescription VARCHAR);
    PROCEDURE up_address(nplace_no INTEGER, naddress VARCHAR);
    PROCEDURE up_capacitys(nplace_no INTEGER, ncapacity INTEGER);
    PROCEDURE up_eventDates(nplace_no INTEGER, neventDate DATE);
    PROCEDURE up_lineUps(nplace_no INTEGER, nlineUp VARCHAR);
    PROCEDURE up_genders(nplace_no INTEGER, ngender VARCHAR);
    PROCEDURE up_eventStates(nplace_no INTEGER, neventState VARCHAR);
    PROCEDURE up_states(nreference_number INTEGER, nstate VARCHAR, nvalue NUMBER, ndiscount INTEGER, nPOSTS_post_no INTEGER);
    PROCEDURE up_priorityPlans(npost_no INTEGER, nPRIORITIES_priorityPlan VARCHAR);   
    
    PROCEDURE up_payment(npayment_no INTEGER, npayment_state VARCHAR);
    
    FUNCTION co_costumer(nTipeId VARCHAR, nId VARCHAR) RETURN SYS_REFCURSOR;
    FUNCTION co_hoster(nTipeId VARCHAR, nId VARCHAR) RETURN SYS_REFCURSOR;
    FUNCTION co_bar(nNit INTEGER) RETURN SYS_REFCURSOR;
    FUNCTION co_document(nTipeId VARCHAR, nId VARCHAR) RETURN SYS_REFCURSOR;
    FUNCTION co_timeTable(nNit INTEGER) RETURN SYS_REFCURSOR;
    FUNCTION co_qualification(nTipeIdG VARCHAR, nIdG VARCHAR, nTipeIdR VARCHAR, nIdR VARCHAR) RETURN SYS_REFCURSOR;
    
    FUNCTION co_event RETURN SYS_REFCURSOR;
    FUNCTION co_post RETURN SYS_REFCURSOR;
    FUNCTION co_priority RETURN SYS_REFCURSOR;
    FUNCTION co_reservation RETURN SYS_REFCURSOR;
    FUNCTION co_place RETURN SYS_REFCURSOR;
    FUNCTION co_legalStandar RETURN SYS_REFCURSOR;
    --FUNCTION co_event(nHOSTERS_USERS_id VARCHAR) RETURN SYS_REFCURSOR;
    --FUNCTION co RETURN SYS_REFCURSOR;
    
    FUNCTION co_payment(npayment_no INTEGER) RETURN SYS_REFCURSOR;
    FUNCTION co_ticket(norder_number INTEGER) RETURN SYS_REFCURSOR;    
    
    PROCEDURE del_qualification(nTipeIdG VARCHAR, nIdG VARCHAR, nTipeIdR VARCHAR, nIdR VARCHAR);
    PROCEDURE del_user(nTipeId VARCHAR, nId VARCHAR);
    
    PROCEDURE del_event(nreference_code INTEGER);
    PROCEDURE del_post(npost_no INTEGER);
    PROCEDURE del_reservation(nreference_number INTEGER);
END PC_USER;
/
CREATE OR REPLACE PACKAGE PC_User_Experience_Analyst IS
    FUNCTION co_costumer(nTipeId VARCHAR, nId VARCHAR) RETURN SYS_REFCURSOR;
    FUNCTION co_hoster(nTipeId VARCHAR, nId VARCHAR) RETURN SYS_REFCURSOR;
    FUNCTION co_bar(nNit INTEGER) RETURN SYS_REFCURSOR;
    FUNCTION co_document(nTipeId VARCHAR, nId VARCHAR) RETURN SYS_REFCURSOR;
    FUNCTION co_timeTable(nNit INTEGER) RETURN SYS_REFCURSOR;
    
    FUNCTION co_posts RETURN SYS_REFCURSOR;
END PC_User_Experience_Analyst;
/
CREATE OR REPLACE PACKAGE PC_Content_Analyst IS
    FUNCTION co_costumer(nTipeId VARCHAR, nId VARCHAR) RETURN SYS_REFCURSOR;
    FUNCTION co_hoster(nTipeId VARCHAR, nId VARCHAR) RETURN SYS_REFCURSOR;
    FUNCTION co_bar(nNit INTEGER) RETURN SYS_REFCURSOR;
    
    FUNCTION co_reservations RETURN SYS_REFCURSOR;
END PC_Content_Analyst;
/
CREATE OR REPLACE PACKAGE PC_General_Administrator IS
    FUNCTION co_payments(npayment_no INTEGER) RETURN SYS_REFCURSOR;
    FUNCTION co_tickets(norder_number INTEGER) RETURN SYS_REFCURSOR;
END PC_General_Administrator;
/
-- Implementación de dichos paquetes
CREATE OR REPLACE PACKAGE BODY PC_USER IS
    FUNCTION ad_costumer(nTipeId VARCHAR, nId VARCHAR, nName VARCHAR, nEmal VARCHAR, nPassword VARCHAR, nAddresse VARCHAR, nPhone INTEGER)
    RETURN VARCHAR AS valueR VARCHAR(100);
        BEGIN
            valueR := PC_USERS.ad_costumer(nTipeId, nId, nName, nEmal, nPassword, nAddresse, nPhone);
            RETURN valueR;
        END;
    -------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION ad_hoster(nTipeId VARCHAR, nId VARCHAR, nName VARCHAR, nEmal VARCHAR, nPassword VARCHAR, nAddresse VARCHAR, nPhone INTEGER)
    RETURN VARCHAR AS valueR VARCHAR(200);
        BEGIN
            valueR := PC_USERS.ad_hoster(nTipeId, nId, nName, nEmal, nPassword, nAddresse, nPhone);
            RETURN valueR;
        END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION ad_bar(nTipeId VARCHAR, nId VARCHAR, nName VARCHAR, nEmal VARCHAR, nPassword VARCHAR, nAddresse VARCHAR, nPhone INTEGER, nNit INTEGER, nDetail VARCHAR, nTimeTable VARCHAR)
    RETURN INTEGER AS valueR INTEGER;
        BEGIN
            valueR := PC_USERS.ad_bar(nTipeId, nId, nName, nEmal, nPassword, nAddresse, nPhone, nNit, nDetail, nTimeTable);
            RETURN valueR;
        END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION ad_document(nTipeId VARCHAR, nId VARCHAR, nDocument VARCHAR)
    RETURN VARCHAR AS valueR VARCHAR(100);
        BEGIN
            valueR := PC_USERS.ad_document(nTipeId , nId , nDocument);
            RETURN valueR;
        END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION ad_qualification(nTipeIdG VARCHAR, nIdG VARCHAR, nTipeIdR VARCHAR, nIdR VARCHAR, nScore NUMBER)
    RETURN VARCHAR AS valueR VARCHAR(300);
        BEGIN
            valueR := PC_QUALIFICATIONS.ad_qualification(nTipeIdG, nIdG, nTipeIdR, nIdR, nScore);
            RETURN valueR;
        END;
    -------------------------------------------------------------------------------------------------------------------------------------- 
    FUNCTION ad_events(nHOSTERS_USERS_typeId VARCHAR, nHOSTERS_USERS_id VARCHAR, nrestriction VARCHAR, ndescription VARCHAR)
    RETURN INTEGER AS event INTEGER;
        BEGIN
            event := PC_EVENTS.ad_events(nHOSTERS_USERS_typeId, nHOSTERS_USERS_id, nrestriction, ndescription);
            RETURN event;
        END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION ad_posts(nEVENTS_reference_code INTEGER, nPRIORITIES_priorityPlan VARCHAR)
    RETURN INTEGER AS post INTEGER;
        BEGIN
            post := PC_EVENTS.ad_posts(nEVENTS_reference_code, nPRIORITIES_priorityPlan);
            RETURN post;
        END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION ad_reservations(nstate VARCHAR, nvalue NUMBER, ndiscount INTEGER, nPOSTS_post_no INTEGER)
    RETURN INTEGER AS reservation INTEGER;
        BEGIN
            reservation := PC_EVENTS.ad_reservations(nstate, nvalue, ndiscount, nPOSTS_post_no);
            RETURN reservation;
        END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION ad_legal_standars(nEVENTS_reference_code INTEGER, nlegalStandar VARCHAR)
    RETURN INTEGER AS legalStandar INTEGER;
        BEGIN
            legalStandar := PC_EVENTS.ad_legal_standars(nEVENTS_reference_code, nlegalStandar);
            RETURN legalStandar;
        END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION ad_places(naddress VARCHAR, ncapacity INTEGER, neventDate DATE, nlineUp VARCHAR, ngender VARCHAR, neventState VARCHAR, nEVENTS_reference_code INTEGER)
    RETURN INTEGER AS place INTEGER;
        BEGIN
            place := PC_EVENTS.ad_places(naddress, ncapacity, neventDate, nlineUp, ngender, neventState, nEVENTS_reference_code);
            RETURN place;
        END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION ad_payment(nbank VARCHAR, nid INTEGER, NRESERVATIONS_reference_number INTEGER, nPOSTS_post_no INTEGER)
    RETURN INTEGER AS payments INTEGER;
        BEGIN
            payments := PC_PAYMENTS.ad_payments(nbank, nid, NRESERVATIONS_reference_number, nPOSTS_post_no);
            RETURN payments;
        END;
    --------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE up_costumer(nTipeId VARCHAR, nId VARCHAR, nName VARCHAR, nEmal VARCHAR, nPassword VARCHAR, nAddresse VARCHAR, nPhone INTEGER) AS
    BEGIN
        PC_USERS.up_costumer(nTipeId, nId, nName, nEmal, nPassword, nAddresse, nPhone);
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE up_hoster(nTipeId VARCHAR, nId VARCHAR, nName VARCHAR, nEmal VARCHAR, nPassword VARCHAR, nAddresse VARCHAR, nPhone INTEGER) AS
    BEGIN
        PC_USERS.up_hoster(nTipeId, nId, nName, nEmal, nPassword, nAddresse, nPhone);
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE up_bar(nNit INTEGER ,nName VARCHAR, nEmal VARCHAR, nPassword VARCHAR, nAddresse VARCHAR, nPhone INTEGER, nDetail VARCHAR) AS
    BEGIN
        PC_USERS.up_bar(nNit,nName, nEmal, nPassword, nAddresse, nPhone, nDetail);
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE up_timeTable(nNit INTEGER, nTimeTable VARCHAR) AS
    BEGIN
        PC_USERS.up_timeTable(nNit, nTimeTable);
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE up_qualification(nTipeIdG VARCHAR, nIdG VARCHAR, nTipeIdR VARCHAR, nIdR VARCHAR, nScore NUMBER) AS
    BEGIN
        PC_QUALIFICATIONS.up_qualification(nTipeIdG, nIdG, nTipeIdR, nIdR, nScore);
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE up_restriction(nreference_code INTEGER, nrestriction VARCHAR) AS
    BEGIN
    PC_EVENTS.up_restrictions(nreference_code, nrestriction);
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE up_descriptions(nreference_code INTEGER, ndescription VARCHAR) AS
    BEGIN
    PC_EVENTS.up_description(nreference_code, ndescription);
    END;
     --------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE up_address(nplace_no INTEGER, naddress VARCHAR) AS
    BEGIN
    PC_EVENTS.up_address(nplace_no, naddress);
    END;
     --------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE up_capacitys(nplace_no INTEGER, ncapacity INTEGER) AS
    BEGIN
    PC_EVENTS.up_capacity(nplace_no, ncapacity);
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE up_eventDates(nplace_no INTEGER, neventDate DATE) AS
    BEGIN
    PC_EVENTS.up_eventDate(nplace_no, neventDate);
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE up_lineUps(nplace_no INTEGER, nlineUp VARCHAR) AS
    BEGIN
    PC_EVENTS.up_lineUp(nplace_no, nlineUp);
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE up_genders(nplace_no INTEGER, ngender VARCHAR) AS
    BEGIN
    PC_EVENTS.up_gender(nplace_no, ngender);
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE up_eventStates(nplace_no INTEGER, neventState VARCHAR) AS
    BEGIN
    PC_EVENTS.up_eventState(nplace_no, neventState);
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE up_states(nreference_number INTEGER, nstate VARCHAR, nvalue NUMBER, ndiscount INTEGER, nPOSTS_post_no INTEGER) AS
    BEGIN
    PC_EVENTS.up_state(nreference_number, nstate, nvalue, ndiscount, nPOSTS_post_no);
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE up_priorityPlans(npost_no INTEGER, nPRIORITIES_priorityPlan VARCHAR) AS
    BEGIN
    PC_EVENTS.up_priorityPlan(npost_no, nPRIORITIES_priorityPlan);
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE up_payment(npayment_no INTEGER, npayment_state VARCHAR) AS
    BEGIN
    PC_PAYMENTS.up_payments(npayment_no, npayment_state);
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION co_costumer(nTipeId VARCHAR, nId VARCHAR)
    RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
    BEGIN
        s_cursor := PC_USERS.co_costumer(nTipeId, nId); 
        RETURN s_cursor;
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION co_hoster(nTipeId VARCHAR, nId VARCHAR)
    RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
    BEGIN
        s_cursor := PC_USERS.co_hoster(nTipeId, nId); 
        RETURN s_cursor;
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION co_bar(nNit INTEGER)
    RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
    BEGIN
        s_cursor := PC_USERS.co_bar(nNit); 
        RETURN s_cursor;
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION co_document(nTipeId VARCHAR, nId VARCHAR)
    RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
    BEGIN
        s_cursor := PC_USERS.co_document(nTipeId, nId); 
        RETURN s_cursor;
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION co_timeTable(nNit INTEGER)
    RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
    BEGIN
        s_cursor := PC_USERS.co_timeTable(nNit); 
        RETURN s_cursor;
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION co_qualification(nTipeIdG VARCHAR, nIdG VARCHAR, nTipeIdR VARCHAR, nIdR VARCHAR)
    RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
    BEGIN
        s_cursor := PC_QUALIFICATIONS.co_qualification(nTipeIdG, nIdG, nTipeIdR, nIdR); 
        RETURN s_cursor;
    END;
    ----------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION co_event RETURN SYS_REFCURSOR IS events SYS_REFCURSOR;
    BEGIN
	    events := PC_EVENTS.co_events;
	    RETURN events;
    END;
    ----------------------------------------------------------------------------------------------------------------------------------------
        FUNCTION co_post RETURN SYS_REFCURSOR IS posts SYS_REFCURSOR;
    BEGIN
	    posts := PC_EVENTS.co_post;
	    RETURN posts;
    END;
    ----------------------------------------------------------------------------------------------------------------------------------------
        FUNCTION co_priority RETURN SYS_REFCURSOR IS priorities SYS_REFCURSOR;
    BEGIN
	    priorities := PC_EVENTS.co_priority;
	    RETURN priorities;
    END;
    ----------------------------------------------------------------------------------------------------------------------------------------
        FUNCTION co_reservation RETURN SYS_REFCURSOR IS reservations SYS_REFCURSOR;
    BEGIN
	    reservations := PC_EVENTS.co_reservation;
	    RETURN reservations;
    END;
    ----------------------------------------------------------------------------------------------------------------------------------------
        FUNCTION co_place RETURN SYS_REFCURSOR IS places SYS_REFCURSOR;
    BEGIN
	    places := PC_EVENTS.co_place;
	    RETURN places;
    END;
    ----------------------------------------------------------------------------------------------------------------------------------------
        FUNCTION co_legalStandar RETURN SYS_REFCURSOR IS legalStandars SYS_REFCURSOR;
    BEGIN
	    legalStandars := PC_EVENTS.co_legalStandar;
	    RETURN legalStandars;
    END;
    ----------------------------------------------------------------------------------------------------------------------------------------
        FUNCTION co_payment(npayment_no INTEGER) RETURN SYS_REFCURSOR IS payments SYS_REFCURSOR;
    BEGIN
        payments := PC_PAYMENTS.co_payments(npayment_no);
        RETURN payments;
    END;
    ----------------------------------------------------------------------------------------------------------------------------------------
        FUNCTION co_ticket(norder_number INTEGER) RETURN SYS_REFCURSOR IS tickets SYS_REFCURSOR;
    BEGIN
        tickets := PC_PAYMENTS.co_tickets(norder_number);
        RETURN tickets;
    END;
    /*
    FUNCTION co_event(nHOSTERS_USERS_id VARCHAR) RETURN SYS_REFCURSOR IS events SYS_REFCURSOR;
    BEGIN
	    events := PC_EVENTS.co_event(nHOSTERS_USERS_id);
	    RETURN events;
    END;
    ----------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION co RETURN SYS_REFCURSOR IS event SYS_REFCURSOR;
    BEGIN
	    event := PC_EVENTS.co;
	    RETURN event;
    END;
    */
    ----------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE del_user(nTipeId VARCHAR, nId VARCHAR) AS
    BEGIN
        PC_USERS.del_user(nTipeId, nId);
    END;
    ----------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE del_qualification(nTipeIdG VARCHAR, nIdG VARCHAR, nTipeIdR VARCHAR, nIdR VARCHAR) AS
    BEGIN
        PC_QUALIFICATIONS.del_qualification(nTipeIdG, nIdG, nTipeIdR, nIdR);
    END;
    ----------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE del_event(nreference_code INTEGER) AS
    BEGIN
    PC_EVENTS.del_events(nreference_code);
    END;
    ----------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE del_post(npost_no INTEGER) AS
    BEGIN
    PC_EVENTS.del_posts(npost_no);
    END;
    ----------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE del_reservation(nreference_number INTEGER) AS
    BEGIN
    PC_EVENTS.del_reservations(nreference_number);
    END;
END PC_USER;
/
CREATE OR REPLACE PACKAGE BODY PC_User_Experience_Analyst IS
    FUNCTION co_costumer(nTipeId VARCHAR, nId VARCHAR)
    RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
    BEGIN
        s_cursor := PC_USERS.co_costumer(nTipeId, nId); 
        RETURN s_cursor;
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION co_hoster(nTipeId VARCHAR, nId VARCHAR)
    RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
    BEGIN
        s_cursor := PC_USERS.co_hoster(nTipeId, nId); 
        RETURN s_cursor;
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION co_bar(nNit INTEGER)
    RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
    BEGIN
        s_cursor := PC_USERS.co_bar(nNit); 
        RETURN s_cursor;
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION co_document(nTipeId VARCHAR, nId VARCHAR)
    RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
    BEGIN
        s_cursor := PC_USERS.co_document(nTipeId, nId); 
        RETURN s_cursor;
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION co_timeTable(nNit INTEGER)
    RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
    BEGIN
        s_cursor := PC_USERS.co_timeTable(nNit); 
        RETURN s_cursor;
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION co_posts RETURN SYS_REFCURSOR IS post SYS_REFCURSOR;
    BEGIN
	    post := PC_EVENTS.co_post;
	    RETURN post;
    END;
END PC_User_Experience_Analyst;
/
CREATE OR REPLACE PACKAGE BODY PC_Content_Analyst IS
    FUNCTION co_costumer(nTipeId VARCHAR, nId VARCHAR)
    RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
    BEGIN
        s_cursor := PC_USERS.co_costumer(nTipeId, nId); 
        RETURN s_cursor;
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION co_hoster(nTipeId VARCHAR, nId VARCHAR)
    RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
    BEGIN
        s_cursor := PC_USERS.co_hoster(nTipeId, nId); 
        RETURN s_cursor;
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION co_bar(nNit INTEGER)
    RETURN SYS_REFCURSOR IS s_cursor SYS_REFCURSOR;
    BEGIN
        s_cursor := PC_USERS.co_bar(nNit); 
        RETURN s_cursor;
    END;
    --------------------------------------------------------------------------------------------------------------------------------------
    FUNCTION co_reservations RETURN SYS_REFCURSOR IS reservation SYS_REFCURSOR;
    BEGIN
	    reservation := PC_EVENTS.co_reservation;
	    RETURN reservation;
    END;
END PC_Content_Analyst;
/
CREATE OR REPLACE PACKAGE BODY PC_General_Administrator IS
        FUNCTION co_payments(npayment_no INTEGER) RETURN SYS_REFCURSOR IS payment SYS_REFCURSOR;
    BEGIN
        payment := PC_PAYMENTS.co_payments(npayment_no);
        RETURN payment;
    END;
    ----------------------------------------------------------------------------------------------------------------------------------------
        FUNCTION co_tickets(norder_number INTEGER) RETURN SYS_REFCURSOR IS ticket SYS_REFCURSOR;
    BEGIN
        ticket := PC_PAYMENTS.co_tickets(norder_number);
        RETURN ticket;
    END;
END PC_General_Administrator;
/
/*
DROP PACKAGE BODY PC_USER;
DROP PACKAGE PC_USER;

DROP PACKAGE BODY PC_User_Experience_Analyst;
DROP PACKAGE PC_User_Experience_Analyst;

DROP PACKAGE BODY PC_Content_Analyst;
DROP PACKAGE PC_Content_Analyst;
*/