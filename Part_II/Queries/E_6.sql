-- Find the maximum number of different businesses that 
-- have been reviewed by a single user. Return one column "count".

SELECT COUNT(*) FROM
(SELECT BUSINESS_ID, COUNT(*) as ct
FROM (
  SELECT DISTINCT BUSINESS_ID, USER_ID FROM REVIEWS
) 
GROUP BY BUSINESS_ID)
WHERE ct = 1 ;



