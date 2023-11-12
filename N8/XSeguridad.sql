-- Eliminación de paquetes de actores, roles y permisos.

REVOKE ALL ON PC_USER FROM USERR;
REVOKE ALL ON PC_User_Experience_Analyst FROM User_Experience_A;
REVOKE ALL ON PC_Content_Analyst FROM Content_A;
REVOKE ALL ON APROVATION_USER_INDEX FROM User_Experience_A;
REVOKE ALL ON TOP_SCORES FROM User_Experience_A;
REVOKE ALL ON PC_General_Administrator FROM General_Administrat;
----------------------------------------------------------------------------------------------------------------------------------------

DROP PACKAGE BODY PC_QUALIFICATIONS;
DROP PACKAGE PC_QUALIFICATIONS;

DROP PACKAGE BODY PC_USERS;
DROP PACKAGE PC_USERS;

DROP PACKAGE BODY PC_EVENTS;
DROP PACKAGE PC_EVENTS;

DROP PACKAGE BODY PC_PAYMENTS;
DROP PACKAGE PC_PAYMENTS;

----------------------------------------------------------------------------------------------------------------------------------------

DROP PACKAGE BODY PC_USER;
DROP PACKAGE PC_USER;

DROP PACKAGE BODY PC_User_Experience_Analyst;
DROP PACKAGE PC_User_Experience_Analyst;

DROP PACKAGE BODY PC_Content_Analyst;
DROP PACKAGE PC_Content_Analyst;

DROP PACKAGE BODY PC_General_Administrator;
DROP PACKAGE PC_General_Administrator;

----------------------------------------------------------------------------------------------------------------------------------------

DROP ROLE USERR;
DROP ROLE User_Experience_AA;
DROP ROLE Content_A;
DROP ROLE General_Administrat;