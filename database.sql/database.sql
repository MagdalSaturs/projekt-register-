USE master
GO

DROP DATABASE IF EXISTS Projekt
GO

CREATE DATABASE Projekt
GO

USE Projekt
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

GO

CREATE TABLE Uzytkownik (
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	Admin VARCHAR(30) CHECK(Admin IN('TAK', 'NIE')) NOT NULL DEFAULT('NIE'),
    Imie VARCHAR(25) NOT NULL,
    Nazwisko VARCHAR(25) NOT NULL,
    Login VARCHAR(25) NOT NULL,
    Haslo VARCHAR(25) NOT NULL,
    Umowa VARCHAR(25) CHECK(Umowa IN('TAK','NIE')) NOT NULL DEFAULT('NIE'),
    Email VARCHAR(25) NOT NULL,
    DataRejestracji DATETIME NOT NULL DEFAULT(GETDATE()),
    DataLogowania DATETIME NOT NULL DEFAULT(GETDATE())
)

INSERT INTO Uzytkownik
VALUES
('TAK','Admin', 'Admin', 'admin', 'adminadmin', 'TAK', 'admin@admin.com', DEFAULT, DEFAULT)

CREATE TABLE Playlista (
	Id INT NOT NULL IDENTITY PRIMARY KEY,
    Nazwa VARCHAR(100) NOT NULL DEFAULT("Ulubione"),
    Typ VARCHAR(25) CHECK(Typ IN('Publiczna','Prywtna')) NOT NULL,
    DataPublikacji DATETIME NOT NULL DEFAULT(GETDATE()),
    UzytkownicyId INT NOT NULL FOREIGN KEY REFERENCES Uzytkownik(Id)
)

CREATE TABLE Piosenka (
    Id INT NOT NULL IDENTITY UNIQUE,
    Tytul VARCHAR(30) NOT NULL CHECK(LEN(Tytul) >= 3),
    CzasTrwania TIME NOT NULL DEFAULT(3),
    Wykonawca VARCHAR(30) NOT NULL CHECK(LEN(Wykonawca) >= 2),
    Kategoria VARCHAR(15) CHECK(Kategoria IN('POP', 'ROCK','RAP', 'Trap')),
    KrajPochodzenia VARCHAR(30) NOT NULL CHECK(LEN(KrajPochodzenia) >= 3),
    DataDodania DATE NOT NULL DEFAULT(GETDATE()),
    LinkOkladki VARCHAR(300) NOT NULL DEFAULT('https://scontent-frt3-1.xx.fbcdn.net/v/t1.18169-9/13417651_774698349333124_3934195859392981271_n.png?_nc_cat=106&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=TvSpBfCcSIMAX-zeEXu&_nc_ht=scontent-frt3-1.xx&oh=00_AT-suA5u4Bh0kQslhC_YtC59ak7GZGmdY8PqGmKarZDrgg&oe=62C63592')
)

CREATE TABLE PlaylistaPiosenka (
    PlaylistaId INT FOREIGN KEY REFERENCES Playlista(Id),
    PiosenkaId INT FOREIGN KEY REFERENCES Piosenka(Id)
)


INSERT INTO Piosenka
VALUES
('I need you','3:00','NF','POP','Wielka Brytania','2022-01-18','URL okładki'),
('Libe','3:00','Sido','ROCK','Niemcy','2022-01-18','URL okładki'),
('Freaks','2:00','Surf Curse','ROCK','Anglia','2022-01-18','https://cdns-images.dzcdn.net/images/cover/5aac59ef604ec29937df77577ddf48ec/500x500.jpg'),
('Big City Life','4:00','Mattafix','RAP','Ameryka','2022-01-18','https://m.media-amazon.com/images/I/51GaMD5BWWL.jpg'),
('Nic a nic','3:00','KMS','RAP','Polska','2022-01-18','https://yt3.ggpht.com/ytc/AKedOLQFygCY5kz-l80q7e9qeWYn0X-hg2-r8Q0zWuSDzQ=s900-c-k-c0x00ffffff-no-rj'),
('Melodia','2:00','Sanah','POP','Polska','2022-01-18','URL okładki'),
('Lie','4:00', 'NF','Trap','Ameryka','2022-01-18','URL okłądki'),
('If You Want Love','3:00', 'NF','Trap','Ameryka','2022-01-18','URL okkładki'),
('Paralyzed','4:00', 'NF','Trap','Ameryka','2022-01-18','URL okładki'),
('Let you down','3:00', 'NF','Trap','Ameryka','2022-01-18','URL okłądki'),
('Freaks','4:00','Surf Curse','Rock','USA','2022-01-18','https://cdns-images.dzcdn.net/images/cover/5aac59ef604ec29937df77577ddf48ec/500x500.jpg'),
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
('parents','3:00','YUNGBLUD','Rock','Ameryka','2022-01-19','https://images.genius.com/2c24afdaee2107b0f3c67657bf73c096.1000x1000x1.jpg'),
('Kill Somebody','3:00','YUNGBLUD','Rock','Ameryka','2022-01-19','https://images.genius.com/2c24afdaee2107b0f3c67657bf73c096.1000x1000x1.jpg'),
('Medication','2:00','YUNGBLUD','Rock','Ameryka','2022-01-19','https://images.genius.com/2c24afdaee2107b0f3c67657bf73c096.1000x1000x1.jpg'),
('Mars','3:00','YUNGBLUD','Rock','Ameryka','2022-01-19','https://images.genius.com/2c24afdaee2107b0f3c67657bf73c096.1000x1000x1.jpg'),
('Zalatani','4:00','Sarius','Rap','Polska','2022-01-19','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7XtUfBBRZoiHgzugHLhXOIHZUoK9U2sy0Vw&usqp=CAU'),
('Nie Widać Po Mnie','4:00','Sarius','Rap','Polska','2022-01-19','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7XtUfBBRZoiHgzugHLhXOIHZUoK9U2sy0Vw&usqp=CAU'),
('Powiedział mi ktoś?','4:00','Sarius','Rap','Polska','2022-01-19','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7XtUfBBRZoiHgzugHLhXOIHZUoK9U2sy0Vw&usqp=CAU'),
('Usta','3:00','Przyłu','Trap','Polska','2022-01-19','https://ecsmedia.pl/c/juniper-w-iext58901693.jpg'),
('Bedzie lepiej','3:00','Tymek','Trap','Polska','2022-01-19','https://cdn.newonce.me/uploads/images/4747/schema_meta_data_tymekfit.jpg')
