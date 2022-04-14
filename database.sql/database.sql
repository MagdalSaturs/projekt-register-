USE master
GO

DROP DATABASE IF EXISTS Projekt
GO

CREATE DATABASE Projekt
GO

USE Projekt
GO

CREATE TABLE Uzytkownicy (
	Id INT NOT NULL IDENTITY PRIMARY KEY,
    Imie VARCHAR(25) NOT NULL,
    Nazwisko VARCHAR(25) NOT NULL,
    Login VARCHAR(25) NOT NULL,
    Haslo VARCHAR(25) NOT NULL,
    Umowa VARCHAR(25) CHECK(Umowa IN('TAK','NIE')) NOT NULL,
    Email VARCHAR(25) NOT NULL,
    DataRejestracji DATETIME NOT NULL DEFAULT(GETDATE()),
    DataLogowania DATETIME NOT NULL DEFAULT(GETDATE())
)

CREATE TABLE Playlista (
	Id INT NOT NULL IDENTITY PRIMARY KEY,
    Nazwa VARCHAR(100) NOT NULL,
    Typ VARCHAR(25) CHECK(Typ IN('Publiczna','Prywtna')) NOT NULL,
    DataPublikacji DATETIME NOT NULL DEFAULT(GETDATE()),
    UzytkownicyId INT NOT NULL FOREIGN KEY REFERENCES Uzytkownicy(Id)
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
('I need you',3,'NF','POP','Wielka Brytania','2022-01-18','URL okładki'),
('Libe',3,'Sido','ROCK','Niemcy','2022-01-18','URL okładki'),
('Freaks',2,'Surf Curse','ROCK','Anglia','2022-01-18','URL okładki'),
('Big City Life',4,'Mattafix','RAP','Ameryka','2022-01-18','URL okładki'),
('Nic a nic',3,'KMS','RAP','Polska','2022-01-18','URL okładki'),
('Melodia',2,'Sanah','POP','Polska','2022-01-18','URL okładki'),
('Lie',4, 'NF','Trap','Ameryka','2022-01-18','URL okładki'),
('If You Want Love',3, 'NF','Trap','Ameryka','2022-01-18','URL okładki'),
('Paralyzed',4, 'NF','Trap','Ameryka','2022-01-18','URL okładki'),
('Let you down',3, 'NF','Trap','Ameryka','2022-01-18','URL okładki'),
('Libe',4,'Sido','Rock','Niemcy','2022-01-18','URL okładki'),
('Freaks',4,'Surf Curse','Rock','USA','2022-01-18','URL okładki'),
('Nichts ohne Dich',4, 'Nzola', 'Pop','Niemcy','2022-01-19','URL okładki'),
('Ich libe mich',5, 'Nzola', 'Pop','Niemcy','2022-01-19','URL okładki'),
('Uberall',4, 'Celine', 'Pop','Niemcy','2022-01-19','URL okładki'),
('Quiet',3,'MILCK','Pop','Ameryka','2022-01-19','URL okładki'),
('No Talk',3,'Lowell','Pop','Ameryka','2022-01-19','URL okładki'),
('OUTRUN MYSELF',5,'Jack Kays, Travis Barker','Rock','Ameryka','2022-01-19','URL okładki'),
('SIDEWAYS',4,'Jack Kays, Travis Barker','Rock','Ameryka','2022-01-19','URL okładki'),
('Ophelia',3,'The Lumineers','Pop','Ameryka','2022-01-19','URL okładki'),
('I Want You Back',3,'The Jackson 5','Pop','Ameryka','2022-01-19','URL okładki'),
('lonely',4,'Machine Gun Kelly','Rock','Ameryka','2022-01-19','URL okładki'),
('my ex"s best friend',3,'Machine Gun Kelly','Rock','Ameryka','2022-01-19','URL okładki'),
('forget me too(feat. Halsey','Machine Gun Kelly, Halsey',3,'Rock','Ameryka','2022-01-19','URL okładki'),
('parents',3,'YUNGBLUD','Rock','Ameryka','2022-01-19','URL okładki'),
('Kill Somebody',3,'YUNGBLUD','Rock','Ameryka','2022-01-19','URL okładki'),
('Medication',2,'YUNGBLUD','Rock','Ameryka','2022-01-19','URL okładki'),
('Mars',3,'YUNGBLUD','Rock','Ameryka','2022-01-19','URL okładki'),
('Zalatani',4,'Sarius','Rap','Polska','2022-01-19','URL okładki'),
('Nie Widać Po Mnie',4,'Sarius','Rap','Polska','2022-01-19','URL okładki'),
('Powiedział mi ktoś?',4,'Sarius','Rap','Polska','2022-01-19','URL okładki'),
('Usta','Przyłu',3,'Trap','Polska','2022-01-19','URL okładki'),
('Bedzie lepiej',3,'Tymek','Trap','Polska','2022-01-19','URL okładki')