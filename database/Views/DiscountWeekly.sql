CREATE VIEW DiscountWeekly as
select
   datepart(year, ActivationDate) as year,
   datepart(week, ActivationDate) as week,
   count(*) as discounts from LoyaltyCards
where ActivationDate is not null
group by
   datepart(year, ActivationDate),
   datepart(week, ActivationDate)
