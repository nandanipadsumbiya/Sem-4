select * from Albums
select * from Artists
select * from Songs

----------------------------------------part A------------------------------------------------

--1. Retrieve a unique genre of songs.
select distinct genre 
from Songs

--2.Find top 2 albums released before 2010. 
select top 2 release_year
from Albums
where release_year<2010

--3.Insert Data into the Songs Table. (1245, ‘Zaroor’, 2.55, ‘Feel good’, 1005) 
insert into Songs
values (1245 , 'Zaroor' , 2.55 , 'Feel good' , 1005)

--4.Change the Genre of the song ‘Zaroor’ to ‘Happy’ 
update Songs
set Genre = 'Happy'
where Song_title = 'Zaroor'

--5.Delete an Artist ‘Ed Sheeran’ 
delete from Artists
where Artist_name ='Ed Sheeran'


--6.Add a New Column for Rating in Songs Table. [Ratings decimal(3,2)]
alter table Songs
add  Rating decimal(3,2)


--7.Retrieve songs whose title starts with 'S'. 
select Song_title 
from Songs
where Song_title Like 'S%'


--8.Retrieve all songs whose title contains 'Everybody'. 
select Song_title 
from Songs
where Song_title Like '%Everybody%'

--9.Display Artist Name in Uppercase. 
select upper(Artist_name)
from Artists


--10.Find the Square Root of the Duration of a Song ‘Good Luck’
select sqrt(duration) 
from Songs
where Song_title = 'good luck'

--11.Find Current Date.
select getdate()

--12.Find the number of albums for each artist.
select count(Albums.Album_id) as number_of_artist
from Albums join Artists
on Albums.Artist_id = Artists.Artist_id



--13.Retrieve the Album_id which has more than 5 songs in it.
select Albums.Album_id
from Songs inner join Albums
on Songs.Album_id = Albums.Album_id
group by Albums.Album_id
having count(Songs.Song_id)>5


--14.Retrieve all songs from the album 'Album1'. (using Subquery) 
select * from Songs
where Album_id =(
	select Album_id
	from Albums
	where Album_title='Album1'
)

--15.Retrieve all albums name from the artist ‘Aparshakti Khurana’ (using Subquery)
select Album_title
from Albums
where Artist_id = (
		select Artist_id
		from Artists
		where Artist_name = ' Aparshakti Khurana ')


--16. Retrieve all the song titles with its album title. 
select S.Song_title,
		A.Album_title
from Songs s
inner join Albums A
on S.Album_id = A.Album_id


--17. Find all the songs which are released in 2020.
select S.Song_title,
		A.Release_year
from Songs S
inner join Albums A
on S.Album_id = A.Album_id
where A.Release_year = 2020


--18. Create a view called ‘Fav_Songs’ from the songs table having songs with song_id 101-105. 
CREATE VIEW Fav_Songs
AS
select * from Songs
where Song_id Between 101 AND 105

select * from Fav_Songs


--19.Update a song name to ‘Jannat’ of song having song_id 101 in Fav_Songs view. 
update Fav_Songs
set Song_title = 'JANNAT '
where Song_id = 101;



--20. Find all artists who have released an album in 2020.
select AR.Artist_Name,
	   AL.Release_year
from Albums AL
inner join Artists AR
on AL.Artist_id = AR.Artist_id
where AL.Release_year = 2020

--21. Retrieve all songs by Shreya Ghoshal and order them by duration.
select AR.Artist_name,
	   S.Song_title
from Artists AR
inner join Albums AL
on AR.Artist_id = AL.Artist_id
inner join Songs S
on S.Album_id = AL.Album_id
where AR.Artist_name = 'Shreya Ghoshal'
order by S.Duration


----------------------------------------Part B----------------------------------------

--22.Retrieve all song titles by artists who have more than one album. 
SELECT S.Song_title, A.Album_title, AR.Artist_name
FROM Songs S
JOIN Albums A 
ON S.Album_id = A.Album_id
JOIN Artists AR 
ON A.Artist_id = AR.Artist_id
WHERE A.Artist_id IN (
    SELECT Artist_id
    FROM Albums
    GROUP BY Artist_id
    HAVING COUNT(Album_id) > 1
);


--23.Retrieve all albums along with the total number of songs.  
SELECT A.Album_id, A.Album_title, COUNT(S.Song_id) AS Total_Songs
FROM Albums A
LEFT JOIN Songs S 
ON A.Album_id = S.Album_id
GROUP BY A.Album_id, A.Album_title, A.Release_year;


--24.Retrieve all songs and release year and sort them by release year.
SELECT S.Song_title , A.Release_year 
FROM Songs S
JOIN Albums A
ON S.Album_id = A.Album_id
ORDER BY A.Release_year


--25.Retrieve the total number of songs for each genre, showing genres that have more than 2 songs. 
SELECT Genre, COUNT(*) AS Total_Songs
FROM Songs
GROUP BY Genre
HAVING COUNT(*) > 2;


--26. List all artists who have albums that contain more than 3 songs.
SELECT AR.Artist_id, AR.Artist_name
FROM Artists AR
JOIN Albums AL 
ON AR.Artist_id = AL.Artist_id
JOIN Songs S 
ON AL.Album_id = S.Album_id
GROUP BY AR.Artist_id, AR.Artist_name
HAVING COUNT(S.Song_id) > 3;



--------------------------------------------------------PART C-------------------------------------------------------------


--27. Retrieve albums that have been released in the same year as 'Album4' 
SELECT Album_id, Album_title, Artist_id, Release_year
FROM Albums
WHERE Release_year = ( SELECT Release_year FROM Albums WHERE Album_title = 'Album4')
AND Album_title != 'Album4';


--28. Find the longest song in each genre 
SELECT S.Song_title, S.Genre, S.Duration
FROM Songs S
WHERE S.Duration = 
			(SELECT MAX(Duration) 
			FROM Songs
			WHERE Genre = S.Genre);



--29. Retrieve the titles of songs released in albums that contain the word 'Album' in the title. 
SELECT S.Song_title
FROM Songs S
JOIN Albums A 
ON S.Album_id = A.Album_id
WHERE A.Album_title LIKE '%Album%';


--30. Retrieve the total duration of songs by each artist where total duration exceeds 15 minutes. 
SELECT AR.Artist_id, AR.Artist_name, SUM(S.Duration) AS Total_Duration FROM Artists AR
JOIN Albums AL 
ON AR.Artist_id = AL.Artist_id
JOIN Songs S 
ON AL.Album_id = S.Album_id
GROUP BY AR.Artist_id, AR.Artist_name
HAVING SUM(S.Duration) > 15;



