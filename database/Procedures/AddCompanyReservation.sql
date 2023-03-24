CREATE PROCEDURE [dbo].[AddCompanyReservation] (@CustomerId int, @Seats int, @StartDate datetime, @Guests GuestList READONLY)
AS
BEGIN
  -- Klient firmowy musi istnieć!
  IF not exists (select Customerid from CompanyCustomers where CustomerId = @CustomerId)
  BEGIN
     ;
     THROW 51000, 'Such Company Cusotmer does not exist!', 1
  END


  -- rezerwacja dla co najmniej 2 osób
  IF @Seats < 2
  BEGIN
     ;
     THROW 51000, 'Too few seats!', 1
  END




  -- data rezerwacji musi być późniejsza niż data teraźniejsza (ustalamy, że różnica abs(getdate() - startDate) > 15 minut


  IF DATEDIFF(minute, getdate(), @startDate) < 15
  BEGIN
     ;
     THROW 51000, 'You cannot make reservation less than 15 minutes before it!', 1
  END






  Insert into Reservations (CustomerId, Seats, StartDate, EndDate, Status)
  values(@CustomerId, @Seats, @StartDate, DATEADD(hour,2,@StartDate), 'Awaiting')
  DECLARE @ReservationId int = SCOPE_IDENTITY()


  IF EXISTS (select CustomerId from @Guests)
  BEGIN
     INSERT INTO CompanyCustomerList (ReservationId, CustomerId)
     SELECT @ReservationId, CustomerId FROM @Guests
  END


 


END


GO
