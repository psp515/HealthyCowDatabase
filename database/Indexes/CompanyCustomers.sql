CREATE UNIQUE CLUSTERED INDEX CompanyCustomer
ON CompanyCustomers(CustomerId)

CREATE UNIQUE NONCLUSTERED INDEX CompanyNIP
ON CompanyCustomers(NIP)

CREATE UNIQUE NONCLUSTERED INDEX CompanyName
ON CompanyCustomers(CompanyName)

CREATE UNIQUE NONCLUSTERED INDEX Address
ON CompanyCustomers(AddressId)
