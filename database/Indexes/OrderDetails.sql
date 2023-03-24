CREATE CLUSTERED INDEX OrderDetail
ON OrderDetails(OrderId, MenuMealId)

CREATE NONCLUSTERED INDEX OrderDetailsToMenu
ON OrderDetails(OrderId, MenuMealId)
