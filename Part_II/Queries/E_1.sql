--1. Find the businesses (name, review_count) in the city of 
--'las vegas' that have 'valet' parking, 5 stars and are
--open on Friday. Order by the business name in alphabetical 
--order.

SELECT B.business_name as name, B.review_count as review_count
FROM BUSINESS B
JOIN BUSINESS_LOCATION L ON B.business_id = L.business_id
JOIN BUSINESS_HOURS BH ON B.business_id = BH.business_id
JOIN DAY_OF_WEEK WD ON BH.day_id = WD.day_id
JOIN BUSINESS_PARKING_TYPE BP ON BP.business_id = P.business_id
WHERE 
    CONTAINS(L.city_name = 'las vegas')        AND 
    WD.day_name = 'Friday'      AND 
    P.parking_type_description = 'valet'    AND 
    B.stars = 5
ORDER BY B.business_name ASC;


