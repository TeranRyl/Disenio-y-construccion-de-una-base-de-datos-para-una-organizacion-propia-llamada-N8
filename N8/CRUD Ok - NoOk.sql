/*CRUD OK
Ingreso de datos correctos usando los procedimientos de los paquetes
*/

/*ad_costumer*/
SELECT * FROM USERS;
set serveroutput on; 
-----------------------------------------------------------------------------------------------------------------------------
DECLARE 
    val VARCHAR(100);
BEGIN
    val := PC_USERS.ad_costumer('CC','1014282013','Diego','diegoo@gmail.com','jsaS8sakT0*kj','Street 15#12-06',30144685882);
    DBMS_OUTPUT.PUT_LINE(val);
END;
DECLARE 
    val VARCHAR(100);
BEGIN
    val := PC_USERS.ad_costumer('CC','1014282063','Daniel','dani@gmail.com','jsaS8sakT0*kj','Street 12#12-06',30146685882);
    DBMS_OUTPUT.PUT_LINE(val);
END;
-----------------------------------------------------------------------------------------------------------------------------
DECLARE
    val VARCHAR(100);
BEGIN
    val := PC_USERS.ad_hoster('CC','1014282015','Felipe','felip@gmail.com','jsaS8sAakT0*kj','Avenue Street 15#12-06',30144685682);
    DBMS_OUTPUT.PUT_LINE(val);
END;
-----------------------------------------------------------------------------------------------------------------------------
DECLARE
    val INTEGER;
BEGIN
    val := PC_USERS.ad_bar('CC','1014259013','coolClub','coolClub@gmail.com','jsaS8sakT0*kj','Transversal 15#12-06',30194685882,5656665,'The coolest one','Mon: 6:00pm-11:00pm');
    DBMS_OUTPUT.PUT_LINE(val);
END;
-----------------------------------------------------------------------------------------------------------------------------
DECLARE
    val VARCHAR(100);
BEGIN
    val := PC_USERS.ad_document('CC', '1014259013', 'try.pdf');
    DBMS_OUTPUT.PUT_LINE(val);
END;

SELECT * FROM DOCUMENTS;
-----------------------------------------------------------------------------------------------------------------------------
SELECT * FROM USERS;

BEGIN
    PC_USERS.up_costumer('CC','1014282013','OK','juanio2.0@hotmail.com',null,null,3059985669);
    PC_USERS.up_hoster('CC','1014282015','OK','juani0@hotmail.com',null,null,3074989669);
    PC_USERS.up_bar('5656665','ROK','juanoRito2.0@hotmail.com',null,null,30549856897,'OK');
    pc_users.up_timetable('5656665','Sun: 2:00pm-15:00pm');
END;
-----------------------------------------------------------------------------------------------------------------------------
VARIABLE elCursor REFCURSOR;
EXECUTE :elCursor := PC_USERS.co_costumer('CC', '1014282013'); 
PRINT :elCursor;
EXECUTE :elCursor := PC_USERS.co_hoster('CC', '1014282015'); 
PRINT :elCursor;
EXECUTE :elCursor := PC_USERS.co_bar('5656665'); 
PRINT :elCursor;
EXECUTE :elCursor := PC_USERS.co_document('CC', '1014282013'); 
PRINT :elCursor;
EXECUTE :elCursor := PC_USERS.co_timeTable('5656665'); 
PRINT :elCursor;
-----------------------------------------------------------------------------------------------------------------------------
BEGIN
    PC_USERS.del_user('CC','1014259013');
END;

SELECT * FROM USERS;
-----------------------------------------------------------------------------------------------------------------------------
DECLARE 
    val VARCHAR(100);
BEGIN
    val := PC_QUALIFICATIONS.ad_qualification('CC', '1014282013', 'CC', '1014282063', 4);
    DBMS_OUTPUT.PUT_LINE(val);
END;
-----------------------------------------------------------------------------------------------------------------------------
BEGIN
    PC_QUALIFICATIONS.up_qualification('CC', '1014282013', 'CC', '1014282063', 5);
END;
-----------------------------------------------------------------------------------------------------------------------------
VARIABLE elCursor REFCURSOR;
EXECUTE :elCursor := PC_QUALIFICATIONS.co_qualification('CC', '1014282013', 'CC', '1014282063'); 
PRINT :elCursor;
-----------------------------------------------------------------------------------------------------------------------------
BEGIN
    PC_QUALIFICATIONS.del_qualification('CC', '1014282013', 'CC', '1014282063');
END;
-----------------------------------------------------------------------------------------------------------------------------
BEGIN
    PC_QUALIFICATIONS.del_qualificationsU('CC', '1014282013');
END;
SELECT * FROM QUALIFICATIONS;