/*
Created: 25.04.2019
Modified: 02.05.2019
Model: Park_Rozrywki
Database: Oracle 12c Release 2
*/


-- Create tables section -------------------------------------------------

-- Table Parki_rozrywki

CREATE TABLE Parki_rozrywki(
  ID_Parku_rozrywki Integer NOT NULL,
  Nazwa Varchar2(30 ) NOT NULL,
  Miasto Varchar2(20 ) NOT NULL,
  Ulica Varchar2(30 ) NOT NULL,
  Kod_pocztowy Varchar2(6 ) NOT NULL,
  Data_zalozenia Date NOT NULL,
  Imie_wlasciciela Varchar2(20 ) NOT NULL,
  Nazwisko_wlasciciela Varchar2(30 ) NOT NULL
)
/

-- Add keys for table Parki_rozrywki

ALTER TABLE Parki_rozrywki ADD CONSTRAINT PK_Park_Rozrywki PRIMARY KEY (ID_Parku_rozrywki)
/

-- Table Pracownicy

CREATE TABLE Pracownicy(
  ID_Pracownika Integer NOT NULL,
  Nazwisko Varchar2(20 ) NOT NULL,
  Imie Varchar2(20 ) NOT NULL,
  Data_urodzenia Date NOT NULL,
  Plec Char(1 ) NOT NULL
        CHECK (Plec IN ('M','K')),
  PESEL Char(11 ) NOT NULL,
  Data_zatrudnienia Date NOT NULL,
  Rodzaj_zatrudnienia Varchar2(30 ) NOT NULL
        CHECK (Rodzaj_zatrudnienia IN ('Umowa na czas nieokreslony','Umowa na okres probny','Umowa na czas okreslony')),
  ID_Parku_rozrywki Integer NOT NULL
)
/

-- Create indexes for table Pracownicy

CREATE INDEX IX_Park_zatrudnia_pracownikow ON Pracownicy (ID_Parku_rozrywki)
/

-- Add keys for table Pracownicy

ALTER TABLE Pracownicy ADD CONSTRAINT PK_Pracownika PRIMARY KEY (ID_Pracownika)
/

-- Table Wynagrodzenia

CREATE TABLE Wynagrodzenia(
  ID_Wynagrodzenia Integer NOT NULL,
  Data Date NOT NULL,
  Wartosc Number(10,2) NOT NULL,
  Premia Number(10,2) NOT NULL,
  ID_Pracownika Integer NOT NULL
)
/

-- Create indexes for table Wynagrodzenia

CREATE INDEX IX_Pracownik_otrzymuje_wynagrodzenie ON Wynagrodzenia (ID_Pracownika)
/

-- Add keys for table Wynagrodzenia

ALTER TABLE Wynagrodzenia ADD CONSTRAINT PK_wynagrodzenie PRIMARY KEY (ID_Wynagrodzenia)
/

-- Table Specjalizacje

CREATE TABLE Specjalizacje(
  ID_Specjalizacji Integer NOT NULL,
  Nazwa Varchar2(30 ) NOT NULL,
  Opis Varchar2(200 )
)
/

-- Add keys for table Specjalizacje

ALTER TABLE Specjalizacje ADD CONSTRAINT PK_specjalizacji PRIMARY KEY (ID_Specjalizacji)
/

-- Table Atrakcje

CREATE TABLE Atrakcje(
  ID_Atrakcji Integer NOT NULL,
  Nazwa Varchar2(20 ) NOT NULL,
  Liczba_miejsc Integer NOT NULL,
  Minimalny_wiek Integer,
  ID_Parku_rozrywki Integer NOT NULL
)
/

-- Create indexes for table Atrakcje

CREATE INDEX IX_Park_posiada_atrakcje ON Atrakcje (ID_Parku_rozrywki)
/

-- Add keys for table Atrakcje

ALTER TABLE Atrakcje ADD CONSTRAINT PK_Atrakcji PRIMARY KEY (ID_Atrakcji)
/

-- Table Sklepy

CREATE TABLE Sklepy(
  ID_Sklepu Integer NOT NULL,
  Nazwa Varchar2(30 ) NOT NULL,
  Powierzchnia Integer NOT NULL,
  ID_Parku_rozrywki Integer NOT NULL
)
/

-- Create indexes for table Sklepy

CREATE INDEX IX_Park_posiada_sklepy ON Sklepy (ID_Parku_rozrywki)
/

-- Add keys for table Sklepy

ALTER TABLE Sklepy ADD CONSTRAINT PK_Sklepu PRIMARY KEY (ID_Sklepu)
/

-- Table Towary

CREATE TABLE Towary(
  ID_Towaru Integer NOT NULL,
  Nazwa Varchar2(30 ) NOT NULL,
  Cena Number(10,2) NOT NULL,
  Dostepnosc Integer NOT NULL,
  Opis Varchar2(200 )
)
/

-- Add keys for table Towary

ALTER TABLE Towary ADD CONSTRAINT PK_Towaru PRIMARY KEY (ID_Towaru)
/

-- Table Parkingi

CREATE TABLE Parkingi(
  ID_Parkingu Integer NOT NULL,
  Lokalizacja Varchar2(30 ) NOT NULL,
  Liczba_miejsc Integer NOT NULL,
  Liczba_wolnych_miejsc Integer,
  ID_Parku_rozrywki Integer NOT NULL
)
/

-- Create indexes for table Parkingi

CREATE INDEX IX_Park_posiada_parkingi ON Parkingi (ID_Parku_rozrywki)
/

-- Add keys for table Parkingi

ALTER TABLE Parkingi ADD CONSTRAINT PK_Parkingu PRIMARY KEY (ID_Parkingu)
/

-- Table Kasy

CREATE TABLE Kasy(
  ID_Kasy Integer NOT NULL,
  Nazwa Varchar2(20 ) NOT NULL,
  Godzina_otwarcia Date NOT NULL,
  Godzina_zamkniecia Date NOT NULL,
  ID_Parku_rozrywki Integer NOT NULL
)
/

-- Create indexes for table Kasy

CREATE INDEX IX_Park_posiada_kasy ON Kasy (ID_Parku_rozrywki)
/

-- Add keys for table Kasy

ALTER TABLE Kasy ADD CONSTRAINT PK_Kasy PRIMARY KEY (ID_Kasy)
/

-- Table Bilety

CREATE TABLE Bilety(
  ID_Biletu Integer NOT NULL,
  Cena Number(10,2) NOT NULL,
  Data_sprzedazy Date NOT NULL,
  Typ_biletu Varchar2(15 ) NOT NULL
        CHECK (Typ_biletu IN ('Ulgowy','Normalny','Rodzinny','Grupowy')),
  ID_Kasy Integer NOT NULL
)
/

-- Create indexes for table Bilety

CREATE INDEX IX_Bilety_sa_sprzedawane_przez_kasy ON Bilety (ID_Kasy)
/

-- Add keys for table Bilety

ALTER TABLE Bilety ADD CONSTRAINT PK_Biletu PRIMARY KEY (ID_Biletu)
/

-- Table Sklep_Towar

CREATE TABLE Sklep_Towar(
  ID_Sklepu Integer NOT NULL,
  ID_Towaru Integer NOT NULL
)
/

-- Table Pracownik_Specjalizacja

CREATE TABLE Pracownik_Specjalizacja(
  ID_Pracownika Integer NOT NULL,
  ID_Specjalizacji Integer NOT NULL
)
/

-- Table Pracownik_Kasa

CREATE TABLE Pracownik_Kasa(
  ID_Pracownika Integer NOT NULL,
  ID_Kasy Integer NOT NULL,
  Data_obslugi Date NOT NULL
)
/

-- Table and Columns comments section

COMMENT ON COLUMN Pracownik_Kasa.Data_obslugi IS 'Data obslugi kasy przez pracownika'
/

-- Table Pracownik_Atrakcja

CREATE TABLE Pracownik_Atrakcja(
  ID_Pracownika Integer NOT NULL,
  ID_Atrakcji Integer NOT NULL
)
/

-- Table Pracownik_Sklep

CREATE TABLE Pracownik_Sklep(
  ID_Pracownika Integer NOT NULL,
  ID_Sklepu Integer NOT NULL
)
/

-- Table Kategorie_Towaru

CREATE TABLE Kategorie_Towaru(
  ID_Rodzaj_towaru Integer NOT NULL,
  Kategoria Varchar2(30 ) NOT NULL,
  Opis Varchar2(200 )
)
/

-- Add keys for table Kategorie_Towaru

ALTER TABLE Kategorie_Towaru ADD CONSTRAINT PK_Kategorie_Towaru PRIMARY KEY (ID_Rodzaj_towaru)
/

ALTER TABLE Kategorie_Towaru ADD CONSTRAINT Kategoria UNIQUE (Kategoria)
/

-- Table Towary_Kategorie

CREATE TABLE Towary_Kategorie(
  ID_Towaru Integer NOT NULL,
  ID_Rodzaj_Towaru Integer NOT NULL
)
/

-- Add keys for table Towary_Kategorie

ALTER TABLE Towary_Kategorie ADD CONSTRAINT PK_Towary_Kategorie PRIMARY KEY (ID_Towaru,ID_Rodzaj_Towaru)
/

-- Table Przeglady

CREATE TABLE Przeglady(
  ID_Przegladu Integer NOT NULL,
  Data_przegladu Date NOT NULL,
  Koszt_przegladu Number(10,2) NOT NULL,
  Opis Varchar2(300 ),
  ID_Pracownika Integer NOT NULL,
  ID_Atrakcji Integer NOT NULL
)
/

-- Create indexes for table Przeglady

CREATE INDEX IX_Pracownik_wykonuje_przeglad ON Przeglady (ID_Pracownika)
/

CREATE INDEX IX_Atrakcja_posiada_przeglady ON Przeglady (ID_Atrakcji)
/

-- Add keys for table Przeglady

ALTER TABLE Przeglady ADD CONSTRAINT PK_Przeglady PRIMARY KEY (ID_Przegladu)
/


-- Create foreign keys (relationships) section ------------------------------------------------- 

ALTER TABLE Pracownicy ADD CONSTRAINT Park_zatrudnia_pracownikow FOREIGN KEY (ID_Parku_rozrywki) REFERENCES Parki_rozrywki (ID_Parku_rozrywki)
/


ALTER TABLE Atrakcje ADD CONSTRAINT Park_posiada_atrakcje FOREIGN KEY (ID_Parku_rozrywki) REFERENCES Parki_rozrywki (ID_Parku_rozrywki)
/


ALTER TABLE Parkingi ADD CONSTRAINT Park_posiada_parkingi FOREIGN KEY (ID_Parku_rozrywki) REFERENCES Parki_rozrywki (ID_Parku_rozrywki)
/


ALTER TABLE Kasy ADD CONSTRAINT Park_posiada_kasy FOREIGN KEY (ID_Parku_rozrywki) REFERENCES Parki_rozrywki (ID_Parku_rozrywki)
/


ALTER TABLE Sklepy ADD CONSTRAINT Park_posiada_sklepy FOREIGN KEY (ID_Parku_rozrywki) REFERENCES Parki_rozrywki (ID_Parku_rozrywki)
/


ALTER TABLE Bilety ADD CONSTRAINT Bilety_sa_sprzedawane_przez_kasy FOREIGN KEY (ID_Kasy) REFERENCES Kasy (ID_Kasy)
/


ALTER TABLE Towary_Kategorie ADD CONSTRAINT Towar_posiada_kategorie_Towar FOREIGN KEY (ID_Towaru) REFERENCES Towary (ID_Towaru)
/


ALTER TABLE Towary_Kategorie ADD CONSTRAINT Towar_posiada_kategorie_Kategoria FOREIGN KEY (ID_Rodzaj_Towaru) REFERENCES Kategorie_Towaru (ID_Rodzaj_towaru)
/


ALTER TABLE Przeglady ADD CONSTRAINT Pracownik_wykonuje_przeglad FOREIGN KEY (ID_Pracownika) REFERENCES Pracownicy (ID_Pracownika)
/


ALTER TABLE Przeglady ADD CONSTRAINT Atrakcja_posiada_przeglady FOREIGN KEY (ID_Atrakcji) REFERENCES Atrakcje (ID_Atrakcji)
/


ALTER TABLE Wynagrodzenia ADD CONSTRAINT Pracownik_otrzymuje_wynagrodzenie FOREIGN KEY (ID_Pracownika) REFERENCES Pracownicy (ID_Pracownika)
/





