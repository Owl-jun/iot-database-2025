-- 데이터베이스 생성
CREATE DATABASE sample;

-- 데이터베이스 생성(CharSet, Collation 지정)
CREATE DATABASE sample2
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- 데이터베이스 변경 
ALTER DATABASE sample
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- 데이터베이스 삭제
-- 운영DB에서 실행하면 퇴사각
DROP DATABASE sample;
DROP DATABASE sample2;

-- 테이블 생성 
CREATE TABLE NewBook
		(	
			bookid		INTEGER			-- PRIMARY KEY
    , bookname 	VARCHAR(255)
    , publisher	VARCHAR(255)
    , price			INTEGER
    , PRIMARY KEY (bookid)
    -- PRIMARY KEY (bookname, publisher) 복합키설정
    );
	
DROP TABLE NewBook;
-- 테이블 생성시, 제약조건을 추가가능
-- bookname은 NULL을 가질 수 없고, publisher는 같은 값이 있으면 안됨.
-- price는 값이 입력되지 않은 경우 기본값이 10000을 저장
-- 최소가격은 1000원 이상으로 한다.
CREATE TABLE NewBook
		(	
			bookid		INTEGER		 -- PRIMARY KEY
    , bookname 	VARCHAR(255)	NOT NULL
    , publisher	VARCHAR(255)  UNIQUE
    , price			INTEGER				DEFAULT 10000 CHECK(price >= 1000)
    , PRIMARY KEY (bookid)
    -- PRIMARY KEY (bookname, publisher) 복합키설정
    );
    
    
-- 3-35
CREATE TABLE NewCustomer (
		custid			INTEGER				PRIMARY KEY
	 ,name				VARCHAR(100)	NOT NULL
	 ,address			VARCHAR(255)	NOT NULL
   ,phone				VARCHAR(30)		NOT NULL
);

-- 3-36
CREATE TABLE NewOrders (
		orderid			INTEGER 			PRIMARY KEY
	, custid			INTEGER				NOT NULL
  , bookid			INTEGER				NOT NULL
  , saleprice		INTEGER				
  , orderdate		DATE
  ,	FOREIGN KEY(custid) REFERENCES NewCustomer(custid) ON DELETE CASCADE
  ,	FOREIGN KEY(bookid) REFERENCES NewBook(bookid) ON DELETE CASCADE
);



-- ALTER
-- 이미 존재하는 컬럼은 MODIFY , 삭제시 DROP , 추가 : ADD
-- NewBook 테이블에 varchar(13)의 isbn 속성을 추가하시오
ALTER TABLE NewBook ADD isbn VARCHAR(13);
ALTER TABLE NewBook MODIFY isbn INTEGER;
ALTER TABLE NewBook DROP isbn;
ALTER TABLE NewBook MODIFY bookname VARCHAR(255) NOT NULL;
-- ALTER TABLE NewBook ADD PRIMARY KEY(bookid);


-- DROP (조심, 조심)
-- 3-42 NewBook 테이블 삭제하시오.
-- 관계에서 부모테이블은 자식테이블을 지우기전에 삭제할 수 없음.
DROP TABLE NewOrders;
DROP TABLE NewBook;




