

SELECT EMP_ID, EMP_NAME,  DEPT_TITLE , SALARY, NATIONAL_CODE
FROM EMPLOYEE
  JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID 
  JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
  JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '한국'; 



SELECT EMP_ID, EMP_NAME,  DEPT_TITLE , SALARY, NATIONAL_CODE
FROM EMPLOYEE
  JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID 
  JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
  JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '러시아'; 


--=======================================
CREATE OR REPLACE VIEW VW_EMPLOYEE
AS
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
     JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
     JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
       JOIN NATIONAL USING (NATIONAL_CODE);

SELECT * FROM VW_EMPLOYEE WHERE NATIONAL_NAME = '중국';


--====================================
-- 뷰 생성 : 직원번호, 이름, 직급명, 성별(남|여), 근무년수 정보조회
-- 근무년수 : 현재연도  - 입사연도
-- 성별 : 주민번호 8번째 자리값으로 분류


SELECT EMP_ID, EMP_NAME, JOB_NAME,
                     DECODE (SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여', '3', '남', '4', '여'),
                     EXTRACT (YEAR FROM SYSDATE) - EXTRACT (YEAR FROM HIRE_DATE)
            
FROM EMPLOYEE
            JOIN JOB USING (JOB_CODE);
            
            
-- 뷰 생성 ( 틀린 생성 ) 
CREATE OR REPLACE VIEW VW_EMP_JOB
AS
SELECT EMP_ID, EMP_NAME, JOB_NAME,
                   DECODE (SUBSTR (EMP_NO, 8,1), '1', '남', '2', '여', '3', '남', '4', '여'),
                   EXTRACT (YEAR FROM SYSDATE) - EXTRACT (YEAR FROM HIRE_DATE)
FROM EMPLOYEE
            JOIN JOB USING (JOB_CODE);
            -------------------->오류발생 왜냐면,, : ORA-00998: 이 식은 열의 별명과 함께 지정해야 합니다
            ----------------------> 함수,연산식 들어간 컬럼은 무조건 별칭줘야댐




-- 별칭 부여 1) 서브쿼리에 직접 별칭 부여
CREATE OR REPLACE VIEW VW_EMP_JOB
AS
SELECT EMP_ID, EMP_NAME, JOB_NAME,
                   DECODE (SUBSTR (EMP_NO, 8,1), '1', '남', '2', '여', '3', '남', '4', '여') "성별",
                   EXTRACT (YEAR FROM SYSDATE) - EXTRACT (YEAR FROM HIRE_DATE) "근무년수"
FROM EMPLOYEE
            JOIN JOB USING (JOB_CODE);
            
        SELECT * FROM VW_EMP_JOB;
        
        
        
-- 별칭 부여2) 뷰이름 선언하면서 컬럼명 정의
CREATE OR REPLACE VIEW VW_EMP_JOB
AS
SELECT EMP_ID, EMP_NAME, JOB_NAME,
                   DECODE (SUBSTR (EMP_NO, 8,1), '1', '남', '2', '여', '3', '남', '4', '여') 
                   EXTRACT (YEAR FROM SYSDATE) - EXTRACT (YEAR FROM HIRE_DATE) 
FROM EMPLOYEE
            JOIN JOB USING (JOB_CODE);
            
        SELECT * FROM VW_EMP_JOB;



-- 테이블을 뷰로 생성
CREATE OR REPLACE VIEW VW_JOB
AS
SELECT JOB_CODE, JOB_NAEM FROM JOB;

-- 뷰를 통해 데이터 삽입 -> 쟙 테이블에 데이터 삽입
INSERT INTO VW_JOB VALUES ('J8', '인턴');

--뷰 통해서 데이터 수정 -> 원본 데이터 변경
UPDATE VW_JOB SET JOB_NAME = '알바' WHERE JOB_CODE = 'J8';

--뷰 통해서 데이터 삭제 -> 원본데이터 삭제
DELETE FROM VW_JOB WHERE JOB_CODE = 'J8';

ROLLBACK;


--================== 
--FORCE  옵션

CREATE OR REPLACE FORCE VIEW VW_TEST
AS SELECT TEST_ID, TEST_NAME FROM TB_TEST;
--> 경고는 뜨는데 뷰자체는 생성됨

SELECT * FROM VW_TEST;

SELECT * FROM USER_VIEWS;



-- * WITH CHECK OPTION 옵션
-- VW_EMP_SAL (급여가 300이상인 직원정보)
CREATE OR REPLACE VIEW VW_EMP_SAL
AS SELECT * FROM EMPLOYEE WHERE SALARY >= 3000000
WITH CHECK OPTION;

SELECT * FROM VW_EMP_SAL;

-- 204번 직원급여 200만원으로 변경 (300만원 미만으로 변경)
UPDATE VW_EMP_SAL
         SET SALARY = 2000000
   WHERE EMP_ID = '204'; 



-- * WITH READ ONLY 옵션
CREATE OR REPLACE VIEW VW_EMP_SAL
AS SELECT * FROM EMPLOYEE WHERE SALARY >= 3000000
WITH READ ONLY;


SELECT * FROM VW_EMP_SAL;








