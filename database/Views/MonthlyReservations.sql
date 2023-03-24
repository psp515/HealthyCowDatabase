create view [dbo].[MonthlyReservations] as
select
   datepart(year, StartDate) as year,
   datepart(month, StartDate) as month,
   count(*) as reservations from Reservations
group by
   datepart(year, StartDate),
   datepart(month, StartDate)
with rollup
GO
