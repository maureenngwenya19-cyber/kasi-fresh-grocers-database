USE KasiFreshGrocersDB
GO
-- CREATING SUPPLIER'S TABLE

CREATE TABLE Suppliers
(
SupplierID INT NOT NULL PRIMARY KEY IDENTITY(1,1) ,
SupplierName VARCHAR(50) NOT NULL ,
ContactEmail VARCHAR(100) UNIQUE ,
Province VARCHAR(20) NOT NULL
)

-- CREATING BRANCHES TABLE

CREATE TABLE Branches
(
BranchID INT NOT NULL PRIMARY KEY IDENTITY (101,1) ,
BranchName VARCHAR(50) NOT NULL,
Township VARCHAR(20) NOT NULL,
Province VARCHAR(20) NOT NULL ,
ManagerName VARCHAR(50) NOT NULL 

)

--CREATING PRODUCT TABLE

CREATE TABLE Products
(
ProductID INT NOT NULL PRIMARY KEY IDENTITY (201,1),
ProductName VARCHAR(20) NOT NULL ,
Category VARCHAR(20) NOT NULL ,
UnitPrice DECIMAL (10,2) NOT NULL ,
SupplierID INT,

CONSTRAINT FK_Suppliers_Products
FOREIGN KEY(SupplierID) REFERENCES Suppliers(SupplierID)

)

-- CREATING CUSTOMERS TABLE

CREATE TABLE Customers
(  
CustomerID INT NOT NULL PRIMARY KEY IDENTITY(1001,1),
FirstName VARCHAR(50) NOT NULL ,
LastName VARCHAR(50) NOT NULL ,
Email VARCHAR(100) UNIQUE ,
Phone VARCHAR(20) NOT NULL ,
LoyaltyTier VARCHAR(20) NOT NULL ,
SignupDate DATETIME DEFAULT GETDATE()

)

-- CREATING ORDERS TABLE

CREATE TABLE Orders
(
OrderID INT NOT NULL PRIMARY KEY IDENTITY(10,1),
OrderDate DATETIME DEFAULT GETDATE(),
PaymentMethod VARCHAR(50) NOT NULL ,
CustomerID INT NOT NULL,
BranchID INT NOT NULL ,

FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID),
FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
)


--CREATING ORDERITEMS TABLE

CREATE TABLE OrderItems
(
OrderItemID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
unitPrice DECIMAL(10,2) NOT NULL ,
Quantity INT NOT NULL CHECK (Quantity >0 ),
ProductID INT NOT NULL ,
OrderID INT NOT NULL ,

FOREIGN KEY(OrderID) REFERENCES Orders(OrderID),
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)

)

/* QUESTION 1.3 */

   /* ------------------------------------------------------------
                            Suppliers 
   ------------------------------------------------------------ */

 INSERT INTO Suppliers
    (SupplierName, ContactEmail, Province)
VALUES
    ('Cafe Mozart', 'cafemozart@worldonline.co.za', 'Gauteng'),
    ('Go Fresh', 'orders@gofresh.co.za', 'Mpumalanga'),
    ('P.Serassis', 'faith@serassis.co.za', 'KwaZulu-Natal'),
    ('Coca Cola ABI', 'coca@ccbagroup.com', 'Northern Cape'),
    ('Eastern Produce meat', 'orders@easternproduce.co.za', 'Western Cape'),
    ('Willow Valley', 'orders@willowvalleydairyfarm.co.za', 'KwaZulu-Natal'),
    ('La Concorde', 'info@laconcorde.co.za', 'KwaZulu-Natal'),
    ('SA Household Supplies', 'orders@sahousehold.co.za', 'Eastern Cape');
GO

/* ------------------------------------------------------------
   Branches - 8 township branches
   ------------------------------------------------------------ */

INSERT INTO Branches
    (BranchName, Township, Province, ManagerName)
VALUES
    ('Kasi Fresh Soweto', 'Soweto', 'Gauteng', 'Jessica Mokwena'),
    ('Kasi Fresh Alexandra', 'Alexandra', 'Gauteng', 'Khensani Molefe'),
    ('Kasi Fresh Khayelitsha', 'Khayelitsha', 'Western Cape', 'Nyeleti Baloyi'),
    ('Kasi Fresh Umlazi', 'Umlazi', 'KwaZulu-Natal', 'Sibusiso Ndabezitha'),
    ('Kasi Fresh Mamelodi', 'Mamelodi', 'Gauteng', 'Nompumelelo Smith'),
    ('Kasi Fresh Mdantsane', 'Mdantsane', 'Eastern Cape', 'Rose Adams'),
    ('Kasi Fresh Tembisa', 'Tembisa', 'Gauteng', 'Princess Nyokong'),
    ('Kasi Fresh Galeshewe', 'Galeshewe', 'Northern Cape', 'Kabelo Modau');
GO


/* ------------------------------------------------------------
   Products - 8 rows
   ------------------------------------------------------------ */

INSERT INTO Products
    (ProductName, Category, UnitPrice, SupplierID)
VALUES
    ('White Bread 700g', 'Bakery', 20.00, 1),
    ('Maize Meal 5kg', 'Groceries', 42.99, 7),
    ('Semi Skimmed Milk 2L', 'Dairy', 44.99, 4),
    ('Canola Oil 2L', 'Cooking', 89.99, 1),
    ('Orange Juice 2L', 'Beverages', 67.99, 2),
    ('Basmati Rice 2kg', 'Groceries', 118.99, 3),
    ('Chicken Portions 2kg', 'Meat', 102.99, 5),
    ('Laundry Powder 2kg', 'Household', 114.99, 8);
GO


/* ------------------------------------------------------------
   Customers - 8 rows
   ------------------------------------------------------------ */

INSERT INTO Customers
    (FirstName, LastName, Email, Phone, LoyaltyTier, SignupDate)
VALUES
    ('Sipho', 'Dlomo', 'sipho.dlomo@email.com', '0719284553',
     'Bronze', '2025-05-15'),

    ('Bonolo', 'Khumalo', 'bonolokhumalo@email.com', '0727816655',
     'Silver', '2024-11-19'),

    ('Thandi', 'Morena', 'thandimorena@email.com', '0734445678',
     'Gold', '2024-07-12'),

    ('James', 'Ngwenya', 'jamesngwenya@email.com', '0745678932',
     'Bronze', '2025-04-15'),

    ('Lebo', 'Molefe', 'lebomolefe@email.com', '0758679012',
     'Silver', '2024-09-10'),

    ('Ayanda', 'Moepa', 'ayandamoepa@email.com', '0767890133',
     'Gold', '2024-06-18'),

    ('Kabelo', 'Maseko', 'kabelomaseko@email.com', '0778901234',
     'Bronze', '2025-04-22'),

    ('Precious', 'Dube', 'preciousdube@email.com', '0789012345',
     'Platinum', '2024-02-10');
GO


/* ------------------------------------------------------------
                   Orders 

   ------------------------------------------------------------ */

INSERT INTO Orders
    (CustomerID, BranchID, OrderDate, PaymentMethod)
VALUES
    (1001, 101, DATEADD(DAY, -10, GETDATE()), 'Card'),
    (1002, 102, DATEADD(DAY, -20, GETDATE()), 'Cash'),
    (1003, 103, DATEADD(DAY, -35, GETDATE()), 'Card'),
    (1004, 104, DATEADD(DAY, -50, GETDATE()), 'EFT'),
    (1005, 105, DATEADD(DAY, -70, GETDATE()), 'Card'),
    (1006,106, DATEADD(DAY, -15, GETDATE()), 'Cash'),
    (1007,107, DATEADD(DAY, -120, GETDATE()), 'Card'),
    (1008,108, DATEADD(DAY, -150, GETDATE()), 'EFT')
 GO


/* ------------------------------------------------------------
                       OrderItems 
   ------------------------------------------------------------ */

INSERT INTO OrderItems
    (UnitPrice,Quantity, ProductID,OrderID)
VALUES
    (67.99,2,201,10),
    (81.99,4,202,12),
    (56.99,1,205,16),
	(5.99,3,206,17),
	(9.99,8,203,10),
	(16.99,6,205,11),
	(28.99,4,207,13),
    (29.67,4,207,15)
GO

/* ============================================================
   QUESTION 1.4
                     Queries
   ============================================================ */

 /*total revenue per branch (5 marks)*/
SELECT b.BranchID,b.BranchName,b.Township,SUM(oi.Quantity * oi.UnitPrice) AS TotalRevenue
FROM Branches b
    INNER JOIN Orders o      ON o.BranchID = b.BranchID
    INNER JOIN OrderItems oi ON oi.OrderID = o.OrderID
WHERE o.OrderDate IS NOT NULL         
GROUP BY b.BranchID, b.BranchName, b.Township
ORDER BY TotalRevenue DESC;
GO
 
 /*customers that have not ordered in the last 90 days*/
 SELECT c.CustomerID,c.FirstName,c.LastName,c.Email,
    MAX(o.OrderDate) AS LastOrderDate,
    DATEDIFF(DAY, MAX(o.OrderDate), GETDATE()) AS DaysSinceLastOrder
FROM Customers c
    LEFT JOIN Orders o ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName, c.Email
HAVING MAX(o.OrderDate) IS NULL
    OR MAX(o.OrderDate) < DATEADD(DAY, -90, GETDATE())   
ORDER BY LastOrderDate ASC;   
GO
 


/* ============================================================
   QUESTION 1.5
   NON-CLUSTERED INDEX
   ============================================================ */

   CREATE NONCLUSTERED INDEX IX_Orders_CustomerID
ON Orders (CustomerID);
GO
 
-- ---------------------------------------------------------------------------
-- Audit table that the trigger will log to
-- ---------------------------------------------------------------------------
CREATE TABLE OrderAudit
(
    AuditID         INT IDENTITY(1,1)   NOT NULL,
    OrderItemID     INT                 NOT NULL,
    OrderID         INT                 NOT NULL,
    ProductID       INT                 NOT NULL,
    Quantity        INT                 NOT NULL,
    UnitPrice       DECIMAL(10,2)       NOT NULL,
    ActionDate      DATETIME            NOT NULL DEFAULT (GETDATE()),
    CONSTRAINT PK_OrderAudit PRIMARY KEY (AuditID)
);
GO
 
CREATE TRIGGER trg_OrderItems_AfterInsert
ON OrderItems
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
 
    IF EXISTS (SELECT 1 FROM inserted WHERE Quantity <= 0)
    BEGIN
        RAISERROR ('OrderItems insert rejected: Quantity must be greater than zero.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
 
    -- Log every inserted line item to the audit table
    INSERT INTO OrderAudit (OrderItemID, OrderID, ProductID, Quantity, UnitPrice, ActionDate)
    SELECT OrderItemID, OrderID, ProductID, Quantity, UnitPrice, GETDATE()
    FROM inserted;
END;
GO
INSERT INTO OrderItems (UnitPrice,Quantity,ProductID,OrderID)
VALUES (300,20,201,10);
SELECT * FROM OrderAudit;
GO

  /* 1.6  VIEW: vw_SalesSummary */
 
CREATE VIEW vw_SalesSummary AS
SELECT
    o.OrderID,
    c.CustomerID,
    c.FirstName + ' ' + c.LastName     AS CustomerName,
    p.ProductID,
    p.ProductName,
    oi.Quantity,
    oi.UnitPrice,
    (oi.Quantity * oi.UnitPrice)       AS LineTotal,
    o.OrderDate,
    o.BranchID
FROM Orders o
    INNER JOIN Customers  c  ON c.CustomerID  = o.CustomerID
    INNER JOIN OrderItems oi ON oi.OrderID    = o.OrderID
    INNER JOIN Products   p  ON p.ProductID   = oi.ProductID;
GO


 SELECT * FROM vw_SalesSummary;
 
 
/* 1.7  STORED PROCEDURE: usp_UpdateLoyaltyPoints (uses a WHILE loop) */

 ALTER TABLE Customers
ADD LoyaltyPoints INT NOT NULL DEFAULT 0;
GO
CREATE OR ALTER PROCEDURE usp_UpdateLoyaltyPoints
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CustomerQueue TABLE
    (
        RowNum INT IDENTITY(1,1),
        CustomerID INT
    );

    INSERT INTO @CustomerQueue (CustomerID)
    SELECT CustomerID FROM Customers;

    DECLARE @i INT = 1;
    DECLARE @MaxRow INT = (SELECT MAX(RowNum) FROM @CustomerQueue);
    DECLARE @CurrentCustomerID INT;
    DECLARE @TotalSpend DECIMAL(12,2);
    DECLARE @NewPoints INT;

    WHILE @i <= @MaxRow
    BEGIN
        SELECT @CurrentCustomerID = CustomerID
        FROM @CustomerQueue
        WHERE RowNum = @i;

        SELECT @TotalSpend = ISNULL(SUM(oi.Quantity * oi.UnitPrice), 0)
        FROM Orders o
        INNER JOIN OrderItems oi ON oi.OrderID = o.OrderID
        WHERE o.CustomerID = @CurrentCustomerID;

        SET @NewPoints = CAST(@TotalSpend / 10 AS INT);

        UPDATE Customers
        SET LoyaltyPoints = @NewPoints
        WHERE CustomerID = @CurrentCustomerID;

        SET @i = @i + 1;
    END;

    PRINT 'Loyalty points updated for all customers.';
END;
GO

 EXEC usp_UpdateLoyaltyPoints;
GO
EXEC usp_UpdateLoyaltyPoints;
SELECT CustomerID, LoyaltyTier FROM Customers ORDER BY CustomerID;
GO

/* =============================================================================
   1.8  BASIC SECURITY (login/user, GRANT SELECT)         
   ============================================================================= */
 

CREATE OR ALTER PROCEDURE usp_UpdateLoyaltyPoints
AS
BEGIN
    SET NOCOUNT ON;
 
    BEGIN TRY
 
        DECLARE @CustomerQueue TABLE
        (
            RowNum       INT IDENTITY(1,1) PRIMARY KEY,
            CustomerID   INT
        );
 
        INSERT INTO @CustomerQueue (CustomerID)
        SELECT CustomerID FROM Customers;
 
        DECLARE @i          INT = 1;
        DECLARE @MaxRow     INT = (SELECT MAX(RowNum) FROM @CustomerQueue);
        DECLARE @CurrentCustomerID INT;
        DECLARE @TotalSpend DECIMAL(12,2);
        DECLARE @NewPoints  INT;
 
        WHILE @i <= @MaxRow
        BEGIN
            SELECT @CurrentCustomerID = CustomerID
            FROM @CustomerQueue
            WHERE RowNum = @i;
 
            SELECT @TotalSpend = ISNULL(SUM(oi.Quantity * oi.UnitPrice), 0)
            FROM Orders o
                INNER JOIN OrderItems oi ON oi.OrderID = o.OrderID
            WHERE o.CustomerID = @CurrentCustomerID;
 
            SET @NewPoints = CAST(@TotalSpend / 10 AS INT);
 
            UPDATE Customers
            SET LoyaltyPoints = @NewPoints,
                LoyaltyTier =
                    CASE
                        WHEN @TotalSpend >= 1000 THEN 'Gold'
                        WHEN @TotalSpend >= 400  THEN 'Silver'
                        ELSE 'Bronze'
                    END
            WHERE CustomerID = @CurrentCustomerID;
 
            SET @i = @i + 1;
        END
 
        PRINT 'Loyalty points and tiers updated for all customers.';
 
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred while updating loyalty points. The operation was rolled back.';
        PRINT 'Error message: ' + ERROR_MESSAGE();
        PRINT 'Error number: '  + CAST(ERROR_NUMBER() AS NVARCHAR(20));
        PRINT 'Error line: '    + CAST(ERROR_LINE() AS NVARCHAR(20));
    END CATCH
END;
GO
 

CREATE LOGIN KasiReportingUser
    WITH PASSWORD = 'R3port!ngPass2026',
    CHECK_POLICY = ON;
GO
 

CREATE USER KasiReportingUser
    FOR LOGIN KasiReportingUser;
GO
 

CREATE ROLE ReportingRole;
GO
 
ALTER ROLE ReportingRole ADD MEMBER KasiReportingUser;
GO
 

GRANT SELECT ON vw_SalesSummary TO ReportingRole;
GRANT SELECT ON Orders          TO ReportingRole;
GRANT SELECT ON OrderItems      TO ReportingRole;
GRANT SELECT ON Customers       TO ReportingRole;
GRANT SELECT ON Products        TO ReportingRole;
GRANT SELECT ON Branches        TO ReportingRole;
GRANT SELECT ON Suppliers       TO ReportingRole;
GO