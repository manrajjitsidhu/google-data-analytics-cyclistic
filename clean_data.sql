SET SQL_SAFE_UPDATES = 0;
update aggregated_all_year_data
set start_station_name = null where start_station_name='';
update aggregated_all_year_data
set end_station_name = null where end_station_name='';
update aggregated_all_year_data
set end_station_name = null where end_station_name='';
update aggregated_all_year_data
set rideable_type = 'classic_bike' where rideable_type='docked_bike';



create table cleaned_data as (
select
	rideable_type as ride_type,
	ROW_NUMBER() OVER(ORDER BY started_at ASC) AS identifier,
	trim(start_station_name) as start_station,
	trim(end_station_name) as end_station,
    started_at,
	hour(started_at) as hour,
	day(started_at) as day,
	month(started_at) as month,
	year(started_at) as year,
	timestampdiff(minute,started_at, ended_at) as trip_duration,
	start_lat,
	start_lng,
	end_lat,
	end_lng,
	member_casual AS membership_type
from 
	aggregated_all_year_data
);
create table final_cleaned_data as (
select 
ride_type,
identifier,
start_station,
end_station,
started_at,
hour,
	case
when day = 1 then 'Monday' 
when day = 2 then 'Tuesday'
when day = 3 then 'Wednesday'
when day = 4 then 'Thursday'
when day = 5 then 'Friday'
when day = 6 then 'Saturday'
when day = 7 then 'Sunday'
end as weekday,
case
when day < 6 then 'Weekday'
 else 'Weekend'
end as dayname,
case
when month = 1 then 'January'
when month = 2 then 'Februrary'
when month = 3 then 'March'
when month = 4 then 'April'
when month = 5 then 'May'
when month = 6 then 'June'
when month = 7 then 'July'
when month = 8 then 'August'
when month = 9 then 'September'
when month = 10 then 'October'
when month = 11 then 'November'
when month = 12 then 'December'
end as monthname,
year,
trip_duration,
	start_lat,
	start_lng,
	end_lat,
	end_lng,
	membership_type
from 
	cleaned_data
where 
	trip_duration > 1 
	and trip_duration < 1440
	and start_station not in ('Pawel Bialowas - Test- PBSC charging station',
								'Base - 2132 W Hubbard Warehouse',
								'DIVVY CASSETTE REPAIR MOBILE STATION',
								'Base - 2132 W Hubbard',
								'Lincoln Ave & Roscoe St - Charging',
								'Wilton Ave & Diversey Pkwy - Charging',
								'Bissell St & Armitage Ave - Charging')
	and end_station not in ('Pawel Bialowas - Test- PBSC charging station',
								'Base - 2132 W Hubbard Warehouse',
								'DIVVY CASSETTE REPAIR MOBILE STATION',
								'Base - 2132 W Hubbard',
								'Lincoln Ave & Roscoe St - Charging',
								'Wilton Ave & Diversey Pkwy - Charging',
								'Bissell St & Armitage Ave - Charging')
);
delete from final_cleaned_data 
where weekday is null;