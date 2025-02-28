
DELIMITER $$

CREATE PROCEDURE InsertBook
(
    IN mybookid    INTEGER,
    IN mybookname  VARCHAR(40),
    IN mypublisher VARCHAR(40),
    IN myprice     INTEGER
)
BEGIN
    INSERT INTO BookBook(bookid, bookname, publisher, price)
    VALUES (mybookid, mybookname, mypublisher, myprice);
END $$

DELIMITER ;


CALL InsertBook(23,'스포츠과학','마당과학서적',25000);
SELECT * FROM Book;



