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
	nls_date_format = 'YYYY-MM-DD';

--
select sysdate from dual;
--

-------------------------
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
	insert into bd1_STANOWISKO (STA_Rodzaj,STA_OPIS)
	values ('Prawnik','Obrona klienta');

	insert into bd1_STANOWISKO (STA_Rodzaj,STA_OPIS)
	values ('Prokurator','Oskazanie oskazonego');
	
		insert into bd1_STANOWISKO (STA_Rodzaj,STA_OPIS)
	values ('Sedzia Sadowy','Prowadzenie rozpraw');
	
		insert into bd1_STANOWISKO (STA_Rodzaj,STA_OPIS)
	values ('Komornik','');

	column STA_ID HEADING 'ID' for 999999
	column STA_Rodzaj HEADING 'Rodzaj stanowiska' for A20
	column STA_OPIS HEADING 'Opis stanowiska' for A20


	select * from bd1_STANOWISKO;	

---------------------------

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
	
	insert into bd1_INSTYTUTY (INS_Lokalizacja)
	values ('Nowy Sacz');
	
	insert into bd1_INSTYTUTY (INS_Lokalizacja)
	values ('Limanowa');
	
	insert into bd1_INSTYTUTY (INS_Lokalizacja)
	values ('Mszalnica');
	
	insert into bd1_INSTYTUTY (INS_Lokalizacja)
	values ('Warszawa');
	
	column INS_ID HEADING 'ID' for 999999
	column INS_Lokalizacja HEADING 'Lokalizacja instytutu' for A20

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
	values ('Pawel','Ciula','Mezczyzna','Mszalnica',NULL,NULL);
	
	insert into bd1_OSOBY (OSO_Imie,OSO_Nazwisko,OSO_Plec,OSO_Adres_Zamieszkania,OSO_Kod_Pocztowy,OSO_Telefon)
	values ('Kamila','Nowak','Kobieta','Limanowa',NULL,NULL);
	
	column OSO_ID HEADING 'ID' for 999999
	column OSO_Imie HEADING 'Imie' for A20
	column OSO_Nazwisko HEADING 'Nazwisko' for A20
	column OSO_Plec HEADING 'Plec' for A20
	column OSO_Adres_Zamieszkania HEADING 'Adres Zamieszkania' for A20
	column OSO_Kod_Pocztowy HEADING 'Kod Pocztowy' for A20
	column OSO_Telefon HEADING 'Numer Telefonu' for A20

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
	
	insert into bd1_PRACOWNICY (OSO_ID)
	values ('5');
	
	insert into bd1_PRACOWNICY (OSO_ID)
	values ('6');
	
	column PRA_ID HEADING 'ID_Pracownika' for 999999
	column OSO_ID HEADING 'ID_Osoby' for 99999

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
	values ('2021-08-21','','1','3','1');
	insert into bd1_HISTORIA_ZATRUDNIENIA (HIS_Data_Zatrudnienia,HIS_Data_Zwolnienia,STA_ID,INS_ID,PRA_ID)
	values ('2019-08-21','','2','3','2');
	insert into bd1_HISTORIA_ZATRUDNIENIA (HIS_Data_Zatrudnienia,HIS_Data_Zwolnienia,STA_ID,INS_ID,PRA_ID)
	values ('2019-08-21','2021-09-11','2','4','3');
	insert into bd1_HISTORIA_ZATRUDNIENIA (HIS_Data_Zatrudnienia,HIS_Data_Zwolnienia,STA_ID,INS_ID,PRA_ID)
	values ('2019-08-21','','3','4','4');
	column HIS_Pracownika_ID HEADING 'ID Histori Pracownika' for 999999
	column HIS_Data_Zatrudnienia HEADING 'Data Zatrudnienia' for A20
	column HIS_Data_Zwolnienia HEADING 'Data Zwolnienia' for A20
	column STA_ID HEADING 'Stanowisko ID' for 999999
	column INS_ID HEADING 'Instytut ID' for 999999
	column PRA_ID HEADING 'Pracownik ID' for 999999
	
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
	
	insert into bd1_KLIENCI (OSO_ID)
	values ('7');
	
	insert into bd1_KLIENCI (OSO_ID)
	values ('8');

	column KLI_ID HEADING 'ID_Klienta' for 999999
	column OSO_ID HEADING 'ID_Osoby' for 99999

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
	
	insert into bd1_USLUGI (PRA_ID,KLI_ID)
	values ('2','3');
	
	insert into bd1_USLUGI (PRA_ID,KLI_ID)
	values ('2','2');

	insert into bd1_USLUGI (PRA_ID,KLI_ID)
	values ('4','3');
	
	insert into bd1_USLUGI (PRA_ID,KLI_ID)
	values ('4','3');

	column USL_ID HEADING 'ID_Uslugi' for 999999
	column PRA_ID HEADING 'ID_Pracownika' for 99999
	column KLI_ID HEADING 'ID_Klienta' for 99999

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
	values ('Wyrok w zawieszeniu','2021-10-15','2022-11-15','1');
	

	column KAR_ID HEADING 'ID_Kary' for 999999
	column KAR_Wyrok HEADING 'Wyrok' for 99999
	column KAR_Data_Rozpoczecia HEADING 'Data rozpoczecia kary' for 99999
	column KAR_Data_Zakonczenia HEADING 'Data zakonczenia kary' for 99999
	column OSK_ID HEADING 'ID_Oskarzenia' for 99999

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
	values ('2021-10-21','Bezprawne zbieranie danych o zyciu prywatnym');

	column PRZ_ID HEADING 'ID_Przestepstwa' for 999999
	column PRZ_Data HEADING 'Data przestepstwa' for A20
	column PRZ_Rodzaj HEADING 'Rodzaj przestepstwa' for A25

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

	select * from bd1_SLEDZTWA;		

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
	
	insert into bd1_DOWODY (DOW_Opis,DOW_Rodzaj,SLE_ID)
	values (NULL,'Przedmiot kradiezy','1');


	column DOW_ID HEADING 'ID_Dowodu' for 999999
	column DOW_Opis HEADING 'Opis dowodu' for A20
	column DOW_Rodzaj HEADING 'Rodzaj dowodu' for A20
	column SLE_ID HEADING 'ID_Sledztwa' for 99999

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
	values ('Zeznanie na niekorzysc oskazonego','2019-11-09','Swiadek zdarzenia','Przypadkowa osoba','Zeznanie swojej wersje zdarzen');
	
	insert into bd1_STANOWISKO_SWIADKA (STA_SW_Zeznania,STA_SW_Data,STA_SW_Rodzaj,STA_SW_Typ_Swiadka,STA_SW_Opis)
	values ('Zeznanie na niekorzysc oskazonego','2021-06-09','Swiadek zdarzenia','Ojciec ofiary','Zeznanie swojej wersje zdarzen');
	
	insert into bd1_STANOWISKO_SWIADKA (STA_SW_Zeznania,STA_SW_Data,STA_SW_Rodzaj,STA_SW_Typ_Swiadka,STA_SW_Opis)
	values ('Zeznanie na korzysc oskazonego','2021-05-10','Swiadek zdarzenia','Siostra oskazonego','Zeznanie swojej wersje zdarzen');
	
	insert into bd1_STANOWISKO_SWIADKA (STA_SW_Zeznania,STA_SW_Data,STA_SW_Rodzaj,STA_SW_Typ_Swiadka,STA_SW_Opis)
	values ('Zeznanie na niekorzysc oskazonego','2021-08-21','Swiadek zdarzenia','Matka ofiary','Zeznanie swojej wersje zdarzen');
	
	column STA_SW_ID HEADING 'ID_Stanowiska_Swiadka' for 999999
	column STA_SW_Zeznania HEADING 'Stanowisko swiadka zeznania' for A20
	column STA_SW_Data HEADING 'Data skladanai stanowiska swiadka' for A20
	column STA_SW_Rodzaj HEADING 'Rodzaj stanowiska swiadka' for A20
	column STA_SW_Typ_Swiadka HEADING 'Typ swiadka' for A20
	column STA_SW_Opis HEADING 'Opis stanowiska swiadka' for A20

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

---------------------------	SELECT --------------------------------------



SELECT * FROM BD1_OSOBY WHERE OSO_ID > '5';
/*ID_Osoby Imie            Nazwisko        Plec                 Adres Zamieszkania   Kod Pocztowy         Numer Telefonu
-------- --------------- --------------- -------------------- -------------------- -------------------- --------------------
       6 Julia           Czesak          Kobieta              Nowy Sacz            33-300
       7 Pawel           Ciula           Mezczyzna            Mszalnica            33-300
       8 Kamila          Kowalska        Kobieta              Limanowa             34-600													*/


SELECT OSO_ID,OSO_Imie,OSO_Nazwisko,OSO_Plec,OSO_Adres_Zamieszkania FROM bd1_OSOBY WHERE OSO_Nazwisko='Nowak' AND OSO_Adres_Zamieszkania='Limanowa'; 
 
/*ID_Osoby Imie            Nazwisko        Plec            Adres Zamieszka
-------- --------------- --------------- --------------- ---------------
       2 Kamil           Nowak           Mezczyzna       Limanowa 			*/
 

SELECT HIS_Pracownika_ID,HIS_Data_Zatrudnienia,HIS_Data_Zwolnienia,INS_Lokalizacja FROM bd1_HISTORIA_ZATRUDNIENIA, bd1_INSTYTUTY WHERE bd1_HISTORIA_ZATRUDNIENIA.INS_ID=bd1_INSTYTUTY.INS_ID AND INS_Lokalizacja='Bochnia';
/*ID Histori Pracownika Data Zatrudnien Data Zwolnienia Lokalizacja instytutu
--------------------- --------------- --------------- ----------------------------
                    1 2021-08-21                      Bochnia
                    2 2019-08-21                      Bochnia					*/
					

SELECT * FROM bd1_KARY WHERE KAR_Data_Zakonczenia > '2020-01-01' AND KAR_WYROK='Wiezienie';
/*ID_Kary Wyrok                                                            Data rozpo Data zakon ID_Oskarzenia
------- ---------------------------------------------------------------- ---------- ---------- -------------
      1 Wiezienie                                                        2021-11-29 2025-11-21             2 */
	  
UPDATE bd1_HISTORIA_ZATRUDNIENIA SET HIS_Data_Zwolnienia='2021-12-07' WHERE HIS_Pracownika_ID LIKE '1';
SELECT * FROM bd1_HISTORIA_ZATRUDNIENIA WHERE HIS_Pracownika_ID LIKE '1';
/*ID Histori Pracownika Data Zatrudnien Data Zwolnienia Stanowisko ID Instytut ID ID_Pracownika
--------------------- --------------- --------------- ------------- ----------- -------------
                    1 2021-08-21      2021-12-07                  1           3             1 */
					
---------------------------	NVL --------------------------------------				


SELECT OSO_Imie,OSO_Nazwisko, NVL(OSO_Telefon, 'nie podano numeru telefonu') Numer_Telefonu FROM bd1_OSOBY;
/*Imie                 Nazwisko             NUMER_TELEFONU
-------------------- -------------------- --------------------------
Jakub                Kowalski             123-456-789
Kamil                Nowak                987-654-321
Dominik              Filipek              123-987-456
Natalia              Nowak                987-654-321
Artur                Nowak                nie podano numeru telefonu
Julia                Czesak               nie podano numeru telefonu
Pawel                Ciula                nie podano numeru telefonu
Kamila               Kowalska             nie podano numeru telefonu */

SELECT DOW_ID,SLE_ID,DOW_Rodzaj, NVL(DOW_Opis, 'nie podano opisu') DOW_Opis FROM bd1_DOWODY;
/* ID_Dowodu ID_Sledztwa Rodzaj dowodu        Opis dowodu
--------- ----------- -------------------- --------------------
        1           1 Bron                 Dowod zebrany z miej
                                           sca zbrodni

        2           2 Przedmiot kradiezy   Dowod zabezpieczony
                                           w domu oskazonego

        3           1 Przedmiot kradiezy   nie podano opisu */
		
SELECT KAR_ID, KAR_Wyrok,KAR_Data_Rozpoczecia,KAR_Data_Zakonczenia, NVL(ROUND(KAR_Data_Zakonczenia - CURRENT_DATE), 0) Koniec_za FROM bd1_KARY;
/*ID_Kary Wyrok                                                            Data rozpo Data zakon  KONIEC_ZA
------- ---------------------------------------------------------------- ---------- ---------- ----------
      1 Wiezienie                                                        2021-11-29 2025-11-21       1444
      2 Wyrok w zawieszeniu                                              2021-10-15 2022-11-15        342 */
	  
SELECT OSO_Imie,OSO_Nazwisko, NVL(OSO_Kod_Pocztowy, 'nie podano kodu pocztowego') Kod_pocztowy FROM bd1_OSOBY;
/*Imie                 Nazwisko             KOD_POCZTOWY
-------------------- -------------------- --------------------------
Jakub                Kowalski             33-300
Kamil                Nowak                34-600
Dominik              Filipek              33-500
Natalia              Nowak                33-661
Artur                Nowak                33-661
Julia                Czesak               33-300
Pawel                Ciula                nie podano kodu pocztowego
Kamila               Kowalska             nie podano kodu pocztowego*/

-- ## -- ## -- ## -- ## -- 




---
---------------------------	GROUP BY --------------------------------------
---



SELECT kli.KLI_ID,kli.OSO_ID,oso.OSO_Imie,oso.OSO_Nazwisko,oso.OSO_Plec,oso.OSO_Adres_Zamieszkania
FROM bd1_KLIENCI kli 
INNER JOIN bd1_OSOBY oso ON kli.OSO_ID=oso.OSO_ID;
/*
ID_Klienta ID_Osoby Imie                 Nazwisko             Plec                 Adres Zamieszkania
---------- -------- -------------------- -------------------- -------------------- --------------------
         1        3 Dominik              Filipek              Mezczyzna            Bochnia
         2        4 Natalia              Nowak                Kobieta              Krakow
         3        7 Pawel                Ciula                Mezczyzna            Mszalnica
         4        8 Kamila               Nowak                Kobieta              Limanowa */
		 
SELECT his.HIS_Data_Zatrudnienia,his.PRA_ID,ins.INS_Lokalizacja,sta.STA_OPIS
FROM bd1_HISTORIA_ZATRUDNIENIA his 
INNER JOIN bd1_INSTYTUTY ins ON his.INS_ID=ins.INS_ID 
INNER JOIN bd1_STANOWISKO sta ON his.STA_ID=sta.STA_ID;
/*
Data Zatrudnienia    ID_Pracownika Lokalizacja instytut Opis stanowiska
-------------------- ------------- -------------------- --------------------
2021-08-21                       1 Bochnia              Obrona klienta
2019-08-21                       2 Bochnia              Oskazanie oskazonego
2019-08-21                       3 Nowy Sacz            Oskazanie oskazonego
2019-08-21                       4 Nowy Sacz            Prowadzenie rozpraw */

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
/*
ID_Sprawy_Sadowej Imie i nazwisko pracownika Imie i nazwisko klienta   Rodzaj przestepstwa klienta
----------------- -------------------------- ------------------------- -----------------------------------
                1 Kamil Nowak                Dominik Filipek           Drogowe
                2 Kamil Nowak                Natalia Nowak             Bezprawne zbieranie danych o zyciu
                                                                       prywatnym
*/


--------HAVING---------

-- ilosc instytutow znajduajcych sie w tym samym miescie (min 2)
SELECT INS_Lokalizacja, COUNT(INS_Lokalizacja) AS Ilosc FROM bd1_INSTYTUTY GROUP BY INS_Lokalizacja HAVING COUNT(INS_Lokalizacja)>1;
/*Lokalizacja instytut      ILOSC
-------------------- ----------
Warszawa                      2*/

-- ilosc osob o tym samym nazwisku w bazie danych (min 2)
COLUMN a HEADING 'Ilosc osob o takim samym nazwisku'
SELECT OSO_Nazwisko, COUNT(OSO_Nazwisko) AS a FROM bd1_OSOBY GROUP BY OSO_Nazwisko HAVING COUNT(OSO_Nazwisko)>1 ORDER BY OSO_Nazwisko DESC;
/*Nazwisko             Ilosc osob o takim samym nazwisku
-------------------- ---------------------------------
Nowak                                                4
Kowalski                                             2 */
-- stanowiska swiadkow zdarzen w bazie danych zeznane po dacie 2020-01-01 ustawione w kolejnosci malejacej (od najnowszych do najstarszych)
SELECT STA_SW_Rodzaj,STA_SW_Data  FROM bd1_STANOWISKO_SWIADKA GROUP BY STA_SW_Data,STA_SW_Rodzaj HAVING MAX(STA_SW_Data) > '2020-01-01' ORDER BY STA_SW_Data DESC;
/*Rodzaj stanowiska sw Data skladanai stano
-------------------- --------------------
Swiadek zdarzenia    2021-10-09
Swiadek zdarzenia    2021-08-21
Swiadek zdarzenia    2021-06-09
Swiadek zdarzenia    2021-05-10 */



SPOOL OFF

