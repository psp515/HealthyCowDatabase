create view OrdersAwaitingPayment as
select
   orderid,
   selected.customerid,
   round(case when (DiscountInfo.active = 1 and k1 <= price)
       then price * (1 - r1)
       else price
   end, 2) as cost
from (
   select
       orders.orderid,
       orders.CustomerId,
       isnull(sum( details.Quantity * menu.Price ), 0) as price
   from orders
    left join OrderDetails as details
       on orders.OrderId=details.OrderId
    left join Menu
       on details.MenuMealId = Menu.MenuMealId
   where orders.IsPaid=0
   group by orders.orderid, orders.CustomerId
) selected inner join DiscountInfo
on selected.CustomerId= DiscountInfo.CustomerId