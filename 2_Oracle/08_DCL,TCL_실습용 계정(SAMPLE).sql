








 CREATE TABLE TEST (
 TEST_ID NUMBER,
 TEST_NAME VARCHAR2 (10)
 );
 
 --> 접속은 됐는데 테이블 생성권한은 불충분해서 오류뜸
 --> 샘플계정에 CREATE 테이블 권한 부여해야댕
 
SELECT * FROM TEST;

INSERT INTO TEST (TEST_ID, TEST_NAME)
VALUES  (10,'채희');
COMMIT;