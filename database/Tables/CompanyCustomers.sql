CREATE TABLE [CompanyCustomers] (
 [CustomerId] int PRIMARY KEY NOT NULL,
 [CompanyName] varchar(255) NOT NULL,
 [NIP] varchar(32) NOT NULL,
 [AddressId] int NOT NULL,
 CONSTRAINT CC_ValidNIP CHECK (NIP LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)


ALTER TABLE [CompanyCustomers] ADD FOREIGN KEY ([CustomerId]) REFERENCES [Customers] ([CustomerId])


ALTER TABLE [CompanyCustomers] ADD FOREIGN KEY ([AddressId]) REFERENCES [Addresses] ([AddressId])