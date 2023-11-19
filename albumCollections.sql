CREATE DATABASE albumCollection;

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

INSERT INTO artist(artistName)
VALUES ('Ludwig van Beethoven'),
       ('Franz Schubert'),
       ('Iron Maiden'),
       ('Roxette'),
       ('Dr Dre'),
       ('Van Halen');

SELECT * FROM artist;

INSERT INTO genre(genreName)
VALUES ('Classical'),
       ('Rock'),
       ('Hiphop'),
       ('Pop');

SELECT * FROM genre;


INSERT INTO album(albumTitle, artistAlbumId, albumGenreId)
VALUES ('Piano Concertos Nos 1-5', 1,1), -- Beethoven
       ('Leichenfantasie', 2, 1), -- Schubert
       ('OU812',6, 2),  -- Van Halen
       ('Look Sharp', 4, 4),  -- Roxette
       ('Chronic', 5, 3), -- Dr Dre
       ('Brave new world', 3, 2); -- Iron Maiden


SELECT * FROM artist;
SELECT * FROM genre;
SELECT * FROM album;

SELECT albumTitle FROM album WHERE albumGenreId = 3;

-- Join
SELECT album.albumId, album.albumTitle, artist.artistName
FROM album
JOIN artist ON album.artistAlbumId = artist.artistId
WHERE artist.artistName = 'Dr Dre';




