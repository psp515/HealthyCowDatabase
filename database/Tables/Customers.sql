CREATE TABLE [Customers] (
 [CustomerId] int PRIMARY KEY NOT NULL IDENTITY(100, 1),
 [Email] varchar(255) NOT NULL UNIQUE,
 [PhoneNumber] varchar(15) NOT NULL UNIQUE,
 [CreationDate] datetime NOT NULL,
 CONSTRAINT CC_ValidEmail CHECK (Email LIKE '%@%'),
 CONSTRAINT CC_ValidPhoneNumber CHECK (SUBSTRING (PhoneNumber, 1, 1) LIKE '[0-9+]' AND ISNUMERIC(PhoneNumber) = 1)
)
