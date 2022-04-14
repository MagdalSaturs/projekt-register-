USE master
GO

DROP DATABASE IF EXISTS Projekt
GO

CREATE DATABASE Projekt
GO

USE Projekt
GO

CREATE TABLE Logowanie (
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	Imie VARCHAR(50) NOT NULL,
	Nazwisko VARCHAR(50) NOT NULL,
	Login VARCHAR(255) NOT NULL,
	Haslo VARCHAR(255) NOT NULL,
	Email VARCHAR(255) NOT NULL,
	Rejestracja DATETIME NOT NULL DEFAULT(GETDATE()),
	Logowanie DATETIME DEFAULT(GETDATE()),
	Umowa VARCHAR(3) NOT NULL DEFAULT('NIE') CHECK(Umowa LIKE 'NIE' OR Umowa LIKE 'TAK')
)

INSERT INTO Logowanie
VALUES
('Admin', 'Administrator' , 'admin', 'adminadmin', 'admin@gmail.com', DEFAULT, DEFAULT)

CREATE TABLE Playlista (
	Id INT NOT NULL IDENTITY UNIQUE,
	Nazwa VARCHAR(50) NOT NULL DEFAULT('Ulubione')
	Typ VARCHAR(15) CHECK(Typ IN('POP', 'ROCK','RAP', 'Trap')),
	DataPublikacji DATE DEFAULT(GETDATE())
	Uzytkownik_Id INT NOT NULL FOREIGN KEY REFERENCES Logowanie (Id)
)

CREATE TABLE Playlista_Songs (
	Playlista_Id INT FOREIGN KEY REFERENCES Playlista (Id),
	Songs_Id INT FOREIGN KEY REFERENCES Songs (Id)
)

CREATE TABLE Songs (
	Id INT NOT NULL IDENTITY UNIQUE,
	Tytul VARCHAR(30) NOT NULL CHECK(LEN(Tytul) >= 3),
	Wykonawca VARCHAR(30) NOT NULL CHECK(LEN(Wykonawca) >= 2),
	Kategoria VARCHAR(15) CHECK(Kategoria IN('POP', 'ROCK','RAP', 'Trap')),
	Kraj VARCHAR(30) NOT NULL CHECK(LEN(Kraj) >= 3),
	DataDodania DATE NOT NULL,
)

INSERT INTO Songs 
VALUES
('I need you', 'NF','POP','Wielka Brytania','2022-01-18'),
('Libe','Sido','ROCK','Niemcy','2022-01-18'),
('Freaks','Surf Curse','ROCK','Anglia','2022-01-18'),
('Big City Life', 'Mattafix','RAP','Ameryka','2022-01-18'),
('Nic a nic','KMS','RAP','Polska','2022-01-18'),
('Melodia','Sanah','POP','Polska','2022-01-18'),
('Lie', 'NF','Trap','Ameryka','2022-01-18'),
('If You Want Love', 'NF','Trap','Ameryka','2022-01-18'),
('Paralyzed', 'NF','Trap','Ameryka','2022-01-18'),
('Let you down', 'NF','Trap','Ameryka','2022-01-18'),
('Libe','Sido','Rock','Niemcy','2022-01-18'),
('Freaks','Surf Curse','Rock','USA','2022-01-18'),
('Big City Life', 'Mattafix','Rap','Ameryka','2022-01-18'),
('Nic a nic','KMS','Rap','Polska','2022-01-18'),
('Melodia','Sanah','Pop','Polska','2022-01-18'),
('Nichts ohne Dich', 'Nzola', 'Pop','Niemcy','2022-01-19'),
('Ich libe mich', 'Nzola', 'Pop','Niemcy','2022-01-19'),
('Uberall', 'Celine', 'Pop','Niemcy','2022-01-19'),
('Quiet','MILCK','Pop','Ameryka','2022-01-19'),
('No Talk','Lowell','Pop','Ameryka','2022-01-19'),
('OUTRUN MYSELF','Jack Kays, Travis Barker','Rock','Ameryka','2022-01-19'),
('SIDEWAYS','Jack Kays, Travis Barker','Rock','Ameryka','2022-01-19'),
('Ophelia','The Lumineers','Pop','Ameryka','2022-01-19'),
('I Want You Back','The Jackson 5','Pop','Ameryka','2022-01-19'),
('lonely','Machine Gun Kelly','Rock','Ameryka','2022-01-19'),
('my ex"s best friend','Machine Gun Kelly','Rock','Ameryka','2022-01-19'),
('forget me too(feat. Halsey','Machine Gun Kelly, Halsey','Rock','Ameryka','2022-01-19'),
('parents','YUNGBLUD','Rock','Ameryka','2022-01-19'),
('Kill Somebody','YUNGBLUD','Rock','Ameryka','2022-01-19'),
('Medication','YUNGBLUD','Rock','Ameryka','2022-01-19'),
('Mars','YUNGBLUD','Rock','Ameryka','2022-01-19'),
('Zalatani','Sarius','Rap','Polska','2022-01-19'),
('Nie Wida� Po Mnie','Sarius','Rap','Polska','2022-01-19'),
('Powiedzia� mi kto�','Sarius','Rap','Polska','2022-01-19'),
('Usta','Przy�u','Trap','Polska','2022-01-19'),
('Bedzie lepiej','Miyo, Tymek','Trap','Polska','2022-01-19')
