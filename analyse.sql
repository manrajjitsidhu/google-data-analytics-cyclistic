create table ride_type_summary as 
(
select ride_type,  membership_type,
count(*) as ride_count,
sum(trip_duration) as total_trip_length, 
round(avg(trip_duration),2) as avg_trip_length
from final_cleaned_data
group by ride_type, membership_type
order by ride_count desc
);

create table hour_summary as 
(
select hour,  membership_type,
count(*) as ride_count,
sum(trip_duration) as total_trip_length, 
round(avg(trip_duration),2) as avg_trip_length
from final_cleaned_data
group by hour, membership_type
order by hour 
);

create table day_type_summary as 
(
select dayname,  membership_type,
count(*) as ride_count,
sum(trip_duration) as total_trip_length, 
round(avg(trip_duration),2) as avg_trip_length
from final_cleaned_data
group by dayname, membership_type
order by ride_count desc
);

create table weekday_summary as 
(
select weekday,  membership_type,
count(*) as ride_count,
sum(trip_duration) as total_trip_length, 
round(avg(trip_duration),2) as avg_trip_length
from final_cleaned_data
group by weekday, membership_type
order by ride_count desc
);

create table month_summary as 
(
select monthname,  membership_type,
count(*) as ride_count,
sum(trip_duration) as total_trip_length, 
round(avg(trip_duration),2) as avg_trip_length
from final_cleaned_data
group by monthname, membership_type
order by ride_count desc
);

create table membership_type_summary as 
(
select membership_type, 
count(*) as ride_count,
sum(trip_duration) as total_trip_length, 
round(avg(trip_duration),2) as avg_trip_length
from final_cleaned_data
group by membership_type
);

create table start_station_summary as 
(
select distinct(start_station), 
count(*) as ride_count,
sum(trip_duration) as total_trip_length, 
round(avg(trip_duration),2) as avg_trip_length
from final_cleaned_data
group by start_station
order by ride_count desc
);

create table end_station_summary as 
(
select distinct(end_station), 
count(*) as ride_count,
sum(trip_duration) as total_trip_length, 
round(avg(trip_duration),2) as avg_trip_length
from final_cleaned_data
group by end_station
order by ride_count desc
);
