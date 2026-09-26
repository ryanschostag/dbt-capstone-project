/*
Create a silver_airport_comments model:

Source model: src_airport_comments
Filter out records with null / empty values for the comment body
If the member's nickname is null, change it to __UNKNOWN__
Make this an incremental model that uses comment_id to identify new records (hint: compare against the maximum existing comment_id in the target table)
Add a new column: loaded_at, which should be the current_timestamp() by default
The columns of this model must be exactly the same (and in the same order) as those of src_airport_comments, plus the extra loaded_at as the last column
*/

{{
    config(
        materialized='incremental',
        unique_key='comment_id'
    )
}}

with silver_airport_comments as (
    select
        comment_id,
        airport_ident,
        comment_timestamp,
        case
            when member_nickname is null then '__UNKNOWN__'
            else member_nickname
        end as member_nickname,
        comment_subject,
        comment_body,
        get_current_timestamp() as loaded_at
    from {{ ref('src_airport_comments') }}
    where comment_body is not null and comment_body != ''
)
select * from silver_airport_comments
