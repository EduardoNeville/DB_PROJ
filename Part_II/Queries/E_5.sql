-- Find all users that started using Yelp at 2006 or before and
-- their usernames consist of only one character. 
-- List their user ids, usernames and the date they started using 
-- Yelp (user_id, user_name, yelping_since). 
-- Sort the result in alphabetical order of usernames. 
-- Limit the number of returned rows to 50.

SELECT U.user_id, U.user_name, U.yelping_since
FROM User_Yelp U
WHERE 
    U.yelping_since <= DATE '2006-12-31' AND
    SUBSTR(U.user_name, 1, 1) IS NOT NULL AND
    SUBSTR(U.user_name, 2) IS NULL 
ORDER BY U.user_name ASC
FETCH FIRST 50 ROWS ONLY;


