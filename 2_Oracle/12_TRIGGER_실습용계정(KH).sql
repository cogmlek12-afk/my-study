
CREATE OR REPLACE TRIGGER TRG_EMP01
AFTER INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('신입사원님 환영합니다 ^^');
END;
/


--======================
--상품테이블
CREATE TABLE TB_PRODUCT (
         PNO NUMBER PRIMARY KEY,
         PNAME VARCHAR2(30) NOT NULL,
         BRAND VARCHAR2(30) NOT NULL,
         PRICE NUMBER DEFAULT 0,
         STOCK NUMBER DEFAULT 0
         );
         
--상품 번호 시퀀스
CREATE SEQUENCE SEQ_PNO
        START WITH 200
        INCREMENT BY 5
        NOCACHE;
        
--샘플 데이터 추가
INSERT INTO TB_PRODUCT (PNO, PNAME, BRAND) VALUES (SEQ_PNO.NEXTVAL, '뽕따', '해태');
INSERT INTO TB_PRODUCT VALUES (SEQ_PNO.NEXTVAL, '빠삐코' , '롯데' ,1200, 20);
INSERT INTO TB_PRODUCT VALUES (SEQ_PNO.NEXTVAL, '토마토마', '크라운', 1200, 10);

SELECT * FROM TB_PRODUCT;
COMMIT;

--입출고 내역 테이블
CREATE TABLE TB_PDETAIL (
        DNO NUMBER PRIMARY KEY,
        PNO NUMBER REFERENCES TB_PRODUCT(PNO),
        DDATE DATE DEFAULT SYSDATE, 
        AMOUNT NUMBER NOT NULL,
        DTYPE CHAR(6) CHECK(DTYPE IN ( '입고', '출고')) 
        
        );

CREATE SEQUENCE SEQ_DNO
NOCACHE;

SELECT *
FROM TB_PDETAIL;

--=============

CREATE OR REPLACE TRIGGER TRG_PRODUCT
AFTER INSERT ON TB_PDETAIL
FOR EACH ROW 
BEGIN


          IF 
          :NEW.DTYPE = '입고' THEN
             UPDATE TB_PRODUCT
             SET STOCK = STOCK + :NEW.AMOUNT
             WHERE PNO = :NEW.PNO;
             END IF;
             END;
             /
             
             SELECT *
             FROM TB_PRODUCT;
             
             INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 205, SYSDATE, 7, '출고');
             INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 210, SYSDATE, 20, '입고');

 SELECT *
 FROM TB_PDETAIL;
 
 COMMIT;






         
         