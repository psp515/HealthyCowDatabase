CREATE TABLE [LoyaltyCards] (
 [LoyaltyCardId] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
 [CustomerId] int NOT NULL,
 [DiscountId] int NOT NULL,
 [ActivationDate] datetime,
)


ALTER TABLE [LoyaltyCards] ADD FOREIGN KEY ([CustomerId]) REFERENCES [IndividualCustomers] ([CustomerId])


ALTER TABLE [LoyaltyCards] ADD FOREIGN KEY ([DiscountId]) REFERENCES [Discounts] ([DiscountId])