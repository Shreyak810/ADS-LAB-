create database assign6;
use assign6;

# Customer Database

CREATE TABLE Customers (
    Customer_id VARCHAR(20) PRIMARY KEY,
    Customer_name VARCHAR(20),
    City_id VARCHAR(20),
    First_order_date DATE
);

# Inserting values into Customers Table
INSERT INTO Customers VALUES('25','Harsh','1','2024-02-20');
INSERT INTO Customers VALUES('35','Suyash','2','2023-02-20');


# Walk-In Customers Table
CREATE TABLE Walk_in_Customers (
    Customer_id VARCHAR(20),
    Tourism_guide VARCHAR(50),
    Timing DATE, 
    FOREIGN KEY(Customer_id) REFERENCES Customers(Customer_id)
);

# Inserting Values into Walk_in_Customers Table
INSERT INTO Walk_in_Customers VALUES('25', 'Harsh','2024-02-20');
INSERT INTO Walk_in_Customers VALUES('35', 'Suyash','2023-02-20');

SELECT * FROM Customers;
SELECT * FROM Walk_in_Customers;

# Mail Order Customers Table
CREATE TABLE Mail_Order_Customers (
    Customer_id VARCHAR(20),
    Post_address VARCHAR(50),
    Timing DATE, 
    FOREIGN KEY(Customer_id) REFERENCES Customers(Customer_id)
);

INSERT INTO Mail_Order_Customers VALUES('25', 'Pune', '2024-02-20');
INSERT INTO Mail_Order_Customers VALUES('35', 'Mumbai', '2024-02-20');

SELECT * FROM Mail_Order_Customers;

# Sales Database

CREATE TABLE Headquarters (
    City_id VARCHAR(20) PRIMARY KEY,
    City_name VARCHAR(50),
    Headquarters_addr VARCHAR(50),
    State VARCHAR(20),
    Timing DATE
);

INSERT INTO Headquarters VALUES('1','Pune','FC Road','Maharashtra','2024-02-20');
INSERT INTO Headquarters VALUES('2','Mumbai','Thane','Maharashtra','2023-02-20');

# Stores Table

CREATE TABLE Stores (
    Store_id VARCHAR(20) PRIMARY KEY,
    City_id VARCHAR(50),
    Phone VARCHAR(20),
    Timing DATE,
    FOREIGN KEY(City_id) REFERENCES Headquarters(City_id)
);

INSERT INTO Stores VALUES('1','1','9881221043','2024-02-20');
INSERT INTO Stores VALUES('2','2','7506561817','2024-02-20');

# Items Table

CREATE TABLE Items (
    Item_id VARCHAR(20) PRIMARY KEY,
    Description VARCHAR(50),
    Size INT,
    Weight INT,
    Unit_price INT,
    Timing DATE
);

INSERT INTO Items VALUES('1','Smartphone',1,1,30000,'2024-02-20');

# Stores Items
CREATE TABLE Stored_Items (
    Store_id VARCHAR(20),
    Item_id VARCHAR(20),
    Quantity_held INT,
    Timing DATE,
    PRIMARY KEY(Store_id,Item_id),
    FOREIGN KEY(Store_id) REFERENCES Stores(Store_id),
    FOREIGN KEY(Item_id) REFERENCES Items(Item_id)
);

INSERT INTO Stored_Items VALUES('1','1',13,'2024-02-20');

CREATE TABLE Orders (
    Order_no VARCHAR(20) PRIMARY KEY,
    Order_date DATE,
    Customer_id VARCHAR(20)
);

INSERT INTO Orders VALUES('1','2023-02-20','1');

CREATE TABLE Ordered_Items (
    Order_no VARCHAR(20),
    Item_id VARCHAR(20),
    Quantity_ordered INT,
    Ordered_price INT,
    Timing DATE,
    PRIMARY KEY(Order_no,Item_id),
    FOREIGN KEY(Order_no) REFERENCES Orders(Order_no),
    FOREIGN KEY(Item_id) REFERENCES Items(Item_id)
);

INSERT INTO Ordered_Items VALUES('1','1',13,30000,'2024-02-20');

# 1
CREATE TABLE Report_Q1(
    City_name VARCHAR(50),
    State VARCHAR(20),
    Phone VARCHAR(20),
    Description VARCHAR(50),
    Size INT,
    Weight INT,
    Unit_price INT
);

SELECT City_name, State, Phone, Description, Size, Weight, Unit_price FROM Items, Stores, Headquarters;

INSERT INTO Report_Q1 
    SELECT City_name, State, Phone, Description, Size, Weight, Unit_price FROM Items, Stores, Headquarters;

SELECT * FROM Report_Q1;



# 2
CREATE TABLE Report_Q2(
    Store_id VARCHAR(20),
    Order_no VARCHAR(20),
    Customer_name VARCHAR(20),
    Order_date DATE
);

SELECT Stores.Store_id, Orders.Order_no, Customer_name, Order_date FROM Stores, Orders, Ordered_Items, Customers, Stored_Items WHERE Quantity_ordered <= Quantity_held;

INSERT INTO Report_Q2 
    SELECT Stores.Store_id, Orders.Order_no, Customer_name, Order_date FROM Stores, Orders, Ordered_Items, Customers, Stored_Items WHERE Quantity_ordered <= Quantity_held;


# 3
CREATE TABLE Report_Q3(
    Customer_id VARCHAR(20),
    Store_id VARCHAR(20),
    City_name VARCHAR(20),
    Phone VARCHAR(20)
);

SELECT Customers.Customer_id, Stores.Store_id, City_name, Phone FROM Orders, Customers, Stored_Items, Stores, Headquarters;

INSERT INTO Report_Q3
    SELECT Customers.Customer_id, Stores.Store_id, City_name, Phone FROM Orders, Customers, Stored_Items, Stores, Headquarters;

# 4
CREATE TABLE Report_Q4(
    City_name VARCHAR(50),
    Headquarters_addr VARCHAR(50),
    State VARCHAR(20),
    Quantity_held VARCHAR(20)
);

SELECT City_name, Headquarters_addr, State, Quantity_held FROM Headquarters, Stored_Items;

INSERT INTO Report_Q4 
    SELECT City_name, Headquarters_addr, State, Quantity_held FROM Headquarters, Stored_Items;

# 5
CREATE TABLE Report_Q5(
    Order_no VARCHAR(20),
    Item_id VARCHAR(20),
    Description VARCHAR(20),
    Store_id VARCHAR(20),
    City_name VARCHAR(20)
);

SELECT Order_no, Item_id, Description, Store_id, City_name
FROM Orders, ((Stored_Items NATURAL JOIN Items) NATURAL JOIN Stores) NATURAL JOIN Headquarters;

INSERT INTO Report_Q5
    SELECT Order_no, Item_id, Description, Store_id, City_name
    FROM Orders, ((Stored_Items NATURAL JOIN Items) NATURAL JOIN Stores) NATURAL JOIN Headquarters;


# 6
CREATE TABLE Report_Q6(
    Customer_id VARCHAR(20),
    City_name VARCHAR(20),
    State VARCHAR(20)
);

SELECT Customer_id, City_name, State
FROM Customers NATURAL JOIN Headquarters;

INSERT INTO Report_Q6
    SELECT Customer_id, City_name, State
    FROM Customers NATURAL JOIN Headquarters;

# 7
CREATE TABLE Report_Q7(
    Quantity_held INT,
    Item_id VARCHAR(20),
    City_name VARCHAR(20)
);

INSERT INTO Report_Q7
    SELECT SUM(Quantity_held) AS TotalQuantity, Item_id, City_name 
    FROM Stored_Items 
    NATURAL JOIN Stores 
    NATURAL JOIN Headquarters 
    GROUP BY Item_id, City_name;


# 8
CREATE TABLE Report_Q8(
    Order_no VARCHAR(20),
    Item_id VARCHAR(20),
    Quantity_ordered INT,
    Customer_id VARCHAR(20),
    Store_id VARCHAR(20),
    City_id VARCHAR(20)
);

SELECT Order_no, Item_id, Quantity_ordered, Customer_id, Store_id, City_id
FROM (Ordered_Items NATURAL JOIN Orders NATURAL JOIN Stored_Items) NATURAL JOIN Stores;

INSERT INTO Report_Q8
    SELECT Order_no, Item_id, Quantity_ordered, Customer_id, Store_id, City_id 
    FROM (Ordered_Items NATURAL JOIN Orders NATURAL JOIN Stored_Items) NATURAL JOIN Stores;


# 9
CREATE TABLE Report_Q9(
    Customer_id VARCHAR(20)
);

SELECT Customer_id
FROM Walk_in_Customers NATURAL JOIN Mail_Order_Customers;

INSERT INTO Report_Q9
    SELECT Customer_id
    FROM Walk_in_Customers NATURAL JOIN Mail_Order_Customers;

