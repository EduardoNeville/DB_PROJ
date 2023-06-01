-- Find the city whose businesses have the 
-- lowest combined number of reviews; 
-- only reviews from users with less than 3 friends 
-- should be taken into account. 
-- If there is a tie, choose the first city by 
-- alphabetical order.
-- Return 2 columns, 
-- the number of reviews (as review_count) and 
-- the city name (as city_name).

WITH city_reviews AS (
    SELECT bl.city_name AS city, COUNT(r.review_id) AS reviews
    FROM Reviews r
    INNER JOIN User_Yelp u ON r.user_id = u.user_id
    INNER JOIN (
        SELECT user_id
        FROM Friends
        GROUP BY user_id
        HAVING COUNT(friends_id) < 3
    ) f ON u.user_id = f.user_id
    INNER JOIN Business_location bl ON r.business_id = bl.business_id
    GROUP BY bl.city_name
),
min_reviews AS (
    SELECT MIN(reviews) AS min_reviews
    FROM city_reviews
)
SELECT reviews AS review_count, city AS city_name
FROM city_reviews
WHERE reviews = (SELECT min_reviews FROM min_reviews)
ORDER BY city
FETCH FIRST ROW ONLY;

