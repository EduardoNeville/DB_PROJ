-- Find the cities where all businesses work less than 5 days 
-- a week. List only the names of the cities (city_name) and 
-- sort the results in alphabetical order.

WITH BM5 AS (SELECT distinct Business_id
    FROM BUSINESS_HOURS
    GROUP BY Business_id
    HAVING COUNT(DISTINCT DAY_ID) >= 5
    ),--Businesses working more than or exaclty 5 days a week
CT5 AS (SELECT distinct BL.city_name
    FROM BUSINESS_LOCATION BL
    RIGHT JOIN BM5
on bl.business_id = BM5.business_id) -- cities with businesses working more than or exaclty 5 days a week 
SELECT cti.city_name 
FROM CITIES cti
LEFT JOIN CT5
on cti.city_name = ct5.city_name
WHERE ct5.city_name IS NULL;