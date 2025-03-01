-- 1. 데이터베이스 생성
CREATE DATABASE PracticeDB;
USE PracticeDB;

-- 2. 고객(Customer) 테이블 생성
CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. 제품(Product) 테이블 생성
CREATE TABLE Product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. 주문(Order) 테이블 생성
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_price DECIMAL(10,2) DEFAULT 0,
    status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE
);

-- 5. 주문 상세(Order Details) 테이블 생성
CREATE TABLE OrderDetails (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE
);

-- 6. 샘플 데이터 삽입
INSERT INTO Customer (name, email, phone, address) VALUES
('김철수', 'chulsoo@example.com', '010-1234-5678', '서울시 강남구'),
('이영희', 'younghee@example.com', '010-9876-5432', '부산시 해운대구'),
('박민수', 'minsoo@example.com', '010-5555-8888', '대구시 수성구');

INSERT INTO Product (name, category, price, stock) VALUES
('노트북', '전자기기', 1200000, 10),
('스마트폰', '전자기기', 900000, 20),
('무선 이어폰', '액세서리', 150000, 50),
('책상', '가구', 300000, 5),
('의자', '가구', 120000, 8);

INSERT INTO Orders (customer_id, total_price, status) VALUES
(1, 2100000, 'Shipped'),
(2, 120000, 'Pending');

INSERT INTO OrderDetails (order_id, product_id, quantity, subtotal) VALUES
(1, 1, 1, 1200000),
(1, 2, 1, 900000),
(2, 5, 1, 120000);

-- 7. 기본 데이터 확인
SELECT * FROM Customer;
SELECT * FROM Product;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;
