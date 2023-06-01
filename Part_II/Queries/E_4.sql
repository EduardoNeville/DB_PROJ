-- Find all businesses that have more than 3000 reviews and more 
-- than 2 dietary restriction categories. For every business 
-- list the business id, the business name and the review count
-- (business_id, business_name,review_count). 
-- Order the results in descending order according to the number of reviews

SELECT B.business_id, B.business_name, B.review_count
FROM BUSINESS B
JOIN (
    SELECT business_id
    FROM business_dietary_restrictions
    GROUP BY business_id
    HAVING COUNT(dietary_rest_id) > 2
) D ON B.business_id = D.business_id
WHERE B.review_count > 3000
ORDER BY B.review_count DESC;




