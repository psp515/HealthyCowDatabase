CREATE TABLE [Discounts] (
 [DiscountId] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
 [R1] float NOT NULL,
 [Z1] int NOT NULL,
 [K1] money NOT NULL,
 [ActivationDate] datetime NOT NULL,
 [ExpireDate] datetime
)
