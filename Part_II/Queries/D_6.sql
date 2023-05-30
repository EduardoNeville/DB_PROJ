--Find the number of businesses 
--for which every user that gave the business a positive tip (containing 'awesome') 
--has also given some business a positive tip within the previous day. 
--Return one column "count".


WITH positive_tips AS (
    SELECT USER_ID, BUSINESS_ID, TIP_DATE
    FROM TIPS
    WHERE TIP_TEXT LIKE '%awesome'),
user_yesterday AS (
    SELECT DISTINCT pt1.USER_ID
    FROM positive_tips pt1
    JOIN positive_tips pt2 ON pt1.USER_ID = pt2.USER_ID AND TO_DATE(pt1.TIP_DATE, 'DD-MON-RR') - 1 = TO_DATE(pt2.TIP_DATE, 'DD-MON-RR')
)
SELECT count(Business_ID) as count 
FROM BUSINESS bs
WHERE NOT EXISTS (
    SELECT pt.USER_ID
    FROM positive_tips pt
    WHERE bs.BUSINESS_ID = pt.business_id
    AND pt.USER_ID NOT IN (SELECT USER_ID FROM user_yesterday)
);


