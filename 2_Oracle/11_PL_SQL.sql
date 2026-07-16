



SET SERVEROUTPUT ON;

BEGIN
DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');

END;

/


DECLARE 
        NAME VARCHAR2(10);
        AGE NUMBER;
        CLASS CONSTANT CHAR(1) := 'C';
BEGIN
        NAME := '김채희';
        AGE := 20;
        
        DBMS_OUTPUT.PUT_LINE('이름 : ' || NAME);
        DBMS_OUTPUT.PUT_LINE('나이 : ' || AGE);
        DBMS_OUTPUT.PUT_LINE('강의장 : ' || CLASS);
        END;
        
        /
        
        
DECLARE
      EID NUMBER;
      ENAME VARCHAR2(10);
BEGIN
  --    ENAME := '김채희';
  ENAME := '&이름';
      
  --    EID := &직원번호;
  EID := 1004;
      
      DBMS_OUTPUT.PUT_LINE('이름' || ENAME);
      DBMS_OUTPUT.PUT_LINE('직원번호 : ' || EID);
END;
/
        
        DECLARE 
      EID EMPLOYEE.EMP_ID%TYPE;
      ENAME EMPLOYEE.EMP_NAME%TYPE;
      SAL EMPLOYEE.SALARY%TYPE;
        
        BEGIN
        
        SELECT EMP_ID, EMP_NAME, SALARY
        INTO EID, ENAME,SAL
        FROM EMPLOYEE
        WHERE EMP_ID = '&직원번호';
        
        DBMS_OUTPUT.PUT_LINE('직원번호 : ' || EID);
        DBMS_OUTPUT.PUT_LINE('직원이름 : ' ||  ENAME);
        DBMS_OUTPUT.PUT_LINE('급여 : ' || SAL);
        
        END;
        
        /
        
        
        --=====================================
        
        DECLARE
        EID EMPLOYEE.EMP_ID%TYPE;
        ENAME EMPLOYEE.EMP_NAME%TYPE;
        JCODE EMPLOYEE.JOB_CODE%TYPE;
        SAL EMPLOYEE.SALARY%TYPE;
        DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
        
BEGIN
    SELECT  EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
    INTO EID, ENAME, JCODE, SAL, DTITLE
    FROM EMPLOYEE
           JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    WHERE EMP_ID = '&201';
        
        
        DBMS_OUTPUT.PUT_LINE(EID || ',' || ENAME || ',' || JCODE || ',' || SAL  || ',' || DTITLE);
        
        END;
        /
        
        
        --===========================================================
        
DECLARE
              E EMPLOYEE%ROWTYPE;
BEGIN
             SELECT *
            INTO  E
            FROM EMPLOYEE
            WHERE EMP_ID = '&직원번호';
            
        DBMS_OUTPUT.PUT_LINE('이름:' || E.EMP_NAME);
        DBMS_OUTPUT.PUT_LINE('급여:' || E.SALARY);
        
        DBMS_OUTPUT.PUT_LINE('보너스:' || NVL(E.BONUS,0));
        END;
        /
        
        --==================================
        DECLARE
                SCORE NUMBER;
                GRADE CHAR(1);
        BEGIN
               SCORE := &점수;
               
        IF SCORE >= 90 THEN GRADE := 'A' ;
        ELSIF SCORE >= 80 THEN GRADE := 'B';
         ELSIF SCORE >= 70 THEN GRADE := 'C';
        ELSIF SCORE >= 60 THEN GRADE := 'D';  
        ELSE GRADE := 'F';
        END IF;
        
        DBMS_OUTPUT.PUT_LINE('몸무게는 ' || SCORE || ' 이고, 등급은  ' || GRADE|| '입니다.');
        
        IF GRADE = 'F'
        THEN  DBMS_OUTPUT.PUT_LINE('F는 재평가');
        END IF;
        END;
        /
        
        
        DECLARE
               EID EMPLOYEE.EMP_ID%TYPE;
               ENAME EMPLOYEE.EMP_NAME%TYPE;
               SAL EMPLOYEE.SALARY%TYPE;
               BONUS EMPLOYEE.BONUS%TYPE;
               
      BEGIN
            
            SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
            INTO EID, ENAME, SAL, BONUS
            FROM EMPLOYEE
            WHERE EMP_ID = '&직원번호';
            
            DBMS_OUTPUT.PUT_LINE('직원번호 : ' || EID);
             DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
             DBMS_OUTPUT.PUT_LINE('급여 : ' || SAL);
               
               
            
            IF BONUS = 0 THEN  DBMS_OUTPUT.PUT_LINE('보너스없다');
            ELSE  DBMS_OUTPUT.PUT_LINE('보너스 : ' || BONUS);
        
            
            END IF;
            
            END;
            /
            
            
            -----=============================================
            DROP TABLE TEST;
            
            
           CREATE TABLE TEST (
            TNO  NUMBER PRIMARY KEY,
            TDATE DATE
            );
            
            DROP SEQUENCE SEQ_TNO;
            
            CREATE SEQUENCE SEQ_TNO
            MAXVALUE 1000
            INCREMENT BY 2
            NOCYCLE
            NOCACHE;
            
            
            
            --TEST체이블에 100개 데이터추가
            
            IS
            BEGIN
            
                   FOR I IN 1..100
                   LOOP
                            --데이터 추가 (INSERT)
                            INSERT INTO TEST VALUES (SEQ_TNO.NEXTVAL, SYSDATE);
                   END LOOP;
                   
                   COMMIT;
                   
                   END;
                   /
        
        
        
        SELECT COUNT(*) FROM TEST;
        
        
        
        
        --=============================
        
        CREATE OR REPLACE PROCEDURE INSERT_TEST_DATA
        (
        DCOUNT IN NUMBER
        )
        IS
        BEGIN
            
                   FOR I IN 1..100
                   LOOP
                            --데이터 추가 (INSERT)
                            INSERT INTO TEST VALUES (SEQ_TNO.NEXTVAL, SYSDATE);
                   END LOOP;
                   
                   COMMIT;
                   
                   DBMS_OUTPUT.PUT_LINE(DCOUNT || '개의 데이터가 추가되었습니다.');
                   END;
                   /
        
        
        -- 생성된 프로시저를 사용(실행)
        CALL INSERT_TEST_DATA(50);
        
        BEGIN 
              INSERT_TEST_DATA(20);
              
              END;
              /
        
        
        
        
        
        SELECT COUNT (*) FROM TEST;
        
        
        --===============================
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        