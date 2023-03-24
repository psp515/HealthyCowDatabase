CREATE TRIGGER [dbo].[ValidatePremiumMealOrdered]
ON
[dbo].[OrderDetails]
after insert as


BEGIN
  -- zawsze będzie tylko jeden taki orderid, bo jest onInsert




  DECLARE @OrderToRemove int = (SELECT DISTINCT OD.Orderid FROM OrderDetails AS OD
  INNER JOIN Menu AS MN ON MN.MenuMealId = OD.MenuMealId
  INNER JOIN Meals AS M ON MN.MealId = M.MealId
  INNER JOIN Orders AS O ON O.OrderId = OD.OrderId
  INNER JOIN Reservations AS R ON R.ReservationId = O.ReservationId
  WHERE M.IsPremium = 1
  AND O.ReservationId IS NOT NULL
  AND (DATEPART(WEEKDAY, R.StartDate) NOT BETWEEN 4 AND 6
  OR O.OrderDate >= (SELECT DATEADD(week, DATEDIFF(week, 0, DATEADD(DAY, -1,R.StartDate)), 0)) ))


  IF @OrderToRemove IS NULL
  BEGIN
     SET @OrderToRemove = (SELECT DISTINCT OD.Orderid FROM OrderDetails AS OD
  INNER JOIN Menu AS MN ON MN.MenuMealId = OD.MenuMealId
  INNER JOIN Meals AS M ON MN.MealId = M.MealId
  INNER JOIN Orders AS O ON O.OrderId = OD.OrderId
  INNER JOIN TakeawayOrders AS T ON T.OrderId = OD.OrderId


  WHERE M.IsPremium = 1
  AND (DATEPART(WEEKDAY, T.TakeawayDate) NOT BETWEEN 4 AND 6
  OR O.OrderDate >= (SELECT DATEADD(week, DATEDIFF(week, 0, DATEADD(DAY, -1,T.TakeawayDate)), 0)) ))
 




  DELETE FROM TakeawayOrders WHERE OrderId = @OrderToRemove


  DELETE FROM OrderDetails WHERE OrderId = @OrderToRemove


  DELETE
  FROM ORDERS
  WHERE OrderId = @OrderToRemove
 
 
  PRINT 'Cannot order seafood'
  END
  ELSE
  BEGIN


     DELETE
     FROM OrderDetails WHERE OrderId = @OrderToRemove


     DELETE
     FROM Orders WHERE OrderId = @OrderToRemove


     PRINT 'Cannot order seafood'
    
  END
END
go




ALTER TABLE [dbo].[OrderDetails] ENABLE TRIGGER [ValidatePremiumMealOrdered]
GO
