SELECT 

station_id
,'ny' as city
,'ny_'||station_id as city_station_id
,name
,short_name
,latitude as station_latitude
,longitude as station_longitude
,st_geogpoint(longitude, latitude) station_geom
,region_id
,rental_methods
,capacity
,cast(null as string) external_id
,eightd_has_key_dispenser
,cast(null as boolean) has_kiosk

FROM {{ source('bikeshare', 'ny_bikeshare_stations') }}