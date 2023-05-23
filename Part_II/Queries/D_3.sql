-- 3. List the name, number of stars, and review count (business_name, stars, review_count) of the businesses that
-- are in the category 'Irish Pub' and offer 'live' music. Sort in alphabetical order of the business names

SELECT B.BUSINESS_NAME, B.STARS, B.REVIEW_COUNT
FROM BUSINESS B
JOIN BUSINESS_HAS_CATEGORIES BHC ON B.BUSINESS_ID = BHC.BUSINESS_ID
JOIN BUSINESS_CATEGORIES BC ON BHC.CATEGORY_ID = BC.CATEGORY_ID
JOIN BUSINESS_MUSIC BM ON B.BUSINESS_ID = BM.BUSINESS_ID
JOIN MUSIC M ON BM.MUSIC_ID = M.MUSIC_ID
WHERE BC.CATEGORY_NAME = 'Irish Pub'
AND M.MUSIC_DESCRIPTION = 'live'
ORDER BY B.BUSINESS_NAME;
