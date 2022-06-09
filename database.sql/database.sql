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
	Admin VARCHAR(30) CHECK(Admin IN('TAK', 'NIE')) NOT NULL,
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
('I need you','3:00','NF','POP','Wielka Brytania',DEFAULT,'https://ecsmedia.pl/c/when-i-grow-up-w-iext54753814.jpg'),
('Libe','3:00','Sido','ROCK','Niemcy','2022-01-18','https://kolekcjonerrapu.pl/userdata/public/gfx/621/Sido---Blutzbrudaz---Die-Mukke-Zum-Film-cover-okladka.jpg'),
('Freaks','2:00','Surf Curse','ROCK','Anglia','2022-01-18','https://cdns-images.dzcdn.net/images/cover/5aac59ef604ec29937df77577ddf48ec/500x500.jpg'),
('Big City Life','4:00','Mattafix','RAP','Ameryka','2022-01-18','https://m.media-amazon.com/images/I/51GaMD5BWWL.jpg'),
('Nic a nic','3:00','KMS','RAP','Polska','2022-01-18','https://yt3.ggpht.com/ytc/AKedOLQFygCY5kz-l80q7e9qeWYn0X-hg2-r8Q0zWuSDzQ=s900-c-k-c0x00ffffff-no-rj'),
('Melodia','2:00','Sanah','POP','Polska','2022-01-18','https://ecsmedia.pl/c/melodia-w-iext109849769.jpg'),
('Lie','4:00', 'NF','Trap','Ameryka','2022-01-18','https://ecsmedia.pl/c/when-i-grow-up-w-iext54753814.jpg'),
('If You Want Love','3:00', 'NF','Trap','Ameryka','2022-01-18','https://ecsmedia.pl/c/when-i-grow-up-w-iext54753814.jpg'),
('Paralyzed','4:00', 'NF','Trap','Ameryka','2022-01-18','https://ecsmedia.pl/c/when-i-grow-up-w-iext54753814.jpg'),
('Let you down','3:00', 'NF','Trap','Ameryka','2022-01-18','https://ecsmedia.pl/c/when-i-grow-up-w-iext54753814.jpg'),
('Freaks','4:00','Surf Curse','Rock','USA','2022-01-18','https://cdns-images.dzcdn.net/images/cover/5aac59ef604ec29937df77577ddf48ec/500x500.jpg'),
('Nichts ohne Dich','4:00', 'Nzola', 'Pop','Niemcy','2022-01-19','https://m.media-amazon.com/images/I/51oFQ+GFEXL._SS500_.jpg'),
('Ich libe mich','5:00', 'Nzola', 'Pop','Niemcy','2022-01-19','https://is1-ssl.mzstatic.com/image/thumb/Music118/v4/01/55/6c/01556c77-26a7-2858-2844-e78e2342ad80/859721926515_cover.jpg/375x375bb.jpg'),
('Uberall','4:00', 'Celine', 'Pop','Niemcy','2022-01-19','https://i1.sndcdn.com/artworks-OUnKnolFBSUjirYZ-aZsMwA-t500x500.jpg'),
('Quiet','3:00','MILCK','Pop','Ameryka','2022-01-19','https://images.genius.com/827059da7afd6febad6eab5114c5e396.630x630x1.jpg'),
('No Talk','3:00','Lowell','Pop','Ameryka','2022-01-19','https://cdns-images.dzcdn.net/images/cover/b5f33e103bf0b3824d5399092cb3943a/500x500.jpg'),
('OUTRUN MYSELF','5:00','Jack Kays, Travis Barker','Rock','Ameryka','2022-01-19','https://studiosol-a.akamaihd.net/uploadfile/letras/fotos/b/f/4/5/bf4568c3eda3f53dd23531aad83877b4.jpg'),
('SIDEWAYS','4:00','Jack Kays, Travis Barker','Rock','Ameryka','2022-01-19','https://studiosol-a.akamaihd.net/uploadfile/letras/fotos/b/f/4/5/bf4568c3eda3f53dd23531aad83877b4.jpg'),
('Ophelia','3:00','The Lumineers','Pop','Ameryka','2022-01-19','https://e.snmc.io/i/600/s/724fca7e305fcc480a91d8010169e343/6086517/the-lumineers-cleopatra-Cover-Art.jpg'),
('I Want You Back','3:00','The Jackson 5','Pop','Ameryka','2022-01-19','https://upload.wikimedia.org/wikipedia/en/9/96/Iwantyoubacksingle.jpg'),
('lonely','4:00','Machine Gun Kelly','Rock','Ameryka','2022-01-19','https://ecsmedia.pl/c/tickets-to-my-downfall-b-iext104185453.jpg'),
('my ex"s best friend','3:00','Machine Gun Kelly','Rock','Ameryka','2022-01-19','https://ecsmedia.pl/c/tickets-to-my-downfall-b-iext104185453.jpg'),
('parents','3:00','YUNGBLUD','Rock','Ameryka','2022-01-19','https://images.genius.com/2c24afdaee2107b0f3c67657bf73c096.1000x1000x1.jpg'),
('Kill Somebody','3:00','YUNGBLUD','Rock','Ameryka','2022-01-19','https://images.genius.com/2c24afdaee2107b0f3c67657bf73c096.1000x1000x1.jpg'),
('Medication','2:00','YUNGBLUD','Rock','Ameryka','2022-01-19','https://images.genius.com/2c24afdaee2107b0f3c67657bf73c096.1000x1000x1.jpg'),
('Mars','3:00','YUNGBLUD','Rock','Ameryka','2022-01-19','https://images.genius.com/2c24afdaee2107b0f3c67657bf73c096.1000x1000x1.jpg'),
('Zalatani','4:00','Sarius','Rap','Polska','2022-01-19','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7XtUfBBRZoiHgzugHLhXOIHZUoK9U2sy0Vw&usqp=CAU'),
('Nie Widać Po Mnie','4:00','Sarius','Rap','Polska','2022-01-19','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7XtUfBBRZoiHgzugHLhXOIHZUoK9U2sy0Vw&usqp=CAU'),
('Powiedział mi ktoś?','4:00','Sarius','Rap','Polska','2022-01-19','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7XtUfBBRZoiHgzugHLhXOIHZUoK9U2sy0Vw&usqp=CAU'),
('Usta','3:00','Przyłu','Trap','Polska','2022-01-19','https://ecsmedia.pl/c/juniper-w-iext58901693.jpg'),
('Bedzie lepiej','3:00','Tymek','Trap','Polska','2022-01-19','https://cdn.newonce.me/uploads/images/4747/schema_meta_data_tymekfit.jpg')