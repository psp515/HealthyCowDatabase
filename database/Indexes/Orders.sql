CREATE UNIQUE CLUSTERED INDEX OrderPK
ON Orders(OrderId)

CREATE NONCLUSTERED INDEX OrderToReservation
ON Orders(ReservationId)

CREATE NONCLUSTERED INDEX OrderToCustomer
ON Orders(CustomerId)
