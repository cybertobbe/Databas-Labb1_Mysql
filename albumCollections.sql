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
