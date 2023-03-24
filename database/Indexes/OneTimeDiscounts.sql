CREATE CLUSTERED UNIQUE INDEX OneTimeDiscount
ON OneTimeDiscounts(OneTimeDisocuntId)

CREATE NONCLUSTERED UNIQUE INDEX Customer
ON OneTimeDiscounts(CustomerId)

CREATE NONCLUSTERED INDEX BigDiscount
ON OneTimeDiscounts(BigDiscountId)