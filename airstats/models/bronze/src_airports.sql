/*
Requirements:

Use a CTE to reference the airports source
Select and rename the following columns:
Source Column Name	Target Column Name
ident	airport_ident
type	airport_type
name	airport_name
latitude_deg	airport_lat
longitude_deg	airport_long
continent	continent (no rename)
iso_country	iso_country (no rename)
iso_region	iso_region (no rename)
*/

with airports as (
    select 
        ident as airport_ident,
        type as airport_type,
        name as airport_name,
        latitude_deg as airport_lat,
        longitude_deg as airport_long,
        continent,
        iso_country,
        iso_region
    from {{ source('airstats', 'raw_airports') }}
)
select * from airports
