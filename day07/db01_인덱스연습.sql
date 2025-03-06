-- 기존테이블 삭제
drop table if exists NewBook;

-- 테이블 생성
create table NewBook (
	bookid INT AUTO_INCREMENT primary key,
    bookname varchar(100),
    publisher varchar(100),
    price INT
);

-- 500만건 더미데이터 생성
set session cte_max_recursion_depth = 5000000;

-- 더미데이터 생성
insert into NewBook (bookname,publisher,price)
with recursive cte(n) as 
(
	SELECT 1
    UNION ALL
    SELECT n+1 from cte where n < 5000000
)
select 	concat('Book', lpad(n, 7, '0'))
	 , 	concat('Company', lpad(n,7,'0'))
     ,  floor(3000 + rand() * 30000) as price
from 	cte;


SELECT COUNT(*) FROM NewBook;
SELECT * FROM NewBook;


-- 가격을 7개 정도 검색할 수 있는 쿼리 작성
select * from NewBook
 where price in (8377,14567,24500,33000,5600,6700,15000);
 

-- 인덱스 생성
create index idx_book on NewBook(price);
