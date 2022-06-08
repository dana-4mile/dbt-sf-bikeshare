select

hash_trip_id
,original_trip_id
,city
,duration_sec
,start_timestamp
,start_station_name
,start_station_id
,end_timestamp
,end_station_name
,end_station_id
,bike_id
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
,min_trip_distance_meters
,is_returned_to_same_station

from {{ref('sf_trips_stg')}}

UNION ALL

select

hash_trip_id
,original_trip_id
,city
,duration_sec
,start_timestamp
,start_station_name
,start_station_id
,end_timestamp
,end_station_name
,end_station_id
,bike_id
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
,min_trip_distance_meters
,is_returned_to_same_station

from {{ref('ny_trips_stg')}}


