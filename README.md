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
- SQL 기초
    - DDL (데이터 정의어)
    - DML 중 INSERT , UPDATE , DELETE

- SQL 고급
