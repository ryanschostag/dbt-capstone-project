/*
Requirements:

Use a CTE to reference the runways source
Select and rename the following columns:
Source Column Name	Target Column Name
id	runway_id
airport_ident	airport_ident (no rename)
length_ft	runway_length_ft
width_ft	runway_width_ft
surface	runway_surface
lighted	runway_lighted
closed	runway_closed
*/

{{
    config(
        materialized='ephemeral',
        unique_key='runway_id'
    )
}}

with runways as (
    select
        id as runway_id,
        airport_ident,
        length_ft as runway_length_ft,
        width_ft as runway_width_ft,
        surface as runway_surface,
        lighted as runway_lighted,
        closed as runway_closed
    from {{ source('airstats', 'raw_runways') }}
)
select * from runways
