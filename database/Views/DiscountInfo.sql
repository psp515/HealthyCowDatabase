create view DiscountInfo as
select CustomerId, active, k1, R1 from (
   select
       Customers.CustomerId,
       case when (
           isnull(
               LC.ActivationDate,
               dateadd(year, 1, getdate())
               ) < GETDATE()
           )
               then cast(1 as bit)
               else cast(0 as bit)
           end
       as active,
       D.Z1,
       D.R1,
       D.K1
   from Customers
   left join IndividualCustomers IC on Customers.CustomerId = IC.CustomerId
   left join LoyaltyCards LC on IC.CustomerId = LC.CustomerId
   left join Discounts D on LC.DiscountId = D.DiscountId
) discountInfo
