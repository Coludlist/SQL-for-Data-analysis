

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    price DECIMAL(10, 2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Customers (first_name, last_name, email) VALUES
('Ram', 'Kumar', 'ram@example.com'),
('Bob', 'Johnson', 'bob@example.com'),
('john', 'Brown', 'john@example.com');

INSERT INTO Products (name, price) VALUES
('Laptop', 1200.00),
('Mouse', 25.00),
('Keyboard', 75.00),
('Monitor', 300.00);

INSERT INTO Orders (customer_id, order_date) VALUES
(1, '2025-10-20'),  
(2, '2025-10-21'),  
(1, '2025-10-23');  

INSERT INTO Order_Items (order_id, product_id, quantity) VALUES
(1, 1, 1),  
(1, 2, 1),  
(2, 3, 2),  
(3, 4, 1), 
(3, 2, 1);  
show tables;
SELECT * FROM customers;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM Order_Items;


SELECT
    name,
    price
FROM
    Products
WHERE
    price > 100.00
ORDER BY
    price DESC; 
    
    SELECT
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS total_orders
FROM
    Customers c
LEFT JOIN
    Orders o ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id;
    
    SELECT first_name, last_name
FROM Customers
WHERE customer_id IN (
    
    SELECT customer_id
    FROM Orders
    WHERE order_id IN (
        
        SELECT order_id
        FROM Order_Items
        WHERE product_id = (
           
            SELECT product_id
            FROM Products
            WHERE name = 'Mouse'
        )
    )
);

SELECT
    p.name,
    SUM(oi.quantity * p.price) AS total_revenue
FROM
    Order_Items oi
JOIN
    Products p ON oi.product_id = p.product_id
GROUP BY
    p.name
ORDER BY
    total_revenue DESC;
    

CREATE VIEW v_OrderRevenue AS
SELECT
    o.order_id,
    o.order_date,
    c.first_name,
    c.last_name,
    SUM(oi.quantity * p.price) AS order_total
FROM
    Orders o
JOIN
    Customers c ON o.customer_id = c.customer_id
JOIN
    Order_Items oi ON o.order_id = oi.order_id
JOIN
    Products p ON oi.product_id = p.product_id
GROUP BY
    o.order_id;


SELECT * FROM v_OrderRevenue WHERE order_total > 100;

CREATE INDEX idx_email ON Customers(email);
