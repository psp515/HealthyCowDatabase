CREATE TABLE [Employees] (
 [EmployeeId] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
 [AddressId] int NOT NULL,
 [FirstName] varchar(32) NOT NULL,
 [LastName] varchar(64) NOT NULL,
 [Avatar] varchar(255),
 [Role] nvarchar(255) NOT NULL CHECK ([Role] IN ('Worker', 'Manager', 'Owner')),
 [HiredDate] datetime NOT NULL,
 [FiredDate] datetime
)


ALTER TABLE [Employees] ADD FOREIGN KEY ([AddressId]) REFERENCES [Addresses] ([AddressId])