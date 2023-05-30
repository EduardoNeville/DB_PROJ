--For each state, find the number of distinct businesses having the tag "vegetarian".
--List the state name and the number of businesses (state_name, business_count). 
--Order by the number of businesses in descending order.

SELECT STATES.state_name as state_name, COALESCE(cts.ct, 0) as business_count
FROM STATES
LEFT JOIN 
    (SELECT BUSINESS_LOCATION.STATE_NAME, COUNT(*) as ct
    FROM BUSINESS_LOCATION
    JOIN (SELECT DISTINCT BUSINESS_ID 
        FROM business_dietary_restrictions
        WHERE business_dietary_restrictions.DIETARY_REST_ID =(
            SELECT DIETARY_REST_ID
            FROM dietary_restrictions 
            WHERE dietary_restrictions.dietary_rest_description = 'vegetarian'
            )
        ) VBs 
    on BUSINESS_LOCATION.BUSINESS_ID = VBs.BUSINESS_ID
    GROUP BY BUSINESS_LOCATION.STATE_NAME) cts
on STATES.state_name = cts.STATE_NAME
ORDER BY business_count DESC ;
