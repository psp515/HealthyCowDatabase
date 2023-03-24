CREATE VIEW DiscountMonthly as
select
   datepart(year, ActivationDate) as year,
   datepart(month, ActivationDate) as week,
   count(*) as discounts from LoyaltyCards
where ActivationDate is not null
group by
   datepart(year, ActivationDate),
   datepart(month , ActivationDate)
