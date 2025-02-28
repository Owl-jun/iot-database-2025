-- 인덱스
-- DDL로 인덱스 생성
-- Book테이블의 bookname에 인덱스 ix_Book을 생성하시오.

CREATE INDEX ix_Book ON Book(bookname);
CREATE INDEX ix_Book2 ON Book(publisher, price);

SHOW INDEX FROM Book;

-- 실행계획(Explain Current Statement) - 인덱스나 조인 등에서 쿼리중 어디에서 가장 처리비용이 많이 발생하는지 체크
SELECT * FROM Book WHERE publisher = '대한미디어' AND price >= 30000;

-- 인덱스 최적화
ANALYZE TABLE Book;

-- 삭제
DROP INDEX ix_Book ON Book;