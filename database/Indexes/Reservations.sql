CREATE UNIQUE CLUSTERED INDEX Reservation
ON Reservations(ReservationId)

CREATE NONCLUSTERED INDEX ReservationsCustomers
ON Reservations(CustomerId)
