CREATE DATABASE albumCollection1;

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
    price INT,
    FOREIGN KEY (artistAlbumId) REFERENCES artist(artistId),
    FOREIGN KEY (albumGenreId) REFERENCES genre(genreId),
    PRIMARY KEY (albumId)
);

INSERT INTO artist(artistName)
VALUES ('Ludwig van Beethoven'),
       ('Franz Schubert'),
       ('Iron Maiden'),
       ('Roxette'),
       ('Dr Dre'),
       ('Van Halen');


INSERT INTO genre(genreName)
VALUES ('Classical'),
       ('Rock'),
       ('Hiphop'),
       ('Pop');


INSERT INTO album(albumTitle, artistAlbumId, albumGenreId, price)
VALUES ('Piano Concertos Nos 1-5', 1,1, 59), -- Beethoven
       ('Leichenfantasie', 2, 1, 99), -- Schubert
       ('OU812',6, 2, 129),  -- Van Halen
       ('Look Sharp', 4, 4, 99),  -- Roxette
       ('Chronic', 5, 3, 99), -- Dr Dre
       ('Brave new world', 3, 2, 89), -- Iron Maiden
       ('Joyride', 4,4, 89),                -- Roxette
       ('Dreams', 6, 2, 99),                -- Van Halen
       ('Run to the hills', 3, 2, 59),      -- Iron Maiden
       ('Compton', 5, 3, 59),               -- Dr Dre
       ('Piano Concerto No.4+5', 1, 1, 99), -- Beethoven
       ('Dretox', 5, 3, 89),                 -- Dr Dre
       ('Impromptus D899 & D935', 1, 1, 59), -- Beethoven
       ('Piano Duets', 1, 1, 59),              -- Beethoven
       ('Somewhere in Time', 3, 2, 129);    -- Iron Maiden


SELECT * FROM artist;
SELECT * FROM album;
SELECT * FROM genre;

-- Update album genre
UPDATE album
SET albumGenreId = 2
WHERE albumTitle = 'Joyride';

-- Delete 1 album
DELETE FROM album
WHERE albumTitle = 'Somewhere in Time';

SELECT * FROM artist;
SELECT * FROM genre;
SELECT * FROM album;

SELECT albumTitle FROM album WHERE albumGenreId = 2;

-- Inner Join
-- Hämtar alla album titlar och artistnamn i genre hiphop
SELECT genre.genreName, album.albumTitle, artist.artistName
FROM album
INNER JOIN genre ON album.albumGenreId = genre.genreId
INNER JOIN artist ON album.artistAlbumId = artist.artistId
WHERE genre.genreName = 'Classical';

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



-- Transaction uppdatera album kolumn pris med priser


-- Visa referens integritet, 2 rader
-- Försök ta bort en skiva som är kopplad, försök att lägga till skiva till något icke kopplat.
DELETE FROM genre WHERE genreID = '2';



DROP DATABASE albumCollection1;
