-- SELECT * -- ALL 이라고 부름, 모든 컬럼을 지칭
SELECT *
  FROM Book
 WHERE price between 10000 and 20000; -- ;은 생략가능. C,Python 같은 코드로 가져갈때는 반드시 삭제!

-- 워크벤치에서 쿼리 실행할 땐 편함 
SELECT *
  FROM Book;
  
-- 프로그래밍 언어로 가져갈 땐, 컬럼이름 컬럼갯수를 모두 파악해야 하기 때문에 아래처럼 사용
SELECT bookid, bookname, publisher, price
  FROM Book;
  
  
-- 중복제거하여 출력 Keyword : DISTINCT
SELECT DISTINCT publisher
  FROM Book;
  
-- 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색하시오
SELECT *
  FROM Book
 WHERE publisher = '굿스포츠' or publisher = '대한미디어';
 
-- LIKE , NOTLIKE
-- % : 0 이상
-- _ : 1개의 자리 대체
-- [] : 괄호안의 문자 한칸 
-- ex ) [A] = A 를 찾는 조건
-- ex ) [A-C]_ = A,B,C 중하나 + 한칸
-- ex ) [A-C]% = A~C 중하나로 시작하는 문자열
-- [^], [!] 위의 반대
-- 그러나 MySQL 은 [] 집합을 지원하지않기에, 정규표현식 사용할 것
-- %A% : 어느 문자열에 A가 포함되는지   


-- 도서 이름의 왼쪽 두 번째 위치에 '구'라는 문자열을 갖는 도서를 검색하세요.
-- 와일드카드 LIKE
SELECT *
  FROM Book
 WHERE bookname LIKE '_구%';
 
-- REGEXP 사용 , 그냥 정규표현식임
SELECT *
  FROM Book
 WHERE bookname REGEXP '^.{1}[구].*'; 
 
 
-- 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오.
SELECT *
  FROM Book
 WHERE bookname REGEXP '.*축구.*' AND price >= 20000;
 

-- 도서를 이름순으로 검색하시오.
SELECT *
  FROM Book
ORDER BY bookname;	-- 우선순위는 먼저 쓴놈 부터

SELECT *
  FROM Book
ORDER BY price DESC,bookname ASC;	-- DESC 내림차순 , ASC 오름차순 (디폴트)

-- 집계함수

-- 고객이 주문한 도서의 총판매액, 평균값, 최저가, 최고가를 구하시오.
SELECT 
	SUM(saleprice) as '총판매액',
    AVG(saleprice) as '평균값',
    MIN(saleprice) as '최저가',
    MAX(saleprice) as '최고가'
FROM
	Orders;

-- GROUP BY
SELECT custid, COUNT(*) as 도서수량, sum(saleprice)
from Orders
group by custid;


-- 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오.
SELECT custid, COUNT(*) as '총 수량', SUM(saleprice) as '총 판매액'
FROM Orders
GROUP BY custid;

-- 가격이 8000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오.
-- 단, 2권 이상 구매한 고객에 대해서만 구하시오.
SELECT custid , COUNT(*)
FROM Orders
WHERE saleprice >= 8000
GROUP BY custid
HAVING COUNT(*) >= 2;


-- 조인

