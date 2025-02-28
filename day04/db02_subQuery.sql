-- 서브쿼리 고급

-- 4-12 Orders 테이블 평균 주문금액 이하의 주문에 대해 주문번호와 금액을 나타내시오.
-- 집계함수는 GROUP BY가 없어도 테이블 전체를 집계할 수 있음

SELECT *
  FROM Orders
 WHERE saleprice <= (SELECT AVG(saleprice) FROM Orders);

-- 4-13 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 금액을 나타내시오.

SELECT * FROM Orders;

SELECT orderid, custid, saleprice
  FROM Orders o1
 WHERE saleprice > (SELECT AVG(saleprice) FROM Orders o2 WHERE o1.custid = o2.custid);
 
-- 4-14 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
SELECT * FROM Customer;

SELECT sum(o.saleprice) total
  FROM Orders o
  JOIN Customer c ON o.custid = c.custid
 WHERE c.address LIKE '대한민국%';
 
SELECT SUM(saleprice) 'total'
  FROM Orders
 WHERE custid IN ( SELECT custid
					 FROM Customer
					WHERE address LIKE '대한민국%');
                    
-- 4-15 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 판매금액을 보이시오.
-- 비교연산자만 쓰면 서브쿼리의 값이 단일값이 되어야 함(제약사항)
SELECT orderid, saleprice
  FROM Orders
 WHERE saleprice > (SELECT MAX(saleprice) FROM Orders WHERE custid = 3);
 
 -- ALL 사용 시 단일 값이 아니어도 됨.
 SELECT orderid, saleprice
  FROM Orders
 WHERE saleprice > ALL (SELECT saleprice FROM Orders WHERE custid = 3);
 
-- 4-16 EXISTS 연산자를 사용하여 대한민국에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오.
SELECT sum(saleprice) total
  FROM Orders o
 WHERE EXISTS (SELECT * FROM Customer c WHERE address LIKE '대한민국%' AND c.custid = o.custid);
 
-- 추가 , 최신방법( 서브쿼리에서 두가지 컬럼을 비교하는 법 ) - 튜플(파이썬과 동일)
SELECT *
  FROM Orders
 WHERE (custid, orderid) IN (SELECT custid, orderid FROM Orders WHERE custid = 2);
 
 
-- SELECT 서브쿼리
-- 4-17 마당서점의 고객별 판매액을 나타내시오(고객이름과 고객별 판매액 출력).
SELECT (SELECT name FROM Customer WHERE Customer.custid = Orders.custid) name, sum(saleprice) total
  FROM Orders
 GROUP BY custid;


-- ALTER TABLE Orders ADD bname VARCHAR(100); 
-- 4-18 Orders 테이블에 각 주문에 맞는 도서이름을 입력하시오.
SELECT *
  FROM Orders;

UPDATE Orders
   SET bname = (SELECT bookname FROM Book WHERE Book.bookid = Orders.bookid)
 WHERE Orders.bookid;

-- FROM절 서브쿼리, 인라인 뷰
-- 4-19 고객번호가 2이하인 고객의 판매액을 나타내시오(고객이름, 고객별 판매액 출력)
SELECT cs.name, SUM(Orders.saleprice) total
  FROM Orders, (SELECT custid
					 , name
				  FROM Customer
				 WHERE custid <= 2) AS cs
 WHERE Orders.custid = cs.custid
 GROUP BY cs.name;
 
