-- Find the ids (business_id) of the businesses that have been
-- reviewed by more than 1030 unique users. List
-- only the ids and sort by ascending order

SELECT B.business_id
FROM BUSINESS B
JOIN (
    SELECT business_id
    FROM REVIEWS
    GROUP BY business_id
    HAVING COUNT(DISTINCT user_id) > 1030
) R ON B.business_id = R.business_id
ORDER BY B.business_id ASC;


