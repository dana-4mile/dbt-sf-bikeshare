SELECT 

station_id
,'sf' as city
,'sf_'||station_id as city_station_id
,name
,short_name
,lat as station_latitude
,lon as station_longitude
,station_geom
,region_id
,rental_methods
,capacity
,external_id
,eightd_has_key_dispenser
,has_kiosk

FROM {{ source('bikeshare', 'sf_bikeshare_station_info') }}