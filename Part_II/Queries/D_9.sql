-- For each of the top-10 (in terms of number of reviews) 
-- businesses, find the top-3 reviewers: among those who 
-- reviewed the business, the ones that have the three 
-- highest numbers of total reviews across all businesses.
-- Return 3 columns: 
-- the business id (as business_id), 
-- rank (1-3) of the top reviewer (as reviewer_rank) and 
-- the number of reviews made (as review_count). 
-- Order the results by business id in alphabetical order, 
-- and then rank (1 - 3)

WITH top_10_businesses AS (
    SELECT business_id, ROW_NUMBER() OVER (ORDER BY review_count DESC) AS r
    FROM Business
    WHERE ROWNUM <= 10
),
reviewer_rankings AS (
    SELECT r.business_id, u.user_id, u.review_count, ROW_NUMBER() OVER (PARTITION BY r.business_id ORDER BY u.review_count DESC) AS rank
    FROM Reviews r
    INNER JOIN User_Yelp u ON r.user_id = u.user_id
    INNER JOIN top_10_businesses t ON r.business_id = t.business_id
)
SELECT business_id, rank AS reviewer_rank, review_count
FROM reviewer_rankings
WHERE rank <= 3
ORDER BY business_id, reviewer_rank;




