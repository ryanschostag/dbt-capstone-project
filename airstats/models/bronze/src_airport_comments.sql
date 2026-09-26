/*
Requirements:

Use a CTE to reference the airport_comments source
Select and rename the following columns:
Source Column Name	Target Column Name
id	comment_id
airport_ident	airport_ident (no rename)
date	comment_timestamp (it's actually a timestamp column, not a date column)
member_nickname	member_nickname (no rename)
subject	comment_subject
body	comment_body
*/

with airport_comments as (
    select
        id as comment_id,
        airportIdent as airport_ident,
        date as comment_timestamp,
        memberNickname as member_nickname,
        subject as comment_subject,
        body as comment_body
    from {{ source('airstats', 'raw_airport_comments') }}
)
select * from airport_comments
