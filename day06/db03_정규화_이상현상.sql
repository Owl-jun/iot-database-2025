use madangUniv;
use madang;

CREATE TABLE Summer(
	sid	INT ,
    class VARCHAR(20),
    price INT
);

INSERT INTO Summer 
VALUES	(100, 'JAVA',20000),
		(150,'PYTHON',15000),
        (200,'C',10000),
        (250,'JAVA',20000);
        
SELECT * FROM Summer;

ALTER TABLE Summer 
DROP PRIMARY KEY;

SET SQL_SAFE_UPDATES=1;

DELETE 
  FROM Summer
 WHERE class = 'C++';

INSERT INTO Summer
VALUES (200,'C',10000);

SELECT COUNT(COALESCE(sid))
  FROM Summer;


INSERT INTO Summer VALUES (NULL,'C++', 25000);

UPDATE Summer
   SET price = 20000
 WHERE class = 'JAVA';
 
SELECT DISTINCT(class) , price
FROM Summer;