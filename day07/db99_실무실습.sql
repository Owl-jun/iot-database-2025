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

