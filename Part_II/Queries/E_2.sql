-- 2. Find the top-10 (according to the number of stars) businesses in the state of California. For every business list
-- the business name and the number of stars (business_name, stars). Sort the result in descending order according
-- to the number of stars, and break tie by the business names in alphabetical order.
-- Note that states are stored by their abbreviation.

SELECT B.BUSINESS_NAME, B.STARS
FROM (
    SELECT BUSINESS_ID, BUSINESS_NAME, STARS
    FROM BUSINESS
    WHERE BUSINESS_ID IN (
        SELECT BUSINESS_ID
        FROM BUSINESS_LOCATION
        WHERE STATE_NAME = 'CA'
    )
) B
ORDER BY B.STARS DESC, B.BUSINESS_NAME ASC
FETCH FIRST 10 ROWS ONLY;
