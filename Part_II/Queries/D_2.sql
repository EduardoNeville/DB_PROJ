-- Find the top-10 states with the highest number of registered businesses. 
-- List only the state and the number of businesses (state_name, num_businesses) 
-- and sort the results in descending order according to the number of businesses.

SELECT STATE_NAME as state_name, n_b as num_businesses
FROM (
  SELECT STATE_NAME, COUNT(*) AS n_b,
         RANK() OVER (ORDER BY COUNT(*) DESC) AS rank_num
  FROM BUSINESS_LOCATION
  GROUP BY STATE_NAME
) 
WHERE rank_num <= 10;


