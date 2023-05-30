-- What is the maximum number of categories assigned to a business? Return one column "count"

SELECT MAX(category_count) AS "count"
FROM (
    SELECT BUSINESS_ID, COUNT(*) AS category_count
    FROM BUSINESS_HAS_CATEGORIES
    GROUP BY BUSINESS_ID
);
