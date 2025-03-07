-- WorkBook SQL Practice
/* 샘플 - Employee에서 사원번호, 이름, 급여, 업무, 입사일, 상사의 사원번호를 출력하시오.
	이때 이름과 성을 연결하여 Full Name 이라는 별칭으로 출력하시오.
*/

SELECT employee_id 사원번호
	 , concat(first_name,' ',last_name) 이름
     , salary 급여
     , job_id 업무
     , hire_date 입사일
     , manager_id 상사
  FROM employees;
  
SELECT * FROM employees;

SELECT concat(first_name,' ',last_name) Name
	 , job_id Job
     , salary Salary
	 , (salary*12+100) 'Increased Ann_Salary'
     , (salary+100)*12 'Increased Salary'
  FROM employees;
  
SELECT concat(last_name,': 1 Year Salary = $',salary*12) '1 Year Salary'
  FROM employees;
  
SELECT DISTINCT department_id, job_id
  FROM employees;
  
  
SELECT concat(first_name,' ',last_name) Name, salary
FROM employees
WHERE salary NOT between 7000 and 10000
order by salary asc;

SELECT last_name 'e AND o Name'
FROM employees
WHERE last_name LIKE '%e%' and last_name LIKE '%o%';

SELECT date_add(sysdate(), interval 9 hour) as sysdate;
SELECT concat(first_name,' ',last_name) Name, employee_id , hire_date
FROM employees
WHERE hire_date between '1995-05-20' and '1996-05-20'
ORDER BY hire_date;

SELECT concat(first_name,' ',last_name) name
	 , salary
     , job_id
     , commission_pct
  FROM employees
 WHERE commission_pct IS NOT NULL
 ORDER BY salary desc, commission_pct desc;
 
SELECT employee_id, concat(first_name,' ',last_name) name, salary ,ROUND(salary * 1.123,0) as 'Increased Salary'
  FROM employees
 WHERE department_id = 60;

SELECT CONCAT(UPPER(substring(first_name,1,1))
	 , substring(first_name,2) 
     , ' ' 
	 , UPPER(substring(last_name,1,1))
     , substring(last_name,2)
     , ' is a '
     , UPPER(job_id)) 'Employee JOBs'
  FROM employees
 WHERE last_name LIKE '%s';
 
 SELECT * FROM employees;
 
SELECT concat(first_name,' ',last_name) Name
	 , salary
     , salary*12 as 'Annual Salary'
     , IF (commission_pct IS NULL , 'salary only', 'salary + Commission') 'Commission ?'
  FROM employees;
  
SELECT concat(first_name,' ',last_name) Name, hire_date, date_format(hire_date, '%W') as 'Day of the week'
  FROM employees
 ORDER BY FIELD(DATE_FORMAT(hire_date, '%W'), 
               'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 
               'Friday', 'Saturday'); ;
               
               
SELECT * FROM employees;

SELECT department_id 
	 , concat('$',format(sum(salary),0)) 'Sum Salary'
	 , concat('$',format(avg(salary),0)) 'Avg Salary'
	 , concat('$',format(max(salary),0)) 'Max Salary'
	 , concat('$',format(min(salary),0)) 'Min Salary'
  FROM employees
 WHERE department_id is not null
 group by department_id
 order by department_id;
 
SELECT job_id, avg(salary) 'Avg Salary'
  FROM employees
 WHERE job_id NOT LIKE '%CLERK%'
 GROUP BY job_id
 HAVING avg(salary) > 10000
 ORDER BY avg(salary) DESC;
 

SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM job_grades;

SELECT d.department_name, COUNT(e.employee_id)
  FROM employees e
  JOIN departments d ON e.department_id = d.department_id
 GROUP BY d.department_name
HAVING COUNT(e.employee_id) >= 5
 ORDER BY COUNT(e.employee_id) DESC;
 
SELECT CONCAT(e.first_name,e.last_name) Name
	 , e.job_id
     , d.department_name
     , e.hire_date
     , e.salary
     , j.grade_level
  FROM employees e , job_grades j , departments d
 WHERE e.department_id = d.department_id
   AND e.salary Between j.lowest_sal and j.highest_sal;
   
SELECT CONCAT(first_name,' ',last_name) Employee
	 , CONCAT('report to')'report to' 
     , UPPER((SELECT CONCAT(first_name,' ',last_name) Employee FROM employees e2 WHERE e1.manager_id = e2.employee_id)) Manager
  FROM employees e1;
  
  
SELECT CONCAT(first_name, ' ', last_name) AS Name, 
       job_id, 
       salary, 
       hire_date
FROM employees e
WHERE salary = (SELECT MIN(salary) 
                FROM employees 
                GROUP BY job_id
                HAVING e.job_id = job_id);
                
                
SELECT e.employee_id
	 , CONCAT(e.first_name,' ',e.last_name) Name
     , e.job_id
     , e.hire_date
  FROM employees e
  JOIN departments d 
    ON e.department_id = d.department_id
 WHERE d.location_id IN (SELECT location_id 
						   FROM locations l 
						  WHERE city LIKE 'O%');
                          
                          
-- 서브쿼리 계속

/* 사원의 급여 정보 중 업무별(job) 최소 급여를 받는 사원의 이름, 성을 name으로 별칭, 업무, 급여, 입사일로 출력(21행) */

SELECT * 
  FROM employees e1
 WHERE (e1.job_id, e1.salary) IN
								(SELECT e2.job_id
									  , MIN(e2.salary) as salary
								   FROM employees e2
								  GROUP BY e2.job_id);

-- 집합 연산자 : 테이블 내용을 합쳐서 조회

-- 조건부 논리 표현식 제어 : CASE

SELECT employee_id , CONCAT(first_name, ' ', last_name) as 'Name', job_id, salary,
  CASE job_id	
	WHEN 'HR_REP' THEN 1.10 * salary
	WHEN 'MK_REP' THEN 1.12 * salary
	WHEN 'PR_REP' THEN 1.15 * salary
	WHEN 'SA_REP' THEN 1.18 * salary
	WHEN 'IT_PROG' THEN 1.20 * salary
	ELSE salary
  END  "New Salary"
FROM employees;
                

SELECT month(hire_date), count(*)
FROM employees
GROUP BY month(hire_date);

SELECT 
        MONTH(hire_date) AS month_num,
        COUNT(*) AS hire_count
    FROM employees
    GROUP BY MONTH(hire_date);




-- 563Page 문제 3 step1
WITH month_counts AS (
    SELECT 
        MONTH(hire_date) AS month_num,
        COUNT(*) AS hire_count
    FROM employees
    GROUP BY MONTH(hire_date)
    ORDER BY month_num
)
SELECT 
    CASE WHEN month_num = 1 THEN hire_count ELSE 0 END AS '1월',
    CASE WHEN month_num = 2 THEN hire_count ELSE 0 END AS '2월',
    CASE WHEN month_num = 3 THEN hire_count ELSE 0 END AS '3월',
    CASE WHEN month_num = 4 THEN hire_count ELSE 0 END AS '4월',
    CASE WHEN month_num = 5 THEN hire_count ELSE 0 END AS '5월',
    CASE WHEN month_num = 6 THEN hire_count ELSE 0 END AS '6월',
    CASE WHEN month_num = 7 THEN hire_count ELSE 0 END AS '7월',
    CASE WHEN month_num = 8 THEN hire_count ELSE 0 END AS '8월',
    CASE WHEN month_num = 9 THEN hire_count ELSE 0 END AS '9월',
    CASE WHEN month_num = 10 THEN hire_count ELSE 0 END AS '10월',
    CASE WHEN month_num = 11 THEN hire_count ELSE 0 END AS '11월',
    CASE WHEN month_num = 12 THEN hire_count ELSE 0 END AS '12월'
FROM month_counts;


-- 563Page 문제 3 step2
SELECT 
    SUM(CASE WHEN month(hire_date) = 1 THEN 1 ELSE 0 END) AS '1월',
    SUM(CASE WHEN month(hire_date) = 2 THEN 1 ELSE 0 END) AS '2월',
    SUM(CASE WHEN month(hire_date) = 3 THEN 1 ELSE 0 END) AS '3월',
    SUM(CASE WHEN month(hire_date) = 4 THEN 1 ELSE 0 END) AS '4월',
    SUM(CASE WHEN month(hire_date) = 5 THEN 1 ELSE 0 END) AS '5월',
    SUM(CASE WHEN month(hire_date) = 6 THEN 1 ELSE 0 END) AS '6월',
    SUM(CASE WHEN month(hire_date) = 7 THEN 1 ELSE 0 END) AS '7월',
    SUM(CASE WHEN month(hire_date) = 8 THEN 1 ELSE 0 END) AS '8월',
    SUM(CASE WHEN month(hire_date) = 9 THEN 1 ELSE 0 END) AS '9월',
    SUM(CASE WHEN month(hire_date) = 10 THEN 1 ELSE 0 END) AS '10월',
    SUM(CASE WHEN month(hire_date) = 11 THEN 1 ELSE 0 END) AS '11월',
    SUM(CASE WHEN month(hire_date) = 12 THEN 1 ELSE 0 END) AS '12월'
FROM employees;


-- ROLLUP
/* 샘플 */

SELECT * from employees;

SELECT CASE WHEN GROUPING(department_id) = 1 THEN '(All-DEPTS)' ELSE department_id END as 'Dept#'
	 , CASE WHEN GROUPING(job_id) = 1 THEN '(All-JOBS)' ELSE job_id END as 'Jobs'
     , COUNT(employee_id) as "COUNT EMPs"
     , CONCAT('$',FORMAT(SUM(salary),0)) as 'Salary SUM'
  FROM employees
 GROUP BY department_id, job_id WITH ROLLUP;
 
 
-- 분석함수 NTILE , RANK

select department_id
	 , sum(salary) as 'sum salary'
     , ntile(6) over(order by sum(salary) desc) -- 범위 별로 등급 매기는 키워드
  from employees
 group by department_id;
 
 
select employee_id 
	 , last_name 
     , salary
     , department_id
     , rank() over (partition by department_id order by salary desc) as 'Rank'
     , Dense_Rank() over (partition by department_id order by salary desc) as 'Dense_Rank'
     , Row_Number() over (partition by department_id order by salary desc) as 'Row_Number'
from employees;
