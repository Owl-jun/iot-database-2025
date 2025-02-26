-- 그룹화 GROUP BY 키워드 사용
-- 3-19 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오.
SELECT 
    custid
    , COUNT(*) as 구매도서수량
    , SUM(saleprice) as 고객별총액
FROM
    Orders
GROUP BY custid
ORDER BY 3 DESC;
		
-- 추가
SELECT 
    custid
    , COUNT(*) as 구매도서수량
    , SUM(saleprice) as 고객별총액
FROM
    Orders
GROUP BY custid
with rollup;

-- 조인 : 두개 이상의 테이블을 합쳐서 출력
-- 3-21 : 고객과 고객의 주문에 관한 데이터를 모두 나타내시오.

SELECT *
FROM  Customer
INNER JOIN Orders 
ON Orders.custid = Customer.custid;

-- 추가
SELECT *
  FROM Customer, Orders
 WHERE Customer.custid = Orders.custid;
 
-- 중복되거나 필요없는 컬럼은 제거하고 출력
SELECT c.custid
	,  c.name
    ,  c.address
    ,  o.orderid
    ,  o.saleprice
    ,  o.orderdate
  FROM Customer AS c
 INNER JOIN Orders AS o
	ON o.custid = c.custid;
    
-- 필요하면 테이블 조인하면 됨    
SELECT c.custid
	,  c.name
    ,  c.address
    ,  o.orderid
    ,  o.saleprice
    ,  o.orderdate
    ,  b.bookname
  FROM Customer AS c
 INNER JOIN Orders AS o 
	ON o.custid = c.custid 
 INNER JOIN Book AS b
	ON b.bookid = o.bookid;
    
    
-- 3-23 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
SELECT 
    c.name, o.saleprice
FROM
    Customer AS c,
    Orders AS o
WHERE
    c.custid = o.custid;
    
-- 3-24 고객별로 주문한 모든 도서의 총판매액을 구하고, 고객별로 정렬하시오.
SELECT 
    c.name, SUM(o.saleprice)
FROM
    Customer AS c,
    Orders AS o
WHERE
    c.custid = o.custid
GROUP BY c.name
ORDER BY c.name;

-- 3-25 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
SELECT 
    c.name, b.bookname
FROM
    Customer AS c,
    Orders AS o,
    Book AS b
WHERE
    c.custid = o.custid
        AND o.bookid = b.bookid;
        
-- 3-26 가격이 20000원인 도서를 주문한 고객의 이름과, 도서의 이름을 구하시오.

SELECT c.name , b.bookname
FROM Customer AS c
INNER JOIN Orders as o 	ON c.custid = o.custid
INNER JOIN Book as b 	ON b.bookid = o.bookid
WHERE o.saleprice = 20000;
        
-- 외부조인 : 조건을 만족하지 않는(일치하지 않는) 데이터도 출력이 필요할 때 사용하는 조인
-- 3-27 도서를 구매하지 않은 고객을 포함해 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오.
-- LEFT OUTER JOIN 또는 RIGHT OUTER JOIN - LEFT, RIGHT 는 기준이 되는 테이블 위치
SELECT 
    *
FROM
    Customer,
    Orders;


SELECT 
    c.name, saleprice
FROM
    Customer AS c
        LEFT OUTER JOIN
    Orders AS o ON c.custid = o.custid;


-- 서브쿼리 (부속질의)
SELECT bookname
  FROM Book
 WHERE price = (SELECT MAX(price) FROM Book);
 
SELECT name
  FROM Customer
 WHERE custid in (SELECT custid FROM Orders);
 
SELECT name
FROM Customer
WHERE custid IN (SELECT custid
					FROM Orders
                    WHERE bookid IN 
						(SELECT bookid
						FROM Book
						WHERE publisher = '대한미디어'));
                        
-- 상관 서브쿼리.
SELECT b.bookname
FROM Book b
WHERE b.price > (SELECT AVG(price) from Book b2 where b.publisher = b2.publisher);

SELECT b.bookname
FROM Book b
JOIN (
    SELECT publisher, AVG(price) AS avg_price
    FROM Book
    GROUP BY publisher
) AS avg_table ON b.publisher = avg_table.publisher
WHERE b.price > avg_table.avg_price;

-- 중복 제거
SELECT name
FROM Customer
WHERE address LIKE '대한민국%'
UNION
SELECT name
FROM Customer
WHERE custid IN (SELECT custid FROM Orders);

-- 중복 포함
SELECT name
FROM Customer
WHERE address LIKE '대한민국%'
UNION ALL
SELECT name
FROM Customer
WHERE custid IN (SELECT custid FROM Orders);


-- EXISTS : 상광 서브쿼리에서 사용하는 키워드
-- 주문이 있는 고객의 이름과 주소를 나타내시오.

SELECT name, address
FROM Customer as c
WHERE EXISTS (SELECT * FROM Orders o WHERE c.custid = o.custid);
