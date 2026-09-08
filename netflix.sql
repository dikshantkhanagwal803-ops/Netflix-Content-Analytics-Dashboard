1. Movies vs TV Shows
--------------------
select type,
count(*) as total_titles
from netflix_titles
group by type;

2. Top 10 Countries by Content
------------------------------
select country,
count(*) as total_titles
from netflix_titles
group by country
order by total_titles desc
limit 10;

3. Content Added Per Year
-------------------------
select 
year(str_to_date(date_added, '%M %d, %Y')) as year_added,
count(*) as total_titles
from netflix_titles
group by year_added
order by year_added;

4. Most Common Ratings
------------------------
select rating,
count(*) as total_ratings
from netflix_titles
group by rating
order by total_ratings DESC;

5. Top Genres
-----------------
select listed_in,
count(*) as total_titles
from netflix_titles
group by listed_in
order by total_titles desc
limit 10;

6. Top Directors
-------------------
select director,
count(*) as total_titles
from netflix_titles
group by director
order by total_titles desc
limit 10;

7. Content Ranking by Country
-----------------------------
select country,
count(*) as total_tittle,
rank() over(
order by count(*) desc)
as country_ranking
from netflix_titles
group by country;

8. Content Growth Trend
-------------------------

with yearly_content as(
select
year(str_to_date(date_added,'%M %D %Y')) as year_added,
count(*) as total_titles
from netflix_titles
group by year_added
)

select*,
lag(total_titles)over(
order by year_added) as previous_year

from yearly_content;

9. Movies vs TV Shows by Country
----------------------------------

select
country,
type,
count(*) as total_titles
from netflix_titles
group by country,type;

10. Content Released by Decade
-------------------------------
select 
case
when release_year >= 2020 then '2020s'
when release_year >= 2010 then '2010s'
when release_year >= 2020 then '2000s'
else 'before 2000s'
end as decade,
count(*) as total_titles
from netflix_titles
group by decade;

11. Most Common Rating by Content Type
----------------------------------------
select
type, rating,
max(rating),
count(*) as total_titles,
rank() over(
partition by type
order by type, max(rating) desc) as rating_rank
from netflix_titles
group by type, rating;

12. List all the movies relaesed in specific year '2020'
---------------------------------------------------------
select title,
release_year,
type
from netflix_titles
where release_year = 2020 and type ='Movie'

13. Find the top 5 countries with most content on netflix
----------------------------------------------------------
select country, count(*) as total_titles
from netflix_titles
group by country 
order by total_titles desc
limit 5;

14. Identify the longest movie
-------------------------------
select title,
duration
from netflix_titles
where type = 'Movie'
order by cast(replace(duration,'min','') as unsigned) desc
limit 1;

15. find content added in last 5 years
--------------------------------------

select *
from netflix_titles
where release_year >= (
 select max(release_year)-5
 from netflix_titles);



