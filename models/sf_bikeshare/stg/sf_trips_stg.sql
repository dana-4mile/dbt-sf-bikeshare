{{ config(
    materialized='table',
    partition_by={
      "field": "start_timestamp",
      "data_type": "timestamp",
      "granularity": "day"
    }
)}}

with sf_trips as (

SELECT 

md5('sf'||trip_id) as hash_trip_id
,trip_id as original_trip_id
,'sf' as city
,duration_sec
,start_date as start_timestamp
,start_station_name
,start_station_id
,end_date as end_timestamp
,end_station_name
,end_station_id
,bike_number as bike_id
,zip_code
,subscriber_type
,start_station_latitude
,start_station_longitude
,end_station_latitude
,end_station_longitude
,member_birth_year
,member_gender
,start_station_geom
,end_station_geom
,st_distance(start_station_geom, end_station_geom) min_trip_distance_meters
,if(start_station_id = end_station_id, true, false) is_returned_to_same_station

from {{ source('bikeshare', 'sf_bikeshare_trips') }} )

, trips_ranked as (

    SELECT

    *
    ,row_number() over (partition by hash_trip_id order by duration_sec desc) rownum

    from sf_trips

)

select

* except (rownum)

from trips_ranked

where rownum = 1 