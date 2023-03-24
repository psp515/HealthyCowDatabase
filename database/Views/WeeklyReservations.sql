CREATE view [dbo].[WeeklyReservations] as
select
   datepart(year, StartDate) as year,
   datepart(week, StartDate) as week,
   count(*) as reservations
from Reservations
group by
   datepart(year, StartDate),
   datepart(week, StartDate)
with rollup
GO
