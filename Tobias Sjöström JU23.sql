-- Detta är en databas för en skivsamling, indelad i artist, genre och album

-- Skapa databas
CREATE DATABASE albumCollection;

-- Skapa 3 tabeller
CREATE TABLE artist(
    artistId INT NOT NULL AUTO_INCREMENT,
    artistName VARCHAR(50),
    PRIMARY KEY (artistId)
);

CREATE TABLE genre(
  genreID INT NOT NULL AUTO_INCREMENT,
  genreName VARCHAR(30),
  PRIMARY KEY (genreId)
);

CREATE TABLE album(
    albumId INT NOT NULL AUTO_INCREMENT,
    albumTitle VARCHAR(30),
    artistAlbumId INT NOT NULL,
    albumGenreId INT NOT NULL,
    FOREIGN KEY (artistAlbumId) REFERENCES artist(artistId),
    FOREIGN KEY (albumGenreId) REFERENCES genre(genreId),
    PRIMARY KEY (albumId)
);


-- Lägg till artister
INSERT INTO artist(artistName)
VALUES ('Ludwig van Beethoven'),
       ('Franz Schubert'),
       ('Iron Maiden'),
       ('Roxette'),
       ('Dr Dre'),
       ('Van Halen');

-- Lägg till genres
INSERT INTO genre(genreName)
VALUES ('Classical'),
       ('Rock'),
       ('Hiphop'),
       ('Pop');

-- Lägg till album
INSERT INTO album(albumTitle, artistAlbumId, albumGenreId)
VALUES ('Piano Concertos Nos 1-5', 1,1),    -- Beethoven
       ('Leichenfantasie', 2, 1),           -- Schubert
       ('OU812',6, 2),                      -- Van Halen
       ('Look Sharp', 4, 4),                -- Roxette
       ('Chronic', 5, 3),                   -- Dr Dre
       ('Brave new world', 3, 2);           -- Iron Maiden

-- Update lägger till fler album
INSERT INTO album(albumTitle, artistAlbumId, albumGenreId)
VALUES ('Joyride', 4,4),                -- Roxette
       ('Dreams', 6, 2),                -- Van Halen
       ('Run to the hills', 3, 2),      -- Iron Maiden
       ('Compton', 5, 3),               -- Dr Dre
       ('Piano Concerto No.4+5', 1, 1), -- Beethoven
       ('Dretox', 5, 3);                -- Dr Dre

-- Update lägger till fler album
INSERT INTO album(albumTitle, artistAlbumId, albumGenreId)
VALUES ('Impromptus D899 & D935', 1, 1),    -- Beethoven
       ('Piano Duets', 1, 1),               -- Beethoven
       ('Somewhere in Time', 3, 2);         -- Iron Maiden

-- Kolla tabellerna
SELECT * FROM artist;
SELECT * FROM album;
SELECT * FROM genre;

-- Update album genre
-- Ändra genre för album Joyride från pop till rock
UPDATE album
SET albumGenreId = 2
WHERE albumTitle = 'Joyride';

-- Delete 1 album
DELETE FROM album
WHERE albumTitle = 'Somewhere in Time';


-- Inner Join
-- Hämtar alla albumtitlar och artistnamn i genre hiphop
SELECT genre.genreName, album.albumTitle, artist.artistName
FROM artist
INNER JOIN album ON artist.artistId = album.artistAlbumId
INNER JOIN genre ON album.albumGenreId = genre.genreID
WHERE genre.genreName = 'Hiphop';

-- Räkna antalet artister
SELECT COUNT(artist.artistName) AS numberOfArtists FROM artist;


-- Skapa vy som visar alla artister tillsammans med albumName
CREATE VIEW ArtistsAndAlbums AS
SELECT artist.artistName, album.albumTitle
FROM artist
LEFT JOIN album ON artist.artistId = album.artistAlbumId;

-- Visa Vy sorterad i bokstavsordning på artistName
SELECT * FROM ArtistsAndAlbums
         ORDER BY artistName;


-- Lägg till kolumn för pris i album inför transaction
ALTER TABLE album
ADD price INT AFTER albumTitle;
-- Kolla att kolumn för pris blivit tillagd.
SELECT * FROM album;

-- Transaction uppdatera albumkolumn pris med priser
-- Disable auto-commit
SET AUTOCOMMIT = 0;

-- Starta transaktion och uppdatera 3 st album till 89 kr.
START TRANSACTION;
UPDATE album
SET album.price=89
WHERE albumTitle IN('Compton', 'Dreams', 'Look Sharp');

-- Uppdatera album Piano Duets till 99 kr
UPDATE album
SET album.price=99
WHERE albumTitle = ('Piano Duets');

-- Ignorera uppdatering
ROLLBACK;
-- Spara uppdatering permanent
COMMIT;

-- Referens integritet

-- Försök radera en genre som är kopplad till album
DELETE FROM genre WHERE genreID = '2';
-- Försök radera en tabell med kopplingar
DROP TABLE artist;

-- Radera alla tabeller i rätt ordning
DROP TABLE album;
DROP TABLE genre;
DROP TABLE artist;

-- Radera databas
DROP DATABASE albumCollection;
