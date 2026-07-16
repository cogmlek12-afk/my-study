-- ** KH_연습 문제 **
-- 1. '심봉선' 사원과 같은 부서에 속한 사원들의 사원명, 부서코드, 입사일을 조회

SELECT
FROM
WHERE

--1) 심봉선 부서코드 
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '심봉선'; -->D5

--2) 해당 부서코드인 사원 정보
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = ( SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '심봉선') 
 AND EMP_NAME != '심봉선'; -->위에 정보에서 심봉선 빼기


-- 2. 회사 전체 사원의 평균 급여보다 같거나 많은 급여를 받는 사원들의 사번, 사원명, 급여를 조회
--1) 전체 사원 평균급여
SELECT AVG(SALARY)
FROM EMPLOYEE;

--2) 평균보다 많이 받는 직원
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEE) ;


-- 3. 부서가 '회계관리부' 또는 '기술지원부' 부서에 속한 사원의 사원명, 부서코드, 급여를 조회
--1) 부서테이블에서 회계관리부 OR 기술지원부 부서코드 조회
SELECT DEPT_ID 
FROM DEPARTMENT
WHERE DEPT_TITLE IN ('회계관리부', '기술지원부'); --D2, D8

--) 해당 부서 사원조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN (SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE IN('회계관리부' , '기술지원부') ;


-- 4. '유하진' 사원과 부서와 직급이 같은 사원의 사원명, 부서코드, 직급코드 조회
--1) 유하진 부서,직급코드
SELECT DEPT_CODE,JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '유하진';

--2) 해당 사원 정보 조회
SELECT EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE, FROM EMPLOYEE WHERE EMP_NAME = '유하진')
  AND EMP_NAME <> '유하진';

-- 5. 각 직급 별 가장 높은 급여를 받는 사원들의 사원명, 직급코드, 급여를 조회
--1) 각 직급 별 가장 높은 급여
SELECT JOB_CODE, MAX(SALARY) 
FROM EMPLOYEE 
GROUP BY JOB_CODE ;

--2) 해당사원 정보조회
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) 
IN
(SELECT JOB_CODE, MAX(SALARY) 
FROM EMPLOYEE 
GROUP BY JOB_CODE 
);
