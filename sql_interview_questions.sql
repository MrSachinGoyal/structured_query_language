

# DAY 1
-- Question 1 Link: https://platform.stratascratch.com/coding/9726-classify-business-type?code_type=3
-- Solution: 
SELECT DISTINCT(business_name),
	   CASE WHEN business_name LIKE '%restaurant%' THEN 'restaurant'
		    WHEN (business_name LIKE '%cafe%') OR (business_name LIKE '%café%') OR (business_name LIKE '%coffee%') THEN 'cafe'
		    WHEN business_name LIKE '%school%' THEN 'school'
		    ELSE 'other'
      END AS business_type
FROM sf_restaurant_health_violations;

# DAY 2
-- Question 2 Link: https://www.hackerrank.com/challenges/binary-search-tree-1/problem?isFullScreen=true
-- Solution:
SELECT N,
       CASE WHEN P IS NULL THEN 'Root'
            WHEN N IN (SELECT DISTINCT(P) FROM BST WHERE P IS NOT NULL) THEN 'Inner'
            ELSE 'Leaf'
        END AS Type
FROM BST
ORDER BY N;
