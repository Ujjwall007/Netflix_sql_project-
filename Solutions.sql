--Netflix Project

create table netflix
(
    show_id VARCHAR(6),
    type VARCHAR(10),
    title VARCHAR(150),
    director VARCHAR(208),
    casts VARCHAR(1000),
    country VARCHAR(150),
    date_added VARCHAR(50),
    release_year INT,
    rating VARCHAR(10),
    duration VARCHAR(15),
    listed_in VARCHAR(25),
    description VARCHAR(250)
);

drop table if exists netflix;

select * FROM netflix

ALTER TABLE netflix
ALTER COLUMN listed_in TYPE VARCHAR(80);

ALTER TABLE netflix
ALTER COLUMN description TYPE VARCHAR(260);


copy netflix
from '/Users/ujjwaltyagi/Downloads/netflix_titles.csv'
delimiter ','
csv header;

-- 15 Business Problems & Solutions:-

select * FROM netflix


--1. Count the number of Movies vs TV Shows
select type, count(type) as total_number
from netflix
group by type;

--2. Find the most common rating for movies and TV shows
SELECT type, rating, COUNT(*) AS common_r
FROM netflix
GROUP BY type, rating
ORDER BY common_r DESC;

--3. List all movies released in a specific year (e.g., 2020)
select title, release_year from netflix
where release_year =2020;

--4. Find the top 5 countries with the most content on Netflix
select country, count(country) as most_content
from netflix
group by country
order by most_content desc limit 5;

--5. Identify the longest movie or TV show duration
select title, duration, count(duration)  as longest_Movie_nd_tv
from netflix
group by title, duration
order by longest_Movie_nd_tv desc limit 2;

--6. Find content added in the last 5 years
SELECT title, release_year
FROM netflix
WHERE release_year BETWEEN 2017 AND 2021;

--7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
select title, director from netflix
where director = 'Rajiv Chilaka';

--8. List all TV shows with more than 5 seasons
SELECT title, type, duration
FROM netflix
WHERE type = 'TV Show'
AND CAST(SPLIT_PART(duration, ' ', 1) AS INT) > 5;

--9. Count the number of content items in each genre
select listed_in, count(listed_in) as total_num
from netflix
group by listed_in
order by total_num asc;

--10. Find the average release year for content produced in a specific country
select country, avg(release_year) as content_produce
from netflix
group by country;

--11. List all movies that are documentaries
select title, type, listed_in as all_doc
from netflix
where listed_in ='Documentaries';

--12. Find all content without a director
select title, director as yo
from netflix
where director is null;

--13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
SELECT COUNT(*) AS total_movies
FROM netflix
WHERE type = 'Movie'
AND casts LIKE '%Salman Khan%'
AND release_year BETWEEN 2012 AND 2021;

--14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
SELECT actor, COUNT(*) AS total_movies
FROM netflix,
     UNNEST(STRING_TO_ARRAY(casts, ', ')) AS actor
WHERE country LIKE '%India%'
AND type = 'Movie'
GROUP BY actor
ORDER BY total_movies DESC LIMIT 10;

--15. Categorize the content based on the presence of the keywords 'kill' and 'violence' 
--in the description field. Label content containing these keywords as 'Bad' and all
--other content as 'Good'. Count how many items fall into each category.

select 
case
when discription like '%kill%' than 'Bad'
or discription like '%Violence%' than 'Bad'
else 'Good'
end as category,
from netflix
group by category;

SELECT 
    CASE
        WHEN description LIKE '%kill%' THEN 'Bad'
        WHEN description LIKE '%violence%' THEN 'Bad'
        ELSE 'Good'
    END AS category,
FROM netflix
GROUP BY category;


