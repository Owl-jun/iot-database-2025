
CREATE TABLE Bank (
	name VARCHAR(40) PRIMARY KEY,
    balance INTEGER
);

INSERT INTO Bank VALUES ('박지성', 1000000), ('김연아',1000000);

SELECT * FROM Bank;

-- ------------------------------------------------
START TRANSACTION;

SELECT * FROM Bank WHERE name = '박지성';
SELECT * FROM Bank WHERE name = '김연아';

UPDATE Bank SET balance = balance - 10000 WHERE name = '박지성';
UPDATE Bank SET balance = balance + 10000 WHERE name = '김연아';

COMMIT;
ROLLBACK;
-- ------------------------------------------------