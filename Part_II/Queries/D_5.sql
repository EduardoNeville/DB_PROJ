-- 5. Find the average rating and the total number of reviews for all businesses which have a minimum of two
-- categories and more than one parking type. Return two columns (stars, review_count). 

SELECT AVG(B.STARS) AS stars, SUM(B.REVIEW_COUNT) AS review_count
FROM BUSINESS B
WHERE B.BUSINESS_ID IN (
    SELECT BHC.BUSINESS_ID
    FROM BUSINESS_HAS_CATEGORIES BHC
    GROUP BY BHC.BUSINESS_ID
    HAVING COUNT(*) >= 2
)
AND B.BUSINESS_ID IN (
    SELECT BPT.BUSINESS_ID
    FROM BUSINESS_PARKING_TYPE BPT
    GROUP BY BPT.BUSINESS_ID
    HAVING COUNT(*) > 1
);
