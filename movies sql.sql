use movies;

-- 1 write a SQL query to find those movies, which were released before 1998. Return movie title.
select mov_title from movies
where mov_year < 1998;

-- 2 write a SQL query to find the name of all reviewers and movies together in a single list.
select reviewer.rev_name from reviewer
union
select movies.mov_title from movies;

--  3 write a SQL query to find the movies with ID 905 or 907 or 917. Return movie title
select mov_title from movies
where mov_id IN (905,907,917);

-- 4 write a SQL query to find the movie titles that contain the word 'Boogie Nights'. Sort the result-set in ascending order by movie year.
-- Return movie ID, movie title and movie release year.
select mov_id,mov_title,mov_year from movies
where mov_title like '%Boogie%Nights%'
order by mov_year asc;

-- 5 write a SQL query to find those movies that have been released in countries other than the United Kingdom.
-- Return movie title, movie year, movie time, and date of release, releasing country
select mov_title,mov_year,mov_time,
mov_dt_rel as data_of_release,
mov_rl_country as releasing_country from movies
where mov_rl_country not in ('uk');

-- 6 write a SQL query to find those movies, which have received highest number of stars.
-- Group the result set on movie title and sorts the result-set in ascending order by movie title. 
-- Return movie title and maximum number of review stars.
select mov_title, max(rev_stars) 
from movies,rating
where movies.mov_id=rating.movie_id
and rating.rev_stars is not null
group by mov_title
order by mov_title;

-- 7 write a SQL query to determine those years in which there was at least one movie that received a rating of at least three stars.
-- Sort the result-set in ascending order by movie year. Return movie year
select distinct mov_year from movies
where mov_id IN (select mov_id from rating
where rev_stars > 3)
order by mov_year;

-- 8 write a SQL query to find those reviewers who have not given a rating to certain  films. Return reviewer name.
select distinct rev_name 
from reviewer 
where rev_id IN (
  select rev_id 
  from rating 
  where rev_stars IS null
);

-- 9 write a SQL query to find those reviewers who have not given a rating to certain  films. Return reviewer name.
select distinct r.rev_name from reviewer r inner join rating ra
 ON r.rev_id=ra.rev_id
where ra.rev_stars is null;

-- 10 write a SQL query to search for movies that do not have any ratings. Return movie title.
select distinct m.mov_title,r.rev_id from movies m
left join rating r on m.mov_id = r.movie_id
where r.movie_id IS null;

-- 11 write a SQL query to find out who was cast in the movie 'Annie Hall'. Return actor first name, last name and role.
select act_fname, act_lname, role
from actor
join movie_cast ON actor.act_id = movie_cast.act_id
join movies ON movie_cast.mov_id = movies.mov_id
AND movies.mov_title = 'Annie Hall';

-- 12write a SQL query to find the highest-rated movies. Return  movie title,  movie year, review stars and releasing country.
select mov_title,mov_year,rev_stars,mov_dt_rel as releasing_country
from movies natural join rating
where rev_stars = ( 
select max(rev_stars)
from rating
);