# iot-database-2025
IoT 개발자 데이터베이스 저장소

## 1일차

- 데이터베이스 시스템


- MySQL 설치(Docker)
    1. powerShell 오픈, docker 확인
        ```Shell
        > docker -v
        Docker version 27.5.1, build 9f9e405
        ```
    2. MySQL Docker 이미지 다운로드
        ```Shell
        > docker pull mysql
        Using default tag: latest
        latest: Pulling from library/mysql
        2be0d473cadf: Download complete
        d255dceb9ed5: Download complete
        277ab5f6ddde: Download complete
        43759093d4f6: Download complete
        23d22e42ea50: Download complete
        431b106548a3: Download complete
        893b018337e2: Download complete
        df1ba1ac457a: Download complete
        f56a22f949f9: Download complete
        cc9646b08259: Download complete
        Digest: sha256:146682692a3aa409eae7b7dc6a30f637c6cb49b6ca901c2cd160becc81127d3b
        Status: Downloaded newer image for mysql:latest
        docker.io/library/mysql:latest
        ```
    3. MySQL Image 확인
        ```Shell
        > docker images
        REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
        mysql        latest    146682692a3a   4 weeks ago   1.09GB  
        ```
    4. Docker 컨테이너 생성
        - MySQL Port --> 3306 (default)
        - Oracle Port --> 1521
        - SQL Server --> 1433
        ```Shell
        > docker run --name mysql-container -e MYSQL_ROOT_PASSWORD=root -d -p 3306:3306 mysql:latest
        ```
    5. 컨테이너 확인
        ```shell
        > docker ps -a
        d011e5dba0d6   mysql:latest   "docker-entrypoint.s…"   About a minute ago   Created                               mysql-container
        ```
    6. Docker 컨테이너 시작, 중지, 재시작
        ```shell
        > docker stop mysql-container       # 중지
        > docker start mysql-container      # 시작
        > docker restart mysql-container    # 재시작
        ```
    7. MySQL Docker 컨테이너 접속
        ```shell
        > docker exec -it mysql-container bash  # bash : 리눅스의 파워셸
        ```

- Workbench 설치
    - https://dev.mysql.com/downloads/workbench/
    - MySQL Installer 에서 Workbench, Sample만 설치
- 관계 데이터 모델

