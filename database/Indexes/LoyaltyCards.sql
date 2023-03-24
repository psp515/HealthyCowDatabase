CREATE UNIQUE CLUSTERED INDEX LoyaltyCard
ON LoyaltyCards(LoyaltyCardId)

CREATE UNIQUE NONCLUSTERED INDEX Customer
ON LoyaltyCards(CustomerId)

CREATE NONCLUSTERED INDEX Discount
ON LoyaltyCards(DiscountId)
