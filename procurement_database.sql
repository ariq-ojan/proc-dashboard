CREATE DATABASE IF NOT EXISTS procurement_dashboard; --1. CREATE THE DATABASE
USE procurement_dashboard

CREATE TABLE suppliers(
    supplier_id VARCHAR(20) PRIMARY KEY, --2. CREATE/DEFINE SUPPLIERS TABLE
    supplier_name VARCHAR(100)
);

ALTER TABLE suppliers
MODIFY supplier_name VARCHAR(255);

LOAD DATA INFILE 'path/to/csv/or/data' --3. LOAD THE CSV TO THE SUPPLIERS TABLE
INTO TABLE suppliers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(supplier_id, supplier_name);

CREATE TABLE orders(
    order_no VARCHAR(20) PRIMARY KEY, --4. CREATE THE ORDERS TABLE
    order_type VARCHAR(5),
    supplier_id VARCHAR(20),
    order_state VARCHAR(50),
    date_issued DATE,
    author VARCHAR(20),

    FOREIGN KEY(supplier_id) REFERENCES suppliers(supplier_id)
);

ALTER TABLE orders MODIFY supplier_id VARCHAR(50) NULL; 

ALTER TABLE orders DROP FOREIGN KEY orders_ibfk_1;

ALTER TABLE orders --5. CREATE STAGING TABLE TO LATER INSERT TO MAIN ORDERS TABLE
ADD CONSTRAINT orders_ibfk_1
FOREIGN KEY (supplier_id)
REFERENCES suppliers(supplier_id)
ON DELETE SET NULL
ON UPDATE CASCADE;

ALTER TABLE orders_staging
CHANGE COLUMN order_status order_state VARCHAR(50);

TRUNCATE TABLE orders_staging

LOAD DATA INFILE 'path/to/csv/or/data'
INTO TABLE orders_staging
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(order_no, order_type, supplier_id, date_issued, order_state, author);

SELECT order_no, COUNT(*) 
FROM orders_staging 
GROUP BY order_no 
HAVING COUNT(*) > 1;

INSERT INTO orders (order_no, order_type, supplier_id, date_issued, order_state, author) --6. INSERT STAGING TABLE INTO MAIN TABLE
SELECT order_no, order_type, supplier_id, date_issued, order_state, author
FROM orders_staging
WHERE (supplier_id IS NULL OR supplier_id IN (SELECT supplier_id FROM suppliers)) 
   AND order_no NOT IN (SELECT order_no FROM orders);

TRUNCATE TABLE orders

LOAD DATA INFILE 'path/to/csv/or/data'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(order_no, order_type, supplier_id, date_issued, order_state, author)

CREATE TABLE items(
    order_no VARCHAR(20), --7. CREATE ITEMS TABLE
    pos_no INT,
    detail_state VARCHAR(20),
    receiving_date DATE,
    part_no VARCHAR(100),
    serial_no VARCHAR(50),
    description TEXT,
    material_type VARCHAR(5),
    qty INT,
    uom VARCHAR(20),
    backorder INT,
    priority VARCHAR(20),
    order_currency VARCHAR(5),
    local_price DECIMAL(18,2),
    local_amount DECIMAL(18,2),
    foreign_price DECIMAL(18,2),
    foreign_amount DECIMAL(18,2),
    cost_center VARCHAR(20),
    ship_to VARCHAR(20),
    PRIMARY KEY(order_no, pos_no),
    FOREIGN KEY(order_no) REFERENCES orders(order_no)
);

ALTER TABLE items 
MODIFY receiving_date DATE NULL;

ALTER TABLE items
MODIFY serial_no VARCHAR(50) NULL;

ALTER TABLE items
MODIFY ship_to VARCHAR(20) NULL;

CREATE TABLE items_staging LIKE items; --8. LOAD ITEMS TABLE INTO A STAGING TABLE
LOAD DATA INFILE 'path/to/csv/or/data' --9. LOAD CSV INTO STAGING TABLE
INTO TABLE items_staging
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(order_no, pos_no, detail_state, @receiving_date, part_no, @serial_no, description, material_type, qty, uom, backorder, priority, order_currency, local_price, local_amount, foreign_price, foreign_amount, cost_center, @ship_to)
SET 
    receiving_date = NULLIF(@receiving_date, ''),
    serial_no = NULLIF(@serial_no, ''),
    ship_to = NULLIF(@ship_to, '');

INSERT INTO items 
(order_no, pos_no, detail_state, receiving_date, part_no, serial_no, description, material_type, qty, uom, backorder, priority, order_currency, local_price, local_amount, foreign_price, foreign_amount, cost_center, ship_to)
SELECT 
    order_no, pos_no, detail_state, receiving_date, part_no, serial_no, description, material_type, qty, uom, backorder, priority, order_currency, local_price, local_amount, foreign_price, foreign_amount, cost_center, ship_to
FROM items_staging
WHERE order_no IN (SELECT order_no FROM orders);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.2/Uploads/items.csv'
INTO TABLE items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(order_no, pos_no, detail_state, @receiving_date, part_no, @serial_no, description, material_type, qty, uom, backorder, priority, order_currency, local_price, local_amount, foreign_price, foreign_amount, cost_center, @ship_to)
SET 
    receiving_date = NULLIF(@receiving_date, ''),
    serial_no = NULLIF(@serial_no, ''),
    ship_to = NULLIF(@ship_to, '');
SET receiving_date = NULLIF(@receiving_date, '');