USE master
GO

DROP DATABASE IF EXISTS magazyn2022
GO

CREATE DATABASE magazyn2022
GO

USE magazyn2022
GO

IF NOT EXISTS (SELECT name  
     FROM master.sys.server_principals
     WHERE name = 'app')
BEGIN
    CREATE LOGIN app WITH PASSWORD = 'app', CHECK_POLICY = OFF
END
GO

CREATE USER app FOR LOGIN app
GO

EXEC sp_addrolemember 'db_datawriter', 'app'
EXEC sp_addrolemember 'db_datareader', 'app'

CREATE TABLE Uzytkownicy (
    Login VARCHAR(50) PRIMARY KEY,
    Haslo VARCHAR(50) NOT NULL CHECK(LEN(Haslo) >= 4)
)

INSERT INTO Uzytkownicy VALUES
('admin', 'admin123')

CREATE TABLE Produkty (
    Id INT PRIMARY KEY IDENTITY,
    Nazwa VARCHAR(50) NOT NULL,
    Kategoria VARCHAR(50) NOT NULL CHECK (Kategoria IN ('Sport', 'Zabawki', 'Ubrania')),
    Ilosc SMALLINT NOT NULL CHECK (Ilosc > 0),
    Cena MONEY NOT NULL CHECK (Cena > 0)
)

SET IDENTITY_INSERT Produkty ON

INSERT INTO Produkty (Id, Nazwa, Kategoria, Ilosc, Cena) VALUES
(1, 'Rower', 'Sport', 10, 1000),
(2, 'Pluszowy miś', 'Zabawki', 40, 50),
(3, 'Koń na biegunach', 'Zabawki', 2, 200),
(4, 'Spodnie', 'Ubrania', 16, 99.99),
(5, 'Sandały', 'Ubrania', 21, 78.55),
(6, 'Rakieta tenisowa', 'Sport', 3, 250)

SET IDENTITY_INSERT Produkty OFF

USE master
GO

USE master
GO

DROP DATABASE IF EXISTS Projekt
GO

CREATE DATABASE Projekt
GO

USE Projekt
GO

CREATE TABLE Uzytkownik (
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	Admin VARCHAR(30) CHECK(Admin IN('TAK', 'NIE') NOT NULL,
    Imie VARCHAR(25) NOT NULL,
    Nazwisko VARCHAR(25) NOT NULL,
    Login VARCHAR(25) NOT NULL,
    Haslo VARCHAR(25) NOT NULL,
    Umowa VARCHAR(25) CHECK(Umowa IN('TAK','NIE')) NOT NULL,
    Email VARCHAR(25) NOT NULL,
    DataRejestracji DATETIME NOT NULL DEFAULT(GETDATE()),
    DataLogowania DATETIME NOT NULL DEFAULT(GETDATE())
)

INSERT INTO Uzytkownik
VALUES
('TAK','Admin', 'Admin', 'admin', 'adminadmin', 'TAK', 'admin@admin.com', DEFAULT, DEFAULT)

CREATE TABLE Playlista (
	Id INT NOT NULL IDENTITY PRIMARY KEY,
    Nazwa VARCHAR(100) NOT NULL,
    Typ VARCHAR(25) CHECK(Typ IN('Publiczna','Prywtna')) NOT NULL,
    DataPublikacji DATETIME NOT NULL DEFAULT(GETDATE()),
    UzytkownicyId INT NOT NULL FOREIGN KEY REFERENCES Uzytkownik(Id)
)

CREATE TABLE Piosenka (
    Id INT NOT NULL IDENTITY UNIQUE,
    Tytul VARCHAR(30) NOT NULL CHECK(LEN(Tytul) >= 3),
    CzasTrwania TIME NOT NULL,
    Wykonawca VARCHAR(30) NOT NULL CHECK(LEN(Wykonawca) >= 2),
    Kategoria VARCHAR(15) CHECK(Kategoria IN('POP', 'ROCK','RAP', 'Trap')),
    KrajPochodzenia VARCHAR(30) NOT NULL CHECK(LEN(KrajPochodzenia) >= 3),
    DataDodania DATE NOT NULL,
    LinkOkladki VARCHAR(300) NOT NULL
)

CREATE TABLE PlaylistaPiosenka (
    PlaylistaId INT FOREIGN KEY REFERENCES Playlista(Id),
    PiosenkaId INT FOREIGN KEY REFERENCES Piosenka(Id)
)


INSERT INTO Piosenka
VALUES
('I need you','3:00','NF','POP','Wielka Brytania','2022-01-18','URL okładki'),
('Libe','3:00','Sido','ROCK','Niemcy','2022-01-18','URL okładki'),
('Freaks','2:00','Surf Curse','ROCK','Anglia','2022-01-18','URL okładki'),
('Big City Life','4:00','Mattafix','RAP','Ameryka','2022-01-18','URL okładki'),
('Nic a nic','3:00','KMS','RAP','Polska','2022-01-18','URL okładki'),
('Melodia','2:00','Sanah','POP','Polska','2022-01-18','URL okładki'),
('Lie','4:00', 'NF','Trap','Ameryka','2022-01-18','URL okładki'),
('If You Want Love','3:00', 'NF','Trap','Ameryka','2022-01-18','URL okładki'),
('Paralyzed','4:00', 'NF','Trap','Ameryka','2022-01-18','URL okładki'),
('Let you down','3:00', 'NF','Trap','Ameryka','2022-01-18','URL okładki'),
('Libe','4:00','Sido','Rock','Niemcy','2022-01-18','URL okładki'),
('Freaks','4:00','Surf Curse','Rock','USA','2022-01-18','URL okładki'),
('Nichts ohne Dich','4:00', 'Nzola', 'Pop','Niemcy','2022-01-19','URL okładki'),
('Ich libe mich','5:00', 'Nzola', 'Pop','Niemcy','2022-01-19','URL okładki'),
('Uberall','4:00', 'Celine', 'Pop','Niemcy','2022-01-19','URL okładki'),
('Quiet','3:00','MILCK','Pop','Ameryka','2022-01-19','URL okładki'),
('No Talk','3:00','Lowell','Pop','Ameryka','2022-01-19','URL okładki'),
('OUTRUN MYSELF','5:00','Jack Kays, Travis Barker','Rock','Ameryka','2022-01-19','URL okładki'),
('SIDEWAYS','4:00','Jack Kays, Travis Barker','Rock','Ameryka','2022-01-19','URL okładki'),
('Ophelia','3:00','The Lumineers','Pop','Ameryka','2022-01-19','URL okładki'),
('I Want You Back','3:00','The Jackson 5','Pop','Ameryka','2022-01-19','URL okładki'),
('lonely','4:00','Machine Gun Kelly','Rock','Ameryka','2022-01-19','URL okładki'),
('my ex"s best friend','3:00','Machine Gun Kelly','Rock','Ameryka','2022-01-19','URL okładki'),
('parents','3:00','YUNGBLUD','Rock','Ameryka','2022-01-19','URL okładki'),
('Kill Somebody','3:00','YUNGBLUD','Rock','Ameryka','2022-01-19','URL okładki'),
('Medication','2:00','YUNGBLUD','Rock','Ameryka','2022-01-19','URL okładki'),
('Mars','3:00','YUNGBLUD','Rock','Ameryka','2022-01-19','URL okładki'),
('Zalatani','4:00','Sarius','Rap','Polska','2022-01-19','URL okładki'),
('Nie Widać Po Mnie','4:00','Sarius','Rap','Polska','2022-01-19','URL okładki'),
('Powiedział mi ktoś?','4:00','Sarius','Rap','Polska','2022-01-19','URL okładki'),
('Usta','3:00','Przyłu','Trap','Polska','2022-01-19','URL okładki'),
('Bedzie lepiej','3:00','Tymek','Trap','Polska','2022-01-19','URL okładki')