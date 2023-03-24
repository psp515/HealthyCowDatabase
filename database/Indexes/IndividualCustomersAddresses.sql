CREATE UNIQUE CLUSTERED INDEX Customer
ON IndividualCustomersAddresses(CustomerId)

CREATE NONCLUSTERED INDEX Address
ON IndividualCustomersAddresses(AddressId)
