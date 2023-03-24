CREATE UNIQUE CLUSTERED INDEX Address
ON Addresses(AddressId)

CREATE INDEX AddressToCity
ON Addresses(CityId)

CREATE NONCLUSTERED INDEX AddressStreet
ON Addresses(Street)

CREATE NONCLUSTERED INDEX AddressNumber
ON Addresses(HouseNumber)