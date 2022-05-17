DROP TABLE IF EXISTS Uzytkownik;
CREATE TABLE Uzytkownik (
	Id INT NOT NULL AUTO_INCREMENT,
	Admin VARCHAR(30) NOT NULL CHECK(Admin IN('TAK', 'NIE')),
    Imie VARCHAR(25) NOT NULL,
    Nazwisko VARCHAR(25) NOT NULL,
    Login VARCHAR(25) NOT NULL,
    Haslo VARCHAR(25) NOT NULL,
    Umowa VARCHAR(25) NOT NULL CHECK(Umowa IN('TAK','NIE')),
    Email VARCHAR(25) NOT NULL,
    DataRejestracji DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    DataLogowania DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (Id)
);


INSERT INTO Uzytkownik (Admin, Imie, Nazwisko, Login, Haslo, Umowa, Email)
VALUES ('TAK','Admin', 'Admin', 'admin', 'adminadmin', 'TAK', 'admin@admin.com');

DROP TABLE IF EXISTS Playlista;
CREATE TABLE Playlista (
	Id INT NOT NULL AUTO_INCREMENT,
    Nazwa VARCHAR(100) NOT NULL,
    Typ VARCHAR(25) NOT NULL CHECK(Typ IN('Publiczna','Prywtna')),
    DataPublikacji DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UzytkownicyId INT NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (UzytkownicyId) REFERENCES Uzytkownik(Id)
);

DROP TABLE IF EXISTS Piosenka;
CREATE TABLE Piosenka (
    Id INT NOT NULL AUTO_INCREMENT,
    Tytul VARCHAR(30) NOT NULL CHECK(LEN(Tytul) >= 3),
    CzasTrwania TIME NOT NULL,
    Wykonawca VARCHAR(30) NOT NULL CHECK(LEN(Wykonawca) >= 2),
    Kategoria VARCHAR(15) CHECK(Kategoria IN('POP', 'ROCK','RAP', 'Trap')),
    KrajPochodzenia VARCHAR(30) NOT NULL CHECK(LEN(KrajPochodzenia) >= 3),
    DataDodania DATE NOT NULL,
    LinkOkladki VARCHAR(300) NOT NULL,
    PRIMARY KEY (Id)
);

DROP TABLE IF EXISTS PlaylistaPiosenka;
CREATE TABLE PlaylistaPiosenka (
    PlaylistaId INT,
    PiosenkaId INT,
    FOREIGN KEY (PlaylistaId) REFERENCES Playlista(Id),
    FOREIGN KEY (PiosenkaId) REFERENCES Piosenka(Id)
);


INSERT INTO Piosenka (Tytul, CzasTrwania, Wykonawca, Kategoria, KrajPochodzenia, DataDodania, LinkOkladki)
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
('Bedzie lepiej','3:00','Tymek','Trap','Polska','2022-01-19','URL okładki');