CREATE UNIQUE CLUSTERED INDEX TakeawayOrder
ON TakeawayOrders(TakeawayOrderId)

CREATE UNIQUE NONCLUSTERED INDEX TakeawayOrderToOrder
ON TakeawayOrders(OrderId)
