-- Find all cities that satisfy the following: each business in the city has 
-- at least two reviews. List only the names of the cities (city_name) in alphabetical order. 
-- Limit the number of returned rows to 50..

SELECT distinct CT.city_name as city_name
FROM CITIES CT
WHERE CT.city_name NOT IN ( 
    SELECT distinct BL.city_name
    FROM BUSINESS_LOCATION BL
    WHERE EXISTS (SELECT Business_id 
    FROM Business Bs
    WHERE bs.business_id = bl.business_id and bs.review_count < 2  
    ) --cities with businesses having less then two reviews
) ORDER BY city_name 
FETCH FIRST 50 ROWS ONLY;
