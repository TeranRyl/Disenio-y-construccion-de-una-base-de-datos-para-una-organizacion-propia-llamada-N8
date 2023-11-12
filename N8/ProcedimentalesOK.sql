--USERS CRUD
/* Ingreso de datos usando la automatización definida en los disparadores. */
INSERT INTO USERS VALUES ('CC','1014282012','Diego','diego@gmail.com','jsaS8sakT0*kkj','Street 15#12-06',3014468752);

/*TR_COSTUMERS_BI*/
INSERT INTO COSTUMERS VALUES ('CC','1014282012');

/*TR_HOSTERS_BI*/
INSERT INTO HOSTERS VALUES ('CC','1014282012');

/*TR_BARS_BI*/
INSERT INTO BARS VALUES ('CC','1014282012',125557,'');

/*TR_BARS_AI*/
SELECT * FROM TIMETABLES;

/*TR_DOCUMENTS_BI*/
INSERT INTO DOCUMENTS(USERS_TYPEID, USERS_ID, DOCUMENT) VALUES ('CC','1014282012','MBDA.pdf');

----------------------------------------------------------------------------------------------------------------------------------------------------------------
--EVENTS CRUD
-- the reference_code is generated
INSERT INTO EVENTS(HOSTERS_USERS_typeId, HOSTERS_USERS_id, restriction, description) VALUES ('CC','1014282012',NULL, 'latin party');

SELECT * FROM EVENTS;
--  the post_no is generated
INSERT INTO PRIORITIES VALUES('Platinum', 0, 0);
SELECT * FROM PRIORITIES;
INSERT INTO POSTS(EVENTS_reference_code, PRIORITIES_priorityPlan) VALUES (1, 'Platinum');
SELECT * FROM POSTS;

-- the place_no is generated / the reference_number is generated / the eventState is Open by default
INSERT INTO PLACES(address, capacity, eventDate, lineUp, gender, eventState, EVENTS_reference_code) VALUES ('Street 85', 150, TO_DATE('29/05/22','dd/mm/yy'), 'Casta', 'Urban', NULL, 1); -- MAS DE 2 DIAS
SELECT * FROM PLACES;
INSERT INTO RESERVATIONS(state, value, discount, POSTS_post_no) VALUES ('None',20000,NULL, '1');
SELECT * FROM RESERVATIONS;

-- the legalStandar_no is generated
INSERT INTO LEGAL_STANDARS(EVENTS_reference_code, legalStandar) VALUES (1, 'latinparty.pdf');
SELECT * FROM LEGAL_STANDARS;

-- the free priority plan must be well defined
INSERT INTO EVENTS(HOSTERS_USERS_typeId, HOSTERS_USERS_id, restriction, description) VALUES ('CC','1014282012',NULL, 'latin party');
INSERT INTO POSTS(EVENTS_reference_code, PRIORITIES_priorityPlan) VALUES (2, NULL);
SELECT * FROM POSTS;

-- the None state must be well defined
INSERT INTO PLACES(address, capacity, eventDate, lineUp, gender, eventState, EVENTS_reference_code) VALUES ('Street 85', 150, TO_DATE('21/05/22','dd/mm/yy'), 'Casta', 'Urban', NULL, 2);  -- MENOS DE 2 DIAS
INSERT INTO RESERVATIONS(state, value, discount, POSTS_post_no) VALUES (NULL,NULL,0, 2);
SELECT * FROM RESERVATIONS;

-- just description, restrictions, state, priorityPlan, eventState, prices, discounts and place could be updated.
--INSERT INTO EVENTS(HOSTERS_USERS_typeId, HOSTERS_USERS_id, restriction, description) VALUES ('CC','1014282012',NULL, 'latin party');
--INSERT INTO PLACES(address, capacity, eventDate, lineUp, gender, eventState, EVENTS_reference_code) VALUES ('Street 85', 150, TO_DATE('2022/05/23','yyyy/mm/dd'), 'Casta', 'Urban', 'Open', 3); 
--INSERT INTO POSTS(EVENTS_reference_code, PRIORITIES_priorityPlan) VALUES (3, NULL);
--INSERT INTO RESERVATIONS(state, value, discount, POSTS_post_no) VALUES (NULL,NULL,0, 3);
UPDATE EVENTS SET reference_code= 100 WHERE reference_code= 1; --MAS DE 2 DIAS

-- description, restrictions, and place could be updated before the last two days before event date.
UPDATE PLACES SET capacity= 100 WHERE place_no= 2; -- MENOS DE 2 DIAS

-- reservations can be carried until completed before the last day of the event date. After there is less than one day left for the event, the reservation becomes accepted.
UPDATE RESERVATIONS SET state= 'Accepted' WHERE reference_number= 1; -- MENOS DE 2 DIAS

-- when registering accepted reservations, if the number of this event causes the venue to reach 100% capacity, the state changes to closed.
INSERT INTO EVENTS(HOSTERS_USERS_typeId, HOSTERS_USERS_id, restriction, description) VALUES ('CC','1014282012',NULL, 'latin new party');
INSERT INTO PLACES(address, capacity, eventDate, lineUp, gender, eventState, EVENTS_reference_code) VALUES ('Street 85', 1, TO_DATE('24/05/22','dd/mm/yy'), 'Casta', 'Urban', NULL, 3); -- MENOS DE 1 DIA
INSERT INTO POSTS(EVENTS_reference_code, PRIORITIES_priorityPlan) VALUES (3, NULL);
INSERT INTO RESERVATIONS(state, value, discount, POSTS_post_no) VALUES (NULL,NULL,0, 3);
UPDATE RESERVATIONS SET state= 'Accepted' WHERE reference_number= 3;-- MENOS DE 2 DIAS
INSERT INTO RESERVATIONS(state, value, discount, POSTS_post_no) VALUES (NULL,NULL,0, 3);
--UPDATE RESERVATIONS SET state= 'Accepted' WHERE reference_number= 4;

-- once a reservation is accepted, it cannot be modified or deleted.
UPDATE RESERVATIONS SET state= 'Cancelled' WHERE reference_number= 3;
----------------------------------------------------------------------------------------------------------------------------------------------------------------
--PAYMENTS CRUD

--the payment_no and date are generated / the None state must be well defined
INSERT INTO PAYMENTS(bank, id, payment_state, RESERVATIONS_reference_number, POSTS_post_no) VALUES ('Itau','100704581',NULL, 3, NULL);
SELECT * FROM PAYMENTS;

--the payment can be for a reservation or a publication, but not both and neither (XOR)
INSERT INTO PAYMENTS(bank, id, payment_state, RESERVATIONS_reference_number, POSTS_post_no) VALUES ('Itau','100704581',NULL, 3, 3);

--  only the status of the payment and its date can be updated
UPDATE PAYMENTS SET payment_no= 2454 WHERE payment_no= 1;

-- if the payment status is updated, its date is automatically updated
UPDATE PAYMENTS SET payment_state= 'Requested' WHERE payment_no= 1;

-- if the payment status is complete, it can no longer be updated /  a completed payment automatically generates a ticket* / the order_number and date are generated
UPDATE PAYMENTS SET payment_state= 'Completed' WHERE payment_no= 1;
SELECT * FROM TICKETS;
UPDATE PAYMENTS SET payment_state= 'Reverse' WHERE payment_no= 1;


-- if the payment refers to a reservation, the status of the payment can be updated up to 1 day after the date of the event.
INSERT INTO PAYMENTS(bank, id, payment_state, RESERVATIONS_reference_number, POSTS_post_no) VALUES ('Davivienda','100704581',NULL, 2, NULL);
UPDATE PAYMENTS SET payment_state= 'Requested' WHERE payment_no= 2; -- MAS DE 2 DIAS DEL EVENTDATE




