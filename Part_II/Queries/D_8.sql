-- Find the names of the cities that satisfy the following: 
-- the combined number of reviews for the top-100 (wrt to 
-- reviews) businesses in the city is at least double the
-- combined number of reviews for the rest of the businesses
-- in the city. Return one column 'city'.

WITH top_100 AS (
    SELECT B.business_id FROM BUSINESS B
    JOIN REVIEWS R ON B.business_id = R.business_id
    GROUP BY B.business_id
    -- Filtering to only top 100 businesses
    -- in terms of review count
    ORDER BY COUNT(R.review_id) DESC
    FETCH FIRST 100 ROWS ONLY
)
SELECT L.city_name
FROM BUSINESS_LOCATION L
JOIN top_100 B ON L.business_id = B.business_id
GROUP BY L.city_name 

-- At this point we have a filterd table that has city_name column and nothing more

-- Now we find the total number of reviews for the rest of the businesses in the city

SELECT L.city_name, SUM(B.review_count) AS review_count
FROM BUSINESS_LOCATION L
JOIN (
    SELECT B2.business_id, COUNT(R.review_id) AS review_count FROM BUSINESS B2
    JOIN REVIEWS R ON B2.business_id = R.business_id
    GROUP BY B2.business_id
    -- Filtering to only top 100 businesses
    -- in terms of review count
    ORDER BY COUNT(R.review_id) DESC
    FETCH FIRST 100 ROWS ONLY
) B2 ON L.business_id = B2.business_id AS rest

-- Now we compare the two and filter out the cities that satisfy the condition

WHERE top_100 >= 2 * COUNT(rest)



