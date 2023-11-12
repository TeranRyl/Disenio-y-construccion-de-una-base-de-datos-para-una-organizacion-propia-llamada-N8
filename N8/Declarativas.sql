/* Definición de restricciones para un único atributo (Tipos) */

/*USERS' CRUD*/
ALTER TABLE USERS ADD CONSTRAINT CK_USERS_TTypeId CHECK (typeId IN ('CC', 'CE'));
ALTER TABLE USERS ADD CONSTRAINT CK_USERS_TEmail CHECK (REGEXP_LIKE(email,'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$'));
ALTER TABLE USERS ADD CONSTRAINT CK_USERS_TPassword CHECK (NOT REGEXP_LIKE(password,'^(.{0,7}|[^0-9]*|[^A-Z]*|[^a-z]*|[a-zA-Z0-9]*)$'));
ALTER TABLE USERS ADD CONSTRAINT CK_USERS_TAddress CHECK (REGEXP_LIKE(address,'^(Avenue Street|Street|Avenue|Career|Transversal) {0,1}[0-9]+[A-Z|a-z]*#(Avenue Street|Street|Avenue|Career|Transversal){0,1} {0,1}[0-9]+[A-Z|a-z]*-[0-9]+[A-Z|a-z]*$'));

ALTER TABLE DOCUMENTS ADD CONSTRAINT CK_DOCUMENTS_TDocument CHECK (REGEXP_LIKE(document,'.+pdf$'));

ALTER TABLE TIMETABLES ADD CONSTRAINT CK_TIMETABLES_TTimeTable CHECK (REGEXP_LIKE(timeTable,'((Mon|Tue|Wed|Thu|Fri|Sun|Mon): [0-9]{1,2}:[0-9]{2}(am|pm)-[0-9]{1,2}:[0-9]{2}(am|pm)\s{0,1})+'));

ALTER TABLE QUALIFICATIONS ADD CONSTRAINT CK_EVENTS_score CHECK (score > 0 AND score <=5);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--ALTER TABLE DOCUMENTS DROP CONSTRAINT CK_DOCUMENTS_TDocument;

ALTER TABLE EVENTS ADD CONSTRAINT CK_EVENTS_reference_code CHECK (reference_code > 0);
ALTER TABLE LEGAL_STANDARS ADD CONSTRAINT CK_LEGAL_STANDARS_no CHECK (legalStandar_no > 0);
ALTER TABLE PLACES ADD CONSTRAINT CK_PLACES_place_no CHECK (place_no > 0);
ALTER TABLE POSTS ADD CONSTRAINT CK_POSTS_post_no CHECK(post_no > 0);
ALTER TABLE RESERVATIONS ADD CONSTRAINT CK_RESERVATIONS_referencer CHECK (reference_number > 0);
ALTER TABLE RESERVATIONS ADD CONSTRAINT CK_RESERVATIONS_value CHECK (value >= 0);
ALTER TABLE PRIORITIES ADD CONSTRAINT CK_PRIORITIES_value CHECK (value >= 0);
ALTER TABLE RESERVATIONS ADD CONSTRAINT CK_RESERVATIONS_TState CHECK (state = 'Accepted' OR state = 'In progress' OR state = 'Completed' OR state = 'Cancelled' OR state = 'None');
ALTER TABLE PRIORITIES ADD CONSTRAINT CK_PRIORITIES_TPlan CHECK (priorityPlan = 'Platinum' OR priorityPlan = 'Premium' OR priorityPlan = 'Deluxe');

--ALTER TABLE TICKETS ADD CONSTRAINT CK_TICKETS_TDocument CHECK (code_QR LIKE 'file\\\%' AND code_QR LIKE'%.pdf' AND length(code_QR) >= 12);

ALTER TABLE LEGAL_STANDARS ADD CONSTRAINT CK_LEGAL_STANDARS_TDocument CHECK (REGEXP_LIKE(legalStandar,'.+pdf$'));

ALTER TABLE PLACES ADD CONSTRAINT CK_PLACES_TAddress CHECK (address LIKE 'Avenue Street%' OR address LIKE 'Street%' OR address LIKE 'Avenue%' OR address LIKE 'Career%' OR address LIKE 'Transversal%' AND address LIKE '#' AND address LIKE '%-%');
ALTER TABLE PLACES ADD CONSTRAINT CK_PAYMENTS_TEvent CHECK (eventState = 'Open' OR eventState = 'Closed');



ALTER TABLE TICKETS ADD CONSTRAINT CK_TICKETS_order_number CHECK (order_number > 0);
ALTER TABLE PAYMENTS ADD CONSTRAINT CK_PAYMENTS_TPayment CHECK (payment_state = 'Completed' OR payment_state = 'Requested' OR payment_state = 'Reverse' OR payment_state = 'Failed' OR payment_state = 'None');
ALTER TABLE PAYMENTS ADD CONSTRAINT CK_PAYMENTS_payment_no CHECK (payment_no > 0);
ALTER TABLE TICKETS ADD CONSTRAINT CK_TICKETS_TDocument CHECK (REGEXP_LIKE(code_qr,'.+pdf$'));
