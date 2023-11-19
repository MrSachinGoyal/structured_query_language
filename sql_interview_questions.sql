

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

# DAY 3
-- Question 3 Link: https://www.hackerrank.com/challenges/the-company/problem?isFullScreen=true
-- Solution:
SELECT c.company_code, 
       c.founder AS founder_name,
       COUNT(DISTINCT(lm.lead_manager_code)) AS lead_manager_count,
       COUNT(DISTINCT(sm.senior_manager_code)) AS senior_manager_count,
       COUNT(DISTINCT(mgr.manager_code)) AS manager_count,
       COUNT(DISTINCT(emp.employee_code)) AS emp_count
FROM 
	company c
INNER JOIN 
	lead_manager lm
ON 
	c.company_code = lm.company_code
LEFT JOIN 
	senior_manager sm
ON 
	lm.lead_manager_code = sm.lead_manager_code
LEFT JOIN 
	manager mgr
ON 
	sm.senior_manager_code = mgr.senior_manager_code
LEFT JOIN 
	employee emp
ON 
	mgr.manager_code = emp.manager_code
GROUP BY 
	c.company_code, c.founder
ORDER BY 
	c.company_code;

# DAY 4
-- Question 4 Link: https://www.hackerrank.com/challenges/the-report/problem?isFullScreen=true
-- Solution: 
SELECT 
CASE WHEN grades.grade >= 8 THEN stu.name ELSE NULL END AS Name, 
grades.grade AS grade, 
stu.marks AS mark
FROM 
	students stu
INNER JOIN 
	grades 
ON 
	grades.min_mark <= stu.marks AND grades.max_mark >= stu.marks
ORDER BY 
	grade DESC, Name ASC,marks ASC;

# DAY 5
-- Question 5 Link: https://www.hackerrank.com/challenges/full-score/problem?isFullScreen=true
-- Solution:
SELECT sub.hacker_id AS hacker_id, 
       hackers.name AS hacker_name
FROM 
	difficulty diff
INNER JOIN 
	challenges ch
ON 
	diff.difficulty_level = ch.difficulty_level
INNER JOIN 
	submissions sub
ON 
	ch.challenge_id = sub.challenge_id
INNER JOIN 
	hackers 
ON 
	hackers.hacker_id = sub.hacker_id
WHERE 
	sub.score = diff.score
GROUP BY 
	sub.hacker_id, hackers.name
HAVING 
	COUNT(*) > 1
ORDER BY 
	COUNT(*) DESC, hacker_id ASC;
    
# DAY 6:
-- Question Link: https://www.hackerrank.com/challenges/occupations/problem?isFullScreen=true
-- Solution:

WITH CTE AS 
(SELECT occupation, 
       name,
       ROW_NUMBER() OVER(PARTITION BY occupation ORDER BY Name ASC) AS name_order 
FROM occupations),

CTE_2 AS 
(SELECT name_order,
        MIN(CASE WHEN occupation = 'Doctor' THEN name END) AS 'Doctor',
        MIN(CASE WHEN occupation = 'Professor' THEN name END) AS 'Professor',
        MIN(CASE WHEN occupation = 'Singer' THEN name END) AS 'Singer',
        MIN(CASE WHEN occupation = 'Actor' THEN name END) AS 'Actor'
FROM
     CTE
GROUP BY name_order)
    
SELECT Doctor, 
       Professor, 
       Singer, 
       Actor 
FROM CTE_2;