{{ config(
    materialized='table',
    partition_by={
      "field": "start_timestamp",
      "data_type": "timestamp",
      "granularity": "day"
    }
)}}

with ny_trips as

( SELECT 

md5(starttime||stoptime||bikeid||start_station_id||end_station_id) as hash_trip_id
,cast(null as string) as original_trip_id
,'ny' as city
,tripduration as duration_sec
,timestamp(starttime) as start_timestamp
,start_station_name
,start_station_id
,timestamp(stoptime) as end_timestamp
,end_station_name
,end_station_id
,bikeid as bike_id
,cast(null as string) as zip_code
,usertype as subscriber_type
,start_station_latitude
,start_station_longitude
,end_station_latitude
,end_station_longitude
,birth_year as member_birth_year
,date_diff(date(starttime),date(birth_year||'-01-01'),year) member_age
,gender as member_gender
,st_geogpoint(start_station_longitude, start_station_latitude) start_station_geom
,st_geogpoint(end_station_longitude, end_station_latitude) end_station_geom
,st_distance(st_geogpoint(start_station_longitude, start_station_latitude), st_geogpoint(end_station_longitude, end_station_latitude)) min_trip_distance_meters
,if(start_station_id = end_station_id, true, false) is_returned_to_same_station

from {{ source('dholmes_lightdash_demo', 'ny_bikeshare_trips') }}

where start_station_id is not null )

, trips_ranked as (

    SELECT

    *
    ,row_number() over (partition by hash_trip_id order by duration_sec desc) rownum

    from ny_trips

)

select

* except (rownum)

from trips_ranked

where rownum = 1 