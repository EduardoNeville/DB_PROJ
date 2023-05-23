-- Find all users that started using Yelp at 2006 or before and
-- their usernames consist of only one character. List their 
-- user ids, usernames and the date they started using 
-- Yelp (user_id, user_name, yelping_since). Sort the result 
-- in alphabetical order of usernames. Limit the number of 
-- returned rows to 50.

SELECT U.user_id, U.name, U.yelping_since
FROM Users U
WHERE 
    U.yelping_since <= '2006-01-01' AND 
    LENGTH(U.name) = 1
ORDER BY U.name
LIMIT 50;


