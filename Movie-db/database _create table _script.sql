/* Database - create table - movie-db */

create database if not exists sequelmovie;

use sequelmovie;

create table movie (
	movieID int(5) not null,
    movieTitle varchar(50) not null,
    movieDesc varchar(150),
    MovieReleaseDate date,
    MovieRunTime int(3) check (MovieRunTime > 25),
    MovieCertificate varchar(4) check (movieCertificate in ('N/A','PG','12','12A','15','15A','16','18')),
    MovieRating int(1) check (MovieRating > 0 and MovieRating <= 5),
    constraint movie_pk primary key (movieID)
);


create table poster (
	posterID int(5) not null,
	posterLink varchar (200) default 'http://www.uidownload.com/files/478/82/442/error-404-page-not-found-icon.jpg',
	p_movieID int(5) not null,
	constraint poster_pk primary key (posterID),
	constraint poster_fk_movie foreign key (p_movieID) references movie (movieID)
);


create table trailer (
	trailerID int(5) not null,
    trailerLength int(2),
    trailerURl varchar(150),
    t_movieID int (5) not null,
    constraint trailer_pk primary key (trailerID),
    constraint trailer_fk_movie foreign key (t_movieID) references movie (movieID)
);


create table studio (
	studioID int(5) not null,
    studioName varchar(50) not null,
    studioAddress varchar(200),
    constraint studio_pk primary key (studioID)
);


create table movie_studio (
	movie_studioID int(5) not null,
    m_movieID int(5) not null,
    s_studioID int(5) not null,
    constraint movie_studio_pk primary key (movie_studioID),
    constraint movie_studio_fk_movie foreign key (m_movieID) references movie (movieID),
    constraint movie_studio_fk_studio foreign key (s_studioID) references studio (studioID)
);

create table genre (
	genreID int(5) not null,
    genreType varchar(25) not null,
    genreDesc varchar(200),
    constraint genre_pk primary key (genreID)
);

create table movie_genre (
	movie_genreID int(5) not null,
    m_movieID int(5) not null,
    g_genreID int(5) not null,
    constraint movie_genre_pk primary key (movie_genreID),
    constraint movie_genre_fk_movie foreign key (m_movieID) references movie (movieID),
    constraint movie_genre_fk_genre foreign key (g_genreID) references genre (genreID)
);

create table person(
    personID int(5) not null,
    personFirstName varchar(50) not null,
    personLastName varchar(50),
    personNationality varchar(50),
    personPicture varchar (150),
    constraint person_pk primary key (personID)
);

create table role(
    roleID int(5) not null,
    roleDesc varchar(25) not null,
    m_movieID int(5) not null,
    p_personID int(5) not null,
    constraint role_pk primary key (roleID),
    constraint role_fk_movie foreign key (m_movieID) references movie (movieID),
    constraint role_fk_person foreign key (p_personID) references person (personID)
);

create table soundtrack(
    soundtrackID int(5) not null,
    soundtrackName varchar(100) not null,
    soundtrackSize int(2),
    m_movieID int(5) not null,
    constraint soundtrack_pk primary key (soundtrackID),
    constraint soundtrack_fk_movie foreign key (m_movieID) references movie (movieID)
);

create table song(
    songID int(5) not null,
    songName varchar(100) not null,
    songLength int(3),
    songURL varchar(150),
    constraint song_pk primary key (songID)
);

create table soundtrack_song(
    soundtrack_songID int(5) not null,
    soundtrack_soundtrackID int(5) not null,
    song_songID int(5) not null,
    constraint soundtrack_song_pk primary key (soundtrack_songID),
    constraint soundtrack_song_fk_soundtrack foreign key (soundtrack_soundtrackID) references soundtrack (soundtrackID),
    constraint soundtrack_song_fk_song foreign key (song_songID) references song (songID)
);

create table artiste(
    artisteID int(5) not null,
    artisteName varchar(50) not null,
    artisteNationality varchar(50),
    constraint artiste_pk primary key (artisteID)
);


create table song_artiste(
    song_artisteID int(5) not null,
    s_songID int(5) not null,
    a_artisteID int(5) not null,
    constraint song_artiste_pk primary key (song_artisteID),
    constraint song_artiste_fk_song foreign key (s_songID) references song (songID),
    constraint song_artiste_fk_artiste foreign key (a_artisteID) references artiste (artisteID)
);

create table band(
    bandID int(5) not null,
    bandName varchar(25) not null,
    constraint band_pk primary key (bandID)
);

create table song_band(
    song_bandID int(5) not null,
    song_songID int(5) not null,
    b_bandID int(5) not null,
    constraint song_band_pk primary key (song_bandID),
    constraint song_band_fk_song foreign key (song_songID) references song (songID),
    constraint song_band_fk_band foreign key (b_bandID) references band (bandID)
);

create table artiste_band(
    artiste_bandID int(5) not null,
    bandRole varchar(50),
    a_artisteID int(5) not null,
    b_bandID int(5) not null,
    constraint artiste_band_pk primary key (artiste_bandID),
    constraint artiste_band_fk_artiste foreign key (a_artisteID) references artiste (artisteID),
    constraint artiste_band_fk_band foreign key (b_bandID) references band (bandID)
);
