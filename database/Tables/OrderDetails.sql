CREATE TABLE [OrderDetails] (
 [OrderDetailId] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
 [OrderId] int NOT NULL,
 [MenuMealId] int NOT NULL,
 [Quantity] int NOT NULL default 1,
  CONSTRAINT OD_ValidQuantity Check (Quantity > 0)
)


ALTER TABLE [OrderDetails] ADD FOREIGN KEY ([OrderId]) REFERENCES [Orders] ([OrderId])


ALTER TABLE [OrderDetails] ADD FOREIGN KEY ([MenuMealId]) REFERENCES [Menu] ([MenuMealId])