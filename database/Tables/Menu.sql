CREATE TABLE [Menu] (
 [MenuMealId] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
 [MealId] int NOT NULL,
 [StartDate] datetime NOT NULL,
 [EndDate] datetime,
 [Price] money NOT NULL,
 [Quantity] int,
 CONSTRAINT MN_ValidPrice CHECK ( Price >= 0 ),
 CONSTRAINT MN_ValidQuantity CHECK (Quantity >= 0)
)


ALTER TABLE [Menu] ADD FOREIGN KEY ([MealId]) REFERENCES [Meals] ([MealId])