-- 뷰
-- DDL CREATE로 뷰 생성

CREATE VIEW Vorders
AS SELECT 	orderid, O.custid, name, O.bookid, bookname, saleprice, orderdate
	FROM	Customer C, Orders O, Book B
    WHERE	C.custid = O.custid AND B.bookid = O.bookid;
    
SELECT * FROM Vorders;


-- 4-20
-- 주소에 대한민국을 포함하는 고객들로 구성된 뷰를 만들고 조회하시오. 뷰의 이름은 vw_Customer로 설정하시오

CREATE OR REPLACE VIEW vw_Customer
AS SELECT	*
	FROM 	Customer
    WHERE 	address LIKE '%대한민국%';

SELECT * FROM vw_Customer;
SELECT * FROM Customer;

-- 추가, 뷰로 insert할 수 있는지
-- 단일 테이블이면 가능, 조인된 테이블이면 불가
INSERT INTO vw_Customer
VALUES (7, '손흥민', ' 런던', '010-9999-0099');

-- 뷰의 수정
CREATE OR REPLACE VIEW vw_Customer (custid, name, address)
AS SELECT custid, name, address
	FROM	Customer
    WHERE	address LIKE '%영국%';



