
with invalid_airport_comments_test as (
    select
        sac_silver.comment_id,
        sac_silver.member_nickname as silver_member_nickname,
        sac_silver.comment_subject as silver_comment_subject,
        sac_silver.comment_body as silver_comment_body
    from {{ ref('silver_airport_comments') }} sac_silver
    where (
        sac_silver.member_nickname is null or sac_silver.member_nickname = ''
        or sac_silver.comment_subject is null or sac_silver.comment_subject = ''
        or sac_silver.comment_body is null or sac_silver.comment_body = ''
    )
)
select * from invalid_airport_comments_test
