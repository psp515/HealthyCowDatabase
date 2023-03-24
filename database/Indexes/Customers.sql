CREATE UNIQUE CLUSTERED INDEX Customer
ON Customers(CustomerId)

CREATE UNIQUE NONCLUSTERED INDEX CustomersEmails
ON Customers(Email)

CREATE UNIQUE NONCLUSTERED INDEX CustomersPhoneNumber
ON Customers(PhoneNumber)
