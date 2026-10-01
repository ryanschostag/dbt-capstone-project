with closed_heliports as (
    select *
    from {{ ref('scd_silver_airports') }} ssa 
    where ssa.airport_ident = 'US-3302'
    and dbt_valid_to is null
)
select *
from closed_heliports;
