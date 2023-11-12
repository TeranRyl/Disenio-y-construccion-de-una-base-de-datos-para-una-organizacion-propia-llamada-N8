/* Creaci�n de tablas */

CREATE TABLE USERS (typeId VARCHAR(3) NOT NULL, id VARCHAR(20) NOT NULL,name VARCHAR(100) NOT NULL, email VARCHAR(100) NOT NULL, password VARCHAR(16) NOT NULL, address VARCHAR(200) NOT NULL, phone INTEGER NOT NULL);
CREATE TABLE DOCUMENTS (document_no INTEGER NOT NULL, USERS_typeId VARCHAR(3) NOT NULL, USERS_id VARCHAR(20) NOT NULL, document VARCHAR(200) NOT NULL);
CREATE TABLE QUALIFICATIONS(USERS_typeIdG VARCHAR(3) NOT NULL, USERS_idG VARCHAR(20) NOT NULL, USERS_typeIdR VARCHAR(3) NOT NULL, USERS_idR VARCHAR(20) NOT NULL, score NUMBER NOT NULL);
CREATE TABLE HOSTERS(USERS_typeId VARCHAR(3) NOT NULL, USERS_id VARCHAR(20) NOT NULL);
CREATE TABLE COSTUMERS(USERS_typeId VARCHAR(3) NOT NULL, USERS_id VARCHAR(20) NOT NULL);
CREATE TABLE EVENTS (reference_code INTEGER NOT NULL, HOSTERS_USERS_typeId VARCHAR (3) NOT NULL, HOSTERS_USERS_id VARCHAR(20) NOT NULL, restriction VARCHAR(100), description VARCHAR(50) NOT  NULL);
CREATE TABLE LEGAL_STANDARS (legalStandar_no INTEGER NOT NULL, EVENTS_reference_code INTEGER NOT NULL, legalStandar VARCHAR(200) NOT NULL);
CREATE TABLE BARS(HOSTERS_USERS_typeId VARCHAR(3) NOT NULL, HOSTERS_USERS_id VARCHAR(20) NOT NULL, nit INTEGER NOT NULL, detail VARCHAR(50));
CREATE TABLE TIMETABLES (BARS_nit INTEGER NOT NULL, timeTable VARCHAR(500) NOT NULL);
CREATE TABLE POSTS (post_no INTEGER NOT NULL, EVENTS_reference_code INTEGER NOT NULL, PRIORITIES_priorityPlan VARCHAR(20));
CREATE TABLE CUSTOMERS_BY_POSTS(COSTUMERS_USERS_typeId VARCHAR(3) NOT NULL, COSTUMERS_USERS_id VARCHAR(20) NOT NULL, POSTS_post_no INTEGER NOT NULL);
CREATE TABLE PRIORITIES(priorityPlan VARCHAR(20) NOT NULL,  value NUMBER, discount INTEGER);
CREATE TABLE RESERVATIONS (reference_number INTEGER NOT NULL, state VARCHAR(10) NOT NULL,  value NUMBER NOT NULL, discount INTEGER, POSTS_post_no INTEGER NOT NULL);
CREATE TABLE PAYMENTS (payment_no INTEGER NOT NULL, bank VARCHAR(20) NOT NULL, id INTEGER NOT NULL, payment_state VARCHAR(10) NOT NULL, payment_date DATE NOT NULL, RESERVATIONS_reference_number INTEGER, POSTS_post_no INTEGER);
CREATE TABLE TICKETS (order_number INTEGER NOT NULL, code_qr VARCHAR(200) NOT NULL, ticketDate DATE NOT NULL, PAYMENTS_payment_no INTEGER NOT NULL);
CREATE TABLE PLACES (place_no INTEGER NOT NULL, address VARCHAR(50) NOT NULL, capacity INTEGER NOT NULL, eventDate DATE NOT NULL, lineUp VARCHAR(100) NOT NULL, gender VARCHAR(20) NOT NULL, eventState VARCHAR(10), EVENTS_reference_code INTEGER NOT NULL);

