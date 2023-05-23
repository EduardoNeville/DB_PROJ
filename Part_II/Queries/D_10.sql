-- Find the city whose businesses have the 
-- lowest combined number of reviews; 
-- only reviews from users with less than 3 friends 
-- should be taken into account. 
-- If there is a tie, choose the first city by 
-- alphabetical order.
-- Return 2 columns, 
-- the number of reviews (as review_count) and 
-- the city name (as city_name).

SELECT SUM(B.review_count) AS review_count
FROM BUSINESS B 
JOIN REVIEW R ON B.business_id = R.business_id
WHERE 
    R.user_id IN (
        SELECT user_id FROM USER WHERE friend_count < 3)
GROUP BY B.city
ORDER BY review_count ASC
LIMIT 1;

