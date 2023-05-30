-- Find the maximum number of different businesses that 
-- have been reviewed by a single user. Return one column "count".

SELECT max(rv_ct_usr) as count
From (
    SELECT user_id, count( distinct BUsiness_id) as rv_ct_usr
    From REVIEWS
    GROUP BY user_id
)