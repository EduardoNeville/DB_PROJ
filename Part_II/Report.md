# Part 2
Deliverable 2 <br>
Assumptions <br>
<In this section write down the assumptions you made about the data, if any. Write a sentence for each assumption you made>
The DATA is somehow clean (no duplicate…)

### DDL Section

#### QUERY E_1:

Description of logic: 
    Return columns: Business_name, Business_review_count 

SQL statement:
    
We joined the BUSINESS table with the BUSINESS_NAME and the BUSINESS_HOURS tables using the business_id.
Then joining it with the DAY_OF_WEEK table using the day_id of the BUSINESS_HOURS.
We then joined this table with the BUSINESS_PARKING_TYPE
We then filterd the table by:
Location name containing las vegas,
Working on a Friday,
Has a valet, and
Has 5 stars

#### QUERY E_2:

Description of logic: 

    Return columns:  Business_name, Business_stars

From the Business table we map the BUSINESS_ID to match the BUSINESS_ID from BUSINESS_LOCATION and filter by STATE_NAME
We then order by Stars in descending order, in case of tie we decide with the BUSINESS_NAME in alphabetical order.

SQL statement:

~~~~ sql
SELECT B.BUSINESS_NAME, B.STARS
FROM (
    SELECT BUSINESS_ID, BUSINESS_NAME, STARS
    FROM BUSINESS
    WHERE BUSINESS_ID IN (
        SELECT BUSINESS_ID
        FROM BUSINESS_LOCATION
        WHERE STATE_NAME = 'CA'
    )
) B
ORDER BY B.STARS DESC, B.BUSINESS_NAME ASC
FETCH FIRST 10 ROWS ONLY;
~~~~

Result:

![Result E2](Query_results/Result_E2.png)

#### QUERY E_3:

Description of logic: 

    Result columns: Business_id

SQL statement:

We join the business table with a filtered table of reviews using the BUSINESS_ID. 
The filtered table groups businesses filtering themto have higher than 1030 distinct reviews.
We then order the this table in ascending order 


``` sql
SELECT B.business_id
FROM BUSINESS B
JOIN (
    SELECT business_id
    FROM REVIEWS
    GROUP BY business_id
    HAVING COUNT(DISTINCT user_id) > 1030
) R ON B.business_id = R.business_id
ORDER BY B.business_id ASC;
```

Result:

![Result E3](Query_results/Result_E3.png)

#### QUERY E_4:

Description of logic: 
    Result: Business_id, Business_name, Review_count

Joins two tables using business_id.
The first being the business table 
The second being a filtered version of the dietary restions table 
Counting how many dietary restrictions does each business have. If they have more than 2 they are added to the table.
We then filter to only have businesses with more that 3000 reviews.
And order them descending according to review count

SQL statement:
``` sql
SELECT B.business_id, B.business_name, B.review_count FROM BUSINESS B
JOIN business_dietary_restrictions D ON B.business_id = D.business_id
WHERE 
    B.review_count > 3000
GROUP BY B.business_id, B.business_name, B.review_count
HAVING COUNT(D.dietary_rest_id) > 2
ORDER BY B.review_count DESC;
```

Result: 

![Result E4](Query_results/Result_E4.png)

#### QUERY E_5:

Description of logic: 

    Returns: User_ID, User_name, Yelping_since

We are searching for users with single character usernames that joined Yelp before 2007. To do so we use a fileter on the date of the users signup date and search for a Username with a substring of one character that doesn't have another substring with one character. We then order them alphabetically and return the first 50 users.

SQL statement:

``` sql
SELECT U.user_id, U.user_name, U.yelping_since
FROM User_Yelp U
WHERE 
    U.yelping_since <= DATE '2006-12-31' AND
    SUBSTR(U.user_name, 1, 1) IS NOT NULL AND
    SUBSTR(U.user_name, 2) IS NULL 
ORDER BY U.user_name ASC
FETCH FIRST 50 ROWS ONLY;
```

Result: 

![Result E5_1](Query_results/Result_E5_1.png)
![Result E5_2](Query_results/Result_E5_2.png)

#### QUERY E_6:

Description of logic: 

    Result column: Count

We first need to count, for each user, the number of businesses they reviewed. Then we simply compute the max of these counts. 
More precisely, we have an sub query on the table REVIEWS that counts for each user, the number of distinct businesses they reviewed. Then we simply select the maximum of these counts. 

SQL statement:
``` sql
SELECT max(rv_ct_usr) as count
From (
    SELECT user_id, count( distinct BUsiness_id) as rv_ct_usr
    From REVIEWS
    GROUP BY user_id
);
```

Result:

![Result E6](Query_results/Result_E6.png)

#### QUERY E_7:

Description of logic: 
We first find the DIETARY_REST_ID corresponding to. ‘vegetarian’, then we find all the businesses with this DIETARY_REST_ID, we count, by states, these businesses and adding the states which do not have such restaurant (setting the count to 0).
In details : 
A sub query simply select from BUSINESS_DIETARY_RESTRICTION the DIETARY_REST_ID of the tuple having DIETARY_REST_DESCRIPTION ‘vegetarian’
Another subquery on BUSINESS selects only the BUSINESS_ID of tuples having the found DIETARY_REST_ID
Then we perform a join of these BUSINESS_ID with BUSINESS_LOCATION (ON BUSINESS_ID) so that we have the location of all BUSINESS VEGETARIAN
Then we count the distinct BUSINESS_ID by state
We finally join with all states in STATES (on STATE_NAME) so that states that do not have BUSINESS with ‘vegetarian’ tag still appear with count 0


SQL statement:
``` sql
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
```
Result:

![Result E7](Query_results/Result_E7.png)

#### QUERY E_8:

Description of logic: 
We first count by BUSINESS_ID in BUSINESS_HAS_CATEGORIES. Then we join with all BUSINESS (on BUSINESS_ID) so that businesses with no category still appear and with count 0. Then we simply apply the min, max, avg, and median functions. 

SQL statement:
```sql
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
```

Result:

![Result E8](Query_results/Result_E8.png)

#### QUERY E_9:

Description of logic: 
    Result colum: Count

We count how many categories each business has and we output the highest value

SQL statement:
```sql
SELECT MAX(category_count) AS "count"
FROM (
    SELECT BUSINESS_ID, COUNT(*) AS category_count
    FROM BUSINESS_HAS_CATEGORIES
    GROUP BY BUSINESS_ID
);
```

Result: 
![Result E9](Query_results/Result_E9.png)


#### QUERY E_10:


Description of logic: 

SQL statement:


General Comments
<In this section write general comments about your deliverable (comments and work allocation between team members>

#### QUERY D_1:

Description of logic: 
Fisrt we find the business that work more or exactly 5 days a week. Then we find the cities which contain at least one business that work more or exactly 5 days a week. In the end we select all the cities but the one which appeared in the previous table.
In detail : 
- We create a table BM5 wich is the selection of buisness_id in buisness_hours which have count of distince day_id superirior or equal to five i.e businezses working more or exactly five days
- Then we  create a table ct5 which is a right join BUSINESS_LOCATION-BM5 on buisness_id, this allows us to link the businesses working more than or exaclty 5 days a week with their city. Using a right join allows to only select the city_name having a business in BM5. We then select the distinct_name of this join. 
- In the end we perform a left join CITIES-ct5 on city_name to link eith all the city names, filtering out the ones that are in ct5 by selecting only the rows with NULL in the join. 


SQL statement:
```sql
WITH BM5 AS (SELECT distinct Business_id
    FROM BUSINESS_HOURS
    GROUP BY Business_id
    HAVING COUNT(DISTINCT DAY_ID) >= 5
    ),--Businesses working more than or exaclty 5 days a week
CT5 AS (SELECT distinct BL.city_name
    FROM BUSINESS_LOCATION BL
    RIGHT JOIN BM5
on bl.business_id = BM5.business_id) -- cities with businesses working more than or exaclty 5 days a week 
SELECT cti.city_name 
FROM CITIES cti
LEFT JOIN CT5
on cti.city_name = ct5.city_name
WHERE ct5.city_name IS NULL;
```

Results :

![Result D1](Query_results/Result_D1.png)


#### QUERY D_2:

Description of logic: 
We count each occurence of each state_name in the business_location table, then use the RANK() and ORDER function to retrieve the 10 most occuring state_name.

SQL statement:
```sql
SELECT STATE_NAME as state_name, n_b as num_businesses
FROM (
  SELECT STATE_NAME, COUNT(*) AS n_b,
         RANK() OVER (ORDER BY COUNT(*) DESC) AS rank_num
  FROM BUSINESS_LOCATION
  GROUP BY STATE_NAME
) 
WHERE rank_num <= 10;
```

Results :

![Result D2](Query_results/Result_D2.png)


#### QUERY D_3:

Description of logic: 
    Result: Business_name, stars, review_count
SQL statement:
 It selects the business name, star rating, and review count from the "BUSINESS" table. It joins this table with the "BUSINESS_HAS_CATEGORIES" table, "BUSINESS_CATEGORIES" table, "BUSINESS_MUSIC" table, and "MUSIC" table to incorporate additional details about categories and music. The query filters the results to include businesses categorized as "Irish Pub" and offering "live" music. The final result is sorted in ascending order based on the business name.

```sql
SELECT B.BUSINESS_NAME, B.STARS, B.REVIEW_COUNT -- , BC.CATEGORY_NAME, M.MUSIC_DESCRIPTION
FROM BUSINESS B
JOIN BUSINESS_HAS_CATEGORIES BHC ON B.BUSINESS_ID = BHC.BUSINESS_ID
JOIN BUSINESS_CATEGORIES BC ON BHC.CATEGORY_ID = BC.CATEGORY_ID
JOIN BUSINESS_MUSIC BM ON B.BUSINESS_ID = BM.BUSINESS_ID
JOIN MUSIC M ON BM.MUSIC_ID = M.MUSIC_ID
WHERE BC.CATEGORY_NAME = 'Irish Pub'
AND M.MUSIC_DESCRIPTION = 'live'
ORDER BY B.BUSINESS_NAME ASC;
```

Result:

![Result D3](Query_results/Result_D3.png)

#### QUERY D_4:

Description of logic: 
We first find businesses with less than 2 reviews. Then we select cities which have at least one of these businesses. In the end we link all the cities so that cities with no business do apear adn filter out cities that were slected in the previous sentence.
In details:
- A subquery select the Business_id when review_count < 2 in BUSINESS_LOCATION
- A subquery select tuples in Buisness_location if the buisness_id is in the previous query result
- A final query select all city_name that are not in the previous subquery.

SQL statement:
```sql
SELECT distinct CT.city_name as city_name
FROM CITIES CT
WHERE CT.city_name NOT IN ( 
    SELECT distinct BL.city_name
    FROM BUSINESS_LOCATION BL
    WHERE EXISTS (SELECT Business_id 
    FROM Business Bs
    WHERE bs.business_id = bl.business_id and bs.review_count < 2  
    ) --cities with businesses having less then two reviews
) ORDER BY city_name 
FETCH FIRST 50 ROWS ONLY;
```

Result:

![Result D4](Query_results/Result_D4.png)

#### QUERY D_5:

Description of logic: 
It selects the average of the "STARS" column and the sum of the "REVIEW_COUNT" column from the "BUSINESS" table. The query filters the results to include businesses whose IDs are present in the subquery result where the "BUSINESS_HAS_CATEGORIES" table is grouped by "BUSINESS_ID" and having a count greater than or equal to 2. Additionally, it further filters the results to include businesses whose IDs are present in another subquery result where the "BUSINESS_PARKING_TYPE" table is grouped by "BUSINESS_ID" and having a count greater than 1. The query calculates these aggregations for the qualifying businesses.

SQL statement:
```sql
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
```

Result:

![Result D5](Query_results/Result_D5.png)


#### QUERY D_6:

Description of logic: 
First we store all the positive_tips, the we select all user thast fulfill the "yestersay condition". Then for each business_id, we check if there is a user who left a tip and who is not the user fulfilling the condition.
In details :
- We select the USER_ID, BUSINESS_ID, and TIP_DATE from the TIPS table where the TIP_TEXT contains the word "awesome" (= the positive tips) adn store in the table positive_tips
- WE select distinct USER_IDs from the positive_tips CTE where there exists another tip by the same user with a TIP_DATE one day earlier
- In the main query, we select the count of distinct BUSINESS_IDs from BUSINESS using a WHERE clause including a subquery that checks for the existence of a USER_ID that is not in users fulfilling the conditions and who gave a positive tip to this business.

SQL statement:
```sql
WITH positive_tips AS (
    SELECT USER_ID, BUSINESS_ID, TIP_DATE
    FROM TIPS
    WHERE LOWER(TIP_TEXT) LIKE '%awesome%'),
user_yesterday AS (
    SELECT DISTINCT pt1.USER_ID
    FROM positive_tips pt1
    JOIN positive_tips pt2 ON pt1.USER_ID = pt2.USER_ID AND TO_DATE(pt1.TIP_DATE, 'DD-MON-RR') - 1 = TO_DATE(pt2.TIP_DATE, 'DD-MON-RR')
)
SELECT count(distinct Business_ID) as count 
FROM BUSINESS bs
WHERE NOT EXISTS (
    SELECT pt.USER_ID
    FROM positive_tips pt
    WHERE bs.BUSINESS_ID = pt.business_id
    AND pt.USER_ID NOT IN (SELECT USER_ID FROM user_yesterday)
);
```

Results: 

![Result D6](Query_results/Result_D6.png)

#### QUERY D_7:

Description of logic: 

The first subquery selects the average stars from the "BUSINESS" table, joined with the "BUSINESS_GOOD_FOR_MEAL", "GOOD_FOR_MEAL", "BUSINESS_AMBIANCE", and "AMBIANCE" tables. It filters the results to include businesses that are good for dinner ("GOOD_FOR_MEAL_DESCRIPTION = 'dinner'") and have a divey ambiance ("AMBIANCE_DESCRIPTION = 'divey'").

The second subquery follows the same structure as the first but filters for businesses that are good for dinner ("GOOD_FOR_MEAL_DESCRIPTION = 'dinner'") and have an upscale ambiance ("AMBIANCE_DESCRIPTION = 'upscale'").

The main query subtracts the average stars from the second subquery from the average stars from the first subquery and aliases the result as "DIFFERENCE_OF_AVERAGES". The result represents the difference in average stars between businesses with a divey ambiance and businesses with an upscale ambiance that are good for dinner. The query is executed against the "DUAL" table

SQL statement:
```sql
SELECT
  (
    SELECT AVG(B.STARS)
    FROM BUSINESS B
    JOIN BUSINESS_GOOD_FOR_MEAL BGFM ON B.BUSINESS_ID = BGFM.BUSINESS_ID
    JOIN GOOD_FOR_MEAL GFM ON BGFM.GOOD_FOR_MEAL_ID = GFM.GOOD_FOR_MEAL_ID
    JOIN BUSINESS_AMBIANCE BA ON B.BUSINESS_ID = BA.BUSINESS_ID
    JOIN AMBIANCE A ON BA.AMBIANCE_ID = A.AMBIANCE_ID
    WHERE GFM.GOOD_FOR_MEAL_DESCRIPTION = 'dinner'
    AND A.AMBIANCE_DESCRIPTION = 'divey'
  ) - 
  (
    SELECT AVG(B.STARS)
    FROM BUSINESS B
    JOIN BUSINESS_GOOD_FOR_MEAL BGFM ON B.BUSINESS_ID = BGFM.BUSINESS_ID
    JOIN GOOD_FOR_MEAL GFM ON BGFM.GOOD_FOR_MEAL_ID = GFM.GOOD_FOR_MEAL_ID
    JOIN BUSINESS_AMBIANCE BA ON B.BUSINESS_ID = BA.BUSINESS_ID
    JOIN AMBIANCE A ON BA.AMBIANCE_ID = A.AMBIANCE_ID
    WHERE GFM.GOOD_FOR_MEAL_DESCRIPTION = 'dinner'
    AND A.AMBIANCE_DESCRIPTION = 'upscale'
  ) AS DIFFERENCE_OF_AVERAGES
FROM DUAL;
```

Result:

![Result D7](Query_results/Result_D7.png)

#### QUERY D_8:

Description of logic: 

SQL statement:
```sql

```
#### QUERY D_9:

Description of logic: 

SQL statement:
```sql

```

#### QUERY D_10:

Description of logic: 

SQL statement:
```sql

```


Optimization with indexing :

QUERY D2 : The initial runtime is 0.057 with a cost of 389 I/Os, mainly due to the GROUP BY clause. 




