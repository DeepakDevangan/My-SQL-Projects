/* database - queries */

use sequelmovie;

select
	movieTitle as Title,
    movieDesc as Description,
    movieReleasedate as Release_Date,
    movieRuntime as Run_Time
from
	movie;

    
select
	movieTitle, movieRating
from
	movie
order by movieRating desc;


select
	movieTitle, movieRuntime, movieRating
from
	movie
where MovieRunTime > 150;


select
	movieTitle
from
	movie
where MovieReleaseDate < sysdate();


select movieTitle, personFirstName, personLastName, roleDesc
from movie, person, role
where movieID = m_movieID and p_personID = personID;

select * from movie_v_actors; #View

select songName
from song, artiste, song_artiste
where artisteID = a_artisteID and songID = s_songID and artisteName = 'Joe Bloggs';

select movieTitle, songName, soundtrackName, artisteName
from movie, song, soundtrack, artiste, soundtrack_song, song_artiste
where movieID = m_movieID and soundtrackID = soundtrack_soundtrackID and song_songID = songID and songID = s_songID and a_artisteID = artisteID;

select movieTitle, soundtrackName
from movie, soundtrack
where movieID = m_movieID and soundtrackSize > 10;

select * from movie_v_genre
where genreType in ('drama', 'comic book');

select * from movie_v_trailer;
select * from movie_v_trailer_poster;

insert into movie values (0011, 'Alien', 'After a space merchant vessel lands on the source moon and finds one of the crew attacked by a mysterious life-form.', '1979-6-22', 175, '18', '4.5'); 

delete from movie
where movieTitle = 'Alien';

alter table movie
change movieDesc moviePlot varchar(150);

update poster
set posterLink = ifnull(posterLink, 'http://www.uidownload.com/files/478/82/442/error-404-page-not-found-icon.jpg');

update person
set personPicture = ifnull(personPicture, 'http://www.uidownload.com/files/478/82/442/error-404-page-not-found-icon.jpg');

update trailer
set trailerURL = ifnull(trailerURL, 'https://youtu.be/dQw4w9WgXcQ');

