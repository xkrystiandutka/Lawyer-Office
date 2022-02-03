------------------------------------------------------
-- UWAGI:
-- Skrypt nalezy uruchomić DWA RAZY - po drugim uruchomieniu 
-- nie mogą w nim występowac żadne błędy!
------------------------------------------------------

CLEAR SCREEN;
--
SET LINESIZE 350;
SET PAGESIZE 300;

-- wyswietla komunikaty zwrotne z Oracle
SET SERVEROUTPUT ON;

-- Nagrywanie konunikatów z buforu ekranowego do pliku
-- Przydatne w przypadku poszukiwania błedów w długich plikach!
SPOOL "D:\ORACLE\Database.sql.txt"

show user;

-- wyswietla komunikaty zwrotne z Oracle
SET SERVEROUTPUT ON;

-- zmień format daty
alter session set 
	nls_date_format = 'YYYY-MM-DD';

--
select sysdate from dual;
--
---------------------------
PROMPT   sekwencja kasowania
---------------------------
drop table bd1_SPRAWY_SADOWE;
drop table bd1_ZEZNANIA;
drop table bd1_STANOWISKO_SWIADKA;
drop table bd1_DOWODY;
drop table bd1_SLEDZTWA;
drop table bd1_PRZESTEPSTWA;
drop table bd1_KARY;
drop table bd1_OSKARZENIA;
drop table bd1_USLUGI;
drop table bd1_KLIENCI;
drop table bd1_HISTORIA_ZATRUDNIENIA;
drop table bd1_PRACOWNICY;
drop table bd1_OSOBY;
drop table bd1_INSTYTUTY;
drop table bd1_STANOWISKO;

---------------------------
PROMPT   DDL create table
---------------------------	

---------------------------
PROMPT   table bd1_STANOWISKO
---------------------------	
create table bd1_STANOWISKO (
STA_ID			number(8)	NOT NULL,		
STA_Rodzaj		varchar2(64)	NOT NULL,
STA_OPIS		varchar2(64),
STA_Zarobki		number(8) 
)
PCTFREE 5
TABLESPACE STUDENT_DATA;
	------------------------
	-- NOLOGGING
	------------------------
	ALTER TABLE bd1_STANOWISKO NOLOGGING;				
	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_STANOWISKO 
		ADD CONSTRAINT bd1_STANOWISKO 
		PRIMARY KEY (STA_ID)
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING;
	------------------------
	-- INDEXy
	------------------------	
	CREATE INDEX bd1_IX_STA_Rodzaj 
	ON bd1_STANOWISKO (STA_Rodzaj)
	TABLESPACE STUDENT_INDEX NOLOGGING;	

---------------------------
PROMPT   table bd1_INSTYTUTY
---------------------------	
create table bd1_INSTYTUTY (
INS_ID				number(8) NOT NULL,		
INS_Lokalizacja		varchar2(64) NOT NULL
)
PCTFREE 5
TABLESPACE STUDENT_DATA;
	------------------------
	-- NOLOGGING
	------------------------
	ALTER TABLE bd1_INSTYTUTY NOLOGGING;				
	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_INSTYTUTY 
		ADD CONSTRAINT bd1_INSTYTUTY 
		PRIMARY KEY (INS_ID)
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING;		
	------------------------
	-- INDEXy
	------------------------	
	CREATE INDEX bd1_IX_INS_Lokalizacja 
	ON bd1_INSTYTUTY (INS_Lokalizacja)
	TABLESPACE STUDENT_INDEX NOLOGGING;		

---------------------------
PROMPT   table bd1_OSOBY
---------------------------	
create table bd1_OSOBY (
OSO_ID					number(8) 	 NOT NULL,		
OSO_Imie				varchar2(32) NOT NULL,
OSO_Nazwisko			varchar2(32) NOT NULL,		
OSO_Plec				varchar2(32) NOT NULL,		
OSO_Adres_Zamieszkania	varchar2(32) NOT NULL,		
OSO_Kod_Pocztowy		char(8),
OSO_Telefon				char(16)		
)
PCTFREE 5
TABLESPACE STUDENT_DATA;
	------------------------
	-- NOLOGGING
	------------------------
	ALTER TABLE bd1_OSOBY NOLOGGING;				
	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_OSOBY 
		ADD CONSTRAINT bd1_OSOBY 
		PRIMARY KEY (OSO_ID)
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING		;
	------------------------
	-- INDEXy
	------------------------	
	CREATE INDEX bd1_IX_OSO_Imie
	ON bd1_OSOBY (OSO_Imie)
	TABLESPACE STUDENT_INDEX NOLOGGING;

	CREATE INDEX bd1_IX_OSO_Nazwisko 
	ON bd1_OSOBY (OSO_Nazwisko)
	TABLESPACE STUDENT_INDEX NOLOGGING;

	CREATE INDEX bd1_IX_OSO_Adres_Zamieszkania 
	ON bd1_OSOBY (OSO_Adres_Zamieszkania)
	TABLESPACE STUDENT_INDEX NOLOGGING;	

---------------------------
PROMPT   table bd1_PRACOWNICY
---------------------------	
create table bd1_PRACOWNICY (
PRA_ID		number(8) NOT NULL,		
OSO_ID		number(8) NOT NULL		
)
PCTFREE 5
TABLESPACE STUDENT_DATA;
	------------------------
	-- NOLOGGING
	------------------------
	ALTER TABLE bd1_PRACOWNICY NOLOGGING;				
	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_PRACOWNICY 
		ADD CONSTRAINT bd1_PRACOWNICY 
		PRIMARY KEY (PRA_ID)
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING		;
		--  FOREIGN Keys
	------------------------
	ALTER TABLE bd1_PRACOWNICY
		ADD CONSTRAINT FK1_bd1_PRACOWNICY
		FOREIGN KEY(OSO_ID) 
		REFERENCES bd1_OSOBY(OSO_ID) ENABLE;
	------------------------
	-- INDEXy
	------------------------	
	CREATE INDEX bd1_IX_OSO_ID
	ON bd1_PRACOWNICY (OSO_ID)
	TABLESPACE STUDENT_INDEX NOLOGGING;

---------------------------
PROMPT   table bd1_HISTORIA_ZATRUDNIENIA
---------------------------	
create table bd1_HISTORIA_ZATRUDNIENIA (
HIS_Pracownika_ID			number(8) NOT NULL,		
HIS_Data_Zatrudnienia		varchar2(64) NOT NULL,
HIS_Data_Zwolnienia			varchar2(64),
STA_ID						number(8) NOT NULL,
INS_ID						number(8) NOT NULL,
PRA_ID						number(8) NOT NULL
)
PCTFREE 5
TABLESPACE STUDENT_DATA;
	------------------------
	-- NOLOGGING
	------------------------
	ALTER TABLE bd1_HISTORIA_ZATRUDNIENIA NOLOGGING;				
	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_HISTORIA_ZATRUDNIENIA 
		ADD CONSTRAINT bd1_HISTORIA_ZATRUDNIENIA 
		PRIMARY KEY (HIS_Pracownika_ID)
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING		;
------------------------
	--  FOREIGN Keys
	------------------------
	ALTER TABLE bd1_HISTORIA_ZATRUDNIENIA
		ADD CONSTRAINT FK1_bd1_HISTORIA_ZATRUDNIENIA
		FOREIGN KEY(STA_ID) 
		REFERENCES bd1_STANOWISKO(STA_ID) ENABLE;

	ALTER TABLE bd1_HISTORIA_ZATRUDNIENIA
		ADD CONSTRAINT FK2_bd1_HISTORIA_ZATRUDNIENIA
		FOREIGN KEY(INS_ID) 
		REFERENCES bd1_INSTYTUTY(INS_ID) ENABLE;
		
	ALTER TABLE bd1_HISTORIA_ZATRUDNIENIA
		ADD CONSTRAINT FK3_bd1_HISTORIA_ZATRUDNIENIA
		FOREIGN KEY(PRA_ID) 
		REFERENCES bd1_PRACOWNICY(PRA_ID) ENABLE;
	------------------------
	-- INDEXy
	------------------------	
	CREATE INDEX bd1_IX_HIS_Data_Zatrudnienia
	ON bd1_HISTORIA_ZATRUDNIENIA (HIS_Data_Zatrudnienia)
	TABLESPACE STUDENT_INDEX NOLOGGING;

	CREATE INDEX bd1_IX_HIS_HIS_Data_Zwolnienia
	ON bd1_HISTORIA_ZATRUDNIENIA (HIS_Data_Zwolnienia)
	TABLESPACE STUDENT_INDEX NOLOGGING;
	
---------------------------
PROMPT   table bd1_KLIENCI
---------------------------	
create table bd1_KLIENCI (
KLI_ID		number(8) NOT NULL,		
OSO_ID		number(8) NOT NULL		
)
PCTFREE 5
TABLESPACE STUDENT_DATA;
	------------------------
	-- NOLOGGING
	------------------------
	ALTER TABLE bd1_KLIENCI NOLOGGING;				
	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_KLIENCI 
		ADD CONSTRAINT bd1_KLIENCI 
		PRIMARY KEY (KLI_ID)
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING		;
	--  FOREIGN Keys
	------------------------
	ALTER TABLE bd1_KLIENCI
		ADD CONSTRAINT FK1_bd1_KLIENCI
		FOREIGN KEY(KLI_ID) 
		REFERENCES bd1_OSOBY(OSO_ID) ENABLE;

---------------------------
PROMPT   table bd1_USLUGI
---------------------------	
create table bd1_USLUGI (
USL_ID		number(8) NOT NULL,		
PRA_ID		number(8) NOT NULL,	
KLI_ID		number(8) NOT NULL		
)
PCTFREE 5
TABLESPACE STUDENT_DATA;
	------------------------
	-- NOLOGGING
	------------------------
	ALTER TABLE bd1_USLUGI NOLOGGING;				
	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_USLUGI 
		ADD CONSTRAINT bd1_USLUGI 
		PRIMARY KEY (USL_ID)
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING		;
	--  FOREIGN Keys
	------------------------
	ALTER TABLE bd1_USLUGI
		ADD CONSTRAINT FK1_bd1_USLUGI
		FOREIGN KEY(PRA_ID) 
		REFERENCES bd1_PRACOWNICY(PRA_ID) ENABLE;
	ALTER TABLE bd1_USLUGI
		ADD CONSTRAINT FK2_bd1_USLUGI
		FOREIGN KEY(KLI_ID) 
		REFERENCES bd1_KLIENCI(KLI_ID) ENABLE;
	------------------------
	-- INDEXy
	------------------------	
	CREATE INDEX bd1_IX_PRA_ID
	ON bd1_USLUGI (PRA_ID)
	TABLESPACE STUDENT_INDEX NOLOGGING;	
	
	CREATE INDEX bd1_IX_KLI_ID
	ON bd1_USLUGI (KLI_ID)
	TABLESPACE STUDENT_INDEX NOLOGGING;
	
---------------------------
PROMPT   table bd1_OSKARZENIA
---------------------------	
create table bd1_OSKARZENIA (
OSK_ID		number(8) NOT NULL,		
OSK_Data	DATE NOT NULL,		
OSK_Rodzaj	varchar2(64)
)
PCTFREE 5
TABLESPACE STUDENT_DATA;
	------------------------
	-- NOLOGGING
	------------------------
	ALTER TABLE bd1_OSKARZENIA NOLOGGING;				
	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_OSKARZENIA 
		ADD CONSTRAINT bd1_OSKARZENIA 
		PRIMARY KEY (OSK_ID)
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING		;
	------------------------
	-- INDEXy
	------------------------	
	CREATE INDEX bd1_IX_OSK_Rodzaj
	ON bd1_OSKARZENIA (OSK_Rodzaj)
	TABLESPACE STUDENT_INDEX NOLOGGING;	
		
---------------------------
PROMPT   table bd1_KARY
---------------------------	
create table bd1_KARY (
KAR_ID					number(8) NOT NULL,		
KAR_Wyrok				varchar2(64) NOT NULL,		
KAR_Data_Rozpoczecia	DATE NOT NULL,		
KAR_Data_Zakonczenia	DATE NOT NULL,	
OSK_ID 					number(8) NOT NULL		
)
PCTFREE 5
TABLESPACE STUDENT_DATA;
	------------------------
	-- NOLOGGING
	------------------------
	ALTER TABLE bd1_OSKARZENIA NOLOGGING;				
	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_KARY 
		ADD CONSTRAINT bd1_KARY 
		PRIMARY KEY (KAR_ID)
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING		;
	--  FOREIGN Keys
	------------------------
	ALTER TABLE bd1_KARY 
		ADD CONSTRAINT FK1_bd1_KARY
		FOREIGN KEY(OSK_ID) 
		REFERENCES bd1_OSKARZENIA(OSK_ID) ENABLE;
	------------------------
	-- INDEXy
	------------------------	
	CREATE INDEX bd1_IX_KAR_Wyrok
	ON bd1_KARY (KAR_Wyrok)
	TABLESPACE STUDENT_INDEX NOLOGGING;

	CREATE INDEX bd1_IX_KAR_Data_Rozpoczecia
	ON bd1_KARY (KAR_Data_Rozpoczecia)
	TABLESPACE STUDENT_INDEX NOLOGGING;	

	CREATE INDEX bd1_IX_KAR_Data_Zakonczenia
	ON bd1_KARY (KAR_Data_Zakonczenia)
	TABLESPACE STUDENT_INDEX NOLOGGING;		

---------------------------
PROMPT   table bd1_PRZESTEPSTWA;
---------------------------	
create table bd1_PRZESTEPSTWA (
PRZ_ID		number(8) NOT NULL,		
PRZ_Data  	DATE NOT NULL,		
PRZ_Rodzaj	varchar2(64) NOT NULL,
PRZ_Uwagi varchar2(64)
)
PCTFREE 5
TABLESPACE STUDENT_DATA;
	------------------------
	-- NOLOGGING
	------------------------
	ALTER TABLE bd1_PRZESTEPSTWA NOLOGGING;				
	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_PRZESTEPSTWA 
		ADD CONSTRAINT bd1_PRZESTEPSTWA 
		PRIMARY KEY (PRZ_ID)
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING;
	------------------------
	-- INDEXy
	------------------------	
	CREATE INDEX bd1_IX_PRZ_Rodzaj
	ON bd1_PRZESTEPSTWA (PRZ_Rodzaj)
	TABLESPACE STUDENT_INDEX NOLOGGING;
	
---------------------------
PROMPT   table bd1_SLEDZTWA
---------------------------	
create table bd1_SLEDZTWA (
SLE_ID				number(8) NOT NULL,		
SLE_Data			DATE	  NOT NULL,		
PRZ_ID				number(8) NOT NULL
)
PCTFREE 5
TABLESPACE STUDENT_DATA;
	------------------------
	-- NOLOGGING
	------------------------
	ALTER TABLE bd1_SLEDZTWA NOLOGGING;				
	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_SLEDZTWA 
		ADD CONSTRAINT bd1_SLEDZTWA 
		PRIMARY KEY (SLE_ID)
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING		;
	--  FOREIGN Keys
	------------------------
	ALTER TABLE bd1_SLEDZTWA  
		ADD CONSTRAINT FK1_bd1_SLEDZTWA 
		FOREIGN KEY(PRZ_ID) 
		REFERENCES bd1_PRZESTEPSTWA(PRZ_ID) ENABLE;
	------------------------
	-- INDEXy
	------------------------	
	CREATE INDEX bd1_IX_SLE_Data
	ON bd1_SLEDZTWA (SLE_Data)
	TABLESPACE STUDENT_INDEX NOLOGGING;	

---------------------------
PROMPT   table bd1_DOWODY;
---------------------------	
create table bd1_DOWODY (
DOW_ID		number(8) NOT NULL,		
DOW_Opis  	varchar2(64),		
DOW_Rodzaj	varchar2(64) NOT NULL,
SLE_ID		number(8) NOT NULL
)
PCTFREE 5
TABLESPACE STUDENT_DATA;
	------------------------
	-- NOLOGGING
	------------------------
	ALTER TABLE bd1_DOWODY NOLOGGING;				
	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_DOWODY 
		ADD CONSTRAINT bd1_DOWODY 
		PRIMARY KEY (DOW_ID)
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING		;
	--  FOREIGN Keys
	------------------------
	ALTER TABLE bd1_DOWODY  
		ADD CONSTRAINT FK1_bd1_DOWODY 
		FOREIGN KEY(SLE_ID) 
		REFERENCES bd1_SLEDZTWA(SLE_ID) ENABLE;
	------------------------
	-- INDEXy
	------------------------	
	CREATE INDEX bd1_IX_DOW_Opis
	ON bd1_DOWODY (DOW_Opis)
	TABLESPACE STUDENT_INDEX NOLOGGING;		
	
	CREATE INDEX bd1_IX_DOW_Rodzaj
	ON bd1_DOWODY (DOW_Rodzaj)
	TABLESPACE STUDENT_INDEX NOLOGGING;	
		
---------------------------
PROMPT   table bd1_STANOWISKO_SWIADKA
---------------------------	
create table bd1_STANOWISKO_SWIADKA (
STA_SW_ID				number(8) NOT NULL,		
STA_SW_Zeznania  		varchar2(64) NOT NULL,		
STA_SW_Data			DATE NOT NULL,		
STA_SW_Rodzaj			varchar2(64) NOT NULL,		
STA_SW_Typ_Swiadka		varchar2(64) NOT NULL,		
STA_SW_Opis			varchar2(64) NOT NULL
)
PCTFREE 5
TABLESPACE STUDENT_DATA;
	------------------------
	-- NOLOGGING
	------------------------
	ALTER TABLE bd1_STANOWISKO_SWIADKA NOLOGGING;				
	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_STANOWISKO_SWIADKA 
		ADD CONSTRAINT bd1_STANOWISKO_SWIADKA 
		PRIMARY KEY (STA_SW_ID)
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING		;
	------------------------
	-- INDEXy
	------------------------	
	CREATE INDEX bd1_IX_STA_SW_Rodzaj
	ON bd1_STANOWISKO_SWIADKA (STA_SW_Rodzaj)
	TABLESPACE STUDENT_INDEX NOLOGGING;		
	
	CREATE INDEX bd1_IX_STA_SW_Data
	ON bd1_STANOWISKO_SWIADKA (STA_SW_Data)
	TABLESPACE STUDENT_INDEX NOLOGGING;
---------------------------
PROMPT   table bd1_ZEZNANIA
---------------------------	
create table bd1_ZEZNANIA (
ZEZ_ID		number(8) NOT NULL,		
ZEZ_Typ  	varchar2(64) NOT NULL,		
ZEZ_Opis	varchar2(64) NOT NULL,		
DOW_ID		number(8) NOT NULL,		
STA_SW_ID	number(8) NOT NULL,		
OSK_ID		number(8) NOT NULL
)
PCTFREE 5
TABLESPACE STUDENT_DATA;
	------------------------
	-- NOLOGGING
	------------------------
	ALTER TABLE bd1_ZEZNANIA NOLOGGING;				
	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_ZEZNANIA 
		ADD CONSTRAINT bd1_ZEZNANIA 
		PRIMARY KEY (ZEZ_ID)
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING		;
	--  FOREIGN Keys
	------------------------
	ALTER TABLE bd1_ZEZNANIA  
		ADD CONSTRAINT FK1_bd1_ZEZNANIA 
		FOREIGN KEY(DOW_ID) 
		REFERENCES bd1_DOWODY(DOW_ID) ENABLE;
	ALTER TABLE bd1_ZEZNANIA  
		ADD CONSTRAINT FK2_bd1_ZEZNANIA 
		FOREIGN KEY(STA_SW_ID) 
		REFERENCES bd1_STANOWISKO_SWIADKA(STA_SW_ID) ENABLE;
	ALTER TABLE bd1_ZEZNANIA  
		ADD CONSTRAINT FK3_bd1_ZEZNANIA 
		FOREIGN KEY(OSK_ID) 
		REFERENCES bd1_OSKARZENIA(OSK_ID) ENABLE;
	------------------------
	-- INDEXy
	------------------------	
	CREATE INDEX bd1_IX_ZEZ_Typ
	ON bd1_ZEZNANIA (ZEZ_Typ)
	TABLESPACE STUDENT_INDEX NOLOGGING;		
	
	CREATE INDEX bd1_IX_ZEZ_Opis
	ON bd1_ZEZNANIA (ZEZ_Opis)
	TABLESPACE STUDENT_INDEX NOLOGGING;

---------------------------
PROMPT   table bd1_SPRAWY_SADOWE;
---------------------------	
create table bd1_SPRAWY_SADOWE (
SPR_ID		number(8) NOT NULL,		
PRZ_ID  	number(8) NOT NULL,		
USL_ID		number(8) NOT NULL
)
PCTFREE 5
TABLESPACE STUDENT_DATA;
	------------------------
	-- NOLOGGING
	------------------------
	ALTER TABLE bd1_SPRAWY_SADOWE NOLOGGING;				
	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_SPRAWY_SADOWE 
		ADD CONSTRAINT bd1_SPRAWY_SADOWE 
		PRIMARY KEY (SPR_ID)
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING		;
	--  FOREIGN Keys
	------------------------
	ALTER TABLE bd1_SPRAWY_SADOWE  
		ADD CONSTRAINT FK1_bd1_SPRAWY_SADOWE 
		FOREIGN KEY(PRZ_ID) 
		REFERENCES bd1_PRZESTEPSTWA(PRZ_ID) ENABLE;
	ALTER TABLE bd1_SPRAWY_SADOWE  
		ADD CONSTRAINT FK2_bd1_SPRAWY_SADOWE 
		FOREIGN KEY(USL_ID) 
		REFERENCES bd1_USLUGI(USL_ID) ENABLE;

PROMPT ;
PROMPT----------------------------------------;
PROMPT Sequence;
PROMPT----------------------------------------; 
PROMPT ;

	drop sequence SEQ_bd1_STANOWISKO;
	drop sequence SEQ_bd1_INSTYTUTY;
	drop sequence SEQ_bd1_OSOBY;
	drop sequence SEQ_bd1_PRACOWNICY;
	drop sequence SEQ_bd1_HISTORIA_ZATRUDNIENIA;
	drop sequence SEQ_bd1_KLIENCI;
	drop sequence SEQ_bd1_USLUGI;
	drop sequence SEQ_bd1_OSKARZENIA;
	drop sequence SEQ_bd1_KARY;
	drop sequence SEQ_bd1_PRZESTEPSTWA;
	drop sequence SEQ_bd1_SLEDZTWA;
	drop sequence SEQ_bd1_DOWODY;
	drop sequence SEQ_bd1_STANOWISKO_SWIADKA;
	drop sequence SEQ_bd1_ZEZNANIA;
	drop sequence SEQ_bd1_SPRAWY_SADOWE;

CREATE SEQUENCE SEQ_bd1_STANOWISKO INCREMENT BY 1 START WITH 1 MINVALUE 1;
CREATE SEQUENCE SEQ_bd1_INSTYTUTY INCREMENT BY 1 START WITH 1 MINVALUE 1;
CREATE SEQUENCE SEQ_bd1_OSOBY INCREMENT BY 1 START WITH 1 MINVALUE 1;
CREATE SEQUENCE SEQ_bd1_PRACOWNICY INCREMENT BY 1 START WITH 1 MINVALUE 1;
CREATE SEQUENCE SEQ_bd1_HISTORIA_ZATRUDNIENIA INCREMENT BY 1 START WITH 1 MINVALUE 1;
CREATE SEQUENCE SEQ_bd1_KLIENCI INCREMENT BY 1 START WITH 1 MINVALUE 1;
CREATE SEQUENCE SEQ_bd1_USLUGI INCREMENT BY 1 START WITH 1 MINVALUE 1;
CREATE SEQUENCE SEQ_bd1_OSKARZENIA INCREMENT BY 1 START WITH 1 MINVALUE 1;
CREATE SEQUENCE SEQ_bd1_KARY INCREMENT BY 1 START WITH 1 MINVALUE 1;
CREATE SEQUENCE SEQ_bd1_PRZESTEPSTWA INCREMENT BY 1 START WITH 1 MINVALUE 1;
CREATE SEQUENCE SEQ_bd1_SLEDZTWA INCREMENT BY 1 START WITH 1 MINVALUE 1;
CREATE SEQUENCE SEQ_bd1_DOWODY INCREMENT BY 1 START WITH 1 MINVALUE 1;
CREATE SEQUENCE SEQ_bd1_STANOWISKO_SWIADKA INCREMENT BY 1 START WITH 1 MINVALUE 1;
CREATE SEQUENCE SEQ_bd1_ZEZNANIA INCREMENT BY 1 START WITH 1 MINVALUE 1;
CREATE SEQUENCE SEQ_bd1_SPRAWY_SADOWE INCREMENT BY 1 START WITH 1 MINVALUE 1;

PROMPT ;
PROMPT----------------------------------------;
PROMPT Trigger;
PROMPT----------------------------------------; 
PROMPT ;

	CREATE OR REPLACE TRIGGER T_BI_bd1_STANOWISKO
	BEFORE INSERT ON bd1_STANOWISKO
	FOR EACH ROW
	BEGIN
		IF :NEW.STA_ID IS NULL THEN
			SELECT SEQ_bd1_STANOWISKO.NEXTVAL 
				INTO :NEW.STA_ID FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_STANOWISKO - STA_ID='||:NEW.STA_ID);
		--
	END;
	/

	CREATE OR REPLACE TRIGGER T_BI_bd1_INSTYTUTY
	BEFORE INSERT ON bd1_INSTYTUTY
	FOR EACH ROW
	BEGIN
		IF :NEW.INS_ID IS NULL THEN
			SELECT SEQ_bd1_INSTYTUTY.NEXTVAL 
				INTO :NEW.INS_ID FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_INSTYTUTY - INS_ID='||:NEW.INS_ID);
		--
	END;
	/

	CREATE OR REPLACE TRIGGER T_BI_bd1_OSOBY
	BEFORE INSERT ON bd1_OSOBY
	FOR EACH ROW
	BEGIN
		IF :NEW.OSO_ID IS NULL THEN
			SELECT SEQ_bd1_OSOBY.NEXTVAL 
				INTO :NEW.OSO_ID FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_OSOBY - OSO_ID='||:NEW.OSO_ID);
		--
	END;
	/

	CREATE OR REPLACE TRIGGER T_BI_bd1_PRACOWNICY
	BEFORE INSERT ON bd1_PRACOWNICY
	FOR EACH ROW
	BEGIN
		IF :NEW.PRA_ID IS NULL THEN
			SELECT SEQ_bd1_PRACOWNICY.NEXTVAL 
				INTO :NEW.PRA_ID FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_PRACOWNICY - PRA_ID='||:NEW.PRA_ID);
		--
	END;
	/

	CREATE OR REPLACE TRIGGER T_BI_bd1_HISTORIA_ZATRUDNIENIA
	BEFORE INSERT ON bd1_HISTORIA_ZATRUDNIENIA
	FOR EACH ROW
	BEGIN
		IF :NEW.HIS_Pracownika_ID IS NULL THEN
			SELECT SEQ_bd1_HISTORIA_ZATRUDNIENIA.NEXTVAL 
				INTO :NEW.HIS_Pracownika_ID FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_HISTORIA_ZATRUDNIENIA - HIS_Pracownika_ID='||:NEW.HIS_Pracownika_ID);
		--
	END;
	/

	CREATE OR REPLACE TRIGGER T_BI_bd1_KLIENCI
	BEFORE INSERT ON bd1_KLIENCI
	FOR EACH ROW
	BEGIN
		IF :NEW.KLI_ID IS NULL THEN
			SELECT SEQ_bd1_KLIENCI.NEXTVAL 
				INTO :NEW.KLI_ID FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_KLIENCI - KLI_ID='||:NEW.KLI_ID);
		--
	END;
	/

	CREATE OR REPLACE TRIGGER T_BI_bd1_USLUGI
	BEFORE INSERT ON bd1_USLUGI
	FOR EACH ROW
	BEGIN
		IF :NEW.USL_ID IS NULL THEN
			SELECT SEQ_bd1_USLUGI.NEXTVAL 
				INTO :NEW.USL_ID FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_USLUGI - USL_ID='||:NEW.USL_ID);
		--
	END;
	/

	CREATE OR REPLACE TRIGGER T_BI_bd1_OSKARZENIA
	BEFORE INSERT ON bd1_OSKARZENIA
	FOR EACH ROW
	BEGIN
		IF :NEW.OSK_ID IS NULL THEN
			SELECT SEQ_bd1_OSKARZENIA.NEXTVAL 
				INTO :NEW.OSK_ID FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_OSKARZENIA - OSK_ID='||:NEW.OSK_ID);
		--
	END;
	/	
	
	CREATE OR REPLACE TRIGGER T_BI_bd1_KARY
	BEFORE INSERT ON bd1_KARY
	FOR EACH ROW
	BEGIN
		IF :NEW.KAR_ID IS NULL THEN
			SELECT SEQ_bd1_KARY.NEXTVAL 
				INTO :NEW.KAR_ID FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_KARY - KAR_ID='||:NEW.KAR_ID);
		--
	END;
	/

	CREATE OR REPLACE TRIGGER T_BI_bd1_PRZESTEPSTWA
	BEFORE INSERT ON bd1_PRZESTEPSTWA
	FOR EACH ROW
	BEGIN
		IF :NEW.PRZ_ID IS NULL THEN
			SELECT SEQ_bd1_PRZESTEPSTWA.NEXTVAL 
				INTO :NEW.PRZ_ID FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_PRZESTEPSTWA - PRZ_ID='||:NEW.PRZ_ID);
		--
	END;
	/	

	CREATE OR REPLACE TRIGGER T_BI_bd1_SLEDZTWA
	BEFORE INSERT ON bd1_SLEDZTWA
	FOR EACH ROW
	BEGIN
		IF :NEW.SLE_ID IS NULL THEN
			SELECT SEQ_bd1_SLEDZTWA.NEXTVAL 
				INTO :NEW.SLE_ID FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_SLEDZTWA - SLE_ID='||:NEW.SLE_ID);
		--
	END;
	/

	CREATE OR REPLACE TRIGGER T_BI_bd1_DOWODY
	BEFORE INSERT ON bd1_DOWODY
	FOR EACH ROW
	BEGIN
		IF :NEW.DOW_ID IS NULL THEN
			SELECT SEQ_bd1_DOWODY.NEXTVAL 
				INTO :NEW.DOW_ID FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_DOWODY - DOW_ID='||:NEW.DOW_ID);
		--
	END;
	/	

	CREATE OR REPLACE TRIGGER T_BI_bd1_STANOWISKO_SWIADKA
	BEFORE INSERT ON bd1_STANOWISKO_SWIADKA
	FOR EACH ROW
	BEGIN
		IF :NEW.STA_SW_ID IS NULL THEN
			SELECT SEQ_bd1_STANOWISKO_SWIADKA.NEXTVAL 
				INTO :NEW.STA_SW_ID FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_STANOWISKO_SWIADKA - STA_SW_ID='||:NEW.STA_SW_ID);
		--
	END;
	/		

	CREATE OR REPLACE TRIGGER T_BI_bd1_ZEZNANIA
	BEFORE INSERT ON bd1_ZEZNANIA
	FOR EACH ROW
	BEGIN
		IF :NEW.ZEZ_ID IS NULL THEN
			SELECT SEQ_bd1_ZEZNANIA.NEXTVAL 
				INTO :NEW.ZEZ_ID FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_ZEZNANIA - ZEZ_ID='||:NEW.ZEZ_ID);
		--
	END;
	/		

	CREATE OR REPLACE TRIGGER T_BI_bd1_SPRAWY_SADOWE
	BEFORE INSERT ON bd1_SPRAWY_SADOWE
	FOR EACH ROW
	BEGIN
		IF :NEW.SPR_ID IS NULL THEN
			SELECT SEQ_bd1_SPRAWY_SADOWE.NEXTVAL 
				INTO :NEW.SPR_ID FROM DUAL;
		END IF;
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_SPRAWY_SADOWE - SPR_ID='||:NEW.SPR_ID);
		--
	END;
	/	
	
PROMPT ;
PROMPT----------------------------------------;
PROMPT WSTAWIANIE WIERSZY;
PROMPT----------------------------------------; 
PROMPT ;

------------------------ DML bd1_STANOWISKO	------------------------
	insert into bd1_STANOWISKO (STA_Rodzaj,STA_OPIS,STA_Zarobki)
	values ('Prawnik','Obrona klienta','4000');
	
	insert into bd1_STANOWISKO (STA_Rodzaj,STA_OPIS,STA_Zarobki)
	values ('Prokurator','Oskazanie oskazonego','7500');
	
	insert into bd1_STANOWISKO (STA_Rodzaj,STA_OPIS,STA_Zarobki)
	values ('Sedzia Sadowy','Prowadzenie rozpraw','16000');
	
	insert into bd1_STANOWISKO (STA_Rodzaj,STA_OPIS,STA_Zarobki)
	values ('Komornik','','2500');
	
	insert into bd1_STANOWISKO (STA_Rodzaj,STA_OPIS,STA_Zarobki)
	values ('Radca Prawny','','5500');
	
	insert into bd1_STANOWISKO (STA_Rodzaj,STA_OPIS,STA_Zarobki)
	values ('Rzecznik patentowy','','4500');
	
	insert into bd1_STANOWISKO (STA_Rodzaj,STA_OPIS,STA_Zarobki)
	values ('Asystent sedziego','','3500');
	
	insert into bd1_STANOWISKO (STA_Rodzaj,STA_OPIS,STA_Zarobki)
	values ('Doradca prawny','','3500');

------------------------ DML bd1_INSTYTUTY	------------------------

	insert into bd1_INSTYTUTY (INS_Lokalizacja)
	values ('Krakow');

	insert into bd1_INSTYTUTY (INS_Lokalizacja)
	values ('Warszawa');

	insert into bd1_INSTYTUTY (INS_Lokalizacja)
	values ('Bochnia');
	
	insert into bd1_INSTYTUTY (INS_Lokalizacja)
	values ('Nowy Sacz');
	
	insert into bd1_INSTYTUTY (INS_Lokalizacja)
	values ('Limanowa');
	
	insert into bd1_INSTYTUTY (INS_Lokalizacja)
	values ('Mszalnica');
	
	insert into bd1_INSTYTUTY (INS_Lokalizacja)
	values ('Warszawa');
	
	insert into bd1_INSTYTUTY (INS_Lokalizacja)
	values ('Opole');

------------------------ DML bd1_OSOBY	------------------------

	insert into bd1_OSOBY (OSO_Imie,OSO_Nazwisko,OSO_Plec,OSO_Adres_Zamieszkania,OSO_Kod_Pocztowy,OSO_Telefon)
	values ('Jakub','Kowalski','Mezczyzna','Nowy Sacz','33-300','123-456-789');
	
	insert into bd1_OSOBY (OSO_Imie,OSO_Nazwisko,OSO_Plec,OSO_Adres_Zamieszkania,OSO_Kod_Pocztowy,OSO_Telefon)
	values ('Kamil','Nowak','Mezczyzna','Krakow','34-600','987-654-321');
	
	insert into bd1_OSOBY (OSO_Imie,OSO_Nazwisko,OSO_Plec,OSO_Adres_Zamieszkania,OSO_Kod_Pocztowy,OSO_Telefon)
	values ('Dominik','Filipek','Mezczyzna','Bochnia','33-500','123-987-456');
	
	insert into bd1_OSOBY (OSO_Imie,OSO_Nazwisko,OSO_Plec,OSO_Adres_Zamieszkania,OSO_Kod_Pocztowy,OSO_Telefon)
	values ('Natalia','Nowak','Kobieta','Krakow','33-661','987-654-321');
	
	insert into bd1_OSOBY (OSO_Imie,OSO_Nazwisko,OSO_Plec,OSO_Adres_Zamieszkania,OSO_Kod_Pocztowy,OSO_Telefon)
	values ('Artur','Nowak','Mezczyzna','Krakow','33-661',NULL);
	
	insert into bd1_OSOBY (OSO_Imie,OSO_Nazwisko,OSO_Plec,OSO_Adres_Zamieszkania,OSO_Kod_Pocztowy,OSO_Telefon)
	values ('Julia','Kowalski','Kobieta','Nowy Sacz','33-300',NULL);
	
	insert into bd1_OSOBY (OSO_Imie,OSO_Nazwisko,OSO_Plec,OSO_Adres_Zamieszkania,OSO_Kod_Pocztowy,OSO_Telefon)
	values ('Pawel','Ciula','Mezczyzna','Limanowa',NULL,NULL);
	
	insert into bd1_OSOBY (OSO_Imie,OSO_Nazwisko,OSO_Plec,OSO_Adres_Zamieszkania,OSO_Kod_Pocztowy,OSO_Telefon)
	values ('Kamila','Nowak','Kobieta','Krakow',NULL,NULL);
	
	insert into bd1_OSOBY (OSO_Imie,OSO_Nazwisko,OSO_Plec,OSO_Adres_Zamieszkania,OSO_Kod_Pocztowy,OSO_Telefon)
	values ('Szymon','Karambol','Mezczyzna','Limanowa',NULL,NULL);

------------------------ DML bd1_PRACOWNICY	------------------------

	insert into bd1_PRACOWNICY (OSO_ID)
	values ('1');
	
	insert into bd1_PRACOWNICY (OSO_ID)
	values ('2');
	
	insert into bd1_PRACOWNICY (OSO_ID)
	values ('5');
	
	insert into bd1_PRACOWNICY (OSO_ID)
	values ('6');

------------------------ DML bd1_HISTORIA_ZATRUDNIENIA	------------------------

	insert into bd1_HISTORIA_ZATRUDNIENIA (HIS_Data_Zatrudnienia,HIS_Data_Zwolnienia,STA_ID,INS_ID,PRA_ID)
	values ('2021-03-21','','1','3','1');
	insert into bd1_HISTORIA_ZATRUDNIENIA (HIS_Data_Zatrudnienia,HIS_Data_Zwolnienia,STA_ID,INS_ID,PRA_ID)
	values ('2019-02-11','','2','3','2');
	insert into bd1_HISTORIA_ZATRUDNIENIA (HIS_Data_Zatrudnienia,HIS_Data_Zwolnienia,STA_ID,INS_ID,PRA_ID)
	values ('2019-01-15','2021-09-11','2','4','3');
	insert into bd1_HISTORIA_ZATRUDNIENIA (HIS_Data_Zatrudnienia,HIS_Data_Zwolnienia,STA_ID,INS_ID,PRA_ID)
	values ('2019-09-06','','3','4','4');

------------------------ DML bd1_KLIENCI ------------------------

	insert into bd1_KLIENCI (OSO_ID)
	values ('3');
	
	insert into bd1_KLIENCI (OSO_ID)
	values ('4');
	
	insert into bd1_KLIENCI (OSO_ID)
	values ('7');
	
	insert into bd1_KLIENCI (OSO_ID)
	values ('8');
	
	insert into bd1_KLIENCI (OSO_ID)
	values ('9');

------------------------ DML bd1_USLUGI	------------------------
	
	insert into bd1_USLUGI (PRA_ID,KLI_ID)
	values ('2','1');
	
	insert into bd1_USLUGI (PRA_ID,KLI_ID)
	values ('2','2');
	
	insert into bd1_USLUGI (PRA_ID,KLI_ID)
	values ('2','3');
	
	insert into bd1_USLUGI (PRA_ID,KLI_ID)
	values ('2','2');

	insert into bd1_USLUGI (PRA_ID,KLI_ID)
	values ('4','3');
	
	insert into bd1_USLUGI (PRA_ID,KLI_ID)
	values ('4','3');

------------------------ DML bd1_OSKARZENIA	------------------------

	insert into bd1_OSKARZENIA (OSK_Data,OSK_Rodzaj)
	values ('2021-10-02','Przestepstwo drogowe');
	

	insert into bd1_OSKARZENIA (OSK_Data,OSK_Rodzaj)
	values ('2020-05-11','Oszustwo');

	insert into bd1_OSKARZENIA (OSK_Data,OSK_Rodzaj)
	values ('2019-10-03','Kradziez');

------------------------ DML bd1_KARY ------------------------

	insert into bd1_KARY (KAR_Wyrok,KAR_Data_Rozpoczecia,KAR_Data_Zakonczenia,OSK_ID)
	values ('Wiezienie','2021-11-29','2025-11-21','2');
	
	insert into bd1_KARY (KAR_Wyrok,KAR_Data_Rozpoczecia,KAR_Data_Zakonczenia,OSK_ID)
	values ('Wyrok w zawieszeniu','2021-10-15','2022-11-15','1');

------------------------ DML bd1_PRZESTEPSTWA ------------------------

	insert into bd1_PRZESTEPSTWA (PRZ_Data,PRZ_Rodzaj)
	values ('2021-11-27','Drogowe');
	
	insert into bd1_PRZESTEPSTWA (PRZ_Data,PRZ_Rodzaj)
	values ('2021-10-21','Bezprawne zbieranie danych o zyciu prywatnym');

------------------------ DML bd1_SLEDZTWA ------------------------

	insert into bd1_SLEDZTWA (SLE_Data,PRZ_ID)
	values ('2021-11-15','2');
	
	insert into bd1_SLEDZTWA (SLE_Data,PRZ_ID)
	values ('2019-11-15','1');

------------------------ DML bd1_DOWODY ------------------------

	insert into bd1_DOWODY (DOW_Opis,DOW_Rodzaj,SLE_ID)
	values ('Dowod zebrany z miejsca zbrodni','Bron','1');
	
	insert into bd1_DOWODY (DOW_Opis,DOW_Rodzaj,SLE_ID)
	values ('Dowod zabezpieczony w domu oskazonego','Przedmiot kradiezy','2');
	
	insert into bd1_DOWODY (DOW_Opis,DOW_Rodzaj,SLE_ID)
	values (NULL,'Przedmiot kradiezy','1');

------------------------ DML bd1_STANOWISKO_SWIADKA	------------------------

	insert into bd1_STANOWISKO_SWIADKA (STA_SW_Zeznania,STA_SW_Data,STA_SW_Rodzaj,STA_SW_Typ_Swiadka,STA_SW_Opis)
	values ('Zeznanie na korzysc oskazonego','2021-10-09','Swiadek zdarzenia','Brat Oskazonego','Zeznanie swojej wersje zdarzen');
	
	insert into bd1_STANOWISKO_SWIADKA (STA_SW_Zeznania,STA_SW_Data,STA_SW_Rodzaj,STA_SW_Typ_Swiadka,STA_SW_Opis)
	values ('Zeznanie na niekorzysc oskazonego','2019-11-09','Swiadek zdarzenia','Przypadkowa osoba','Zeznanie swojej wersje zdarzen');
	
	insert into bd1_STANOWISKO_SWIADKA (STA_SW_Zeznania,STA_SW_Data,STA_SW_Rodzaj,STA_SW_Typ_Swiadka,STA_SW_Opis)
	values ('Zeznanie na niekorzysc oskazonego','2021-06-09','Swiadek zdarzenia','Ojciec ofiary','Zeznanie swojej wersje zdarzen');
	
	insert into bd1_STANOWISKO_SWIADKA (STA_SW_Zeznania,STA_SW_Data,STA_SW_Rodzaj,STA_SW_Typ_Swiadka,STA_SW_Opis)
	values ('Zeznanie na korzysc oskazonego','2021-05-10','Swiadek zdarzenia','Siostra oskazonego','Zeznanie swojej wersje zdarzen');
	
	insert into bd1_STANOWISKO_SWIADKA (STA_SW_Zeznania,STA_SW_Data,STA_SW_Rodzaj,STA_SW_Typ_Swiadka,STA_SW_Opis)
	values ('Zeznanie na niekorzysc oskazonego','2021-08-21','Swiadek zdarzenia','Matka ofiary','Zeznanie swojej wersje zdarzen');

------------------------ DML bd1_ZEZNANIA ------------------------

	insert into bd1_ZEZNANIA (ZEZ_Typ,ZEZ_Opis,DOW_ID,STA_SW_ID,OSK_ID)
	values ('Opinia bieglego','Brak mozliwosc wykorzystania zeznan','2','1','3');
	insert into bd1_ZEZNANIA (ZEZ_Typ,ZEZ_Opis,DOW_ID,STA_SW_ID,OSK_ID)
	values ('Opinia bieglego','Mozna wykorzystac zeznan','2','2','3');

------------------------ DML bd1_SPRAWY_SADOWE ------------------------

	insert into bd1_SPRAWY_SADOWE (PRZ_ID,USL_ID)
	values ('1','1');
	insert into bd1_SPRAWY_SADOWE (PRZ_ID,USL_ID)
	values ('2','2');

PROMPT ;
PROMPT----------------------------------------;
PROMPT SELECTY;
PROMPT----------------------------------------; 
PROMPT ;

	column STA_ID HEADING 'ID' for 999999
	column STA_Rodzaj HEADING 'Rodzaj stanowiska' for A35
	column STA_OPIS HEADING 'Opis stanowiska' for A35
	column STA_Zarobki HEADING 'Stanowisko zarobki' for 999999

	select * from bd1_STANOWISKO;	

	column INS_ID HEADING 'ID' for 999999
	column INS_Lokalizacja HEADING 'Lokalizacja instytutu' for A20

	select * from bd1_INSTYTUTY;

	column OSO_ID HEADING 'ID' for 999999
	column OSO_Imie HEADING 'Imie' for A20
	column OSO_Nazwisko HEADING 'Nazwisko' for A20
	column OSO_Plec HEADING 'Plec' for A20
	column OSO_Adres_Zamieszkania HEADING 'Adres Zamieszkania' for A20
	column OSO_Kod_Pocztowy HEADING 'Kod Pocztowy' for A20
	column OSO_Telefon HEADING 'Numer Telefonu' for A20

	select * from bd1_OSOBY;

	column PRA_ID HEADING 'ID_Pracownika' for 999999
	column OSO_ID HEADING 'ID_Osoby' for 99999

	select * from bd1_PRACOWNICY;

	column HIS_Pracownika_ID HEADING 'ID Histori Pracownika' for 999999
	column HIS_Data_Zatrudnienia HEADING 'Data Zatrudnienia' for A20
	column HIS_Data_Zwolnienia HEADING 'Data Zwolnienia' for A20
	column STA_ID HEADING 'Stanowisko ID' for 999999
	column INS_ID HEADING 'Instytut ID' for 999999
	column PRA_ID HEADING 'Pracownik ID' for 999999
	
	select * from bd1_HISTORIA_ZATRUDNIENIA;	

	column KLI_ID HEADING 'ID_Klienta' for 999999
	column OSO_ID HEADING 'ID_Osoby' for 99999

	select * from bd1_KLIENCI;

	column USL_ID HEADING 'ID_Uslugi' for 999999
	column PRA_ID HEADING 'ID_Pracownika' for 99999
	column KLI_ID HEADING 'ID_Klienta' for 99999

	select * from bd1_USLUGI;

	column OSK_ID HEADING 'ID_Oskarzenia' for 999999
	column OSK_Data HEADING 'Data oskarzenia' for A20
	column OSK_Rodzaj HEADING 'Rodzaj oskarzenia' for A30

	select * from bd1_OSKARZENIA;

	column KAR_ID HEADING 'ID_Kary' for 999999
	column KAR_Wyrok HEADING 'Wyrok' for A30
	column KAR_Data_Rozpoczecia HEADING 'Data rozpoczecia kary' for A25
	column KAR_Data_Zakonczenia HEADING 'Data zakonczenia kary' for A25
	column OSK_ID HEADING 'ID_Oskarzenia' for 99999

	select * from bd1_KARY;

	column PRZ_ID HEADING 'ID_Przestepstwa' for 999999
	column PRZ_Data HEADING 'Data przestepstwa' for A20
	column PRZ_Rodzaj HEADING 'Rodzaj przestepstwa' for A35
	column PRZ_Uwagi HEADING 'Uwagi' for A25

	select * from bd1_PRZESTEPSTWA;

	column SLE_ID HEADING 'ID_Przestepstwa' for 999999
	column SLE_Data HEADING 'Data sledztwa' for A20
	column PRZ_ID HEADING 'ID_Przestepstwa' for 99999

	select * from bd1_SLEDZTWA;		

	column DOW_ID HEADING 'ID_Dowodu' for 999999
	column DOW_Opis HEADING 'Opis dowodu' for A40
	column DOW_Rodzaj HEADING 'Rodzaj dowodu' for A25
	column SLE_ID HEADING 'ID_Sledztwa' for 99999

	select * from bd1_DOWODY;

	column STA_SW_ID HEADING 'ID_Stanowiska_Swiadka' for 999999
	column STA_SW_Zeznania HEADING 'Stanowisko swiadka zeznania' for A35
	column STA_SW_Data HEADING 'Data skladania stanowiska' for A32
	column STA_SW_Rodzaj HEADING 'Rodzaj stanowiska swiadka' for A30
	column STA_SW_Typ_Swiadka HEADING 'Typ swiadka' for A25
	column STA_SW_Opis HEADING 'Opis stanowiska swiadka' for A32

	select * from bd1_STANOWISKO_SWIADKA;	

	column ZEZ_ID HEADING 'ID_Zeznan' for 999999
	column ZEZ_Typ HEADING 'Typ zeznania' for A35
	column ZEZ_Opis HEADING 'Opis zeznania' for A35
	column DOW_ID HEADING 'ID_Dowodu' for 99999
	column STA_SW_ID HEADING 'ID_Stanowiska_Swiadka' for 99999
	column OSK_ID HEADING 'ID_Oskarzenia' for 99999

	select * from bd1_ZEZNANIA;

	column SPR_ID HEADING 'ID_Sprawy_Sadowej' for 999999
	column PRZ_ID HEADING 'ID_Przestepstwa' for 99999
	column USL_ID HEADING 'ID_Uslugi' for 99999
	
	select * from bd1_SPRAWY_SADOWE;

PROMPT ;
PROMPT----------------------------------------;
PROMPT PODSUMOWANIE;
PROMPT----------------------------------------; 
PROMPT ;

-- describe USER_TABLES
	column TABLE_NAME HEADING 'NAME' for A32
	column DROPPED HEADING 'NAME' for A32

PROMPT Lista utworzonych tabel:	

SELECT TABLE_NAME FROM USER_TABLES
WHERE DROPPED='NO';


SELECT * FROM BD1_OSOBY WHERE OSO_ID > '5';

SELECT OSO_ID,OSO_Imie,OSO_Nazwisko,OSO_Plec,OSO_Adres_Zamieszkania FROM bd1_OSOBY WHERE OSO_Nazwisko='Nowak' AND OSO_Adres_Zamieszkania='Limanowa'; 
 
SELECT HIS_Pracownika_ID,HIS_Data_Zatrudnienia,HIS_Data_Zwolnienia,INS_Lokalizacja FROM bd1_HISTORIA_ZATRUDNIENIA, bd1_INSTYTUTY WHERE bd1_HISTORIA_ZATRUDNIENIA.INS_ID=bd1_INSTYTUTY.INS_ID AND INS_Lokalizacja='Bochnia';

SELECT * FROM bd1_KARY WHERE KAR_Data_Zakonczenia > '2020-01-01' AND KAR_WYROK='Wiezienie';
	  
UPDATE bd1_HISTORIA_ZATRUDNIENIA SET HIS_Data_Zwolnienia='2021-12-07' WHERE HIS_Pracownika_ID LIKE '1';
SELECT * FROM bd1_HISTORIA_ZATRUDNIENIA WHERE HIS_Pracownika_ID LIKE '1';

SELECT OSO_Imie,OSO_Nazwisko, NVL(OSO_Telefon, 'nie podano numeru telefonu') Numer_Telefonu FROM bd1_OSOBY;

SELECT DOW_ID,SLE_ID,DOW_Rodzaj, NVL(DOW_Opis, 'nie podano opisu') DOW_Opis FROM bd1_DOWODY;

SELECT KAR_ID, KAR_Wyrok,KAR_Data_Rozpoczecia,KAR_Data_Zakonczenia, NVL(ROUND(KAR_Data_Zakonczenia - CURRENT_DATE), 0) Koniec_za FROM bd1_KARY;

SELECT OSO_Imie,OSO_Nazwisko, NVL(OSO_Kod_Pocztowy, 'nie podano kodu pocztowego') Kod_pocztowy FROM bd1_OSOBY;

SELECT kli.KLI_ID,kli.OSO_ID,oso.OSO_Imie,oso.OSO_Nazwisko,oso.OSO_Plec,oso.OSO_Adres_Zamieszkania
FROM bd1_KLIENCI kli 
INNER JOIN bd1_OSOBY oso ON kli.OSO_ID=oso.OSO_ID;

SELECT his.HIS_Data_Zatrudnienia,his.PRA_ID,ins.INS_Lokalizacja,sta.STA_OPIS
FROM bd1_HISTORIA_ZATRUDNIENIA his 
INNER JOIN bd1_INSTYTUTY ins ON his.INS_ID=ins.INS_ID 
INNER JOIN bd1_STANOWISKO sta ON his.STA_ID=sta.STA_ID;

COLUMN pracownik HEADING 'Imie i nazwisko pracownika' FORMAT A26
COLUMN klient HEADING 'Imie i nazwisko klienta' FORMAT A25
COLUMN rodzaj HEADING 'Rodzaj przestepstwa klienta' FORMAT A35
SELECT spr.SPR_ID,oso.OSO_Imie||' '|| oso.OSO_Nazwisko AS pracownik,oso_.OSO_Imie|| ' ' ||oso_.OSO_Nazwisko AS klient, prze.PRZ_Rodzaj AS rodzaj  
FROM bd1_SPRAWY_SADOWE spr 
INNER JOIN bd1_USLUGI usl ON spr.USL_ID=usl.USL_ID
INNER JOIN bd1_PRACOWNICY pra ON usl.PRA_ID=pra.PRA_ID  
INNER JOIN bd1_KLIENCI kli ON usl.KLI_ID=kli.KLI_ID
INNER JOIN bd1_OSOBY oso ON pra.OSO_ID=oso.OSO_ID 
INNER JOIN bd1_OSOBY oso_ ON kli.OSO_ID=oso_.OSO_ID
INNER JOIN bd1_PRZESTEPSTWA prze ON spr.PRZ_ID=prze.PRZ_ID;

--------HAVING---------

-- ilosc instytutow znajduajcych sie w tym samym miescie (min 2)
SELECT INS_Lokalizacja, COUNT(INS_Lokalizacja) AS Ilosc FROM bd1_INSTYTUTY GROUP BY INS_Lokalizacja HAVING COUNT(INS_Lokalizacja)>1;

-- ilosc osob o tym samym nazwisku w bazie danych (min 2)
COLUMN a HEADING 'Ilosc osob o takim samym nazwisku'
SELECT OSO_Nazwisko, COUNT(OSO_Nazwisko) AS a FROM bd1_OSOBY GROUP BY OSO_Nazwisko HAVING COUNT(OSO_Nazwisko)>1 ORDER BY OSO_Nazwisko DESC;

-- stanowiska swiadkow zdarzen w bazie danych zeznane po dacie 2020-01-01 ustawione w kolejnosci malejacej (od najnowszych do najstarszych)
SELECT STA_SW_Rodzaj,STA_SW_Data  FROM bd1_STANOWISKO_SWIADKA GROUP BY STA_SW_Data,STA_SW_Rodzaj HAVING MAX(STA_SW_Data) > '2020-01-01' ORDER BY STA_SW_Data DESC;

COLUMN pracownik HEADING 'Imie i nazwisko pracownika' FORMAT A26 
SELECT pra.PRA_ID, his.HIS_Data_Zatrudnienia, oso.OSO_Imie||' '|| oso.OSO_Nazwisko AS pracownik, sta.STA_Rodzaj, sta.STA_Zarobki FROM  bd1_HISTORIA_ZATRUDNIENIA his 
INNER JOIN bd1_PRACOWNICY pra ON his.PRA_ID=pra.PRA_ID  
INNER JOIN bd1_OSOBY oso ON pra.OSO_ID=oso.OSO_ID 
INNER JOIN bd1_STANOWISKO sta ON his.STA_ID=sta.STA_ID
WHERE sta.STA_Zarobki BETWEEN (SELECT AVG(STA_Zarobki) FROM bd1_STANOWISKO) AND (SELECT MAX(STA_Zarobki) FROM bd1_STANOWISKO); 

COLUMN pracownik HEADING 'Imie i nazwisko pracownika' FORMAT A26 
SELECT pra.PRA_ID, his.HIS_Data_Zatrudnienia, oso.OSO_Imie||' '|| oso.OSO_Nazwisko AS pracownik,ins.INS_Lokalizacja, sta.STA_Rodzaj, sta.STA_Zarobki  FROM  bd1_HISTORIA_ZATRUDNIENIA his 
INNER JOIN bd1_PRACOWNICY pra ON his.PRA_ID=pra.PRA_ID  
INNER JOIN bd1_OSOBY oso ON pra.OSO_ID=oso.OSO_ID 
INNER JOIN bd1_STANOWISKO sta ON his.STA_ID=sta.STA_ID
INNER JOIN bd1_STANOWISKO sta ON his.STA_ID=sta.STA_ID
INNER JOIN bd1_INSTYTUTY ins ON his.INS_ID=ins.INS_ID
WHERE sta.STA_Rodzaj IN(SELECT sta.STA_Rodzaj FROM bd1_STANOWISKO WHERE sta.STA_Rodzaj LIKE 'Prokurator'); 

CREATE OR REPLACE VIEW Informacje_o_pracowniku(ID_Pracownika, Zatrudnienia, Imie_i_nazwisko_pracownika, Rodzaj_stanowiska, Stanowisko_zarobki)
AS SELECT pra.PRA_ID, his.HIS_Data_Zatrudnienia, oso.OSO_Imie||' '|| oso.OSO_Nazwisko AS pracownik, sta.STA_Rodzaj, sta.STA_Zarobki FROM  bd1_HISTORIA_ZATRUDNIENIA his 
INNER JOIN bd1_PRACOWNICY pra ON his.PRA_ID=pra.PRA_ID  
INNER JOIN bd1_OSOBY oso ON pra.OSO_ID=oso.OSO_ID 
INNER JOIN bd1_STANOWISKO sta ON his.STA_ID=sta.STA_ID
WHERE sta.STA_Zarobki BETWEEN (SELECT AVG(STA_Zarobki) FROM bd1_STANOWISKO) AND (SELECT MAX(STA_Zarobki) FROM bd1_STANOWISKO); 

describe Informacje_o_pracowniku;

CREATE OR REPLACE VIEW Informacje_o_prokuratorach(ID_Pracownika, Zatrudnienia, Imie_i_nazwisko_pracownika, Lokalizacja_instytut, Rodzaj_stanowiska, Stanowisko_zarobki)
AS SELECT pra.PRA_ID, his.HIS_Data_Zatrudnienia, oso.OSO_Imie||' '|| oso.OSO_Nazwisko AS pracownik,ins.INS_Lokalizacja, sta.STA_Rodzaj, sta.STA_Zarobki  FROM  bd1_HISTORIA_ZATRUDNIENIA his 
INNER JOIN bd1_PRACOWNICY pra ON his.PRA_ID=pra.PRA_ID  
INNER JOIN bd1_OSOBY oso ON pra.OSO_ID=oso.OSO_ID 
INNER JOIN bd1_STANOWISKO sta ON his.STA_ID=sta.STA_ID
INNER JOIN bd1_STANOWISKO sta ON his.STA_ID=sta.STA_ID
INNER JOIN bd1_INSTYTUTY ins ON his.INS_ID=ins.INS_ID
WHERE sta.STA_Rodzaj IN(SELECT sta.STA_Rodzaj FROM bd1_STANOWISKO WHERE sta.STA_Rodzaj LIKE 'Prokurator');

describe Informacje_o_prokuratorach;

---------------------------	INDEX MONITORING ---------------------------	

	column INDEX_NAME HEADING 'NAME' for A32
    column INDEX_TYPE HEADING 'TYPE' for A10
    column TABLE_NAME HEADING 'TABLE' for A20
    column PF HEADING 'PCT_FREE' for 9999999
    column IE HEADING '1oEXTENT' for 9999999
    
    SELECT INDEX_NAME,INDEX_TYPE,TABLE_NAME,
            PCT_FREE||'[%]' PF,
            INITIAL_EXTENT/1024||'[kB]' IE 
    FROM USER_INDEXES;  
	
Commit;

select ROWID, OSO_ID, OSO_IMIE, OSO_NAZWISKO, OSO_Adres_Zamieszkania from bd1_OSOBY;

insert into bd1_OSOBY (OSO_Imie,OSO_Nazwisko,OSO_Plec,OSO_Adres_Zamieszkania,OSO_Kod_Pocztowy,OSO_Telefon)
	values ('Piotr','Kasparow','Mezczyzna','Limanowa','34-600','123-456-789');
	
select ROWID, OSO_ID, OSO_IMIE, OSO_NAZWISKO, OSO_Adres_Zamieszkania from bd1_OSOBY;

rollback;

select ROWID, OSO_ID, OSO_IMIE, OSO_NAZWISKO, OSO_Adres_Zamieszkania from bd1_OSOBY;

UPDATE bd1_OSOBY SET OSO_Adres_Zamieszkania = 'Warszawa' WHERE OSO_ID = 8;

select ROWID, OSO_ID, OSO_IMIE, OSO_NAZWISKO, OSO_Adres_Zamieszkania from bd1_OSOBY;

SAVEPOINT trs_BeforeDelete;

DELETE FROM bd1_OSOBY WHERE OSO_NAZWISKO LIKE 'Ciula';

select ROWID, OSO_ID, OSO_IMIE, OSO_NAZWISKO, OSO_Adres_Zamieszkania from bd1_OSOBY;

ROLLBACK TO SAVEPOINT trs_BeforeDelete;

select ROWID, OSO_ID, OSO_IMIE, OSO_NAZWISKO, OSO_Adres_Zamieszkania from bd1_OSOBY;

commit work;
	
---------------------------  PROCEDURE bd1_pINSERT_Dowody ---------------------------

CREATE OR REPLACE PROCEDURE bd1_pINSERT_Dowody(
						inDOW_Opis IN bd1_DOWODY.DOW_Opis%TYPE,
						inDOW_Rodzaj IN bd1_DOWODY.DOW_Rodzaj%TYPE,
						inSLE_ID IN bd1_DOWODY.SLE_ID%TYPE,
						inMnoznik IN number,
						ile IN number)
	IS
		mnoznik number;
	BEGIN
		IF inMnoznik < 50 THEN 
			mnoznik := 50;
		ELSIF inMnoznik > 100 and inMnoznik < 200 THEN 
			mnoznik := 100;
		ELSE 
			mnoznik := 200;
		END IF;
		--
		for licznikPETLI IN 1 .. ile
	loop
		insert into bd1_DOWODY (DOW_Opis,DOW_Rodzaj,SLE_ID)
		values (inDOW_Opis||(inMnoznik+mnoznik+licznikPETLI),inDOW_Rodzaj,inSLE_ID);
	end loop;
END;
/

Select * from bd1_DOWODY;

	exec bd1_pINSERT_Dowody('Dowod znaleziony przy oskazonym nr ','Kradziez przedmiot','2',10,5);
	
Select * from bd1_DOWODY;

CREATE OR REPLACE FUNCTION bd1_fINSERT_Dowody(
					inDOW_Opis IN bd1_DOWODY.DOW_Opis%TYPE,
					inDOW_Rodzaj IN bd1_DOWODY.DOW_Rodzaj%TYPE,
					inSLE_ID IN bd1_DOWODY.SLE_ID%TYPE,
					inMnoznik IN number,
					ile IN number)
RETURN varchar2
IS
	mnoznik number;
	newDOW_ID bd1_DOWODY.DOW_ID%TYPE;
BEGIN
	IF ile < 10 THEN 
		mnoznik := 1;
	ELSIF ile > 50 and ile < 100 THEN 
		mnoznik := 10;
	ELSE 
		mnoznik := 100;
	END IF;
	
	for licznikPetli IN 1 .. ile
	loop
		insert into bd1_DOWODY (DOW_Opis,DOW_Rodzaj,SLE_ID)
		values (inDOW_Opis||(inMnoznik+mnoznik+licznikPETLI),inDOW_Rodzaj,inSLE_ID);
		--
		SELECT SEQ_bd1_DOWODY.CURRVAL INTO newDOW_ID FROM DUAL; 
		--
		DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do bd1_DOWODY - DOW_ID='||newDOW_ID);
	end loop;
	RETURN 'Dodano '||ile||' wierszy';
END;
/

Select * from bd1_DOWODY;

	BEGIN
		DBMS_OUTPUT.PUT_LINE(bd1_fINSERT_Dowody('Dowod znaleziony przy oskazonym nr ','Kradziez przedmiot','2',10,5));
	END;
	/

Select * from bd1_DOWODY;

---------------------------  VIEW bd1_V_Postepowanie_w_sprawie ---------------------------

	CREATE OR REPLACE VIEW bd1_V_Postepowanie_w_sprawie 
	AS
	select o.OSK_ID,o.OSK_Data,o.OSK_Rodzaj,
		k.KAR_ID,k.KAR_Wyrok,k.KAR_Data_Rozpoczecia,k.KAR_Data_Zakonczenia	
		from bd1_OSKARZENIA o, bd1_KARY k
		where o.OSK_ID = k.OSK_ID;

		select * from bd1_V_Postepowanie_w_sprawie order by OSK_ID;

---------------------------  PROCEDURE bd1_p_INSERT_zez_swi ---------------------------

CREATE OR REPLACE VIEW bd1_V_zez_swi 
	AS
	select z.ZEZ_ID,s.STA_SW_OPIS, s.STA_SW_Data, z.ZEZ_Typ, z.ZEZ_Opis
		from bd1_ZEZNANIA Z
		INNER JOIN bd1_STANOWISKO_SWIADKA s on z.STA_SW_ID=s.STA_SW_ID;

		select * from bd1_V_zez_swi;



CREATE OR REPLACE Procedure bd1_p_zez_swi(
	inSTA_SW_Zeznania IN bd1_STANOWISKO_SWIADKA.STA_SW_Zeznania%TYPE,
	inSTA_SW_Data IN bd1_STANOWISKO_SWIADKA.STA_SW_Data%TYPE,
	inSTA_SW_Rodzaj IN bd1_STANOWISKO_SWIADKA.STA_SW_Rodzaj%TYPE,
	inSTA_SW_Typ_Swiadka IN bd1_STANOWISKO_SWIADKA.STA_SW_Typ_Swiadka%TYPE,
	inSTA_SW_OPIS IN bd1_STANOWISKO_SWIADKA.STA_SW_OPIS%TYPE,
	inZEZ_Typ IN bd1_ZEZNANIA.ZEZ_Typ%TYPE,
	inZEZ_Opis IN bd1_ZEZNANIA.ZEZ_Opis%TYPE,
	inDOW_ID IN bd1_ZEZNANIA.DOW_ID%TYPE,
	inSTA_SW_ID IN bd1_ZEZNANIA.STA_SW_ID%TYPE,
	inOSK_ID IN bd1_ZEZNANIA.OSK_ID%TYPE	
		
	)
IS
	PRAGMA AUTONOMOUS_TRANSACTION;
	STA_SW_ID_curr bd1_STANOWISKO_SWIADKA.STA_SW_ID%TYPE;
	ZEZ_ID_curr bd1_ZEZNANIA.ZEZ_ID%TYPE;
	
BEGIN
	-- kursor niejawny INSERT
	insert into bd1_STANOWISKO_SWIADKA (STA_SW_Zeznania,STA_SW_Data,STA_SW_Rodzaj,STA_SW_Typ_Swiadka,STA_SW_Opis)
	values (inSTA_SW_Zeznania,inSTA_SW_Data,inSTA_SW_Rodzaj,inSTA_SW_Typ_Swiadka,inSTA_SW_OPIS);
	--
		-- niebezpieczne jeśli na bazie pracuje wielu użytkowników:
		SELECT SEQ_bd1_STANOWISKO_SWIADKA.CURRVAL INTO STA_SW_ID_curr FROM DUAL; 
	--
	-- kursor niejawny INSERT
	insert into bd1_ZEZNANIA (ZEZ_Typ,ZEZ_Opis,DOW_ID,STA_SW_ID,OSK_ID)
	values (inZEZ_Typ,inZEZ_Opis,inDOW_ID,inSTA_SW_ID,inOSK_ID);
	--
		-- niebezpieczne jeśli na bazie pracuje wielu użytkowników:
		SELECT SEQ_bd1_STANOWISKO.CURRVAL INTO ZEZ_ID_curr FROM DUAL;
	--
	DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz bd1_STANOWISKO_SWIADKA - ID='||STA_SW_ID_curr);
	--
	DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz bd1_ZEZNANIA - ID='||ZEZ_ID_curr);
	--
	-- prosta obsługa transakcji
IF STA_SW_ID_curr > 0 and ZEZ_ID_curr > 0 THEN 
		COMMIT;
	ELSE 
		ROLLBACK;
	END IF;
	--
END;
/

exec bd1_p_zez_swi('Zeznanie na korzysc oskazonego','2022-01-25','Przechodzen','Obywatel','Zeznal swoja wersje zdarzen','Opinia bieglego','mozna wykorzystac',1,2,1);

select * from bd1_V_zez_swi;

CREATE OR REPLACE Procedure bd1_pr_zez_swi(
	inSTA_SW_Zeznania IN bd1_STANOWISKO_SWIADKA.STA_SW_Zeznania%TYPE,
	inSTA_SW_Data IN bd1_STANOWISKO_SWIADKA.STA_SW_Data%TYPE,
	inSTA_SW_Rodzaj IN bd1_STANOWISKO_SWIADKA.STA_SW_Rodzaj%TYPE,
	inSTA_SW_Typ_Swiadka IN bd1_STANOWISKO_SWIADKA.STA_SW_Typ_Swiadka%TYPE,
	inSTA_SW_OPIS IN bd1_STANOWISKO_SWIADKA.STA_SW_OPIS%TYPE,
	inZEZ_Typ IN bd1_ZEZNANIA.ZEZ_Typ%TYPE,
	inZEZ_Opis IN bd1_ZEZNANIA.ZEZ_Opis%TYPE,
	inDOW_ID IN bd1_ZEZNANIA.DOW_ID%TYPE,
	inSTA_SW_ID IN bd1_ZEZNANIA.STA_SW_ID%TYPE,
	inOSK_ID IN bd1_ZEZNANIA.OSK_ID%TYPE	
		
	)
IS
	PRAGMA AUTONOMOUS_TRANSACTION;
	STA_SW_ID_curr bd1_STANOWISKO_SWIADKA.STA_SW_ID%TYPE;
	ZEZ_ID_curr bd1_ZEZNANIA.ZEZ_ID%TYPE;
	
BEGIN
	-- kursor niejawny INSERT
	insert into bd1_STANOWISKO_SWIADKA (STA_SW_Zeznania,STA_SW_Data,STA_SW_Rodzaj,STA_SW_Typ_Swiadka,STA_SW_Opis)
	values (inSTA_SW_Zeznania,inSTA_SW_Data,inSTA_SW_Rodzaj,inSTA_SW_Typ_Swiadka,inSTA_SW_OPIS)
	RETURNING STA_SW_ID
	INTO STA_SW_ID_curr;
	
	IF SQL%FOUND then
		insert into bd1_ZEZNANIA (ZEZ_Typ,ZEZ_Opis,DOW_ID,STA_SW_ID,OSK_ID)
		values (inZEZ_Typ,inZEZ_Opis,inDOW_ID,inSTA_SW_ID,inOSK_ID)
		RETURNING ZEZ_ID
		INTO ZEZ_ID_curr;
		
		IF SQL%FOUND then
	DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz bd1_STANOWISKO_SWIADKA - ID='||STA_SW_ID_curr);
	commit;
	ELSE
	DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz bd1_ZEZNANIA - ID='||ZEZ_ID_curr);
					ROLLBACK;

				END IF;
		ELSE
			rollback;
		END IF;
END;
/

exec bd1_pr_zez_swi('Zeznanie na niekorzysc oskazonego','2022-01-28','Przechodzen','Policjant','Zeznal swoja wersje zdarzen','Opinia bieglego','nie mozna wykorzystac',2,3,2);

select * from bd1_V_zez_swi;

CREATE OR REPLACE VIEW bd1_V_kli_oso 
	AS
	select k.KLI_ID, k.OSO_ID, OSO_Imie, OSO_Nazwisko, OSO_Plec, OSO_Adres_Zamieszkania, OSO_Kod_Pocztowy, OSO_Telefon
		from bd1_KLIENCI k
		INNER JOIN bd1_OSOBY o on o.OSO_ID=k.OSO_ID;
		
		
		select * from bd1_V_kli_oso;
		
	CREATE OR REPLACE PROCEDURE bd1_P_kli_oso (
	inOSO_Adres_Zamieszkania IN bd1_OSOBY.OSO_Adres_Zamieszkania%TYPE,
	inOSO_Kod_Pocztowy IN bd1_OSOBY.OSO_Kod_Pocztowy%TYPE	)
	IS
	PRAGMA AUTONOMOUS_TRANSACTION; 
	--
	CURSOR curOSO_Adres(cOSO_Adres IN bd1_OSOBY.OSO_Adres_Zamieszkania%TYPE)
	IS
	select * from bd1_OSOBY
		where OSO_Adres_Zamieszkania = cOSO_Adres
	FOR UPDATE of OSO_Kod_Pocztowy; 
	--
	wiersz bd1_OSOBY%ROWTYPE;
	--
	ile number := 0;
	status number := 0;
BEGIN
	--
	OPEN curOSO_Adres(inOSO_Adres_Zamieszkania);
	---
	LOOP 
	FETCH curOSO_Adres INTO wiersz; 
		--
		-- warunek wyjścia z pętli
		EXIT WHEN curOSO_Adres%NOTFOUND OR curOSO_Adres%ROWCOUNT <1;
		--
		ile := ile + 1;
			IF wiersz.OSO_Kod_Pocztowy IS NULL THEN
			--
				IF inOSO_Kod_Pocztowy IS NOT NULL then	
					--
					-- kursor niejawny
					UPDATE bd1_OSOBY set OSO_Kod_Pocztowy = inOSO_Kod_Pocztowy
					WHERE CURRENT OF curOSO_Adres;
					-- 
					-- check update
					if SQL%FOUND THEN 
						status := status + 1; 
					ELSE 
						status := 0; 
					END IF;
				END IF;
			--
			END IF;
		--	
	END LOOP;
	--
	CLOSE curOSO_Adres;
	--
	-- prosta obsługa transakcji
	IF ile = status THEN
		DBMS_OUTPUT.PUT_LINE('bd1_p_Set_OSO_Kod_Pocztowy: COMMIT :) ');
		COMMIT;
	ELSE 
		DBMS_OUTPUT.PUT_LINE('bd1_p_Set_OSO_Kod_Pocztowy: ROLLBACK :( ');
		ROLLBACK;
	END IF;
END;
/

exec bd1_P_kli_oso('Limanowa','34-600');

select * from bd1_V_kli_oso;


	CREATE OR REPLACE VIEW bd1_V_prz_sle 
	AS
	select p.PRZ_ID, p.PRZ_Data, p.PRZ_Rodzaj, p.PRZ_Uwagi, s.SLE_ID,s.SLE_Data
		from bd1_PRZESTEPSTWA p
		INNER JOIN bd1_SLEDZTWA s on s.PRZ_ID=p.PRZ_ID;
		
		
	select * from bd1_V_prz_sle;

	
	CREATE OR REPLACE PROCEDURE bd1_P_prz_sle (
	inPRZ_Rodzaj IN bd1_PRZESTEPSTWA.PRZ_Rodzaj%TYPE,
	inPRZ_Uwagi IN bd1_PRZESTEPSTWA.PRZ_Uwagi%TYPE	)
	IS
	PRAGMA AUTONOMOUS_TRANSACTION; 
	--
	CURSOR curPRZ_Rodzaj(cPRZ_Rodzaj IN bd1_PRZESTEPSTWA.PRZ_Rodzaj%TYPE)
	IS
	select * from bd1_PRZESTEPSTWA
		where PRZ_Rodzaj = cPRZ_Rodzaj
	FOR UPDATE of PRZ_Uwagi; 
	--
	wiersz bd1_PRZESTEPSTWA%ROWTYPE;
	--
	ile number := 0;
	status number := 0;
BEGIN
	--
	OPEN curPRZ_Rodzaj(inPRZ_Rodzaj);
	---
	LOOP 
	FETCH curPRZ_Rodzaj INTO wiersz; 
		--
		-- warunek wyjścia z pętli
		EXIT WHEN curPRZ_Rodzaj%NOTFOUND OR curPRZ_Rodzaj%ROWCOUNT <1;
		--
		ile := ile + 1;
			IF wiersz.PRZ_Uwagi IS NULL THEN
			--
				IF inPRZ_Uwagi IS NOT NULL then	
					--
					-- kursor niejawny
					UPDATE bd1_PRZESTEPSTWA set PRZ_Uwagi = inPRZ_Uwagi
					WHERE CURRENT OF curPRZ_Rodzaj;
					-- 
					-- check update
					if SQL%FOUND THEN 
						status := status + 1; 
					ELSE 
						status := 0; 
					END IF;
				END IF;
			--
			END IF;
		--	
	END LOOP;
	--
	CLOSE curPRZ_Rodzaj;
	--
	-- prosta obsługa transakcji
	IF ile = status THEN
		DBMS_OUTPUT.PUT_LINE('bd1_p_Set_PRZ_Uwagi: COMMIT :) ');
		COMMIT;
	ELSE 
		DBMS_OUTPUT.PUT_LINE('bd1_p_Set_PRZ_Uwagi: ROLLBACK :( ');
		ROLLBACK;
	END IF;
END;
/

exec bd1_P_prz_sle('Drogowe','Zostala dokonana kontrola trzezwosci');

select * from bd1_V_prz_sle;

SPOOL OFF