/* Instagram clone exploratory data analysis */

/* Used Main Functions : joins, date manipulation, regular expression, views, stored procedures, agrregate functions, string manipulation */

use ig_clone;
----------------------------------------------------------------------------------------------------------------

# Question-1: The first 10 users on the platform
select
	username
from
	ig_clone.users
order by created_at
limit 10;

----------------------------------------------------

# Question-2: Total Number of registrations

select 
	count(*) as total_registration
from
	ig_clone.users;

----------------------------------------------------

# Question-3: The day of the week, when the most users registered on

create view vwtotalregistrations as
select
	date_format(created_at, '%W') as day_of_week,
    count(*) as total_registration
from
	ig_clone.users
group by 1
order by 2 desc;

select
	*
from
	vwtotalregistrations;
    
    /* Another Version */
    
select
	dayname(created_at) as day_name,
    count(*) as total_registration
from
	ig_clone.users
group by day_name
order by total_registration desc;     
----------------------------------------------------------------------------

# Question-4: The user who have never posted a photo
select
	u.username as user_name
from
	ig_clone.users u
    left join
    ig_clone.photos p on u.id = p.user_id
    where p.user_id is null;
----------------------------------------------------------------------------

# Question-5: The most likes on a single photo
select
	u.username as user_name, 
    p.image_url as Image, 
    count(*) as total_likes
from
	ig_clone.users u 
    inner join
    ig_clone.photos p on u.id = p.user_id 
    inner join
    ig_clone.likes l on p.id = l.photo_id
group by u.username, p.image_url
order by total_likes desc
limit 1;
-----------------------------------------------------------------------------

# Question-6: The number of photos posted by most 5 active users
select
	u.username as user_Name, 
    count(*) as total_post
from
	ig_clone.users u 
    right join
    ig_clone.photos p on p.user_id = u.id
group by u.username
order by total_post desc
limit 5;
---------------------------------------------------------------------

# Question-7: The total number of post
select
	count(image_url) as total_number_of_post_by_user
from
	ig_clone.users u 
    inner join
	ig_clone.photos p on p.user_id = u.id;
---------------------------------------------------------------------

# Question-8: The total number of users who posted
select
	count(distinct u.username) as total_number_users_with_post
from
	ig_clone.users u 
    inner join
	ig_clone.photos p on p.user_id = u.id;
--------------------------------------------------------------------

# Question-9: The username with numbers as ending
select
	id, username
from
	ig_clone.users
where username regexp '[%0-9]';
-------------------------------------------------------------------

# Question-10: The usernames with character as ending 
select
	id, username
from
	ig_clone.users
where username not regexp '[$0-9]';
-------------------------------------------------------------------

#Question-11: Username starts with "A"
select
	id, username
from
	ig_clone.users
where username regexp '^[A]';
-------------------------------------------------------------------

#Question-12: The most popular tag names by likes
select
	t.tag_name as tag_name,
    count(l.photo_id) as number_of_likes
from
	ig_clone.photo_tags pt
    join
    ig_clone.likes l on l.photo_id = pt.photo_id
    join
    ig_clone.tags t on t.id = pt.tag_id 
group by tag_name
order by number_of_likes desc
limit 10;
--------------------------------------------------------------------

# Question-13: Total number of users without comments
select
	count(*) as total_number_of_users_without_comments
from
	(select
		u.username, c.comment_text
	from
		ig_clone.users u 
		left join
		ig_clone.comments c on c.user_id = u.id
	group by u.id, c.comment_text
	having comment_text is null) as users;
----------------------------------------------------------------------

# Question-14: The users who have liked every single photo on the library
select
	u.id,
    u.username,
    count(l.photo_id) as total_likes_by_user
from
	ig_clone.users u 
    left join
    ig_clone.likes l on u.id = l.user_id
group by u.id
having total_likes_by_user = (select count(*) from ig_clone.photos);
--------------------------------------------------------------------------        
        
# Question-16: The percentage of users who have either never commented on a photo or likes every photo

SELECT 
    tableA.total_A AS 'Number Of Users who never commented',
    (tableA.total_A / (SELECT 
            COUNT(*)
        FROM
            ig_clone.users u)) * 100 AS '%',
    tableB.total_B AS 'Number of Users who likes every photos',
    (tableB.total_B / (SELECT 
            COUNT(*)
        FROM
            ig_clone.users u)) * 100 AS '%'
FROM
    (SELECT 
        COUNT(*) AS total_A
    FROM
        (SELECT 
        u.username, c.comment_text
    FROM
        ig_clone.users u
    LEFT JOIN ig_clone.comments c ON u.id = c.user_id
    GROUP BY u.id , c.comment_text
    HAVING comment_text IS NULL) AS total_number_of_users_without_comments) AS tableA
        JOIN
    (SELECT 
        COUNT(*) AS total_B
    FROM
        (SELECT 
        u.id, u.username, COUNT(u.id) AS total_likes_by_user
    FROM
        ig_clone.users u
    JOIN ig_clone.likes l ON u.id = l.user_id
    GROUP BY u.id , u.username
    HAVING total_likes_by_user = (SELECT 
            COUNT(*)
        FROM
            ig_clone.photos p)) AS total_number_users_likes_every_photos) AS tableB;
------------------------------------------------------------------------------------

#Question-18: The average time on the platform

select  
    round(avg(datediff(current_timestamp, created_at)/360), 2) as Total_Years_on_Platform
from
    ig_clone.users;
------------------------------------------------------------------------------------


	



