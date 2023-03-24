CREATE VIEW AwaitingTakeawayOrders AS
SELECT T.TakewayId, T.OrderId, T.TakeawayDate, OI.OrderDate, OI.Value, OI.CustomerId, OI.IsPaid
FROM TakeawayOrders as T
   JOIN OrdersInfo OI on T.OrderId = OI.OrderId
WHERE TakeawayDate > GETDATE()
