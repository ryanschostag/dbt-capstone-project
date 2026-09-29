
with unknown_surface_runways_test as (
	select r.id, 
		r.surface as raw_surface,
		sr.runway_surface as silver_surface
	from {{ source('airstats', 'raw_runways') }} r 
	join {{ ref('silver_runways') }} sr
	on r.id = sr.runway_id
	where ( r.surface is null or r.surface = '' )
	and ( 
		sr.runway_surface is null 
		or sr.runway_surface = ''
	)
)
select * from unknown_surface_runways_test
