-- 5-2 동일 도서를 파악 후 있으면 도서가격 변경, 없으면 삽입하는 프로시저

DELIMITER ^^

CREATE PROCEDURE BookInsertOrUpdate
(
	mybookid	INT,
    mybookname	VARCHAR(40),
    mypublisher	VARCHAR(40),
    myprice		INT
)
BEGIN
	DECLARE myCount INT;	
    SELECT COUNT(*) INTO myCount FROM Book
		WHERE bookname = mybookname;
        
	IF myCount != 0 THEN
        UPDATE Book SET price = myprice
			WHERE bookname = mybookname;
            
            IF myCount > 0 THEN
				SET myCount = myCount -1;
			END IF;
            
	ELSE
		INSERT INTO Book(bookid,bookname,publisher,price)
			VALUES(mybookid,mybookname,mypublisher,myprice);
            
	END IF;
END;
^^

DELIMITER ;

SET SQL_SAFE_UPDATES = 0;
CALL BookInsertOrUpdate(50,'뉴비','공학',97500);
CALL BookInsertOrUpdate(13,'기타교본1','지미핸드릭스',97500);
SELECT * FROM Book;