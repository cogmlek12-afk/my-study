-- 1. 새로운 사용자 계정(KH) 생성 (비밀번호: KH)
CREATE USER C##TEST IDENTIFIED BY TEST;

-- 2. 접속 및 데이터 관리를 위한 기본 권한(롤) 부여
GRANT RESOURCE, CONNECT TO C##TEST;

-- 3. 테이블스페이스 무제한 권한 부여 (데이터 입력 에러 방지)
ALTER USER C##TEST DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;