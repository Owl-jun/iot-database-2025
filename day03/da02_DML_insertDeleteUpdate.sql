-- INSERT 짝꿍 : INTO , VALUES
-- 3-44 Book 테이블에 '스포츠 의학' 도서를 추가하세요. 한솔의학서적에서 출간, 가격은 90000원이다.
INSERT INTO Book (bookid,bookname,publisher,price) VALUES (11,'스포츠 의학','한속의학서적',90000);
INSERT INTO Book VALUES (12,'스포츠 의학','한속의학서적',90000);

-- 3-45 다중 데이터 입력
INSERT INTO Book
VALUES 	(13, '기타교본1', '지미핸드릭스', 45000),
		(14, '기타교본2', '지미핸드릭스', 45000),
		(15, '기타교본3', '지미핸드릭스', 45000);

-- 3-46	테이블 하나 통으로 삽입하기
INSERT INTO Book SELECT * FROM Imported_Book;

-- 테이블의 INDEX 값 자동으로 증가하도록 만드려면
CREATE TABLE NewBook(
	 bookid 	INTEGER 		PRIMARY KEY 	auto_increment
    ,bookname 	VARCHAR(255)	NOT NULL
    ,publisher 	VARCHAR(255) 	NOT NULL
    ,price		INTEGER			
);
INSERT INTO NewBook (bookname,publisher,price) VALUES ('마몽','누리마루',3500);
INSERT INTO NewBook VALUES (4,'마몽','누리마루',3500);

INSERT INTO NewBook (bookname,publisher,price) 
VALUES 	('가몽','누리마루',3500),
		('다몽','누리자루',3500),
		('라몽','누리마루',3500),
		('바몽','누리마루',3500);

DELETE FROM NewBook WHERE bookid = 4;
-- PK 자동증가는 편리함, 단, 지워진 PK를 다시 쓸 수 없음, 그리고 직접 할당을 했다면, 그 번호 뒤의 숫자부터 올라감

-- UPDATE 짝꿍 : SET

UPDATE 	Customer
SET		address = '대한민국 부산'
WHERE	custid = 5;

UPDATE 	Book
SET		publisher = (SELECT publisher FROM Imported_Book WHERE bookid = 21)
WHERE 	bookid = 14;

-- 추가. 데이터 수정시 조심할 것!
SELECT  *
FROM	NewBook;

-- WHERE 절 없이 업데이트 할 생각도 하지 말 것 .
UPDATE 	NewBook
SET		price = 80000;
-- WHERE 	bookid = 3  기본키 값을 where 절에 넣지않으면 수정 못하게 safe모드 걸림.


-- DELETE
-- DELETE FROM 테이블 명
-- WHERE 검색조건

select * from Customer;
select * from Book;