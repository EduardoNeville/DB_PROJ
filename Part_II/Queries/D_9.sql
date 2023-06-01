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

SELECT
    B.business_id,
    RANK() OVER (
        PARTITION BY B.business_id 
        ORDER BY COUNT(R.review_id) DESC
        ) AS reviewer_rank,
    COUNT(R.review_id) AS review_count
FROM BUSINESS B
JOIN REVIEWS R ON B.business_id = R.business_id
GROUP BY B.business_id, R.user_id
ORDER BY B.business_id ASC, reviewer_rank ASC
FETCH FIRST 30 ROWS ONLY;

