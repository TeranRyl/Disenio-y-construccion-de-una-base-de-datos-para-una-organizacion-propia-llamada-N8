--Vistas

CREATE VIEW TOP_SCORES_AUX AS (SELECT typeID,id,name,email,AVG(score) as score 
                                    FROM USERS JOIN QUALIFICATIONS ON (typeID = USERS_typeIDR and id = USERS_idR) 
                                    GROUP BY(typeID,ID,name,email)) ORDER BY score DESC;

CREATE VIEW TOP_SCORES AS SELECT * FROM TOP_SCORES_AUX where rownum <= 100;

CREATE VIEW APROVATION_USER_INDEX AS SELECT AVG(score) as score FROM QUALIFICATIONS;

--SELECT * FROM TOP_SCORES;
--SELECT * FROM APROVATION_USER_INDEX;

cREATE VIEW RESOURCES_CK AS
WITH t1(total_post) AS(
SELECT COUNT(*) AS total_post FROM payments
WHERE POSTS_post_no is not null),
t2(total_resv) AS
(SELECT COUNT (payment_no) AS total_resv FROM payments
WHERE RESERVATIONS_REFERENCE_NUMBER is not null)
SELECT t1.total_post, t2.total_resv, t1.total_post+t2.total_resv AS total FROM t1,t2;


CREATE VIEW CO_DELUXE_POST AS
WITH p1(total_plat) AS
(SELECT COUNT(*) AS total_plat FROM posts
WHERE PRIORITIES_priorityPlan = 'Platinum'),
p2 (total_prem) AS
(SELECT COUNT(*) AS total_prem FROM posts
WHERE PRIORITIES_priorityPlan = 'Premium'),
p3 (total_delux) AS
(SELECT COUNT(*) AS total_delux FROM posts
WHERE PRIORITIES_priorityPlan = 'Deluxe')
SELECT p1.total_plat, p2.total_prem, p3.total_delux, p1.total_plat+p2.total_prem+p3.total_delux AS total FROM p1,p2, p3; 



CREATE VIEW CO_EVENT_RESERVATIONS AS
WITH r1(total_acce) AS
(SELECT COUNT(*) AS total_acce FROM RESERVATIONS
WHERE state = 'Accepted'),
r2 (total_in_pro) AS
(SELECT COUNT(*) AS total_in_pro FROM RESERVATIONS
WHERE state = 'In progress'),
r3 (total_complet) AS
(SELECT COUNT(*) AS total_complet FROM RESERVATIONS
WHERE state = 'Completed'),
r4 (total_cancell) AS
(SELECT COUNT(*) AS total_cancell FROM RESERVATIONS
WHERE state = 'Cancelled')
SELECT r1.total_acce, r2.total_in_pro, r3.total_complet, r4.total_cancell, r1.total_acce+r2.total_in_pro+r3.total_complet+r4.total_cancell  AS total FROM r1,r2, r3, r4;




SELECT * FROM CO_DELUXE_POST;
SELECT * FROM CO_EVENT_RESERVATIONS;


CREATE VIEW CO_EVENTS_ACCEPTED AS
(SELECT EVENTS_reference_code AS EVENTS_reference_code, POSTS_post_no AS POSTS_post_no, COUNT(state) AS ACCEPTED FROM RESERVATIONS JOIN POSTS ON (POSTS.post_no = POSTS_post_no) JOIN EVENTS ON (EVENTS_reference_code = reference_code)
WHERE state = 'Accepted' GROUP BY EVENTS_reference_code, POSTS_post_no);
SELECT * FROM CO_EVENTS_ACCEPTED;





SELECT COUNT(*) AS total_plat FROM posts
WHERE PRIORITIES_priorityPlan = 'Platinum';

SELECT COUNT(*) AS total_premiu FROM posts
WHERE PRIORITIES_priorityPlan = 'Premium';

SELECT COUNT(*) AS total_delux FROM posts
WHERE PRIORITIES_priorityPlan = 'Deluxe';




DROP VIEW TOP_SCORES_AUX CASCADE CONSTRAINT;
DROP VIEW TOP_SCORES CASCADE CONSTRAINT;
DROP VIEW APROVATION_USER_INDEX CASCADE CONSTRAINT;

DROP VIEW RESOURCES_CK CASCADE CONSTRAINT;
DROP VIEW CO_DELUXE_POST CASCADE CONSTRAINT;
DROP VIEW CO_EVENT_RESERVATIONS CASCADE CONSTRAINT;
DROP VIEW CO_EVENTS_ACCEPTED CASCADE CONSTRAINT;