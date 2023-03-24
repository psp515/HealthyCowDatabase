CREATE TABLE [Reservations] (
 [ReservationId] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
 [CustomerId] int,
 [Seats] int NOT NULL,
 [StartDate] datetime NOT NULL,
 [EndDate] datetime NOT NULL,
 [Status] nvarchar(255) NOT NULL CHECK ([Status] IN ('Awaiting', 'Confirmed', 'Rejected')),
 CONSTRAINT R_ValidDate CHECK ( StartDate < EndDate ),
 CONSTRAINT R_ValidSeats CHECK (Seats >= 2 )
)


ALTER TABLE [Reservations] ADD FOREIGN KEY ([OrderId]) REFERENCES [Orders] ([OrderId])


ALTER TABLE [Reservations] ADD FOREIGN KEY ([CustomerId]) REFERENCES [Customers] ([CustomerId])