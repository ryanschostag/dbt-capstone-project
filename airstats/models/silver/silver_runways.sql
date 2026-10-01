/*
Create a silver_runways model:

Source model: src_runways
If the surface is null or empty, change it to __UNKNOWN__; keep this column's name as runway_surface
The columns of this model must be exactly the same (and in the same order) as those of src_runways
*/

with silver_runways as (
    select
        runway_id,
        airport_ident,
        runway_length_ft,
        runway_width_ft,
        case
            when runway_surface is null or runway_surface = '' then '__UNKNOWN__'
            else runway_surface
        end as runway_surface,
        runway_lighted,
        runway_closed
    from {{ ref('src_runways') }}
)
select * from silver_runways
