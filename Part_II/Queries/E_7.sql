
--1. Find the businesses (name, review_count) in the city of 
--'las vegas' that have 'valet' parking, 5 stars and are
--open on Friday. Order by the business name in alphabetical 
--order.

SELECT B.business_name, B.review_count
FROM BUSINESS B
JOIN LOCATION L ON B.business_id = BL.business_id
JOIN HOURS H ON B.business_id = BH.business_id
JOIN WEEK_DAYS WD ON BH.day_id = WD.day_id
JOIN PARKING P ON B.business_id = P.business_id
WHERE 
    L.city = 'las vegas'        AND 
    WD.day_name = 'Friday'      AND 
    P.parking_type = 'valet'    AND 
    B.stars = 5
ORDER BY B.business_name ASC;



