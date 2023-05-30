--Find the minimum, maximum, mean, and median number of categories per business.
--Return 4 columns (min_categories, max_categories, mean_categories, median_categories).

SELECT min(ct) as min_categories, max(ct) as max_categories, 
AVG(ct) as mean_categories, MEDIAN(ct) as median_categories
FROM 
    (SELECT COALESCE(BCs_ct.ct, 0) as ct
    FROM (BUSINESS
    LEFT JOIN
        (SELECT BUSINESS_ID, COUNT(*) as ct
        FROM business_has_categories
        GROUP BY business_id) BCs_ct
        on business.business_id = BCs_ct.business_id)
        ) ;