CREATE TABLE [TakeawayOrders] (
 [TakewayId] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
 [OrderId] int NOT NULL,
 [TakeawayDate] datetime NOT NULL,
 CONSTRAINT TO_ValidDate CHECK (TakeawayDate > GETDATE())
)


ALTER TABLE [TakeawayOrders] ADD FOREIGN KEY ([OrderId]) REFERENCES [Orders] ([OrderId])