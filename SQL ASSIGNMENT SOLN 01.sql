----------------------------------------------------------------------SQL ASSIGNMENT--01-------------------------------------------------------------------------------------------------------------------------------------------
--DATABASE CRAETION

CREATE DATABASE ABCFASHIONLTD

--DATABASE USE

USE ABCFASHIONLTD

--Salesman table creation

CREATE TABLE Salesman (
SalesmanId INT,
SalesmanName VARCHAR(255),
Commission DECIMAL(10,2),
City VARCHAR(255),
Age INT
);

--Salesman table record insertion 

INSERT INTO Salesman(SalesmanId,SalesmanName,Commission,City,Age)
VALUES
  (101, 'Joe', 50, 'California', 17),
    (102, 'Simon', 75, 'Texas', 25),
    (103, 'Jessie', 105, 'Florida', 35),
    (104, 'Danny', 100, 'Texas', 22),
    (105, 'Lia', 65, 'New Jersey', 30);

 --Customer table creation

 CREATE TABLE Customer (
 SalesmanId INT,
 CustomerId INT,
 CustomerName VARCHAR(255),
 PurchaseAmount INT
 );

 -- Customer table record insertion

 INSERT INTO Customer(SalesmanId,CustomerId,CustomerName,PurchaseAmount)
 VALUES
   (101, 2345, 'Andrew', 550),
    (103, 1575, 'Lucky', 4500),
    (104, 2345, 'Andrew', 4000),
    (107, 3747, 'Remona', 2700),
    (110, 4004, 'Julia', 4545);

--Orders table creation

CREATE TABLE Orders (OrderId INT,CustomerId INT,SalesmanId INT,Orderdate DATE,Amount Money);

--Order table record insertion

INSERT INTO Orders VALUES
(5001,2345,101,'2021-07-01',550),
(5003,1234,105,'2022-02-15',1500);

--Update datatype in Orders table for amount
ALTER TABLE Orders
ALTER COLUMN Amount DECIMAL(10, 2);




------------------------------------------ Tasks to be Performed-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Task 01 : Insert a new record in your Order

INSERT INTO Orders VALUES
(5004,4004,105,'2023-04-17',4545),
(5002,1575,103,'2020-05-20',4500);

--Task 02-Case 01: Add Primary key constraint for SalesmanId column in Salesman table.
ALTER TABLE Salesman
ADD CONSTRAINT PK_SalesmanId PRIMARY KEY(SalesmanId);

--Note : Before add constraint Primary key in Salesman table , will have to delet or update nullable column.
-------- Check for null values in the SalesmanId column:

SELECT * FROM Salesman WHERE SalesmanId IS NULL;

--------Check for duplicate values in the SalesmanId column:

SELECT SalesmanId, COUNT(*)
FROM Salesman
GROUP BY SalesmanId
HAVING COUNT(*) > 1;

------Update column to NOT NULL.

ALTER TABLE Salesman
ALTER COLUMN SalesmanId INT NOT NULL;

---- Add Primary key constraint.
ALTER TABLE Salesman
ADD CONSTRAINT PK_SalesmanId PRIMARY KEY(SalesmanId);

--Case 02 : Add default constraint for City column in Salesman table.

ALTER TABLE Salesman
ADD CONSTRAINT DF_City
DEFAULT 'Unknown' For City;

--Case 03 : Add Foreign key constraint for SalesmanId column in Customer table. 

ALTER TABLE Customer
ADD CONSTRAINT FK_Customer_Salesman
FOREIGN KEY (SalesmanId)
REFERENCES Salesman (salesmanId);

--- Identify invalid record in customer table.

SELECT CustomerId, SalesmanId
FROM Customer
WHERE SalesmanId NOT IN (SELECT SalesmanId FROM Salesman);

---Update Invalid Records: Change the SalesmanId in the Customer table to a valid one.

UPDATE Customer
SET SalesmanId = 102
WHERE SalesmanId = 107;

UPDATE Customer
SET SalesmanId = 105
WHERE SalesmanId = 110;

--Case 03 : Add not null constraint in Customer_name column for the Customer table.

--First, identify if there are any null values in the CustomerName column:

SELECT COUNT(*) AS NullCount
FROM Customer
WHERE CustomerName IS NULL;

--Than Update Null Values

-- Update null values with a default value, e.g., 'Unknown'

UPDATE Customer
SET CustomerName = 'Unknown'
WHERE CustomerName IS NULL;

-- Add NOT NULL constraint

ALTER TABLE Customer
ALTER COLUMN CustomerName VARCHAR(255) NOT NULL;

--Task 03 : Fetch the data where the Customer’s name is ending with ‘N’ also get the purchase amount value greater than 500.

SELECT * FROM Customer WHERE CustomerName LIKE '%N' AND PurchaseAmount > 500;

--Task 04 : Using SET operators, retrieve the first result with unique SalesmanId values from two tables, and the other result containing SalesmanId with duplicates from two tables.

----To retrieve unique and duplicate SalesmanId values from two tables, you can use the UNION and INTERSECT set operators.

-- Case 01 : Unique SalesmanId from both Salesman and Customer tables.

SELECT SalesmanId
FROM Salesman
UNION
SELECT SalesmanId
FROM Customer;

-- Case 02 : Duplicate SalesmanId in both Salesman and Customer tables.

SELECT SalesmanId
FROM Salesman
INTERSECT
SELECT SalesmanId
FROM Customer;

--Task 05 : Display the below columns which has the matching data.Orderdate, Salesman Name, Customer Name, Commission, and City which has the
--range of Purchase Amount between 500 to 1500.

--Solution :
--Join the Orders table with the Customer table using CustomerId.
--Join the resulting table with the Salesman table using SalesmanId.
--Filter the results where PurchaseAmount is between 500 and 1500.

SELECT 
    O.Orderdate,
    S.SalesmanName,
    C.CustomerName,
    S.Commission,
    S.City
FROM 
    Orders O
JOIN 
    Customer C ON O.CustomerId = C.CustomerId
JOIN 
    Salesman S ON C.SalesmanId = S.SalesmanId
WHERE 
    C.PurchaseAmount BETWEEN 500 AND 1500;

----Note : JOIN Customer C ON O.CustomerId = C.CustomerId: This joins the Orders table with the Customer table based on the CustomerId.
-----------JOIN Salesman S ON C.SalesmanId = S.SalesmanId: This further joins the resulting table with the Salesman table based on the SalesmanId.
-----------WHERE C.PurchaseAmount BETWEEN 500 AND 1500: This filters the results to include only those records where PurchaseAmount is between 500 and 1500.

--Task 06 : Using right join fetch all the results from Salesman and Orders table.

SELECT 
    O.OrderId,
    O.CustomerId,
    O.SalesmanId AS OrderSalesmanId,
    O.Orderdate,
    O.Amount AS OrderAmount,
    S.SalesmanId AS SalesmanId_S,
    S.SalesmanName,
    S.Commission,
    S.City,
    S.Age
FROM 
    Orders O
RIGHT JOIN 
    Salesman S ON O.SalesmanId = S.SalesmanId;
------------------------------------------------------------------------DONE------------------------------------------------------------------------------------------------------------------------------------------------------


















































