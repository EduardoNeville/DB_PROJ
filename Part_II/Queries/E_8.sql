SELECT min(cts) as min_categories, max(cts) as max_categories, AVG(cts) as mean_categories, MEDIAN(cts) as median_categories
FROM
    (SELECT BUSINESS_ID, COUNT(*) as cts
    FROM business_has_categories
    GROUP BY business_id
    ORDER BY cts) ;


