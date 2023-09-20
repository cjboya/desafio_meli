-- Crear la tabla Customer
CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Email VARCHAR(255) UNIQUE,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Gender CHAR(1),
    Address VARCHAR(255),
    Birth_Date DATE,
    Phone VARCHAR(20)
);

-- Crear la tabla Category
CREATE TABLE Category (
    Category_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Path VARCHAR(255)
);

-- Crear la tabla Item
CREATE TABLE Item (
    Item_ID INT PRIMARY KEY,
    Category_ID INT,
    Description TEXT,
    Price DECIMAL(10, 2),
    Status VARCHAR(20),
    Created_Date DATE,
    Modified_Date DATE,
    FOREIGN KEY (Category_ID) REFERENCES Category(Category_ID)
);

-- Crear la tabla Order
CREATE TABLE Order (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT,
    Order_Date DATE,
    Total_Amount DECIMAL(10, 2),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);
