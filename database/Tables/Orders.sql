CREATE TABLE [Orders] (
 [OrderId] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
 [CustomerId] int NOT NULL,
 [Invoice] bit default 0 NOT NULL,
 [IsPaid] bit default 0 NOT NULL,
 [OrderDate] datetime NOT NULL DEFAULT GETDATE(),
 [ReservationId] int,
)


ALTER TABLE [Orders] ADD FOREIGN KEY ([CustomerId]) REFERENCES [Customers] ([CustomerId])


ALTER TABLE [Orders] ADD FOREIGN KEY ([ReservationsId]) REFERENCES [Reservations] ([ReservationsId])