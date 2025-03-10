create table students (
        std_id int primary key auto_increment,
        std_name varchar(100) not null,
        std_mobile varchar(20) null,
        std_regyear date not null
    );
    
alter table students
modify std_regyear int not null;

-- 더미데이터 추가
insert into students (std_name, std_mobile, std_regyear)
values ('홍길동','010-9999-8888',2020);

INSERT INTO students (std_name, std_mobile, std_regyear)
SELECT 
    CONCAT('학생', FLOOR(RAND() * 100000)),  -- 랜덤한 이름
    CONCAT('010-', LPAD(FLOOR(RAND() * 10000), 4, '0'), '-', LPAD(FLOOR(RAND() * 10000), 4, '0')), -- 랜덤한 전화번호
    FLOOR(2020 + RAND() * 5)  -- 2020~2024 사이의 랜덤한 학번
FROM 
    (SELECT 1 FROM information_schema.tables LIMIT 10000) AS tmp;
    
