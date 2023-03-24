CREATE OR ALTER PROCEDURE AddOrder
   @reservationId int = null,
   @customerId int = null,
   @orders FullOrder READONLY,
   @invoice bit = 0,
   @isPaid bit = 0,
   @takeawayDate DATETIME = null,
   @orderId INT = null OUTPUT
AS
BEGIN
   DECLARE @ordersCount INT
   SELECT @ordersCount = COUNT(*) FROM @orders


   IF @ordersCount = 0
       throw 51000, 'Order cannot be empty', 1;


   IF NOT EXISTS (SELECT * FROM Reservations WHERE ReservationId = @reservationId ) and @takeawayDate is null
       throw 51001, 'This reservation does not exists', 1;


   IF @customerId is not null and NOT EXISTS (SELECT * FROM Customers WHERE CustomerId = @customerId)
       THROW 51002, 'Customer does not exists', 1


   IF @customerId is null and @reservationId is not null
      SELECT @customerId = CustomerId
      FROM Reservations
      WHERE ReservationId = @reservationid


   IF @customerId is null and @reservationId is null
       THROW 51003, 'Specify reservationId or customer', 1


   IF @reservationId is not null and @takeawayDate is not null
       THROW 51004, 'You cannot reserve table and takeaway order in one moment', 1


   BEGIN TRANSACTION;


   BEGIN TRY
       PRINT 'New order transaction begin'


       --- CREATE NEW PARENT ORDER ---


       INSERT INTO Orders( CustomerId, Invoice, IsPaid, OrderDate, ReservationId)
       VALUES (@customerId, @invoice, @isPaid, GETDATE(), @reservationId)


       SET @orderId = SCOPE_IDENTITY()


       --- CREATE OPTIONAL TAKEAWAY ORDER ---


       IF @takeawayDate is not null
           INSERT INTO TakeawayOrders(OrderId, TakeawayDate)
           VALUES (@orderId, @takeawayDate)


       --- ADD EACH MEAL ELEMENTS ---


       DECLARE @mealIdToHandle INT
       DECLARE @quantityToHandle INT
       DECLARE @lastMealIdToHandle INT


       SELECT TOP 1
           @lastMealIdToHandle = mealid,
           @quantityToHandle = quantity
       from @orders
       ORDER BY mealid


       SET @mealIdToHandle = @lastMealIdToHandle


       WHILE @mealIdToHandle IS NOT NULL
       BEGIN


           IF NOT EXISTS (SELECT * FROM MenuView WHERE MenuMealId = @mealIdToHandle)
               THROW 51009, 'Meal not found', 1


           DECLARE @available INT
           SELECT @available = Avaliable
           FROM MenuView
           WHERE MenuMealId = @mealIdToHandle


           IF @available < @quantityToHandle
               THROW 51001, 'Not enough available dishes', 1


           EXEC AddOrderDetail @Orderid = @orderId, @Quantity = @quantityToHandle, @MenuMealId = @mealIdToHandle


           PRINT 'Ordered: ' + cast( @mealIdToHandle as VARCHAR) + ' | quantity: ' + cast( @quantityToHandle as VARCHAR)


           SET @lastMealIdToHandle = @mealIdToHandle
           SET @mealIdToHandle = null
           SET @quantityToHandle = null


           SELECT TOP 1
               @mealIdToHandle = mealid,
               @quantityToHandle = quantity
           FROM @orders
           WHERE MealId > @lastMealIdToHandle
           ORDER BY mealid
       END


       IF @isPaid = 1
           EXEC PayForOrder @OrderId = @orderId, @isPaid = @isPaid


       COMMIT TRANSACTION
   END TRY
   BEGIN CATCH
       PRINT 'Transaction failded'
       ROLLBACK TRANSACTION;


       DECLARE @ErrorNumber INT
       DECLARE @ErrorState INT
       DECLARE @ErrorMessage VARCHAR(MAX)


       SET @ErrorNumber =IIF( ERROR_NUMBER() < 50000, ERROR_NUMBER() + 50000, ERROR_NUMBER() );
       SET @ErrorMessage = ERROR_MESSAGE();
       SET @ErrorState = ERROR_STATE();


       PRINT CONCAT(@ErrorNumber,',', @ErrorMessage,',', @ErrorState);
       THROW @ErrorNumber, @ErrorMessage, @ErrorState
   END CATCH


   SELECT * FROM OrderDetails
   WHERE OrderId = @orderId
END
