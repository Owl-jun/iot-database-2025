-- 아래 SELECT 문 들을 하나씩 실행(Ctrl + ENTER) 해보면서 DB의 구조를 파악해보자.
-- Customer 와 Product 에 있는 속성 중 created_at  timestamp 는 정보가 입력 되었을 때 시간을 자동으로 입력해주는 기능입니다. 굳이 사용자가 넣지 않아도 됨.
SELECT * FROM Customer;
SELECT * FROM OrderDetails;
SELECT * FROM Orders;
SELECT * FROM Product;

-- 1. Customer 테이블에 본인의 정보를 담은 값을 추가해보세요.
-- Tip. DML , INSERT 문 활용하기
-- 결과는 SELECT * FROM Customer; 실행해서 확인하자

-- 2. Customer 테이블에 한번에 2개 이상의 값을 추가해보세요.
-- 결과는 SELECT * FROM Customer; 실행해서 확인하자

-- 3. Customer 테이블의 PK 값이 4인 데이터의 이름을 '강황' 으로 변경해주세요.
-- Tip. DML , UPDATE 문 활용하기
-- 결과는 SELECT * FROM Customer; 실행해서 확인하자

-- 4. Customer 테이블에서, 주소가 부산시 인 유저의 이름과 전화번호, 주소를 보여주세요.
-- Tip. DML , SELECT 문
-- 결과 : name : 이영희 | phone : 010-9876-5432 | 부산시 어쩌구저쩌구  만약 본인이 부산에 거주중이라면 1번 문제에서 INSERT 된 값도 나오는게 정상

-- 몸풀기 완료.
-- 생각하는 문제 3개 갑니다.

-- 5. OrderDetails 테이블과 Product 테이블을 활용해서 카테고리가 '전자기기' 인 상품이 몇개 팔렸는지 계산하세요.
-- Tip. JOIN 혹은 FROM & WHERE 절로 테이블 두개를 합친 후 COUNT 집계함수를 활용해보자.
-- 어려울 수 있다, 하지만 고통스러워도 견뎌라, 머리 안 쓰는 문제만 풀면 머리 안 쓰는 일만 한다.
-- 결과 : category : 전자기기 | 개수 : 2


-- 6. Product 테이블을 활용하여 카테고리 별 제품의 개수와, 합산된 가격을 표시해주세요.
-- Tip. GROUP BY와 집계함수 활용하기
-- 결과 : category : 전자기기, 액세서리, 가구 | 제품개수 : 2, 1, 2 | 합산금액 : 2100000.00 , 150000.00 , 420000.00


-- 7. Customer , Orders , OrderDetails 테이블을 활용해서, 주문한 고객들의 이름과 고객 별 주문 횟 수를 출력해주세요.
-- Tip. JOIN , GROUP BY , COUNT 활용하는 문제
-- 결과 : 이름 : 김철수, 이영희 | 주문횟수 : 2, 1



