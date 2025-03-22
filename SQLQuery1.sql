CREATE TABLE Users (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Email NVARCHAR(255) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    FullName NVARCHAR(255),
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Transactions (
    TransactionId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT FOREIGN KEY REFERENCES Users(Id) ON DELETE CASCADE,
    Amount DECIMAL(18,2) NOT NULL,
    TransactionDate DATETIME DEFAULT GETDATE(),
    Location NVARCHAR(255),
    DeviceType NVARCHAR(255),
    IsFraud BIT DEFAULT 0
);

CREATE TABLE FraudAnalysis (
    AnalysisId INT IDENTITY(1,1) PRIMARY KEY,
    TransactionId INT FOREIGN KEY REFERENCES Transactions(TransactionId) ON DELETE CASCADE,
    FraudScore FLOAT,
    PredictedLabel BIT,
    AnalysisDate DATETIME DEFAULT GETDATE()
);
