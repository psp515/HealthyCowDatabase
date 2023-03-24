CREATE TABLE [ReservationDetails] (
 [ReservationId] int NOT NULL,
 [TableId] int NOT NULL,
 CONSTRAINT PK_ReservationDetails PRIMARY KEY (ReservationId, TableId)
)


ALTER TABLE [ReservationDetails] ADD FOREIGN KEY ([ReservationId]) REFERENCES [Reservations] ([ReservationId])


ALTER TABLE [ReservationDetails] ADD FOREIGN KEY ([TableId]) REFERENCES [Tables] ([TableId])
