CREATE VIEW PendingReservations as
select * from Reservations
where status='Awaiting'