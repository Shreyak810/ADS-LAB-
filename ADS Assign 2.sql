use lab;

-- Q1. A)
-- Create test_tabel
CREATE TABLE test_table (
    RecordNumber INT(3),
    CurrentDate DATE
);

-- PSM Procedure to insert 50 records
DELIMITER //

CREATE PROCEDURE InsertRecords()
BEGIN
    DECLARE i INT DEFAULT 1;
    
    WHILE i <= 50 DO
        INSERT INTO test_table (RecordNumber, CurrentDate) VALUES (i, CURDATE());
        SET i = i + 1;
    END WHILE;
    
END //

DELIMITER ;

-- Call the procedure to insert 50 records
CALL InsertRecords();
SELECT * FROM test_table;


-- Create products table

CREATE TABLE products (
    ProductID INT(4),
    category CHAR(3),
    detail VARCHAR(30),
    price DECIMAL(10,2),
    stock INT(5)
);

-- Insert sample data into products table
INSERT INTO products (ProductID, category, detail, price, stock)
VALUES 
    (1, 'ABC', 'Product1', 10.00, 100),
    (2, 'XYZ', 'Product2', 20.00, 50)
    ;

-- PSM Procedure to increase price by X% for all products in category Y
DELIMITER //

CREATE PROCEDURE UpdatePrices(IN X DECIMAL(5,2), IN Y CHAR(3))
BEGIN
    UPDATE products
    SET price = price + (price * (X / 100))
    WHERE category = Y;
END //

DELIMITER ;

CALL UpdatePrices(10,'A');
SELECT * FROM products;

-- Q2
-- A)

CREATE TABLE NameTable (
    name VARCHAR(50)
);

DELIMITER //

CREATE FUNCTION countNoOfWords(input_name VARCHAR(50)) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE word_count INT DEFAULT 0;
    
    IF input_name IS NOT NULL THEN
        SET word_count = LENGTH(input_name) - LENGTH(REPLACE(input_name, ' ', '')) + 1;
    END IF;

    RETURN word_count;
END //

DELIMITER ;

INSERT INTO NameTable VALUES ('Neha');
INSERT INTO NameTable VALUES ('Asmita');

SELECT name, countNoOfWords(name) AS word_count FROM NameTable; 


-- B)
CREATE TABLE AddressTable (
    address VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    pincode VARCHAR(10)
);

DELIMITER //
CREATE FUNCTION extractAddresses(addressInput VARCHAR(100), cityInput VARCHAR(50), stateInput VARCHAR(50), pincodeInput VARCHAR(10), keyword VARCHAR(50)) RETURNS VARCHAR(4000) DETERMINISTIC
BEGIN
    DECLARE result VARCHAR(4000) DEFAULT '';
    IF addressInput LIKE CONCAT('%', keyword, '%') THEN
        SET result := CONCAT(result, 'Address: ', addressInput, '\n');
    END IF;
    IF cityInput LIKE CONCAT('%', keyword, '%') THEN
        SET result := CONCAT(result, 'City: ', cityInput, '\n');
    END IF;
    IF stateInput LIKE CONCAT('%', keyword, '%') THEN
        SET result := CONCAT(result, 'State: ', stateInput, '\n');
    END IF;
    IF pincodeInput LIKE CONCAT('%', keyword, '%') THEN
        SET result := CONCAT(result, 'Pincode: ', pincodeInput, '\n');
    END IF;
    RETURN result;
END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION countWordsInField(inputString VARCHAR(100)) RETURNS INT DETERMINISTIC
BEGIN
    RETURN LENGTH(REGEXP_REPLACE(inputString, '[^ ]+', '')) + 1;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE demonstrateAddress()
BEGIN
    DECLARE resultAddresses VARCHAR(4000);
    DECLARE wordCount INT;

    INSERT INTO AddressTable VALUES ('123 Main St', 'Cityville', 'CA', '12345');

    SET resultAddresses := extractAddresses('123 Main St', 'Cityville', 'CA', '12345', 'City');
    SELECT resultAddresses;

    SET wordCount := countWordsInField('Cityville');
    SELECT CONCAT('Word count in City: ', wordCount);
END //

DELIMITER ;

CALL demonstrateAddress();
SELECT * FROM AddressTable;

--  C)
CREATE TABLE CourseTable (
    course_id INT,
    description VARCHAR(100)
);

-- Stored procedure to insert rows into the table
DELIMITER //

CREATE PROCEDURE insertCourses()
BEGIN
    INSERT INTO CourseTable VALUES (1, 'Introduction to SQL');
    INSERT INTO CourseTable VALUES (2, 'Advanced Java Programming');
    -- Add more rows as needed
END //

DELIMITER ;

-- Call the stored procedure to insert rows
CALL insertCourses();

-- Stored function to demonstrate working with different data sets
DELIMITER //

CREATE FUNCTION getCourseData() RETURNS VARCHAR(4000) DETERMINISTIC
BEGIN
    DECLARE result VARCHAR(4000) DEFAULT '';

    SELECT CONCAT('Course ID: ', course_id, ', Description: ', description, '\n')
    INTO result
    FROM CourseTable;

    RETURN result;
END //

DELIMITER ;

-- Call the stored function to demonstrate working with different data sets
SELECT getCourseData();
SELECT * FROM CourseTable;
