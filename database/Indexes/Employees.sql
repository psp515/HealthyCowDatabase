CREATE UNIQUE CLUSTERED INDEX Employee
ON Discounts(DiscountId)

CREATE NONCLUSTERED INDEX EmployeesNames
ON Employees(LastName,FirstName)

CREATE NONCLUSTERED INDEX EmployeesNamesReversed
ON Employees(FirstName,LastName)
