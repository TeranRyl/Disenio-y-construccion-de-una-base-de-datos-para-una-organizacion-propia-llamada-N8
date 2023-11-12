/* Consulta SQL 
   Incluir identificador */
   
-- Consultar los email y telefonos de los usuarios que vivan en la Calle 222 # 34-50.
SELECT email, phone FROM USERS where address = 'Street 222 # 34-50';

-- Consultar los email y telefonos de los usuarios que cuenten con Cedula de Extranjeria.
SELECT email, phone FROM USERS where typeId = 'FID';

SELECT * FROM PAYMENTS;

SELECT SYSDATE-(SELECT eventDate FROM PLACES WHERE  PLACES.EVENTS_reference_code = 1) FROM DUAL;

SELECT SYSDATE-TO_DATE('22/05/22','dd/mm/yy') FROM DUAL;

SELECT TO_DATE('21/05/22','dd/mm/yy')-TO_DATE('22/05/22','dd/mm/yy') FROM DUAL;

SELECT COUNT(*) FROM RESERVATIONS WHERE POSTS_post_no= 1 AND state= 'Accepted';
SELECT POSTS.EVENTS_reference_code FROM POSTS WHERE POSTS.post_no= 1;
SELECT PLACES.capacity FROM PLACES WHERE PLACES.EVENTS_reference_code= 1;
SELECT PLACES.eventState FROM PLACES WHERE PLACES.EVENTS_reference_code= 1;