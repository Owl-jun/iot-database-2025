-- 내장함수
-- 4-1
-- -78 과 78의 절대값을 구하시오
SELECT ABS(-78), ABS(78);

-- 4-2
-- 4.875를 소수 첫째 자리까지 반올림한 값을 구하시오
SELECT ROUND(4.875,1);

-- 4-3
-- 고객별 평균 주문금액을 100원 단위로 반올림한 값을 구하시오.
SELECT custid '고객번호', ROUND(SUM(saleprice)/COUNT(*),-2) '평균금액'
FROM Orders
GROUP BY custid;

-- 문자열 내장함수
-- 4-4
SELECT bookid, REPLACE(bookname, '야구', '농구') bookname, publisher, price FROM Book;

-- 추가
SELECT concat('HELLO','MySQL');

-- 4-5
SELECT bookname '제목', CHAR_LENGTH(bookname) '문자수' , LENGTH(bookname) '바이트 수' FROM Book WHERE publisher = '굿스포츠';

-- 4-6 DB는 인덱스 1부터 시작 !!
SELECT SUBSTR(name,1,1) '성' , COUNT(*) '인원'
FROM Customer
GROUP BY SUBSTR(name,1,1);

-- 추가 trim
SELECT CONCAT('-',TRIM('     HELLO!     '),'-');
SELECT CONCAT('-',LTRIM('     HELLO!     '),'-');
SELECT CONCAT('-',RTRIM('     HELLO!     '),'-');
SELECT TRIM('=' FROM '==AA==');

-- 4-7
SELECT orderid '주문번호', orderdate '주문일', ADDDATE(orderdate, INTERVAL 10 DAY) '확정'
FROM Orders;

SELECT SYSDATE(), DATE_FORMAT(SYSDATE(), '%Y%m%d:%H%i%s');

-- D-DAY
SELECT DATEDIFF(SYSDATE(), '2025-02-03');

-- Formatting , 1000 단위 마다 , 넣기
SELECT  bookid, FORMAT(price,0) AS price
FROM	MyBook;

-- 4-8
SELECT orderid '주문번호', DATE_FORMAT(orderdate,'%Y-%m-%d') '주문일' , custid '고객번호' , bookid '도서번호'
FROM Orders
WHERE orderdate = STR_TO_DATE('20140707','%Y%m%d');


-- NULL = Python None 동일. 모든 다른 프로그래밍 언어에서는 전부 NULL, NUL
-- 추가. 금액이 NULL 일 때 발생되는 현상

SELECT 	price
FROM	MyBook
WHERE bookid = 3;


-- 핵심. 집계함수가 다 꼬임
SELECT 	 SUM(price) AS '합산은 문제없음'
		,AVG(price) AS '평균이 NULL값이 빠져서 꼬임'
        ,COUNT(price) AS	'NULL이 빠져 2가 됨'
        ,COUNT(*)	AS '3이나옴'
FROM	MyBook;
-- WHERE 	price IS NOT NULL; < NULL 값 피하기


-- NULL값 확인. NULL은 비교연산자 사용불가
-- IS 키워드 사용
SELECT 	*
FROM	MyBook
WHERE 	price IS NOT NULL;