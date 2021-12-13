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
-- Przydatne w przypadku poszukiwania błedów w długich plikach!
SPOOL "D:\ORACLE\Database.sql.txt"

show user;

-- wyswietla komunikaty zwrotne z Oracle
SET SERVEROUTPUT ON;

-- zmień format daty
alter session set 
	nls_date_format = 'YYYY-MM-DD HH24:MI';

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
STA_OPIS		varchar2(64)	
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
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_bd1_STANOWISKO;
	
	CREATE SEQUENCE SEQ_bd1_STANOWISKO 
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
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
		
	------------------------
	-- DML bd1_STANOWISKO
	------------------------
	insert into bd1_STANOWISKO (STA_ID,STA_Rodzaj,STA_OPIS)
	values ('1','Prawnik','Obrona klienta');

	insert into bd1_STANOWISKO (STA_ID,STA_Rodzaj,STA_OPIS)
	values ('2','Prokurator','Oskazanie oskazonego');

	column STA_ID HEADING 'ID' for 999999
	column STA_Rodzaj HEADING 'Rodzaj stanowiska' for A20
	column STA_OPIS HEADING 'Opis stanowiska' for A20


	-- ile wierszy
	select count(*) from bd1_STANOWISKO;

	-- szybciej:
	select count(STA_ID) from bd1_STANOWISKO;

	select * from bd1_STANOWISKO;	

---------------------------

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
	------------------------	
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_bd1_INSTYTUTY;
	
	CREATE SEQUENCE SEQ_bd1_INSTYTUTY 
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
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
		
	------------------------
	-- DML bd1_INSTYTUTY
	------------------------
	insert into bd1_INSTYTUTY (INS_Lokalizacja)
	values ('Krakow');

	insert into bd1_INSTYTUTY (INS_Lokalizacja)
	values ('Warszawa');

	insert into bd1_INSTYTUTY (INS_Lokalizacja)
	values ('Bochnia');
	
	column INS_ID HEADING 'ID' for 999999
	column INS_Lokalizacja HEADING 'Lokalizacja instytutu' for A20

	-- ile wierszy
	select count(*) from bd1_INSTYTUTY;

	-- szybciej:
	select count(INS_ID) from bd1_INSTYTUTY;

	select * from bd1_INSTYTUTY;	

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
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_bd1_OSOBY;
	CREATE SEQUENCE SEQ_bd1_OSOBY 
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
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
		
	------------------------
	-- DML bd1_OSOBY
	------------------------
	insert into bd1_OSOBY (OSO_Imie,OSO_Nazwisko,OSO_Plec,OSO_Adres_Zamieszkania,OSO_Kod_Pocztowy,OSO_Telefon)
	values ('Jakub','Kowalski','Mezczyzna','Nowy Sacz','33-300','123-456-789');
	
	insert into bd1_OSOBY (OSO_Imie,OSO_Nazwisko,OSO_Plec,OSO_Adres_Zamieszkania,OSO_Kod_Pocztowy,OSO_Telefon)
	values ('Kamil','Nowak','Mezczyzna','Limanowa','34-600','987-654-321');
	
	insert into bd1_OSOBY (OSO_Imie,OSO_Nazwisko,OSO_Plec,OSO_Adres_Zamieszkania,OSO_Kod_Pocztowy,OSO_Telefon)
	values ('Dominik','Filipek','Mezczyzna','Bochnia','33-500','123-987-456');
	
	insert into bd1_OSOBY (OSO_Imie,OSO_Nazwisko,OSO_Plec,OSO_Adres_Zamieszkania,OSO_Kod_Pocztowy,OSO_Telefon)
	values ('Natalia','Nowak','Kobieta','Krakow','33-661','987-654-321');
	
	column OSO_ID HEADING 'ID' for 999999
	column OSO_Imie HEADING 'Imie' for A20
	column OSO_Nazwisko HEADING 'Nazwisko' for A20
	column OSO_Plec HEADING 'Plec' for A20
	column OSO_Adres_Zamieszkania HEADING 'Adres Zamieszkania' for A20
	column OSO_Kod_Pocztowy HEADING 'Kod Pocztowy' for A20
	column OSO_Telefon HEADING 'Numer Telefonu' for A20

	-- ile wierszy
	select count(*) from bd1_OSOBY;

	-- szybciej:
	select count(OSO_ID) from bd1_OSOBY;

	select * from bd1_OSOBY;	

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
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_bd1_PRACOWNICY;
	CREATE SEQUENCE SEQ_bd1_PRACOWNICY 
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
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
		
	------------------------
	-- DML bd1_PRACOWNICY
	------------------------
	insert into bd1_PRACOWNICY (OSO_ID)
	values ('1');
	
	insert into bd1_PRACOWNICY (OSO_ID)
	values ('2');

	column PRA_ID HEADING 'ID_Pracownika' for 999999
	column OSO_ID HEADING 'ID_Osoby' for 99999

	-- ile wierszy
	select count(*) from bd1_PRACOWNICY;

	-- szybciej:
	select count(PRA_ID) from bd1_PRACOWNICY;

	select * from bd1_PRACOWNICY;
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
	
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_bd1_HISTORIA_ZATRUDNIENIA;
	CREATE SEQUENCE SEQ_bd1_HISTORIA_ZATRUDNIENIA 
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
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
		
	------------------------
	-- DML bd1_HISTORIA_ZATRUDNIENIA
	------------------------
	insert into bd1_HISTORIA_ZATRUDNIENIA (HIS_Data_Zatrudnienia,HIS_Data_Zwolnienia,STA_ID,INS_ID,PRA_ID)
	values ('2021-08-21','2021-11-10','1','3','1');
	insert into bd1_HISTORIA_ZATRUDNIENIA (HIS_Data_Zatrudnienia,HIS_Data_Zwolnienia,STA_ID,INS_ID,PRA_ID)
	values ('2019-08-21','2020-11-10','2','3','2');
	
	column HIS_Pracownika_ID HEADING 'ID Histori Pracownika' for 999999
	column HIS_Data_Zatrudnienia HEADING 'Data Zatrudnienia' for A20
	column HIS_Data_Zwolnienia HEADING 'Data Zwolnienia' for A20
	column STA_ID HEADING 'Stanowisko ID' for 999999
	column INS_ID HEADING 'Instytut ID' for 999999
	column PRA_ID HEADING 'Pracownik ID' for 999999
	
	-- ile wierszy
	select count(*) from bd1_HISTORIA_ZATRUDNIENIA;

	-- szybciej:
	select count(HIS_Pracownika_ID) from bd1_HISTORIA_ZATRUDNIENIA;

	select * from bd1_HISTORIA_ZATRUDNIENIA;	
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
		FOREIGN KEY(KLI_ID) 
		REFERENCES bd1_OSOBY(OSO_ID) ENABLE;
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_bd1_KLIENCI;
	CREATE SEQUENCE SEQ_bd1_KLIENCI 
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
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
		
	------------------------
	-- DML bd1_KLIENCI
	------------------------
	insert into bd1_KLIENCI (OSO_ID)
	values ('3');
	
	insert into bd1_KLIENCI (OSO_ID)
	values ('4');

	column KLI_ID HEADING 'ID_Klienta' for 999999
	column OSO_ID HEADING 'ID_Osoby' for 99999

	-- ile wierszy
	select count(*) from bd1_KLIENCI;

	-- szybciej:
	select count(KLI_ID) from bd1_KLIENCI;

	select * from bd1_KLIENCI;
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
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_bd1_USLUGI;
	CREATE SEQUENCE SEQ_bd1_USLUGI
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
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
		
	------------------------
	-- DML bd1_USLUGI
	------------------------
	insert into bd1_USLUGI (PRA_ID,KLI_ID)
	values ('2','1');
	
	insert into bd1_USLUGI (PRA_ID,KLI_ID)
	values ('2','2');

	column USL_ID HEADING 'ID_Uslugi' for 999999
	column PRA_ID HEADING 'ID_Pracownika' for 99999
	column KLI_ID HEADING 'ID_Klienta' for 99999

	-- ile wierszy
	select count(*) from bd1_USLUGI;

	-- szybciej:
	select count(USL_ID) from bd1_USLUGI;

	select * from bd1_USLUGI;
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
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_bd1_OSKARZENIA;
	CREATE SEQUENCE SEQ_bd1_OSKARZENIA
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
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
		
	------------------------
	-- DML bd1_OSKARZENIA
	------------------------
	insert into bd1_OSKARZENIA (OSK_Data,OSK_Rodzaj)
	values ('2021-10-02','Przestepstwo drogowe');
	

	insert into bd1_OSKARZENIA (OSK_Data,OSK_Rodzaj)
	values ('2020-05-11','Oszustwo');

	insert into bd1_OSKARZENIA (OSK_Data,OSK_Rodzaj)
	values ('2019-10-03','Kradziez');

	column OSK_ID HEADING 'ID_Oskarzenia' for 999999
	column OSK_Data HEADING 'Data oskarzenia' for A20
	column OSK_Rodzaj HEADING 'Rodzaj oskarzenia' for A20

	-- ile wierszy
	select count(*) from bd1_OSKARZENIA;

	-- szybciej:
	select count(OSK_ID) from bd1_OSKARZENIA;

	select * from bd1_OSKARZENIA;
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
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_bd1_KARY;
	CREATE SEQUENCE SEQ_bd1_KARY
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
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
		
	------------------------
	-- DML bd1_KARY
	------------------------
	insert into bd1_KARY (KAR_Wyrok,KAR_Data_Rozpoczecia,KAR_Data_Zakonczenia,OSK_ID)
	values ('Wiezienie','2021-11-29','2025-11-21','2');
	
	insert into bd1_KARY (KAR_Wyrok,KAR_Data_Rozpoczecia,KAR_Data_Zakonczenia,OSK_ID)
	values ('Wyrok w zawieszeniu','2021-10-15','2021-11-15','1');
	

	column KAR_ID HEADING 'ID_Kary' for 999999
	column KAR_Wyrok HEADING 'Wyrok' for 99999
	column KAR_Data_Rozpoczecia HEADING 'Data rozpoczecia kary' for 99999
	column KAR_Data_Zakonczenia HEADING 'Data zakonczenia kary' for 99999
	column OSK_ID HEADING 'ID_Oskarzenia' for 99999

	-- ile wierszy
	select count(*) from bd1_KARY;

	-- szybciej:
	select count(KAR_ID) from bd1_KARY;

	select * from bd1_KARY;
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
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_bd1_PRZESTEPSTWA;
	CREATE SEQUENCE SEQ_bd1_PRZESTEPSTWA
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
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
		
	------------------------
	-- DML bd1_PRZESTEPSTWA
	------------------------
	insert into bd1_PRZESTEPSTWA (PRZ_Data,PRZ_Rodzaj)
	values ('2021-11-27','Drogowe');
	
	insert into bd1_PRZESTEPSTWA (PRZ_Data,PRZ_Rodzaj)
	values ('2021-10-21','Bezprawne zbieranie danych o życiu prywatnym');

	column PRZ_ID HEADING 'ID_Przestepstwa' for 999999
	column PRZ_Data HEADING 'Data przestepstwa' for A20
	column PRZ_Rodzaj HEADING 'Rodzaj przestepstwa' for A20

	-- ile wierszy
	select count(*) from bd1_PRZESTEPSTWA;

	-- szybciej:
	select count(PRZ_ID) from bd1_PRZESTEPSTWA;

	select * from bd1_PRZESTEPSTWA;
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
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_bd1_SLEDZTWA;
	CREATE SEQUENCE SEQ_bd1_SLEDZTWA
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
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
		
	------------------------
	-- DML bd1_SLEDZTWA
	------------------------
	insert into bd1_SLEDZTWA (SLE_Data,PRZ_ID)
	values ('2021-11-15','2');
	
	insert into bd1_SLEDZTWA (SLE_Data,PRZ_ID)
	values ('2019-11-15','1');


	column SLE_ID HEADING 'ID_Przestepstwa' for 999999
	column SLE_Data HEADING 'Data sledztwa' for A20
	column PRZ_ID HEADING 'ID_Przestepstwa' for 99999

	-- ile wierszy
	select count(*) from bd1_SLEDZTWA;

	-- szybciej:
	select count(SLE_ID) from bd1_SLEDZTWA;

	select * from bd1_SLEDZTWA;		

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
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_bd1_DOWODY;
	CREATE SEQUENCE SEQ_bd1_DOWODY
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
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
		
	------------------------
	-- DML bd1_DOWODY
	------------------------
	insert into bd1_DOWODY (DOW_Opis,DOW_Rodzaj,SLE_ID)
	values ('Dowod zebrany z miejsca zbrodni','Bron','1');
	
	insert into bd1_DOWODY (DOW_Opis,DOW_Rodzaj,SLE_ID)
	values ('Dowod zabezpieczony w domu oskazonego','Przedmiot kradiezy','2');


	column DOW_ID HEADING 'ID_Dowodu' for 999999
	column DOW_Opis HEADING 'Opis dowodu' for A20
	column DOW_Rodzaj HEADING 'Rodzaj dowodu' for A20
	column SLE_ID HEADING 'ID_Sledztwa' for 99999

	-- ile wierszy
	select count(*) from bd1_DOWODY;

	-- szybciej:
	select count(DOW_ID) from bd1_DOWODY;

	select * from bd1_DOWODY;
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
-- SEQUENCE
	------------------------		
	drop sequence SEQ_bd1_STANOWISKO_SWIADKA;
	CREATE SEQUENCE SEQ_bd1_STANOWISKO_SWIADKA
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
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
		
	------------------------
	-- DML bd1_STANOWISKO_SWIADKA
	------------------------
	insert into bd1_STANOWISKO_SWIADKA (STA_SW_Zeznania,STA_SW_Data,STA_SW_Rodzaj,STA_SW_Typ_Swiadka,STA_SW_Opis)
	values ('Zeznanie na korzysc oskazonego','2021-10-09','Swiadek zdarzenia','Brat Oskazonego','Zeznanie swojej wersje zdarzen');
	
	insert into bd1_STANOWISKO_SWIADKA (STA_SW_Zeznania,STA_SW_Data,STA_SW_Rodzaj,STA_SW_Typ_Swiadka,STA_SW_Opis)
	values ('Zeznanie na niekorzysc oskazonego','2021-10-09','Swiadek zdarzenia','Przypadkowa osoba','Zeznanie swojej wersje zdarzen');
	
	column STA_SW_ID HEADING 'ID_Stanowiska_Swiadka' for 999999
	column STA_SW_Zeznania HEADING 'Stanowisko swiadka zeznania' for A20
	column STA_SW_Data HEADING 'Data skladanai stanowiska swiadka' for A20
	column STA_SW_Rodzaj HEADING 'Rodzaj stanowiska swiadka' for A20
	column STA_SW_Typ_Swiadka HEADING 'Typ swiadka' for A20
	column STA_SW_Opis HEADING 'Opis stanowiska swiadka' for A20

	-- ile wierszy
	select count(*) from bd1_STANOWISKO_SWIADKA;

	-- szybciej:
	select count(STA_SW_ID) from bd1_STANOWISKO_SWIADKA;

	select * from bd1_STANOWISKO_SWIADKA;		
---------------------------
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
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_bd1_ZEZNANIA;
	CREATE SEQUENCE SEQ_bd1_ZEZNANIA
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
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
		
	------------------------
	-- DML bd1_ZEZNANIA
	------------------------
	insert into bd1_ZEZNANIA (ZEZ_Typ,ZEZ_Opis,DOW_ID,STA_SW_ID,OSK_ID)
	values ('Opinia bieglego','Braku mozliwosc wykorzystania zeznan z powodu wiezow krwi','2','1','3');
	insert into bd1_ZEZNANIA (ZEZ_Typ,ZEZ_Opis,DOW_ID,STA_SW_ID,OSK_ID)
	values ('Opinia bieglego','Mozna wykorzystac zeznia','2','2','3');
	
	column ZEZ_ID HEADING 'ID_Zeznan' for 999999
	column ZEZ_Typ HEADING 'Typ zeznania' for A20
	column DOW_ID HEADING 'ID_Dowodu' for 99999
	column STA_SW_ID HEADING 'ID_Stanowiska_Swiadka' for 99999
	column OSK_ID HEADING 'ID_Oskarzenia' for 99999

	-- ile wierszy
	select count(*) from bd1_ZEZNANIA;

	-- szybciej:
	select count(ZEZ_ID) from bd1_ZEZNANIA;

	select * from bd1_ZEZNANIA;

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
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_bd1_SPRAWY_SADOWE;
	CREATE SEQUENCE SEQ_bd1_SPRAWY_SADOWE
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
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
		
	------------------------
	-- DML bd1_SPRAWY_SADOWE
	------------------------
	insert into bd1_SPRAWY_SADOWE (PRZ_ID,USL_ID)
	values ('1','1');
	insert into bd1_SPRAWY_SADOWE (PRZ_ID,USL_ID)
	values ('2','2');
	
	column SPR_ID HEADING 'ID_Sprawy_Sadowej' for 999999
	column PRZ_ID HEADING 'ID_Przestepstwa' for 99999
	column USL_ID HEADING 'ID_Uslugi' for 99999
	
	-- ile wierszy
	select count(*) from bd1_SPRAWY_SADOWE;

	-- szybciej:
	select count(SPR_ID) from bd1_SPRAWY_SADOWE;

	select * from bd1_SPRAWY_SADOWE;

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