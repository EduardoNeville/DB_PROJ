-- 2. Find the top-10 (according to the number of stars) businesses in the state of California. For every business list
-- the business name and the number of stars (business_name, stars). Sort the result in descending order according
-- to the number of stars, and break tie by the business names in alphabetical order.
-- Note that states are stored by their abbreviation.

SELECT B.BUSINESS_NAME as business_name, B.STARS as stars
FROM BUSINESS B
JOIN BUSINESS_LOCATION BL ON B.BUSINESS_ID = BL.BUSINESS_ID
WHERE BL.STATE_NAME = 'CA'
ORDER BY B.STARS DESC, B.BUSINESS_NAME ASC
FETCH FIRST 10 ROWS ONLY;
