CREATE VIEW MealsSoldMonthly AS
SELECT YEAR(O.OrderDate)             AS Year,
      DATEPART(month , O.OrderDate) AS Month,
      M.Name,
      ISNULL(SUM(OD.Quantity), 0) AS [Sold Units]
FROM Meals AS M
  JOIN Menu M2 on M.MealId = M2.MealId
  JOIN OrderDetails AS OD ON M2.MenuMealId = OD.MenuMealId
  JOIN Orders O on O.OrderID = OD.OrderID
GROUP BY YEAR(O.OrderDate), DATEPART(month, O.OrderDate), M.Name
