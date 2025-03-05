-- 트랜잭션
START TRANSACTION;

INSERT INTO Book VALUES (99, '데이터베이스', '한빛', 25000);

SELECT bookname AS 'bookname1'
  FROM Book
 WHERE bookid = 99;
SAVEPOINT a;

UPDATE Book SET
	   bookname ='데이터베이스 개론'
 WHERE bookid = 99;
 
SELECT bookname AS 'bookname2'
  FROM Book
 WHERE bookid = 99;
SAVEPOINT b;