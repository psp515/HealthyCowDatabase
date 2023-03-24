ALTER   PROCEDURE [dbo].[AddIndividualReservation] @CustomerId int , @Products FullOrder READONLY, @Seats int, @StartDate datetime, @Invoice int, @isPaid int AS
BEGIN


  -- osoba musi istnieć
  IF not exists (select Customerid from IndividualCustomers where CustomerId = @CustomerId)
  BEGIN
     ;
     THROW 51000, 'Such Cusotmer does not exist!', 1
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




  -- owoce morza obsługuje trigger (swoją drogą do poprawy)




  -- zaczynamy od sprawdzenia, czy produkty w podanej ilości w ogóle są dostępne
  -- sprawdzamy czy ilość elementów po zrobieniu joina będzie taka sama jak przed joinem (w join warunek where available > quantity) i odrzucamy jeśli zamówiono przynajmniej jeden produkt niedostępny


  declare @Check int = (select count(*) from MenuView inner join Menu as MN on Mn.MenuMealId = MenuView.MenuMealId inner join @products as p on p.mealId = MN.MenuMealId)
  IF @Check <> (select count(*) from @Products)
  BEGIN
     ;
     THROW 51000, 'One or more of the ordered products is not available', 1
  END


  -- produkty są dostępne, więc sprawdzamy WZ i WK - kolejność raczej bez znaczenia
  declare @WK int = (select count(*) from Orders where CustomerId = @CustomerId)
  IF @WK < (select Wk from ReservationVariables)
  BEGIN
     ;
     THROW 51000, 'Customer has not made orders enough times', 1
  END




  -- tu wersja bez rabatów
  --declare @WZ int = (select sum(Mv.Price * P.quantity) from MenuView as Mv inner join @Products as P on p.mealId = Mv.MenuMealId)
  --IF @WZ < (select WZ from ReservationVariables)
  --BEGIN


  -- ;
     --THROW 51000, 'Order value is to low', 1
  --END


  -- ####################### wersja z rabatami ##########################


  declare @R2 float = (
     select R2 from Onetimediscounts
     inner join BigDiscounts as b on b.BigDiscountId = OneTimeDiscounts.BigDiscountId
     where getdate() between ActivationDate and ExpireDate and orderid is null and OneTimeDiscounts.CustomerId = @CustomerId
  )






  declare @R1 float = (
     select R1 from LoyaltyCards inner join Discounts as d on d.DiscountId = LoyaltyCards.DiscountId where loyaltycards.ActivationDate is not null and CustomerId = @CustomerId
  )


  declare @R float


  IF ISNULL(@R2, 0) >  ISNULL(@R1, 0)
  BEGIN
     SET @R = @R2
  END
  ELSE
  BEGIN
     SET @R = @R1
  END


  declare @WZ float
  SET @WZ = (select sum(Mv.Price * P.quantity * (1- @R)) from MenuView as Mv inner join @Products as P on p.mealId = Mv.MenuMealId)


  IF @WZ < (select WZ from ReservationVariables)
  BEGIN


     ;
     THROW 51000, @WZ, 1
  END


  -- ############################ koniec wersji z discountami ######################




  -- WZ I WK są spełnione, w dodatku w menu jest wystarczająco dużo posiłków, więc można rezerwować




  PRINT @WZ


  BEGIN TRANSACTION


  BEGIN TRY
       Insert into Reservations (CustomerId, Seats, StartDate, EndDate, Status)
       values(@CustomerId, @Seats, @StartDate, DATEADD(hour,2,@StartDate), 'Awaiting')


       declare @ReservationId int = SCOPE_IDENTITY()


       exec AddOrder @ReservationId, @CustomerId, @Products, @Invoice, @isPaid


       -- tutaj dodajemy do bazy danych nasze zamówienie i na tym kończymy (dopiero potwierdzenie stolika przez managera doda do rezerwacji stolik!


       COMMIT TRANSACTION


  END TRY
  BEGIN CATCH
      PRINT 'Reservation failed'
       ROLLBACK TRANSACTION


       DECLARE @ErrorNumber INT
       DECLARE @ErrorState INT
       DECLARE @ErrorMessage VARCHAR(MAX)


       SET @ErrorNumber =IIF( ERROR_NUMBER() < 50000, ERROR_NUMBER() + 50000, ERROR_NUMBER() );
       SET @ErrorMessage = ERROR_MESSAGE();
       SET @ErrorState = ERROR_STATE();


       PRINT CONCAT(@ErrorNumber,',', @ErrorMessage,',', @ErrorState);
       THROW @ErrorNumber, @ErrorMessage, @ErrorState


   END CATCH


END
