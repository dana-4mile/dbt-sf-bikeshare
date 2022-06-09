SELECT 

station_id
,city
,city_station_id
,name
,short_name
,station_latitude
,station_longitude
,station_geom
,region_id
,rental_methods
,capacity
,external_id
,eightd_has_key_dispenser
,has_kiosk

from {{ref('ny_stations')}}

UNION ALL

SELECT 

station_id
,city
,city_station_id
,name
,short_name
,station_latitude
,station_longitude
,station_geom
,region_id
,rental_methods
,capacity
,external_id
,eightd_has_key_dispenser
,has_kiosk

from {{ref('sf_stations')}}
