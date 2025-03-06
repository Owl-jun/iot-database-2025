-- 데이터베이스 관리
SHOW DATABASES;

-- INFORMATION_SCHEMA, PERFORMANCE_SCHEMA, MYSQL 등은 시스템 DB 라서 개발자,DBA 사용하는게 아님
USE mysql;

-- 하나의 DB내 존재하는 테이블들 확인
SHOW TABLES;

-- 테이블의 구조
DESC madang.NewBook;

SELECT * FROM Vorders;

-- 사용자 추가
-- madang 데이터베이스만 접근할 수 있는 사용자 madang 생성
-- 내부접속용
CREATE USER madang@localhost IDENTIFIED BY 'madang';
-- 외부 접속용
CREATE USER madang@'%' IDENTIFIED BY 'madang';

-- DCL : grant, revoke
grant all privileges on madang.* to madang@localhost with grant option;
grant all privileges on madang.* to madang@'%' with grant option;
flush PRIVILEGES;

-- 권한해제
-- madang 사용자의 권한중 select 권한만 제거
revoke select on madang.* from madang@localhost;

REVOKE ALL PRIVILEGES ON madang.* FROM 'madang'@'%';

