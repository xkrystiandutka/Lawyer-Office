------------------------------------------------------
-- UWAGI:
-- Skrypt nalezy uruchomić DWA RAZY - po drugim uruchomieniu 
-- nie mogą w nim występ[owac żadne błędy!
------------------------------------------------------

CLEAR SCREEN;
--
SET LINESIZE 350;
SET PAGESIZE 300;

-- Nagrywanie konunikatów z buforu ekranowego do pliku
SPOOL "Database.sql.txt"
-- Przydatne w przypadku poszukiwania błedów w długich plikach!

show user;

-- wyswietla komunikaty zwrotne z Oracle
SET SERVEROUTPUT ON;

-- zmień format daty
alter session set 
	nls_date_format = 'YYYY-MM-DD HH24:MI';

--
select sysdate from dual;
--

------------------------------------------------------
-- prefix tabel": bd1_

-- UWAGA! 
--   Prefix "bd1_" został wprowadzony po to, abyście 
--   Państwo mogli uruchamiać przykładowe skrypty 
--   na swoich kontach bez obawy o zduplikowanie nazw tabel 
--   z Państwa prywatnych projektów z przykładami do Lk.
------------------------------------------------------

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
STA_Rodzaj		varchar2(64),
STA_OPIS		varchar2(64)	NOT NULL
)
PCTFREE 5
TABLESPACE STUDENT_DATA;

	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_STANOWISKO 
		ADD CONSTRAINT bd1_STANOWISKO 
		PRIMARY KEY (STA_ID) ;
	------------------------

---------------------------
PROMPT   table bd1_INSTYTUTY
---------------------------	
create table bd1_INSTYTUTY (
INS_ID				number(8) NOT NULL,		
INS_Lokalizacja		varchar2(64)
)
PCTFREE 5
TABLESPACE STUDENT_DATA;

	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_INSTYTUTY 
		ADD CONSTRAINT bd1_INSTYTUTY 
		PRIMARY KEY (INS_ID) ;

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
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_OSOBY 
		ADD CONSTRAINT bd1_OSOBY 
		PRIMARY KEY (OSO_ID) ;

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
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_PRACOWNICY 
		ADD CONSTRAINT bd1_PRACOWNICY 
		PRIMARY KEY (PRA_ID) ;
		--  FOREIGN Keys
	------------------------
	ALTER TABLE bd1_PRACOWNICY
		ADD CONSTRAINT FK1_bd1_PRACOWNICY
		FOREIGN KEY(OSO_ID) 
		REFERENCES bd1_OSOBY(OSO_ID) ENABLE;

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
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_HISTORIA_ZATRUDNIENIA 
		ADD CONSTRAINT bd1_HISTORIA_ZATRUDNIENIA 
		PRIMARY KEY (HIS_Pracownika_ID) ;
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
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_KLIENCI 
		ADD CONSTRAINT bd1_KLIENCI 
		PRIMARY KEY (KLI_ID) ;
	--  FOREIGN Keys
	------------------------
	ALTER TABLE bd1_KLIENCI
		ADD CONSTRAINT FK1_bd1_KLIENCI
		FOREIGN KEY(OSO_ID) 
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
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_USLUGI 
		ADD CONSTRAINT bd1_USLUGI 
		PRIMARY KEY (USL_ID) ;
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
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_OSKARZENIA 
		ADD CONSTRAINT bd1_OSKARZENIA 
		PRIMARY KEY (OSK_ID) ;

---------------------------
PROMPT   table bd1_KARY
---------------------------	
create table bd1_KARY (
KAR_ID					number(8) NOT NULL,		
KAR_Wyrok				varchar2(64) NOT NULL,		
KAR_Data_Rozpoczecia	DATE NOT NULL,		
KAR_Data_Zakonczenia	DATE NOT NULL,	
OSK_ID 					number(8)		
)
PCTFREE 5
TABLESPACE STUDENT_DATA;

	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_KARY 
		ADD CONSTRAINT bd1_KARY 
		PRIMARY KEY (KAR_ID) ;
	--  FOREIGN Keys
	------------------------
	ALTER TABLE bd1_KARY 
		ADD CONSTRAINT FK1_bd1_KARY
		FOREIGN KEY(OSK_ID) 
		REFERENCES bd1_OSKARZENIA(OSK_ID) ENABLE;
---------------------------
PROMPT   table bd1_PRZESTEPSTWA;
---------------------------	
create table bd1_PRZESTEPSTWA (
PRZ_ID		number(8) NOT NULL,		
PRZ_Data  	DATE NOT NULL,		
PRZ_Rodzaj	varchar2(64) NOT NULL
)
PCTFREE 5
TABLESPACE STUDENT_DATA;

	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_PRZESTEPSTWA 
		ADD CONSTRAINT bd1_PRZESTEPSTWA 
		PRIMARY KEY (PRZ_ID) ;
---------------------------
PROMPT   table bd1_SLEDZTWA
---------------------------	
create table bd1_SLEDZTWA (
SLE_ID				number(8) NOT NULL,		
STA_Data			DATE	  NOT NULL,		
PRZ_ID				number(8) NOT NULL
)
PCTFREE 5
TABLESPACE STUDENT_DATA;

	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_SLEDZTWA 
		ADD CONSTRAINT bd1_SLEDZTWA 
		PRIMARY KEY (SLE_ID) ;
	--  FOREIGN Keys
	------------------------
	ALTER TABLE bd1_SLEDZTWA  
		ADD CONSTRAINT FK1_bd1_SLEDZTWA 
		FOREIGN KEY(PRZ_ID) 
		REFERENCES bd1_PRZESTEPSTWA(PRZ_ID) ENABLE;
		

---------------------------
PROMPT   table bd1_DOWODY;
---------------------------	
create table bd1_DOWODY (
DOW_ID		number(8) NOT NULL,		
DOW_Opis  	varchar2(64) NOT NULL,		
DOW_Rodzaj	varchar2(64) NOT NULL,
SLE_ID		number(8) NOT NULL
)
PCTFREE 5
TABLESPACE STUDENT_DATA;

	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_DOWODY 
		ADD CONSTRAINT bd1_DOWODY 
		PRIMARY KEY (DOW_ID) ;
	--  FOREIGN Keys
	------------------------
	ALTER TABLE bd1_DOWODY  
		ADD CONSTRAINT FK1_bd1_DOWODY 
		FOREIGN KEY(SLE_ID) 
		REFERENCES bd1_SLEDZTWA(SLE_ID) ENABLE;


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
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_STANOWISKO_SWIADKA 
		ADD CONSTRAINT bd1_STANOWISKO_SWIADKA 
		PRIMARY KEY (STA_SW_ID) ;

---------------------------
---------------------------
PROMPT   table bd1_ZEZNANIA
---------------------------	
create table bd1_ZEZNANIA (
ZEZ_ID		number(8) NOT NULL,		
ZEZ_Typ  	varchar2(64) NOT NULL,		
ZEZ_Opis	DATE NOT NULL,		
DOW_ID		number(8) NOT NULL,		
STA_SW_ID	number(8) NOT NULL,		
OSK_ID		number(8) NOT NULL
)
PCTFREE 5
TABLESPACE STUDENT_DATA;

	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_ZEZNANIA 
		ADD CONSTRAINT bd1_ZEZNANIA 
		PRIMARY KEY (ZEZ_ID) ;
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


---------------------------

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
	-- PRIMARY KEY
	------------------------
	ALTER TABLE bd1_SPRAWY_SADOWE 
		ADD CONSTRAINT bd1_SPRAWY_SADOWE 
		PRIMARY KEY (SPR_ID) ;
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


 ---------------------------
PROMPT   PODSUMOWANIA
---------------------------	

-- describe USER_TABLES
	column TABLE_NAME HEADING 'NAME' for A32
	column DROPPED HEADING 'NAME' for A32

PROMPT Lista utworzonych tabel:	

SELECT TABLE_NAME FROM USER_TABLES
WHERE DROPPED='NO';

-- ## -- ## -- ## -- ## -- 
SPOOL OFF