/*
             * 서브쿼리 : 하나의 쿼리문 내에서 사용되는 또 다른 쿼리문
                                메인 쿼리문의 조건이나 결과를 위해 먼저 실행되어 값을 제공 (보조역할)
*/


--노옹철 직원과 같은 부서인 직원조회

--1)노홍철 직원의 부서코드를 조회
SELECT DEPT_CODE 
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';  -->D9

--2)부서코드가 D9인 직원들의 정보 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

--서브쿼리 적용해서 1), 2) 합치기
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = (
             SELECT DEPT_CODE
            FROM EMPLOYEE
             WHERE EMP_NAME = '노옹철');
             
             
    --전체 직원평균급여보다 더 많이받는 직원정보조회
    --1) 전체 직원의 평균 급여조회
    SELECT ROUND( AVG(SALARY))
    FROM EMPLOYEE;
    
    --2) 평균 급여보다 더 많이 받는 직원조회
        SELECT *
    FROM EMPLOYEE
    WHERE SALARY > (
          SELECT ROUND( AVG(SALARY))
          FROM EMPLOYEE
          );

-- ============================================================

/*
          서브쿼리의 종류
          : 서브쿼리를 수행한 결과의 "행"과 "열"수에 따라 분류
          
          - 단일행 서브쿼리 : 수행 결과가 오로지 1개일때 (1행 1열)
          - 다중행 서브쿼리 : 수행 결과가 여러 행일 때(N행 1열)
          - 다중열 서브쿼리 : 수행 결과가 한 행이고, 여러개의 컬럼일 때 (1행 N열)
          - 다중행 다중열 서브쿼리 : 수행결과가 여러행이고 여러컬럼일때 (N행N열)
          
          => 종류에 따라 서브쿼리 앞에 사용되는 연산자가 달라질 수 있음
          */

 /* 
                 * 단일행 서브쿼리 => 비교연산자 사용가능 ( =,=!,>,<,>=,<=,.................)
 */


-- 최저 급여를 받는 직원의 이름, 급여, 입사일조회

--1) 최저급여조회
SELECT MIN(SALARY)
FROM EMPLOYEE;


--2)최저급여를 받는 직원정보조회
SELECT *
FROM EMPLOYEE
WHERE SALARY = 1380000;
           
            
--3) 서브쿼리 적용
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM 
WHERE SALARY = (
SELECT MIN(SALARY)
FROM EMPLOYEE);


--노옹철 직원보다 급여 많이받는 직원조회



SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (
           SELECT SALARY
           FROM EMPLOYEE
           WHERE EMP_NAME = '노옹철'
           );


-- 부서코드가 아닌 부서명으로 조회
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE SALARY > (
           SELECT SALARY
           FROM EMPLOYEE
           WHERE EMP_NAME = '노옹철'
           );
           
           
           
-- 부서별 총 급여 기준으로 가장 큰 부서의 부서코드, 총 급여 조회
-- 1) 부서별  총 급여가 가장 큰 부서
-- 1-1) 부서별 급여합
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 1-2) 급여 합들 중 가장 큰 값
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 2) 급여 합이 가장 큰 값인 부서의 부서코드, 급여합을 조회
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = 17700000;
-- 위에 두개 합친거
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
);



--전지연을 제외한 전지연 부서직원들 정보 

SELECT  DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = ' 전지연';  -->D9


SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
 JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE EMP_NAME != '전지연'
AND DEPT_CODE = (
   SELECT  DEPT_CODE
     FROM EMPLOYEE
    WHERE EMP_NAME = ' 전지연'); 
    
    -- ====================================
    /* 
    다중행 서브쿼리 : 서브쿼리 결과가 여러행인 경우(N행1열)
    
    IN (서브쿼리) : 여러개의 결과값 중에서 하나라도 일치하는 값이 있다면 결과로 표시
    => 비교대상 = 결과값1 OR 비교대상 = 결과값2 OR ...
    
    
    > ANY (서브쿼리) : 여러개의 결과값 중 하나라도 크면 결과로 표시
    < ANY (서브쿼리) : 여러개의 결과값 중 하나라도 작으면 결과로 표시
    => 비교대상 > 결과값1 OR 비교대상 > 결과값2 OR ...
    
    > ALL (서브쿼리) : 모든 결과값보다 크면 결과로 표시
    < ALL (서브쿼리) : 모든 결과값보다 작으면 결과로 표시
    => 비교대상 > 결과값1 AND 비교대상 > 결과값2 AND ...
    
    */
    
    
    -- 유재식 직원 또는 윤은해 직원과 같은 직급인 직원들의 정보조회 (직원번호, 이름, 직급코드,급여)
    
    -- 1) 유재식 직원 또는 윤은해 직원의 직급 코드를 조회
    SELECT JOB_CODE
    FROM EMPLOYEE
    WHERE EMP_NAME IN ('유재식', '윤은해'); --> J3, J7
    
    -- 2) 직급 코드가 J3 또는 J7인 직원 정보조회
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
    FROM EMPLOYEE 
    WHERE JOB_CODE IN ('J3', 'J7') ; --> 7명
    
    -- ** 서브쿼리를 적용하여 조회
     SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
    FROM EMPLOYEE 
    WHERE JOB_CODE IN (
     SELECT JOB_CODE
    FROM EMPLOYEE
    WHERE EMP_NAME IN ('유재식', '윤은해')
    );--> J3, J7
    
    -- 과장 직급인 직원의 최소 급여보다 더 많이 받는 대리직급인 직원
    
    --1) 과장직급의 최소급여
    SELECT SALARY
    FROM EMPLOYEE
            JOIN JOB USING(JOB_CODE)
    WHERE JOB_NAME = '과장' ;
    
    --2) 대리직급보다 많이 받는 직원조회
    SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
    FROM EMPLOYEE
               JOIN JOB USING (JOB_CODE)
   WHERE JOB_NAME = '대리'
            AND SALARY > ANY (3760000,2200000,2500000);
            
    -- ** 서브쿼리 적용
    
     SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
    FROM EMPLOYEE
               JOIN JOB USING (JOB_CODE)
   WHERE JOB_NAME = '대리'
            AND SALARY > ANY (
          SELECT SALARY
          FROM EMPLOYEE
            JOIN JOB USING(JOB_CODE)
          WHERE JOB_NAME = '과장' 
    );
    
    
    --======================================================================
    /*
                       * 다중열 서브쿼리 : 서브쿼리의 결과가 한 행이고  컬럼(열)이 여러개인 경우
    
                     ( 컬럼1, 컬럼2,.... ) = ( 서브쿼리 )
    */
    
    --하이유직원과 같은 부서, 같은 직급에 해당하는 직원 정보 조회 ( 이름, 부서코드, 직급코드, 급여)
  
  --1) 하이유의 부서코드, 직급코드 조회
    SELECT DEPT_CODE, JOB_CODE
    FROM EMPLOYEE
    WHERE EMP_NAME = '하이유';   --> D5,J5
    
    --- * 단일행 서브쿼리 -> 컬럼(열) 1개씩 조회하도록 
    SELECT EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D5'
                AND JOB_CODE = 'J5';
    
    
    SELECT EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    FROM EMPLOYEE
    WHERE DEPT_CODE = ( SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '하이유')
                AND JOB_CODE = (SELECT JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '하이유');
    


-- * 다중열 서브쿼리
  SELECT EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    FROM EMPLOYEE
    WHERE (DEPT_CODE,JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
                                                              FROM EMPLOYEE
                                                            WHERE EMP_NAME = '하이유');
                                                            
                                                            


 -- 박나라 직원과 같은 직급이고, 같은 사수인 직원의 정보 조회 (이름,직급코드, 사수번호)
-- 박나라 직급코드, 사수번호
SELECT JOB_CODE, MANAGER_ID 
 FROM EMPLOYEE
 WHERE EMP_NAME = '박나라';  --> J7,207
 
 -- 해당 직급코드랑 사수번호 동일한 직원
 SELECT EMP_NAME, DEPT_CODE, MANAGER_ID
 FROM EMPLOYEE
 WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID
                                                            FROM EMPLOYEE
                                                            WHERE EMP_NAME = '박나라' )
                AND EMP_NAME != '박나라';
 
-- ===================================================
/* 
         다중행 다중열 서브쿼리 : 서브쿼리의 겨로가가 여러행 여러열인경우 (N행 N열)
         */
         
         -- 각 직급별 최소 급여를 받는 직원 정보조회
         
         --1) 직급별 최소 급여 조회
         SELECT JOB_CODE, MIN(SALARY)
         FROM EMPLOYEE
         GROUP BY JOB_CODE;

--2) 각 직급별로 최소급여 받는 직원 조회

         SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
         FROM EMPLOYEE
         GROUP BY JOB_CODE . . . . . . . .. ;

--서브쿼리적용
         SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
         FROM EMPLOYEE
         WHERE (JOB_CODE, SALARY) IN (
          SELECT JOB_CODE, MIN(SALARY)
          FROM EMPLOYEE
         GROUP BY JOB_CODE
  );

-- 각 직급별 최고 급여받는 직원 정보 조회


         SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
         FROM EMPLOYEE
         WHERE (JOB_CODE, SALARY) IN (
          SELECT JOB_CODE, MAX(SALARY)
          FROM EMPLOYEE
         GROUP BY JOB_CODE
         );

-- =====================================================
/* 
              인라인뷰 : 서브쿼리를 FROM  절에 작성하여 마치 테이블처럼 활용
                                  ( 서브쿼리의 결과를 임시 테이블처럼 활용 )
*/

-- 직원들의 직원번호, 이름, 보너스포함 연봉, 부서코드를 조회
--          * 보너스포함 연봉이 3천이상인 직원조회
--          * 보너스포함 연봉 내림차순 정렬

SELECT EMP_ID, EMP_NAME, (SALARY + (SALARY*NVL(BONUS,0))) * 12, DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY + (SALARY*NVL(BONUS,0))) * 12 >= 30000000
ORDER BY 3 DESC;

-- ** 인라인뷰 적용
SELECT EMP_ID, EMP_NAME,"보너스포함연봉", DEPT_CODE
FROM (
SELECT EMP_ID, EMP_NAME,  (SALARY + (SALARY*NVL(BONUS,0))) * 12 "보너스포함연봉" , DEPT_CODE
FROM EMPLOYEE
ORDER BY 3 DESC
)
WHERE "보너스포함연봉" >= 30000000;



--===========================================
--* TOP-N 분석 * 

-- : 상위 N개를 조회
-- ROWNUM : 조회된 행에대해 순서대로 1부터 순번을 부여해주는 가상컬럼
SELECT EMP_ID, EMP_NAME,"보너스포함연봉", DEPT_CODE
FROM (
SELECT EMP_ID, EMP_NAME,  (SALARY + (SALARY*NVL(BONUS,0))) * 12 "보너스포함연봉" , DEPT_CODE
FROM EMPLOYEE
ORDER BY 3 DESC
)
WHERE "보너스포함연봉" >= 30000000
       AND ROWNUM <= 5;
       
       
-- 가장 최근에 입사한 직원 5명을 조회 ( 직원번호,이름,입사일)
--1) 입사일 내림차순 정렬하여 조회 (인라인뷰)
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE 
ORDER BY 3 DESC;


--2) 상위 5개만 조회

SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM (
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE 
ORDER BY 3 DESC
)
WHERE ROWNUM <= 5;

--==========================


/* 
  * 순서를 매기는 함수 (윈도우 함수, WINDOW FUNCTION)
  
  - RANK () OVER(정렬기준)                
  1
  1
  1
  4
  
  
  - DENSE_RANK () OVER ( 정렬기준) 
  1
  1
  1
  2
  
  -> SELECT 절에서만 사용가능
  */


--급여가 높은순서대로 순위를 매겨서 조회
 SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) "순위"
 FROM EMPLOYEE;


SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) "순위"
FROM EMPLOYEE;

--> 상위 5명만 조회
SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) "순위"
FROM EMPLOYEE;


SELECT *
FROM (
SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) "순위"
FROM EMPLOYEE
)
WHERE 순위 <= 5; 

-- 3위부터 5위까지만 보는방법

SELECT *
FROM (
SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) "순위"
FROM EMPLOYEE
)
WHERE 순위 BETWEEN 3 AND 5;

--==============================================================
-- 1) ROWNUM을 활용해서 상위 5명 급여 조회할랬는데 잘안됨
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

-- 문제점 : ROWNUM 순서가 뒤죽박죽호박죽
-- 해결 : 범영이따라하기, 정렬 후에 상위5명 추려내야됨
SELECT ROWNUM, EMP_NAME, SALARY
FROM(
SELECT ROWNUM, EMP_NAME,SALARY
FROM EMPLOYEE 
ORDER BY SALARY DESC
)
WHERE ROWNUM <=5; 


-- 2) 부서별 평균 급여가 270만원을 초과하는 부서에 해당하는 부서코드, 부서별 총 급여합, 부서별 평균급여,
--    부서별 직원수 조회도 할랬는데 잘안됨
SELECT DEPT_CODE, SUM(SALARY) "총합", FLOOR (AVG(SALARY)) "평균급여", COUNT(*) "직원수"
FROM EMPLOYEE 
WHERE SALARY > 2700000
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE; 


-- 문제점 : 부서별 평균이아닌 각 직원의 급여를 기준으로 조건을 제시함 ?
-- 해결 : 범영이따라하기

SELECT DEPT_CODE, SUM(SALARY) "총합", FLOOR (AVG(SALARY)) "평균급여", COUNT(*) "직원수"
FROM EMPLOYEE 
GROUP BY DEPT_CODE
HAVING FLOOR (AVG(SALARY)) > 2700000
ORDER BY DEPT_CODE;

-- 인라인뷰 적용
SELECT *
FROM (
SELECT DEPT_CODE, SUM(SALARY) "총합", FLOOR (AVG(SALARY)) "평균급여", COUNT(*) "직원수"
FROM EMPLOYEE 
GROUP BY DEPT_CODE
)
WHERE 평균급여 > 2700000;
















