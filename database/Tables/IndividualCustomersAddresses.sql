CREATE TABLE [IndividualCustomersAddresses] (
   [CustomerId] INT PRIMARY KEY NOT NULL,
   [AddressId] int NOT NULL,
)


ALTER TABLE [IndividualCustomersAddresses] ADD FOREIGN KEY ([CustomerId]) REFERENCES [Customers] ([CustomerId])
  
ALTER TABLE [IndividualCustomersAddresses] ADD FOREIGN KEY ([AddressId]) REFERENCES [Addresses] ([AddressId])