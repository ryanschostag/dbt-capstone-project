/*
Create a silver_airports model: Just a copy (SELECT *) from src_airports, no transformations needed.
*/
with silver_airports as (
    select * from {{ ref('src_airports') }}
)
select * from silver_airports
