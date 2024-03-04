use DWH

create table DimAccount1 (
    AccountID INT PRIMARY KEY,
    CustomerID INT,
    AccounType VARCHAR(50),
    Balance DECIMAL(18, 2),
    DateOpened DATE,
    status VARCHAR(20),
	CONSTRAINT FK_AccountCustomer FOREIGN KEY (CustomerID) REFERENCES DimCustomer(CustomerID)
)

create table DimCustomer1 (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Address VARCHAR(255),
    CityID INT,
    age INT,
    Gender VARCHAR(10),
    Email VARCHAR(100)
)

create table DimBranch1 (
    BranchID INT PRIMARY KEY,
    BranchName VARCHAR(100),
    BranchLocation VARCHAR(255)
)

create table FactTransaction1 (
	TransactionID INT PRIMARY KEY,
    AccountID INT,
    TransactionDate DATE,
    Amount DECIMAL(18, 2),
    TransactionType VARCHAR(50),
    BranchID INT,
    CONSTRAINT FK_TransactionAccount FOREIGN KEY (AccountID) REFERENCES DimAccount(AccountID),
	CONSTRAINT FK_TransactionBranch FOREIGN KEY (BranchID) REFERENCES DimBranch(BranchID)
)



