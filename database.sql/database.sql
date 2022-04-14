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