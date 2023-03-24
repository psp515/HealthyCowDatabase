CREATE UNIQUE CLUSTERED INDEX Customer
ON IndividualCustomers(CustomerId)

CREATE NONCLUSTERED INDEX FirstName
ON IndividualCustomers(FirstName)

CREATE NONCLUSTERED INDEX Name
ON IndividualCustomers(LastName)
