--PROCEDURE TO DELETE USERS
CREATE OR REPLACE PROCEDURE DELETE_USER
IS
    V_COUNTER NUMBER := 0;
    CURRENT_USER VARCHAR(10);
    EX_INCORRECT_USER EXCEPTION;
    EX_USER_NOT_DROPPED EXCEPTION;
BEGIN
    SELECT USER INTO CURRENT_USER FROM DUAL;
    IF (CURRENT_USER <> 'ADMIN') THEN
        RAISE EX_INCORRECT_USER;
    END IF;
    
        SELECT COUNT(*) INTO V_COUNTER FROM ALL_USERS WHERE USERNAME = 'APPADMIN';
            IF V_COUNTER > 0 THEN  
            DBMS_OUTPUT.PUT_LINE('appadmin dropped');
                EXECUTE IMMEDIATE 'DROP   USER   APPADMIN   CASCADE'; 
            ELSE RAISE EX_USER_NOT_DROPPED;
            END IF; 
        
        SELECT COUNT(*) INTO V_COUNTER FROM ALL_USERS WHERE USERNAME = 'APPCUSTOMERSERVICE';
            IF V_COUNTER > 0 THEN          
                EXECUTE IMMEDIATE 'DROP USER APPCUSTOMERSERVICE CASCADE';  
                DBMS_OUTPUT.PUT_LINE('appcustomerservice dropped');
            ELSE RAISE EX_USER_NOT_DROPPED;
            END IF; 
            
        SELECT COUNT(*) INTO V_COUNTER FROM ALL_USERS WHERE USERNAME = 'APPUNPAIDUSER';
            IF V_COUNTER > 0 THEN          
                EXECUTE IMMEDIATE 'DROP USER APPUNPAIDUSER CASCADE';  
                DBMS_OUTPUT.PUT_LINE('appunpaiduser dropped');
            ELSE RAISE EX_USER_NOT_DROPPED;
            END IF; 
            
        SELECT COUNT(*) INTO V_COUNTER FROM ALL_USERS WHERE USERNAME = 'APPPAIDUSER';
            IF V_COUNTER > 0 THEN          
                EXECUTE IMMEDIATE 'DROP USER APPPAIDUSER CASCADE';  
                DBMS_OUTPUT.PUT_LINE('apppaiduser dropped');
            ELSE RAISE EX_USER_NOT_DROPPED;
            END IF; 
    COMMIT;
    
    EXCEPTION
    
    WHEN EX_INCORRECT_USER THEN
        DBMS_OUTPUT.PUT_LINE('YOU CANNOT PERFORM THIS ACTION, PLEASE CONTACT ADMIN');
    WHEN EX_USER_NOT_DROPPED THEN
        DBMS_OUTPUT.PUT_LINE('USER WAS NOT DELETED');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    ROLLBACK;
END;
/
    EXECUTE DELETE_USER;
    
--CREATING AND GIVING PERMISSIONS TO ALL THE USERS IN THE APPLICATION    
    CREATE USER APPADMIN IDENTIFIED BY NUMusic123456;
    ALTER USER APPADMIN DEFAULT TABLESPACE DATA;
    ALTER USER APPADMIN QUOTA unlimited ON USERS;  
    GRANT create session TO APPADMIN;
    GRANT CONNECT, RESOURCE TO APPADMIN;
    GRANT CREATE TABLE TO APPADMIN;
    GRANT CREATE PROCEDURE TO APPADMIN;
    GRANT EXECUTE ANY PROCEDURE TO APPADMIN;
    GRANT CREATE PUBLIC SYNONYM TO APPADMIN;
    GRANT DROP PUBLIC SYNONYM TO APPADMIN;
    GRANT CREATE SEQUENCE TO APPADMIN;
    GRANT CREATE VIEW TO APPADMIN;
    CREATE USER APPCUSTOMERSERVICE IDENTIFIED BY NUMusic123456;
    ALTER USER APPCUSTOMERSERVICE QUOTA unlimited ON USERS; 
    GRANT create session TO APPCUSTOMERSERVICE;
    CREATE USER APPUNPAIDUSER IDENTIFIED BY NUMusic123456;
    GRANT create session TO APPUNPAIDUSER;
    ALTER USER APPUNPAIDUSER QUOTA unlimited ON USERS; 
    CREATE USER APPPAIDUSER IDENTIFIED BY NUMusic123456;
    GRANT create session TO APPPAIDUSER;
    ALTER USER APPPAIDUSER QUOTA unlimited ON USERS; 
