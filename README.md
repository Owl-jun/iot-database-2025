# iot-database-2025
IoT 개발자 데이터베이스 저장소

## 1일차
- 데이터베이스 시스템
    - 통합된 데이터를 저장해서 운영하면서, 동시에 여러사람이 사용할 수 있도록 하는 시스템
    - 실시간 접근, 계속 변경, 동시 공유가 가능, 내용으로 참조(물리적으로 떨어져 있어도 사용가능)

    - DBMS : SQL Server , Oracle , MySQL , MariaDB , MongoDB .....

- 데이터베이스 언어
    - **SQL (Structured Query Language)**:  
        데이터베이스와 상호작용하기 위한 **표준 언어**.  
        주로 **데이터 정의, 조작, 제어**를 위해 사용합니다.  

    - **DDL (Data Definition Language)**:  
        **스키마 정의 및 구조 변경**을 담당.  
      - 예시: `CREATE`, `ALTER`, `DROP`, `TRUNCATE`  

    - **DML (Data Manipulation Language)**:  
        **데이터(인스턴스)를 검색, 삽입, 수정, 삭제**하는 언어.  
      - 예시: `SELECT`, `INSERT`, `UPDATE`, `DELETE`  

    - **DCL (Data Control Language)**:  
        **사용자 권한 및 접근 제어**를 담당.  
      - 예시: `GRANT`, `REVOKE`  


- MySQL 설치(Docker)
    1. 파워쉘을 오픈, 도커 확인
        ```shell
        > docker -v
        Docker version 27.5.1, build 9f9e405
        ```
    2. MySQL Docker 이미지 다운로드
        ```shell
        > docker pull mysql
        Using default tag: latest
        latest: Pulling from library/mysql
        893b018337e2: Download complete
        43759093d4f6: Downloading [============================>                      ]  28.31MB/49.09MB
        cc9646b08259: Downloading [========>                                          ]  22.02MB/135.7MB
        df1ba1ac457a: Download complete
        277ab5f6ddde: Downloading [=========>                                         ]  9.437MB/48.42MB
        ...
        Status: Downloaded newer image for mysql:latest
        docker.io/library/mysql:latest
        ```
    3. MySQL Image 확인
        ```shell
        > docker images
        REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
        mysql        latest    146682692a3a   4 weeks ago   1.09GB
        ```
    4. Docker 컨테이너 생성
        - MySQL Port번호 3306이 기본
        - Oracle Port 1521
        - SQL Server 1433
        ```shell
        > docker run --name mysql-container -e MYSQL_ROOT_PASSWORD=12345 -d -p 3306:3306 mysql:latest
        ```

        - 컴퓨터 재시작후 컨테이너 자동시작 옵션 명령어
        ```Shell
        > docker update --restart=always mysql-container
        ```
    5. 컨테이너 확인
        ```shell
        > docker ps -a
        CONTAINER ID   IMAGE          COMMAND                   CREATED          STATUS          PORTS
     NAMES
        6a8b5034cc90   mysql:latest   "docker-entrypoint.s…"   16 seconds ago   Up 15 seconds   0.0.0.0:3306->3306/tcp, 33060/tcp   mysql-container
        ```
    
    6. Docker 컨테이너 시작, 중지, 재시작
        ```shell
        > docker stop mysql-container       # 중지
        > docker start mysql-container      # 시작
        > docker restart mysql-container    # 재시작
        ```

    7. MySQL Docker 컨테이너 접속
        ```shell
        > docker exec -it mysql-container bash  # bash 리눅스의 powershell
        bash-5.1# mysql -u root -p
        Enter password:
        Welcome to the MySQL monitor.  Commands end with ; or \g.
        Your MySQL connection id is 9
        Server version: 9.2.0 MySQL Community Server - GPL

        Copyright (c) 2000, 2025, Oracle and/or its affiliates.

        Oracle is a registered trademark of Oracle Corporation and/or its
        affiliates. Other names may be trademarks of their respective
        owners.

        Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

        mysql> show databases;
        +--------------------+
        | Database           |
        +--------------------+
        | information_schema |
        | mysql              |
        | performance_schema |
        | sys                |
        +--------------------+
        4 rows in set (0.01 sec)
        ```

<img src='./img/db001.png' width = 550>

- Workbench 설치
    - https://dev.mysql.com/downloads/workbench/ MySQL Workbench 8.0.41 다운로드 설치
    - MySQL Installer에서 Workbench, Sample 만 설치

    - Workbench 실행 후
        1. MySQL Connections + 클릭

- 관계 데이터 모델
    - 3단계 DB 구조 : 외부 스키마(실세계와 매핑) -> 개념 스키마(DB논리적 설계) -> 내부 스키마(물리적 설계) -> DB

    - 모델에 쓰이는 용어
        - 릴레이션 : 테이블
        - 튜플 : 로우
        - 속성(어트리뷰트) : 컬럼
        - 스키마 : DB 구조
        - 인스턴스 : 스키마 구조를 따라 들어간 데이터(있을수도 있고 없을수도 있고)
        - 관계 : 릴레이션 간의 부모, 자식 연관

    - 무결성 제약조건
        - 키 : **기본키**, **외래키** ,슈퍼키
            - 기본키 : 후보키 중 선택된 키
            - 슈퍼키 : 최소성을 만족하지 못함.
        
        - 무결성 제약조건 3종 요약
            1. 🆔 **개체 무결성(Entity Integrity)**  
            - **기본키는 NULL과 중복을 허용하지 않는다!**  
            2. 🔗 **참조 무결성(Referential Integrity)**  
            - **외래키는 참조하는 기본키에 존재해야 한다!**  
            (존재하지 않는 값을 참조하면 안 됨)  
            3. 🎯 **도메인 무결성(Domain Integrity)**  
            - **컬럼 값은 지정된 데이터 타입과 제약조건을 지켜야 한다!**  


- SQL 기초
    - SQL 개요
    
    ```sql
    -- DML SELECT문
    SELECT publisher, price
      FROM Book
     WHERE bookname = '축구의 역사'; -- 주석입니다
    ```


## 2일차
- SQL 기초
    - 개요
        - 데이터베이스에 있는 데이터를 추출 및 처리작업을 위해서 사용되는 프로그래밍언어
        - 일반 프로그래밍언어와의 차이점
            - DB에서만 문제해결 가능
            - 입출력을 모두 DB에서 테이블로 처리
            - 컴파일 및 실행은 DBMS가 수행

        - DML(데이터 조작어) - 검색, 삽입, 수정, 삭제
            - SELECT, INSERT, UPDATE, DELETE
        - DDL(데이터 정의어)
            - CREATE, ALTER, DROP
        - DCL(데이터 제어어)
            - GRANT, REVOKE

    - DML 중 SELECT 만

        ```sql
         SELECT [ALL|DISTINCT] 컬럼명(들)
           FROM 테이블(들)
         (WHERE) 조건(들)
         (GROUP BY 속성이름(들))
        (HAVING 집계함수 조건(들))
         (ORDER BY 정렬기준(들) ASC|DESC)
          (WITH ROLLUP) : 누계 등 표시
        ```

    - 쿼리 연습 ~GROUP BY   : [MySQL](./day02/db01_select.sql)
    - 쿼리 연습  ~EXISTS    : [MySQL](./day02/db02_select_GroupBy.sql)


## 3일차
- Visual Studio Code 에서 MySQL 연동
    - Weijan Chen 개인개발자가 만든 MySQL 확장도 준수
    - Weijan Chen 이 개발한 Database Client를 설치(추천)
    - Database Client 는 많은 DB연결이 가능!
        - 데이터베이스 아이콘 생성
    - Oracle에서 개발한 MySQL Shell for VS Code를 사용 하지말것(너무 불편함)
    - Database Client
        1. 툴 바의 Database 아이콘 클릭
        2. Create Connection 클릭
        3. 정보 입력 > 연결 테스트
        <img src='./img/create.png' width = 600>
        4. Workbench 처럼 사용
        <img src='./img/da02.png' width = 600>

- SQL 기초
    - 기본 데이터형
        - 데이터베이스에는 엄청 많은 데이터형이 존재(데이터의 사이즈 저장용량을 절약하기 위해서)
        - 주요 데이터형
            - SmallInt(2)   : signed $2^{16}$
            - `Int(4)`       : signed $2^{32}$
            - BigInt(8)     : signed $2^{64}$
            - Float(4)      : 부동소수점 표현(소수점아래 7자리까지 저장)
            - Decimal(5~17) : Float보다 더 큰 수 저장시 사용
            - CHAR(n)       : 고정길이 문자형, n : (1~255)
                - 주의점! Char(10)에 'Hello' 글자를 입력하면 'Hello&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
            - VARCHAR(n)    : 가변길이 문자열, n : (1~65535)
                - 주의점! VARCHAR(10)에 'Hello' 글자를 입력하면 'Hello'
            - Longtext(최대4GB) - 뉴스나 영화스크립트 저장 시 사용
            - LongBlob(최대4GB) - mp3 , mp4 , 음악 , 영화데이터 자체 저장 시 사용
            - Date(3) - 2025-02-27(오늘날짜) 까지 저장하는 타입
            - DateTime(8) - 2025-02-27 10:46:34(오늘날짜 시간) 까지 저장하는 타입
            - JSON(8) - json 타입 데이터를 저장

    - DDL : CREATE

        ```sql
        CREATE DATABASE DB명
        CHARACTER SET utf8mb4
        COLLATE utf8mb4_unicode_ci;

        CREATE TABLE 테이블명
        (
            속성(컬럼)명 제약사항들[NOT NULL|UNIQUE|DEFAULT|CHECK|...]
            PRIMARY KEY(컬럼)
            FOREIGN KEY(컬럼) REFERENCES 테이블명(컬럼) ON DELETE [CASCADE|RESTRICE|SET..]
        );

        ALTER DATABASE DB명
        [변경사항]
        
        ALTER TABLE 테이블명 [이미 존재하는 컬럼은 MODIFY , 삭제시 DROP , 추가 : ADD]
        -- 예시
        ALTER TABLE NewBook ADD isbn VARCHAR(13);
        ALTER TABLE NewBook MODIFY isbn INTEGER;
        ALTER TABLE NewBook DROP isbn;
        ALTER TABLE NewBook MODIFY bookname VARCHAR(255) NOT NULL;

        DROP [TABLE|DATABASE] 객체명;
        ```

        - 테이블 생성 후 확인
            1. Database 메뉴 -> Reverse Engineer(Ctrl+R) : 데이터베이스를 ERD로 변경
            2. 연결은 패스
            3. Select Schema to RE 에서 특정 스키마를 선택
            4. Execute 버튼 클릭
            5. ERD 확인

            <img src='./img/da03.png' width= 600>

    - DDL : ALTER
    - DML 중 INSERT , UPDATE , DELETE
- SQL 고급
    - 내장 함수
        - 절대값 : ABS()
        - 반올림 : ROUND(숫자, 자리수)
        - 문자열치환 : REPLACE(테이블명,'타겟','바꿀문자열')
        - 바이트수 : LENGTH()
        - 문자수 : CHAR_LENGTH()
        - 문자열자르기 : SUBSTR(컬럼명,시작,끝) **시작인덱스 1**
        - 날짜형 관련
            - STR_TO_DATE(string,format) : 문자열데이터를 date형으로 반환
            - DATE_FORMAT(date,format) : 날짜형 데이터를 VARCHAR로 반환
            - ADDDATE(date,INTERVAL dd DAY) : 해당 날짜에서 인터벌만큼 지난 날짜반환
            - DATE(date) : date타입의 날짜부분만 반환 (년-월-일)
            - DATEDIFF(date1,date2) : date1 - date2 의 날짜 차이 (day)
            - SYSDATE() : DMBS 시스템상의 오늘 년월일시분초 반환
            - 날짜형 지정자
                - %Y(2025) %y(25) %M(January) %m(02) %d(날짜) %a(Sunday) %W(Sun) %w(sunday = 0)
                - %H(00~23) %h(01~12) %i(min) %s(second)

    - NULL
        - NULL 자체는 '' 이런것과 달리 아예 존재하지가 않기 때문에 다르다.
        - NULL + 숫자 = NULL
        - NULL 값은 집계함수를 사용자의 의도와 다르게 사용되게한다.
        - COUNT(), AVG() 등등에서 NULL 값은 집계되지 않아 꼬이는 일이 많다.
        - 그래서 IS NOT NULL , IS NULL 등을 활용하여 핸들링을 해줘야 한다.
        - IFNULL(컬럼, 값) : 컬럼의 값이 NULL이면, '값' 으로 대치한다.

## 4일차
- SQL 고급 
    - 행번호 출력 : [SQL](./day04/db01.sql)
         - LIMIT, OFFSET 잘 쓰면 필요없음
         - 행 번호가 필요한 경우도 있다.

- SubQuery 고급 : [SQL](./day04/db02_subQuery.sql)
    - Where 절 - 단일값(비교연산), 다중행(ALL|ANY|EXISTS|IN|NOT IN)
    - Select 절 - 무조건 스칼라값
    - From 절 - 인라인 뷰. 하나의 테이블처럼 사용 (가상테이블)

- SQL 고급
    - VIEW : [SQL](./day04/db03_View.sql)
        - 보여주고 싶은 부분만 가공해서 보여주려고 만든 VIEW
        - 인덱스 없음
        - 단일 테이블로 생성 시 수정이가능 (원본이 수정됨)
        - 조인과 같은 복합 테이블로 생성시 수정 불가
    
    - INDEX : [SQL](./day04/db04.sql)
        - 빠른 검색을 위해서 사용하는 개체
        - 클러스터 인덱스 : 주로 PK 이며 자동으로 생성된다.
        - 논클러스터 인덱스(보조) : 여러개를 생성가능하며 수동으로 생성해야한다. 생성시 자동으로 밸런스 트리구조로 생성된다.
        - 주의점
            - WHERE 절에 자주 사용하는 컬럼에 인덱스 생성
            - 조인문에 사용하는 컬럼에 생성
            - 테이블 당 인덱스 개수는 5개 미만이 효율적
            - 변경이 잦은 컬럼에는 생성하지 말자..
            - NULL 값이 많은 컬럼에도 생성하지 말자..!

- DB 프로그래밍
    - Procedure : [SQL](./day04/db06_procedure.sql)
        - 리턴값이 VOID 인 함수라고 생각하면 된다.
        - 파이썬 등 프로그래밍 언어에서 좀 더 편리하게 사용하기 위해 구현.
        - 개발 솔루션화, 구조화 해서 손쉽게 DB처리를 가능하게 하기 위해.
        - 예제 : [SQL](./day04/db07_Save_Procedure.sql)

## 5일차
- 데이터베이스 프로그래밍
    - 리턴문을 쓸 수 있으면 함수, 아니면 프로시져.
    - 프로시저에서도 값을 반환하려면 OUT 파라미터를 선언.
    - 저장 프로시저 계속
        - 결과를 반환하는 프로시저 (OUT 키워드를 통해 프로시져로 값을 반환할 수 있음)
        - 커서사용 프로시저 (반복문의 한 동작을 담는 녀석)

    - 트리거
        - INSERT UPDATE DELETE 시 발동되는 트리거

    - 사용자 정의 함수
        - 리턴 키워드 사용

- 데이터베이스 연동 프로그래밍 
    - PyMySQL 모듈사용
    - 파이썬 DB연동 콘솔 : [노트북](./day05/db05_파이썬db연동.ipynb)
    - 파이썬 DB연동 웹 (Flask) : [python](./day05/index.py)
        - templates 폴더 내 html 저장

- 데이터 모델링
    - 현실세계의 데이터처리내용을 디지털 환경에 일치시켜서 모델링
    - DB 생명주기
        1. 요구사항 수집 및 분석
        2. 설계
        3. 구현
        4. 운영
        5. 감시 및 개선
    - 모델링 순서
        1. 개념적 모델링 - 요구사항 수집분석 내용 토대로 러프하게 전체 뼈대를 세우는 과정
        2. 논리적 모델링 - ER다이어그램 체계화. DBMS에 맞게 매핑. 키 선정(추가), 정규화, 데이터 표준화
        3. 물리적 모델링 - DBMS 종류에 맞게 데이터타입 지정, 물리적 구조 정의. 응답시간 최소화/트랜잭션 검토/저장공간 배치
    - 현재 ER다이어그램은 IE(Information Engineering)
    - ERWin 설계 실습 : [ERWin](./day05/madangstore.erwin)


## 6일차
- 데이터모델링 계속 : [SQL](./day06/마당대학_CREATE_스키마.sql)
    - 마당대학 데이터베이스 with Workbench : db01_마당대학.mwb(MySQL Workbench Model)
    - Forward Engineering 으로 DB 생성 확인

- 정규화 : [SQL](./day06/db03_정규화_이상현상.sql)
    - 이상현상 : 삽입이상, 삭제이상, 수정이상
        - 정규화를 제대로 못한 DB에서 발생 가능

    - 함수 종속성 : X -> Y를 만족할 때, (X는 결정자)
        - 완전함수종속 : 기본 키(전체)에 대해 종속되고, 기본 키의 "일부"로는 종속되지 않는 경우
        - 이행적종속 : if A -> B, B -> C, THEN A -> C
        - BCNF에 해당하지 않는 경우 : A -> C, B -> C일 경우 C -> B? A? 큰일남

    - 정규화 : 위의 이상현상이 발생하지 않도록 릴레이션을 분해하는 과정
        - 제 1정규화 : 속성의 데이터가 원자값을 가지도록 만드는 정규화
        - 제 2정규화 : 모든 릴레이션의 속성이 완전함수종속을 만족하도록 하는 정규화
        - 제 3정규화 : 이행적종속을 모두 제거하는 정규화
        - BCNF정규화 : 함수종속성 A -> B가 성립시 모든 결정자 A가 후보키가 되는 정규화
        - 제 4정규화 : 실무에서 사용안함. 다치종속성 릴레이션 가진 정규화
        - 제 5정규화 : 실무에서 사용안함. 프로젝트-조인 정규형

- 트랜잭션 : 데이터를 다루는 논리적인 작업단위 [SQL](./day06/db04_트랜잭션.sql)
    - START TRANSACTION, SAVEPOINT , ROLLBACK [TO SAVEPOINT], COMMIT 트랜잭션 처리 명령어
    - ACID 
        - 원자성 : Atomicity, 원자처럼 쪼개지지 않고 한 덩어리로 취급, All or Nothing.
        - 일관성 : Consistency, 트랜잭션 전후의 데이터가 일관되게 저장되어 있어야함.
        - 고립성 : Isolation, 트랜잭션이 발생할 동안 다른 트랜잭션이 값을 수정하지 못하게 막아야 한다.
        - 지속성 : Durability, 트랜잭션 후에 저장된 데이터는 무한히 그 값이 유지되어야 함.

    - 동시성 제어 : [SQL](./day06/db10_동시성제어1.sql)
        - 데드락 해결을 위하여

## 7일차
- Workbench Tip
    - SQL툴 공통으로 SELECT 실행 시 모든 행을 다 표시하지 않음.(성능저하 대비)

- 인덱스 실습 : [SQL](./day07/db01_인덱스연습.sql)
    - 500만건 조회시 prcie로 검색
        - 인덱스가 없으면 0.67초 소요
        - 인덱스를 걸면 0.06초 소요

- 데이터베이스 관리와 보안 : [SQL](./day07/db02_DB관리.sql)
- 실무실습 : [SQL](./day07/db99_실무실습.sql)
    - 서브쿼리 까지

## 8일차
- 실무실습 : []()
    - 서브쿼리부터
        |   함수        |   동일한 값에 대한 처리   |   다음 순위       |
        |   :--:        |   :--:                    |   :--:            |
        |   RANK()      |같은 값이면 같은 순위      |   다음 순위 건너뜀|
        |   DENSE_RANK()|같은 값이면 같은 순위      |   다음 순위 연속  |
        |   ROW_NUMBER()|같은 값이라도 순위가 다름  |   중복 없음       |

- 데이터모델링 실습
    - 병원업무관리 ERD
        - 요구사항으로 개체와 관계를 정립. 계체에 속하는 속성들, 식별자 결정
        - 테이블 명세서 작성(엑셀, 워드)
        - ERwin | Workbench 모델링에서 작성
        - 생성스크립트 : [SQL](./day08/db03_병원업무관리_스키마.sql)
        - Workbench에서 DB생성 후 위 스크립트 실행. DB구현

    <img src="./img/db006.png" width=800>

    - SQL 연습

## 9일차
- tkinter DB연동 GUI앱 개발
    1. MySQL madang 데이터베이스 사용하는 madang 사용자 생성, 권한
    
    2. madang DB에 students 테이블 생성
    ```sql
    create table students (
        std_id int primary key auto_increment,
        std_name varchar(100) not null,
        std_mobile varchar(20) null,
        std_regyear int not null
    );

    alter table students
    modify std_regyear int not null;

    -- 더미데이터 추가
    insert into students (std_name, std_mobile, std_regyear)
    values ('홍길동','010-9999-8888',2020);
    ```

    3. tkinter 템플릿 코드 작성 - 기본적인 GUI앱 틀
    <img src='./img/ui.png' width=800>

    4. 데이터베이스 CRUD 함수 구현 및 검색기능 추가.

- 데이터베이스 연습
    - SQL, 모델링 연습
    
- 코딩테스트 