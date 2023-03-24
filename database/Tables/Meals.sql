CREATE TABLE [Meals] (
 [MealId] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
 [CategoryId] int NOT NULL,
 [Name] varchar(255) NOT NULL,
 [Count] int NOT NULL DEFAULT 0,
 [IsPremium] bit NOT NULL,
)


ALTER TABLE [Meals] ADD FOREIGN KEY ([CategoryId]) REFERENCES [Categories] ([CategoryId])