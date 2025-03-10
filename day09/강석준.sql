
select * from bookstbl;
select * from divtbl;
select * from membertbl;
select * from rentaltbl;

/* 
1. 회원 테이블에서 이메일, 모바일, 이름, 주소 순으로 나오도록 검색하시오.
(결과는 아래와 동일하게 나와야 하며, 전체 행의 개수는 31개입니다)
*/

SELECT Email email
	 , Mobile mobile
     , Names names
     , Addr addr
  FROM membertbl;


/*
2. 함수를 사용하여 아래와 같은 결과가 나오도록 쿼리를 작성하시오.
(전채 행의 개수는 59개입니다)
*/

SELECT Names 도서명, Author 저자, ISBN, Price 정가
  FROM bookstbl
 ORDER BY ISBN;
  
  
/*
3. 다음과 같은 결과가 나오도록 SQL 문을 작성하시오.
(책을 한번도 빌린적이 없는 회원을 뜻합니다. 18명이 나옵니다.)
*/
select * from membertbl;
select * from rentaltbl;

SELECT m.Names 비대여자명, m.Levels 등급, m.Addr 주소, r.rentalDate 대여일
  FROM membertbl m
  LEFT JOIN rentaltbl r
    ON m.Idx = r.memberIdx
 WHERE r.memberIdx IS NULL
 ORDER BY Levels , m.Names;
 
 
 /*
 4. 다음과 같은 결과가 나오도록 SQL 문을 작성하시오.
 */
select * from bookstbl;
select * from divtbl;

SELECT COALESCE(d.Names,'--합계--') 장르 , CONCAT(FORMAT(SUM(b.price),0),'원') 총합계금액
  FROM bookstbl b
  JOIN divtbl d
    ON b.Division = d.Division
 GROUP BY d.Names WITH ROLLUP;
 
 
 

 