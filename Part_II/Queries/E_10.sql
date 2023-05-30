-- How many businesses labeled as "Dry Cleaners" are open on the weekend? Return one column "count"

SELECT COUNT(DISTINCT B.BUSINESS_ID) AS "count"
FROM BUSINESS B
JOIN BUSINESS_HAS_CATEGORIES BHC ON B.BUSINESS_ID = BHC.BUSINESS_ID
JOIN BUSINESS_CATEGORIES BC ON BHC.CATEGORY_ID = BC.CATEGORY_ID
JOIN BUSINESS_HOURS BH ON B.BUSINESS_ID = BH.BUSINESS_ID
WHERE BC.CATEGORY_NAME = 'Laundry Services' -- 'Dry Cleaners' ??
AND BH.DAY_ID IN (5, 6);

-- do a join on day_id if we want to go in details