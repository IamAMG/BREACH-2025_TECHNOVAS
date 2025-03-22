CREATE TABLE KYC (
    KYCID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT FOREIGN KEY REFERENCES Users(ID) ON DELETE CASCADE,  -- Change 'ID' to your actual primary key name
    DocumentType NVARCHAR(50) NOT NULL,  
    DocumentImage NVARCHAR(MAX),  
    FacialScan NVARCHAR(MAX),  
    Verified BIT DEFAULT 0
);
