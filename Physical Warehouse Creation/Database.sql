Create Database FireInsuranceDB;

CREATE TABLE Customer (
    CustomerID NVARCHAR(10) PRIMARY KEY,
    FirstName VARCHAR (50),
    LastName VARCHAR (50),
    Address VARCHAR (255),
    ContactNumber VARCHAR (16) 
	CHECK (ContactNumber LIKE '+91 [0-9][0-9][0-9][0-9][0-9] [0-9][0-9][0-9][0-9][0-9]'),
    Email VARCHAR (50)
	CHECK (Email LIKE '%_@_%._%'),
    DOB DATE,
    Age INT,
    Occupation VARCHAR (50)
);

CREATE TABLE Agent (
    AgentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
	ContactNumber VARCHAR(16)
	CHECK (ContactNumber LIKE '+91 [0-9][0-9][0-9][0-9][0-9] [0-9][0-9][0-9][0-9][0-9]'),
    Email VARCHAR (50)
	CHECK (Email LIKE '%_@_%._%'),
    Commission_Rate DECIMAL(5, 2)
);

CREATE TABLE BuildingDetails (
    BuildingID NVARCHAR(8) PRIMARY KEY,
    BuildingType VARCHAR(50),
    ConstructionType VARCHAR(50),
    RoofType VARCHAR(50),
    Age_of_Wiring INT,
    Num_Floors INT,
    HeatingType VARCHAR(50)
);

CREATE TABLE LocationDetails (
    LocationID INT PRIMARY KEY,
    Location_Name VARCHAR(50),
    Nearest_To_River BIT
);

CREATE TABLE OccupantDetails (
    OccupantID NVARCHAR(8) PRIMARY KEY,
    Occupant_Name VARCHAR(50),
    Occupant_Type VARCHAR(50)
);

CREATE TABLE Property (
    PropertyID NVARCHAR(8) PRIMARY KEY,
    LocationID INT,
    BuildingID NVARCHAR(8),
    OccupantID NVARCHAR(8),
    Fire_Risk_Level VARCHAR(255),
    Year_Built DATE,
    Distance_to_Fire_Hydrant DECIMAL(5, 2),
    Distance_to_Fire_Station DECIMAL(5, 2),
    PropertyTax DECIMAL(10, 2),
    MortgageAmount DECIMAL(10, 2),
    HomeValue DECIMAL(10, 2),
    SquareFootage DECIMAL(10, 2),
    Renovation_Year DATE,
    Nearby_Fire_Station VARCHAR(100),
    
    FOREIGN KEY (LocationID) REFERENCES LocationDetails(LocationID),
    FOREIGN KEY (BuildingID) REFERENCES BuildingDetails(BuildingID),
    FOREIGN KEY (OccupantID) REFERENCES OccupantDetails(OccupantID)
);

CREATE TABLE UnderWriter (
    UnderWriterID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    ContactNumber VARCHAR (16) 
	CHECK (ContactNumber LIKE '+91 [0-9][0-9][0-9][0-9][0-9] [0-9][0-9][0-9][0-9][0-9]'),
    Email VARCHAR (50)
	CHECK (Email LIKE '%_@_%._%'),
);

CREATE TABLE Policy (
    PolicyID INT PRIMARY KEY,
    AgentID INT FOREIGN KEY REFERENCES Agent(AgentID),
    PropertyID NVARCHAR(8) FOREIGN KEY REFERENCES Property(PropertyID),
    PolicyHolderID NVARCHAR(10) FOREIGN KEY REFERENCES Customer(CustomerID),
    UnderwriterID INT FOREIGN KEY REFERENCES Underwriter(UnderwriterID),
    PolicyNumber INT,
    StartDate DATE,
    EndDate DATE,
    CoverageAmount DECIMAL(10, 2),
    PremiumAmount DECIMAL(10, 2),
    DeductibleAmount DECIMAL(10, 2)
);

CREATE TABLE Claim (
    ClaimID INT PRIMARY KEY,
    PolicyID INT,
    DateFiled DATE,
    Description VARCHAR(255),
    ClaimInvestigationStatus VARCHAR(50),
    PaymentApproval BIT,
    FOREIGN KEY (PolicyID) REFERENCES Policy(PolicyID)
);

CREATE TABLE ClaimSettlement (
    ClaimID INT PRIMARY KEY REFERENCES Claim(ClaimID),
    ClaimAmount DECIMAL(10, 2),
    PaymentMethod VARCHAR(25),
    ClaimClosure VARCHAR(10)
);

CREATE TABLE Premium (
    Premium_ID INT PRIMARY KEY,
    PolicyID INT FOREIGN KEY REFERENCES Policy(PolicyID), 
    PaymentDate DATE,
    Amount DECIMAL(10, 2),
    PaymentMethod VARCHAR(50),
    DueDate DATE,
    Premium_Status VARCHAR(50),
    LateFee DECIMAL(6, 2),
    Transaction_ID NVARCHAR(25),
    Payment_Cycle VARCHAR(25),
    Installment_Number INT
);








