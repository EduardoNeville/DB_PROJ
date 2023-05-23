-- Find the names of the cities that satisfy the following: 
-- the combined number of reviews for the top-100 (wrt to 
-- reviews) businesses in the city is at least double the
-- combined number of reviews for the rest of the businesses
-- in the city. Return one column 'city'.

SELECT L.city FROM LOCATION L
JOIN BUSINESS B ON L.business_id = B.business_id
JOIN REVIEW R ON B.business_id = R.business_id
WHERE
    B.BUSINESS IN (
        SELECT B.BUSINESS FROM BUSINESS B
        JOIN REVIEW R ON B.business_id = R.business_id
        GROUP BY B.BUSINESS
        -- Filtering to only top 100 businesses
        ORDER BY COUNT(R.review_id) DESC
        LIMIT 100
    )
    GROUP BY L.city
    HAVING COUNT(R.review_id) >= 2 * (
        SELECT COUNT(R.review_id) FROM REVIEW R
        JOIN BUSINESS B ON R.business_id = B.business_id
        JOIN LOCATION L ON B.business_id = L.business_id
        WHERE L.city = L.city
        GROUP BY L.city
        ORDER BY COUNT(R.review_id) DESC
        LIMIT 100
    )
    ORDER BY L.city ASC ;

