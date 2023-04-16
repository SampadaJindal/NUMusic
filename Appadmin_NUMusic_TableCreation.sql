set serveroutput on;
--drop tables procedure
create or replace PROCEDURE DROP_TABLES IS
V_COUNTER NUMBER := 0;
CURRENT_USER VARCHAR(20);
EX_INCORRECT_USER EXCEPTION;
EX_NO_DATA_FOUND EXCEPTION;
BEGIN
    SELECT USER INTO CURRENT_USER FROM DUAL;
    IF (CURRENT_USER <> 'APPADMIN_NUMUSIC') THEN
        RAISE EX_INCORRECT_USER;
    END IF;
    
    SELECT COUNT(*) INTO V_COUNTER FROM ALL_TABLES WHERE TABLE_NAME = 'ALBUM_ARTIST' AND TABLESPACE_NAME = 'DATA';  
   IF V_COUNTER > 0 THEN                
        EXECUTE IMMEDIATE 'DROP TABLE ALBUM_ARTIST CASCADE CONSTRAINTS';
             DBMS_OUTPUT.PUT_LINE('Table album_artist dropped');
        ELSE RAISE EX_NO_DATA_FOUND; 
   END IF; 

    SELECT COUNT(*) INTO V_COUNTER FROM ALL_TABLES WHERE TABLE_NAME = 'FAVOURITES' AND TABLESPACE_NAME = 'DATA';
    IF V_COUNTER > 0 THEN         
        EXECUTE IMMEDIATE 'DROP TABLE FAVOURITES CASCADE CONSTRAINTS';
            DBMS_OUTPUT.PUT_LINE('Table Favourites dropped'); 
        ELSE RAISE EX_NO_DATA_FOUND;    
    END IF;

    SELECT COUNT(*) INTO V_COUNTER FROM ALL_TABLES WHERE TABLE_NAME = 'SONGS_PLAYLIST' AND TABLESPACE_NAME = 'DATA';
    IF V_COUNTER > 0 THEN         
        EXECUTE IMMEDIATE 'DROP TABLE SONGS_PLAYLIST CASCADE CONSTRAINTS';
            DBMS_OUTPUT.PUT_LINE('Table SONGS_PLAYLIST dropped'); 
        ELSE RAISE EX_NO_DATA_FOUND; 
    END IF;

    SELECT COUNT(*) INTO V_COUNTER FROM ALL_TABLES WHERE TABLE_NAME = 'LYRICS' AND TABLESPACE_NAME = 'DATA';
    IF V_COUNTER > 0 THEN         
        EXECUTE IMMEDIATE 'DROP TABLE LYRICS CASCADE CONSTRAINTS'; 
            DBMS_OUTPUT.PUT_LINE('Table lyrics dropped');
        ELSE RAISE EX_NO_DATA_FOUND; 
    END IF;

    SELECT COUNT(*) INTO V_COUNTER FROM ALL_TABLES WHERE TABLE_NAME = 'DOWNLOAD' AND TABLESPACE_NAME = 'DATA';
    IF V_COUNTER > 0 THEN         
        EXECUTE IMMEDIATE 'DROP TABLE DOWNLOAD CASCADE CONSTRAINTS';
            DBMS_OUTPUT.PUT_LINE('Table download dropped');
        ELSE RAISE EX_NO_DATA_FOUND; 
    END IF;
    
    SELECT COUNT(*) INTO V_COUNTER FROM ALL_TABLES WHERE TABLE_NAME = 'SONGS_ARTIST' AND TABLESPACE_NAME = 'DATA';
    IF V_COUNTER > 0 THEN         
        EXECUTE IMMEDIATE 'DROP TABLE SONGS_ARTIST CASCADE CONSTRAINTS';
            DBMS_OUTPUT.PUT_LINE('Table songs_artist dropped');
        ELSE RAISE EX_NO_DATA_FOUND; 
    END IF;
    
    SELECT COUNT(*) INTO V_COUNTER FROM ALL_TABLES WHERE TABLE_NAME = 'ARTIST' AND TABLESPACE_NAME = 'DATA';
    IF V_COUNTER > 0 THEN         
        EXECUTE IMMEDIATE 'DROP TABLE ARTIST CASCADE CONSTRAINTS'; 
            DBMS_OUTPUT.PUT_LINE('Table artist dropped');
        ELSE RAISE EX_NO_DATA_FOUND; 
    END IF;
    
    SELECT COUNT(*) INTO V_COUNTER FROM ALL_TABLES WHERE TABLE_NAME = 'PLAYLIST' AND TABLESPACE_NAME = 'DATA';
    IF V_COUNTER > 0 THEN         
        EXECUTE IMMEDIATE 'DROP TABLE PLAYLIST CASCADE CONSTRAINTS';
            DBMS_OUTPUT.PUT_LINE('Table playlist dropped');
        ELSE RAISE EX_NO_DATA_FOUND; 
    END IF;
    
    SELECT COUNT(*) INTO V_COUNTER FROM ALL_TABLES WHERE TABLE_NAME = 'SONGS' AND TABLESPACE_NAME = 'DATA';
    IF V_COUNTER > 0 THEN         
        EXECUTE IMMEDIATE 'DROP TABLE SONGS CASCADE CONSTRAINTS';
            DBMS_OUTPUT.PUT_LINE('Table songs dropped');
        ELSE RAISE EX_NO_DATA_FOUND; 
    END IF;
    
    SELECT COUNT(*) INTO V_COUNTER FROM ALL_TABLES WHERE TABLE_NAME = 'ALBUM' AND TABLESPACE_NAME = 'DATA';
    IF V_COUNTER > 0 THEN         
        EXECUTE IMMEDIATE 'DROP TABLE ALBUM CASCADE CONSTRAINTS';
            DBMS_OUTPUT.PUT_LINE('Table album dropped');
        ELSE RAISE EX_NO_DATA_FOUND; 
    END IF;
    
    SELECT COUNT(*) INTO V_COUNTER FROM ALL_TABLES WHERE TABLE_NAME = 'SUBSCRIPTION' AND TABLESPACE_NAME = 'DATA';
    IF V_COUNTER > 0 THEN         
        EXECUTE IMMEDIATE 'DROP TABLE SUBSCRIPTION CASCADE CONSTRAINTS'; 
            DBMS_OUTPUT.PUT_LINE('Table subscription dropped');
        ELSE RAISE EX_NO_DATA_FOUND; 
    END IF;
    
    SELECT COUNT(*) INTO V_COUNTER FROM ALL_TABLES WHERE TABLE_NAME = 'CARD_DETAILS' AND TABLESPACE_NAME = 'DATA';
    IF V_COUNTER > 0 THEN         
        EXECUTE IMMEDIATE 'DROP TABLE CARD_DETAILS CASCADE CONSTRAINTS'; 
            DBMS_OUTPUT.PUT_LINE('Table card_details dropped');
        ELSE RAISE EX_NO_DATA_FOUND; 
    END IF;
    
    SELECT COUNT(*) INTO V_COUNTER FROM ALL_TABLES WHERE TABLE_NAME = 'USER_DETAILS' AND TABLESPACE_NAME = 'DATA';
    IF V_COUNTER > 0 THEN         
        EXECUTE IMMEDIATE 'DROP TABLE USER_DETAILS CASCADE CONSTRAINTS';
            DBMS_OUTPUT.PUT_LINE('Table user_details dropped');
        ELSE RAISE EX_NO_DATA_FOUND; 
    END IF;
    
    COMMIT;
    
    EXCEPTION
    WHEN EX_INCORRECT_USER THEN
        DBMS_OUTPUT.PUT_LINE('YOU CANNOT PERFORM THIS ACTION, PLEASE CONTACT ADMIN');
    WHEN EX_NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('TABLE ALREADY DROPPED');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    ROLLBACK;
    
    
END;
/

-- Create table procedure
CREATE OR REPLACE PROCEDURE CREATETABLES IS
    V_COUNTER NUMBER := 1;
    CURRENT_USER VARCHAR(20);
    EX_INCORRECT_USER EXCEPTION;
    EX_FAILED_TO_CREATE_TABLE EXCEPTION;
    
BEGIN
    SELECT USER INTO CURRENT_USER FROM DUAL;
    IF (CURRENT_USER <> 'APPADMIN_NUMUSIC') THEN
        RAISE EX_INCORRECT_USER;
    END IF;
    SELECT COUNT(*) INTO V_COUNTER FROM ALL_TABLES WHERE TABLE_NAME = 'USER_DETAILS' AND TABLESPACE_NAME = 'DATA';

    IF V_COUNTER = 0 THEN 
    EXECUTE IMMEDIATE '
    CREATE TABLE USER_DETAILS(
    USER_ID NUMBER(20) PRIMARY KEY,
    USER_NAME VARCHAR(20) NOT NULL,
    USER_ADDR VARCHAR(80) NOT NULL,
    USER_PHONE VARCHAR(10) NOT NULL UNIQUE,
    USER_EMAIL VARCHAR(30) NOT NULL UNIQUE,
    USER_CATEGORY VARCHAR(2) NOT NULL CONSTRAINT CHECK_VAL CHECK (USER_CATEGORY = ''A'' OR USER_CATEGORY = ''CS'' OR USER_CATEGORY =''PU'' OR USER_CATEGORY =''UU''),
    USER_PWD VARCHAR(30) NOT NULL
    )';
        DBMS_OUTPUT.PUT_LINE('Table user_details created');
    ELSE RAISE EX_FAILED_TO_CREATE_TABLE;
    
    END IF;
    

-- create table card_details
    SELECT COUNT(*) INTO V_COUNTER FROM ALL_TABLES WHERE TABLE_NAME = 'CARD_DETAILS' AND TABLESPACE_NAME = 'DATA';

    IF V_COUNTER = 0 THEN 
    EXECUTE IMMEDIATE '
    CREATE TABLE CARD_DETAILS(
    CARD_ID NUMBER(10) PRIMARY KEY,
    CVV NUMBER(4) NOT NULL UNIQUE,
    NAME_ON_CARD VARCHAR(20) NOT NULL,
    EXP_DATE DATE NOT NULL,
    CARD_NUM NUMBER(17) NOT NULL UNIQUE,
    USER_ID NUMBER(20) NOT NULL,
    CONSTRAINT FK_USERID FOREIGN KEY(USER_ID)
    REFERENCES USER_DETAILS(USER_ID)
    )';   
        DBMS_OUTPUT.PUT_LINE('Table card_details created');
    ELSE RAISE EX_FAILED_TO_CREATE_TABLE;
    END IF;
    
-- create table subscription
    SELECT COUNT(*) INTO V_COUNTER FROM ALL_TABLES WHERE TABLE_NAME = 'SUBSCRIPTION' AND TABLESPACE_NAME = 'DATA';

    IF V_COUNTER = 0 THEN 
    EXECUTE IMMEDIATE '
    CREATE TABLE SUBSCRIPTION(
    SUBS_ID NUMBER(20) PRIMARY KEY,
    USER_ID NUMBER(20) NOT NULL,
    AUTO_SUBSCRIPTION VARCHAR(1)NOT NULL CONSTRAINT CHECK_AUTO CHECK (AUTO_SUBSCRIPTION = ''Y'' OR AUTO_SUBSCRIPTION = ''N''),
    SUBS_PLAN_NAME VARCHAR(1)NOT NULL CONSTRAINT CHECK_PLAN CHECK (SUBS_PLAN_NAME = ''P'' OR SUBS_PLAN_NAME = ''U''),
    SUBS_START_DATE DATE NOT NULL,
    SUBS_END_DATE DATE,
    CARD_ID NUMBER(10) NOT NULL,
    CONSTRAINT FK_USERID1 FOREIGN KEY(USER_ID)
    REFERENCES USER_DETAILS(USER_ID),
    CONSTRAINT FK_CARDID FOREIGN KEY(CARD_ID)
    REFERENCES CARD_DETAILS(CARD_ID)
    )';
        DBMS_OUTPUT.PUT_LINE('Table subscription created');
    ELSE RAISE EX_FAILED_TO_CREATE_TABLE;
    END IF;
    
-- create table artist
    SELECT COUNT(*) INTO V_COUNTER FROM ALL_TABLES WHERE TABLE_NAME = 'ARTIST' AND TABLESPACE_NAME = 'DATA';

    IF V_COUNTER = 0 THEN 
    EXECUTE IMMEDIATE '
    CREATE TABLE ARTIST(
    ARTIST_ID NUMBER(20) PRIMARY KEY,
    ARTIST_NAME VARCHAR(50) NOT NULL
    )';
        DBMS_OUTPUT.PUT_LINE('Table artist created');
    ELSE RAISE EX_FAILED_TO_CREATE_TABLE;
    END IF;

-- create table playlist
    SELECT COUNT(*) INTO V_COUNTER FROM ALL_TABLES WHERE TABLE_NAME = 'PLAYLIST' AND TABLESPACE_NAME = 'DATA';

    IF V_COUNTER = 0 THEN 
    EXECUTE IMMEDIATE '
    CREATE TABLE PLAYLIST(
    PLAYLIST_ID NUMBER(20) PRIMARY KEY,
    PLAYLIST_NAME VARCHAR(20) NOT NULL,
    USER_ID NUMBER(20) NOT NULL,
    CONSTRAINT FK_USERID2 FOREIGN KEY(USER_ID)
    REFERENCES USER_DETAILS(USER_ID)
    )';
        DBMS_OUTPUT.PUT_LINE('Table playlist created');
    ELSE RAISE EX_FAILED_TO_CREATE_TABLE;
    END IF;
    
-- create table album
     SELECT COUNT(*) INTO V_COUNTER FROM ALL_TABLES WHERE TABLE_NAME = 'ALBUM' AND TABLESPACE_NAME = 'DATA';

    IF V_COUNTER = 0 THEN 
    EXECUTE IMMEDIATE '
    create table album(
    album_id number(20) primary key,
    album_name varchar(50) Not null,
    album_release_date date not null)';
        DBMS_OUTPUT.PUT_LINE('Table album created');
    ELSE RAISE EX_FAILED_TO_CREATE_TABLE;
    END IF;
 
 -- create table songs
 SELECT COUNT(*) INTO V_COUNTER FROM ALL_TABLES WHERE TABLE_NAME = 'SONGS' AND TABLESPACE_NAME = 'DATA';

    IF V_COUNTER = 0 THEN 
    EXECUTE IMMEDIATE '
 
    create table songs(
    song_id number(10) Primary key,
    rating float(1) NOT NULL,
    song_name varchar(40) Not null,
    song_release_date date not null,
    song_duration INTERVAL DAY(2) TO SECOND(6) not null,
    album_id number(20) not null,
    CONSTRAINT FK_ALBUMID FOREIGN KEY (ALBUM_ID)
    REFERENCES ALBUM (ALBUM_ID),
    genre_name varchar2(40) not null)';
        DBMS_OUTPUT.PUT_LINE('Table songs created');
    ELSE RAISE EX_FAILED_TO_CREATE_TABLE;
    END IF;
 
 
-- create table download 
 SELECT COUNT(*) INTO V_COUNTER FROM ALL_TABLES WHERE TABLE_NAME = 'DOWNLOAD' AND TABLESPACE_NAME = 'DATA';

    IF V_COUNTER = 0 THEN 
    EXECUTE IMMEDIATE '
    CREATE TABLE DOWNLOAD (
    SONG_ID NUMBER(10) NOT NULL,
    SUBS_ID NUMBER(20) NOT NULL,
    DOWNLOAD_DATE DATE NOT NULL,
    PRIMARY KEY (SONG_ID, SUBS_ID),
    CONSTRAINT FK_SONGID1 FOREIGN KEY (SONG_ID) REFERENCES SONGS(SONG_ID),
    CONSTRAINT FK_SUBSID FOREIGN KEY (SUBS_ID) REFERENCES SUBSCRIPTION(SUBS_ID)
    )';
        DBMS_OUTPUT.PUT_LINE('Table download created');
    ELSE RAISE EX_FAILED_TO_CREATE_TABLE;
    END IF;

-- create table lyrics
 SELECT COUNT(*) INTO V_COUNTER FROM ALL_TABLES WHERE TABLE_NAME = 'LYRICS' AND TABLESPACE_NAME = 'DATA';

    IF V_COUNTER = 0 THEN 
    EXECUTE IMMEDIATE '
    create table lyrics(
    lyrics_id number(20) primary key,
    song_id number(10) not null,
    constraint fk_songid foreign key (song_id)
    references Songs (song_id),
    lyrics_text varchar(5000) not null,
    lyrics_language varchar(10) not null)';
        DBMS_OUTPUT.PUT_LINE('Table lyrics created');
    ELSE RAISE EX_FAILED_TO_CREATE_TABLE;
    END IF;

-- create table favourites
 SELECT COUNT(*) INTO V_COUNTER FROM ALL_TABLES WHERE TABLE_NAME = 'FAVOURITES' AND TABLESPACE_NAME = 'DATA';

    IF V_COUNTER = 0 THEN 
    EXECUTE IMMEDIATE '
    create table favourites(
    song_id number(10) not null,
    user_id number(20) not null,
    Primary key(song_id, user_id),
    constraint fk_songid2 foreign key (song_id)
    references songs(song_id),
    constraint fk_userid3 foreign key (user_id)
    references user_details(user_id))';
        DBMS_OUTPUT.PUT_LINE('Table favourites created');
    ELSE RAISE EX_FAILED_TO_CREATE_TABLE;
    END IF;

-- create table album_artist
 SELECT COUNT(*) INTO V_COUNTER FROM ALL_TABLES WHERE TABLE_NAME = 'ALBUM_ARTIST' AND TABLESPACE_NAME = 'DATA';

    IF V_COUNTER = 0 THEN 
    EXECUTE IMMEDIATE '
    create table album_artist(
    album_id number(20) not null,
    artist_id number(20) not null,
    Primary key(album_id, artist_id),
    CONSTRAINT FK_ALBUMID1 FOREIGN KEY (ALBUM_ID)
    REFERENCES ALBUM (ALBUM_ID),
    CONSTRAINT FK_Artistid FOREIGN KEY (Artist_ID)
    REFERENCES Artist (Artist_ID))';
        DBMS_OUTPUT.PUT_LINE('Table album_artist created');
    ELSE RAISE EX_FAILED_TO_CREATE_TABLE;
    END IF;

-- create table songs_artist
 SELECT COUNT(*) INTO V_COUNTER FROM ALL_TABLES WHERE TABLE_NAME = 'SONGS_ARTIST' AND TABLESPACE_NAME = 'DATA';

    IF V_COUNTER = 0 THEN 
    EXECUTE IMMEDIATE '
    create table songs_artist(
    song_id number(10) not null,
    artist_id number(20) not null,
    Primary key(song_id, artist_id),
    constraint fk_songid4 foreign key (song_id)
    references songs(song_id),
    CONSTRAINT FK_Artistid1 FOREIGN KEY (Artist_ID)
    REFERENCES Artist (Artist_ID))';
        DBMS_OUTPUT.PUT_LINE('Table songs_artist created');
    ELSE RAISE EX_FAILED_TO_CREATE_TABLE;
    END IF;

-- create table songs_playlist
 SELECT COUNT(*) INTO V_COUNTER FROM ALL_TABLES WHERE TABLE_NAME = 'SONGS_PLAYLIST' AND TABLESPACE_NAME = 'DATA';

    IF V_COUNTER = 0 THEN 
    EXECUTE IMMEDIATE '
  CREATE TABLE SONGS_PLAYLIST (
  SONG_ID NUMBER(10) NOT NULL,
  PLAYLIST_ID NUMBER(20) NOT NULL,
  PRIMARY KEY (SONG_ID, PLAYLIST_ID),
  CONSTRAINT FK_SONGID3 FOREIGN KEY (SONG_ID) REFERENCES SONGS(SONG_ID),
  CONSTRAINT FK_PLAYLISTID FOREIGN KEY (PLAYLIST_ID) REFERENCES PLAYLIST(PLAYLIST_ID)
    )';
        DBMS_OUTPUT.PUT_LINE('Table songs_playlist created');
    ELSE RAISE EX_FAILED_TO_CREATE_TABLE;
    END IF;
COMMIT;

EXCEPTION
    WHEN EX_INCORRECT_USER THEN
        DBMS_OUTPUT.PUT_LINE('YOU CANNOT PERFORM THIS ACTION. PLEASE CONTACT ADMIN');
    WHEN EX_FAILED_TO_CREATE_TABLE THEN
        DBMS_OUTPUT.PUT_LINE('TABLE WAS NOT CREATED SUCCESSFULLY');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    ROLLBACK;

END;
/

-- delete sequence
CREATE OR REPLACE PROCEDURE DELETE_SEQUENCE(OBJNAME VARCHAR2,OBJTYPE VARCHAR2)
IS
    V_COUNTER NUMBER := 0;
    CURRENT_USER VARCHAR(20);
    EX_INCORRECT_USER EXCEPTION;
BEGIN
    SELECT USER INTO CURRENT_USER FROM DUAL;
    IF (CURRENT_USER <> 'APPADMIN_NUMUSIC') THEN
        RAISE EX_INCORRECT_USER;
    END IF;
    IF OBJTYPE = 'SEQUENCE' THEN
        SELECT COUNT(*) INTO V_COUNTER FROM USER_SEQUENCES WHERE SEQUENCE_NAME = UPPER(OBJNAME);
            IF V_COUNTER > 0 THEN          
                EXECUTE IMMEDIATE 'DROP SEQUENCE ' || OBJNAME;        
            END IF; 
    END IF;
   
    COMMIT;
    EXCEPTION
    WHEN EX_INCORRECT_USER THEN
        DBMS_OUTPUT.PUT_LINE('YOU CANNOT DO THIS ACTION. PLEASE CONTACT ADMIN');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    ROLLBACK;
END;
/
-- executing drop tables procedure
EXECUTE DROP_TABLES;

-- executing create tables procedure
EXECUTE CREATETABLES;

EXECUTE DELETE_SEQUENCE('USER_ID_SEQ','SEQUENCE'); 
CREATE SEQUENCE USER_ID_SEQ
    START WITH 100
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
EXECUTE DELETE_SEQUENCE('CARD_DETAILS_ID_SEQ','SEQUENCE'); 
CREATE SEQUENCE CARD_DETAILS_ID_SEQ
    START WITH 1000
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
EXECUTE DELETE_SEQUENCE('SUBS_ID_SEQ','SEQUENCE'); 
CREATE SEQUENCE SUBS_ID_SEQ
    START WITH 10000
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
EXECUTE DELETE_SEQUENCE('ALBUM_ID_SEQ','SEQUENCE'); 
CREATE SEQUENCE ALBUM_ID_SEQ
    START WITH 10
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
EXECUTE DELETE_SEQUENCE('SONG_ID_SEQ','SEQUENCE'); 
CREATE SEQUENCE SONG_ID_SEQ
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
EXECUTE DELETE_SEQUENCE('ARTIST_ID_SEQ','SEQUENCE'); 
CREATE SEQUENCE ARTIST_ID_SEQ
    START WITH 10
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
EXECUTE DELETE_SEQUENCE('LYRICS_ID_SEQ','SEQUENCE'); 
CREATE SEQUENCE LYRICS_ID_SEQ
    START WITH 10000
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;


EXECUTE DELETE_SEQUENCE('PLAYLIST_ID_SEQ','SEQUENCE'); 
CREATE SEQUENCE PLAYLIST_ID_SEQ
    START WITH 100000
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
