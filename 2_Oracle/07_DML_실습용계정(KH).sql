/*
           *SQL
           
           D : DATE /  L : LANGUAGE
           -DQL (QUERY, 데이터 질의 언어) : 데이터 조회할 때 씀 -> SELECT (이거 하나)
           -DDL (DERINITION, 데이터 정의 언어) : 구조(규칙) 관리
           > CREATE생성, ALTER변경, DROP삭제
           -DML (MANIPULATION, 데이터 조작언어) : 데이터 관리(조작)
           > INSERT추가,삽입 / UPDATE변경,수정 / DELETE삭제
           -TCL (트랜잭션 제어언어 
           > COMMIT적용, ROLLBACK취소
           -DCL ( CONTROL,데이터제어언어) 
           > GRANT권한부여, REVOKE권한회수
           
*/

--========================================================

/*              DML / 데이터조작언어

              : 테이블의 데이터값을 추가(INSERT) 하거나 변경(UPDATE) , 삭제(DELETE) 하기위해 사용하는 언어
              
              */

-- INSERT : 테이블에 새로운 행을 추가하는 구문
--1)  INSERT INTO 테이블명 VALUES ( 값,값,값....)
--> 테이블의 모든 컬럼에 대한 값을 직접제시하여 추가할때 사용, 컬럼 순서에 맞게 값나열
--( 컬럼이랑 동일한 데이터로 제시해야됨)
-- 값 부족할때 오류 -> NOT ENOUGH VALUE
-- 값 많을때 오류 -> TOO MANY VALUES 

-- EMPLOYEE 테이블에 데이터 추가하기
SELECT *  FROM EMPLOYEE; 

INSERT INTO EMPLOYEE 
VALUES (900, '누룽지', '030529-3000000', 'cogmlek12@naver.com', NULL, 'D4', 'J4', 4000000, 0.3, NULL, SYSDATE, NULL, 'N');
SELECT * FROM EMPLOYEE;

/* 
 2) INSERT INTO 테이블명 (컬럼명1, 컬럼명2, ...)
VALUES (값1, 값2, ...);
-> 컬럼을 테이블명 옆에 직접 제시해서 값을 추가
제시하지않은 컬럼에는 기본적으로 NULL로 값 저장, NULL값이 아닌 값 저장시엔 기본값 옵션(디폴트) 설정해야됨

==> 제시하지 않은 컬럼에 "NOT NULL"제약조건 있으면 반드시 값을 직접 제시 OR 기본값 옵션 추가해야됨


*/

--EMPLOYEE 테이블에 데이터 추가 ( 직원번호, 이름, 주민번호, 이메일, 직급코드만 
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, EMAIL, JOB_CODE)
                      VALUES (901, '쭈꾸미', '971230-2000000', 'cogmldi12@naver.com', 'J6');


SELECT *  FROM EMPLOYEE; 

/* 
3) INSERT INTO 테이블명 ( 서브쿼리 )

-> VALUES 로 값을 직접명시하는 대신에 서브쿼리로 조회된 결과값을 통채로 INSERT하는 방식 ( 여러행추가하는 방식)
*/

-- EMP 01 테이블 추가
CREATE TABLE EMP01 (
EMP_ID VARCHAR2(3),
EMP_NAME VARCHAR2(20),
DEPT_TITLE VARCHAR2(35)
);


SELECT * FROM EMP01;


--EMP01테이블에 데이터추가
INSERT INTO EMP01
(
 SELECT EMP_ID, EMP_NAME, DEPT_TITLE
 FROM EMPLOYEE
           LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
           );
           
           SELECT *FROM EMP01;
           
--4) INSERT ALL : 두개이상의 테이블에 각각 데이터 추가할때 사용
--                        사용되는 서브쿼리 동일한경우 적용

/*INSERT ALL 
    INTO 테이블명1 [(컬럼명, 컬럼명, ...)] VALUES (서브쿼리컬럼명1, 서브쿼리컬럼명2, ...)
    INTO 테이블명2 [(컬럼명, 컬럼명, ...)] VALUES (서브쿼리컬럼명1, 서브쿼리컬럼명3, ...)
( 서브쿼리 );

==> VALUES 다음에 작성하는 컬럼명은 서브쿼리 결과(RESULT SET)에 표시되는 컬럼명이여야돼



*/
--EMP_DEPT 테이블 : 직원번호(EMP_ID),이름(EMP_NAME),부서코드(DEPT_CODE), 입사일(HIRE_DATE)

CREATE TABLE EMP_DEPT
AS ( SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE WHERE 1=0) ;

SELECT * FROM EMP_DEPT; 

CREATE TABLE EMP_MANAGER
AS (SELECT EMP_ID, EMP_NAME, MANAGER_ID FROM EMPLOYEE WHERE 1=0);

SELECT * FROM EMP_MANAGER;

--코드 D1 직원정보
SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, HIRE_DATE
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D1'; 

INSERT ALL
         INTO EMP_DEPT VALUES ( EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
         INTO EMP_MANAGER  VALUES ( EMP_ID, EMP_NAME,MANAGER_ID)
         (SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, HIRE_DATE
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D1');


SELECT * FROM EMP_DEPT;

SELECT * FROM EMP_MANAGER;
--=============================================
/* 
              ## UPDATE

테이블에 저장되어 있는 기존 데이터를 수정하는 명령어입니다.

UPDATE 테이블명
SET    컬럼명1 = 변경할값1,
       컬럼명2 = 변경할값2,
       ...
[WHERE  조건식];

=> SET절에는 여러개 컬럼을 동시에 변경가능,,
=> WHERE 절을 생략했을 경우 테이블의 모든 행변경 ( 주의 )
*/

--DEPT_TABLE 에 DEPARTMENT 테이블 복제 (데이터포함)
CREATE TABLE DEPT_TABLE
AS ( SELECT * FROM DEPARTMENT);

SELECT * FROM DEPT_TABLE;

-- D1인 부서코드를  '인사팀'으로 변경
UPDATE DEPT_TABLE
     SET DEPT_TITLE = '인사팀'
WHERE DEPT_ID = 'D1';

SELECT * FROM DEPT_TABLE WHERE DEPT_ID = 'D1';

ROLLBACK;

-- 부서명 '총무부' -> '전략기획팀' 변경 ( 기본키 컬럼을 조건으로 제시) 총무부 D9
UPDATE DEPT_TABLE
     SET DEPT_TITLE = '전략기획팀'
WHERE DEPT_ID = 'D9';

SELECT * FROM DEPT_TABLE WHERE DEPT_ID = 'D9';


-- EMP_TABLE 테이블에 EMPLOYEE 테이블을 복제 (직원번호, 이름, 부서코드, 급여, 보너스)

CREATE TABLE EMP_TABLE
AS ( SELECT EMP_ID,  EMP_NAME, DEPT_CODE, SALARY, BONUS FROM EMPLOYEE);

SELECT * FROM EMP_TABLE;

-- 900번 급여 500만원으로 인상
UPDATE EMP_TABLE
   SET SALARY = 5000000
   WHERE EMP_ID = '900';

SELECT * FROM EMP_TABLE WHERE EMP_ID = '900';

UPDATE EMP_TABLE
   SET SALARY = 4500000 , BONUS = 0.2
   WHERE EMP_ID = '215';


SELECT * FROM EMP_TABLE WHERE EMP_ID = '215';

-- 전체 직원 급여 10프로 인상

UPDATE EMP_TABLE
   SET SALARY = SALARY * 1.1;

SELECT * FROM EMP_TABLE;

-- ======================================
/*
        UPDATE문에 서브쿼리 사용하기
        
        UPDATE 테이블명
        SET   컬럼명 = (서브쿼리)
        WHERE  조건
        
*/


UPDATE EMP_TABLE 
     SET SALARY = 3400000,  BONUS =0.2
     WHERE EMP_NAME = '방명수';

ROLLBACK;


--아시아 지역에서 근무하는 직원들 보너스 0.3으로 변경

--1) 아시아 지역에서 근무중인 직원조회
SELECT * FROM LOCATION WHERE LOCAL_NAME LIKE 'ASIA%';


SELECT  *
FROM DEPARTMENT
            JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
            WHERE LOCAL_NAME LIKE 'ASIA%';

SELECT EMP_ID
FROM EMP_TABLE
          JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
          JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
           WHERE LOCAL_NAME LIKE 'ASIA%';
---> 다중행 서브쿼리 IN 사용

   UPDATE EMP_TABLE 
     SET  BONUS =0.3
     WHERE EMP_ID IN (
     SELECT EMP_ID
FROM EMP_TABLE
          JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
          JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
           WHERE LOCAL_NAME LIKE 'ASIA%'
           );


SELECT * FROM EMP_TABLE;
--* 변경사항적용

COMMIT;


--========================================================
/*
DELETE  : 테이블에 저장된 데이터 삭제

DELETE FROM 테이블명
[WHERE 조건] ; -> 이렇게 적으면 모든 데이터 삭제됨

*/

--EMPLOYEE 테이블의 데이터 삭제
DELETE FROM EMPLOYEE;

SELECT * FROM EMPLOYEE;

ROLLBACK;

-- 901번 데이터 삭제
DELETE FROM  EMP_TABLE WHERE EMP_ID = 901;
SELECT *  FROM  EMP_TABLE WHERE EMP_ID = 901;

-- 누룽지삭제
DELETE FROM  EMP_TABLE WHERE EMP_NAME = '누룽지';
SELECT *  FROM  EMP_TABLE WHERE EMP_NAME = '누룽지';


TRUNCATE TABLE EMP_TABLE;

SELECT *  FROM  EMP_TABLE;











