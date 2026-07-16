0/*
      * DDL (DATA DEFINTION LANGUAGE) : 데이터 정의어
      
      : 데이터베이스의 객체 (테이블, 사용자, 뷰, 인덱스 등)의 구조를 정의하거나 변경, 삭제하는 명령어
      : 실제 데이터 값이 아닌 구조(규칙)를 정의
      */
      
      -- ======================================
      /*
        
        * 테이블 생성 : CREATE TABLE 
        
              CREATE TABLE 테이블명 (
                     컬럼명 데이터 타입, 
                     컬럼명 데이터 타입 DEFAULT 기본값,
                     컬럼명 데이터 타입 제약조건 DEFAULT 기본값 제약조건,
                     
                     . . .
              ) ;
              
              
            * 오라클 기본 자료형 (데이터타입) *
            -날짜         |     DATE       | 날짜 및 시간 데이터
            -숫자         |    NUMBER   | 숫자 데이터 ( 정수,실수 )
            -문자         | CHAR (크기) | 고정길이 문자열 ( 최대 2000바이트) -> 지정한크기보다 작은데이터 입력시 공백으로 채워짐
                             | VARCHAR2(크기) | 가변길이 문자열 (최대 4000바이트) -> 입력된 데이터의 실제 크기만큼만 공간을 차지(효율적)
            */
            
            -- 회원 ( MEMBER ) : 회원번호 (MEM_NO) , 회원아이디(MEM_ID), 회원비밀번호 (MEM_PWD), 회원이름(MEM_NAME)
            --                                 , 성별 (GENDER), 연락처(PHONE), 이메일(EMAIL), 가입일시(ENROLLDATE)
                                             
                                             
                                             
        
        CREATE TABLE MEMBER (
                MEM_NO NUMBER, 
                MEM_ID VARCHAR2(20),
                MEM_PWD VARCHAR2 (50),
                MEM_NAME VARCHAR2(20),
                GENDER CHAR(3), --냠 또는 여 (한글은 1글자당 3바이트)
                PHONE CHAR(13), -- ( 한글을 제외한 숫자,영어,기호는 하나당1바이트 )
                EMAIL VARCHAR2(40),
                ENROLLDATE DATE
                );
                                             
  -- 컬럼에 주석추가
  -- : 테이블 구조의 각 컬럼이 무엇을 의미하는지 설명추가
  
  --   COMMENT ON COLUMN 테이블명,컬럼명 IS '설명문구' ;
  
  COMMENT ON COLUMN MEMBER. MEM_NO IS '회원번호';
   COMMENT ON COLUMN MEMBER. MEM_ID IS '아이디';
   COMMENT ON COLUMN MEMBER. MEM_PWD IS '비밀번호';
 COMMENT ON COLUMN MEMBER. MEM_NAME IS '이름';
 COMMENT ON COLUMN MEMBER. GENDER IS '성별';
 COMMENT ON COLUMN MEMBER. PHONE IS '연락처';
 COMMENT ON COLUMN MEMBER. EMAIL IS '이메일';
  COMMENT ON COLUMN MEMBER. ENROLLDATE IS '가입일시';
  
  -- *데이터 추가 (테스트)
  INSERT INTO MEMBER VALUES (1, 'sjlim', '1234', '임수진', '여', '010-1234-1234', 'cogmlek12@naver.com',  SYSDATE);
  INSERT INTO MEMBER VALUES (2, 'dog', '123', '누룽지', '남', '010-1111-2222' , NULL, SYSDATE);
  INSERT INTO MEMBER VALUES (NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
  COMMIT; 
  
  SELECT * FROM MEMBER;
-- ========================================================
/*
      * 제약조건 : 테이블의 특정 컬럼에 부적절한 데이터가  못들어오게 설정하는 규칙
                         데이터 무결성 ( 정확성, 일관성, 신뢰성)을 보장하는 것이 목적
  
  - 설정 방식 종류 -
  1) 컬럼 레벨 방식 : 컬럼 정의 바로 옆에 제약조건을 기술하는 방식 (모든제약조건 설정가능)
  2) 테이블 레벨 방식 : 모든 컬럼 정의를 마친 후, 하단에 별도로 기술하는 방식 (NOT NULL 제외)
           
*/
  
----------------------------------------------------------------------------------------
/*
      * NOT NULL 제약조건
      : 해당 컬럼에 NULL 값이 저장될 수 없도록 제한
      : 필수적으로 입력되어야하는 데이터 ( 아이디, 비번, 연락처 등)에 지정
      
      -> 컬럼 레벨 방식으로만 지정가능 
*/
  
  -- 회원 (MEMBER_NOTNULL) : 회원번호 (MEM_NO) , 회원아이디 (MEM_ID) 비번(MEM_PWD), 이름(MEM_NAME) 컬럼에 NOT NULL 제약조건 설정
  CREATE TABLE MEMBER_NOTNULL (
                MEM_NO NUMBER NOT NULL,
                MEM_ID VARCHAR2(20) NOT NULL,
                MEM_PWD VARCHAR2 (50) NOT NULL,
                MEM_NAME VARCHAR2(20) NOT NULL,
                GENDER CHAR(3), --냠 또는 여 (한글은 1글자당 3바이트)
                PHONE CHAR(13), -- ( 한글을 제외한 숫자,영어,기호는 하나당1바이트 )
                EMAIL VARCHAR2(40),
                ENROLLDATE DATE
  
  );
  
                                             
    -- * 데이터 추가
    INSERT INTO MEMBER_NOTNULL VALUES (1, 'sjlim', '1234', '임수진', '여', '010-1234-1234', 'cogmlek12@naver.com',  SYSDATE);
  INSERT INTO MEMBER_NOTNULL VALUES (2, 'sjlim', '1234', '임수진', '여',NULL,NULL,NULL);
     
  SELECT * FROM MEMBER_NOTNULL;                              
     
     --=============================================
     /* 
        *UNIQUE 제약 조건 : 해당 컬럼에 중복된 데이터 값이 들어오는 것을 제한
                                         고유해야하는 데이터 (주민번호, 아이디, 이메일 등)에 적용
                                         
                                         
                    -> NULL 은 값이 없는 상태를 의미하므로 , UNIQUE 조건이 있어도 여러개 저장될 수 있음...ㅎ               
                    
                    
                    *보통 제약 조건명을 지정하여 설정 : 에러발생시 어떤 제약조건을 위배했는지 명확하게 파악하기위해 ..!!
     */
                                             
-- 회원 (MEMBER_UNIQUE) : 회원 아이디(MEM_ID) UNIQUE 제약 조건 설정 
DROP TABLE MEMBER_UNIQUE;

CREATE TABLE MEMBER_UNIQUE (
  --컬럼 레벨 방식 : NOT NULL (회원번호, 아이디, 비밀번호, 이름)
   MEM_NO NUMBER NOT NULL,
                MEM_ID VARCHAR2(20) NOT NULL,
                MEM_PWD VARCHAR2 (50) NOT NULL,
                MEM_NAME VARCHAR2(20) NOT NULL,
                GENDER CHAR(3),
                PHONE CHAR(13), 
                EMAIL VARCHAR2(40),
                ENROLLDATE DATE,
                
  -- 테이블 레벨 방식 : UNIQUE (아이디)
 CONSTRAINT UQ_MEM_ID UNIQUE (MEM_ID)
);
        
        
-- * 데이터 추가
INSERT INTO MEMBER_UNIQUE VALUES  (1, 'sjlim', '1234', '임수진', '여', '010-1234-1234', NULL,NULL );
INSERT INTO MEMBER_UNIQUE VALUES  (2, 'sjlim', '3333', '박수진', '여', '010-1234-1234', NULL,NULL );
                                            
            SELECT * FROM MEMBER_UNIQUE;      
            
--==========================================================================
/*
            * CHECK 제약조건 : 해당 컬럼에 저장될 수 있는 값의 범위나 특정 조건식을 지정해주는 규칙
                                           조건식의 결과가 TRUE(만족)인 데이터만 저장할 수 있으며, NULL 값도 저장가능..
*/

-- 회원 (MEMBER_CHECK) : 성별(GENDER) '남' 또는 '여' 값만 저장되도록 조건 지정
CREATE TABLE MEMBER_CHECK (
           MEM_NO NUMBER NOT NULL ,
            MEM_ID VARCHAR2(20) NOT NULL,
                MEM_PWD VARCHAR2 (50) NOT NULL,
                MEM_NAME VARCHAR2(20) NOT NULL,
                GENDER CHAR(3) CONSTRAINT CK_GENDER CHECK(GENDER IN ('남', '여')),
                PHONE CHAR(13), 
                EMAIL VARCHAR2(40),
                ENROLLDATE DATE,
                
                CONSTRAINT UQ2_MEM_ID UNIQUE (MEM_ID)
);
                                             
-- =============== 데이터 추가
INSERT INTO MEMBER_CHECK VALUES (1, 'sjlim', '1234', '임수진', '여', NULL, NULL, SYSDATE );
INSERT INTO MEMBER_CHECK VALUES (1, 'sjlim23', '1234', '임수진', '여', NULL, NULL, SYSDATE );     
INSERT INTO MEMBER_CHECK VALUES (1, 'sjlim245', '1234', '임수진', '남', NULL, NULL, SYSDATE );     
    SELECT * FROM MEMBER_CHECK;                                               
                                             
                                             
                                             
--==============================
/*
            * PRIMARY KEY (기본키) 제약조건 
            : 테이블 내에서 각 행을 고유하게 식별하기 위해 사용하는 대표컬럼을 지정
            NOT NULL + UNIQUE (NULL 값을 허용하지 않고, 중복불가)
            테이블당 오직 1개만 지정하여 설정가능
            */
            
            -- 회원 (MEMBER_PRI) : 회원번호 (MEM_NO) 컬럼을 기본키로 지정
            CREATE TABLE MEMBER_PRI ( 
                MEM_NO NUMBER CONSTRAINT PRI_MEM_NO PRIMARY KEY,
                MEM_ID VARCHAR2(20) NOT NULL,
                MEM_PWD VARCHAR2 (50) NOT NULL,
                MEM_NAME VARCHAR2(20) NOT NULL,
                GENDER CHAR(3) CONSTRAINT CK2_GENDER CHECK(GENDER IN ('남', '여')),
                PHONE CHAR(13), 
                EMAIL VARCHAR2(40),
                ENROLLDATE DATE,
                
                CONSTRAINT UQ3_MEM_ID UNIQUE (MEM_ID)
);                                 
                                             
-- 데이터 추가
INSERT INTO MEMBER_PRI VALUES  (1, 'sjlim', '1234', '임수진', NULL, NULL, NULL, NULL);

INSERT INTO MEMBER_PRI VALUES  (1, 'sjlimDD', '1234', '임수진', NULL, NULL, NULL, NULL);
-- 안됨
INSERT INTO MEMBER_PRI VALUES  (NULL, 'sjlimDD', '1234', '임수진', NULL, NULL, NULL, NULL);                                            
-- 안됨
                                             
                                             
   -- =========================================
   /*
             * 복합키 : 단일 컬럼만으로는 기본키 역할을 부여하기 애매할 때
                                두 개 이상의 컬럼을 병합하여 하나의 기본키로 지 정 
                                
               --> 테이블 레벨 방식으로만 설정가능 ..ㅎ...ㅎ
               
               
   */
   
   CREATE TABLE MEMBER_PRI2 ( 
                MEM_ID VARCHAR2(20) NOT NULL,
                MEM_PWD VARCHAR2 (50) NOT NULL,
                MEM_NAME VARCHAR2(20) NOT NULL,
                GENDER CHAR(3)  CHECK(GENDER IN ('남', '여')),
                PHONE CHAR(13), 
                EMAIL VARCHAR2(40),
                ENROLLDATE DATE,
                
               UNIQUE (MEM_ID),
               CONSTRAINT  PRI2_PK_IDPHONE PRIMARY KEY (MEM_ID,PHONE)
);                                 
   
   INSERT INTO MEMBER_PRI2 VALUES ( 'sjlim', '1234', '임수진','여', '010-0000-0000', NULL, NULL);
   INSERT INTO MEMBER_PRI2 VALUES ( 'sj12345', '1234', '임수진','여', '010-0000-0000', NULL, NULL);
   
   
   
      SELECT * FROM MEMBER_UNIQUE;      
   
   --=================================================================
   /* 
                   * FOREIGN KEY (외래키) 제약조건 
                   : 다른 테이블에 존재하는 데이터 범위에서만 값을 저장하고자 할 때 설정
                      테이블 간의 관계에 따라 지정
                      
                      -부모 테이블 (참조대상) : 테이블 내 PK또는 UNIQUE 컬럼만 자식에게 제공가능
                      -자식 테이블 (참조주제) : 외래키 제약조건을 가지고 부모 칼럼을 가리키는 역할
   */
   
        --      부모 테이블 : 회원등급 (MEMBER_GRADE) - 등급번호(GRADE_NO), 등급명(GRADE_NAME)
        CREATE TABLE MEMBER_GRADE (
                        GRADE_NO NUMBER PRIMARY KEY, 
                        GRADE_NAME VARCHAR2(20) NOT NULL
                        );
   
   INSERT INTO MEMBER_GRADE VALUES (100, '일반회원');
   INSERT INTO MEMBER_GRADE VALUES (200, 'VIP회원');
   INSERT INTO MEMBER_GRADE VALUES (300, 'VVIP회원');
   
   
   SELECT * FROM MEMBER_GRADE;
   
   --자식 테이블 : 회원 ( MEMBER_FRK)
   CREATE TABLE MEMBER_FRK (
             MEM_NO NUMBER PRIMARY KEY,
             MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
             MEM_PWD VARCHAR2(20) NOT NULL,
             MEM_NAME VARCHAR2(20) NOT NULL,
             GENDER CHAR(3) CHECK( GENDER IN('남', '여') ),
             ENROLLDATE DATE,
             GRADE_ID  NUMBER REFERENCES MEMBER_GRADE(GRADE_NO)
             );
   
   INSERT INTO MEMBER_FRK VALUES (1, 'cogmlk12', '1234', '오범영', '남', SYSDATE, 100);
 INSERT INTO MEMBER_FRK VALUES (2, 'cogmlk22', '1234', '사범영', '남',SYSDATE, 200);
   INSERT INTO MEMBER_FRK VALUES (3, 'cogmlk32', '1234', '삼범영', '남', SYSDATE, 300);
   --> 부모테이블이 존재하는 값
   
    INSERT INTO MEMBER_FRK VALUES (4, 'cogmlk32', '1234', '삼범영', '남', SYSDATE, 400);
    --> 부모테이블 값 없어서 오류뜸
   
   
   SELECT * FROM MEMBER_FRK;
   
   
   --=========================================
   
   
   --회원 등급 (MEMBER_GRADE)테이블에서 등급번호가 100번인 데이터 삭제
   DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100; -->  자식테이블인 FRK에서 100번이 입력돼서 부모테이블에서 삭제 불가
   
--============================================
/* 
                  삭제옵션 : ON DELETE SET NULL
                  - 부모 테이블에서 참조되고 있는 행이 삭제될때 자식테이블 외래키 값을 자동으로 NULL로 변경 (데이터삭제)
                  - 자식테이블 데이터는 유지, 관계만 정리할때 사용
                  */
                  
   DROP TABLE MEMBER_FRK;
   CREATE TABLE MEMBER_FRK (
             MEM_NO NUMBER PRIMARY KEY,
             MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
             MEM_PWD VARCHAR2(20) NOT NULL,
             MEM_NAME VARCHAR2(20) NOT NULL,
             GENDER CHAR(3) CHECK( GENDER IN('남', '여') ),
             ENROLLDATE DATE,
             GRADE_ID  NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE SET NULL
             );
             
        
        
-- 데이터 추가
INSERT INTO MEMBER_FRK VALUES (1, 'cogmlk1223', '1234', '오범영', '남', SYSDATE, 100);
INSERT INTO MEMBER_FRK VALUES (2, 'cogmlk1235', '123', '오범영', '남', SYSDATE, 300);
   
   SELECT * FROM MEMBER_FRK;
   
   -- 부모테이블에서 참조되고있는 값 삭제(300)
    DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;
    ---> 삭제성공, 자식테이블에서 참조중이던 값은 NULL로변경
   
   ROLLBACK;
   
   --======================================================
   /* 
   
   삭제 옵션 : ON DELETE CASCADE
   - 부모테이블에서 특정행 삭제시 자식테이블 행도 같이 삭제됨
   -부모 자식테이블이 종속 관계일때 사용
*/

DROP TABLE MEMBER_FRK;

   CREATE TABLE MEMBER_FRK (
             MEM_NO NUMBER PRIMARY KEY,
             MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
             MEM_PWD VARCHAR2(20) NOT NULL,
             MEM_NAME VARCHAR2(20) NOT NULL,
             GENDER CHAR(3) CHECK( GENDER IN('남', '여') ),
             ENROLLDATE DATE,
             GRADE_ID  NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE CASCADE
             );
   
   
   -- 데이터 추가
INSERT INTO MEMBER_FRK VALUES (1, 'cogmlk12', '1234', '오범영', '남', SYSDATE, 100);
INSERT INTO MEMBER_FRK VALUES (2, 'cogmlk1235', '123', '오범영', '남', SYSDATE, 300);
   
   SELECT * FROM MEMBER_FRK;
   
   -- 부모테이블에서 참조되고있는 값 삭제(300)
    DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;
    --> 자식 테이블에서 참조중이었던 행 자체가 함께 삭제
    ROLLBACK;
    
    --=========================================================
    /*
            * 기본값 설정 : DEFAULT
            : 데이터가 추가될 때 입력안된 컬럼에 값 넣는 옵션
    */
   
   -- 회원 (MEMBER_DEFAULT)
   CREATE TABLE MEMBER_DEFAULT1 (
             MEM_NO NUMBER PRIMARY KEY,
             MEM_NAME VARCHAR2(20) NOT NULL,
             AGE NUMBER,
             HOBBY VARCHAR2(30) DEFAULT '없다',
             ENROLLDATE DATE DEFAULT SYSDATE
             ); 
             
  -- 데이터추가
  INSERT INTO MEMBER_DEFAULT1 VALUES (1, '누룽지', 39, '숭늉', SYSDATE);
  
  INSERT INTO MEMBER_DEFAULT1 (MEM_NO, NEN_NAME, AGE) VALUES (2, '누룽주', 39);
  
  INSERT INTO MEMBER_DEFAULT1 VALUES (3, '누룽이', 39, NULL,NULL);
  
  SELECT * FROM MEMBER_DEFAULT1;
  
  --====================================================
  /*
           테이블 복제 (CTAS, CREATE TABLE AS SELECT)
           : 기존에 구현되어있는 다른 테이블의 구성과 데이터를 빠르게 가져와서
           새로운 복제본 테이블을 만드는 문법
           : 컬럼 크기, 자료형, 데이터자체는 복제되는데 NOT NULL 외 제약조건은 복제안됨
           
           CREATE TABLE 테이블명
           AS (서브쿼리)
  */
   
   
   -- 회원테이블 (EMPLOYEE)을 복제
   CREATE TABLE EMPLOYEE_COPY
   AS (
        SELECT * FROM EMPLOYEE
        );
   
   
    SELECT * FROM EMPLOYEE_COPY;
    
    
    
    --직원 정보 중 번호,이름,급여만 별도테이블로 복제
    CREATE TABLE EMP_INFO
   AS (
        SELECT EMP_ID, EMP_NAME, SALARY FROM EMPLOYEE
        );
   
   
    SELECT * FROM EMP_INFO;


--구조만 복제
DROP TABLE EMP_INFO;
CREATE TABLE EMP_INFO
AS ( SELECT EMP_ID, EMP_NAME, SALARY FROM EMPLOYEE WHERE 1=0);
   
   
       SELECT * FROM EMP_INFO;
   --=====================================================
   
   /*
               * ALTER : 구조변경 시 사용
               - ALTER TABLE
               : 기존에 생성되있는 테이블의 컬럼이랑 제약조건을 변경하는 구문
               : 컬럼 추가/수정/삭제, 제약조건 추가/삭제
   */
   
   
   --* DEPT_TABLE 테이블 생성 (DEPT_ID:고정길이(5) , DEPT_TITLE:가변길이(35))
   
 CREATE TABLE DEPT_TABLE (
 DEPT_ID CHAR(5),
 DEPT_TITLE VARCHAR2(35)
 );
   
   --=======================
   /* 
                 컬럼추가
                 
                 ALTER TABLE 테이블명 ADD 추가할 컬럼명 데이터타입 [DEFAULT 기본값], [제약조건];
   */
   
  -- DEPT_TABLE 테이블에 CNAME (가변길이(20)) 컬럼 추가
  ALTER TABLE DEPT_TABLE ADD CNAME VARCHAR2 (20); 
  -- NNAME가변길이20 기본값 '한국'컬럼추가
   ALTER TABLE DEPT_TABLE ADD NNAME VARCHAR2 (20) DEFAULT '한국' ;
   
   
   /* 
            컬럼 변경
            
            ALTER TABLE 테이블명 MODIFY 변경할컬럼명 변경할데이터타입 [DEFAULT 기본값]
  */
            
 -- DEPT_TABLE 테이블에 DEPT_ID컬럼의 데이터타입을 고정길이(10) 변경                  
 ALTER TABLE DEPT_TABLE MODIFY DEPT_ID CHAR(10);
   
 -- 수정할때 여러개 컬럼 한번에 변경하기
 --              DEPT_TITLE 컬럼의 데이터타입 가변길이(55)로 변경
--               NNAME 컬럼의 기본값을 '코리아'로 변경
 ALTER TABLE DEPT_TABLE
 MODIFY DEPT_TITLE VARCHAR2(55) 
 MODIFY NNAME DEFAULT '코리아';
   
   
   --===================================
   /* 
           컬럼 삭제
                  
                  ALTER TABLE 테이블명 DROP COLUMN 컬럼명
                  DDL을 다룰때 주의할 점 : 삭제 후 복구 불가
 */
   
   --NNAME 컬럼을 삭제해볼게요
   
   ALTER TABLE DEPT_TABLE DROP COLUMN NNAME;
   
   --====================================
   
   /*
           제약조건 추가
           
           ALTER TABLE 테이블명 (ADD CONSTRAINT 제약조건명) 제약조건 (컬럼명)
   */
   
   -- DEPT_TABLE 의 DEPT_ID컬럼을 기본키로 설정. 제약조건명 : PK_DT
   
   ALTER TABLE DEPT_TABLE ADD CONSTRAINT PK_DT PRIMARY KEY(DEPT_ID);
   
   
   
   -- DEPT_TITLE 컬럼을 중복 불가하게 제한, 제약조건명 : UQ_DT
   
   ALTER TABLE DEPT_TABLE ADD CONSTRAINT UQ_DT UNIQUE (DEPT_TITLE);
   
   
   -- NOT NULL -> 기본값 : NULL 허용 / 변경으로 처리(...... MODIFY 컬럼명 NOT NULL)
   
   ALTER TABLE DEPT_TABLE MODIFY CNAME NOT NULL;
   
   /*
        제약조건 삭제
        
        ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명 
   */
   -- 기본키 삭제 : PK_DT
   ALTER TABLE DEPT_TABLE DROP CONSTRAINT PK_DT;
   
   
  -- 유니크 제약조건 삭제 : UQ_DT
   ALTER TABLE DEPT_TABLE DROP CONSTRAINT  UQ_DT;
   
   
   -- NOT NULL 은 삭제가 아니라 NULL로 변경해야됑
    ALTER TABLE DEPT_TABLE MODIFY CNAME NULL;
    
    -- ====================================================
    /*
              이름 변경하기 ( 컬럼, 제약조건, 테이블 )
              
              ALTER TABLE 테이블명 RENAME COLUMN  기존컬럼명 TO  변경할컬럼명
              
              ALTER TABLE 테이블명 RENAME CONSTRAINT  기존제약조건명  TO 변경할제약조건명
              
             ALTER TABLE 기존테이블명 RENAME TO 변경할테이블명
  */
  
  -- 컬럼명 변경 (DEPT_TIBLE : DEPT_TITLE -> DEPT_NAME)
  ALTER TABLE DEPT_TABLE RENAME COLUMN DEPT_TITLE TO DEPT_NAME;
  
  
  -- 제약조건명 변경
  
  -- 기본키 추가
  ALTER TABLE DEPT_TABLE ADD PRIMARY KEY (DEPT_ID);
   -- 추가한 제약조건명 : SYS_C008517
   -- > 변경할 제약조건명 : PK_DT
   
 ALTER TABLE DEPT_TABLE  RENAME  CONSTRAINT SYS_C008517 TO PK_DT;
   
   
   --  테이블명 변경 : DEPT_TABLE -> DEPT_TEST
   ALTER TABLE DEPT_TABLE  RENAME TO DEPT_TEST;

--===========================
/*
          DROP : 구조를 삭제(제거)
          
          DROP TABLE 테이블명 : 해당 테이블을 완전히 삭제
*/
   
   
   -- DEPT_TEST 테이블을 DEPT_COPY 테이블로 복제
   CREATE TABLE DEPT_COPY
   AS ( SELECT * FROM DEPT_TEST ) ;
   
   -- DEPT_COPY 테이블 삭제
   DROP TABLE DEPT_COPY;
   
   --MEMBER_GRADE 테이블 삭제
   DROP TABLE MEMBER_GRADE;  --> 외래키가 설정되어있어 삭제 불가
   
   --> 관계설정 상관없이 삭제하고싶을때 CASCADE 옵션 추가해야댐
   
   DROP TABLE MEMBER_GRADE CASCADE CONSTRAINTS;
   
   
   
   
   
   
   
   
   
   
   
   
   

                                             