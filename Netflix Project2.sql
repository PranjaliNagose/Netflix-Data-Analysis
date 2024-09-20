create database netflix;
use netflix;

select * from titles;

-- total number of records
select count(*) as total_records from titles;

-- unique values in each column
select 
count(distinct show_id) as unique_show_ids,
count(distinct type) as unique_types,
count(distinct title) as unique_titles,
count(distinct director) as unique_directors,
count(distinct cast) as unique_casts,
count(distinct country) as unique_countries,
count(distinct date_added) as unique_dates_added,
count(distinct release_year) as unique_release_years,
count(distinct rating) as unique_ratings,
count(distinct duration) as unique_durations,
count(distinct listed_in) as unique_listed_in,
count(distinct description) as unique_descriptions
from titles;

-- count missing values in each column
select 
sum(case when director is null then 1 else 0 end) as missing_directors,
sum(case when cast is null then 1 else 0 end) as missing_cast,
sum(case when country is null then 1 else 0 end) as missing_country,
sum(case when date_added is null then 1 else 0 end) as missing_dates_added,
sum(case when rating is null then 1 else 0 end) as missing_ratings,
sum(case when duration is null then 1 else 0 end) as missing_durations
from titles;

-- distribution of type
select type, count(*) as count from titles
group by type
order by count desc;

-- distribution of rating
select rating, count(*) as count from titles
group by rating
order by count desc;

-- distribution of release year
select release_year, count(*) as count from titles
group by release_year
order by release_year;

-- no directors
select 
sum(case when director is null then 1 else 0 end) as missing_directors from titles;

-- top 10 common directors
select director, count(*) as count from titles
group by director
order by count desc
limit 10;

-- top 10 countries
select country, count(*) as count from titles
group by country
order by count desc
limit 10;

-- records add per month
select date_format(str_to_date(date_added,'%b %d, %Y'), '%Y-%m') as month, count(*) as count
from titles
group by month
order by month;

-- find records for dramas
select count(*) as count
from titles
where listed_in like '%dramas%';

-- average duration of movies/shows
select avg(cast(substring_index(duration,' ',1) as unsigned)) as average_duration
from titles
where duration regexp '^[0-9]+ min$';

-- find records with no director info
select count(*) as count from titles
where director = "";

-- records rleased in last 5 years
select * from titles
where release_year >= year(curdate())-5;

-- records for india country
select type, title from titles
where country = 'India';

-- records which offer seasons
select * from titles
where duration like '%seasons%';

-- records which have more than 2 seasons
select * from titles
where duration like '%seasons%'
and cast(substring_index(substring_index(duration,' ',1),' ',-1) as unsigned) > 2;