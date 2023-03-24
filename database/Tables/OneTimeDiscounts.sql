CREATE TABLE [OneTimeDiscounts] (
 [OneTimeDisocuntId] int PRIMARY KEY NOT NULL IDENTITY(1,1),
 [CustomerId] int NOT NULL,
 [BigDiscountId] int NOT NULL,
 [OrderId] int,
 [ActivationDate] datetime,
 [ExpireDate] datetime,
)


ALTER TABLE [OneTimeDiscounts] ADD FOREIGN KEY ([BigDiscountId]) REFERENCES [BigDiscounts] ([BigDiscountId])


ALTER TABLE [OneTimeDiscounts] ADD FOREIGN KEY ([CustomerId]) REFERENCES [IndividualCustomers] ([CustomerId])


ALTER TABLE [OneTimeDiscounts] ADD FOREIGN KEY ([OrderId]) REFERENCES [Orders] ([OrderId])