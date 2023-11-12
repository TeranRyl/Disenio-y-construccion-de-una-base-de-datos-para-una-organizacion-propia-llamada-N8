-- Definición de roles

CREATE ROLE USERR;
CREATE ROLE User_Experience_AA;
CREATE ROLE Content_A;
CREATE ROLE General_Administrat;

-- Definicion de permisos
GRANT EXECUTE 
ON PC_USER TO USERR;

GRANT EXECUTE 
ON PC_USER_Experience_Analyst TO User_Experience_AA;

GRANT SELECT 
ON APROVATION_USER_INDEX TO User_Experience_AA;

GRANT SELECT 
ON TOP_SCORES TO Content_A;

GRANT EXECUTE 
ON PC_Content_Analyst TO Content_A;

GRANT EXECUTE 
ON PC_General_Administrator TO General_Administrat;
