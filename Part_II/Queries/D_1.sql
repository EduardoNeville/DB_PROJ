-- Find the cities where all businesses work less than 5 days 
-- a week. List only the names of the cities (city_name) and 
-- sort the results in alphabetical order.

SELECT DISTINCT L.city FROM BUSINESS_LOCATION L
JOIN BUSINESS B ON L.location_id = B.location_id
JOIN BUSINESS_HOURS H ON B.business_id = H.business_id
WHERE H.day IN (
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday') 
GROUP BY L.city
HAVING COUNT(DISTINCT H.day) < 5
ORDER BY L.city ASC;