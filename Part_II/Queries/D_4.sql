-- Find all cities that satisfy the following: each business in the city has 
-- at least two reviews. List only the names of the cities (city_name) in alphabetical order. 
-- Limit the number of returned rows to 50..
SELECT BUSINESS_LOCATION.city_name
FROM BUSINESS_LOCATION
JOIN
(SELECT BUSINESS_ID, count(*) as review_count
FROM REVIEWS
GROUP BY business_id) rvcts
ON rvcts.business_id = BUSINESS_LOCATION.business_id
GROUP BY BUSINESS_LOCATION.city_name
HAVING MIN(rvcts.review_count) >= 2
ORDER BY BUSINESS_LOCATION.city_name ASC
FETCH FIRST 50 ROWS ONLY;

