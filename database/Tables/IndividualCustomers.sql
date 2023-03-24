CREATE TABLE [IndividualCustomers] (
 [CustomerId] int PRIMARY KEY NOT NULL,
 [FirstName] varchar(64) NOT NULL,
 [LastName] varchar(128) NOT NULL
)


ALTER TABLE [IndividualCustomers] ADD FOREIGN KEY ([CustomerId]) REFERENCES [Customers] ([CustomerId])